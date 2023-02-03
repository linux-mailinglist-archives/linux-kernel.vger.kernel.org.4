Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55668A060
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjBCReg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjBCReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:34:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FAA4287
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:33:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6528314wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC3Bc1ZBnDqOCsf2GYYuc3UMis7l5JLiGW3gDWAr4Jo=;
        b=BwPh2K1s3VvrNIFZ2qnZis7vTO6tK++DzNrfzs3Pted+Yr4HfKoXjAUkPh1CwzYp45
         +vq9FSKPZLhTukJI7nBnbewsG+08a8+StMb3qLJjmbTxvb7/ZTxUvf6qERkVLErxzdsS
         Urgi2wAb2B12FObZ38pPBUlwNTY4zpsDBm/BG8vQC5386AoIBElIBgeBwJ1JxurVpjQ8
         ZmiYQSl4+do5jR71MneUuBGDmoRko0jYthu14ioOSrZRMq4uWRT8RJQyfqaGkISloFfi
         htNNvoCM7kkd44KbL6nVa9xVEo2gOATtfRmQmrl6jthil+exkX+W2ZGWkW7C8RuLfk2r
         w97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC3Bc1ZBnDqOCsf2GYYuc3UMis7l5JLiGW3gDWAr4Jo=;
        b=z88pt+8Ptq6q7qSPq57oBNmfObi1JOJcS7g49jR82wndHIuI6Scln9BBG5fR05CmFZ
         TE+ITJCi8oy0295koU9bBm6BLdBIgG8c3I7AvGiT+u7lCsqBgR5OgINl20vONrSrb+OQ
         9uA+OAXCA5K1TDKrGuxCu2G7qT8O5n9ooW51yB/M+PtvOv8La7Ytkg7f8tCdkI0LQoV3
         j3FzXgcrrn0PQMdkDHEquY8pf97JDWxrOqmbX7L8CfDCS6M34NQzDh51OIW3gAK9zCmf
         T5IQXxkGbICMGjuRe2pfiaHdyMTqADM1AbMDnVdRBHwStrUroOE25hZPViZXBsRAJZR6
         VPew==
X-Gm-Message-State: AO0yUKXN+707+K9xwrafJCRYtkzkQ5lJxzwNblEoLnvluKhEvJ7Bdn3O
        T7dDPCq6VvHUAfCjA/bIlml10A==
X-Google-Smtp-Source: AK7set/DBO+jLxmyS5XuEVXNwD4bAIY8rxWK0cGEjv8PAgpf9eDbnVw8xqM+yV9zrBcgKrvRXgYINg==
X-Received: by 2002:a05:600c:c13:b0:3dc:496f:ad56 with SMTP id fm19-20020a05600c0c1300b003dc496fad56mr10290025wmb.14.1675445637441;
        Fri, 03 Feb 2023 09:33:57 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 09/11] thermal/acpi: Convert the units to milli Celsuis
Date:   Fri,  3 Feb 2023 18:33:29 +0100
Message-Id: <20230203173331.3322089-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@kernel.org>

The trip points are storing the temperature using the Deci Kelvin
units but the thermal framework expects milli Celsius.

In order to migrate to the generic trip points where the temperature
unit is millicelsius. Let's change the unit, so the resulting code
will be compatible with thermal framework used unit.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 56 ++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 316a16ac1a09..9122d1c44777 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -177,9 +177,9 @@ static int acpi_thermal_get_temperature(struct acpi_thermal *tz)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->temperature = tmp;
+	tz->temperature = deci_kelvin_to_millicelsius(tmp);
 
