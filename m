Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6966445E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjAJPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjAJPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:18:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02300479C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:18:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m3so9074619wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+L5nKBjL6STERlSXFWCkSJxT84QGzIUAzA/TnmbEbw=;
        b=gHL3Wy7rUTOmr8el0drFwI7kmw+ouL/DYftv/Zpx4pyylIGfNkjn3LAossEDKLXx8b
         0HLak2iNIwbY3gRtSstIPQL3OVBDBReVmt7iH7Eosm3jcBRRy8N2NqFXHxrGD01MOE+F
         Bq0FRucv++031M4Ywabc4zWR4rOEziaUh5p+gy0ce+FWkQ8dJxOIka/Vf6OwJElSit+a
         fe05Ax8lMbX+1o+ucqKlNscpp/nbPLcZFwW6xH1DPVSfE6QELWHoQKOGi1QPvOcfmRZp
         M55CiXtKdR+dyZ7xVoihfuEyDwLCMnPQ/i0kJtjPiJOxijOQp1D1rM+8a/ZVBPtd+iZf
         eUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+L5nKBjL6STERlSXFWCkSJxT84QGzIUAzA/TnmbEbw=;
        b=W0RvtBk48nkXjdjcUUKFSfjPHupONCDFMUT4YhAPCmsL2ywPS79+ela8eWotKANruj
         h9t7bVJYcfj3XpaPiGrwHObsvRV48A9gLsxwqhLTTyNhTaoIDHQppeIyPoeRZLICvfht
         U93DL1P5rmAD4xdiQQhSkNNfXiSKO3y29lYw5hPP3LW2W+MK3a2SZLBZsBoFKPS02Ey/
         1gsZpYGWT+dFCBOivF8svWhzwMB/t3ZNx3Uag7zU9JMOx65T1dQiMoYLgbFlCxHbj9fK
         pmVFpADeCZTikjRnF0cgsVnli8nJlROdA09U63nLFr+aoe38bSAmWDI9wbgKfVfdx1bh
         10HA==
X-Gm-Message-State: AFqh2kq6loPl0Qm9LRbnNsqvE+SEKQC8z362Qtjd7wK0Yeidmq3SD7xB
        PeT5NnRgtHMpEI4l8obvcNlQ2Q==
X-Google-Smtp-Source: AMrXdXs6iIJqdrd8F7xzn4ZrNVnbkLUMAHk3ReG9adbIDAlle3f/QtTS4JZ9RN2mfbLZag68vAdHJQ==
X-Received: by 2002:a7b:c3c9:0:b0:3d2:e28:647f with SMTP id t9-20020a7bc3c9000000b003d20e28647fmr59452793wmj.15.1673363880461;
        Tue, 10 Jan 2023 07:18:00 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm14857281wma.48.2023.01.10.07.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:18:00 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 3/3] thermal/drivers/intel: Use generic trip points int340x
Date:   Tue, 10 Jan 2023 16:17:45 +0100
Message-Id: <20230110151745.2546131-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert the ops content logic into generic trip points and register
them with the thermal zone.

In order to consolidate the code, use the ACPI thermal framework API
to fill the generic trip point from the ACPI tables.

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
   V3:
      - The driver Kconfig option selects CONFIG_THERMAL_ACPI
      - Change the initialization to use GTSH for the hysteresis on
        all the trip points

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
 .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++--------------
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 3 files changed, 43 insertions(+), 145 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 5d046de96a5d..b7072d37101d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -9,6 +9,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
+	select THERMAL_ACPI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 228f44260b27..626b33253153 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -37,65 +37,6 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
-					 int trip, int *temp)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	int i;
-
-	if (trip < d->aux_trip_nr)
-		*temp = d->aux_trips[trip];
-	else if (trip == d->crt_trip_id)
-		*temp = d->crt_temp;
-	else if (trip == d->psv_trip_id)
-		*temp = d->psv_temp;
-	else if (trip == d->hot_trip_id)
-		*temp = d->hot_temp;
-	else {
-		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-			if (d->act_trips[i].valid &&
-			    d->act_trips[i].id == trip) {
-				*temp = d->act_trips[i].temp;
-				break;
-			}
-		}
-		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
-					 int trip,
-					 enum thermal_trip_type *type)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	int i;
-
-	if (trip < d->aux_trip_nr)
-		*type = THERMAL_TRIP_PASSIVE;
-	else if (trip == d->crt_trip_id)
-		*type = THERMAL_TRIP_CRITICAL;
-	else if (trip == d->hot_trip_id)
-		*type = THERMAL_TRIP_HOT;
-	else if (trip == d->psv_trip_id)
-		*type = THERMAL_TRIP_PASSIVE;
-	else {
-		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-			if (d->act_trips[i].valid &&
-			    d->act_trips[i].id == trip) {
-				*type = THERMAL_TRIP_ACTIVE;
-				break;
-			}
-		}
-		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 				      int trip, int temp)
 {
@@ -109,25 +50,6 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	d->aux_trips[trip] = temp;
-
-	return 0;
-}
-
-
-static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
-		int trip, int *temp)
-{
-	struct int34x_thermal_zone *d = zone->devdata;
-	acpi_status status;
-	unsigned long long hyst;
-
-	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
-	if (ACPI_FAILURE(status))
-		*temp = 0;
-	else
-		*temp = hyst * 100;
-
 	return 0;
 }
 
