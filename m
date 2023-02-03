Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865568A065
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjBCRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjBCReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:34:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7CA4292
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:34:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n13so4422479wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCvJ2+qCRMxXy+MMEVuUk39VFz7D4oUUKPSRDhGhsPo=;
        b=SfBfzQCuNQe4AnDxzxTU+LJrjLjDaqNCE7rH+vRTD8glqFGZamrCEkLuXvMp+7Tt6P
         JC/nwiLpa1yrbT6piicwn5pad6GtMxjX4NKVzrYhKHvq9pwXDW17ocwNjDghUDsvCwp+
         2I2kXlGd4cz/IOFm2jaTg6rDtJDYZ6W0CWrkkv9pypQ9WNFfWqkErgzR+QxWUdojtqZJ
         0xOxXTPnJLQxDqErP/ARcZS2SZ5XB7N27z9vSwxAJcJ9ODvC4Y8TFw+Q7RuepquU0Wxg
         uNDoEIC9a6/v/bn26IYlxH8L2mGIuPg0vune8eoCREseaOE/zn7X5GiMBE3sdPDJ0yro
         /2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCvJ2+qCRMxXy+MMEVuUk39VFz7D4oUUKPSRDhGhsPo=;
        b=AV81yjfIqEmz/omyvdjuDsPN2EA98002eIkwNddGUn5jdhMeHAULyCgZdicDvDSZDm
         XdoxWZrOCFnO/ShR+6wUIEFheORXzPZjNe8Kur6Rbzf5SnlxLQSlTp6TpOifxkS09P5x
         16qzxw/TqOioqNnG/cpcWryLSMVli0GFSv8kJfm8Ax7omi27V8RawEhBrj5nlNloGbOZ
         3Dsxec+5Vipi600wpM66+kOEISYgl0jcXKDjQ+4QcL7DH+HkAHCfng4mbXFGWNHeguRz
         g5uT7XHrASBj3Fk26IrPEu0iyfjCfyFO8mfo43h3g4eduM0Teq+EzLEmVh+RObPouEcw
         XENg==
X-Gm-Message-State: AO0yUKWUuFRcscEMopLYzSftJSoD4I52G42zGho+FXDvuyJexqz83lLM
        ygXfAx7eANsOdxV+hZOR3K4MWQ==
X-Google-Smtp-Source: AK7set9+QthAA/NMqfp05ZXkvtEuBttsvVlIGZ5qWVSAcxo1zpKEyS7hznBGcc0ot51Wmnd3H1JQrQ==
X-Received: by 2002:a05:600c:16c4:b0:3dc:eaef:c1bb with SMTP id l4-20020a05600c16c400b003dceaefc1bbmr10687968wmn.35.1675445638533;
        Fri, 03 Feb 2023 09:33:58 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003dfdeb57027sm5876356wmp.38.2023.02.03.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:33:58 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 10/11] thermal/acpi: Rewrite the trip point intialization to use the generic thermal trip
Date:   Fri,  3 Feb 2023 18:33:30 +0100
Message-Id: <20230203173331.3322089-11-daniel.lezcano@linaro.org>
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

We can use the thermal trip points defined in the thermal.h.

Let's initialize them properly and when the code will be moved to the
generic thermal structure, we will be able to remove the specific acpi
trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 238 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 212 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9122d1c44777..f89236cd4fcd 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -153,6 +153,8 @@ struct acpi_thermal {
 	struct acpi_thermal_trip trips[ACPI_THERMAL_TRIP_MAX];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
+	struct thermal_trip *_trips;
+	int num_trips;
 	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
 	struct mutex thermal_check_lock;
@@ -244,6 +246,198 @@ do {	\
 		"Please report to linux-acpi@vger.kernel.org\n", str); \
 } while (0)
 
