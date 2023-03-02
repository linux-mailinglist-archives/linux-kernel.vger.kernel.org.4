Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15826A848D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCBOsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCBOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30343937
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-0003wl-Ta; Thu, 02 Mar 2023 15:47:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001LsB-7x; Thu, 02 Mar 2023 15:47:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-001ZqU-LV; Thu, 02 Mar 2023 15:47:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/29] platform/x86: intel: int0002_vgpio: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:22 +0100
Message-Id: <20230302144732.1903781-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iMzvEUqbb2rVuVtUa7k/9sDC9oHzlYpq3RgIdsmfWLU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbUqZeyydEqf9Lx4bdId4bvO/zQTf+JMBtAL DyBJyhKW+iJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC21AAKCRDB/BR4rcrs CeL8B/wLiJWJ+Cc+G4vGlLIb0gmj6OIjaI3tm75Qj3ZIxPJBm7dK7o7J/6y/PsDTqORP1b0D4t7 Zh0w7lEVWfjU4FYUnjygZFPPZKS7W/MkXmQkeohk2CYGcv6MS6+vd3l08/IIRLRvpHrUMmDFXFz pebUcKlbaNjYnIFDmfTrAAXBXmiKkwEWwTMUeOc5IoOzQuLgPPDm7gN8BerDOFTF7D+PGqtw2VJ e52arbYSVrWi5SBiL+Uka7RklzUtVMF/XvVWmEXZNlfSAqxYF5/ubtnJ52brgcpRD/xV9Lb9aE5 +Jde4XFPLDi8yGH1Akd6cp7KaGiT/9TvzfdwlADpf22HymlD
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

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/platform/x86/intel/int0002_vgpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
index 97cfbc520a02..b6708bab7c53 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -223,11 +223,10 @@ static int int0002_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int int0002_remove(struct platform_device *pdev)
+static void int0002_remove(struct platform_device *pdev)
 {
 	device_init_wakeup(&pdev->dev, false);
 	acpi_unregister_wakeup_handler(int0002_check_wake, NULL);
-	return 0;
 }
 
 static int int0002_suspend(struct device *dev)
@@ -273,7 +272,7 @@ static struct platform_driver int0002_driver = {
 		.pm			= &int0002_pm_ops,
 	},
 	.probe	= int0002_probe,
-	.remove	= int0002_remove,
+	.remove_new = int0002_remove,
 };
 
 module_platform_driver(int0002_driver);
-- 
2.39.1

