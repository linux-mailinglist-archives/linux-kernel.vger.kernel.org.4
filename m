Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797065A4E3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiLaOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiLaOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:25:39 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA1E0E4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 06:25:35 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BcnlpDxYdLrOWBcnlp3Dt3; Sat, 31 Dec 2022 15:25:34 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 15:25:34 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pnx4008: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 15:25:31 +0100
Message-Id: <61f4e39db4c88408ee0149580e9aa925b784bc93.1672496714.git.christophe.jaillet@wanadoo.fr>
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
 drivers/watchdog/pnx4008_wdt.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index e0ea133c1690..87a44a5675a1 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -179,11 +179,6 @@ static struct watchdog_device pnx4008_wdd = {
 	.max_timeout = MAX_HEARTBEAT,
 };
 
-static void pnx4008_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int pnx4008_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -195,18 +190,10 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
-	wdt_clk = devm_clk_get(dev, NULL);
+	wdt_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
 
-	ret = clk_prepare_enable(wdt_clk);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(dev, pnx4008_clk_disable_unprepare,
-				       wdt_clk);
-	if (ret)
-		return ret;
-
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
 	pnx4008_wdd.parent = dev;
-- 
2.34.1

