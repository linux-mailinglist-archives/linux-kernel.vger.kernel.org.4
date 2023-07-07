Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31374ABF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGGHdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:33:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C321FD9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:33:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qHfyO-0003N7-Cp; Fri, 07 Jul 2023 09:33:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qHfyM-00CgG0-Ar; Fri, 07 Jul 2023 09:33:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qHfyL-002wok-Eg; Fri, 07 Jul 2023 09:33:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Julien Panis <jpanis@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] misc: tps6594-pfsm: Convert to platform remove callback returning void
Date:   Fri,  7 Jul 2023 09:33:43 +0200
Message-Id: <20230707073343.3396477-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lVTZfDlkWQIkBc/T5Uih9QgBjRzRgPeJPBlwUWi78NI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkp7/Wcwt/QNf+huCVErIoFz0vgic9YOIEoEqf0 HTC63+Mx6OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKe/1gAKCRCPgPtYfRL+ TkpgCACqDEdsTjrn/kBDpGy7weSa6TQnC8pJVl6cOkcw5/jXecKp9c4+xMvXkB3rq/ltmfRUmDV Fpx4ALdBLbjiapJfaY6YP1K0D99TVhcieurfnGA5pyzNoNKaItx2Nf82ZYB2agJx2jWIbMc+SJ0 nyGxll3rYxzH8jNgAgHeESfQ7bEa8v++k9/XPykqiGnMEP+SwLKoDau0TseuBb2ypySX2U0LEan KDmrOeDjCuCwGja3hJdxPfFuKO3SZ8l5RF2ixaF10LacYwiDZLPwxMkGBeNMCThh0+3K4B/PkCG Zoek8sMIP1ZBTCkanS/xwhd0dvbIPJvDQRWO/3aayzuaspiO
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/tps6594-pfsm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 5223d1580807..0e24f8daaa9a 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -281,13 +281,11 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 	return misc_register(&pfsm->miscdev);
 }
 
-static int tps6594_pfsm_remove(struct platform_device *pdev)
+static void tps6594_pfsm_remove(struct platform_device *pdev)
 {
 	struct tps6594_pfsm *pfsm = platform_get_drvdata(pdev);
 
 	misc_deregister(&pfsm->miscdev);
-
-	return 0;
 }
 
 static struct platform_driver tps6594_pfsm_driver = {
@@ -295,7 +293,7 @@ static struct platform_driver tps6594_pfsm_driver = {
 		.name = "tps6594-pfsm",
 	},
 	.probe = tps6594_pfsm_probe,
-	.remove = tps6594_pfsm_remove,
+	.remove_new = tps6594_pfsm_remove,
 };
 
 module_platform_driver(tps6594_pfsm_driver);
-- 
2.39.2

