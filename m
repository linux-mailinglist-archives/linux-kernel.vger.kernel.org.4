Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C465A434
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiLaMva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiLaMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:51:28 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95B632F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:51:26 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BbKbp3t8uexdxBbKcp9m3w; Sat, 31 Dec 2022 13:51:25 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 13:51:25 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] watchdog: of_xilinx_wdt: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 13:51:20 +0100
Message-Id: <71551233b18f57037be9e75d2d6428534d7572d3.1672491065.git.christophe.jaillet@wanadoo.fr>
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
Note that the order of operations is slightly modified by this patch. The
clk is now prepare_enable()'ed before calling clk_get_rate().
---
 drivers/watchdog/of_xilinx_wdt.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 3318544366b8..f184843380a3 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -193,7 +193,7 @@ static int xwdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
 
-	xdev->clk = devm_clk_get(dev, NULL);
+	xdev->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(xdev->clk)) {
 		if (PTR_ERR(xdev->clk) != -ENOENT)
 			return PTR_ERR(xdev->clk);
@@ -211,15 +211,6 @@ static int xwdt_probe(struct platform_device *pdev)
 				 "The watchdog clock freq cannot be obtained\n");
 	} else {
 		pfreq = clk_get_rate(xdev->clk);
-		rc = clk_prepare_enable(xdev->clk);
-		if (rc) {
-			dev_err(dev, "unable to enable clock\n");
-			return rc;
-		}
-		rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
-					      xdev->clk);
-		if (rc)
-			return rc;
 	}
 
 	/*
-- 
2.34.1

