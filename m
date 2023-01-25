Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFAF67B535
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbjAYO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjAYOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:55:46 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F34ED0;
        Wed, 25 Jan 2023 06:55:41 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id b6f9cb71624b5631; Wed, 25 Jan 2023 15:55:39 +0100
Received: from kreacher.localnet (unknown [213.134.163.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 195B72201948;
        Wed, 25 Jan 2023 15:55:39 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/3] thermal: intel: int340x: Rework updating trip points
Date:   Wed, 25 Jan 2023 15:52:25 +0100
Message-ID: <4481198.LvFx2qVVIh@kreacher>
In-Reply-To: <5665899.DvuYhMxLoT@kreacher>
References: <5665899.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.149
X-CLIENT-HOSTNAME: 213.134.163.149
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduieefrddugeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrudegledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
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

It is generally invalid to change the trip point indices after they have
been exposed via sysfs.

Moreover, the thermal objects in the ACPI namespace cannot go away and
appear on the fly.  In practice, the only thing that can happen when the
INT3403_PERF_TRIP_POINT_CHANGED notification is sent by the platform
firmware is a change of the return values of those thermal objects.

For this reason, add a special function for updating the trip point
temperatures after re-evaluating the respective ACPI thermal objects
and change int3403_notify() to invoke it instead of
int340x_thermal_read_trips() that would change the trip point indices
on errors.  Also remove the locking from the latter, because it is only
called before registering the thermal zone and it cannot race with the
zone's callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c      |    2 
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   51 +++++++++--
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h |    2 
 3 files changed, 47 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -168,13 +168,11 @@ static int int340x_thermal_get_trip_conf
 	return 0;
 }
 
-int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
+static int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
 {
 	int trip_cnt = int34x_zone->aux_trip_nr;
 	int i;
 
-	mutex_lock(&int34x_zone->trip_mutex);
-
 	int34x_zone->crt_trip_id = -1;
 	if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
 					     &int34x_zone->crt_temp))
@@ -202,11 +200,8 @@ int int340x_thermal_read_trips(struct in
 		int34x_zone->act_trips[i].valid = true;
 	}
 
-	mutex_unlock(&int34x_zone->trip_mutex);
-
 	return trip_cnt;
 }
-EXPORT_SYMBOL_GPL(int340x_thermal_read_trips);
 
 static struct thermal_zone_params int340x_thermal_params = {
 	.governor_name = "user_space",
@@ -309,6 +304,50 @@ void int340x_thermal_zone_remove(struct
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
 
+void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
+{
+	acpi_handle zone_handle = int34x_zone->adev->handle;
+	int i, err;
+
+	mutex_lock(&int34x_zone->trip_mutex);
+
+	if (int34x_zone->crt_trip_id > 0) {
+		err = int340x_thermal_get_trip_config(zone_handle, "_CRT",
+						      &int34x_zone->crt_temp);
+		if (err)
+			int34x_zone->crt_temp = THERMAL_TEMP_INVALID;
+	}
+
+	if (int34x_zone->hot_trip_id > 0) {
+		err = int340x_thermal_get_trip_config(zone_handle, "_HOT",
+						      &int34x_zone->hot_temp);
+		if (err)
+			int34x_zone->hot_temp = THERMAL_TEMP_INVALID;
+	}
+
+	if (int34x_zone->psv_trip_id > 0) {
+		err = int340x_thermal_get_trip_config(zone_handle, "_PSV",
+						      &int34x_zone->psv_temp);
+		if (err)
+			int34x_zone->psv_temp = THERMAL_TEMP_INVALID;
+	}
+
+	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
+		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
+
+		if (!int34x_zone->act_trips[i].valid)
+			break;
+
+		err = int340x_thermal_get_trip_config(zone_handle, name,
+						      &int34x_zone->act_trips[i].temp);
+		if (err)
+			int34x_zone->act_trips[i].temp = THERMAL_TEMP_INVALID;
+	}
+
+	mutex_unlock(&int34x_zone->trip_mutex);
+}
+EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
+
 MODULE_AUTHOR("Aaron Lu <aaron.lu@intel.com>");
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Intel INT340x common thermal zone handler");
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -69,7 +69,7 @@ static void int3403_notify(acpi_handle h
 						   THERMAL_TRIP_VIOLATED);
 		break;
 	case INT3403_PERF_TRIP_POINT_CHANGED:
-		int340x_thermal_read_trips(obj->int340x_zone);
+		int340x_thermal_update_trips(obj->int340x_zone);
 		int340x_thermal_zone_device_update(obj->int340x_zone,
 						   THERMAL_TRIP_CHANGED);
 		break;
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -38,7 +38,7 @@ struct int34x_thermal_zone {
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
 				int (*get_temp) (struct thermal_zone_device *, int *));
 void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
-int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone);
+void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone);
 
 static inline void int340x_thermal_zone_set_priv_data(
 			struct int34x_thermal_zone *tzone, void *priv_data)



