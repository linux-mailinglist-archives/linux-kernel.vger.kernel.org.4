Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5557118EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbjEYVRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbjEYVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00823194;
        Thu, 25 May 2023 14:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9177A64B2D;
        Thu, 25 May 2023 21:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C0C433D2;
        Thu, 25 May 2023 21:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685049436;
        bh=gEZ02IzSGf5PaaA4CSw9rHnl4VSwKJa0glxNZVbO8yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ9cqp2i9MJ3BusPvHZ9HnVnuVpootCBf3eMhWPE5KFV12zK+eelDr4Xfo20BjHHX
         WM+NMD6XNdVhuH7cC7FQe7d2aWlaVhi/yO/jtBmTeA1fn+L1c0CW0mvdZ9ZyquWgTf
         X5vSVi8qP3j9kyFjL3rnr5aM4d0n6NCw5+jy/lrFaSTMbr/iPshcq6sDdmPleC3YKe
         pxCsak13k9+Q5I3AhVjDG4Aa8xoc/BGryO4RJWJMI8wxKdwkHHzNaW7l3rHopczC8a
         BnRL0f/80To2w9w845QQ6UTs1VR3uyajGqCECeDgqkMFiN1SalQyyAJFm4Kpjsz3hT
         TnEc018fzN8zA==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <eduval@amazon.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] thermal: core: register reboot nb
Date:   Thu, 25 May 2023 14:16:54 -0700
Message-Id: <20230525211655.627415-3-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525211655.627415-1-evalenti@kernel.org>
References: <20230525211655.627415-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

This commit will register a reboot notifier block
callback for giving opportunity tearing down
thermal zones, e.g. remove their workqueues, and
for giving the governors the opportunity to leave
the hardware in a known safe state.

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/thermal/thermal_core.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 359e7b2ff0e3..66a255fb650b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -319,6 +319,12 @@ static void handle_error_temperature(struct thermal_zone_device *tz, int error)
 		tz->governor->check_error(tz, error);
 }
 
+static void handle_reboot_prepare(struct thermal_zone_device *tz)
+{
+	if (tz->governor && tz->governor->reboot_prepare)
+		tz->governor->reboot_prepare(tz);
+}
+
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
 	/*
@@ -1508,6 +1514,30 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+/* Best effort attempt to leave thermal zones at a safe state across reboots */
+static void thermal_reboot_prepare(void)
+{
+	struct thermal_zone_device *tz;
+
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		cancel_delayed_work(&tz->poll_queue);
+		handle_reboot_prepare(tz);
+	}
+}
+
+static int thermal_reboot_notify(struct notifier_block *nb,
+				 unsigned long mode, void *_unused)
+{
+	switch (mode) {
+	case SYS_RESTART:
+		thermal_reboot_prepare();
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
@@ -1539,6 +1569,10 @@ static struct notifier_block thermal_pm_nb = {
 	.notifier_call = thermal_pm_notify,
 };
 
+static struct notifier_block thermal_reboot_nb = {
+	.notifier_call = thermal_reboot_notify,
+};
+
 static int __init thermal_init(void)
 {
 	int result;
@@ -1572,6 +1606,11 @@ static int __init thermal_init(void)
 		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
 			result);
 
+	result = register_reboot_notifier(&thermal_reboot_nb);
+	if (result)
+		pr_warn("Thermal: Can not register reboot notifier, return %d\n",
+			result);
+
 	return 0;
 
 unregister_governors:
-- 
2.34.1

