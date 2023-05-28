Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1A71391E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjE1LBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1LBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:01:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E3A4;
        Sun, 28 May 2023 04:01:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-774942ddfe0so195591139f.2;
        Sun, 28 May 2023 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685271690; x=1687863690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkMaF9pneMrwfmhiBRVoj4SpGPwujdRU2k9Az0h/lmc=;
        b=AxAWotZKLbRtgsSNbmdTpajdRsqG/hQgDmGRDE+5yzB8UY4C99vNnHJremno3J0V7Y
         6FG+0kB3CXUr4yBMUUbY5qEi2z213if5IOdR20aqSJ+Cr4WjRRGIMQq8pX1T2LJ+uzw1
         htMikANOwH3+Trss2ke/Vahw2WLPw6/yB9uQxQZ1dZUBfng3TJ4OgwZUyh+ugPurx3UE
         6bI3aw/UtIwL+q+io5WQZoo2sICFrMsjOWHwJYvovK4DnrCiMZ6IPWGfakKqaTEfLp3f
         F+BnWs+evKJYs/sfjWGXxdygU49hTePKpw/98+abJ+n6fXtlaKi2uzJAjsuVx+Jwh2Wk
         A4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685271690; x=1687863690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkMaF9pneMrwfmhiBRVoj4SpGPwujdRU2k9Az0h/lmc=;
        b=CFTdnbqS68/wSOPMKFebYNVubkok+DDOQC/lMcRnoHWJi2AFSxnM0jr71OB7FZZgaS
         U/wub/MxPz/d5xETF8WLUlg2kTugn+YP5Jmwt5L5FF74ZuF2SF9fGWcMTxSyyxtI5v4I
         E8MBrnedoQ3n76+3TA0UqKI8LPQ6WVicLIcHVh57I/D+8w88W4Gdzot6m1+d0szAFxTR
         KUJuJJZFit5AEttoKlhVGauAgM2RrL4nkYa3ijR9IZY2cfuiEpohJrmTdvFdbDhq936O
         XxQyawT5WQZKNVU+Bf60EljtSLh4jQAxa4CwfDVzmg3rLys4KyQjgdQ2L4jEFldTvhj9
         GqwA==
X-Gm-Message-State: AC+VfDwKp1gvF0B/DS07T6p9D0idHd1x27pmHZKrxf3zhlKG/GXpgeh4
        2GXnMVL8TAZNyR+siMHgAp4=
X-Google-Smtp-Source: ACHHUZ7zW6LGywa3f2Fjl8NIEFASVtfW7w0jlb0cHvDENj4iS9MBLytMBsaBAjUYQmUsQcaaEjnIjA==
X-Received: by 2002:a6b:730b:0:b0:763:b459:a701 with SMTP id e11-20020a6b730b000000b00763b459a701mr6179135ioh.1.1685271689687;
        Sun, 28 May 2023 04:01:29 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2abe:81ec:481:190b])
        by smtp.gmail.com with ESMTPSA id bw12-20020a056638460c00b0040f8b6933f0sm2218795jab.74.2023.05.28.04.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 04:01:29 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio CODEC
Date:   Sun, 28 May 2023 06:01:19 -0500
Message-Id: <20230528110119.2632850-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The baseboard has an WM8962 Audio CODEC connected to the SAI3
peripheral.  The CODEC supports stereo in and out
and a microphone input connected to the headphone jack.
Route this CODEC through the simple-audio-card driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Fix whitespace

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index cdae45a48c2c..06e91297fb16 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -118,6 +118,15 @@ pcie0_refclk: clock-pcie {
 		clock-frequency = <100000000>;
 	};
 
+	reg_audio: regulator-wm8962 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_aud";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -137,6 +146,32 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
 		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	sound-wm8962 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8962";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "Headphone", "Headphones",
+					    "Microphone", "Headset Mic",
+					    "Speaker", "Speaker";
+		simple-audio-card,routing = "Headphones", "HPOUTL",
+					    "Headphones", "HPOUTR",
+					    "Speaker", "SPKOUTL",
+					    "Speaker", "SPKOUTR",
+					    "Headset Mic", "MICBIAS",
+					    "IN3R", "Headset Mic";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+			frame-master;
+			bitclock-master;
+		};
+	};
 };
 
 &ecspi2 {
@@ -239,6 +274,34 @@ &i2c4 {
 	clock-frequency = <384000>;
 	status = "okay";
 
+	wm8962: audio-codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wm8962>;
+		clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+		assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+		assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
+		assigned-clock-rates = <22576000>;
+		DCVDD-supply = <&reg_audio>;
+		DBVDD-supply = <&reg_audio>;
+		AVDD-supply = <&reg_audio>;
+		CPVDD-supply = <&reg_audio>;
+		MICVDD-supply = <&reg_audio>;
+		PLLVDD-supply = <&reg_audio>;
+		SPKVDD1-supply = <&reg_audio>;
+		SPKVDD2-supply = <&reg_audio>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+		#sound-dai-cells = <0>;
+	};
+
 	pca6416: gpio@20 {
 		compatible = "nxp,pcal6416";
 		reg = <0x20>;
@@ -315,6 +378,16 @@ &pcie_phy {
 	status = "okay";
 };
 
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -477,6 +550,16 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
+		>;
+	};
+
 	pinctrl_tpm: tpmgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19 /* Reset */
@@ -547,4 +630,10 @@ pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
 		>;
 	};
+
+	pinctrl_wm8962: wm8962grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1	0x59
+		>;
+	};
 };
-- 
2.39.2

