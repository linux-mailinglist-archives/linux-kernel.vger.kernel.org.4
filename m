Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8556619190
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiKDHEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKDHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:04:10 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF826AE3;
        Fri,  4 Nov 2022 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=79Yt+xI3nyfmmjW/gak2wEPyuEyW7d5A7MjoAnCDk64=; b=GtP1bFtXawXgLq2XI81vXRxhW1
        ch8xlAsM692omQLq9bE2DxX6zzUjhvWTWu3VrqBceaVH3E6zhCOv9H6c5hC8xPQa0vr9YCa4wvcZP
        zyvKqFP7YXVmcerJ2++yQT+0wARKNovkJYT3OHRC/l7dbcclXKYkUJE2ogZYGUGAGTWcd8gJqntEj
        czn1nY65Ur7Qre/7FZkg74yFQGNCmoJRwO8TOlOy97eBp2bhrpxJPDp3sKrpz1fDFZiiHhEM8tbnc
        u0sPT8NRmmV4YnXDa2pkeqQPg/ce5/hA0rTtA4Z98UU59u3SVE01XF95Y1eezoX44dEFb6S/xEmMm
        8R+dJsSw==;
Received: from [89.212.21.243] (port=40616 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1oqqk7-00EcG2-CF;
        Fri, 04 Nov 2022 08:04:02 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Date:   Fri,  4 Nov 2022 08:03:56 +0100
Message-Id: <20221104070358.426657-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221104070358.426657-1-andrej.picej@norik.com>
References: <20221104070358.426657-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting device into the "Suspend-To-Idle" mode causes watchdog to
trigger and resets the board after set watchdog timeout period elapses.

Introduce new device-tree property "fsl,suspend-in-wait" which suspends
watchdog in WAIT mode. This is done by setting WDW bit in WCR
(Watchdog Control Register). Watchdog operation is restored after
exiting WAIT mode as expected. WAIT mode corresponds with Linux's
"Suspend-To-Idle".

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v4:
 - added a reviewed-by from Guenter.

Changes in v3:
 - fix spelling in commit message,
 - fix and simplify property handling in probe,
 - add a comment about unknown interaction between imx7d no-ping
   functionality and "fsl,suspend-in-wait",
 - property support handled by of_device_id data pointer.

Changes in v2:
 - validate the property with compatible string, as this functionality
   is not supported by all devices.
---
 drivers/watchdog/imx2_wdt.c | 55 +++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index d0c5d47ddede..19ab7b3d286b 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
@@ -35,6 +36,7 @@
 
 #define IMX2_WDT_WCR		0x00		/* Control Register */
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
 #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
 #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
 #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
@@ -60,13 +62,19 @@
 
 #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
 
+struct imx2_wdt_data {
+	bool wdw_supported;
+};
+
 struct imx2_wdt_device {
 	struct clk *clk;
 	struct regmap *regmap;
 	struct watchdog_device wdog;
+	const struct imx2_wdt_data *data;
 	bool ext_reset;
 	bool clk_is_on;
 	bool no_ping;
+	bool sleep_wait;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -129,6 +137,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 
 	/* Suspend timer in low power mode, write once-only */
 	val |= IMX2_WDT_WCR_WDZST;
+	/* Suspend timer in low power WAIT mode, write once-only */
+	if (wdev->sleep_wait)
+		val |= IMX2_WDT_WCR_WDW;
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate internal chip-level reset if WDOG times out */
@@ -292,6 +303,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->max_hw_heartbeat_ms = IMX2_WDT_MAX_TIME * 1000;
 	wdog->parent		= dev;
 
+	wdev->data = of_device_get_match_data(dev);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret > 0)
 		if (!devm_request_irq(dev, ret, imx2_wdt_isr, 0,
@@ -313,9 +326,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 	wdev->ext_reset = of_property_read_bool(dev->of_node,
 						"fsl,ext-reset-output");
+
+	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait")) {
+		if (!wdev->data->wdw_supported) {
+			dev_err(dev, "suspend-in-wait not supported\n");
+			return -EINVAL;
+		}
+		wdev->sleep_wait = true;
+	}
+
 	/*
 	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
-	 * during suspend.
+	 * during suspend. Interaction with "fsl,suspend-in-wait" is unknown!
 	 */
 	wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");
 	platform_set_drvdata(pdev, wdog);
@@ -417,9 +439,36 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
 			 imx2_wdt_resume);
 
+struct imx2_wdt_data imx_wdt = {
+	.wdw_supported = true,
+};
+
+struct imx2_wdt_data imx_wdt_legacy = {
+	.wdw_supported = false,
+};
+
 static const struct of_device_id imx2_wdt_dt_ids[] = {
-	{ .compatible = "fsl,imx21-wdt", },
-	{ .compatible = "fsl,imx7d-wdt", },
+	{ .compatible = "fsl,imx21-wdt", .data = &imx_wdt_legacy },
+	{ .compatible = "fsl,imx25-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx27-wdt", .data = &imx_wdt_legacy },
+	{ .compatible = "fsl,imx31-wdt", .data = &imx_wdt_legacy },
+	{ .compatible = "fsl,imx35-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx50-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx51-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx53-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx6q-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx6sl-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx6sll-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx6sx-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx6ul-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx7d-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx8mm-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx8mn-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx8mp-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,imx8mq-wdt", .data = &imx_wdt },
+	{ .compatible = "fsl,ls1012a-wdt", .data = &imx_wdt_legacy },
+	{ .compatible = "fsl,ls1043a-wdt", .data = &imx_wdt_legacy },
+	{ .compatible = "fsl,vf610-wdt", .data = &imx_wdt },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
-- 
2.25.1

