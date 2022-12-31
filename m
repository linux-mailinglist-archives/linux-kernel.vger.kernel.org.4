Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E381665A32D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiLaIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 03:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLaIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 03:00:36 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7933F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 00:00:35 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BWnApyjIetht4BWnBpyodI; Sat, 31 Dec 2022 09:00:33 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 09:00:33 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: armada_37xx: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 09:00:31 +0100
Message-Id: <ccb096879a1309b9918ae956d6bdb9668c69bcda.1672473617.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/watchdog/armada_37xx_wdt.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index ac9fed1ef681..e58652939f8a 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -246,11 +246,6 @@ static const struct watchdog_ops armada_37xx_wdt_ops = {
 	.get_timeleft = armada_37xx_wdt_get_timeleft,
 };
 
-static void armada_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int armada_37xx_wdt_probe(struct platform_device *pdev)
 {
 	struct armada_37xx_watchdog *dev;
@@ -280,18 +275,10 @@ static int armada_37xx_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* init clock */
-	dev->clk = devm_clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
 
-	ret = clk_prepare_enable(dev->clk);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       armada_clk_disable_unprepare, dev->clk);
-	if (ret)
-		return ret;
-
 	dev->clk_rate = clk_get_rate(dev->clk);
 	if (!dev->clk_rate)
 		return -EINVAL;
-- 
2.34.1

