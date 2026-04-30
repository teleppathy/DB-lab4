-- ==========================================
-- JOIN queries
-- ==========================================

-- 1. Select customers with their subscriptions
SELECT
    c.first_name,
    c.last_name,
    s.type,
    s.price
FROM customer AS c
LEFT JOIN subscription AS s
    ON c.customer_id = s.customer_id;

-- 2. Select films with their studios
SELECT
    f.title,
    s.name AS studio_name
FROM film AS f
LEFT JOIN studio AS s
    ON f.studio_id = s.studio_id;

-- 3. Select films with their actors
SELECT
    f.title,
    a.first_name,
    a.last_name
FROM film AS f
INNER JOIN film_actor AS fa 
    ON f.film_id = fa.film_id
INNER JOIN actor AS a 
    ON fa.actor_id = a.actor_id;

-- 4. Select films with their genres
SELECT
    f.title,
    g.name AS genre
FROM film AS f
INNER JOIN film_genre AS fg 
    ON f.film_id = fg.film_id
INNER JOIN genre AS g 
    ON fg.genre_id = g.genre_id;

-- 5. Select payment history for each customer
SELECT
    c.first_name,
    c.last_name,
    p.amount,
    p.status
FROM customer AS c
LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id;


-- ==========================================
-- Base aggregation
-- ==========================================

-- 1. Select total sum of payments for each customer
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customer AS c
LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 2. Count how many films each studio has produced
SELECT
    s.name,
    COUNT(f.film_id) AS film_count
FROM studio AS s
LEFT JOIN film AS f
    ON s.studio_id = f.studio_id
GROUP BY s.name;

-- 3. Get average subscription price
SELECT AVG(price) AS avg_price
FROM subscription;

-- 4. Get the cheapest subscription price
SELECT MIN(price) AS cheapest_price
FROM subscription;

-- 5. Get number of films per actor
SELECT
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS film_count
FROM actor AS a
LEFT JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;


-- ==========================================
-- Grouping
-- ==========================================

-- 1. Get the number of films per release year
SELECT
    release_year,
    COUNT(film_id) AS films_count
FROM film
GROUP BY release_year
ORDER BY release_year DESC;

-- 2. Calculate minimum, maximum, and average subscription price by type
SELECT
    type,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM subscription
GROUP BY type
ORDER BY type;

-- 3. Group films by age restriction
SELECT
    age_restriction,
    COUNT(film_id) AS films_count
FROM film
GROUP BY age_restriction;

-- 4. Count payments by status
SELECT
    status,
    COUNT(payment_id) AS payments_count
FROM payment
GROUP BY status;

-- 5. Count number of actors in each film
SELECT
    f.title,
    COUNT(fa.actor_id) AS actor_count
FROM film AS f
LEFT JOIN film_actor AS fa
    ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY actor_count DESC;


-- ==========================================
-- Groups filtering
-- ==========================================

-- 1. Filter customers who have at least one failed payment
SELECT
    c.first_name,
    c.last_name,
    COUNT(p.payment_id) AS failed_payment_count
FROM customer AS c
JOIN payment AS p
    ON c.customer_id = p.customer_id
WHERE p.status = FALSE
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(p.payment_id) >= 1;

-- 2. Filter actors who played in more than 2 films
SELECT
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS films_count
FROM actor AS a
JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 2;

-- 3. Filter subscription types with less than 2 customers
SELECT
    s.type,
    COUNT(s.customer_id) AS subscribers_count
FROM subscription AS s
GROUP BY s.type
HAVING COUNT(s.customer_id) < 2;

-- 4. Filter customers who spent more than 100
SELECT
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customer AS c
JOIN payment AS p
    ON c.customer_id = p.customer_id
WHERE p.status = TRUE
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) > 100;

-- 5. Filter films that have only one genre
SELECT
    f.title,
    COUNT(fg.genre_id) AS genre_count
FROM film AS f
JOIN film_genre AS fg
    ON f.film_id = fg.film_id
GROUP BY f.title
HAVING COUNT(fg.genre_id) = 1;

-- ==========================================
-- Multi-table aggregation 
-- (Місце для твоїх майбутніх запитів)
-- ==========================================
