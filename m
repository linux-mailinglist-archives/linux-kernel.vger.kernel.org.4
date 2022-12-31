Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9104665A3EC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLaM0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLaM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:26:17 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62941265E
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:26:15 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BawFpjtO2fxUsBawFpvF3E; Sat, 31 Dec 2022 13:26:13 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 13:26:13 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] watchdog: lpc18xx: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 13:26:09 +0100
Message-Id: <d4c675190d3ddfbba5c354edb4274757f9117304.1672489554.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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
Note that the order of operations is slightly modified by this patch. The
"reg" clk is now prepare_enable()'ed before clk_get("wdtclk").
---
 drivers/watchdog/lpc18xx_wdt.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 60b6d74f267d..1b9b5f21a0df 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -197,16 +197,10 @@ static const struct watchdog_ops lpc18xx_wdt_ops = {
 	.restart        = lpc18xx_wdt_restart,
 };
 
-static void lpc18xx_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int lpc18xx_wdt_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt;
 	struct device *dev = &pdev->dev;
-	int ret;
 
 	lpc18xx_wdt = devm_kzalloc(dev, sizeof(*lpc18xx_wdt), GFP_KERNEL);
 	if (!lpc18xx_wdt)
@@ -216,38 +210,18 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(lpc18xx_wdt->base))
 		return PTR_ERR(lpc18xx_wdt->base);
 
-	lpc18xx_wdt->reg_clk = devm_clk_get(dev, "reg");
+	lpc18xx_wdt->reg_clk = devm_clk_get_enabled(dev, "reg");
 	if (IS_ERR(lpc18xx_wdt->reg_clk)) {
 		dev_err(dev, "failed to get the reg clock\n");
 		return PTR_ERR(lpc18xx_wdt->reg_clk);
 	}
 
-	lpc18xx_wdt->wdt_clk = devm_clk_get(dev, "wdtclk");
+	lpc18xx_wdt->wdt_clk = devm_clk_get_enabled(dev, "wdtclk");
 	if (IS_ERR(lpc18xx_wdt->wdt_clk)) {
 		dev_err(dev, "failed to get the wdt clock\n");
 		return PTR_ERR(lpc18xx_wdt->wdt_clk);
 	}
 
-	ret = clk_prepare_enable(lpc18xx_wdt->reg_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare or enable sys clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, lpc18xx_clk_disable_unprepare,
-				       lpc18xx_wdt->reg_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(lpc18xx_wdt->wdt_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare or enable wdt clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, lpc18xx_clk_disable_unprepare,
-				       lpc18xx_wdt->wdt_clk);
-	if (ret)
-		return ret;
-
 	/* We use the clock rate to calculate timeouts */
 	lpc18xx_wdt->clk_rate = clk_get_rate(lpc18xx_wdt->wdt_clk);
 	if (lpc18xx_wdt->clk_rate == 0) {
-- 
2.34.1

