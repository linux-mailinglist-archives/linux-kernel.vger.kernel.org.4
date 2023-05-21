Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0873870B1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjEUXJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 19:09:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E749C3;
        Sun, 21 May 2023 16:09:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-76fe17da95fso54027339f.2;
        Sun, 21 May 2023 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684710549; x=1687302549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjwrZuMDrC6WFZ1mTk1to2SpSffKYMQEgBxEDnlWdIc=;
        b=cCVsXoU7POSFFTR4m3QBPhNyoH8d0VaAPkenpPWIXMj/J1RVi8lhAeuKM9ojWv6b1/
         jWKhedJfZH3iUmWHyyb1acZArRe5oNIoECrVU0X/mbHoqvAfuaVaCqJ13I0SDZClwgze
         vxAdrjWc0O1r92yhAnhBiKGzGrPOr4UnWN3XLeE6uwLp/Pf9DaRtKWZud3AxREia1P79
         XJKI9rOKGQLAqf+oefhq3CIpO8Y4zOMW8mlLJjY8xfruX1HYqrCaBszsJUGWUfWgtXD9
         5ovVRunirhpql9NQmBG8zXxIcqjYzDsEpm+MyGqQXQYJfg6SIX62WAYNWL8Ya30iy+Um
         j9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684710549; x=1687302549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjwrZuMDrC6WFZ1mTk1to2SpSffKYMQEgBxEDnlWdIc=;
        b=OsXUoN2a9IEPI17MNRZHZ6Yvrk6Ipm0TmeNW2I4bIRSlcluED/xTEQ0aVzv5gG0oJR
         DaznBZY1pJXTIr0jSpQz0rI3X9UA8XB28mjWQXSqc5/yKeUfCIkvO+CpUWKNBLzJahU7
         5NHpnQAb8Bs229F2zY6w57ANdaAf+XX8UFF3tA+llsLl956/5toNpO/0KT0h/78RWqIs
         Hs/qUhHyXss1AW0L5sK/UbHdyFqrgIWMCi/lW+iKSz4Y74BotgtHdVbdidm6uH+7I4DI
         r2IYzj5/X+9WnStTBqjjhe0vBUafpCHvuD1OatJvHkluLgwSUR9Y1VI+UTzwGXldCxOW
         /5Tw==
X-Gm-Message-State: AC+VfDzPtXs2K1DweAhbgDymdPLMMR3DCxvzT3DtrdeyFFpOCDdWD/Wq
        54/PQHr6CuwXbG09o9fverM=
X-Google-Smtp-Source: ACHHUZ6hEymCyAO8qSLMHwmYiE18Mn8T3gY0/U+0sUgdPdOk3YVkkentS0EH8TEIsuj1kGkDW7pCsg==
X-Received: by 2002:a5d:8e17:0:b0:76c:7b40:9b66 with SMTP id e23-20020a5d8e17000000b0076c7b409b66mr4886742iod.1.1684710548652;
        Sun, 21 May 2023 16:09:08 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:84e4:c2f6:44bb:b929])
        by smtp.gmail.com with ESMTPSA id dl9-20020a056638278900b0040f91082a4fsm1288409jab.75.2023.05.21.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 16:09:08 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio CODEC
Date:   Sun, 21 May 2023 18:09:02 -0500
Message-Id: <20230521230902.167280-1-aford173@gmail.com>
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

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index cdae45a48c2c..3480fb522230 100644
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
@@ -137,6 +146,30 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
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
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
+			frame-master;
+			bitclock-master;
+		};
+	};
 };
 
 &ecspi2 {
@@ -239,6 +272,34 @@ &i2c4 {
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
@@ -315,6 +376,16 @@ &pcie_phy {
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
@@ -477,6 +548,16 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
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
@@ -547,4 +628,10 @@ pinctrl_usdhc2_gpio: usdhc2gpiogrp {
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

