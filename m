Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3086819EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbjA3THq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjA3THg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:07:36 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297A39CF7;
        Mon, 30 Jan 2023 11:07:34 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 198d550b42cf78cc; Mon, 30 Jan 2023 20:07:32 +0100
Received: from kreacher.localnet (unknown [213.134.169.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 03D332528287;
        Mon, 30 Jan 2023 20:07:31 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v1 4/8] thermal: intel: intel_pch: Eliminate device operations object
Date:   Mon, 30 Jan 2023 20:02:19 +0100
Message-ID: <2141577.Mh6RI2rZIc@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
References: <1751684.VLH7GnMWUR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.112
X-CLIENT-HOSTNAME: 213.134.169.112
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudeiledrudduvdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdduuddvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
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

The same device operations object is pointed to by all of the board
configurations in the driver, so effectively the same operations
callbacks are used by all of them which only adds overhead (that can
be significant due to retpolines) for no real purpose.

For this reason, drop the device operations object and replace the
respective callback invocations by direct calls to the specific
functions that were previously pointed to by callback pointers.

No intentional change in behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |   33 +++---------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -82,7 +82,6 @@ static char driver_name[] = "Intel PCH t
 
 struct pch_thermal_device {
 	void __iomem *hw_base;
-	const struct pch_dev_ops *ops;
 	struct pci_dev *pdev;
 	struct thermal_zone_device *tzd;
 	struct thermal_trip trips[PCH_MAX_TRIPS];
@@ -251,25 +250,11 @@ static int pch_resume(struct pch_thermal
 	return 0;
 }
 
-struct pch_dev_ops {
-	int (*hw_init)(struct pch_thermal_device *ptd);
-	int (*get_temp)(struct pch_thermal_device *ptd);
-	int (*suspend)(struct pch_thermal_device *ptd);
-	int (*resume)(struct pch_thermal_device *ptd);
-};
-
-static const struct pch_dev_ops pch_dev_ops = {
-	.hw_init = pch_hw_init,
-	.get_temp = pch_get_temp,
-	.suspend = pch_suspend,
-	.resume = pch_resume,
-};
-
 static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	struct pch_thermal_device *ptd = tzd->devdata;
 
-	*temp = ptd->ops->get_temp(ptd);
+	*temp = pch_get_temp(ptd);
 	return 0;
 }
 
@@ -295,35 +280,27 @@ enum board_ids {
 
 static const struct board_info {
 	const char *name;
-	const struct pch_dev_ops *ops;
 } board_info[] = {
 	[board_hsw] = {
 		.name = "pch_haswell",
-		.ops = &pch_dev_ops,
 	},
 	[board_wpt] = {
 		.name = "pch_wildcat_point",
-		.ops = &pch_dev_ops,
 	},
 	[board_skl] = {
 		.name = "pch_skylake",
-		.ops = &pch_dev_ops,
 	},
 	[board_cnl] = {
 		.name = "pch_cannonlake",
-		.ops = &pch_dev_ops,
 	},
 	[board_cml] = {
 		.name = "pch_cometlake",
-		.ops = &pch_dev_ops,
 	},
 	[board_lwb] = {
 		.name = "pch_lewisburg",
-		.ops = &pch_dev_ops,
 	},
 	[board_wbg] = {
 		.name = "pch_wellsburg",
-		.ops = &pch_dev_ops,
 	},
 };
 
@@ -340,8 +317,6 @@ static int intel_pch_thermal_probe(struc
 	if (!ptd)
 		return -ENOMEM;
 
-	ptd->ops = bi->ops;
-
 	pci_set_drvdata(pdev, ptd);
 	ptd->pdev = pdev;
 
@@ -364,7 +339,7 @@ static int intel_pch_thermal_probe(struc
 		goto error_release;
 	}
 
-	nr_trips = ptd->ops->hw_init(ptd);
+	nr_trips = pch_hw_init(ptd);
 	if (nr_trips < 0) {
 		err = nr_trips;
 		goto error_cleanup;
@@ -412,14 +387,14 @@ static int intel_pch_thermal_suspend_noi
 {
 	struct pch_thermal_device *ptd = dev_get_drvdata(device);
 
-	return ptd->ops->suspend(ptd);
+	return pch_suspend(ptd);
 }
 
 static int intel_pch_thermal_resume(struct device *device)
 {
 	struct pch_thermal_device *ptd = dev_get_drvdata(device);
 
-	return ptd->ops->resume(ptd);
+	return pch_resume(ptd);
 }
 
 static const struct pci_device_id intel_pch_thermal_id[] = {



