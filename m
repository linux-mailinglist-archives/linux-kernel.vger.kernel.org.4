Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0A701C93
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjENJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:23:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04231FFE;
        Sun, 14 May 2023 02:23:14 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id A650B2127F;
        Sun, 14 May 2023 11:23:10 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/4] arm64: dts: colibri-imx8x: fix eval board pin configuration
Date:   Sun, 14 May 2023 11:22:43 +0200
Message-Id: <20230514092246.9741-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230514092246.9741-1-francesco@dolcini.it>
References: <20230514092246.9741-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Fix pinctrl groups to have SODIMM 75 only in one group.
Remove configuration of the pin at SoM level because it is normally
used as CSI_MCLK at camera interface connector.
Without this fix it is not possible, without redefining iomuxc pinctrl,
to use CSI_MCLK signal and leads to the following error messages:

imx8qxp-pinctrl scu:pinctrl: pin IMX8QXP_CSI_MCLK already requested
imx8qxp-pinctrl scu:pinctrl: pin-147 (16-003c) status -22

Fixes: 4d2adf738169 ("arm64: dts: colibri-imx8x: Split pinctrl_hog1")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: remove stray newline after Fixes: tag
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 7cad79102e1a..6f88c11f16e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -365,7 +365,7 @@ &usdhc2 {
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
-		    <&pinctrl_hog2>, <&pinctrl_lpspi2_cs2>;
+		    <&pinctrl_lpspi2_cs2>;
 
 	/* On-module touch pen-down interrupt */
 	pinctrl_ad7879_int: ad7879intgrp {
@@ -499,8 +499,7 @@ pinctrl_hog0: hog0grp {
 	};
 
 	pinctrl_hog1: hog1grp {
-		fsl,pins = <IMX8QXP_CSI_MCLK_LSIO_GPIO3_IO01			0x20>,		/* SODIMM  75 */
-			   <IMX8QXP_QSPI0A_SCLK_LSIO_GPIO3_IO16			0x20>;		/* SODIMM  93 */
+		fsl,pins = <IMX8QXP_QSPI0A_SCLK_LSIO_GPIO3_IO16			0x20>;		/* SODIMM  93 */
 	};
 
 	pinctrl_hog2: hog2grp {
-- 
2.25.1

