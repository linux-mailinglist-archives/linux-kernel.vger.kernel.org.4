Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936725FC81B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJLPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJLPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:16:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8CF101C3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f22so6388344qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goIw7+QQR8qpvLkeJrW6T09vL0MkjGT343LILmKKVoI=;
        b=tswZd+77Kbw84ayjJDKfwr86BimM+iEKam4w4KvI8SYMa+Zi7pFGv8KaxflWygW/gl
         c3Yk7KBL1WJ3K/x0lJMz170NbRpVhua4W01CJF3IGvn4N850Tw9jPN/3w9eSMYejQY2e
         I2HXdcve2UhoEAn/lRywI8TNUKwB9FZ/V56S4FJzg0tBYilfoHs547hDXswrE/cTeM5a
         lRu9qMinik/AYgSSU7AEov5SIQAlMIzrEN/Db6B0MaVr3NWgVgu4dakbHhH+HAhpxnNa
         X1MHbtInkmlUq5sqHr+9Xb4eW3eWfUJS2V5Wes3H50W5fnI3rudc8glZqDl0KEhs4zCz
         vn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goIw7+QQR8qpvLkeJrW6T09vL0MkjGT343LILmKKVoI=;
        b=fAfmVCfnipZPAmTew+nOh2vTZdOMugdHiQSfBsTmSPkJtqGt/4K9VpK4bL4wrf8jRA
         4TXF6uY/UZpgd1rbGnggErIaBrWqBP30IkaTN60gh34Y4VYDJybwJIdUZuSpyLz0BHzF
         K9NcSmXrGs+SjanZtYfV3A7+G3PSKwepVCchlZY5Yv++QLoZj0U87i8Yb8/ZnyJ1OnK3
         4K0LfjSrS9g9ub3o2ZNE13FT7tslqzvImR6ILWrh6jYAVCbMtJl9Vd16d69g6YSWrnzq
         86uiPe4OPGmsg0STv7WV/Z63HULBpk9FInuOdSnKuoPf8qxj+tOYwEc3iD1m+5xqeBxx
         skOw==
X-Gm-Message-State: ACrzQf0qv4UWYfBQi3NaQ9xue5yXqbqJG/RfTPHNRy2sX3rctqJc2oZj
        V/RvWROQulZC4jEmsPMX1UpHaA==
X-Google-Smtp-Source: AMsMyM4fI0wO1c3XVLwcmPk2U3wAlbaKmFAUn93cELkKzh4JUWajFTSPjvJJEox46k8VJ5yI3k3UOg==
X-Received: by 2002:a05:622a:511:b0:39c:bddd:74d5 with SMTP id l17-20020a05622a051100b0039cbddd74d5mr3459170qtx.167.1665587782725;
        Wed, 12 Oct 2022 08:16:22 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a454200b006af0ce13499sm16671612qkp.115.2022.10.12.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:16:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: msm8998: align TLMM pin configuration with DT schema
