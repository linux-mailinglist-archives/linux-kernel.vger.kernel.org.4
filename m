Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774E771567C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjE3HTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjE3HT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:19:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E2A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:19:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdZ-0006US-9t; Tue, 30 May 2023 09:19:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdY-003orM-Cf; Tue, 30 May 2023 09:19:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdX-009OQt-Co; Tue, 30 May 2023 09:19:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 4/6] usb: xhci-plat: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 09:19:11 +0200
Message-Id: <20230530071913.2192214-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
References: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YYc694febUOSmPcBF9ut/bBjNN5AUTaNWOSw51GRHbk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNslW7H6OYyDOVIF/bbx8UO3wm9DXLAhk0jo LoMaMJnOMuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjbAAKCRCPgPtYfRL+ Tty/CACEUxJnhSekiONvj04ozkJ91q9iWgXaaJUNw7lmJ7Jl/fYx9lYG2784dj3ibhp8iUffqBa HOkIKxvSA2hZ6JHfmC3ITeoq7gLHKisGzyBXObj5kW6kjokSzmDrm2cT/GdOHQi/pz0ULQaK9KH MA4SHM3phvtlIouMtiLTfhS64TjVFB3cY0tHbtiISUQAxRaGg7SoyVzmD4j5LacT4eZMCJCk2QC 0O1UZMVMMd5m3kM94L/MqCQlpuAKK33aN+Wptu8VhTcGREJeDJC/p9d6Lx537afVMsO7ybJNkJk Qt9b30USgwAPGXbgFFQdcAEIx6i1mYA9fwhGIydv7+G8AsEp
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

To convert the xhci-plat driver, change the prototype of
xhci_plat_remove() to return void. As this function is exported and used
by the xhci-rcar driver, convert this driver at the same time
accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/host/xhci-plat.c | 6 ++----
 drivers/usb/host/xhci-plat.h | 2 +-
 drivers/usb/host/xhci-rcar.c | 6 +++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a666b21c21bb..a52d73c2cd80 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -395,7 +395,7 @@ static int xhci_generic_plat_probe(struct platform_device *pdev)
 	return xhci_plat_probe(pdev, sysdev, priv_match);
 }
 
-int xhci_plat_remove(struct platform_device *dev)
+void xhci_plat_remove(struct platform_device *dev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -426,8 +426,6 @@ int xhci_plat_remove(struct platform_device *dev)
 	pm_runtime_disable(&dev->dev);
 	pm_runtime_put_noidle(&dev->dev);
 	pm_runtime_set_suspended(&dev->dev);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_plat_remove);
 
@@ -526,7 +524,7 @@ MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
 
 static struct platform_driver usb_generic_xhci_driver = {
 	.probe	= xhci_generic_plat_probe,
-	.remove	= xhci_plat_remove,
+	.remove_new = xhci_plat_remove,
 	.shutdown = usb_hcd_platform_shutdown,
 	.driver	= {
 		.name = "xhci-hcd",
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 83b5b5aa9f8e..2d15386f2c50 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -25,7 +25,7 @@ struct xhci_plat_priv {
 int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev,
 		    const struct xhci_plat_priv *priv_match);
 
-int xhci_plat_remove(struct platform_device *dev);
+void xhci_plat_remove(struct platform_device *dev);
 extern const struct dev_pm_ops xhci_plat_pm_ops;
 
 #endif	/* _XHCI_PLAT_H */
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index ad966b797b89..bf5261fed32c 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -276,10 +276,10 @@ static int xhci_renesas_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver usb_xhci_renesas_driver = {
-	.probe	= xhci_renesas_probe,
-	.remove	= xhci_plat_remove,
+	.probe = xhci_renesas_probe,
+	.remove_new = xhci_plat_remove,
 	.shutdown = usb_hcd_platform_shutdown,
-	.driver	= {
+	.driver = {
 		.name = "xhci-renesas-hcd",
 		.pm = &xhci_plat_pm_ops,
 		.of_match_table = usb_xhci_of_match,
-- 
2.39.2

