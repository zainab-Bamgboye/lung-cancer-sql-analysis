-- ============================================================
-- LUNG CANCER PATIENTS ANALYSIS
-- SQL Portfolio Project
-- Tool: Microsoft SQL Server (SSMS)
-- Dataset: Lung Cancer Patients
-- ============================================================


-- ============================================================
-- 1. DATA OVERVIEW
-- ============================================================

-- View the first 10 records
SELECT TOP 10 *
FROM dbo.[Lung Cancer patients];


-- Count total number of patients
SELECT COUNT(*) AS total_patients
FROM dbo.[Lung Cancer patients];


-- Check the number of columns in the dataset
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'Lung Cancer patients';


-- ============================================================
-- 2. DATA QUALITY CHECKS
-- ============================================================

-- Check for missing values in the age column
SELECT COUNT(*) AS missing_age
FROM dbo.[Lung Cancer patients]
WHERE age IS NULL;


-- Check for invalid ages
SELECT COUNT(*) AS invalid_age
FROM dbo.[Lung Cancer patients]
WHERE age IS NULL
   OR age < 0
   OR age > 120;


-- Check for invalid survival values
SELECT COUNT(*) AS invalid_survived
FROM dbo.[Lung Cancer patients]
WHERE survived NOT IN (0, 1)
   OR survived IS NULL;


-- Check for duplicate age values
SELECT age, COUNT(*) AS duplicate_age
FROM dbo.[Lung Cancer patients]
GROUP BY age
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. DESCRIPTIVE ANALYSIS
-- ============================================================

-- Calculate the average age of patients
SELECT AVG(age) AS average_age
FROM dbo.[Lung Cancer patients];


-- Count patients by gender
SELECT
    gender,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY gender
ORDER BY patient_count DESC;


-- Count patients by cancer stage
SELECT
    cancer_stage,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY cancer_stage
ORDER BY cancer_stage;


-- Count patients by smoking status
SELECT
    smoking_status,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY smoking_status
ORDER BY patient_count DESC;


-- ============================================================
-- 4. AGE ANALYSIS
-- ============================================================

-- Patients older than 60
SELECT COUNT(*) AS patients_over_60
FROM dbo.[Lung Cancer patients]
WHERE age > 60;


-- Patients between 40 and 60 years old
SELECT COUNT(*) AS patients_age_40_to_60
FROM dbo.[Lung Cancer patients]
WHERE age BETWEEN 40 AND 60;


-- Group patients into age categories
SELECT
    CASE
        WHEN age < 40 THEN 'Young (<40)'
        WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40-59)'
        WHEN age >= 60 THEN 'Older (60+)'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY
    CASE
        WHEN age < 40 THEN 'Young (<40)'
        WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40-59)'
        WHEN age >= 60 THEN 'Older (60+)'
        ELSE 'Unknown'
    END
ORDER BY patient_count DESC;


-- ============================================================
-- 5. SURVIVAL ANALYSIS
-- ============================================================

-- Count patients who survived and did not survive
SELECT
    survived,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY survived
ORDER BY survived;


-- Count patients who survived
SELECT COUNT(*) AS survived_patients
FROM dbo.[Lung Cancer patients]
WHERE survived = 1;


-- Count female patients who survived
SELECT COUNT(*) AS survived_female
FROM dbo.[Lung Cancer patients]
WHERE gender = 'female'
  AND survived = 1;


-- Count male patients who survived
SELECT COUNT(*) AS survived_male
FROM dbo.[Lung Cancer patients]
WHERE gender = 'male'
  AND survived = 1;


-- Survival by gender
SELECT
    gender,
    survived,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY gender, survived
ORDER BY gender, survived;


-- ============================================================
-- 6. CANCER STAGE ANALYSIS
-- ============================================================

-- Patients with Stage III or Stage IV cancer
SELECT COUNT(*) AS advanced_stage_patients
FROM dbo.[Lung Cancer patients]
WHERE cancer_stage IN ('Stage III', 'Stage IV');


-- Survival by cancer stage
SELECT
    cancer_stage,
    survived,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY cancer_stage, survived
ORDER BY cancer_stage, survived;


-- ============================================================
-- 7. SMOKING ANALYSIS
-- ============================================================

-- Count current smokers
SELECT COUNT(*) AS current_smokers
FROM dbo.[Lung Cancer patients]
WHERE smoking_status = 'Current Smoker';


-- Survival among current smokers
SELECT
    survived,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
WHERE smoking_status = 'Current Smoker'
GROUP BY survived
ORDER BY survived;


-- Survival by smoking status
SELECT
    smoking_status,
    survived,
    COUNT(*) AS patient_count
FROM dbo.[Lung Cancer patients]
GROUP BY smoking_status, survived
ORDER BY smoking_status, survived;


-- ============================================================
-- 8. COMBINED ANALYSIS
-- ============================================================

-- Female patients with Stage III or IV cancer
SELECT COUNT(*) AS female_advanced_stage
FROM dbo.[Lung Cancer patients]
WHERE gender = 'female'
  AND cancer_stage IN ('Stage III', 'Stage IV');


-- Patients older than 60 OR current smokers
SELECT COUNT(*) AS older_or_current_smoker
FROM dbo.[Lung Cancer patients]
WHERE age > 60
   OR smoking_status = 'Current Smoker';


-- Current smokers who survived
SELECT COUNT(*) AS current_smokers_survived
FROM dbo.[Lung Cancer patients]
WHERE smoking_status = 'Current Smoker'
  AND survived = 1;


-- ============================================================
-- 9. SURVIVAL RATE
-- ============================================================

-- Overall survival rate
SELECT
    COUNT(CASE WHEN survived = 1 THEN 1 END) * 100.0
    / COUNT(*) AS survival_rate_percentage
FROM dbo.[Lung Cancer patients];


-- Survival rate by gender
SELECT
    gender,
    COUNT(CASE WHEN survived = 1 THEN 1 END) * 100.0
    / COUNT(*) AS survival_rate_percentage
FROM dbo.[Lung Cancer patients]
GROUP BY gender;


-- Survival rate by cancer stage
SELECT
    cancer_stage,
    COUNT(CASE WHEN survived = 1 THEN 1 END) * 100.0
    / COUNT(*) AS survival_rate_percentage
FROM dbo.[Lung Cancer patients]
GROUP BY cancer_stage
ORDER BY cancer_stage;


-- Survival rate by smoking status
SELECT
    smoking_status,
    COUNT(CASE WHEN survived = 1 THEN 1 END) * 100.0
    / COUNT(*) AS survival_rate_percentage
FROM dbo.[Lung Cancer patients]
GROUP BY smoking_status
ORDER BY survival_rate_percentage DESC;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
