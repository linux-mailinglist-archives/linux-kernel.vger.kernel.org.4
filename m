Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01B45F4874
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJDR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJDR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:27:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38218642C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:27:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b7so14769986wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO25AA5MH7o6mmP/ulciu6/M0rMSBo6p6lETw4mAlpw=;
        b=EYd8ISRDRP3m6H0QOJ3lqAOf+GTcDb53IVGkGXxakLLhtte45Jaf3vQy8+MXsceTxF
         JTeuRMTQ+OcHFTsvGpBar0nVFWi2w9MihV+26iK501AxsjoE32lZzYhiA54dUm1DKkDV
         GxXphFuSaBNlBw1RpglSx4fOnvOUOZxUVJo+ViHt++gT5FkWM+oRtJwMjDddr6vQEXJ5
         RXsiDdAXcHQtm/BNZaasg9Wy4JbvzqxiNueGl30YezOl/CoNfb1/2lhWluzejdeF0gpo
         JKcGvzggpMhYPwSq+VWpmgdM2UArR8FfXLo3l4yWPjgD43w6XOTOlNsv/e07WD0OzFdb
         WqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO25AA5MH7o6mmP/ulciu6/M0rMSBo6p6lETw4mAlpw=;
        b=vUwCJAvCYr+AEE+xoLpqMniMbWGiELWzSKH9I0KnehCVhTwWTgT9kbV16+gB+Ao6wO
         P5AvE4BPUWvUe5XHrktl/axZuOK2awKg6JM4AIVds9pJTywmX6URE2ciwABgFcbg/sGR
         BnBc2EOCLOVQyHM16C6BzixkNmo5RMyEiZDLu/JtMN/o4GMvZJhDIEr8TTR6E1ojWCyk
         7H9xQB6VOPGBDWAYHU4i9WCBuZwRWKEwrpktArQ4M5LCiIQdWnpPyvAK6cc+aRlJ4Y+M
         TNX69WwRKACZQUBk4AJlX7C4/RxNX90oawhuvAjSDxPQcgMP/5JsvveP2PolKK/cMCku
         ARMA==
X-Gm-Message-State: ACrzQf1DiSYrMTHp/vffBA/ktBnB2463USQZAjl5XOVTgpttKgpDpV3l
        Eq2vSBo4Sf5RkKs5xR7p7+lB0Q==
X-Google-Smtp-Source: AMsMyM7TdOf06JeB9+3SJ05CnANDstNHT8p3fNmJYTRBtajZuQEhDlRBVfxebl+FQkKKeFHEeXe3jA==
X-Received: by 2002:a05:6000:18ab:b0:22e:39f1:861a with SMTP id b11-20020a05600018ab00b0022e39f1861amr7260752wri.129.1664904430642;
        Tue, 04 Oct 2022 10:27:10 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH RFC 3/9] thermal/acpi: Convert the acpi thermal trips to an array
Date:   Tue,  4 Oct 2022 19:26:52 +0200
Message-Id: <20221004172658.2302511-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
References: <12068304.O9o76ZdvQC@kreacher>
 <20221004172658.2302511-1-daniel.lezcano@linaro.org>
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

Instead of having multiple trip points in the structure fields for
each trip type, let's create an array of trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 131 ++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 62 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9620128f05d2..8bf2b25acdf1 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -104,6 +104,15 @@ static struct acpi_driver acpi_thermal_driver = {
 	.drv.pm = &acpi_thermal_pm,
 };
 
+enum {
+	ACPI_THERMAL_TRIP_CRITICAL,
+	ACPI_THERMAL_TRIP_HOT,
+	ACPI_THERMAL_TRIP_PASSIVE,
+	ACPI_THERMAL_TRIP_ACTIVE
+};
+
+#define ACPI_THERMAL_TRIP_MAX (ACPI_THERMAL_TRIP_ACTIVE + ACPI_THERMAL_MAX_ACTIVE)
+
 struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
@@ -143,9 +152,7 @@ struct acpi_thermal {
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
-	struct acpi_thermal_trip critical;
-	struct acpi_thermal_trip hot;
-	struct acpi_thermal_trip passive;
+	struct acpi_thermal_trip trips[ACPI_THERMAL_TRIP_MAX];
 	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
@@ -252,7 +259,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle,
 				"_CRT", NULL, &tmp);
-		tz->critical.temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
 		/*
 		 * Treat freezing temperatures as invalid as well; some
 		 * BIOSes return really low values and cause reboots at startup.
@@ -260,32 +267,32 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		 * ... so lets discard those as invalid.
 		 */
 		if (ACPI_FAILURE(status)) {
-			tz->critical.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
 			pr_info(FW_BUG "Invalid critical threshold (%llu)\n",
 				tmp);
-			tz->critical.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 		} else {
-			tz->critical.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
 			acpi_handle_debug(tz->device->handle,
 					  "Found critical threshold [%lu]\n",
-					  tz->critical.temperature);
+					  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
 		}