@@ -138,58 +60,36 @@ static void int340x_thermal_critical(struct thermal_zone_device *zone)
 
 static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
-	.get_trip_temp	= int340x_thermal_get_trip_temp,
-	.get_trip_type	= int340x_thermal_get_trip_type,
 	.set_trip_temp	= int340x_thermal_set_trip_temp,
-	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
 	.critical	= int340x_thermal_critical,
 };
 
-static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
-				      int *temp)
-{
-	unsigned long long r;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(handle, name, NULL, &r);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = deci_kelvin_to_millicelsius(r);
-
-	return 0;
-}
-
 int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
 {
-	int trip_cnt = int34x_zone->aux_trip_nr;
-	int i;
+	int trip_cnt;
+	int i, ret;
+
+	trip_cnt = int34x_zone->aux_trip_nr;
 
-	int34x_zone->crt_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
-					     &int34x_zone->crt_temp))
-		int34x_zone->crt_trip_id = trip_cnt++;
+	ret = thermal_acpi_trip_crit(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
-	int34x_zone->hot_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_HOT",
-					     &int34x_zone->hot_temp))
-		int34x_zone->hot_trip_id = trip_cnt++;
+	ret = thermal_acpi_trip_hot(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
-	int34x_zone->psv_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_PSV",
-					     &int34x_zone->psv_temp))
-		int34x_zone->psv_trip_id = trip_cnt++;
+	ret = thermal_acpi_trip_psv(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
 
-		if (int340x_thermal_get_trip_config(int34x_zone->adev->handle,
-					name,
-					&int34x_zone->act_trips[i].temp))
+		ret = thermal_acpi_trip_act(int34x_zone->adev, &int34x_zone->trips[trip_cnt], i);
+		if (ret)
 			break;
 
-		int34x_zone->act_trips[i].id = trip_cnt++;
-		int34x_zone->act_trips[i].valid = true;
+		trip_cnt++;
 	}
 
 	return trip_cnt;
@@ -208,7 +108,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	acpi_status status;
 	unsigned long long trip_cnt;
 	int trip_mask = 0;
-	int ret;
+	int i, ret;
 
 	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
 				      GFP_KERNEL);
@@ -228,32 +128,35 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		int34x_thermal_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (ACPI_FAILURE(status))
-		trip_cnt = 0;
-	else {
-		int i;
-
-		int34x_thermal_zone->aux_trips =
-			kcalloc(trip_cnt,
-				sizeof(*int34x_thermal_zone->aux_trips),
-				GFP_KERNEL);
-		if (!int34x_thermal_zone->aux_trips) {
-			ret = -ENOMEM;
-			goto err_trip_alloc;
-		}
-		trip_mask = BIT(trip_cnt) - 1;
+	if (!ACPI_FAILURE(status)) {
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
-		for (i = 0; i < trip_cnt; ++i)
-			int34x_thermal_zone->aux_trips[i] = THERMAL_TEMP_INVALID;
+		trip_mask = BIT(trip_cnt) - 1;
+	}
+
+	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
+					     (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
+					      GFP_KERNEL);
+	if (!int34x_thermal_zone->trips) {
+		ret = -ENOMEM;
+		goto err_trips_alloc;
 	}
 
 	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
 
+	for (i = 0; i < trip_cnt; ++i)
+		int34x_thermal_zone->trips[i].hysteresis = thermal_acpi_trip_gtsh(adev);
+
+	for (i = 0; i < int34x_thermal_zone->aux_trip_nr; i++) {
+		int34x_thermal_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
+		int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
+	}
+	
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register(
+	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),
+						int34x_thermal_zone->trips,
 						trip_cnt,
 						trip_mask, int34x_thermal_zone,
 						int34x_thermal_zone->ops,
@@ -272,9 +175,9 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 err_enable:
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 err_thermal_zone:
+	kfree(int34x_thermal_zone->trips);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
-err_trip_alloc:
+err_trips_alloc:
 	kfree(int34x_thermal_zone->ops);
 err_ops_alloc:
 	kfree(int34x_thermal_zone);
@@ -287,7 +190,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
 {
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
+	kfree(int34x_thermal_zone->trips);
 	kfree(int34x_thermal_zone->ops);
 	kfree(int34x_thermal_zone);
 }
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
index e28ab1ba5e06..0c2c8de92014 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -10,6 +10,7 @@
 #include <acpi/acpi_lpat.h>
 
 #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
+#define INT340X_THERMAL_MAX_TRIP_COUNT INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3
 
 struct active_trip {
 	int temp;
@@ -19,15 +20,8 @@ struct active_trip {
 
 struct int34x_thermal_zone {
 	struct acpi_device *adev;
-	struct active_trip act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
-	unsigned long *aux_trips;
+	struct thermal_trip *trips;
 	int aux_trip_nr;
-	int psv_temp;
-	int psv_trip_id;
-	int crt_temp;
-	int crt_trip_id;
-	int hot_temp;
-	int hot_trip_id;
 	struct thermal_zone_device *zone;
 	struct thermal_zone_device_ops *ops;
 	void *priv_data;
-- 
2.34.1

