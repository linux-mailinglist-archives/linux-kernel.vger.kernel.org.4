Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2065A4D1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiLaOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiLaOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:20:36 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D54DD2FD
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 06:20:34 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BcitpDw3rLrOWBcitp3DP1; Sat, 31 Dec 2022 15:20:32 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 15:20:32 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pic32-dmt: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 15:20:29 +0100
Message-Id: <f9a4dcfc6d31bd9c1417e2d97a40cc2c1dbc6f30.1672496405.git.christophe.jaillet@wanadoo.fr>
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
 drivers/watchdog/pic32-dmt.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index f43062b3c4c8..bc4ccddc75a3 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -164,11 +164,6 @@ static struct watchdog_device pic32_dmt_wdd = {
 	.ops		= &pic32_dmt_fops,
 };
 
-static void pic32_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int pic32_dmt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -184,20 +179,12 @@ static int pic32_dmt_probe(struct platform_device *pdev)
 	if (IS_ERR(dmt->regs))
 		return PTR_ERR(dmt->regs);
 
-	dmt->clk = devm_clk_get(dev, NULL);
+	dmt->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(dmt->clk)) {
 		dev_err(dev, "clk not found\n");
 		return PTR_ERR(dmt->clk);
 	}
 
-	ret = clk_prepare_enable(dmt->clk);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(dev, pic32_clk_disable_unprepare,
-				       dmt->clk);
-	if (ret)
-		return ret;
-
 	wdd->timeout = pic32_dmt_get_timeout_secs(dmt);
 	if (!wdd->timeout) {
 		dev_err(dev, "failed to read watchdog register timeout\n");
-- 
2.34.1

