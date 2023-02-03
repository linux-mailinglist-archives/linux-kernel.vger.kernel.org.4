Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334168A063
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjBCRes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjBCReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:34:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D648FA56D5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:33:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q8so4423577wmo.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za8uPsw5SSvV8WX2HiDt+VQyx2NN7X9xXkrZzQ/66K8=;
        b=fP96O09tFdYsJTmC6eXLyl14WDoHUGqDsl5HcJXm2pMczExOBbEBwcmx5rnXoNG5vg
         G7RUnGyDTBt15mybbBVoUAhlebN6IJ49RiKaPfiuHGIKoAcuP36FIqi3MmghgxFpMlqA
         7bNGR8bBAvgxb5n47//Az6CDg30Rhe1XlUl6Pa9W4cJcEwLxxnXS7xxuM5lXJvTAdwDn
         KJXG2zc7NEKYC8FUyKxb4osQvZZszjyX+YjIJsx+MQg+XTpyC/XdSJIkEI4Vft6PxIbC
         6/m362S10ypEKT7cKfH1lGSVRB5xyjSVAMW6PJ0F3732qYyP3kM1aGLLI2atFZyebOHH
         6Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za8uPsw5SSvV8WX2HiDt+VQyx2NN7X9xXkrZzQ/66K8=;
        b=p6UO5Rm1lEJ86gRHUXB4M98qDJxKW9EuyVjZObTAXLIIgY4fODikWb5Uhwo99TiViU
         aUguHpdhuGSMMFLaoRiOlp/Ng93VE45RRdkXwTa7OKRCbt6ayVFMqAF8AyA3pmCaLAv7
         OPXlXLnQPBj+aROI6HCtfoX74cP6NrwgBl4bJ6q18FbrrpQUIOa7wH292eRpE14d86UY
         U9mJmzvisZlbbno/J+0XOZRTTf8YRN56ig/UK/pN4w82LP4nSCH0T+lyVOVrQypsK+Yc
         4o6MqCQAEv59qcudrdifJdSulJNxgkaJnlXHwnslkJJNq13ph12ylx3KCpce+WGJatfD
         Ralw==
X-Gm-Message-State: AO0yUKU2VC0A0YIFhAEau/g0Xi2Rm4cQGUHAa/xJ5rfZzJCCyAnYouF8
        m/zvGAEKTKphRfXn75AoDE9qYg==
X-Google-Smtp-Source: AK7set9ZA+L6AMPGQzeHh6YBOlYTyUjgC9P72YkBFlAzfqluqd6fXuA0VSS1vf5hFUkebx0cJ65kKA==
X-Received: by 2002:a05:600c:5006:b0:3dd:caa8:3ae2 with SMTP id n6-20020a05600c500600b003ddcaa83ae2mr10847151wmr.6.1675445634153;
        Fri, 03 Feb 2023 09:33:54 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 06/11] thermal/acpi: Encapsulate in functions the trip initialization
Date:   Fri,  3 Feb 2023 18:33:26 +0100
Message-Id: <20230203173331.3322089-7-daniel.lezcano@linaro.org>
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

