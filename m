Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35282745004
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGBSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGBSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:52:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC31B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:52:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992e22c09edso203517966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323911; x=1690915911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWcPgz0os9Uz6vYE00RFzztC/z9PiDcsQFCcyuA2xBg=;
        b=pfOC67LcdHd8rxUI/RHGyZtfz+s1wT4j4eVC46IYrn0uKnsbhHQZRFCFl7zxS9150+
         z6EC0pYLWlVmUvfisfdciwsxytNr9+ClZXt7w3YUZ3ZTTP98rZ6wSzJEA8NdQ0GS+rXW
         Zc4w/e9NAoaVVSj8sgyoaJsSLhmxGXyRI2k7In0NHOQFwiWoQjjYsAHf3da9xUuuobAh
         w5eMJ67J4Fq1GMrv7OQyCaDG6or6nwqzXEYKtunIsKuoI3mb778VhhutiaSf/0jeZdtQ
         y9xyYe/4Bul7kTWwzY+hd6oyBu1D38rBGf9f+qA1dNjPOn0VNIUMQhZs4nC4xHL4e1NK
         b8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323911; x=1690915911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWcPgz0os9Uz6vYE00RFzztC/z9PiDcsQFCcyuA2xBg=;
        b=BCCsH6XiQhHvlV8QWjkRcDvhLUJecOna9CNiXKqWTP1suZ0LxCEnw8GsmkU++cKtL8
         5IrzPNbskX7J0LIDCQ5ZHY7hFUFwFy7lKValo3OqYS8Mc3+lF945U8Us6SyjEgfAm6Ba
         pufNkqZYmp4AlCV55Si4aTfs4t+2ijm0yariSa+1Kam6pBs4cbfetMB7fZcY36DC1ZPb
         qrQG/+l6g1pYyC4luPQLe6/deAfplMPMHyfczpY8WGUmW93N4IhdBPJLiUh25OZC8V9d
         bQ3hyyA5tNapZyBGxhTfNutnBqSP9Hofuj7wkU4hX4diDWcYdK4ri6kUqhzp9M8S7l91
         Bt1w==
X-Gm-Message-State: ABy/qLYqmcrLKDUJkXA+CJAlrn6oYNWr3nh/awpG12KDYaKlxnThRcWE
        F/4WojHQwCCPc6nOl746Ktbg0Q==
X-Google-Smtp-Source: ACHHUZ4H+Ht16eJovguKIw1Xs5Ta+KMLFSEI8B7RhJ5J/FRHQxM6QZI4sINAkKgb5w1koeqOgndjWg==
X-Received: by 2002:a17:906:194a:b0:992:5135:4106 with SMTP id b10-20020a170906194a00b0099251354106mr5524095eje.29.1688323911330;
        Sun, 02 Jul 2023 11:51:51 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b0096f7500502csm10857893ejr.199.2023.07.02.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:51:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: imx: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:51:48 +0200
Message-Id: <20230702185149.44212-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi   |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi            |  8 ++++----
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts     |  6 +++---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts  |  6 +++---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi | 12 ++++++------
 arch/arm64/boot/dts/freescale/imx8mq.dtsi            |  6 +++---
 .../boot/dts/freescale/imx8x-colibri-aster.dtsi      |  2 +-
 .../arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi             |  6 +++---
 9 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 52c5a43b30a0..e2c94da6d6e8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -69,7 +69,7 @@ mdio-mux-emi1@54 {
 			mdio-parent-bus = <&emdio1>;
 			reg = <0x54 1>;		/* BRDCFG4 */
 			mux-mask = <0xe0>;	/* EMI1_MDIO */
-			#address-cells=<1>;
+			#address-cells = <1>;
 			#size-cells = <0>;
 
 			/* Child MDIO buses, one for each riser card:
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cc406bb338fe..de590137e4e6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -701,7 +701,7 @@ snvs: snvs@30370000 {
 
 				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					regmap =<&snvs>;
+					regmap = <&snvs>;
 					offset = <0x34>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -854,7 +854,7 @@ pgc_ispdwp: power-domain@18 {
 					pgc_vpumix: power-domain@19 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
-						clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+						clocks = <&clk IMX8MP_CLK_VPU_ROOT>;
 					};
 
 					pgc_vpu_g1: power-domain@20 {
@@ -1846,8 +1846,8 @@ pcie: pcie@33800000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges =  <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
-				  <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
+				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			num-viewport = <4>;
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index ce7ce2ba855c..b3549eae6278 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -561,9 +561,9 @@ accel-gyro@6a {
 		reg = <0x6a>;
 		vdd-supply = <&reg_3v3_p>;
 		vddio-supply = <&reg_3v3_p>;
-		mount-matrix =  "1",  "0",  "0",
-				"0",  "1",  "0",
-				"0",  "0", "-1";
+		mount-matrix = "1",  "0",  "0",
+			       "0",  "1",  "0",
+			       "0",  "0", "-1";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
index 2b3d437a642a..cf40025111c8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
@@ -13,9 +13,9 @@ / {
 };
 
 &accel_gyro {
-	mount-matrix =  "1",  "0",  "0",
-			"0", "-1",  "0",
-			"0",  "0",  "1";
+	mount-matrix = "1",  "0",  "0",
+		       "0", "-1",  "0",
+		       "0",  "0",  "1";
 };
 
 &bq25895 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
index 7fd0176e4bd3..17f86496f8b0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi
@@ -16,9 +16,9 @@ / {
 };
 
 &accel_gyro {
-	mount-matrix =  "1",  "0",  "0",
-			"0",  "1",  "0",
-			"0",  "0", "-1";
+	mount-matrix = "1",  "0",  "0",
+		       "0",  "1",  "0",
+		       "0",  "0", "-1";
 };
 
 &bq25895 {
@@ -39,9 +39,9 @@ MX8MQ_IOMUXC_SPDIF_RX_GPIO5_IO4		0x83
 };
 
 &magnetometer {
-	mount-matrix =  "1",  "0",  "0",
-			"0", "-1",  "0",
-			"0",  "0", "-1";
+	mount-matrix = "1",  "0",  "0",
+		       "0", "-1",  "0",
+		       "0",  "0", "-1";
 };
 
 &proximity {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 1a2d2c04db32..225eceeaf0d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -633,7 +633,7 @@ snvs: snvs@30370000 {
 
 				snvs_rtc: snvs-rtc-lp{
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					regmap =<&snvs>;
+					regmap = <&snvs>;
 					offset = <0x34>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -1582,8 +1582,8 @@ pcie1: pcie@33c00000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000>, /* downstream I/O 64KB */
-				  <0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x00000000 0x27f80000 0 0x00010000>, /* downstream I/O 64KB */
+				 <0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
index aab655931cde..bc659066e19a 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
@@ -35,7 +35,7 @@ &lpuart2 {
 
 /* Colibri UART_A */
 &lpuart3 {
-	status= "okay";
+	status = "okay";
 };
 
 /* Colibri SDCard */
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
index f8953067bc3b..8d06925a8ebd 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -77,7 +77,7 @@ &lpuart2 {
 
 /* Colibri UART_A */
 &lpuart3 {
-	status= "okay";
+	status = "okay";
 };
 
 &lsio_gpio3 {
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..293579ca8e21 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -683,7 +683,7 @@ usdhc1: mmc@42850000 {
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <8>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				status = "disabled";
 			};
 
@@ -697,7 +697,7 @@ usdhc2: mmc@42860000 {
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				status = "disabled";
 			};
 
@@ -760,7 +760,7 @@ usdhc3: mmc@428b0000 {
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				status = "disabled";
 			};
 		};
-- 
2.34.1

