Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289DB748725
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGEPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGEPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:00:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EE1BFB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:00:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992b66e5affso785248666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569199; x=1691161199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbAqAKO1DYWtwLle1/5u4BlacmjG+slZUG3jmiK/B40=;
        b=lJvE2XCRocjNDWtr4R/fBvs0NRBnbSAol3OHYkiVtTaQd8lGRKJ9UDsODc+aQ6mw1x
         FJxclrSNRTh98oWP10Q5kv8m5iuIhMgZI8+obhyN0R+ViFe+iRmcT9Et8AUrPhwnSCr1
         b4qqipuy4VkvF/58ssEgT/uG6jC9QlFP1C6OpxjMFEzVSjb6VxvhpHFjD5wGLJgXnd/b
         42Kp5b57dnToWZe9HFsqgNijr0CL+6NfqQNspCzabCFJ2ohVscU9j4bWPGGN9Ewwh/hK
         f03oWsmCcpJ8CoHzIW11CMJsw3xDcanymL+Fj5FHiDuWATWvT4K9UwrDgu8ynL5z5xcV
         PxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569199; x=1691161199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbAqAKO1DYWtwLle1/5u4BlacmjG+slZUG3jmiK/B40=;
        b=KTvNqqTeZL4+y+Ds9A71wfqn5NMarjGrIgEff7OCeUFYRcInJpZkHTKiQrYT7TUmcK
         UJARhrDs64g+sy0lpGZZSJvTe/y8F3E8ScWDLHhtDeq2cc2h8R/uIfbCvYD60O8zEqY9
         Kc/v6jEIOrcn105+mfZia7Wu3FsEJDvGjduXsHAKg/1GyGVpGft9rCltfWRXN8BFy4lg
         E83Pe8/eRm7NB3aDgbQuxu/AX4kOoiYCh+Y97Mh36zgUlfbTDX0q7dt1XjWgHkR7Zmun
         HJK9iiHCLs7t32aTnUvN0b2GWXk6ZlD1P+IEyaiWQq/oYx+hWjA79pWwi21u5pxlz/kN
         K6kg==
X-Gm-Message-State: ABy/qLbr5GcoFjUqqe0ttkwf27OUsBnUAjwfVxeKcDhza/LhMPIcxm5k
        3P4NitYZbXGlMVNdiEJ58kmDmQ==
