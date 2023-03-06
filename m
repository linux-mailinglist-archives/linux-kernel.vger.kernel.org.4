Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE0C6AC96E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCFRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCFRKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:10:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53C410BA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:10:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKi-0004gr-Cu; Mon, 06 Mar 2023 18:09:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKh-002Ifd-Oe; Mon, 06 Mar 2023 18:09:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKg-002l03-KK; Mon, 06 Mar 2023 18:09:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] watchdog: wm8350: Simplify using devm_watchdog_register_device()
Date:   Mon,  6 Mar 2023 18:09:01 +0100
Message-Id: <20230306170901.2232323-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eKbSbgyM6iAAADJRyccERsxfhL/Xxs4zw+WOxJ+10fo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBh4nWsFYVrBiPkosnDl6xkGrWr/JqNqSvfocp dlwibEG0iOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAYeJwAKCRDB/BR4rcrs CVhHCACHQhP0vt3MEa1XkSByGKFVe9hQ7w8a1xgKHQIvYp4Zbaq0qPwWSu/xd5aUGZ0jpKAey3O CFUR3rcQ6MDlCM8AbyXa+iNtxScjzIdiigono4GKYkmZmnQqt0YJOdrDMv+TSVYituJEzxT+rZL q7hYdLPtsEuAXHdbueH35QYZpGzXhWalHRNt3PeuvJS1Oj8jDuTMNxykliSwUeqGPfuYW5czzWx EhVHBBgQjuyPU8q/wgjrB+/lJ8vks54vZbXPj0k6bjWGNMWCJrx0bYo5Bjq3sg+9yveQhgBzSuB Gi0IoKbFD5ZQJdWN2MShy2NnaZxZErerPUeEGBnEWhaj0P53
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
 drivers/watchdog/wm8350_wdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 33c62d51f00a..911ad64460a6 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -153,18 +153,11 @@ static int wm8350_wdt_probe(struct platform_device *pdev)
 	/* Default to 4s timeout */
 	wm8350_wdt_set_timeout(&wm8350_wdt, 4);
 
-	return watchdog_register_device(&wm8350_wdt);
-}
-
-static int wm8350_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&wm8350_wdt);
-	return 0;
+	return devm_watchdog_register_device(&wm8350_wdt);
 }
 
 static struct platform_driver wm8350_wdt_driver = {
 	.probe = wm8350_wdt_probe,
-	.remove = wm8350_wdt_remove,
 	.driver = {
 		.name = "wm8350-wdt",
 	},
-- 
2.39.1

