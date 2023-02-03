Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FEC68A0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjBCRpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjBCRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:44:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACEBAA26A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:44:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ba1so1267854wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC3Bc1ZBnDqOCsf2GYYuc3UMis7l5JLiGW3gDWAr4Jo=;
        b=pJ732D7wxi7dC/ACoJ+N7AadtG+fy3kkhpMKjo9B9q/XI4FbuQcIftbwc4hash+Kh8
         FJQzlOrXdWxJAoQDO3uHMZO+Ysk8u/JAffEPVr0qR6BIBiNvnm6yVCSdofBQG6L09+IW
         Lp82Ix4mezOKOEiUcIwJunT8OQxlYdxQhYraoADpk44ESIM7TBkgGbYg+wjTlFVe3B7d
         gwSXRGciCB9K6sqxSYjR+CRh1NxqnjyxQphQ9ZWCOwMKG6MKKcNadvMWK35auY8G3M20
         KTS1unaRQwFEYJxNuAItC6aNuJ+ugDxvKq7Q7WhgitqURRxXjdv9UI+C/rKH2NiH7gbj
         CZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC3Bc1ZBnDqOCsf2GYYuc3UMis7l5JLiGW3gDWAr4Jo=;
        b=RgaU9R/LixuniP+aO6oWOUMgyd1HtVJR4yH34e3CrPHGWub9xe7pCxP+MqJwGKjLuU
         u/nlj1GmyJBbhoRKR/4c97xCJW5KB0R3DvwcBJLVBKeJk1m7FEQgvj8/DC4q9WJeyJ+Q
         Sd1vNhcSLjwxYq8Y9sVQTSjg6lXNuFtjee4gXexY6mfNWHkg0//9Gp66oNOb5XQ0CmL0
         iooQhNacy1T7rGBc6Gwz54YDizr4SyR+9JHUjwi1QD22mo3Bu58BSe6j8aVReUrQsPvJ
         UXflsmED/80qKCsed9iyql8c/EOozoZMnf/mTQkpn+DHme9r0UbBa72uGrm84jmpyI2s
         UhJg==
X-Gm-Message-State: AO0yUKW72Pii5d3Ng6IS5VCi6apcmKa4oFtOzOX9hY7zs8QjATWP/NNb
        +UVuvCfd4mf6/j6zrziiWhG1SA==
X-Google-Smtp-Source: AK7set8tWn0i+VFqDBGvozB6IrkxDRMniFUP/FWEr+ZYy9y56QrHzfqfEbTUcI9R8X/iGi8+uKqtww==
X-Received: by 2002:adf:f481:0:b0:2bf:f6e6:edde with SMTP id l1-20020adff481000000b002bff6e6eddemr7809306wro.3.1675446283027;
        Fri, 03 Feb 2023 09:44:43 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:42 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/11] thermal/acpi: Convert the units to milli Celsuis
Date:   Fri,  3 Feb 2023 18:44:27 +0100
Message-Id: <20230203174429.3375691-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
References: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
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

