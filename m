Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478CB66A20B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAMS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjAMS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:27:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0359F3D1DF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:24:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOjA-0001QQ-BA; Fri, 13 Jan 2023 19:24:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOj9-005pIg-IG; Fri, 13 Jan 2023 19:24:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOj8-00Cahu-Tc; Fri, 13 Jan 2023 19:24:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] mfd: Make .disable() callback return void
Date:   Fri, 13 Jan 2023 19:24:26 +0100
Message-Id: <20230113182427.257484-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
References: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7785; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bPYUFuMW3ojVjSGXCkZojw3yQUzU0NldGrZgxGM16G8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjwaHU4ghmMiNls4Vb/BnwacnSvaUPTIN303Vm+uRk uPLvHliJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8Gh1AAKCRDB/BR4rcrsCUFRB/ 9b3yeNKQaXJ7aKl0WxPL9Voxbe62vd1Cwh7Rr8k5IERXMjS8dqczU8HXiY4r1rSNdMDbHEJy2bc3nX pVGpFHDAYsvpoqZJAl4nYG+1ptqGPmM2Z6XT74erswCx6qTgTLjiVhHRb5xgijIZkzYmhxfytTNckl lqAGkG6ua+x3TYG6h1+DVRVxy5Z0PVbptEobHshsq2BIV7aHGAdf/ZuVQVV41MuatJM4w6ZgIJ7zpu 9MYkJxrNRA6YxSWFfSOd4iqM04Oxd2faARsiHt7dIoIW/L4dxGEZoz1JB/19PTPoLeImVpVjd5i24L X95Z7V3X6j8KCt3F3mLrktyogPm0/V
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All implementations return 0 unconditionally, so change the prototype to
return void. This allows to get rid of error handling in callers that
isn't actually used.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/asic3.c      | 17 +++++++++--------
 drivers/mfd/htc-pasic3.c |  3 +--
 drivers/mfd/mfd-core.c   |  4 +++-
 drivers/mfd/t7l66xb.c    |  4 +---
 drivers/mfd/tc6387xb.c   |  4 +---
 drivers/mfd/tc6393xb.c   | 16 ++++++++++------
 include/linux/mfd/core.h |  2 +-
 7 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 4fb7e35eb5ed..b62e1732cfd2 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -676,7 +676,7 @@ static int ds1wm_enable(struct platform_device *pdev)
 	return 0;
 }
 
-static int ds1wm_disable(struct platform_device *pdev)
+static void ds1wm_disable(struct platform_device *pdev)
 {
 	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
 
@@ -686,8 +686,6 @@ static int ds1wm_disable(struct platform_device *pdev)
 	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_OWM]);
 	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
 	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
-
-	return 0;
 }
 
 static const struct mfd_cell asic3_cell_ds1wm = {
@@ -769,7 +767,7 @@ static int asic3_mmc_enable(struct platform_device *pdev)
 	return 0;
 }
 
-static int asic3_mmc_disable(struct platform_device *pdev)
+static void asic3_mmc_disable(struct platform_device *pdev)
 {
 	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
 
@@ -782,6 +780,11 @@ static int asic3_mmc_disable(struct platform_device *pdev)
 	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_SD_BUS]);
 	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
 	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
+}
+
+static int asic3_mmc_suspend(struct platform_device *pdev)
+{
+	asic3_mmc_disable(pdev);
 	return 0;
 }
 
@@ -789,7 +792,7 @@ static const struct mfd_cell asic3_cell_mmc = {
 	.name          = "tmio-mmc",
 	.enable        = asic3_mmc_enable,
 	.disable       = asic3_mmc_disable,
-	.suspend       = asic3_mmc_disable,
+	.suspend       = asic3_mmc_suspend,
 	.resume        = asic3_mmc_enable,
 	.platform_data = &asic3_mmc_data,
 	.pdata_size    = sizeof(asic3_mmc_data),
@@ -813,14 +816,12 @@ static int asic3_leds_enable(struct platform_device *pdev)
 	return 0;
 }
 
-static int asic3_leds_disable(struct platform_device *pdev)
+static void asic3_leds_disable(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
 
 	asic3_clk_disable(asic, &asic->clocks[clock_ledn[cell->id]]);
-
-	return 0;
 }
 
 static int asic3_leds_suspend(struct platform_device *pdev)
diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
index 0c46b7e64b2d..57fc18e2194f 100644
--- a/drivers/mfd/htc-pasic3.c
+++ b/drivers/mfd/htc-pasic3.c
@@ -82,7 +82,7 @@ static int ds1wm_enable(struct platform_device *pdev)
 	return 0;
 }
 
-static int ds1wm_disable(struct platform_device *pdev)
+static void ds1wm_disable(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	int c;
@@ -91,7 +91,6 @@ static int ds1wm_disable(struct platform_device *pdev)
 	pasic3_write_register(dev, 0x28, c | 0x80);
 
 	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | 0x80);
