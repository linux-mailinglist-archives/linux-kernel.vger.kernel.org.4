Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECE6A74ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCAUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCAUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:15:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60552498B1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p16so9365715wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=664mQufj36GAinUsmDVRemqvXpqdvf+x4ah+LNp4umE=;
        b=OnyIPByHTPA/VbLfXLKicS18pAva9yatk1gSb93dvKbk30+4FKD4PiBW8V5G7P1VeI
         R+aGFczeEJakPBik63P/hJzQTMhjrfRfKXkn6IBQAytAGaE9zkexehWVA4yF8Gk8Bqk8
         uXQgFo0hzCKNRoDrePlEeFMbbUHS5Q5+MKrREJqbcvzJlWv6HrruCUau3llsqn1bzer0
         SuHuDplcwINLb3QmdleFHbKVsA+V1Ao3hYefevttxEeR8WsszZbzMskxG5rIIwSo3IW1
         j6ueXZJ+JYH9zwt5arjeojhZ2vGdYvaNtYI1ptE5zBu1Hc9TB6OOcOgrxNwxV0+t4zxR
         VEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=664mQufj36GAinUsmDVRemqvXpqdvf+x4ah+LNp4umE=;
        b=ofFTerHaoHx6VusyjUhw+oE3YzFj/g5Cz0DqE7cwX9vVzR1vRYs6zfpdMwm9aMK2t6
         QrTPjbZ3ix2IQad3BpGCXDtNlpdZ7WNF4Pn0FGwjeQBY1C0D8vPrtJHVMiiPy5LKPfjE
         +06ZmSC0AXfnhgTJGcesB9f5XMWWGvbmwye+t8DiEKFAnvZW0bu5ptA7AMzVylUNJM7j
         Xsk9BHexwB95445E6tNjStpa06LaHOJRUFOBana5bbnSxbwG2NdK6MQpbQsD1FLpYT1C
         KFa2hXDNujY1cseZHdTIboao+75Ycz96xCPmG61yiLOMC+arp//GZU1Tfq/PfUWlHyb1
         iWPA==
X-Gm-Message-State: AO0yUKXFFSeqYov7usOQpBh/IHXlfw2hOxNtAyW8fAnGswZ2A9S2Uiqb
        +S+0Qto5b5U+/AgMyzJzud9MR6IIaSXETbogiK8=
X-Google-Smtp-Source: AK7set/bQpcBqUspIQrTUO5Lai+QN66xJeYQ1TdGWga6/epJ+Kk7g/iwrG6/S/zqyfzNWZ9wxbj2jA==
X-Received: by 2002:a05:600c:70a:b0:3eb:2b79:a40 with SMTP id i10-20020a05600c070a00b003eb2b790a40mr5999178wmn.20.1677701717666;
        Wed, 01 Mar 2023 12:15:17 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v5 03/18] thermal/core: Use the thermal zone 'devdata' accessor in hwmon located drivers
Date:   Wed,  1 Mar 2023 21:14:31 +0100
Message-Id: <20230301201446.3713334-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

