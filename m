Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D196819E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjA3THo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbjA3THe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:34 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A9838B62;
        Mon, 30 Jan 2023 11:07:33 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 6014c07e825ce42e; Mon, 30 Jan 2023 20:07:31 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A943F2528287;
        Mon, 30 Jan 2023 20:07:30 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 5/8] thermal: intel: intel_pch: Fold two functions into their callers
Date:   Mon, 30 Jan 2023 20:03:11 +0100
Message-ID: <3662399.MHq7AAxBmi@kreacher>
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

Fold two functions, pch_hw_init() and pch_get_temp(), that each have
only one caller, into their respective callers to make the code somewhat
easier to follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   98 ++++++++++++------------------
 1 file changed, 42 insertions(+), 56 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -117,57 +117,6 @@ static int pch_wpt_add_acpi_psv_trip(str
 }
 #endif
 
-static int pch_hw_init(struct pch_thermal_device *ptd)
-{
-	int nr_trips = 0;
-	u16 trip_temp;
-	u8 tsel;
-
-	/* Check if BIOS has already enabled thermal sensor */
-	if (WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL)) {
-		ptd->bios_enabled = true;
-		goto read_trips;
-	}
-
-	tsel = readb(ptd->hw_base + WPT_TSEL);
-	/*
-	 * When TSEL's Policy Lock-Down bit is 1, TSEL become RO.
-	 * If so, thermal sensor cannot enable. Bail out.
-	 */
-	if (tsel & WPT_TSEL_PLDB) {
-		dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
-		return -ENODEV;
-	}
-
-	writeb(tsel|WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
-	if (!(WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL))) {
-		dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
-		return -ENODEV;
-	}
-
-read_trips:
-	trip_temp = readw(ptd->hw_base + WPT_CTT);
-	trip_temp &= 0x1FF;
-	if (trip_temp) {
-		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
-		ptd->trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
-	}
-
-	trip_temp = readw(ptd->hw_base + WPT_PHL);
-	trip_temp &= 0x1FF;
-	if (trip_temp) {
-		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
-		ptd->trips[nr_trips++].type = THERMAL_TRIP_HOT;
-	}
-
-	return nr_trips + pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
-}
-
-static int pch_get_temp(struct pch_thermal_device *ptd)
-{
-	return GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
-}
-
 /* Cool the PCH when it's overheat in .suspend_noirq phase */
 static int pch_suspend(struct pch_thermal_device *ptd)
 {
@@ -254,7 +203,7 @@ static int pch_thermal_get_temp(struct t
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
 
-	*temp = pch_get_temp(ptd);
+	*temp = GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 	return 0;
 }
 
@@ -310,8 +259,10 @@ static int intel_pch_thermal_probe(struc
 	enum board_ids board_id = id->driver_data;
 	const struct board_info *bi = &board_info[board_id];
 	struct pch_thermal_device *ptd;
-	int err;
+	u16 trip_temp;
 	int nr_trips;
+	u8 tsel;
+	int err;
 
 	ptd = devm_kzalloc(&pdev->dev, sizeof(*ptd), GFP_KERNEL);
 	if (!ptd)
@@ -339,12 +290,47 @@ static int intel_pch_thermal_probe(struc
 		goto error_release;
 	}
 
-	nr_trips = pch_hw_init(ptd);
-	if (nr_trips < 0) {
-		err = nr_trips;
+	/* Check if BIOS has already enabled thermal sensor */
+	if (WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL)) {
+		ptd->bios_enabled = true;
+		goto read_trips;
+	}
+
+	tsel = readb(ptd->hw_base + WPT_TSEL);
+	/*
+	 * When TSEL's Policy Lock-Down bit is 1, TSEL become RO.
+	 * If so, thermal sensor cannot enable. Bail out.
+	 */
+	if (tsel & WPT_TSEL_PLDB) {
+		dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
+		err = -ENODEV;
 		goto error_cleanup;
 	}
 
+	writeb(tsel|WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
+	if (!(WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL))) {
+		dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
+		err = -ENODEV;
+		goto error_cleanup;
+	}
+
+read_trips:
+	trip_temp = readw(ptd->hw_base + WPT_CTT);
+	trip_temp &= 0x1FF;
+	if (trip_temp) {
+		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
+	}
+
+	trip_temp = readw(ptd->hw_base + WPT_PHL);
+	trip_temp &= 0x1FF;
+	if (trip_temp) {
+		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[nr_trips++].type = THERMAL_TRIP_HOT;
+	}
+
+	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
+
 	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
 							   nr_trips, 0, ptd,
 							   &tzd_ops, NULL, 0, 0);



