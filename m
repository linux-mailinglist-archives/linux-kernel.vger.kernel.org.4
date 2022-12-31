Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3A65A382
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiLaKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLaKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:37:45 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804DB7DE
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:37:43 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BZFEpDf5DPNsNBZFEp5YB1; Sat, 31 Dec 2022 11:37:41 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 11:37:41 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: davinci: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 11:37:39 +0100
Message-Id: <6a4cf8e8b9d8f555c77395ba2ecadc205553774d.1672483046.git.christophe.jaillet@wanadoo.fr>
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
 drivers/watchdog/davinci_wdt.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 584a56893b81..5f2184bda7b2 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -189,14 +189,8 @@ static const struct watchdog_ops davinci_wdt_ops = {
 	.restart	= davinci_wdt_restart,
 };
 
-static void davinci_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int davinci_wdt_probe(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct davinci_wdt_device *davinci_wdt;
@@ -205,21 +199,11 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	if (!davinci_wdt)
 		return -ENOMEM;
 
-	davinci_wdt->clk = devm_clk_get(dev, NULL);
+	davinci_wdt->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(davinci_wdt->clk))
 		return dev_err_probe(dev, PTR_ERR(davinci_wdt->clk),
 				     "failed to get clock node\n");
 
-	ret = clk_prepare_enable(davinci_wdt->clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, davinci_clk_disable_unprepare,
-				       davinci_wdt->clk);
-	if (ret)
-		return ret;
-
 	platform_set_drvdata(pdev, davinci_wdt);
 
 	wdd			= &davinci_wdt->wdd;
-- 
2.34.1

