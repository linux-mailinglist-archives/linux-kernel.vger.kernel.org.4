Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119A76A57C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjB1LXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjB1LX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:23:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9871B339
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g3so453551wri.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=664mQufj36GAinUsmDVRemqvXpqdvf+x4ah+LNp4umE=;
        b=UlM5mZ3kJrAok/fetBNqilnPJs5MtyFy0gYgd2S0uwaV+3wPD/XR+hypoBCsNYNSHt
         +os9lWNK2cwjkn5Dm+80SKltylmVtq4EfOBVPldmrPkZU8KX3mLK2WuGlEXphbWEL/in
         LCjKNbiMx+IANOgV4Xc0viB+mhJiTrV5+8CcXYC3wwevvjJUqRWCqmjlLJ3xJ3VjtFHD
         aBsRXJRrhtPB1ZVbrs/IW3mtMP0ewx0fRzAJnJ3Ul5ID7y5KTZVFkqTpj8WYnhZqGANk
         Lu0bRURjuvSHjusYiGcN0782OEOBqAielBWwKfwtCtjSDRQpY/1wCVgqHurK9kk4MPeO
         pf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=664mQufj36GAinUsmDVRemqvXpqdvf+x4ah+LNp4umE=;
        b=NaiTDzKCFdP+WuKdVg+ER38ccFo9oNlJN3BwDT749Plk4nF+VOVi9XJhcxWXAr5r6p
         vygPxHt5CXSnEWJGhT2VGEDDttAG2x0FuJqKsu+5j6mn97kbw61TdYdJT8/Crj9JwYaR
         ePnooJV5g1X4JqBT3tiT6vXKDc9CPfPWE5k/Jujo2JkWQ3y8ZVt4ZZ40wkohTp/z14s5
         2ktbLdm4t1lSBtURTi/hWBQn0eOlb59EdjHaHROwy3YB7TG13H7EWC7S6QY7E5iA4yDg
         M1VjLkX13llk7h/fl7hYN72lDFw30ubvnWa1l8hvE8+rR+SjJPTcXkIZ2DDuDGQpEVe4
         Fi6A==
X-Gm-Message-State: AO0yUKWjcD+pFNy5Q2UyQG84vMiNFLVXW5B8LfvK+sDuYcmDBAMyGdLh
        7RmAyDVZr4HomVt3G/nrKi42Gw==
X-Google-Smtp-Source: AK7set87DxlpmsUmw6OKpp3IOw9lYuszsDPcpc3vmgPu3y4eIV2YfFgdP4ZNmSUFw4JB+7pvFSMBUg==
X-Received: by 2002:a5d:4a0d:0:b0:2c3:f026:9085 with SMTP id m13-20020a5d4a0d000000b002c3f0269085mr1794435wrq.13.1677583389751;
        Tue, 28 Feb 2023 03:23:09 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:09 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v4 03/19] thermal/core: Use the thermal zone 'devdata' accessor in hwmon located drivers
Date:   Tue, 28 Feb 2023 12:22:22 +0100
Message-Id: <20230228112238.2312273-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone device structure is exposed to the different drivers
and obviously they access the internals while that should be
restricted to the core thermal code.

In order to self-encapsulate the thermal core code, we need to prevent
the drivers accessing directly the thermal zone structure and provide
accessor functions to deal with.

Use the devdata accessor introduced in the previous patch.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net> #hwmon
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/hwmon.c            | 4 ++--
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 drivers/hwmon/scmi-hwmon.c       | 2 +-
 drivers/hwmon/scpi-hwmon.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 33edb5c02f7d..3adf5c3c75ed 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -154,7 +154,7 @@ static DEFINE_IDA(hwmon_ida);
 #ifdef CONFIG_THERMAL_OF
 static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct hwmon_thermal_data *tdata = tz->devdata;
+	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
 	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
 	int ret;
 	long t;
@@ -171,7 +171,7 @@ static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static int hwmon_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct hwmon_thermal_data *tdata = tz->devdata;
+	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
 	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
 	const struct hwmon_chip_info *chip = hwdev->chip;
 	const struct hwmon_channel_info **info = chip->info;
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..e39a327ac2a1 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1272,7 +1272,7 @@ struct pmbus_thermal_data {
 
 static int pmbus_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct pmbus_thermal_data *tdata = tz->devdata;
+	struct pmbus_thermal_data *tdata = thermal_zone_device_priv(tz);
 	struct pmbus_sensor *sensor = tdata->sensor;
 	struct pmbus_data *pmbus_data = tdata->pmbus_data;
 	struct i2c_client *client = to_i2c_client(pmbus_data->dev);
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index e192f0c67146..046ac157749d 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -141,7 +141,7 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
 {
 	int ret;
 	long value;
-	struct scmi_thermal_sensor *th_sensor = tz->devdata;
+	struct scmi_thermal_sensor *th_sensor = thermal_zone_device_priv(tz);
 
 	ret = scmi_hwmon_read_scaled_value(th_sensor->ph, th_sensor->info,
 					   &value);
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 4d75385f7d5e..121e5e9f487f 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -64,7 +64,7 @@ static void scpi_scale_reading(u64 *value, struct sensor_data *sensor)
 
 static int scpi_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct scpi_thermal_zone *zone = tz->devdata;
+	struct scpi_thermal_zone *zone = thermal_zone_device_priv(tz);
 	struct scpi_sensors *scpi_sensors = zone->scpi_sensors;
 	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
 	struct sensor_data *sensor = &scpi_sensors->data[zone->sensor_id];
-- 
2.34.1

