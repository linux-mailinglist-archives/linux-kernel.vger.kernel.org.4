Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C850D606872
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJTSv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJTSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:51:22 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8F0170B59;
        Thu, 20 Oct 2022 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666291855; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31qI4IyMllYZtSn4jgOmFJFt3IC2yVgWJx1sJSLJGZE=;
        b=jS2b28qwE28HJaF1yBs2kv2L1YlMNT1ryDO6CdMegxqzvI7pKzi2RZmXl0aFoGI3KKG6lA
        M1OzHcPZ+s2D9F6ybRn/GubVEflE2Wc70jFqM/IkhJ26gx5cF3ryDcXtvzvPumBlp4seJB
        D9ncjWaLUSE0eLtrYQa4Wr3OGAgKK7s=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] watchdog: omap: Remove #ifdef guards for PM related functions
Date:   Thu, 20 Oct 2022 19:50:46 +0100
Message-Id: <20221020185047.1001522-4-paul@crapouillou.net>
In-Reply-To: <20221020185047.1001522-1-paul@crapouillou.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pm_ptr() macro to handle the .suspend/.resume callbacks.

This macro allows the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/omap_wdt.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 74d785b2b478..e75aa86f63cb 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -316,8 +316,6 @@ static int omap_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef	CONFIG_PM
-
 /* REVISIT ... not clear this is the best way to handle system suspend; and
  * it's very inappropriate for selective device suspend (e.g. suspending this
  * through sysfs rather than by stopping the watchdog daemon).  Also, this
@@ -353,11 +351,6 @@ static int omap_wdt_resume(struct platform_device *pdev)
 	return 0;
 }
 
-#else
-#define	omap_wdt_suspend	NULL
-#define	omap_wdt_resume		NULL
-#endif
-
 static const struct of_device_id omap_wdt_of_match[] = {
 	{ .compatible = "ti,omap3-wdt", },
 	{},
@@ -368,8 +361,8 @@ static struct platform_driver omap_wdt_driver = {
 	.probe		= omap_wdt_probe,
 	.remove		= omap_wdt_remove,
 	.shutdown	= omap_wdt_shutdown,
-	.suspend	= omap_wdt_suspend,
-	.resume		= omap_wdt_resume,
+	.suspend	= pm_ptr(omap_wdt_suspend),
+	.resume		= pm_ptr(omap_wdt_resume),
 	.driver		= {
 		.name	= "omap_wdt",
 		.of_match_table = omap_wdt_of_match,
-- 
2.35.1

