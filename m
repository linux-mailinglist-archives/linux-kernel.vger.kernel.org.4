Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E967B52F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjAYOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAYOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:55:45 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C330FE;
        Wed, 25 Jan 2023 06:55:39 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id a6cd8a2a436afc72; Wed, 25 Jan 2023 15:55:37 +0100
Received: from kreacher.localnet (unknown [213.134.163.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D6B362201948;
        Wed, 25 Jan 2023 15:55:35 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 3/3] thermal: intel: int340x: Use generic trip points table
Date:   Wed, 25 Jan 2023 15:55:24 +0100
Message-ID: <2155221.irdbgypaU6@kreacher>
In-Reply-To: <5665899.DvuYhMxLoT@kreacher>
References: <5665899.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.149
X-CLIENT-HOSTNAME: 213.134.163.149
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduieefrddugeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrudegledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify int340x_thermal_zone_add() to register the thermal zone along
with a trip points table, which allows the trip-related zone callbacks
to be dropped, because they are not needed any more.

In order to consolidate the code, use ACPI trip library functions to
populate generic trip points in int340x_thermal_read_trips() and to
update them in int340x_thermal_update_trips().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/Kconfig                |    1 
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |  265 +++--------
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h |   10 
 3 files changed, 90 insertions(+), 186 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/Kconfig
+++ linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -9,6 +9,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
+	select THERMAL_ACPI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select INTEL_TCC
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -37,65 +37,6 @@ static int int340x_thermal_get_zone_temp
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
@@ -109,25 +50,6 @@ static int int340x_thermal_set_trip_temp
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
 
@@ -138,58 +60,35 @@ static void int340x_thermal_critical(str
 
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
-static int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
-{
-	int trip_cnt = int34x_zone->aux_trip_nr;
-	int i;
-
-	int34x_zone->crt_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
-					     &int34x_zone->crt_temp))
-		int34x_zone->crt_trip_id = trip_cnt++;
-
-	int34x_zone->hot_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_HOT",
-					     &int34x_zone->hot_temp))
-		int34x_zone->hot_trip_id = trip_cnt++;
-
-	int34x_zone->psv_trip_id = -1;
-	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_PSV",
-					     &int34x_zone->psv_temp))
-		int34x_zone->psv_trip_id = trip_cnt++;
+static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
+				      struct thermal_trip *zone_trips,
+				      int trip_cnt)
+{
+	int i, ret;
+
+	ret = thermal_acpi_trip_critical(zone_adev, &zone_trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
+
+	ret = thermal_acpi_trip_hot(zone_adev, &zone_trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
+
+	ret = thermal_acpi_trip_passive(zone_adev, &zone_trips[trip_cnt]);
+	if (!ret)
+		trip_cnt++;
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
 
-		if (int340x_thermal_get_trip_config(int34x_zone->adev->handle,
-					name,
-					&int34x_zone->act_trips[i].temp))
+		ret = thermal_acpi_trip_active(zone_adev, i, &zone_trips[trip_cnt]);
+		if (ret)
 			break;
 
-		int34x_zone->act_trips[i].id = trip_cnt++;
-		int34x_zone->act_trips[i].valid = true;
+		trip_cnt++;
 	}
 
 	return trip_cnt;
@@ -204,10 +103,12 @@ struct int34x_thermal_zone *int340x_ther
 						     int (*get_temp) (struct thermal_zone_device *, int *))
 {
 	struct int34x_thermal_zone *int34x_thermal_zone;
-	acpi_status status;
-	unsigned long long trip_cnt;
+	struct thermal_trip *zone_trips;
+	unsigned long long trip_cnt = 0;
+	unsigned long long hyst;
 	int trip_mask = 0;
-	int ret;
+	acpi_status status;
+	int i, ret;
 
 	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
 				      GFP_KERNEL);
@@ -227,33 +128,42 @@ struct int34x_thermal_zone *int340x_ther
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
+	zone_trips = kzalloc(sizeof(*zone_trips) * (trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT),
+			     GFP_KERNEL);
+	if (!zone_trips) {
+		ret = -ENOMEM;
+		goto err_trips_alloc;
+	}
+
+	for (i = 0; i < trip_cnt; i++) {
+		zone_trips[i].type = THERMAL_TRIP_PASSIVE;
+		zone_trips[i].temperature = THERMAL_TEMP_INVALID;
 	}
 
-	trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
+	trip_cnt = int340x_thermal_read_trips(adev, zone_trips, trip_cnt);
+
+	status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
+	if (ACPI_SUCCESS(status))
+		hyst *= 100;
+	else
+		hyst = 0;
+
+	for (i = 0; i < trip_cnt; ++i)
+		zone_trips[i].hysteresis = hyst;
+
+	int34x_thermal_zone->trips = zone_trips;
 
 	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
 								adev->handle);
 
