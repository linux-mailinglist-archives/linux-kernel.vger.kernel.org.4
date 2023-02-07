Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCA68CE51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBGEoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBGEoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:44:11 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4027D59;
        Mon,  6 Feb 2023 20:44:10 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D4F951A1200;
        Tue,  7 Feb 2023 05:44:08 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E69F1A0B82;
        Tue,  7 Feb 2023 05:44:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B97D0183ABF0;
        Tue,  7 Feb 2023 12:44:06 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        lorenzo.pieralisi@arm.com, peng.fan@nxp.com, marex@denx.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v10 3/4] arm64: dts: Add i.MX8MQ PCIe EP support
Date:   Tue,  7 Feb 2023 12:18:27 +0800
Message-Id: <1675743508-24702-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675743508-24702-1-git-send-email-hongxing.zhu@nxp.com>
References: <1675743508-24702-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8MQ PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 98fbba4c99a9..9f950a6ac6c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1605,6 +1605,38 @@ pcie1: pcie@33c00000 {
 			status = "disabled";
 		};
 
+		pcie1_ep: pcie-ep@33c00000 {
+			compatible = "fsl,imx8mq-pcie-ep";
+			reg = <0x33c00000 0x000400000>,
+			      <0x20000000 0x08000000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			fsl,max-link-speed = <2>;
+			clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
+				 <&clk IMX8MQ_CLK_PCIE2_PHY>,
+				 <&clk IMX8MQ_CLK_PCIE2_PHY>,
+				 <&clk IMX8MQ_CLK_PCIE2_AUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
+				 <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
+				 <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			assigned-clocks = <&clk IMX8MQ_CLK_PCIE2_CTRL>,
+					  <&clk IMX8MQ_CLK_PCIE2_PHY>,
+					  <&clk IMX8MQ_CLK_PCIE2_AUX>;
+			assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_250M>,
+						 <&clk IMX8MQ_SYS2_PLL_100M>,
+						 <&clk IMX8MQ_SYS1_PLL_80M>;
+			assigned-clock-rates = <250000000>, <100000000>,
+					       <10000000>;
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.34.1

