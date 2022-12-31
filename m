Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47065A3AC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiLaLHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiLaLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:07:31 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA2DF55
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:07:30 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BZi4pTIC3Rn9tBZi4pP7i0; Sat, 31 Dec 2022 12:07:29 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 12:07:29 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 12:07:27 +0100
Message-Id: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
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
Note that I get a compilation error because read_cpuid_id() is not defined
on my system (x86_64).
So I think that a "depends on ARM<something>" in missing in a KConfig file.

Fixing it could help compilation farms build-bots.
---
 drivers/watchdog/ixp4xx_wdt.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 281a48d9889f..607ce4b8df57 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -112,12 +112,6 @@ static const struct watchdog_info ixp4xx_wdt_info = {
 	.identity = KBUILD_MODNAME,
 };
 
-/* Devres-handled clock disablement */
-static void ixp4xx_clock_action(void *d)
-{
-	clk_disable_unprepare(d);
-}
-
 static int ixp4xx_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -139,16 +133,10 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
 	 * Retrieve rate from a fixed clock from the device tree if
 	 * the parent has that, else use the default clock rate.
 	 */
-	clk = devm_clk_get(dev->parent, NULL);
-	if (!IS_ERR(clk)) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-		ret = devm_add_action_or_reset(dev, ixp4xx_clock_action, clk);
-		if (ret)
-			return ret;
+	clk = devm_clk_get_enabled(dev->parent, NULL);
+	if (!IS_ERR(clk))
 		iwdt->rate = clk_get_rate(clk);
-	}
+
 	if (!iwdt->rate)
 		iwdt->rate = IXP4XX_TIMER_FREQ;
 
-- 
2.34.1

