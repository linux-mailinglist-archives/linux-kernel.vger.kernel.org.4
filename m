Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA7714FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjE2TgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2TgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:36:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D70EDC;
        Mon, 29 May 2023 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=kScN4jEpN8ktnFtoDbksBB2wtELQdIZvW75JfnvXhLs=; b=x
        B6iVzQHgT4jvwYWPPow7Pc3Wd3RN5fhtmcU9LA/JFPG4QBDMdc/sUsBR3SBBjrWweFtm9g5scP6/s
        K+aYxd8RyRuwY27nwXiq8LYG64L5rQyaabx0cIOefUtmb9P9nhCO/BazvBGwTq/W67UzpP8o9Jaex
        lM5CvJh+trkOgqiE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35702 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q3ien-0000NW-2t; Mon, 29 May 2023 15:35:53 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 May 2023 15:35:26 -0400
Message-Id: <20230529193525.1034378-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] arm64: dts: imx8mn-var-som-symphony: adapt FEC pinctrl for SOMs with onboard PHY
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The VAR SOM symphony carrier board can be used with SOMs which have a
soldered ethernet PHY onboard and with SOMs which don't have one.

For SOMs with an onboard PHY, the PHY on the cartrier board is not
used, and GPIO1_IO9 is used as a reset line to the onboard PHY.

For SOMs without an onboard PHY, the PHY on the carrier board is
used. For this configuration, pca9534 GPIO 5 (located on the carrier
board) is used as a reset line to the PHY, and GPIO1_IO9 is not
used.

GPIO1_IO9 is not connected to any user-accessible pins or functions,
and leaving it enabled in the mux pinctrl for both configurations is
safe.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../dts/freescale/imx8mn-var-som-symphony.dts | 40 -------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
index 3ed7021a487c..406a711486da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
@@ -152,46 +152,6 @@ &usbotg1 {
 	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
 };
 
-&pinctrl_fec1 {
-	fsl,pins = <
-		MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-		MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-		MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-		MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-		MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-		MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-		MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-		MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-		MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-		MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-		MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-		MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-		MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-		MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
-	>;
-};
-
-&pinctrl_fec1_sleep {
-	fsl,pins = <
-		MX8MN_IOMUXC_ENET_MDC_GPIO1_IO16		0x120
-		MX8MN_IOMUXC_ENET_MDIO_GPIO1_IO17		0x120
-		MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x120
-		MX8MN_IOMUXC_ENET_TD2_GPIO1_IO19		0x120
-		MX8MN_IOMUXC_ENET_TD1_GPIO1_IO20		0x120
-		MX8MN_IOMUXC_ENET_TD0_GPIO1_IO21		0x120
-		MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x120
-		MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x120
-		MX8MN_IOMUXC_ENET_RD1_GPIO1_IO27		0x120
-		MX8MN_IOMUXC_ENET_RD0_GPIO1_IO26		0x120
-		MX8MN_IOMUXC_ENET_TXC_GPIO1_IO23		0x120
-		MX8MN_IOMUXC_ENET_RXC_GPIO1_IO25		0x120
-		MX8MN_IOMUXC_ENET_RX_CTL_GPIO1_IO24		0x120
-		MX8MN_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x120
-		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
-	>;
-};
-
 &iomuxc {
 	pinctrl_captouch: captouchgrp {
 		fsl,pins = <

base-commit: 8b817fded42d8fe3a0eb47b1149d907851a3c942
-- 
2.30.2

