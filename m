Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DD65A39F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiLaKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiLaKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:53:39 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130230C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:53:37 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BZUdpDj8SPNsNBZUdp5ZNY; Sat, 31 Dec 2022 11:53:35 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 11:53:35 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: imgpdc: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 11:53:34 +0100
Message-Id: <1f8d1ce1e6a63c507a291aea624b1337326cc563.1672483996.git.christophe.jaillet@wanadoo.fr>
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
"sys" clk is now prepare_enable()'ed before clk_get("wdt").
---
 drivers/watchdog/imgpdc_wdt.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index b57ff3787052..a55f801895d4 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -175,16 +175,11 @@ static const struct watchdog_ops pdc_wdt_ops = {
 	.restart        = pdc_wdt_restart,
 };
 
-static void pdc_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	u64 div;
-	int ret, val;
+	int val;
 	unsigned long clk_rate;
 	struct pdc_wdt_dev *pdc_wdt;
 
@@ -196,38 +191,18 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(pdc_wdt->base))
 		return PTR_ERR(pdc_wdt->base);
 
-	pdc_wdt->sys_clk = devm_clk_get(dev, "sys");
+	pdc_wdt->sys_clk = devm_clk_get_enabled(dev, "sys");
 	if (IS_ERR(pdc_wdt->sys_clk)) {
 		dev_err(dev, "failed to get the sys clock\n");
 		return PTR_ERR(pdc_wdt->sys_clk);
 	}
 
-	pdc_wdt->wdt_clk = devm_clk_get(dev, "wdt");
+	pdc_wdt->wdt_clk = devm_clk_get_enabled(dev, "wdt");
 	if (IS_ERR(pdc_wdt->wdt_clk)) {
 		dev_err(dev, "failed to get the wdt clock\n");
 		return PTR_ERR(pdc_wdt->wdt_clk);
 	}
 
-	ret = clk_prepare_enable(pdc_wdt->sys_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare or enable sys clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, pdc_clk_disable_unprepare,
-				       pdc_wdt->sys_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(pdc_wdt->wdt_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare or enable wdt clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, pdc_clk_disable_unprepare,
-				       pdc_wdt->wdt_clk);
-	if (ret)
-		return ret;
-
 	/* We use the clock rate to calculate the max timeout */
 	clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
 	if (clk_rate == 0) {
-- 
2.34.1

