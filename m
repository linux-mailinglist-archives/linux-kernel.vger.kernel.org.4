Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A27118EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjEYVRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjEYVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327AA7;
        Thu, 25 May 2023 14:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BCC64B30;
        Thu, 25 May 2023 21:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31806C433D2;
        Thu, 25 May 2023 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685049437;
        bh=vEe5IMrxvZ6zjp9aBXSVRXJpxdUpiaH0SmaBoWt1Nqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOYzQrWxDyfJoP/3gDvkOTQNTcpl0mwqfLpe6KQap1/xPJQeBfJUO7RYyGvzhmOuc
         sPgFSRVBY8DV4AVO1YTcpbX0qw3yi5Js+zc/+dZaGt4wV37xEIipDxHW06FlMFjuJS
         vhwWXp7UusKlHg90Qnuj1QarpO195cnncgjbU6BeqloOqBAoQV2p2+pCfuYxEZ4DfS
         wuG4o0VNtGWIVVCvYlVEABI3tHoB6YJIm6aqZlu77Zk+HmElPGWrUGTaOsPEwe2T7i
         DhLUlRD2XTYi++pHyS0dkxF9zfYKKk60w69dvm63WpZqEam/N/P0avkG7br2V5agBS
         wHmG0E80/2V2Q==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <eduval@amazon.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] thermal: core: register a crash callback
Date:   Thu, 25 May 2023 14:16:55 -0700
Message-Id: <20230525211655.627415-4-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525211655.627415-1-evalenti@kernel.org>
References: <20230525211655.627415-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

This commit will register a crash callback for
the thermal subsystem, this way the thermal
core can tear down the thermal zones and ask
governors to leave the hardware in a known
safe state prior upon the event of a crash.

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
 drivers/thermal/thermal_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 66a255fb650b..38b168b9245e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/of.h>
 #include <linux/suspend.h>
+#include <linux/panic_notifier.h>
 
 #define CREATE_TRACE_POINTS
 #include "thermal_trace.h"
@@ -1525,6 +1526,14 @@ static void thermal_reboot_prepare(void)
 	}
 }
 
+static int thermal_crash_notify(struct notifier_block *nb,
+				unsigned long mode, void *_unused)
+{
+	thermal_reboot_prepare();
+
+	return 0;
+}
+
 static int thermal_reboot_notify(struct notifier_block *nb,
 				 unsigned long mode, void *_unused)
 {
@@ -1569,6 +1578,10 @@ static struct notifier_block thermal_pm_nb = {
 	.notifier_call = thermal_pm_notify,
 };
 
+static struct notifier_block thermal_crash_nb = {
+	.notifier_call = thermal_crash_notify,
+};
+
 static struct notifier_block thermal_reboot_nb = {
 	.notifier_call = thermal_reboot_notify,
 };
@@ -1611,6 +1624,8 @@ static int __init thermal_init(void)
 		pr_warn("Thermal: Can not register reboot notifier, return %d\n",
 			result);
 
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &thermal_crash_nb);
 	return 0;
 
 unregister_governors:
-- 
2.34.1

