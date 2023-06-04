Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90D7216D9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjFDMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjFDMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:21:25 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63378CA;
        Sun,  4 Jun 2023 05:21:23 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id f9566b58db2df641; Sun, 4 Jun 2023 14:21:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4FC29963C55;
        Sun,  4 Jun 2023 14:21:21 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 5/7] ACPI: thermal: Eliminate struct acpi_thermal_state_flags
Date:   Sun, 04 Jun 2023 14:18:05 +0200
Message-ID: <3186378.5fSG56mABF@kreacher>
In-Reply-To: <2703629.mvXUDI8C0e@kreacher>
References: <2703629.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehm
 ihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the enabled flag is only needed for active trip points,
so drop struct acpi_thermal_state_flags, add a simple "bool valid" field
to the definitions of all trip point structures instead of flags and
add a "bool enabled" field to struct acpi_thermal_active.

Adjust the code using the modified structures accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
---

v1 -> v2:
   * Added R-by from Michal.
   * Replaced 0 with "false" in one assignment overlooked previously.

---
 drivers/acpi/thermal.c |  132 +++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 68 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -105,35 +105,30 @@ struct acpi_thermal_state {
 	int active_index;
 };
 
-struct acpi_thermal_state_flags {
-	u8 valid:1;
-	u8 enabled:1;
-	u8 reserved:6;
-};
-
 struct acpi_thermal_critical {
-	struct acpi_thermal_state_flags flags;
 	unsigned long temperature;
+	bool valid;
 };
 
 struct acpi_thermal_hot {
-	struct acpi_thermal_state_flags flags;
 	unsigned long temperature;
+	bool valid;
 };
 
 struct acpi_thermal_passive {
-	struct acpi_thermal_state_flags flags;
+	struct acpi_handle_list devices;
 	unsigned long temperature;
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
-	struct acpi_handle_list devices;
+	bool valid;
 };
 
 struct acpi_thermal_active {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
 	struct acpi_handle_list devices;
+	unsigned long temperature;
+	bool valid;
+	bool enabled;
 };
 
 struct acpi_thermal_trips {
@@ -229,7 +224,7 @@ static int acpi_thermal_trips_update(str
 	acpi_status status;
 	unsigned long long tmp;
 	struct acpi_handle_list devices;
-	int valid = 0;
+	bool valid = false;
 	int i;
 
 	/* Critical Shutdown */
@@ -243,21 +238,21 @@ static int acpi_thermal_trips_update(str
 		 * ... so lets discard those as invalid.
 		 */
 		if (ACPI_FAILURE(status)) {
-			tz->trips.critical.flags.valid = 0;
+			tz->trips.critical.valid = false;
 			acpi_handle_debug(tz->device->handle,
 					  "No critical threshold\n");
 		} else if (tmp <= 2732) {
 			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
-			tz->trips.critical.flags.valid = 0;
+			tz->trips.critical.valid = false;
 		} else {
-			tz->trips.critical.flags.valid = 1;
+			tz->trips.critical.valid = true;
 			acpi_handle_debug(tz->device->handle,
 					  "Found critical threshold [%lu]\n",
 					  tz->trips.critical.temperature);
 		}
-		if (tz->trips.critical.flags.valid) {
+		if (tz->trips.critical.valid) {
 			if (crt == -1) {
-				tz->trips.critical.flags.valid = 0;
+				tz->trips.critical.valid = false;
 			} else if (crt > 0) {
 				unsigned long crt_k = celsius_to_deci_kelvin(crt);
 
@@ -276,12 +271,12 @@ static int acpi_thermal_trips_update(str
 	if (flag & ACPI_TRIPS_HOT) {
 		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
-			tz->trips.hot.flags.valid = 0;
+			tz->trips.hot.valid = false;
 			acpi_handle_debug(tz->device->handle,
 					  "No hot threshold\n");
 		} else {
 			tz->trips.hot.temperature = tmp;
-			tz->trips.hot.flags.valid = 1;
+			tz->trips.hot.valid = true;
 			acpi_handle_debug(tz->device->handle,
 					  "Found hot threshold [%lu]\n",
 					  tz->trips.hot.temperature);
@@ -289,9 +284,9 @@ static int acpi_thermal_trips_update(str
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.valid) ||
 	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->trips.passive.flags.valid;
+		valid = tz->trips.passive.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -303,44 +298,44 @@ static int acpi_thermal_trips_update(str
 		}
 
 		if (ACPI_FAILURE(status)) {
-			tz->trips.passive.flags.valid = 0;
+			tz->trips.passive.valid = false;
 		} else {
 			tz->trips.passive.temperature = tmp;
-			tz->trips.passive.flags.valid = 1;
+			tz->trips.passive.valid = true;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC1", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->trips.passive.valid = false;
 				else
 					tz->trips.passive.tc1 = tmp;
 
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC2", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->trips.passive.valid = false;
 				else
 					tz->trips.passive.tc2 = tmp;
 
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TSP", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.flags.valid = 0;
+					tz->trips.passive.valid = false;
 				else
 					tz->trips.passive.tsp = tmp;
 			}
 		}
 	}
-	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.flags.valid) {
+	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 						 NULL, &devices);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(tz->device->handle,
 					 "Invalid passive threshold\n");
-			tz->trips.passive.flags.valid = 0;
+			tz->trips.passive.valid = false;
 		} else {
-			tz->trips.passive.flags.valid = 1;
+			tz->trips.passive.valid = true;
 		}
 
 		if (memcmp(&tz->trips.passive.devices, &devices,
@@ -351,24 +346,24 @@ static int acpi_thermal_trips_update(str
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
-		if (valid != tz->trips.passive.flags.valid)
+		if (valid != tz->trips.passive.valid)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
 	/* Active (optional) */
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
-		valid = tz->trips.active[i].flags.valid;
+		valid = tz->trips.active[i].valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
 		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->trips.active[i].flags.valid)) {
+		    tz->trips.active[i].valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
-				tz->trips.active[i].flags.valid = 0;
+				tz->trips.active[i].valid = false;
 				if (i == 0)
 					break;
 
@@ -390,21 +385,21 @@ static int acpi_thermal_trips_update(str
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
-				tz->trips.active[i].flags.valid = 1;
+				tz->trips.active[i].valid = true;
 			}
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].flags.valid) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].valid) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
-				tz->trips.active[i].flags.valid = 0;
+				tz->trips.active[i].valid = false;
 			} else {
-				tz->trips.active[i].flags.valid = 1;
+				tz->trips.active[i].valid = true;
 			}
 
 			if (memcmp(&tz->trips.active[i].devices, &devices,
@@ -415,10 +410,10 @@ static int acpi_thermal_trips_update(str
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
-			if (valid != tz->trips.active[i].flags.valid)
+			if (valid != tz->trips.active[i].valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->trips.active[i].valid)
 			break;
 	}
 
@@ -438,17 +433,18 @@ static int acpi_thermal_trips_update(str
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	int i, valid, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+	int i, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+	bool valid;
 
 	if (ret)
 		return ret;
 
-	valid = tz->trips.critical.flags.valid |
-		tz->trips.hot.flags.valid |
-		tz->trips.passive.flags.valid;
+	valid = tz->trips.critical.valid |
+		tz->trips.hot.valid |
+		tz->trips.passive.valid;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid |= tz->trips.active[i].flags.valid;
+		valid = valid || tz->trips.active[i].valid;
 
 	if (!valid) {
 		pr_warn(FW_BUG "No valid trip found\n");
@@ -485,7 +481,7 @@ static int thermal_get_trip_type(struct
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->trips.critical.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_CRITICAL;
 			return 0;
@@ -493,7 +489,7 @@ static int thermal_get_trip_type(struct
 		trip--;
 	}
 
-	if (tz->trips.hot.flags.valid) {
+	if (tz->trips.hot.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_HOT;
 			return 0;
@@ -501,7 +497,7 @@ static int thermal_get_trip_type(struct
 		trip--;
 	}
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->trips.passive.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -509,7 +505,7 @@ static int thermal_get_trip_type(struct
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].flags.valid; i++) {
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -529,7 +525,7 @@ static int thermal_get_trip_temp(struct
 	if (!tz || trip < 0)
 		return -EINVAL;
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->trips.critical.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->trips.critical.temperature,
@@ -539,7 +535,7 @@ static int thermal_get_trip_temp(struct
 		trip--;
 	}
 
-	if (tz->trips.hot.flags.valid) {
+	if (tz->trips.hot.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->trips.hot.temperature,
@@ -549,7 +545,7 @@ static int thermal_get_trip_temp(struct
 		trip--;
 	}
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->trips.passive.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->trips.passive.temperature,
@@ -560,7 +556,7 @@ static int thermal_get_trip_temp(struct
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].flags.valid; i++) {
+		tz->trips.active[i].valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->trips.active[i].temperature,
@@ -578,7 +574,7 @@ static int thermal_get_crit_temp(struct
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
 
-	if (tz->trips.critical.flags.valid) {
+	if (tz->trips.critical.valid) {
 		*temperature = deci_kelvin_to_millicelsius_with_offset(
 					tz->trips.critical.temperature,
 					tz->kelvin_offset);
@@ -664,13 +660,13 @@ static int acpi_thermal_cooling_device_c
 	int trip = -1;
 	int result = 0;
 
-	if (tz->trips.critical.flags.valid)
+	if (tz->trips.critical.valid)
 		trip++;
 
-	if (tz->trips.hot.flags.valid)
+	if (tz->trips.hot.valid)
 		trip++;
 
-	if (tz->trips.passive.flags.valid) {
+	if (tz->trips.passive.valid) {
 		trip++;
 		for (i = 0; i < tz->trips.passive.devices.count; i++) {
 			handle = tz->trips.passive.devices.handles[i];
@@ -695,7 +691,7 @@ static int acpi_thermal_cooling_device_c
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->trips.active[i].valid)
 			break;
 
 		trip++;
@@ -783,19 +779,19 @@ static int acpi_thermal_register_thermal
 	acpi_status status;
 	int i;
 
-	if (tz->trips.critical.flags.valid)
+	if (tz->trips.critical.valid)
 		trips++;
 
-	if (tz->trips.hot.flags.valid)
+	if (tz->trips.hot.valid)
 		trips++;
 
-	if (tz->trips.passive.flags.valid)
+	if (tz->trips.passive.valid)
 		trips++;
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].flags.valid;
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid;
 	     i++, trips++);
 
-	if (tz->trips.passive.flags.valid)
+	if (tz->trips.passive.valid)
 		tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
 								&acpi_thermal_zone_ops, NULL,
 								tz->trips.passive.tsp * 100,
@@ -965,7 +961,7 @@ static int acpi_thermal_get_info(struct
  */
 static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
-	if (tz->trips.critical.flags.valid &&
+	if (tz->trips.critical.valid &&
 	    (tz->trips.critical.temperature % 5) == 1)
 		tz->kelvin_offset = 273100;
 	else
@@ -1074,20 +1070,20 @@ static int acpi_thermal_resume(struct de
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].flags.valid)
+		if (!tz->trips.active[i].valid)
 			break;
 
-		tz->trips.active[i].flags.enabled = 1;
+		tz->trips.active[i].enabled = true;
 		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
 			result = acpi_bus_update_power(
 					tz->trips.active[i].devices.handles[j],
 					&power_state);
 			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->trips.active[i].flags.enabled = 0;
+				tz->trips.active[i].enabled = false;
 				break;
 			}
 		}
-		tz->state.active |= tz->trips.active[i].flags.enabled;
+		tz->state.active |= tz->trips.active[i].enabled;
 	}
 
 	acpi_queue_thermal_check(tz);



