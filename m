Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB165A4D8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiLaOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLaOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:23:02 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112D10A4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 06:23:00 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BclGp4iYmTOlqBclGpfRCi; Sat, 31 Dec 2022 15:22:59 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 15:22:59 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pic32-wdt: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 15:22:57 +0100
Message-Id: <4335b4201b535ebc749a98bad0b99e3cb5317c39.1672496563.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/watchdog/pic32-wdt.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index 41715d68d9e9..6d1a00222991 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -162,11 +162,6 @@ static const struct of_device_id pic32_wdt_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, pic32_wdt_dt_ids);
 
-static void pic32_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int pic32_wdt_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -186,22 +181,12 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 	if (!wdt->rst_base)
 		return -ENOMEM;
 
-	wdt->clk = devm_clk_get(dev, NULL);
+	wdt->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		dev_err(dev, "clk not found\n");
 		return PTR_ERR(wdt->clk);
 	}
 
-	ret = clk_prepare_enable(wdt->clk);
-	if (ret) {
-		dev_err(dev, "clk enable failed\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, pic32_clk_disable_unprepare,
-				       wdt->clk);
-	if (ret)
-		return ret;
-
 	if (pic32_wdt_is_win_enabled(wdt)) {
 		dev_err(dev, "windowed-clear mode is not supported.\n");
 		return -ENODEV;
-- 
2.34.1