The thermal trip update function is a bit difficult to read, it is
very long and has everything put in there to initialize the trip
points. In order to improve its readability, let's encapuslate the
different parts into dedicated functions. So we can act individually
per trip type changes and will make easier to review the next changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 257 ++++++++++++++++++++++++-----------------
 1 file changed, 154 insertions(+), 103 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c4fd583fbf5c..a3a8130c955f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -246,113 +246,120 @@ do {	\
 		"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
-static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	unsigned long long tmp;
-	struct acpi_handle_list devices;
-	int valid = 0;
-	int i;
 
-	/* Critical Shutdown */
-	if (flag & ACPI_TRIPS_CRITICAL) {
-		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
-
-		/*
-		 * Treat freezing temperatures as invalid as well; some
-		 * BIOSes return really low values and cause reboots at startup.
-		 * Below zero (Celsius) values clearly aren't right for sure..
-		 * ... so lets discard those as invalid.
-		 */
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-			acpi_handle_debug(tz->device->handle,
-					  "No critical threshold\n");
-		} else if (tmp <= 2732) {
-			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
+	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
+	tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = tmp;
+	/*
+	 * Treat freezing temperatures as invalid as well; some
+	 * BIOSes return really low values and cause reboots at startup.
+	 * Below zero (Celsius) values clearly aren't right for sure..
+	 * ... so lets discard those as invalid.
+	 */
+	if (ACPI_FAILURE(status)) {
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
+		acpi_handle_debug(tz->device->handle,
+				  "No critical threshold\n");
+	} else if (tmp <= 2732) {
+		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
+	} else {
+		tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
+		acpi_handle_debug(tz->device->handle,
+				  "Found critical threshold [%lu]\n",
+				  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
+	}
+	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid == 1) {
+		if (crt == -1) {
 			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 1;
-			acpi_handle_debug(tz->device->handle,
-					  "Found critical threshold [%lu]\n",
-					  tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature);
-		}
-
-		if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid) {
-			if (crt == -1) {
-				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid = 0;
-			} else if (crt > 0) {
-				unsigned long crt_k = celsius_to_deci_kelvin(crt);
+		} else if (crt > 0) {
+			unsigned long crt_k = celsius_to_deci_kelvin(crt);
 
-				/*
-				 * Allow override critical threshold
-				 */
-				if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
-					pr_info("Critical threshold %d C\n", crt);
+			/*
+			 * Allow override critical threshold
+			 */
+			if (crt_k > tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature)
+				pr_info("Critical threshold %d C\n", crt);
 
-				tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
-			}
+			tz->trips[ACPI_THERMAL_TRIP_CRITICAL].temperature = crt_k;
 		}
 	}
 
-	/* Critical Sleep (optional) */
-	if (flag & ACPI_TRIPS_HOT) {
-		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
-			acpi_handle_debug(tz->device->handle,
-					  "No hot threshold\n");
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
-			tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
-			acpi_handle_debug(tz->device->handle,
-					  "Found hot threshold [%lu]\n",
-					  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
-		}
+	return 0;
+}
+
+static int acpi_thermal_trips_update_hot(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+
+	status = acpi_evaluate_integer(tz->device->handle,
+				       "_HOT", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 0;
+		acpi_handle_debug(tz->device->handle,
+				  "No hot threshold\n");
+	} else {
+		tz->trips[ACPI_THERMAL_TRIP_HOT].temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid = 1;
+		acpi_handle_debug(tz->device->handle,
+				  "Found hot threshold [%lu]\n",
+				  tz->trips[ACPI_THERMAL_TRIP_HOT].temperature);
 	}
 
-	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
-	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
-		if (psv == -1) {
-			status = AE_SUPPORT;
-		} else if (psv > 0) {
-			tmp = celsius_to_deci_kelvin(psv);
-			status = AE_OK;
-		} else {
-			status = acpi_evaluate_integer(tz->device->handle,
-						       "_PSV", NULL, &tmp);
-		}
+	return 0;
+}
 
-		if (ACPI_FAILURE(status)) {
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-		} else {
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
-			tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
-			if (flag == ACPI_TRIPS_INIT) {
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TC1", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TC2", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TSP", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
-				else
-					tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
-			}
+static int acpi_thermal_trips_update_passive(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status;
+	unsigned long long tmp;
+	struct acpi_handle_list devices;
+	int valid = 0;
+
+	valid = tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid;
+	if (psv == -1) {
+		status = AE_SUPPORT;
+	} else if (psv > 0) {
+		tmp = celsius_to_deci_kelvin(psv);
+		status = AE_OK;
+	} else {
+		status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &tmp);
+	}
+
+	if (ACPI_FAILURE(status))
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+	else {
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].temperature = tmp;
+		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 1;
+		if (flag == ACPI_TRIPS_INIT) {
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TC1",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc1 = tmp;
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TC2",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tc2 = tmp;
+			status = acpi_evaluate_integer(
+				tz->device->handle, "_TSP",
+				NULL, &tmp);
+			if (ACPI_FAILURE(status))
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid = 0;
+			else
+				tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp = tmp;
 		}
 	}
+
 	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
@@ -372,12 +379,23 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
+
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
 		if (valid != tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
-	/* Active (optional) */
+	return 0;
+}
+
+static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	unsigned long long tmp;
+	struct acpi_handle_list devices;
+	int valid = 0;
+	int i;
+
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
 		valid = tz->trips[i].flags.valid;
@@ -445,17 +463,50 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			break;
 	}
 
-	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(devices));
-		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
-						 NULL, &devices);
-		if (ACPI_SUCCESS(status) &&
-		    memcmp(&tz->devices, &devices, sizeof(devices))) {
-			tz->devices = devices;
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
-		}
+	return 0;
+}
+
+static int acpi_thermal_trips_update_devices(struct acpi_thermal *tz, int flag)
+{
+	acpi_status status = AE_OK;
+	struct acpi_handle_list devices;
+
+	memset(&devices, 0, sizeof(devices));
+	status = acpi_evaluate_reference(tz->device->handle, "_TZD", NULL, &devices);
+	if (ACPI_SUCCESS(status)
+	    && memcmp(&tz->devices, &devices, sizeof(devices))) {
+		tz->devices = devices;
+		ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
+	}
+
+	return 0;
+}
+
+static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+{
+	/* Critical Shutdown */
+	if (flag & ACPI_TRIPS_CRITICAL) {
+		acpi_thermal_trips_update_critical(tz, flag);
 	}
 
+	/* Critical Sleep (optional) */
+	if (flag & ACPI_TRIPS_HOT) {
+		acpi_thermal_trips_update_hot(tz, flag);
+	}
+
+	/* Passive (optional) */
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
+		acpi_thermal_trips_update_passive(tz, flag);
+	}
+
+	/* Active (optional) */
+	acpi_thermal_trips_update_active(tz, flag);
+
+	if (flag & ACPI_TRIPS_DEVICES) {
+		acpi_thermal_trips_update_devices(tz, flag);
+	}
+	
 	return 0;
 }
 
-- 
2.34.1

