Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0E474977A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGFI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:29:39 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A048172B;
        Thu,  6 Jul 2023 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1688632175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C5ZsjOqtPPGYJFIxPY4zElOVIK+rkHUv8ea5aIS7+R8=;
        b=JKl+j3vKNg/eW7Ik2efJYb5lOny2bzPXKHYPEG/5xYgAXHtv83U9yljp/qy68vtp6glsPD
        LVa0jH4/k1CT7YM1O+k6sDFMKGmZvfPnRi75TvMXhvl69gaOf0mfM2dB+mh0W/ef6iWTZ1
        M0HsxfUVhFSsydQbE6AMQnTVF4T7aFo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] watchdog: starfive: Remove #ifdef guards for PM related functions
Date:   Thu,  6 Jul 2023 10:29:28 +0200
Message-Id: <20230706082928.10869-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/starfive-wdt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 8058fca4d05d..7c8a1c5e75be 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -526,7 +526,6 @@ static void starfive_wdt_shutdown(struct platform_device *pdev)
 	starfive_wdt_pm_stop(&wdt->wdd);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int starfive_wdt_suspend(struct device *dev)
 {
 	struct starfive_wdt *wdt = dev_get_drvdata(dev);
@@ -556,9 +555,7 @@ static int starfive_wdt_resume(struct device *dev)
 
 	return starfive_wdt_start(wdt);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int starfive_wdt_runtime_suspend(struct device *dev)
 {
 	struct starfive_wdt *wdt = dev_get_drvdata(dev);
@@ -574,11 +571,10 @@ static int starfive_wdt_runtime_resume(struct device *dev)
 
 	return starfive_wdt_enable_clock(wdt);
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops starfive_wdt_pm_ops = {
-	SET_RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
+	RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
 };
 
 static const struct of_device_id starfive_wdt_match[] = {
@@ -594,7 +590,7 @@ static struct platform_driver starfive_wdt_driver = {
 	.shutdown = starfive_wdt_shutdown,
 	.driver = {
 		.name = "starfive-wdt",
-		.pm = &starfive_wdt_pm_ops,
+		.pm = pm_ptr(&starfive_wdt_pm_ops),
 		.of_match_table = starfive_wdt_match,
 	},
 };
-- 
2.40.1

