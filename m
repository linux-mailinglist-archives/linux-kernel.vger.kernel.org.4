Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8F6B7A74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCMOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjCMOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:34:39 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6959B234D6;
        Mon, 13 Mar 2023 07:34:38 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 59da252f0a8029b0; Mon, 13 Mar 2023 15:34:36 +0100
Received: from kreacher.localnet (unknown [213.134.189.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 082459C5854;
        Mon, 13 Mar 2023 15:34:35 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quanxian Wang <quanxian.wang@intel.com>
Subject: [PATCH v2 2/4] thermal: core: Introduce thermal_cooling_device_present()
Date:   Mon, 13 Mar 2023 15:28:08 +0100
Message-ID: <4488488.LvFx2qVVIh@kreacher>
In-Reply-To: <2692681.mvXUDI8C0e@kreacher>
References: <2692681.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.189.11
X-CLIENT-HOSTNAME: 213.134.189.11
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukeelrdduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeelrdduuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 uggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a helper function, thermal_cooling_device_present(), for
checking if the given cooling device is in the list of registered
cooling devices to avoid some code duplication in a subsequent
patch.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1045,6 +1045,18 @@ devm_thermal_of_cooling_device_register(
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
 
+static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
+{
+	struct thermal_cooling_device *pos = NULL;
+
+	list_for_each_entry(pos, &thermal_cdev_list, node) {
+		if (pos == cdev)
+			return true;
+	}
+
+	return false;
+}
+
 static void __unbind(struct thermal_zone_device *tz, int mask,
 		     struct thermal_cooling_device *cdev)
 {
@@ -1067,20 +1079,17 @@ void thermal_cooling_device_unregister(s
 	int i;
 	const struct thermal_zone_params *tzp;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *pos = NULL;
 
 	if (!cdev)
 		return;
 
 	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(pos, &thermal_cdev_list, node)
-		if (pos == cdev)
-			break;
-	if (pos != cdev) {
-		/* thermal cooling device not found */
+
+	if (!thermal_cooling_device_present(cdev)) {
 		mutex_unlock(&thermal_list_lock);
 		return;
 	}
+
 	list_del(&cdev->node);
 
 	/* Unbind all thermal zones associated with 'this' cdev */



