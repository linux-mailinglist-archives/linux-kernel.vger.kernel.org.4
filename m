Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F462EC51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiKRDSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiKRDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:18:21 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1757F8DA6B;
        Thu, 17 Nov 2022 19:18:18 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A24B71A1251;
        Fri, 18 Nov 2022 04:18:16 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 699611A1244;
        Fri, 18 Nov 2022 04:18:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 941C418002F4;
        Fri, 18 Nov 2022 11:18:14 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com, marex@denx.de,
        tharvey@gateworks.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, richard.leitner@linux.dev
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL configurations
Date:   Fri, 18 Nov 2022 10:56:39 +0800
Message-Id: <1668740199-31956-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe SYSPLL configurations, thus the internal SYSPLL can be used as
i.MX8MP PCIe reference clock.

The following properties of PHY dts node should be changed accordingly.
  - Set 'fsl,refclk-pad-mode' as '<IMX8_PCIE_REFCLK_PAD_OUTPUT>'.
  - Change 'clocks' to '<&clk IMX8MP_CLK_HSIO_AXI>'.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v1->v2:
Refer to Lucas' comments, don't expose IMX8MP_CLK_HSIO_ROOT to dts node.
https://patchwork.ozlabs.org/project/linux-pci/patch/1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com/

Use <&clk IMX8MP_CLK_HSIO_AXI> as referrence clock source when internal
clock mode is used by i.MX8MP PCIe module.

Verified on i.MX8MP EVK board with removing R131/R132/R137/R138, and
populating R135/R136.
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0e3b6ba22f94..5ad20a8ea25e 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -21,6 +21,16 @@
 #define  USB_CLOCK_MODULE_EN	BIT(1)
 #define  PCIE_PHY_APB_RST	BIT(4)
 #define  PCIE_PHY_INIT_RST	BIT(5)
+#define GPR_REG2		0x8
+#define  P_PLL_MASK		GENMASK(5, 0)
+#define  M_PLL_MASK		GENMASK(15, 6)
+#define  S_PLL_MASK		GENMASK(18, 16)
+#define  P_PLL			(0xc << 0)
+#define  M_PLL			(0x320 << 6)
+#define  S_PLL			(0x4 << 16)
+#define GPR_REG3		0xc
+#define  PLL_CKE		BIT(17)
+#define  PLL_RST		BIT(31)
 
 struct imx8mp_blk_ctrl_domain;
 
@@ -86,6 +96,18 @@ static void imx8mp_hsio_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
 		regmap_set_bits(bc->regmap, GPR_REG0,
 				PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
+
+		/* Set the PLL configurations, P = 12, M = 800, S = 4. */
+		regmap_update_bits(bc->regmap, GPR_REG2,
+				   P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
+				   P_PLL | M_PLL | S_PLL);
+		udelay(1);
+
+		regmap_update_bits(bc->regmap, GPR_REG3, PLL_RST, PLL_RST);
+		udelay(10);
+
+		/* Set 1b'1 to pll_cke of GPR_REG3 */
+		regmap_update_bits(bc->regmap, GPR_REG3, PLL_CKE, PLL_CKE);
 		break;
 	default:
 		break;
-- 
2.25.1