-	acpi_handle_debug(tz->device->handle, "Temperature is %lu dK\n",
+	acpi_handle_debug(tz->device->handle, "Temperature is %lu m°C\n",
 			  tz->temperature);
 
 	return 0;
@@ -250,7 +250,7 @@ static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 	unsigned long long tmp;
 
 	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-	tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
+	tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = deci_kelvin_to_millicelsius(tmp);
 	/*
 	 * Treat freezing temperatures as invalid as well; some
 	 * BIOSes return really low values and cause reboots at startup.
@@ -261,7 +261,7 @@ static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 		acpi_handle_debug(tz->device->handle,
 				  "No critical threshold\n");
-	} else if (tmp <= 2732) {
+	} else if (tmp <= 0) {
 		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
 		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 	} else {
@@ -274,15 +274,15 @@ static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 		if (crt == -1) {
 			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 		} else if (crt > 0) {
-			unsigned long crt_k = celsius_to_deci_kelvin(crt);
+			crt *= MILLIDEGREE_PER_DEGREE;
 
 			/*
 			 * Allow override critical threshold
 			 */
-			if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
-				pr_info("Critical threshold %d C\n", crt);
+			if (crt > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
+				pr_info("Critical threshold %d m°C\n", crt);
 
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt;
 		}
 	}
 
@@ -325,10 +325,11 @@ static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
 	if (psv == -1) {
 		status = AE_SUPPORT;
 	} else if (psv > 0) {
-		tmp = celsius_to_deci_kelvin(psv);
+		tmp = psv * MILLIDEGREE_PER_DEGREE;
 		status = AE_OK;
 	} else {
 		status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &tmp);
+		tmp = deci_kelvin_to_millicelsius(tmp);
 	}
 
 	if (ACPI_FAILURE(status))
@@ -411,6 +412,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 		if (flag & ACPI_TRIPS_ACTIVE)  {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
+			tmp = deci_kelvin_to_millicelsius(tmp);
 			if (ACPI_FAILURE(status)) {
 				tz->trips[i].flags.valid = 0;
 				if (i == 0)
@@ -420,7 +422,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 					break;
 
 				if (i == 1)
-					tz->trips[0].temperature = celsius_to_deci_kelvin(act);
+					tz->trips[0].temperature = act * MILLIDEGREE_PER_DEGREE;
 				else
 					/*
 					 * Don't allow override higher than
@@ -428,9 +430,9 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 					 */
 					tz->trips[i - 1].temperature =
 						(tz->trips[i - 2].temperature <
-						celsius_to_deci_kelvin(act) ?
+						act * MILLIDEGREE_PER_DEGREE ?
 						tz->trips[i - 2].temperature :
-						celsius_to_deci_kelvin(act));
+						act * MILLIDEGREE_PER_DEGREE);
 
 				break;
 			} else {
@@ -546,8 +548,8 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
 	if (result)
 		return result;
 
-	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
-							tz->kelvin_offset);
+	*temp = tz->temperature;
+
 	return 0;
 }
 
@@ -606,9 +608,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
-					tz->kelvin_offset);
+			*temp = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature;
 			return 0;
 		}
 		trip--;
@@ -616,9 +616,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips[ACPI_THERMAL_TRIP_HOT].temperature,
-					tz->kelvin_offset);
+			*temp = tz->trips[ACPI_THERMAL_TRIP_HOT].temperature;
 			return 0;
 		}
 		trip--;
@@ -626,9 +624,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature,
-					tz->kelvin_offset);
+			*temp = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature;
 			return 0;
 		}
 		trip--;
@@ -637,9 +633,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips[i].flags.valid; i++) {
 		if (!trip) {
-			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips[i].temperature,
-					tz->kelvin_offset);
+			*temp = tz->trips[i].temperature;
 			return 0;
 		}
 		trip--;
@@ -654,9 +648,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 	struct acpi_thermal *tz = thermal->devdata;
 
 	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
-		*temperature = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
-					tz->kelvin_offset);
+		*temperature = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature;
 		return 0;
 	}
 
@@ -675,8 +667,8 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 
 	if (type == THERMAL_TRIP_ACTIVE) {
 		int trip_temp;
-		int temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->temperature, tz->kelvin_offset);
+		int temp = tz->temperature;
+
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
 
@@ -1090,7 +1082,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
+		acpi_device_bid(device), tz->temperature);
 	goto end;
 
 free_memory:
-- 
2.34.1

