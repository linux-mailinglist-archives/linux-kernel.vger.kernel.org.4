Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3267A28D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjAXTT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjAXTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:19:18 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D154F370;
        Tue, 24 Jan 2023 11:19:15 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 1ca963bc24d3b939; Tue, 24 Jan 2023 20:19:13 +0100
Received: from kreacher.localnet (unknown [213.134.189.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F024C7A644A;
        Tue, 24 Jan 2023 20:19:12 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/6] thermal: intel: int340x: Assorted minor cleanups
Date:   Tue, 24 Jan 2023 20:13:44 +0100
Message-ID: <4795442.GXAFRqVoOG@kreacher>
In-Reply-To: <12159228.O9o76ZdvQC@kreacher>
References: <12159228.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.30
X-CLIENT-HOSTNAME: 213.134.189.30
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekledrfedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekledrfedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthho
 pehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Improve some inconsistent usage of white space in int340x_thermal_zone.c,
fix up one coding style issue in it (missing braces around an else
branch of a conditional) and while at it replace a !ACPI_FAILURE()
check with an equivalent ACPI_SUCCESS() one.

Also add INT340X_THERMAL_MAX_TRIP_COUNT to trip_cnt before using it
for the allocation of trips for more clarity.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   22 +++++------
 1 file changed, 10 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -30,10 +30,10 @@ static int int340x_thermal_get_zone_temp
 			return conv_temp;
 
 		*temp = (unsigned long)conv_temp * 10;
-	} else
+	} else {
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
 		*temp = deci_kelvin_to_millicelsius(tmp);
-
+	}
 	return 0;
 }
 
@@ -46,7 +46,7 @@ static int int340x_thermal_set_trip_temp
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			millicelsius_to_deci_kelvin(temp));
+					    millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -99,7 +99,6 @@ int int340x_thermal_read_trips(struct in
 		trip_cnt++;
 
 	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
-
 		ret = thermal_acpi_trip_active(int34x_zone->adev, i, &int34x_zone->trips[trip_cnt]);
 		if (ret)
 			break;
@@ -125,8 +124,7 @@ struct int34x_thermal_zone *int340x_ther
 	acpi_status status;
 	int i, ret;
 
-	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
-				      GFP_KERNEL);
+	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone), GFP_KERNEL);
 	if (!int34x_thermal_zone)
 		return ERR_PTR(-ENOMEM);
 
@@ -143,14 +141,15 @@ struct int34x_thermal_zone *int340x_ther
 		int34x_thermal_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (!ACPI_FAILURE(status)) {
+	if (ACPI_SUCCESS(status)) {
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
 		trip_mask = BIT(trip_cnt) - 1;
 	}
 
-	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
-					     (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
-					      GFP_KERNEL);
+	trip_cnt += INT340X_THERMAL_MAX_TRIP_COUNT;
+
+	int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) * trip_cnt,
+					     GFP_KERNEL);
 	if (!int34x_thermal_zone->trips) {
 		ret = -ENOMEM;
 		goto err_trips_alloc;
@@ -166,8 +165,7 @@ struct int34x_thermal_zone *int340x_ther
 		int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
 	}
 
-	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
-								adev->handle);
+	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
 	int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
 						acpi_device_bid(adev),



