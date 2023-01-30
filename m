Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEE6819F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjA3TIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbjA3THn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:43 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82483B3F7;
        Mon, 30 Jan 2023 11:07:37 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 122e913e5c33ba76; Mon, 30 Jan 2023 20:07:36 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 35ED32528287;
        Mon, 30 Jan 2023 20:07:35 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 2/8] thermal: intel: intel_pch: Eliminate redundant return pointers
Date:   Mon, 30 Jan 2023 19:59:48 +0100
Message-ID: <1847763.CQOukoFCf9@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
References: <1751684.VLH7GnMWUR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.112
X-CLIENT-HOSTNAME: 213.134.169.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduuddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogieslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both pch_wpt_init() and pch_wpt_get_temp() can return the proper
result via their return values, so they do not need to use return
pointers.

Modify them accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   40 +++++++++++++-----------------
 1 file changed, 18 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -118,12 +118,11 @@ static int pch_wpt_add_acpi_psv_trip(str
 }
 #endif
 
-static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
+static int pch_wpt_init(struct pch_thermal_device *ptd)
 {
-	u8 tsel;
+	int nr_trips = 0;
 	u16 trip_temp;
-
-	*nr_trips = 0;
+	u8 tsel;
 
 	/* Check if BIOS has already enabled thermal sensor */
 	if (WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL)) {
@@ -151,29 +150,23 @@ read_trips:
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
-		ptd->trips[*nr_trips].type = THERMAL_TRIP_CRITICAL;
-		++(*nr_trips);
+		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
 	}
 
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
-		ptd->trips[*nr_trips].type = THERMAL_TRIP_HOT;
-		++(*nr_trips);
+		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[nr_trips++].type = THERMAL_TRIP_HOT;
 	}
 
-	*nr_trips += pch_wpt_add_acpi_psv_trip(ptd, *nr_trips);
-
-	return 0;
+	return nr_trips + pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
 }
 
-static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
+static int pch_wpt_get_temp(struct pch_thermal_device *ptd)
 {
-	*temp = GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
-
-	return 0;
+	return GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 }
 
 /* Cool the PCH when it's overheat in .suspend_noirq phase */
@@ -259,8 +252,8 @@ static int pch_wpt_resume(struct pch_the
 }
 
 struct pch_dev_ops {
-	int (*hw_init)(struct pch_thermal_device *ptd, int *nr_trips);
-	int (*get_temp)(struct pch_thermal_device *ptd, int *temp);
+	int (*hw_init)(struct pch_thermal_device *ptd);
+	int (*get_temp)(struct pch_thermal_device *ptd);
 	int (*suspend)(struct pch_thermal_device *ptd);
 	int (*resume)(struct pch_thermal_device *ptd);
 };
@@ -278,7 +271,8 @@ static int pch_thermal_get_temp(struct t
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
 
-	return	ptd->ops->get_temp(ptd, temp);
+	*temp = ptd->ops->get_temp(ptd);
+	return 0;
 }
 
 static void pch_critical(struct thermal_zone_device *tzd)
@@ -372,9 +366,11 @@ static int intel_pch_thermal_probe(struc
 		goto error_release;
 	}
 
-	err = ptd->ops->hw_init(ptd, &nr_trips);
-	if (err)
+	nr_trips = ptd->ops->hw_init(ptd);
+	if (nr_trips < 0) {
+		err = nr_trips;
 		goto error_cleanup;
+	}
 
 	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
 							   nr_trips, 0, ptd,



