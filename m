Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341BE606871
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJTSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJTSvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:51:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44974170B7B;
        Thu, 20 Oct 2022 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666291854; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xIYc2tjT8/lB6pDNaHqi80nRJ3Rpz+QWPGYXDoEgJJA=;
        b=GirfJmHsDYS5A0zJTzVT68o6M9UJTsIM/0b4c/YXdzZF2Ub6z1pUsVZVerJ65Dg2SskBht
        D0h4up67DGzMSNpCTTXKtnmtFfUVjLf+7C3dsx2eJuwMqPJ6DXllIHlCnVuIYrTFhTF/8g
        XIUeX7e4fQdOiD2nKrOH80uxlk4Dhho=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] watchdog: twl4030: Remove #ifdef guards for PM related functions
Date:   Thu, 20 Oct 2022 19:50:45 +0100
Message-Id: <20221020185047.1001522-3-paul@crapouillou.net>
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
 drivers/watchdog/twl4030_wdt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 36b4a660928d..09d17e20f4a7 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -81,7 +81,6 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, wdt);
 }
 
-#ifdef CONFIG_PM
 static int twl4030_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct watchdog_device *wdt = platform_get_drvdata(pdev);
@@ -99,10 +98,6 @@ static int twl4030_wdt_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define twl4030_wdt_suspend        NULL
-#define twl4030_wdt_resume         NULL
-#endif
 
 static const struct of_device_id twl_wdt_of_match[] = {
 	{ .compatible = "ti,twl4030-wdt", },
@@ -112,8 +107,8 @@ MODULE_DEVICE_TABLE(of, twl_wdt_of_match);
 
 static struct platform_driver twl4030_wdt_driver = {
 	.probe		= twl4030_wdt_probe,
-	.suspend	= twl4030_wdt_suspend,
-	.resume		= twl4030_wdt_resume,
+	.suspend	= pm_ptr(twl4030_wdt_suspend),
+	.resume		= pm_ptr(twl4030_wdt_resume),
 	.driver		= {
 		.name		= "twl4030_wdt",
 		.of_match_table	= twl_wdt_of_match,
-- 
2.35.1

