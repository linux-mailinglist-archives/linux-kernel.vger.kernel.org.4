Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAA701C95
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjENJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjENJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:23:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A51FF6;
        Sun, 14 May 2023 02:23:14 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 21D9421326;
        Sun, 14 May 2023 11:23:12 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 4/4] arm64: dts: colibri-imx8x: delete adc1 and dsp
Date:   Sun, 14 May 2023 11:22:46 +0200
Message-Id: <20230514092246.9741-5-francesco@dolcini.it>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

i.MX8, i.MX8X, i.MX8XP and i.MX8XL SOC device trees are all based on
imx8-ss-*.dtsi files. For i.MX8X and i.MX8XP these device trees
should be updated with some peripherals removed or updated, similar
to i.MX8XL (imx8dxl-ss-*.dtsi files). However, it looks like only
i.MX8 and i.MX8XL are up to date, but for i.MX8X and i.MX8XP some
of the peripherals got inherited from imx8-ss-*.dtsi files, but in
reality they are not present on SOC.
As a result, during resource partition ownership check U-Boot receives
messages from SCU firmware about these resources not owned by boot
partition. In reality, these resources are not owned by anyone, as
they simply does not exist, but are defined in Linux device tree.
This change removes those peripherals, which are listed during
U-Boot resource partition ownership check as warnings:

  ## Flattened Device Tree blob at 9d400000
     Booting using the fdt blob at 0x9d400000
     Loading Device Tree to 00000000fd652000, end 00000000fd67efff ... OK
  Disable clock-controller@59580000 rsrc 512 not owned
  Disable clock-controller@5ac90000 rsrc 102 not owned

  Starting kernel ...

Fixes: ba5a5615d54f ("arm64: dts: freescale: add initial support for colibri imx8x")
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Fixed patch From:
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index b0d6f632622c..49d105eb4769 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -769,3 +769,10 @@ pinctrl_wifi: wifigrp {
 		fsl,pins = <IMX8QXP_SCU_BOOT_MODE3_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20>;
 	};
 };
+
+/* Delete peripherals which are not present on SOC, but are defined in imx8-ss-*.dtsi */
+
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &dsp;
+/delete-node/ &dsp_lpcg;
-- 
2.25.1

