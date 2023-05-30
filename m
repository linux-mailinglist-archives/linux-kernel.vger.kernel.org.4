Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC471567D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjE3HTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjE3HT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:19:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C990
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:19:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdZ-0006UO-9v; Tue, 30 May 2023 09:19:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdX-003orD-P3; Tue, 30 May 2023 09:19:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdW-009OQn-Vo; Tue, 30 May 2023 09:19:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/6] usb: xhci-histb: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 09:19:09 +0200
Message-Id: <20230530071913.2192214-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
References: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=U3rXptJKZVfEw+MHdwyDbq+XxbeLCznWrbH7lif8zkw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNquZ36UD22fQhXa1UNpGm8ZYvjDueQv+VLQ q8kKGk4Q9eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjagAKCRCPgPtYfRL+ TmChB/9ofZMjHxKtzPBb1AnM7b50A36Jlk5NmqBFdbt74LsoPwOUP4faqHwnxXwNGRxOfkYV4q+ A/4ZBkQ22sv0ad3gqOjA7KPQ6VjPmoPd0ibrVSxCwdirwFalmrv6sbAIl1tCJ+3eKVnlyhAWeOE IcqmzWQBuryg2/CVFybJq2wxl+B+4Rp79ltol5+Ikwm9RaVdqjimMKSD/1FExTxzKuowPuhk/jN iewHMdhg3RvLMDp1pf/1khxGWz//27vlE4/A/nDCP+tton+SZ0gCYgLcIYWk0sTG9P3TxBVZInl TxvdYYAdQceNrewwnzP8wWpHTLRD8Pnp3qnNwfqndghy7lZZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/host/xhci-histb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-histb.c b/drivers/usb/host/xhci-histb.c
index 91ce97821de5..d8aba07e802d 100644
--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -319,7 +319,7 @@ static int xhci_histb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xhci_histb_remove(struct platform_device *dev)
+static void xhci_histb_remove(struct platform_device *dev)
 {
 	struct xhci_hcd_histb *histb = platform_get_drvdata(dev);
 	struct usb_hcd *hcd = histb->hcd;
@@ -339,8 +339,6 @@ static int xhci_histb_remove(struct platform_device *dev)
 	usb_put_hcd(hcd);
 	pm_runtime_put_sync(&dev->dev);
 	pm_runtime_disable(&dev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused xhci_histb_suspend(struct device *dev)
@@ -385,7 +383,7 @@ MODULE_DEVICE_TABLE(of, histb_xhci_of_match);
 
 static struct platform_driver histb_xhci_driver = {
 	.probe	= xhci_histb_probe,
-	.remove	= xhci_histb_remove,
+	.remove_new = xhci_histb_remove,
 	.driver	= {
 		.name = "xhci-histb",
 		.pm = DEV_PM_OPS,
-- 
2.39.2

