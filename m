Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653756B8FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCNK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCNK0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:26:13 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6142A2799E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:25:21 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4m4tFdzMqPvm;
        Tue, 14 Mar 2023 11:24:24 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4m1JcSz2N3f;
        Tue, 14 Mar 2023 11:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789464;
        bh=HIHduv343O/RfhGallEGN58ltkLdGgRfwOahZt9TG1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7e8l1v34pvPTt4I0WPFXow4DQk+XHDkfDER61PaIpFDZvcriA5QBtA0GPI0vTlbB
         xi9d8RStN38aBII5E0UcMF2MMmygwIYUcGDLUG4eyTKGyXSgKvGi0xQLRIP9YUjVp0
         m4/KPm+GlBLSKYuHn0eyQXEfzkNZQlq1kkiVxbqo=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/23] arm64: dts: colibri-imx8x: Split pinctrl_hog1
Date:   Tue, 14 Mar 2023 11:23:52 +0100
Message-Id: <20230314102410.424773-7-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index a352246aa1f3..10dce84dc153 100644
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

