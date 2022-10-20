Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798460686E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJTSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJTSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:51:07 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABECD156256;
        Thu, 20 Oct 2022 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666291854; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5IpqpesPwT77Jvi5jmQo30Q/fMNFWN8hFsyxEzy+wU=;
        b=RV8v8McoZWApg9qmSCRUuGTBvS8MtaVJr25IDyp3vXfG0El7CofrN8G8SqO6nLop+B3omY
        s6oXK5yHJQ1KWBSqpRZh5GmagNBCB8kV9r8TayjZWGG5bmdTIRZ1In7RZO/f3Rey9HIZGT
        gnUN08FlnCXn3fWoJIz30relP/B7l7M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] watchdog: at91rm9200: Remove #ifdef guards for PM related functions
Date:   Thu, 20 Oct 2022 19:50:44 +0100
Message-Id: <20221020185047.1001522-2-paul@crapouillou.net>
In-Reply-To: <20221020185047.1001522-1-paul@crapouillou.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
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
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org

 drivers/watchdog/at91rm9200_wdt.c | 11 ++---------
 drivers/watchdog/db8500_wdt.c     |  9 ++-------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 6d751eb8191d..5126454bb861 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -278,8 +278,6 @@ static void at91wdt_shutdown(struct platform_device *pdev)
 	at91_wdt_stop();
 }
 
-#ifdef CONFIG_PM
-
 static int at91wdt_suspend(struct platform_device *pdev, pm_message_t message)
 {
 	at91_wdt_stop();
@@ -293,11 +291,6 @@ static int at91wdt_resume(struct platform_device *pdev)
 	return 0;
 }
 
-#else
-#define at91wdt_suspend NULL
-#define at91wdt_resume	NULL
-#endif
-
 static const struct of_device_id at91_wdt_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-wdt" },
 	{ /* sentinel */ }
@@ -308,8 +301,8 @@ static struct platform_driver at91wdt_driver = {
 	.probe		= at91wdt_probe,
 	.remove		= at91wdt_remove,
 	.shutdown	= at91wdt_shutdown,
-	.suspend	= at91wdt_suspend,
-	.resume		= at91wdt_resume,
+	.suspend	= pm_ptr(at91wdt_suspend),
+	.resume		= pm_ptr(at91wdt_resume),
 	.driver		= {
 		.name	= "atmel_st_watchdog",
 		.of_match_table = at91_wdt_dt_ids,
diff --git a/drivers/watchdog/db8500_wdt.c b/drivers/watchdog/db8500_wdt.c
index 6ed8b63d310d..97148ac0aa54 100644
--- a/drivers/watchdog/db8500_wdt.c
+++ b/drivers/watchdog/db8500_wdt.c
@@ -105,7 +105,6 @@ static int db8500_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int db8500_wdt_suspend(struct platform_device *pdev,
 			     pm_message_t state)
 {
@@ -130,15 +129,11 @@ static int db8500_wdt_resume(struct platform_device *pdev)
 	}
 	return 0;
 }
-#else
-#define db8500_wdt_suspend NULL
-#define db8500_wdt_resume NULL
-#endif
 
 static struct platform_driver db8500_wdt_driver = {
 	.probe		= db8500_wdt_probe,
-	.suspend	= db8500_wdt_suspend,
-	.resume		= db8500_wdt_resume,
+	.suspend	= pm_ptr(db8500_wdt_suspend),
+	.resume		= pm_ptr(db8500_wdt_resume),
 	.driver		= {
 		.name	= "db8500_wdt",
 	},
-- 
2.35.1

