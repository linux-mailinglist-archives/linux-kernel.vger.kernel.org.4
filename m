Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607D4619CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiKDQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiKDQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:11:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490947313
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:11:35 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i9so3323181qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zZ4hgOBkSS7lKqMVHhHdz8obglhyQ+aTwbL4NpTFkY=;
        b=Yq6e3O/pGs0MyOMWNUA3vzTx3Od/4zemKt3ajIfy7bcKicU6rKTt+8SIfixfMHxYJG
         w3lkubqOHSdShkN8ENt7WCjjVvv9tm492yyyg6N6h8Q0bhPz7urmD2n6uvcihudnfrtD
         w5UqLLeSSwlvEdhrQ/6T0CGR628QwEKOuiTjBynJldhpCCIjNLmnUz62A21iSOSUoBz2
         PTm/SNg41p669YN1ZpS75LmdeyTFSdWeYGC9CLP8h32bqyQkootg73Cnl8BMYv1fcapI
         9/Q0u8hE1BASSR7bydW+osW15FGfsoMxrnc8IjlNiBNooe9wpIkU0P+PUIriongxdZqa
         dUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zZ4hgOBkSS7lKqMVHhHdz8obglhyQ+aTwbL4NpTFkY=;
        b=AEWAY3ScXebi90Ilwt15Rlt51Va4FCEk3TS5zGQV3Pfm+Vus4EvbkdaXWKh+j82M2P
         Jk1/8AiJeQBiOCXC6kztumiB5NmCUFUPd7wAJyZwiFWQ0+8bKaENYhfjw2tTj8pgMkQD
         bUQPCApD6loiVa+iKN1aD+Fw3KQ5F2tq6mRDNjGeDqUEId23wnErdO7lIwI8wpYt2GlM
         GjZKsyToaIjHFBYsdLTfHGW4VQ/h5do1uJ5IXheAUnq6IZTA85Q7Jk78LstF8YpzpMIf
         hqXl7Z5GvSG3VFzN39n4n4vcuxJDmvPqN1NXUjk93rdH0Ucl/C00OtXEFgvekXx5/n25
         pz4Q==
X-Gm-Message-State: ACrzQf2i7BN265av2Wlzfz2pjU+BeZpZSix19UdlFUXhvlmTw19cH08E
        5+4BBfptZioZWrH5RtgveUjqqw==
X-Google-Smtp-Source: AMsMyM6tpIfGesI5sSD92+o7Ph27abF80lG778Fl8YEEGnGgkigFyNhJSH2KgbhupSJ1G3bKjEPdZA==
X-Received: by 2002:a37:69c5:0:b0:6fa:d6f:e848 with SMTP id e188-20020a3769c5000000b006fa0d6fe848mr26175271qkc.17.1667578294302;
        Fri, 04 Nov 2022 09:11:34 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a0cc600b006e6a7c2a269sm3125370qkj.22.2022.11.04.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:11:33 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: qcom: qcs404: align TLMM pin configuration with DT schema
Date:   Fri,  4 Nov 2022 12:11:30 -0400
Message-Id: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 20 +++---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 52 +++++++--------
 arch/arm64/boot/dts/qcom/qcs404.dtsi         | 66 ++++++++++++--------
 3 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
