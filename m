Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D576CCA29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjC1Snz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjC1Sny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:43:54 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E402121;
        Tue, 28 Mar 2023 11:43:30 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 81b377ba140dd037; Tue, 28 Mar 2023 20:43:28 +0200
Received: from kreacher.localnet (unknown [213.134.169.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 72F1578215F;
        Tue, 28 Mar 2023 20:43:27 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Imre Deak <imre.deak@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1] thermal: core: Drop excessive lockdep_assert_held() calls
Date:   Tue, 28 Mar 2023 20:43:26 +0200
Message-ID: <2681615.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.43
X-CLIENT-HOSTNAME: 213.134.169.43
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduieelrdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdegfedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehimhhrvgdruggvrghksehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The lockdep_assert_held() calls added to cooling_device_stats_setup()
and cooling_device_stats_destroy() by commit 790930f44289 ("thermal:
core: Introduce thermal_cooling_device_update()") trigger false-positive
lockdep reports in code paths that are not subject to race conditions
(before cooling device registration and after cooling device removal).

For this reason, remove the lockdep_assert_held() calls from both
cooling_device_stats_setup() and cooling_device_stats_destroy() and
add one to thermal_cooling_device_stats_reinit() that has to be called
under the cdev lock.

Fixes: 790930f44289 ("thermal: core: Introduce thermal_cooling_device_update()")
Link: https://lore.kernel.org/linux-acpi/ZCIDTLFt27Ei7+V6@ideak-desk.fi.intel.com
Reported-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -876,8 +876,6 @@ static void cooling_device_stats_setup(s
 	unsigned long states = cdev->max_state + 1;
 	int var;
 
-	lockdep_assert_held(&cdev->lock);
-
 	var = sizeof(*stats);
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
@@ -903,8 +901,6 @@ out:
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
-	lockdep_assert_held(&cdev->lock);
-
 	kfree(cdev->stats);
 	cdev->stats = NULL;
 }
@@ -931,6 +927,8 @@ void thermal_cooling_device_destroy_sysf
 
 void thermal_cooling_device_stats_reinit(struct thermal_cooling_device *cdev)
 {
+	lockdep_assert_held(&cdev->lock);
+
 	cooling_device_stats_destroy(cdev);
 	cooling_device_stats_setup(cdev);
 }