Date:   Wed, 12 Oct 2022 11:14:15 -0400
Message-Id: <20221012151416.38645-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
References: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom/msm8998-clamshell.dtsi      |  7 +-
 .../boot/dts/qcom/msm8998-fxtec-pro1.dts      | 16 ++--
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts      |  4 +-
 .../dts/qcom/msm8998-oneplus-cheeseburger.dts | 10 +--
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi | 14 ++--
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 30 ++++----
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 76 +++++++++----------
 7 files changed, 78 insertions(+), 79 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 7928b8197474..16685fadd3e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -35,7 +35,7 @@ bluetooth {
 };
 
 &blsp1_uart3_on {
-	rx {
+	rx-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-up on 45 (RX). This is needed to
@@ -46,7 +46,7 @@ rx {
 		bias-pull-up;
 	};
 
-	cts {
+	cts-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-down on 47 (CTS) to match the pull
@@ -357,8 +357,9 @@ &sdhc2 {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	touchpad: touchpad-pin {
+	touchpad: touchpad-pin-state {
 		pins = "gpio123";
+		function = "gpio";
 		bias-pull-up;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 429ba57e20f7..5fc0564664cf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -216,7 +216,7 @@ bluetooth {
 };
 
 &blsp1_uart3_on {
-	rx {
+	rx-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-up on 45 (RX). This is needed to
@@ -227,7 +227,7 @@ rx {
 		bias-pull-up;
 	};
 
-	cts {
+	cts-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-down on 47 (CTS) to match the pull
@@ -615,14 +615,14 @@ &remoteproc_slpi {
 &tlmm {
 	gpio-reserved-ranges = <0 4>;
 
-	mdp_vsync_n: mdp-vsync-n {
+	mdp_vsync_n: mdp-vsync-n-state {
 		pins = "gpio10";
 		function = "mdp_vsync_a";
 		bias-pull-down;
 		drive-strength = <2>;
 	};
 
-	gpio_kb_pins_extra: gpio-kb-pins-extra {
+	gpio_kb_pins_extra: gpio-kb-pins-extra-state {
 		pins = "gpio21", "gpio32", "gpio33", "gpio114",
 		       "gpio128", "gpio129";
 		function = "gpio";
@@ -630,21 +630,21 @@ gpio_kb_pins_extra: gpio-kb-pins-extra {
 		bias-pull-up;
 	};
 
-	ts_vio_default: ts-vio-def {
+	ts_vio_default: ts-vio-def-state {
 		pins = "gpio81";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	ts_rst_n: ts-rst-n {
+	ts_rst_n: ts-rst-n-state {
 		pins = "gpio89";
 		function = "gpio";
 		bias-pull-up;
 		drive-strength = <8>;
 	};
 
-	hall_sensor1_default: hall-sensor1-def {
+	hall_sensor1_default: hall-sensor1-def-state {
 		pins = "gpio124";
 		function = "gpio";
 		bias-disable;
@@ -652,7 +652,7 @@ hall_sensor1_default: hall-sensor1-def {
 		input-enable;
 	};
 
-	ts_int_n: ts-int-n {
+	ts_int_n: ts-int-n-state {
 		pins = "gpio125";
 		function = "gpio";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index a3ca58100aee..61f5a827a8d7 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -46,7 +46,7 @@ bluetooth {
 };
 
 &blsp1_uart3_on {
-	rx {
+	rx-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-up on 45 (RX). This is needed to
@@ -57,7 +57,7 @@ rx {
 		bias-pull-up;
 	};
 
-	cts {
+	cts-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-down on 47 (CTS) to match the pull
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
index 122f6c25220e..b951f98d1b7b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
@@ -33,11 +33,9 @@ button-backlight {
 
 &pmi8998_gpio {
 	button_backlight_default: button-backlight-state {
-		pinconf {
-			pins = "gpio5";
-			function = "gpio";
-			bias-pull-down;
-			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-		};
+		pins = "gpio5";
+		function = "gpio";
+		bias-pull-down;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 62bda23791bb..748de88d5d57 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -233,7 +233,7 @@ bluetooth {
 };
 
 &blsp1_uart3_on {
-	rx {
+	rx-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-up on 46 (RX). This is needed to
@@ -244,7 +244,7 @@ rx {
 		bias-pull-up;
 	};
 
-	cts {
+	cts-pins {
 		/delete-property/ bias-disable;
 		/*
 		 * Configure a pull-down on 47 (CTS) to match the pull
@@ -492,7 +492,7 @@ vreg_bob: bob {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	hall_sensor_default: hall-sensor-default {
+	hall_sensor_default: hall-sensor-default-state {
 		pins = "gpio124";
 		function = "gpio";
 		drive-strength = <2>;
@@ -500,28 +500,28 @@ hall_sensor_default: hall-sensor-default {
 		input-enable;
 	};
 
-	ts_int_active: ts-int-active {
+	ts_int_active: ts-int-active-state {
 		pins = "gpio125";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
 	};
 
-	ts_reset_active: ts-reset-active {
+	ts_reset_active: ts-reset-active-state {
 		pins = "gpio89";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
 	};
 
-	nfc_int_active: nfc-int-active {
+	nfc_int_active: nfc-int-active-state {
 		pins = "gpio92";
 		function = "gpio";
 		drive-strength = <6>;
 		bias-pull-up;
 	};
 
-	nfc_enable_active: nfc-enable-active {
+	nfc_enable_active: nfc-enable-active-state {
 		pins = "gpio12", "gpio116";
 		function = "gpio";
 		drive-strength = <6>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index d08639082247..440f2b2d2b2e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -565,14 +565,14 @@ &sdhc2 {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	mdp_vsync_n: mdp-vsync-n {
+	mdp_vsync_n: mdp-vsync-n-state {
 		pins = "gpio10";
 		function = "mdp_vsync_a";
 		drive-strength = <2>;
 		bias-pull-down;
 	};
 
-	nfc_ven: nfc-ven {
+	nfc_ven: nfc-ven-state {
 		pins = "gpio12";
 		function = "gpio";
 		bias-disable;
@@ -580,42 +580,42 @@ nfc_ven: nfc-ven {
 		output-low;
 	};
 
-	msm_mclk0_default: msm-mclk0-active {
+	msm_mclk0_default: msm-mclk0-active-state {
 		pins = "gpio13";
 		function = "cam_mclk";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	msm_mclk1_default: msm-mclk1-active {
+	msm_mclk1_default: msm-mclk1-active-state {
 		pins = "gpio14";
 		function = "cam_mclk";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	cci0_default: cci0-default {
+	cci0_default: cci0-default-state {
 		pins = "gpio18", "gpio19";
 		function = "cci_i2c";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	cci1_default: cci1-default {
+	cci1_default: cci1-default-state {
 		pins = "gpio19", "gpio20";
 		function = "cci_i2c";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	cam0_vdig_default: cam0-vdig-default {
+	cam0_vdig_default: cam0-vdig-default-state {
 		pins = "gpio21";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	tof_int: tof-int {
+	tof_int: tof-int-state {
 		pins = "gpio22";
 		function = "gpio";
 		bias-pull-up;
@@ -623,28 +623,28 @@ tof_int: tof-int {
 		input-enable;
 	};
 
-	cam1_vdig_default: cam1-vdig-default {
+	cam1_vdig_default: cam1-vdig-default-state {
 		pins = "gpio25";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	usb_extcon_active: usb-extcon-active {
+	usb_extcon_active: usb-extcon-active-state {
 		pins = "gpio38";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <16>;
 	};
 
-	tof_reset: tof-reset {
+	tof_reset: tof-reset-state {
 		pins = "gpio27";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	hall_sensor0_default: acc-cover-open {
+	hall_sensor0_default: acc-cover-open-state {
 		pins = "gpio124";
 		function = "gpio";
 		bias-disable;
@@ -652,14 +652,14 @@ hall_sensor0_default: acc-cover-open {
 		input-enable;
 	};
 
-	ts_int_n: ts-int-n {
+	ts_int_n: ts-int-n-state {
 		pins = "gpio125";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
 	};
 
-	usb_vbus_active: usb-vbus-active {
+	usb_vbus_active: usb-vbus-active-state {
 		pins = "gpio128";
 		function = "gpio";
 		bias-disable;
@@ -667,7 +667,7 @@ usb_vbus_active: usb-vbus-active {
 		output-low;
 	};
 
-	ts_vddio_en: ts-vddio-en-default {
+	ts_vddio_en: ts-vddio-en-default-state {
 		pins = "gpio133";
 		function = "gpio";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 2c4acf227253..9650670eae05 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1062,76 +1062,76 @@ tlmm: pinctrl@3400000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			sdc2_on: sdc2-on {
-				clk {
+			sdc2_on: sdc2-on-state {
+				clk-pins {
 					pins = "sdc2_clk";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc2_cmd";
 					drive-strength = <10>;
 					bias-pull-up;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc2_data";
 					drive-strength = <10>;
 					bias-pull-up;
 				};
 			};
 
-			sdc2_off: sdc2-off {
-				clk {
+			sdc2_off: sdc2-off-state {
+				clk-pins {
 					pins = "sdc2_clk";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc2_cmd";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc2_data";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 			};
 
-			sdc2_cd: sdc2-cd {
+			sdc2_cd: sdc2-cd-state {
 				pins = "gpio95";
 				function = "gpio";
 				bias-pull-up;
 				drive-strength = <2>;
 			};
 
-			blsp1_uart3_on: blsp1-uart3-on {
-				tx {
+			blsp1_uart3_on: blsp1-uart3-on-state {
+				tx-pins {
 					pins = "gpio45";
 					function = "blsp_uart3_a";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				rx {
+				rx-pins {
 					pins = "gpio46";
 					function = "blsp_uart3_a";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				cts {
+				cts-pins {
 					pins = "gpio47";
 					function = "blsp_uart3_a";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				rfr {
+				rfr-pins {
 					pins = "gpio48";
 					function = "blsp_uart3_a";
 					drive-strength = <2>;
@@ -1139,168 +1139,168 @@ rfr {
 				};
 			};
 
-			blsp1_i2c1_default: blsp1-i2c1-default {
+			blsp1_i2c1_default: blsp1-i2c1-default-state {
 				pins = "gpio2", "gpio3";
 				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c1_sleep: blsp1-i2c1-sleep {
+			blsp1_i2c1_sleep: blsp1-i2c1-sleep-state-state {
 				pins = "gpio2", "gpio3";
 				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp1_i2c2_default: blsp1-i2c2-default {
+			blsp1_i2c2_default: blsp1-i2c2-default-state {
 				pins = "gpio32", "gpio33";
 				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c2_sleep: blsp1-i2c2-sleep {
+			blsp1_i2c2_sleep: blsp1-i2c2-sleep-state-state {
 				pins = "gpio32", "gpio33";
 				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp1_i2c3_default: blsp1-i2c3-default {
+			blsp1_i2c3_default: blsp1-i2c3-default-state {
 				pins = "gpio47", "gpio48";
 				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c3_sleep: blsp1-i2c3-sleep {
+			blsp1_i2c3_sleep: blsp1-i2c3-sleep-state {
 				pins = "gpio47", "gpio48";
 				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp1_i2c4_default: blsp1-i2c4-default {
+			blsp1_i2c4_default: blsp1-i2c4-default-state {
 				pins = "gpio10", "gpio11";
 				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c4_sleep: blsp1-i2c4-sleep {
+			blsp1_i2c4_sleep: blsp1-i2c4-sleep-state {
 				pins = "gpio10", "gpio11";
 				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp1_i2c5_default: blsp1-i2c5-default {
+			blsp1_i2c5_default: blsp1-i2c5-default-state {
 				pins = "gpio87", "gpio88";
 				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c5_sleep: blsp1-i2c5-sleep {
+			blsp1_i2c5_sleep: blsp1-i2c5-sleep-state {
 				pins = "gpio87", "gpio88";
 				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp1_i2c6_default: blsp1-i2c6-default {
+			blsp1_i2c6_default: blsp1-i2c6-default-state {
 				pins = "gpio43", "gpio44";
 				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c6_sleep: blsp1-i2c6-sleep {
+			blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
 				pins = "gpio43", "gpio44";
 				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 			/* 6 interfaces per QUP, BLSP2 indexes are numbered (n)+6 */
-			blsp2_i2c1_default: blsp2-i2c1-default {
+			blsp2_i2c1_default: blsp2-i2c1-default-state {
 				pins = "gpio55", "gpio56";
 				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c1_sleep: blsp2-i2c1-sleep {
+			blsp2_i2c1_sleep: blsp2-i2c1-sleep-state {
 				pins = "gpio55", "gpio56";
 				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp2_i2c2_default: blsp2-i2c2-default {
+			blsp2_i2c2_default: blsp2-i2c2-default-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c8";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c2_sleep: blsp2-i2c2-sleep {
+			blsp2_i2c2_sleep: blsp2-i2c2-sleep-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c8";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp2_i2c3_default: blsp2-i2c3-default {
+			blsp2_i2c3_default: blsp2-i2c3-default-state {
 				pins = "gpio51", "gpio52";
 				function = "blsp_i2c9";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c3_sleep: blsp2-i2c3-sleep {
+			blsp2_i2c3_sleep: blsp2-i2c3-sleep-state {
 				pins = "gpio51", "gpio52";
 				function = "blsp_i2c9";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp2_i2c4_default: blsp2-i2c4-default {
+			blsp2_i2c4_default: blsp2-i2c4-default-state {
 				pins = "gpio67", "gpio68";
 				function = "blsp_i2c10";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c4_sleep: blsp2-i2c4-sleep {
+			blsp2_i2c4_sleep: blsp2-i2c4-sleep-state {
 				pins = "gpio67", "gpio68";
 				function = "blsp_i2c10";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp2_i2c5_default: blsp2-i2c5-default {
+			blsp2_i2c5_default: blsp2-i2c5-default-state {
 				pins = "gpio60", "gpio61";
 				function = "blsp_i2c11";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c5_sleep: blsp2-i2c5-sleep {
+			blsp2_i2c5_sleep: blsp2-i2c5-sleep-state {
 				pins = "gpio60", "gpio61";
 				function = "blsp_i2c11";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			blsp2_i2c6_default: blsp2-i2c6-default {
+			blsp2_i2c6_default: blsp2-i2c6-default-state {
 				pins = "gpio83", "gpio84";
 				function = "blsp_i2c12";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c6_sleep: blsp2-i2c6-sleep {
+			blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
 				pins = "gpio83", "gpio84";
 				function = "blsp_i2c12";
 				drive-strength = <2>;
-- 
2.34.1

