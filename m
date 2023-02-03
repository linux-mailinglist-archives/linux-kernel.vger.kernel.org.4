Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772868A052
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjBCReE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjBCRdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:33:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF4BA4292
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:33:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so4447381wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gq0E/YoPxBHVucgVAdwG/B9OSJ+hQO93j4O3hXiF4s=;
        b=t8ZgldBZCGzxhcueoE963fGMGt0RN2t93rSkJDpg+pfgaIujsTgpMjULYPRCv47S8j
         Ua+UdV3/XxxSON+QsJHVLrbZ6v/g7iqtcdlZgRTNjhPn3AUzRmVPulTOEz2M/Lk+w5Vp
         JfRR5SJXOaciPIyemkZIjosAsFI1DQxr/TaNrjvI2TKCo1slcZn5ZEUp6nPq+UM8CZGo
         prWK0TTiu3hU6QAweIYLiiPh8Pz1/TeOkO1FuhZum5bo4+/jv4nELoNiXYoxcVaxSvoP
         vE3XFjGBUodP9VT6Xm4b+4zTq2LEWCpmPzUii02A05x6vicTdPMY3MKZcEAj3qsnwkKT
         qgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gq0E/YoPxBHVucgVAdwG/B9OSJ+hQO93j4O3hXiF4s=;
        b=wjawBuBtbIHUfHnwaPD+KMQqBxwwwMd39QlClZtOQZdMWiMi2akfqz4+eEayuTntHP
         SmIjF6JwuiELIQe6xgD9CVTwPg3N632Bn1KZCvUQB0wyf5pwE4pHNhtjnxRBWEWqKGsS
         Dfl0tDXuVTsbTW9QdY+FAB2bAeoG2duijXXBvcmen1hcWSyL9uP5SgkmBRElb/pPP9fK
         OLkL+45n9zmhzQYEUQakVkp1/P0zn0xv59kj7hv6Jo+3BLC3OCgjMntEt23R/JquHdg/
         hEdIsYOPgtCng47/wFINCG381CKCyDhEHSBsCWVYxekXX5qs0dx6hoZnoaYAh9V3ehuA
         giYg==
X-Gm-Message-State: AO0yUKX67IFXwDMpSUnFSnPSNumMmgsGOuGykusZwS8h65jHCPPDKFaj
        b4bQRoQ9H94bEXMDuyjXm6qOmA==
X-Google-Smtp-Source: AK7set+8B9ke/HXqRtJjT48urq15ges2nlPMN3A1PR2GSVUdS0KTCRvu68q6SjIlTXET5GhB632s7A==
X-Received: by 2002:a05:600c:1d11:b0:3de:3381:24f2 with SMTP id l17-20020a05600c1d1100b003de338124f2mr10653315wms.30.1675445630934;
        Fri, 03 Feb 2023 09:33:50 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:50 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 03/11] thermal/acpi: Convert the acpi thermal trips to an array
Date:   Fri,  3 Feb 2023 18:33:23 +0100
Message-Id: <20230203173331.3322089-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
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

Instead of having multiple trip points in the structure fields for
each trip type, let's create an array of trip points.

No functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 130 ++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e27b0b71fcf8..6b07de78c4c6 100644
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
@@ -251,7 +258,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	/* Critical Shutdown */
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-		tz->critical.temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
 
 		/*
 		 * Treat freezing temperatures as invalid as well; some
@@ -260,32 +267,32 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		 * ... so lets discard those as invalid.
 		 */
 		if (ACPI_FAILURE(status)) {
-			tz->critical.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
 			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
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
 
-		if (tz->critical.flags.valid) {
+		if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
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
@@ -294,22 +301,22 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	if (flag & ACPI_TRIPS_HOT) {
 		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
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
 	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->passive.flags.valid;
+		valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -321,53 +328,53 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		}
 
 		if (ACPI_FAILURE(status)) {
-			tz->passive.flags.valid = 0;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 		} else {
-			tz->passive.temperature = tmp;
-			tz->passive.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC1", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tc1 = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC2", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->passive.flags.valid = 0;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
 				else
-					tz->passive.tc2 = tmp;
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TSP", NULL, &tmp);
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
 		} else {
-			tz->passive.flags.valid = 1;
+			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
 		}
 
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
 
@@ -460,9 +467,9 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
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
@@ -502,7 +509,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_CRITICAL;
 			return 0;
@@ -510,7 +517,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->hot.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_HOT;
 			return 0;
@@ -518,7 +525,7 @@ static int thermal_get_trip_type(struct thermal_zone_device *thermal,
 		trip--;
 	}
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -546,30 +553,30 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->critical.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->hot.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->hot.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_HOT].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
 		trip--;
 	}
 
-	if (tz->passive.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->passive.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -595,9 +602,9 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 {
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (tz->critical.flags.valid) {
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
-					tz->critical.temperature,
+					tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature,
 					tz->kelvin_offset);
 		return 0;
 	}
@@ -635,8 +642,9 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	 * tz->temperature has already been updated by generic thermal layer,
 	 * before this callback being invoked
 	 */
-	i = (tz->passive.tc1 * (tz->temperature - tz->last_temperature)) +
-		(tz->passive.tc2 * (tz->temperature - tz->passive.temperature));
+	i = (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 * (tz->temperature - tz->last_temperature)) +
+		(tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 *
+		(tz->temperature - tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature));
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -681,16 +689,16 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
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
-		for (i = 0; i < tz->passive.devices.count; i++) {
-			handle = tz->passive.devices.handles[i];
+		for (i = 0; i < tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices.count; i++) {
+			handle = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -774,23 +782,23 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
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
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->active[i].flags.valid;
 	     i++, trips++);
 
-	if (tz->passive.flags.valid)
+	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		tz->thermal_zone =
 			thermal_zone_device_register("acpitz", trips, 0, tz,
 						     		&acpi_thermal_zone_ops, NULL,
-						     		tz->passive.tsp*100,
+						     		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
 						     		tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
@@ -966,8 +974,8 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
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

