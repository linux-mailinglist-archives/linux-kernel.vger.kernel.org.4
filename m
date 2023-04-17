Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A256E4F66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDQRj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDQRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:39:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A653AD38;
        Mon, 17 Apr 2023 10:39:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r15so4669317wmo.1;
        Mon, 17 Apr 2023 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753151; x=1684345151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ieDwkRbhuGtBTgJ4hOuFJkUlUo/FNB20cmPOQ1PxlQ=;
        b=dzUrRtQkog8JNXGtZoiC7CP+HTXCAQ9v4suq8iLyRHwcHjnosnjoOp1/z00XXRaR/z
         3IXC/WUMCCftHOJuVXpTHXptlFVHH0vXL8bWaUUCkyJ2lipZ5x320iNXy1osMJ31chsx
         3UeC2Do+coPSWPt4eIpOSKxm8wQg4Xmi7cwTKsCwvelKlqf8ubQk6BlOf6AJa7jiLvdV
         Iub8emhrPLAPUyeaE+5+kI9xRSAcOQFv0VTfmLUUIaxwT/SZkhaTz2/KsMzZXtxHcJhS
         DO8RbBZVcqnDg2FWAHZUA+bbY91JKjKyjfjkyo2A9eYMsi7MMgyuoZoeFHJ0SAC0fkRt
         PGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753151; x=1684345151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ieDwkRbhuGtBTgJ4hOuFJkUlUo/FNB20cmPOQ1PxlQ=;
        b=jXRS9PCA4aaet2CUJGYmElFmcimraBoYf1G79Mo636L6dAFvZdwGp4yR7V95wCAj9T
         +XAvBQ+9X2RMe5hBr1Ple/mWsM/NdDMLnVFdF+MAWY52SehtbdU0xLeNnBrH6qTAMugZ
         smxKT15tSoVW9cTA08BQaqrQa6RmO4dUD2CDnIHappeLbMwfc8qFOhXf1CqwObmgDyKK
         NIScrAl0A38NBaw9Z3a8MbXjt0YF0iQYqD2jNlex6URzbj++watKxtEsmZfyOJz+FRn+
         ZCQBu2xmaV6e3dgoqJjQYsfRT5NmF9JOeRV7KrAiJTN2uK65PIrk2lAUAuGNhGcE5fyW
         VTTg==
X-Gm-Message-State: AAQBX9eYOBsKrBVB0HFKp8ORf1Dc2mni0u+qmwGz58CZotg1Fgjx8x6V
        KlJptbuaBHo9hOUjeItHTY06g+l0IYggWQ==
X-Google-Smtp-Source: AKy350acDiZjZ/q8MEpKibMOeWoQQvMBufVGART6kFvMm7dpJYWzgvi7Mk44pQ8mdwP7UAQSTuaddg==
X-Received: by 2002:a7b:c40b:0:b0:3ed:d3a7:7077 with SMTP id k11-20020a7bc40b000000b003edd3a77077mr10800678wmi.40.1681753151293;
        Mon, 17 Apr 2023 10:39:11 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (35.145.195.178.dynamic.wline.res.cust.swisscom.ch. [178.195.145.35])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b003f174cafcdasm2478211wmb.7.2023.04.17.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:39:10 -0700 (PDT)
From:   Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 1/4] arm64: dts: colibri-imx8x: fix eval board pin configuration
Date:   Mon, 17 Apr 2023 19:38:27 +0200
Message-Id: <20230417173830.19401-2-andrejs.cainikovs@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
References: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.34.1

