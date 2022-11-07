Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12D61FE65
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiKGTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiKGTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:14:09 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 11:14:08 PST
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833FC1E71E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:14:08 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1os6h2-000VhV-EN; Mon, 07 Nov 2022 18:17:56 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8m{m,n}-venice-gw7902: add gpio pins for new board revision
Date:   Mon,  7 Nov 2022 10:17:54 -0800
Message-Id: <20221107181754.218158-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio pins present on new board revision:
 * LTE modem support (imx8mm-gw7902 only)
  - lte_pwr#
  - lte_rst
  - lte_int
 * M2 power enable
  - m2_pwr_en
 * off-board 4.0V supply
  - vdd_4p0_en

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../boot/dts/freescale/imx8mm-venice-gw7902.dts      | 12 ++++++++----
 .../boot/dts/freescale/imx8mn-venice-gw7902.dts      |  8 ++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 0359dca031c8..11481e09c75b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -261,7 +261,7 @@ ethphy0: ethernet-phy@0 {
 
 &gpio1 {
 	gpio-line-names = "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "m2_reset", "", "m2_wdis#",
+		"m2_pwr_en", "", "", "", "", "m2_reset", "", "m2_wdis#",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
 };
@@ -283,7 +283,8 @@ &gpio3 {
 &gpio4 {
 	gpio-line-names = "", "", "", "", "", "", "", "",
 		"", "", "", "amp_gpio3", "amp_gpio2", "", "amp_gpio1", "",
-		"", "", "", "", "amp_gpio4", "app_gpio1", "", "uart1_rs485",
+		"lte_pwr#", "lte_rst", "lte_int", "",
+		"amp_gpio4", "app_gpio1", "vdd_4p0_en", "uart1_rs485",
 		"", "uart1_term", "uart1_half", "app_gpio2",
 		"mipi_gpio1", "", "", "";
 };
@@ -750,14 +751,19 @@ &iomuxc {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x40000159 /* M2_GDIS# */
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x40000041 /* M2_PWR_EN */
 			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000041 /* M2_RESET */
 			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7	0x40000119 /* M2_OFF# */
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x40000159 /* M2_WDIS# */
+			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18       0x40000041 /* LTE_INT */
+			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17       0x40000041 /* LTE_RST# */
+			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16       0x40000041 /* LTE_PWR */
 			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14	0x40000041 /* AMP GPIO1 */
 			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12	0x40000041 /* AMP GPIO2 */
 			MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11	0x40000041 /* AMP GPIO3 */
 			MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20	0x40000041 /* AMP_GPIO4 */
 			MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x40000041 /* APP GPIO1 */
+			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22	0x40000041 /* VDD_4P0_EN */
 			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x40000041 /* APP GPIO2 */
 			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x40000041 /* UART2_EN# */
 			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x40000041 /* MIPI_GPIO1 */
@@ -791,8 +797,6 @@ MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
 			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
 			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19 /* RST# */
 			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19 /* IRQ# */
-			MX8MM_IOMUXC_GPIO1_IO08_ENET1_1588_EVENT0_IN	0x141
-			MX8MM_IOMUXC_GPIO1_IO09_ENET1_1588_EVENT0_OUT	0x141
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 187e0410b87d..97582db71ca8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -256,7 +256,7 @@ ethphy0: ethernet-phy@0 {
 
 &gpio1 {
 	gpio-line-names = "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "m2_reset", "", "m2_wdis#",
+		"m2_pwr_en", "", "", "", "", "m2_reset", "", "m2_wdis#",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
 };
@@ -278,7 +278,7 @@ &gpio3 {
 &gpio4 {
 	gpio-line-names = "", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "app_gpio1", "", "uart1_rs485",
+		"", "", "", "", "", "app_gpio1", "vdd_4p0_en", "uart1_rs485",
 		"", "uart1_term", "uart1_half", "app_gpio2",
 		"mipi_gpio1", "", "", "";
 };
@@ -701,10 +701,12 @@ &iomuxc {
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x40000159 /* M2_GDIS# */
+			MX8MN_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x40000041 /* M2_PWR_EN */
 			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000041 /* M2_RESET */
 			MX8MN_IOMUXC_NAND_DATA01_GPIO3_IO7	0x40000119 /* M2_OFF# */
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x40000159 /* M2_WDIS# */
 			MX8MN_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x40000041 /* APP GPIO1 */
+			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x40000041 /* VDD_4P0_EN */
 			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27	0x40000041 /* APP GPIO2 */
 			MX8MN_IOMUXC_SD1_DATA6_GPIO2_IO8	0x40000041 /* UART2_EN# */
 			MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x40000041 /* MIPI_GPIO1 */
@@ -738,8 +740,6 @@ MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
 			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
 			MX8MN_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19 /* RST# */
 			MX8MN_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19 /* IRQ# */
-			MX8MN_IOMUXC_GPIO1_IO08_ENET1_1588_EVENT0_IN	0x141
-			MX8MN_IOMUXC_GPIO1_IO09_ENET1_1588_EVENT0_OUT	0x141
 		>;
 	};
 
-- 
2.25.1

