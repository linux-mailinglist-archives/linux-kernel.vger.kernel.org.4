Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67F74CFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGJIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjGJIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:23:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC6291
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:23:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qImAv-0001mB-0n; Mon, 10 Jul 2023 10:23:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qImAt-00DNI3-Sv; Mon, 10 Jul 2023 10:23:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qImAs-003kVg-O1; Mon, 10 Jul 2023 10:23:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: tps6594-esm: Convert to platform remove callback returning void
Date:   Mon, 10 Jul 2023 10:23:11 +0200
Message-Id: <20230710082311.3474785-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0OjzaYWz21aAqHhnSpRTgIdIhlM9Z7hOSmfvvIr5peY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkq7/u+8QE2G1Y2r9DttJvLZfpG8lSffzjc8zZn tQsDGdr7EqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKu/7gAKCRCPgPtYfRL+ TvwUB/48hHp2WY1rKzEyMaHXicXxkS0fnihtw0F7QbXKqeaLgeHEo9LjgPONoCi5UOaCC7nfYB1 i7W93Zy7tFklyXk1q++VJ4SUNcnylHrORjijFlXrktE64D5arsdNRJwJpq8dLJZ/R9FsZadcP9N vW5CbjyiATJzKMKXMDynSNajt98rlzHd58NEdA2G/PhB0NVDxlNMgwpoQVnAeYLjgY1tpyReBp/ kN90iw0862J8rJlRKMKsCVNriU6UJkmwdRRbTywWGByiUukbDUncUmiHySLO0/Jl3ZiiW49Damd z0nFoh5suKTr29WnH79vqLVZR23oxAF/X6zDH0oKTYsX15LP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

There are two calls that can go wrong in tps6594_esm_remove(); for both
there is already an error message. Not returning the error code has the
only side effect of suppressing (another) error message by the core
about the error being ignored. So tps6594_esm_remove() can be converted
to return void without any loss.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/tps6594-esm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index b488f704f104..a32da1c4ba61 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -65,7 +65,7 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tps6594_esm_remove(struct platform_device *pdev)
+static void tps6594_esm_remove(struct platform_device *pdev)
 {
 	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
@@ -86,8 +86,6 @@ static int tps6594_esm_remove(struct platform_device *pdev)
 out:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-
-	return ret;
 }
 
 static int tps6594_esm_suspend(struct device *dev)
@@ -121,7 +119,7 @@ static struct platform_driver tps6594_esm_driver = {
 		.pm = pm_sleep_ptr(&tps6594_esm_pm_ops),
 	},
 	.probe = tps6594_esm_probe,
-	.remove = tps6594_esm_remove,
+	.remove_new = tps6594_esm_remove,
 };
 
 module_platform_driver(tps6594_esm_driver);

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

