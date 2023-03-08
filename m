Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6B6B07DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjCHNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCHNCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:02:18 -0500
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 05:00:26 PST
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FCC5633
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:25 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgB4L80zMrTB1;
        Wed,  8 Mar 2023 13:53:10 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgB0KBwzMslsV;
        Wed,  8 Mar 2023 13:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279990;
        bh=VG5XVHemEYXmdQeztm//MWBEt3exZaox2vLjN4m5Nz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYdLpbX9gaNyU3JxrDqfscnX8HyPp2r6cTfx6kEWKqB8MlDMJjCSs03yMUeMrXYN9
         lBvM2ykVK0elo0wsI35T3BY+zu6jlT5vcTHfQFP9GwMQRtUrtQ9u/dcCnH49uvyKbM
         4keWjjtbsTnphzcjFxxKRrdDbexr0icIl/FK2+cI=
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
Subject: [PATCH v1 07/25] arm64: dts: colibri-imx8x: Split pinctrl_hog1
Date:   Wed,  8 Mar 2023 13:52:41 +0100
Message-Id: <20230308125300.58244-8-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Split pinctrl_hog1 into a second group so CSI_MCLK can be muxed to a
gpio on its own.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index e1b907b7a85d..432449359625 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -119,7 +119,8 @@ &usdhc2 {
 
 &iomuxc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>;
+	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
+		    <&pinctrl_hog2>;
 
 	/* On-module touch pen-down interrupt */
 	pinctrl_ad7879_int: ad7879intgrp {
@@ -253,6 +254,10 @@ pinctrl_hog1: hog1grp {
 			   <IMX8QXP_QSPI0A_SCLK_LSIO_GPIO3_IO16			0x20>;		/* SODIMM  93 */
 	};
 
+	pinctrl_hog2: hog2grp {
+		fsl,pins = <IMX8QXP_CSI_MCLK_LSIO_GPIO3_IO01			0x20>;		/* SODIMM  75 */
+	};
+
 	/*
 	 * This pin is used in the SCFW as a UART. Using it from
 	 * Linux would require rewritting the SCFW board file.
-- 
2.39.2

