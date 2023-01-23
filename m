Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E82678521
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjAWSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAWSlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:41:51 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464826848;
        Mon, 23 Jan 2023 10:41:42 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 81a3920b434318b1; Mon, 23 Jan 2023 19:41:40 +0100
Received: from kreacher.localnet (unknown [213.134.188.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2267E213259F;
        Mon, 23 Jan 2023 19:41:40 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v7 2/3] thermal: intel: intel_pch: Use generic trip points
Date:   Mon, 23 Jan 2023 19:40:33 +0100
Message-ID: <4790872.GXAFRqVoOG@kreacher>
In-Reply-To: <5916342.lOV4Wx5bFT@kreacher>
References: <5916342.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.170
X-CLIENT-HOSTNAME: 213.134.188.170
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekkedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeekrddujedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghr
 rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The thermal framework gives the possibility to register the trip
points along with the thermal zone.  When that is done, no get_trip_*
callbacks are needed and they can be removed.

Convert the existing callbacks content logic into generic trip points
initialization code and register them along with the thermal zone.

In order to consolidate the code, use an ACPI trip library function
to populate a generic trip point.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
[ rjw: Subject and changelog edits, rebase ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/Kconfig             |    1 
 drivers/thermal/intel/intel_pch_thermal.c |   88 ++++++------------------------
 2 files changed, 20 insertions(+), 69 deletions(-)

Index: linux-pm/drivers/thermal/intel/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/intel/Kconfig
+++ linux-pm/drivers/thermal/intel/Kconfig
@@ -81,6 +81,7 @@ config INTEL_BXT_PMIC_THERMAL
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
 	depends on X86 && PCI
+	select THERMAL_ACPI if ACPI
 	help
 	  Enable this to support thermal reporting on certain intel PCHs.
 	  Thermal reporting device will provide temperature reading,
Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -65,6 +65,8 @@
 #define WPT_TEMP_OFFSET	(PCH_TEMP_OFFSET * MILLIDEGREE_PER_DEGREE)
 #define GET_PCH_TEMP(x)	(((x) / 2) + PCH_TEMP_OFFSET)
 
+#define PCH_MAX_TRIPS 3 /* critical, hot, passive */
+
 /* Amount of time for each cooling delay, 100ms by default for now */
 static unsigned int delay_timeout = 100;
 module_param(delay_timeout, int, 0644);
@@ -82,12 +84,7 @@ struct pch_thermal_device {
 	const struct pch_dev_ops *ops;
 	struct pci_dev *pdev;
 	struct thermal_zone_device *tzd;
-	int crt_trip_id;
-	unsigned long crt_temp;
-	int hot_trip_id;
-	unsigned long hot_temp;
-	int psv_trip_id;
-	unsigned long psv_temp;
+	struct thermal_trip trips[PCH_MAX_TRIPS];
 	bool bios_enabled;
 };
 
@@ -102,33 +99,22 @@ static void pch_wpt_add_acpi_psv_trip(st
 				      int *nr_trips)
 {
 	struct acpi_device *adev;
-
-	ptd->psv_trip_id = -1;
+	int ret;
 
 	adev = ACPI_COMPANION(&ptd->pdev->dev);
-	if (adev) {
-		unsigned long long r;
-		acpi_status status;
-
-		status = acpi_evaluate_integer(adev->handle, "_PSV", NULL,
-					       &r);
-		if (ACPI_SUCCESS(status)) {
-			unsigned long trip_temp;
-
-			trip_temp = deci_kelvin_to_millicelsius(r);
-			if (trip_temp) {
-				ptd->psv_temp = trip_temp;
-				ptd->psv_trip_id = *nr_trips;
-				++(*nr_trips);
-			}
-		}
-	}
+	if (!adev)
+		return;
+
+	ret = thermal_acpi_trip_passive(adev, &ptd->trips[*nr_trips]);
+	if (ret)
+		return;
+
+	++(*nr_trips);
 }
 #else
 static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 				      int *nr_trips)
 {
-	ptd->psv_trip_id = -1;
 
 }
 #endif
@@ -163,21 +149,19 @@ static int pch_wpt_init(struct pch_therm
 	}
 
 read_trips:
-	ptd->crt_trip_id = -1;
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->crt_temp = GET_WPT_TEMP(trip_temp);
-		ptd->crt_trip_id = 0;
+		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[*nr_trips].type = THERMAL_TRIP_CRITICAL;
 		++(*nr_trips);
 	}
 
-	ptd->hot_trip_id = -1;
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->hot_temp = GET_WPT_TEMP(trip_temp);
-		ptd->hot_trip_id = *nr_trips;
+		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[*nr_trips].type = THERMAL_TRIP_HOT;
 		++(*nr_trips);
 	}
 
@@ -298,39 +282,6 @@ static int pch_thermal_get_temp(struct t
 	return	ptd->ops->get_temp(ptd, temp);
 }
 
-static int pch_get_trip_type(struct thermal_zone_device *tzd, int trip,
-			     enum thermal_trip_type *type)
-{
-	struct pch_thermal_device *ptd = tzd->devdata;
-
-	if (ptd->crt_trip_id == trip)
-		*type = THERMAL_TRIP_CRITICAL;
-	else if (ptd->hot_trip_id == trip)
-		*type = THERMAL_TRIP_HOT;
-	else if (ptd->psv_trip_id == trip)
-		*type = THERMAL_TRIP_PASSIVE;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *temp)
-{
-	struct pch_thermal_device *ptd = tzd->devdata;
-
-	if (ptd->crt_trip_id == trip)
-		*temp = ptd->crt_temp;
-	else if (ptd->hot_trip_id == trip)
-		*temp = ptd->hot_temp;
-	else if (ptd->psv_trip_id == trip)
-		*temp = ptd->psv_temp;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static void pch_critical(struct thermal_zone_device *tzd)
 {
 	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
@@ -338,8 +289,6 @@ static void pch_critical(struct thermal_
 
 static struct thermal_zone_device_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
-	.get_trip_type = pch_get_trip_type,
-	.get_trip_temp = pch_get_trip_temp,
 	.critical = pch_critical,
 };
 
@@ -423,8 +372,9 @@ static int intel_pch_thermal_probe(struc
 	if (err)
 		goto error_cleanup;
 
-	ptd->tzd = thermal_zone_device_register(bi->name, nr_trips, 0, ptd,
-						&tzd_ops, NULL, 0, 0);
+	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
+							   nr_trips, 0, ptd,
+							   &tzd_ops, NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
 			bi->name);