index 08d5d51221cf..9c7d4e780357 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
@@ -37,54 +37,54 @@ phy1: phy@4 {
 };
 
 &tlmm {
-	ethernet_defaults: ethernet-defaults {
-		int {
+	ethernet_defaults: ethernet-defaults-state {
+		int-pins {
 			pins = "gpio61";
 			function = "rgmii_int";
 			bias-disable;
 			drive-strength = <2>;
 		};
-		mdc {
+		mdc-pins {
 			pins = "gpio76";
 			function = "rgmii_mdc";
 			bias-pull-up;
 		};
-		mdio {
+		mdio-pins {
 			pins = "gpio75";
 			function = "rgmii_mdio";
 			bias-pull-up;
 		};
-		tx {
+		tx-pins {
 			pins = "gpio67", "gpio66", "gpio65", "gpio64";
 			function = "rgmii_tx";
 			bias-pull-up;
 			drive-strength = <16>;
 		};
-		rx {
+		rx-pins {
 			pins = "gpio73", "gpio72", "gpio71", "gpio70";
 			function = "rgmii_rx";
 			bias-disable;
 			drive-strength = <2>;
 		};
-		tx-ctl {
+		tx-ctl-pins {
 			pins = "gpio68";
 			function = "rgmii_ctl";
 			bias-pull-up;
 			drive-strength = <16>;
 		};
-		rx-ctl {
+		rx-ctl-pins {
 			pins = "gpio74";
 			function = "rgmii_ctl";
 			bias-disable;
 			drive-strength = <2>;
 		};
-		tx-ck {
+		tx-ck-pins {
 			pins = "gpio63";
 			function = "rgmii_ck";
 			bias-pull-up;
 			drive-strength = <16>;
 		};
-		rx-ck {
+		rx-ck-pins {
 			pins = "gpio69";
 			function = "rgmii_ck";
 			bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index dbbe1653718b..4d53cd544e41 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -229,7 +229,7 @@ &sdcc1 {
 };
 
 &tlmm {
-	perst_state: perst {
+	perst_state: perst-state {
 		pins = "gpio43";
 		function = "gpio";
 
@@ -238,68 +238,63 @@ perst_state: perst {
 		output-low;
 	};
 
-	sdc1_on: sdc1-on {
-		clk {
+	sdc1_on: sdc1-on-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			bias-disable;
 			drive-strength = <16>;
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc1_cmd";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		data {
+		data-pins {
 			pins = "sdc1_data";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		rclk {
+		rclk-pins {
 			pins = "sdc1_rclk";
 			bias-pull-down;
 		};
 	};
 
-	sdc1_off: sdc1-off {
-		clk {
+	sdc1_off: sdc1-off-state {
+		clk-pins {
 			pins = "sdc1_clk";
 			bias-disable;
 			drive-strength = <2>;
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc1_cmd";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		data {
+		data-pins {
 			pins = "sdc1_data";
 			bias-pull-up;
 			drive-strength = <2>;
 		};
 
-		rclk {
+		rclk-pins {
 			pins = "sdc1_rclk";
 			bias-pull-down;
 		};
 	};
 
-	usb3_id_pin: usb3-id-pin {
-		pinmux {
-			pins = "gpio116";
-			function = "gpio";
-		};
+	usb3_id_pin: usb3-id-state {
+		pins = "gpio116";
+		function = "gpio";
 
-		pinconf {
-			pins = "gpio116";
-			drive-strength = <2>;
-			bias-pull-up;
-			input-enable;
-		};
+		drive-strength = <2>;
+		bias-pull-up;
+		input-enable;
 	};
 };
 
@@ -366,31 +361,28 @@ &wifi {
 /* PINCTRL - additions to nodes defined in qcs404.dtsi */
 
 &blsp1_uart2_default {
-	rx {
+	rx-pins {
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	tx {
+	tx-pins {
 		drive-strength = <2>;
 		bias-disable;
 	};
 };
 
 &blsp1_uart3_default {
-	cts {
-		pins = "gpio84";
+	cts-pins {
 		bias-disable;
 	};
 
-	rts-tx {
-		pins = "gpio85", "gpio82";
+	rts-tx-pins {
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
-		pins = "gpio83";
+	rx-pins {
 		bias-pull-up;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 80f2d05595fa..577d76662468 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -593,118 +593,130 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			blsp1_i2c0_default: blsp1-i2c0-default {
+			blsp1_i2c0_default: blsp1-i2c0-default-state {
 				pins = "gpio32", "gpio33";
 				function = "blsp_i2c0";
 			};
 
-			blsp1_i2c1_default: blsp1-i2c1-default {
+			blsp1_i2c1_default: blsp1-i2c1-default-state {
 				pins = "gpio24", "gpio25";
 				function = "blsp_i2c1";
 			};
 
-			blsp1_i2c2_default: blsp1-i2c2-default {
-				sda {
+			blsp1_i2c2_default: blsp1-i2c2-default-state {
+				sda-pins {
 					pins = "gpio19";
 					function = "blsp_i2c_sda_a2";
 				};
 
-				scl {
+				scl-pins {
 					pins = "gpio20";
 					function = "blsp_i2c_scl_a2";
 				};
 			};
 
-			blsp1_i2c3_default: blsp1-i2c3-default {
+			blsp1_i2c3_default: blsp1-i2c3-default-state {
 				pins = "gpio84", "gpio85";
 				function = "blsp_i2c3";
 			};
 
-			blsp1_i2c4_default: blsp1-i2c4-default {
+			blsp1_i2c4_default: blsp1-i2c4-default-state {
 				pins = "gpio117", "gpio118";
 				function = "blsp_i2c4";
 			};
 
-			blsp1_uart0_default: blsp1-uart0-default {
+			blsp1_uart0_default: blsp1-uart0-default-state {
 				pins = "gpio30", "gpio31", "gpio32", "gpio33";
 				function = "blsp_uart0";
 			};
 
-			blsp1_uart1_default: blsp1-uart1-default {
+			blsp1_uart1_default: blsp1-uart1-default-state {
 				pins = "gpio22", "gpio23";
 				function = "blsp_uart1";
 			};
 
-			blsp1_uart2_default: blsp1-uart2-default {
-				rx {
+			blsp1_uart2_default: blsp1-uart2-default-state {
+				rx-pins {
 					pins = "gpio18";
 					function = "blsp_uart_rx_a2";
 				};
 
-				tx {
+				tx-pins {
 					pins = "gpio17";
 					function = "blsp_uart_tx_a2";
 				};
 			};
 
-			blsp1_uart3_default: blsp1-uart3-default {
-				pins = "gpio82", "gpio83", "gpio84", "gpio85";
-				function = "blsp_uart3";
+			blsp1_uart3_default: blsp1-uart3-default-state {
+				cts-pins {
+					pins = "gpio84";
+					function = "blsp_uart3";
+				};
+
+				rts-tx-pins {
+					pins = "gpio85", "gpio82";
+					function = "blsp_uart3";
+				};
+
+				rx-pins {
+					pins = "gpio83";
+					function = "blsp_uart3";
+				};
 			};
 
-			blsp2_i2c0_default: blsp2-i2c0-default {
+			blsp2_i2c0_default: blsp2-i2c0-default-state {
 				pins = "gpio28", "gpio29";
 				function = "blsp_i2c5";
 			};
 
-			blsp1_spi0_default: blsp1-spi0-default {
+			blsp1_spi0_default: blsp1-spi0-default-state {
 				pins = "gpio30", "gpio31", "gpio32", "gpio33";
 				function = "blsp_spi0";
 			};
 
-			blsp1_spi1_default: blsp1-spi1-default {
-				mosi {
+			blsp1_spi1_default: blsp1-spi1-default-state {
+				mosi-pins {
 					pins = "gpio22";
 					function = "blsp_spi_mosi_a1";
 				};
 
-				miso {
+				miso-pins {
 					pins = "gpio23";
 					function = "blsp_spi_miso_a1";
 				};
 
-				cs_n {
+				cs-n-pins {
 					pins = "gpio24";
 					function = "blsp_spi_cs_n_a1";
 				};
 
-				clk {
+				clk-pins {
 					pins = "gpio25";
 					function = "blsp_spi_clk_a1";
 				};
 			};
 
-			blsp1_spi2_default: blsp1-spi2-default {
+			blsp1_spi2_default: blsp1-spi2-default-state {
 				pins = "gpio17", "gpio18", "gpio19", "gpio20";
 				function = "blsp_spi2";
 			};
 
-			blsp1_spi3_default: blsp1-spi3-default {
+			blsp1_spi3_default: blsp1-spi3-default-state {
 				pins = "gpio82", "gpio83", "gpio84", "gpio85";
 				function = "blsp_spi3";
 			};
 
-			blsp1_spi4_default: blsp1-spi4-default {
+			blsp1_spi4_default: blsp1-spi4-default-state {
 				pins = "gpio37", "gpio38", "gpio117", "gpio118";
 				function = "blsp_spi4";
 			};
 
-			blsp2_spi0_default: blsp2-spi0-default {
+			blsp2_spi0_default: blsp2-spi0-default-state {
 				pins = "gpio26", "gpio27", "gpio28", "gpio29";
 				function = "blsp_spi5";
 			};
 
-			blsp2_uart0_default: blsp2-uart0-default {
+			blsp2_uart0_default: blsp2-uart0-default-state {
 				pins = "gpio26", "gpio27", "gpio28", "gpio29";
 				function = "blsp_uart5";
 			};
-- 
2.34.1