-		if (tz->critical.flags.valid == 1) {
+		if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid == 1) {
 			if (crt == -1) {
-				tz->critical.flags.valid = 0;
+				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 			} else if (crt > 0) {
 				unsigned long crt_k = celsius_to_deci_kelvin(crt);
 
 				/*
 				 * Allow override critical threshold
 				 */
-				if (crt_k > tz->critical.temperature)
+				if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
 					pr_info("Critical threshold %d C\n", crt);
 
-				tz->critical.temperature = crt_k;
+				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
 			}
 		}
 	}
@@ -295,22 +302,22 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		status = acpi_evaluate_integer(tz->device->handle,
 				"_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
-			tz->hot.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No hot threshold\n");
 		} else {
-			tz->hot.temperature = tmp;
-			tz->hot.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
+			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
 			acpi_handle_debug(tz->device->handle,
 					  "Found hot threshold [%lu]\n",
-					  tz->hot.temperature);
+					  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
 		}
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->passive.flags.valid) ||
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
 		(flag == ACPI_TRIPS_INIT)) {
-		valid = tz->passive.flags.valid;
+		valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -322,56 +329,56 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		}
 
 		if (ACPI_FAILURE(status))
-			tz->passive.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 		else {
-			tz->passive.temperature = tmp;
-			tz->passive.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TC1",
 						NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tc1 = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TC2",
 						NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tc2 = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
 				status = acpi_evaluate_integer(
 						tz->device->handle, "_TSP",
 						NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tsp = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
 			}
 		}
 	}
-	if ((flag & ACPI_TRIPS_DEVICES) && tz->passive.flags.valid) {
+	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(tz->device->handle,
 					 "Invalid passive threshold\n");
-			tz->passive.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 		}
 		else
-			tz->passive.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
 
-		if (memcmp(&tz->passive.devices, &devices,
+		if (memcmp(&tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices, &devices,
 				sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->passive.devices, &devices,
+			memcpy(&tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices, &devices,
 				sizeof(struct acpi_handle_list));
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
-		if (valid != tz->passive.flags.valid)
+		if (valid != tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
@@ -462,9 +469,9 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 	if (ret)
 		return ret;
 
-	valid = tz->critical.flags.valid |
-		tz->hot.flags.valid |
-		tz->passive.flags.valid;
+	valid = tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid |
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid |
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
 		valid |= tz->active[i].flags.valid;
@@ -504,7 +511,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_CRITICAL;
 			return 0;
@@ -512,7 +519,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->hot.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_HOT;
 			return 0;
@@ -520,7 +527,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -549,30 +556,30 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->critical.temperature,
+				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->hot.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->hot.temperature,
+				tz->trips[ACPI_THERMAL_TRIP_HOT].temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-				tz->passive.temperature,
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature,
 				tz->kelvin_offset);
 			return 0;
 		}
@@ -598,9 +605,9 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
-				tz->critical.temperature,
+				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
 				tz->kelvin_offset);
 		return 0;
 	} else
@@ -637,9 +644,9 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = (tz->passive.tc1 * (tz->temperature - tz->last_temperature))
-		+ (tz->passive.tc2
-		* (tz->temperature - tz->passive.temperature));
+	i = (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 * (tz->temperature - tz->last_temperature))
+		+ (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2
+		* (tz->temperature - tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature));
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -683,17 +690,17 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	int trip = -1;
 	int result = 0;
 
-	if (tz->critical.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid)
 		trip++;
 
-	if (tz->hot.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid)
 		trip++;
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		trip++;
-		for (i = 0; i < tz->passive.devices.count;
+		for (i = 0; i < tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices.count;
 		    i++) {
-			handle = tz->passive.devices.handles[i];
+			handle = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -773,23 +780,23 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	acpi_status status;
 	int i;
 
-	if (tz->critical.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid)
 		trips++;
 
-	if (tz->hot.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid)
 		trips++;
 
-	if (tz->passive.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		trips++;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 			tz->active[i].flags.valid; i++, trips++);
 
-	if (tz->passive.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
 						&acpi_thermal_zone_ops, NULL,
-						     tz->passive.tsp*100,
+						     tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
 						     tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
@@ -966,8 +973,8 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
  */
 static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
-	if (tz->critical.flags.valid &&
-	    (tz->critical.temperature % 5) == 1)
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid &&
+	    (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature % 5) == 1)
 		tz->kelvin_offset = 273100;
 	else
 		tz->kelvin_offset = 273200;
-- 
2.34.1