-	return 0;
 }
 
 static struct ds1wm_driver_data ds1wm_pdata = {
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 16d1861e9682..b854c4adb527 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -55,7 +55,9 @@ int mfd_cell_disable(struct platform_device *pdev)
 		return 0;
 	}
 
-	return cell->disable(pdev);
+	cell->disable(pdev);
+
+	return 0;
 }
 EXPORT_SYMBOL(mfd_cell_disable);
 
diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 1d9d1d38d068..fd7dfbe64bf5 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -94,7 +94,7 @@ static int t7l66xb_mmc_enable(struct platform_device *mmc)
 	return 0;
 }
 
-static int t7l66xb_mmc_disable(struct platform_device *mmc)
+static void t7l66xb_mmc_disable(struct platform_device *mmc)
 {
 	struct t7l66xb *t7l66xb = dev_get_drvdata(mmc->dev.parent);
 	unsigned long flags;
@@ -109,8 +109,6 @@ static int t7l66xb_mmc_disable(struct platform_device *mmc)
 	raw_spin_unlock_irqrestore(&t7l66xb->lock, flags);
 
 	clk_disable_unprepare(t7l66xb->clk32k);
-
-	return 0;
 }
 
 static void t7l66xb_mmc_pwr(struct platform_device *mmc, int state)
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index 5392da6ba7b0..848058e7fe41 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -96,13 +96,11 @@ static int tc6387xb_mmc_enable(struct platform_device *mmc)
 	return 0;
 }
 
-static int tc6387xb_mmc_disable(struct platform_device *mmc)
+static void tc6387xb_mmc_disable(struct platform_device *mmc)
 {
 	struct tc6387xb *tc6387xb = dev_get_drvdata(mmc->dev.parent);
 
 	clk_disable_unprepare(tc6387xb->clk32k);
-
-	return 0;
 }
 
 static struct tmio_mmc_data tc6387xb_mmc_data = {
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 997bb8b5881d..20521fece1ae 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -241,7 +241,7 @@ static int tc6393xb_ohci_enable(struct platform_device *dev)
 	return 0;
 }
 
-static int tc6393xb_ohci_disable(struct platform_device *dev)
+static void tc6393xb_ohci_disable(struct platform_device *dev)
 {
 	struct tc6393xb *tc6393xb = dev_get_drvdata(dev->dev.parent);
 	unsigned long flags;
@@ -259,8 +259,6 @@ static int tc6393xb_ohci_disable(struct platform_device *dev)
 	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
 
 	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
-
-	return 0;
 }
 
 static int tc6393xb_ohci_suspend(struct platform_device *dev)
@@ -271,7 +269,9 @@ static int tc6393xb_ohci_suspend(struct platform_device *dev)
 	if (tcpd->resume_restore)
 		return -EBUSY;
 
-	return tc6393xb_ohci_disable(dev);
+	tc6393xb_ohci_disable(dev);
+
+	return 0;
 }
 
 static int tc6393xb_fb_enable(struct platform_device *dev)
@@ -292,7 +292,7 @@ static int tc6393xb_fb_enable(struct platform_device *dev)
 	return 0;
 }
 
-static int tc6393xb_fb_disable(struct platform_device *dev)
+static void tc6393xb_fb_disable(struct platform_device *dev)
 {
 	struct tc6393xb *tc6393xb = dev_get_drvdata(dev->dev.parent);
 	unsigned long flags;
@@ -306,7 +306,11 @@ static int tc6393xb_fb_disable(struct platform_device *dev)
 	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
 
 	raw_spin_unlock_irqrestore(&tc6393xb->lock, flags);
+}
 
+static int tc6393xb_fb_suspend(struct platform_device *dev)
+{
+	tc6393xb_fb_disable(dev);
 	return 0;
 }
 
@@ -417,7 +421,7 @@ static struct mfd_cell tc6393xb_cells[] = {
 		.num_resources = ARRAY_SIZE(tc6393xb_fb_resources),
 		.resources = tc6393xb_fb_resources,
 		.enable = tc6393xb_fb_enable,
-		.suspend = tc6393xb_fb_disable,
+		.suspend = tc6393xb_fb_suspend,
 		.resume = tc6393xb_fb_enable,
 		.disable = tc6393xb_fb_disable,
 	},
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 0bc7cba798a3..9833d0501d42 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -69,7 +69,7 @@ struct mfd_cell {
 	int			level;
 
 	int			(*enable)(struct platform_device *dev);
-	int			(*disable)(struct platform_device *dev);
+	void			(*disable)(struct platform_device *dev);
 
 	int			(*suspend)(struct platform_device *dev);
 	int			(*resume)(struct platform_device *dev);
-- 
2.39.0

