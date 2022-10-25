Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77C60C50A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiJYH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJYH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:26:00 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279C107AB9;
        Tue, 25 Oct 2022 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aJweMiiv60aAvd4o0keDrFaMyPWSNSdiMVKyzovAEWY=; b=dBJ2HGYfx6LE4X5Bjq6pWYx6S0
        /Zs6Z2T2mGZdsLVF0i9pCYxmv3GYzLsJjky9Ri2xs1bwK4G5rR26sb3PGAVt1dkJSXjnwJ8sez1iR
        JRtEWaZQbGHOIlixqhjwBD0Catt3jQnkD72YIQQpNGa+2EjRkj5+N8kbh9rUWhvV+RnUBuu7+xgql
        Gkx9Eh07Qi8bCyccmVDjITRitPZdyUHRMWtZdl/ga+g/I4O2kWUyCcgRZAdYwC7RGu9GMSBuNDsFh
        4qYIn8DYix+MWbxnKtIBlozbbPahfSiBFzDYv8pT+oqDqb5UTPRQJly0CtetW40jnEqv00qqxdEek
        mnOJDwfA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:33544 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1onEJZ-006HEZ-Gk;
        Tue, 25 Oct 2022 09:25:40 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Date:   Tue, 25 Oct 2022 09:25:31 +0200
Message-Id: <20221025072533.2980154-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025072533.2980154-1-andrej.picej@norik.com>
References: <20221025072533.2980154-1-andrej.picej@norik.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting device into the "Suspend-To-Idle" mode causes watchdog to
trigger and reset the board after set watchdog timeout period elapses.

Introduce new device-tree property "fsl,suspend-in-wait" which suspends
watchdog in WAIT mode. This is done by setting WDW bit in WCR
(Watchdog Control Register) Watchdog operation is restored after exiting
WAIT mode as expected. WAIT mode coresponds with Linux's
"Suspend-To-Idle".

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v2:
 - validate the property with compatible string, as this functionality
   is not supported by all devices.
---
 drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index d0c5d47ddede..dd9866c6f1e5 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -35,6 +35,7 @@
 
 #define IMX2_WDT_WCR		0x00		/* Control Register */
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
 #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
 #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
 #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
@@ -67,6 +68,27 @@ struct imx2_wdt_device {
 	bool ext_reset;
 	bool clk_is_on;
 	bool no_ping;
+	bool sleep_wait;
+};
+
+static const char * const wdw_boards[] __initconst = {
+	"fsl,imx25-wdt",
+	"fsl,imx35-wdt",
+	"fsl,imx50-wdt",
+	"fsl,imx51-wdt",
+	"fsl,imx53-wdt",
+	"fsl,imx6q-wdt",
+	"fsl,imx6sl-wdt",
+	"fsl,imx6sll-wdt",
+	"fsl,imx6sx-wdt",
+	"fsl,imx6ul-wdt",
+	"fsl,imx7d-wdt",
+	"fsl,imx8mm-wdt",
+	"fsl,imx8mn-wdt",
+	"fsl,imx8mp-wdt",
+	"fsl,imx8mq-wdt",
+	"fsl,vf610-wdt",
+	NULL
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 
 	/* Suspend timer in low power mode, write once-only */
 	val |= IMX2_WDT_WCR_WDZST;
+	/* Suspend timer in low power WAIT mode, write once-only */
+	if (wdev->sleep_wait)
+		val |= IMX2_WDT_WCR_WDW;
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate internal chip-level reset if WDOG times out */
@@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 	wdev->ext_reset = of_property_read_bool(dev->of_node,
 						"fsl,ext-reset-output");
+
+	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
+		if (of_device_compatible_match(dev->of_node, wdw_boards))
+			wdev->sleep_wait = 1;
+		else {
+			dev_warn(dev, "Warning: Suspending watchdog during " \
+				"WAIT mode is not supported for this device.\n");
+			wdev->sleep_wait = 0;
+		}
+	else
+		wdev->sleep_wait = 0;
+
 	/*
 	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
 	 * during suspend.
-- 
2.25.1

