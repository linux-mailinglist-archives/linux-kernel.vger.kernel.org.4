Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98A65A333
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 09:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLaIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 03:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLaIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 03:12:32 -0500
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB00C75E
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 00:12:31 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BWyjpGbkfBicGBWyjpKZZ0; Sat, 31 Dec 2022 09:12:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 09:12:30 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: cadence: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 09:12:28 +0100
Message-Id: <615c6c3c46c3ee8e3136725af0ab0b51e1298091.1672474336.git.christophe.jaillet@wanadoo.fr>
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
 drivers/watchdog/cadence_wdt.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index bc99e9164930..23d41043863f 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -274,11 +274,6 @@ static const struct watchdog_ops cdns_wdt_ops = {
 	.set_timeout = cdns_wdt_settimeout,
 };
 
-static void cdns_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 /************************Platform Operations*****************************/
 /**
  * cdns_wdt_probe - Probe call for the device.
@@ -333,21 +328,11 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(cdns_wdt_device);
 	watchdog_set_drvdata(cdns_wdt_device, wdt);
 
-	wdt->clk = devm_clk_get(dev, NULL);
+	wdt->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return dev_err_probe(dev, PTR_ERR(wdt->clk),
 				     "input clock not found\n");
 
-	ret = clk_prepare_enable(wdt->clk);
-	if (ret) {
-		dev_err(dev, "unable to enable clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, cdns_clk_disable_unprepare,
-				       wdt->clk);
-	if (ret)
-		return ret;
-
 	clock_f = clk_get_rate(wdt->clk);
 	if (clock_f <= CDNS_WDT_CLK_75MHZ) {
 		wdt->prescaler = CDNS_WDT_PRESCALE_512;
-- 
2.34.1

