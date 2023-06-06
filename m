Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C327247F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbjFFPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFFPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:38:32 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA089139;
        Tue,  6 Jun 2023 08:38:30 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1q6YlJ-0067oT-EH; Tue, 06 Jun 2023 15:38:21 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw7904: enable UART1 hardware flow control
Date:   Tue,  6 Jun 2023 08:38:19 -0700
Message-Id: <20230606153819.1449257-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the GW7904 uart1 can use UART3_TX/RX for hardware flow control
which was the desired default configuration. Remove uart3 and configure
uart1 for hardware flow control.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mm-venice-gw7904.dts     | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index 93088fa1c3b9..c12e3f4f800f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -636,6 +636,8 @@ &pgc_mipi {
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	cts-gpios = <&gpio5 26 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&gpio5 27 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -646,13 +648,6 @@ &uart2 {
 	status = "okay";
 };
 
-/* off-board RS232 */
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
 &usbotg1 {
 	dr_mode = "host";
 	disable-over-current;
@@ -814,6 +809,8 @@ pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
 			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MM_IOMUXC_UART3_RXD_GPIO5_IO26	0x140 /* CTS# in */
+			MX8MM_IOMUXC_UART3_TXD_GPIO5_IO27	0x140 /* RTS# out */
 		>;
 	};
 
@@ -824,13 +821,6 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
-			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
-		>;
-	};
-
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-- 
2.25.1