-	int34x_thermal_zone->zone = thermal_zone_device_register(
+	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),
-						trip_cnt,
+						zone_trips, trip_cnt,
 						trip_mask, int34x_thermal_zone,
 						int34x_thermal_zone->ops,
 						&int340x_thermal_params,
@@ -271,9 +181,9 @@ struct int34x_thermal_zone *int340x_ther
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
@@ -286,7 +196,7 @@ void int340x_thermal_zone_remove(struct
 {
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-	kfree(int34x_thermal_zone->aux_trips);
+	kfree(int34x_thermal_zone->trips);
 	kfree(int34x_thermal_zone->ops);
 	kfree(int34x_thermal_zone);
 }
@@ -294,42 +204,41 @@ EXPORT_SYMBOL_GPL(int340x_thermal_zone_r
 
 void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
 {
-	acpi_handle zone_handle = int34x_zone->adev->handle;
-	int i, err;
+	struct acpi_device *zone_adev = int34x_zone->adev;
+	struct thermal_trip *zone_trips = int34x_zone->trips;
+	int trip_cnt = int34x_zone->zone->num_trips;
+	int act_trip_nr = 0;
+	int i;
 
 	mutex_lock(&int34x_zone->zone->lock);
 
-	if (int34x_zone->crt_trip_id > 0) {
-		err = int340x_thermal_get_trip_config(zone_handle, "_CRT",
-						      &int34x_zone->crt_temp);
-		if (err)
-			int34x_zone->crt_temp = THERMAL_TEMP_INVALID;
-	}
-
-	if (int34x_zone->hot_trip_id > 0) {
-		err = int340x_thermal_get_trip_config(zone_handle, "_HOT",
-						      &int34x_zone->hot_temp);
-		if (err)
-			int34x_zone->hot_temp = THERMAL_TEMP_INVALID;
-	}
-
-	if (int34x_zone->psv_trip_id > 0) {
-		err = int340x_thermal_get_trip_config(zone_handle, "_PSV",
-						      &int34x_zone->psv_temp);
-		if (err)
-			int34x_zone->psv_temp = THERMAL_TEMP_INVALID;
-	}
-
-	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
-
-		if (!int34x_zone->act_trips[i].valid)
+	for (i = int34x_zone->aux_trip_nr; i < trip_cnt; i++) {
+		struct thermal_trip trip;
+		int err;
+
+		switch (zone_trips[i].type) {
+		case THERMAL_TRIP_CRITICAL:
+			err = thermal_acpi_trip_critical(zone_adev, &trip);
 			break;
-
-		err = int340x_thermal_get_trip_config(zone_handle, name,
-						      &int34x_zone->act_trips[i].temp);
-		if (err)
-			int34x_zone->act_trips[i].temp = THERMAL_TEMP_INVALID;
+		case THERMAL_TRIP_HOT:
+			err = thermal_acpi_trip_hot(zone_adev, &trip);
+			break;
+		case THERMAL_TRIP_PASSIVE:
+			err = thermal_acpi_trip_passive(zone_adev, &trip);
+			break;
+		case THERMAL_TRIP_ACTIVE:
+			err = thermal_acpi_trip_active(zone_adev, act_trip_nr++,
+						       &trip);
+			break;
+		default:
+			err = -ENODEV;
+		}
+		if (err) {
+			zone_trips[i].temperature = THERMAL_TEMP_INVALID;
+			continue;
+		}
+		
+		zone_trips[i].temperature = trip.temperature;
 	}
 
 	mutex_unlock(&int34x_zone->zone->lock);
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
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



