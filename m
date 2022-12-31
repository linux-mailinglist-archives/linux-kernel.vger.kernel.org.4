Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A265A3B8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiLaLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLaLOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:14:36 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090363F9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:14:35 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BZoupLWNG8ao3BZovp4Bzp; Sat, 31 Dec 2022 12:14:33 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 12:14:33 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: loongson1: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 12:14:30 +0100
Message-Id: <624106aa86ef7e49f16b11b229528eabd63de8f7.1672485257.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Note that I get a compilation error because <loongson1.h> is not found on
my system (x86_64).
So I think that a "depends on LOONG<something>" in missing in a KConfig
file.

Fixing it could help compilation farms build-bots.
---
 drivers/watchdog/loongson1_wdt.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index bb3d075c0633..c55656cfb403 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -79,11 +79,6 @@ static const struct watchdog_ops ls1x_wdt_ops = {
 	.set_timeout = ls1x_wdt_set_timeout,
 };
 
-static void ls1x_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int ls1x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -100,20 +95,10 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata->clk = devm_clk_get(dev, pdev->name);
+	drvdata->clk = devm_clk_get_enabled(dev, pdev->name);
 	if (IS_ERR(drvdata->clk))
 		return PTR_ERR(drvdata->clk);
 
-	err = clk_prepare_enable(drvdata->clk);
-	if (err) {
-		dev_err(dev, "clk enable failed\n");
-		return err;
-	}
-	err = devm_add_action_or_reset(dev, ls1x_clk_disable_unprepare,
-				       drvdata->clk);
-	if (err)
-		return err;
-
 	clk_rate = clk_get_rate(drvdata->clk);
 	if (!clk_rate)
 		return -EINVAL;
-- 
2.34.1

