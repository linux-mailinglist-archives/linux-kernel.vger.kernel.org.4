Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF25748728
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjGEPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGEPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:00:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3219A2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:00:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991da766865so812761166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569201; x=1691161201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/0F5R5mM5gPxobbPiX1/48EdQzBnBDgRcO6PDWtuN8=;
        b=HccxiV79lI2HgXxRNWs8t158mb7UQqRkK8v9l/986PAPvi595UGcoLvuijRIZs2p3Y
         hvgVF6r8NQsI0qI6wbB1N7B2zUkqP+byHpTHq/+if1kNYiXID0hqKDSQr9QABiPfPW40
         DoZ/+xgX6I2KasLF7nbz9yk7c3Btq5cX3RhjssFb29UsNc7vXoDvOwXtkRktoUxIrlWu
         gLxwtLl1HW0PJIao5pz/cnrJEvFdqZEflnehNYrJidcg+ILACHldZdM4Y8H4P4rdpiL3
         HrHWhpidUrJddAUJKbB1ATRpJKmIq+ZEVbp0bffYnZNVSB9HWQxz9lzICRudVBqGeSQl
         Gmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569201; x=1691161201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/0F5R5mM5gPxobbPiX1/48EdQzBnBDgRcO6PDWtuN8=;
        b=V2aOwFnnAUzuGTR2Suf69H/6VTNzYeVrRrPyqvwrDCkx9oX3EithiMoLVuBLfpLXs3
         97sreBKpRWobD6cUTIutBHM27fxiGHSo5UiGCjSZoujfbRQZI07rhMHzMQfJlYbAnn+2
         fkw8AzC0N04W5SZBgKXvjWx296SkXdECCNXBqvOPi5OAAiTlgn260i4Y1pRM6cofJiEy
         IZhQwYAOujx7BpoCpe8Z0czyNacQcdmM31Yn8GftG0TdE+qCbUzsqJRIfRXFNLEG0yP3
         SqrJQABa9/OFpmCD8CntVTVXTo1gNOXGTV7LPV+fLfpiqfTAA2DYIMecv3brc1tXjox3
         HRLQ==
X-Gm-Message-State: ABy/qLYe+K6zStUQLeTp5lgCr6Gg7TNorS0Iy4a45bli+Vv8b1Nq1Y84
        cTAYl6sA+XTqNbn6KSKJ6cfirQ==
X-Google-Smtp-Source: APBJJlFs66ZYzad7VZkX8+2j2B/JcOuMsc3lw/12x52kx+Zfnk9LAjEu8jN6kZrrLFgmFyjhTXqnqg==
X-Received: by 2002:a17:906:f884:b0:992:345e:8319 with SMTP id lg4-20020a170906f88400b00992345e8319mr13126885ejb.58.1688569201513;
        Wed, 05 Jul 2023 08:00:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906605400b0098ec690e6d7sm13079425ejj.73.2023.07.05.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:00:01 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: freescale: add missing space before {
Date:   Wed,  5 Jul 2023 16:59:53 +0200
Message-Id: <20230705145953.293632-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705145953.293632-1-krzysztof.kozlowski@linaro.org>
References: <20230705145953.293632-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi    | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts           | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi       | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi              | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts        | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index bd5d771637ca..9b1b522517f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -684,15 +684,15 @@ &lsio_pwm3 {
 };
 
 /* Messaging Units */
-&mu_m0{
+&mu_m0 {
 	status = "okay";
 };
 
-&mu1_m0{
+&mu1_m0 {
 	status = "okay";
 };
 
-&mu2_m0{
+&mu2_m0 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 4839a962a170..0b71f50d936e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -40,7 +40,7 @@ pmic: pmic@25 {
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 
 		regulators {
-			buck1: BUCK1{
+			buck1: BUCK1 {
 				regulator-name = "VDD_SOC";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <950000>;
@@ -59,7 +59,7 @@ buck2: BUCK2 {
 				regulator-ramp-delay = <3125>;
 			};
 
-			buck4: BUCK4{
+			buck4: BUCK4 {
 				regulator-name = "VDD_3V3";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -67,7 +67,7 @@ buck4: BUCK4{
 				regulator-always-on;
 			};
 
-			buck5: BUCK5{
+			buck5: BUCK5 {
 				regulator-name = "VDD_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
index b4409349eb3f..cccdc3dd1c6c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
@@ -129,7 +129,7 @@ buck2: BUCK2 {
 				nxp,dvs-standby-voltage = <850000>;
 			};
 
-			buck4: BUCK4{
+			buck4: BUCK4 {
 				regulator-name = "BUCK4";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <3400000>;
@@ -137,7 +137,7 @@ buck4: BUCK4{
 				regulator-always-on;
 			};
 
-			buck5: BUCK5{
+			buck5: BUCK5 {
 				regulator-name = "BUCK5";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <3400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
index 0187890a90c5..efc00f4abeb1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-sr-som.dtsi
@@ -133,7 +133,7 @@ eeprom@50 {
 	};
 };
 
-&pgc_gpu{
+&pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 225eceeaf0d5..5b5414955420 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -631,7 +631,7 @@ snvs: snvs@30370000 {
 				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x30370000 0x10000>;
 
-				snvs_rtc: snvs-rtc-lp{
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
 					regmap = <&snvs>;
 					offset = <0x34>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
index 7d00e17f0447..50bf7919c863 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
@@ -180,7 +180,7 @@ IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
-	pinctrl_leds: ledsgrp{
+	pinctrl_leds: ledsgrp {
 		fsl,pins = <
 			IMX8QXP_ESAI0_TX2_RX3_LSIO_GPIO0_IO06			0x00000021
 			IMX8QXP_ESAI0_TX3_RX2_LSIO_GPIO0_IO07			0x00000021
-- 
2.34.1