X-Google-Smtp-Source: APBJJlG5QFJkXz+zM086UXcR/0JBmK9zro/+zH7HRc5lj2VmpUTglZEwFiqhFcdebkvcnPabXzXx+w==
X-Received: by 2002:a17:906:4805:b0:992:5deb:db89 with SMTP id w5-20020a170906480500b009925debdb89mr11443057ejq.22.1688569198866;
        Wed, 05 Jul 2023 07:59:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906605400b0098ec690e6d7sm13079425ejj.73.2023.07.05.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:59:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: nxp: add missing space before {
Date:   Wed,  5 Jul 2023 16:59:52 +0200
Message-Id: <20230705145953.293632-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx27.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx31.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx50.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx51.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi   |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                  |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi        |  4 ++--
 .../arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts    |  6 +++---
 .../arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi              |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts               | 10 +++++-----
 arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts   |  2 +-
 16 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
index e140307be2e7..faba12ee7465 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
@@ -534,7 +534,7 @@ sahara2: crypto@10025000 {
 				clock-names = "ipg", "ahb";
 			};
 
-			clks: ccm@10027000{
+			clks: ccm@10027000 {
 				compatible = "fsl,imx27-ccm";
 				reg = <0x10027000 0x1000>;
 				#clock-cells = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx31.dtsi b/arch/arm/boot/dts/nxp/imx/imx31.dtsi
index 95c05f17a6d5..e1ae7c175f7d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx31.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx31.dtsi
@@ -232,7 +232,7 @@ bus@53f00000 { /* AIPS2 */
 			reg = <0x53f00000 0x100000>;
 			ranges;
 
-			clks: ccm@53f80000{
+			clks: ccm@53f80000 {
 				compatible = "fsl,imx31-ccm";
 				reg = <0x53f80000 0x4000>;
 				interrupts = <31>, <53>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx50.dtsi b/arch/arm/boot/dts/nxp/imx/imx50.dtsi
index 3d9a9f37f672..c5b25d2f6264 100644
--- a/arch/arm/boot/dts/nxp/imx/imx50.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx50.dtsi
@@ -335,7 +335,7 @@ src: reset-controller@53fd0000 {
 				#reset-cells = <1>;
 			};
 
-			clks: ccm@53fd4000{
+			clks: ccm@53fd4000 {
 				compatible = "fsl,imx50-ccm";
 				reg = <0x53fd4000 0x4000>;
 				interrupts = <0 71 0x04 0 72 0x04>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
index ba92a3ea6872..2b3195f5e32c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
@@ -455,7 +455,7 @@ src: reset-controller@73fd0000 {
 				#reset-cells = <1>;
 			};
 
-			clks: ccm@73fd4000{
+			clks: ccm@73fd4000 {
 				compatible = "fsl,imx51-ccm";
 				reg = <0x73fd4000 0x4000>;
 				interrupts = <0 71 0x04 0 72 0x04>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
index 17dc13719639..0ebc35e6e985 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
@@ -595,7 +595,7 @@ src: reset-controller@53fd0000 {
 				#reset-cells = <1>;
 			};
 
-			clks: ccm@53fd4000{
+			clks: ccm@53fd4000 {
 				compatible = "fsl,imx53-ccm";
 				reg = <0x53fd4000 0x4000>;
 				interrupts = <0 71 0x04 0 72 0x04>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
index 6b64b2fc3995..db1bc511e71f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
@@ -301,12 +301,12 @@ &i2c4 {
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
 
-	eeprom@50{
+	eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
 
-	eeprom@57{
+	eeprom@57 {
 		compatible = "atmel,24c64";
 		reg = <0x57>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 3a4308666552..b2dcec8991b7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -221,7 +221,7 @@ dma_apbh: dma-controller@1804000 {
 			clocks = <&clks IMX6SX_CLK_APBH_DMA>;
 		};
 
-		gpmi: nand-controller@1806000{
+		gpmi: nand-controller@1806000 {
 			compatible = "fsl,imx6sx-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 155515fe13fa..2ac40d69425b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -442,14 +442,14 @@ MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
 		>;
 	};
 
-	pinctrl_flexcan1: flexcan1grp{
+	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
 			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
 		>;
 	};
 
-	pinctrl_flexcan2: flexcan2grp{
+	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
 			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
index 3792679c0c90..ad7f63ca521a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcexpress.dts
@@ -145,7 +145,7 @@ MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x40017051
 		>;
 	};
 
-	pinctrl_flexcan1: flexcan1grp{
+	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
 			MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
index 3ec042bfccba..1762bc47e18d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts
@@ -291,20 +291,20 @@ MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
 		>;
 	};
 
-	pinctrl_flexcan1: flexcan1grp{
+	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
 			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
 		>;
 	};
-	pinctrl_flexcan2: flexcan2grp{
+	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
 			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
 		>;
 	};
 
-	pinctrl_goodix_touch: goodixgrp{
+	pinctrl_goodix_touch: goodixgrp {
 		fsl,pins = <
 			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1020
 		>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
index 43868311f48a..33d5f27285a4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
@@ -272,7 +272,7 @@ MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
 		>;
 	};
 
-	pinctrl_flexcan2: flexcan2grp{
+	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
 			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
index 92ac0edcb608..ef76ece21010 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-mainboard.dts
@@ -133,7 +133,7 @@ &lcdif {
 	pinctrl-0 = <&pinctrl_disp0_3>;
 };
 
-&reg_usbotg_vbus{
+&reg_usbotg_vbus {
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
index 73d90845e85c..c5eefe89cd99 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi
@@ -509,7 +509,7 @@ MX7D_PAD_GPIO1_IO10__PWM3_OUT	0x7f
 		>;
 	};
 
-	pinctrl_pwm4: pwm4grp{
+	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO11__PWM4_OUT	0x7f
 		>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 54026c2c93fa..be3c8e93e63d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -1269,7 +1269,7 @@ dma_apbh: dma-controller@33000000 {
 			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
 		};
 
-		gpmi: nand-controller@33002000{
+		gpmi: nand-controller@33002000 {
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
index ce8e26d7791f..e13ccae629a7 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
@@ -62,19 +62,19 @@ simple-audio-card,codec {
 	};
 };
 
-&can0{
+&can0 {
 	status = "disabled";
 };
 
-&can1{
+&can1 {
 	status = "disabled";
 };
 
-&can2{
+&can2 {
 	status = "disabled";
 };
 
-&can3{
+&can3 {
 	status = "okay";
 };
 
@@ -125,7 +125,7 @@ &enet2 {
 	status = "okay";
 };
 
-&esdhc{
+&esdhc {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts
index 29f8a3a245d4..7ae2d4ca8ef0 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx283lc.dts
@@ -47,7 +47,7 @@ &mac0 {
 	status = "okay";
 };
 
-&pinctrl{
+&pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hog_pins_cpuimx283>;
 
-- 
2.34.1

