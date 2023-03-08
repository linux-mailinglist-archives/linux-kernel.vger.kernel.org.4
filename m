Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D61D6B07B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjCHNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCHNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:34 -0500
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21582343
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:57 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsg92MnTzMrT9x;
        Wed,  8 Mar 2023 13:53:09 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsg85xHpzMslsW;
        Wed,  8 Mar 2023 13:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279989;
        bh=Z/W9Y8z78AI62F9IAb60Dw83aMzrKQzekSMZDmWIZR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9Rkg9QdwRNM0CgJnkXZbs66hC+nmx1UK3B+4Gz+Zce/6Ts9kOUswW1j5eF1ErHQn
         MUz0mjY5g95DvjZsrcq5JL4G4wcy+jyAYXzuZLvJRSsDKbyx/wV66ig5u+gYv2t+Lv
         AtXPtgMGlMXZ9bMPtd9VWW1OnHONC9eZ/TzLKa/w=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/25] arm64: dts: colibri-imx8x: Add atmel pinctrl groups
Date:   Wed,  8 Mar 2023 13:52:39 +0100
Message-Id: <20230308125300.58244-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add pinctrl groups for enabling atmel touchscreen support.
Remove the pads out of pinctrl_hog0 as they now can be enabled more
specific using pinctrl_atmel_conn label.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 .../boot/dts/freescale/imx8x-colibri.dtsi      | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 7fea99206020..0b84b65c846a 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -134,6 +134,22 @@ pinctrl_adc0: adc0grp {
 			   <IMX8QXP_ADC_IN5_ADMA_ADC_IN5			0x60>;		/* SODIMM   2 */
 	};
 
+	/* Atmel MXT touchsceen + Capacitive Touch Adapter */
+	/* NOTE: This pingroup conflicts with pingroups
+	 * pinctrl_pwm_b/pinctrl_pwm_c. Don't enable them
+	 * simultaneously.
+	 */
+	pinctrl_atmel_adap: atmeladaptergrp {
+		fsl,pins = <IMX8QXP_UART1_RX_LSIO_GPIO0_IO22			0x21>,		/* SODIMM  30 */
+			   <IMX8QXP_UART1_TX_LSIO_GPIO0_IO21			0x4000021>;	/* SODIMM  28 */
+	};
+
+	/* Atmel MXT touchsceen + boards with built-in Capacitive Touch Connector */
+	pinctrl_atmel_conn: atmelconnectorgrp {
+		fsl,pins = <IMX8QXP_QSPI0B_DATA2_LSIO_GPIO3_IO20		0x4000021>,	/* SODIMM 107 */
+			   <IMX8QXP_QSPI0B_SS1_B_LSIO_GPIO3_IO24		0x21>;		/* SODIMM 106 */
+	};
+
 	pinctrl_can_int: canintgrp {
 		fsl,pins = <IMX8QXP_QSPI0A_DQS_LSIO_GPIO3_IO13			0x40>;		/* SODIMM  73 */
 	};
@@ -214,12 +230,10 @@ pinctrl_hog0: hog0grp {
 			   <IMX8QXP_QSPI0A_DATA2_LSIO_GPIO3_IO11		0x20>,		/* SODIMM  69 */
 			   <IMX8QXP_QSPI0B_DATA0_LSIO_GPIO3_IO18		0x20>,		/* SODIMM  99 */
 			   <IMX8QXP_QSPI0B_DATA1_LSIO_GPIO3_IO19		0x20>,		/* SODIMM 105 */
-			   <IMX8QXP_QSPI0B_DATA2_LSIO_GPIO3_IO20		0x20>,		/* SODIMM 107 */
 			   <IMX8QXP_QSPI0B_DATA3_LSIO_GPIO3_IO21		0x20>,		/* SODIMM  98 */
 			   <IMX8QXP_QSPI0B_DQS_LSIO_GPIO3_IO22			0x20>,		/* SODIMM 102 */
 			   <IMX8QXP_QSPI0B_SCLK_LSIO_GPIO3_IO17			0x20>,		/* SODIMM  95 */
 			   <IMX8QXP_QSPI0B_SS0_B_LSIO_GPIO3_IO23		0x20>,		/* SODIMM 104 */
-			   <IMX8QXP_QSPI0B_SS1_B_LSIO_GPIO3_IO24		0x20>,		/* SODIMM 106 */
 			   <IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27			0x20>,		/* SODIMM  97 */
 			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26			0x20>,		/* SODIMM  79 */
 			   <IMX8QXP_SAI0_TXD_LSIO_GPIO0_IO25			0x20>,		/* SODIMM 103 */
-- 
2.39.2

