Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36B6AC96D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCFRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCFRKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:10:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E464B81C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:09:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKh-0004gY-Ob; Mon, 06 Mar 2023 18:09:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKh-002Ifa-3q; Mon, 06 Mar 2023 18:09:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKg-002l00-Cx; Mon, 06 Mar 2023 18:09:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] watchdog: rn5t618: Simplify using devm_watchdog_register_device()
Date:   Mon,  6 Mar 2023 18:09:00 +0100
Message-Id: <20230306170901.2232323-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bq6NqBPM2LpQjqHH+4WiBPfT6AZw0afyjHDglX+lfrE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBh4kcQSPD/UEwhLVFLaxTT2V0AkW1LUmJOVjp Jsf4kObGEOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAYeJAAKCRDB/BR4rcrs CV5nB/9rkdIe4mcbTBAj5LhKKdzS5BaKKxVCC+gyNSSR3xuNG6MBORABaZ5buKQv10Lm3jnzS0y qb64s39Rg0YbNk2jtZTgtbH+rcgO/+pPQBPa1IGIDTGXLLR4XKokj5crVQ6w93U/JeYjoszXIA9 7NXr7Evb+v1yk8ABRo+YeFpO27W4igey+FqvpxKKN4kBw155WRoUONTS3LahX37RxHGjxXRL/kJ 32rT2CcUakFk8E3orvmMof0EToPtDPz8itzcOmTb25YbBi6hNPsBTWGEfCkAac/gVuMIoCLr/wn 28023F34fYeC9MOSB0Ujb2xpPKRyZULRxpaMyAmYY4stp2hl
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
 drivers/watchdog/rn5t618_wdt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index 40d8ebd8c0ac..c0aee627ff3b 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -178,21 +178,11 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 
-	return watchdog_register_device(&wdt->wdt_dev);
-}
-
-static int rn5t618_wdt_remove(struct platform_device *pdev)
-{
-	struct rn5t618_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdt_dev);
-
-	return 0;
+	return devm_watchdog_register_device(&wdt->wdt_dev);
 }
 
 static struct platform_driver rn5t618_wdt_driver = {
 	.probe = rn5t618_wdt_probe,
-	.remove = rn5t618_wdt_remove,
 	.driver = {
 		.name	= DRIVER_NAME,
 	},
-- 
2.39.1

