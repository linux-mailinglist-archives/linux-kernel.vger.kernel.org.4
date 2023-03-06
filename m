Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1C6AC96F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCFRKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCFRKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:10:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20421A30
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:10:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKh-0004gW-Lc; Mon, 06 Mar 2023 18:09:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKh-002IfU-14; Mon, 06 Mar 2023 18:09:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKg-002kzx-6q; Mon, 06 Mar 2023 18:09:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/3] watchdog: bcm47xx: Simplify using devm_watchdog_register_device()
Date:   Mon,  6 Mar 2023 18:08:59 +0100
Message-Id: <20230306170901.2232323-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JOxaeQ/qlp8PNCw4eRsoKrCgQTxAkZTtmbv1GqXssTQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBh4fDiTTzV3ULvk7eUHClBWcQALKE1SxTxzlm xHjedvRZNSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAYeHwAKCRDB/BR4rcrs CV2jB/96D03Mg0dYUOOKgv8Ra1VvtupViW7kzFZNPS1pr+d0ocjF3apez4hdY/GEZ984H+io3zH EZrDpnudCfbd20WG5FnpkAsxlzKyqo2/Wt+HU8IlQnILqcWitxOF2E6mW7QEJmQrPd1aR2/Sw4+ mHy3+ad3qvnY/72Lt9dSQX5ZhLXFGeoapQCDqey9ZYyqhdLZKiRPcQKGNnwnk4QVXogOhTOpAcJ CLknVobF4mKnjfhBZ3AeN00zVTrDkEzJjeQV1+luSH4NHg7w3bLHUAvcKP9oTIS3uNtQ8XomsAI flYWK0ymYzv1UDQKN7gEKU2eVG0IsoKfVWn1dyguVmULsWcD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to drop the .remove() function as it only exists to
unregister the watchdog device which is now done in a callback
registered by devm_watchdog_register_device().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/bcm47xx_wdt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 05425c1dfd4c..8698ef94dddf 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -202,7 +202,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	watchdog_set_restart_priority(&wdt->wdd, 64);
 	watchdog_stop_on_reboot(&wdt->wdd);
 
-	ret = watchdog_register_device(&wdt->wdd);
+	ret = devm_watchdog_register_device(&wdt->wdd);
 	if (ret)
 		goto err_timer;
 
@@ -218,21 +218,11 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm47xx_wdt_remove(struct platform_device *pdev)
-{
-	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
-
-	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
-}
-
 static struct platform_driver bcm47xx_wdt_driver = {
 	.driver		= {
 		.name	= "bcm47xx-wdt",
 	},
 	.probe		= bcm47xx_wdt_probe,
-	.remove		= bcm47xx_wdt_remove,
 };
 
 module_platform_driver(bcm47xx_wdt_driver);
-- 
2.39.1