+static void acpi_thermal_trips_override(struct thermal_trip *trip, int temperature)
+{
+	if (temperature > trip->temperature)
+		pr_info("Overriding temperature %d->%d m°C\n",
+			trip->temperature, temperature);
+
+	trip->temperature = temperature;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_critical(struct acpi_thermal *tz,
+							      struct thermal_trip *trips,
+							      int *num_trips)
+{
+	acpi_status status = AE_OK;
+	unsigned long long temp;
+
+	/*
+	 * Module parameters disable the critical trip point
+	 */
+	if (crt < 0)
+		goto out;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
+		goto out;
+	}
+
+	if (temp <= 2732) {
+		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", temp);
+		goto out;
+	}
+
+	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+	if (!trips)
+		goto out;
+
+	memset(&trips[*num_trips], 0, sizeof(*trips));
+
+	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+	trips[*num_trips].type = THERMAL_TRIP_CRITICAL;
+
+	if (crt > 0)
+		acpi_thermal_trips_override(&trips[*num_trips], crt * MILLI);
+	
+	(*num_trips)++;
+out:
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_hot(struct acpi_thermal *tz,
+							 struct thermal_trip *trips,
+							 int *num_trips)
+{
+	acpi_status status;
+	unsigned long long temp;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
+		goto out;
+	}
+
+	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+	if (!trips)
+		goto out;
+
+	memset(&trips[*num_trips], 0, sizeof(*trips));
+
+	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+	trips[*num_trips].type = THERMAL_TRIP_HOT;
+	
+	(*num_trips)++;
+out:
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_passive(struct acpi_thermal *tz,
+							     struct thermal_trip *trips,
+							     int *num_trips)
+{
+	struct acpi_handle_list devices;
+	acpi_status status;
+	unsigned long long temp;
+
+	/*
+	 * Module parameters disable all passive trip points
+	 */
+	if (psv < 0)
+		goto out;
+	
+	status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No passive threshold\n");
+		goto out;
+	}
+
+	status = acpi_evaluate_reference(tz->device->handle, "_PSL", NULL, &devices);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No passive device associated\n");
+		goto out;
+	}
+	
+	trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+	if (!trips)
+		goto out;
+
+	memset(&trips[*num_trips], 0, sizeof(*trips));
+
+	trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+	trips[*num_trips].type = THERMAL_TRIP_PASSIVE;
+	
+	(*num_trips)++;
+out:
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc_active(struct acpi_thermal *tz,
+							    struct thermal_trip *trips,
+							    int *num_trips)
+{
+	struct acpi_handle_list devices;
+	acpi_status status;
+	unsigned long long temp;
+	int i;
+
+	/*
+	 * Module parameters disable all active trip points
+	 */
+	if (act < 0)
+		return trips;
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		char name[5];
+
+		sprintf(name, "_AC%d", i);
+
+		status = acpi_evaluate_integer(tz->device->handle, name, NULL, &temp);
+		if (ACPI_FAILURE(status))
+			break;
+
+		sprintf(name, "_AL%d", i);
+
+		status = acpi_evaluate_reference(tz->device->handle, name, NULL, &devices);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_info(tz->device->handle, "No _AL%d defined for _AC%d\n", i, i);
+			break;
+		}
+
+		trips = krealloc(trips, sizeof(*trips) * (*num_trips + 1), GFP_KERNEL);
+		if (!trips)
+			break;
+
+		memset(&trips[*num_trips], 0, sizeof(*trips));
+
+		trips[*num_trips].temperature = deci_kelvin_to_millicelsius(temp);
+		trips[*num_trips].type = THERMAL_TRIP_ACTIVE;
+	
+		(*num_trips)++;
+	}
+
+	/*
+	 * We found at least one trip point and we have an override option
+	 */
+	if (i && act) {
+		/*
+		 * Regarding the ACPI specification AC0 is the highest active
+		 * temperature trip point. We will override this one.
+		 */
+		acpi_thermal_trips_override(&trips[*num_trips], act * MILLI);		
+	}
+
+	return trips;
+}
+
+static struct thermal_trip *acpi_thermal_trips_alloc(struct acpi_thermal *tz, int *num_trips)
+{
+	struct thermal_trip *trips = NULL;
+
+	*num_trips = 0;
+
+	trips = acpi_thermal_trips_alloc_critical(tz, trips, num_trips);
+
+	trips = acpi_thermal_trips_alloc_hot(tz, trips, num_trips);
+
+	trips = acpi_thermal_trips_alloc_passive(tz, trips, num_trips);
+
+	trips = acpi_thermal_trips_alloc_active(tz, trips, num_trips);
+
+	return trips;
+}
+
 static int acpi_thermal_trips_update_critical(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status = AE_OK;
@@ -398,7 +592,7 @@ static int acpi_thermal_trips_update_active(struct acpi_thermal *tz, int flag)
 	int valid = 0;
 	int i;
 
-	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
 
 		valid = tz->trips[i].flags.valid;
@@ -820,35 +1014,20 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
-	int trips = 0;
 	int result;
 	acpi_status status;
-	int i;
-
-	if (tz->trips[ACPI_THERMAL_TRIP_CRITICAL].flags.valid)
-		trips++;
-
-	if (tz->trips[ACPI_THERMAL_TRIP_HOT].flags.valid)
-		trips++;
-
-	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
-		trips++;
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips[i].flags.valid;
-	     i++, trips++);
 
 	if (tz->trips[ACPI_THERMAL_TRIP_PASSIVE].flags.valid)
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     		&acpi_thermal_zone_ops, NULL,
-						     		tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
-						     		tz->polling_frequency*100);
+			thermal_zone_device_register_with_trips("acpitz", tz->_trips, tz->num_trips, 0, tz,
+								&acpi_thermal_zone_ops, NULL,
+								tz->trips[ACPI_THERMAL_TRIP_PASSIVE].tsp*100,
+								tz->polling_frequency*100);
 	else
 		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     		&acpi_thermal_zone_ops, NULL,
-						     		0, tz->polling_frequency * 100);
-
+			thermal_zone_device_register_with_trips("acpitz", tz->_trips, tz->num_trips, 0, tz,
+								&acpi_thermal_zone_ops, NULL,
+								0, tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
@@ -1051,8 +1230,8 @@ static void acpi_thermal_check_fn(struct work_struct *work)
 
 static int acpi_thermal_add(struct acpi_device *device)
 {
-	struct acpi_thermal *tz;
-	int result;
+	struct acpi_thermal *tz = NULL;
+	int result = 0;
 
 	if (!device)
 		return -EINVAL;
@@ -1073,9 +1252,13 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_thermal_guess_offset(tz);
 
+	tz->_trips = acpi_thermal_trips_alloc(tz, &tz->num_trips);
+	if (!tz->_trips)
+		goto free_trips;
+
 	result = acpi_thermal_register_thermal_zone(tz);
 	if (result)
-		goto free_memory;
+		goto free_trips;
 
 	refcount_set(&tz->thermal_check_count, 3);
 	mutex_init(&tz->thermal_check_lock);
@@ -1085,6 +1268,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 		acpi_device_bid(device), tz->temperature);
 	goto end;
 
+free_trips:
+	kfree(tz->_trips);
 free_memory:
 	kfree(tz);
 end:
@@ -1101,6 +1286,7 @@ static void acpi_thermal_remove(struct acpi_device *device)
 	flush_workqueue(acpi_thermal_pm_queue);
 	tz = acpi_driver_data(device);
 
+	kfree(tz->trips);
 	acpi_thermal_unregister_thermal_zone(tz);
 	kfree(tz);
 }
-- 
2.34.1

