Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D75FBB05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJKTFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJKTEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:04:47 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532755FEF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:04:41 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so9546198qvq.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCrzZTkyGbZeavhMxP/y0D0DNb5GtgzKtML0oALkIig=;
        b=Ar8k0M0s/u9M2Mrry28hqTYCRI0T+kOUSasatR32AhsTHsgOH+Gfh+g53WoonS8Ju+
         fGLTBjmCbQhcJ7iFTd4FbUDPWaivZ/pNY2CsmM1eBc+XfXpeM/Gj0o+qhOTcxV0dXxKZ
         7fMvs0tzb+qhlH7CTD+TBdYE/2ws9PoP8D3w3zWP43s4uEahyJBUcFujPK5bcW67uaxy
         Uwpn3pEgoBwBb4scuPpfADaCy90w1Qx0Xg/gLR+8N8Y0UlDpboWPRRaAVpG9W8W6XdYw
         /QsKBZQYtuU1QtCRw45UoxpuHpL4deT/gxZznfv+0cblgpAOmKKrTvE7oQnE1KRLLNoY
         teTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCrzZTkyGbZeavhMxP/y0D0DNb5GtgzKtML0oALkIig=;
        b=K1M+EUcLWIfRThoscxsDsy+gOOH9T6FllqRiER+tzEyksCbt9A3Araop0ufDW7Sd9f
         by0kNEIQ/HKriiKX/ky9UeGBX5D2yBs+GFuXo9jrUqMZ/MdimjE+b+20ATQNrWkuFUhI
         9MbUsAimCIkp+Sps3Ub5qSUqNJAJYgcM8MGs2QbeGtFV2ja+hD6KfcsID/LOEoYbIHNm
         6+oTROSse4GbGEMX5b4PvQseRiyZ23tRe3rWEzJkohRHHkvccKihHLoG+9aJ1O+VJaCl
         T3W9pchCtHTNlLpgG1NLryjEd77w+/36cn06Xqx8yOwe2S+Tkl02fZA8TKi2SAqhx37U
         bFzw==
X-Gm-Message-State: ACrzQf0V+DKxwlx1DGlNma7Zl0Y0rVhc2dRuC/nnkEonUNeU0C2dZFUb
        p+kMXC8ix231jt4LT/R0VTnfDg==
X-Google-Smtp-Source: AMsMyM5kb3I0Qm0ETwFg9XQ1S8V3EprPQMoycQmJLCU5wMw2KhQiAhwdpwOXAEr/uTgbyr4hhqODTA==
X-Received: by 2002:a05:6214:29c5:b0:4b1:9c45:c6dc with SMTP id gh5-20020a05621429c500b004b19c45c6dcmr21019581qvb.2.1665515080369;
        Tue, 11 Oct 2022 12:04:40 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14527185qkn.37.2022.10.11.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:04:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sdm630: align TLMM pin configuration with DT schema
Date:   Tue, 11 Oct 2022 15:02:30 -0400
Message-Id: <20221011190231.76784-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
References: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
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
'-state' suffix and their optional children with '-pins' suffix.  All
nodes for GPIOs must also define the function property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v1:
1. Add tags.
---
 .../boot/dts/qcom/sda660-inforce-ifc6560.dts  |   6 +-
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  18 ++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 121 ++++++++----------
 .../sdm636-sony-xperia-ganges-mermaid.dts     |   2 +-
 .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  |   6 +-
 5 files changed, 75 insertions(+), 78 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 28050bc5f081..f8f8a9f35e27 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -401,16 +401,18 @@ vreg_bob: bob {
 };
 
 &sdc2_state_on {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio54";
+		function = "gpio";
 		bias-pull-up;
 		drive-strength = <2>;
 	};
 };
 
 &sdc2_state_off {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio54";
+		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 09c07800793a..d604a9675508 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -577,16 +577,18 @@ vreg_l19a_3p3: l19 {
 };
 
 &sdc2_state_on {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio54";
+		function = "gpio";
 		bias-pull-up;
 		drive-strength = <2>;
 	};
 };
 
 &sdc2_state_off {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio54";
+		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
@@ -615,33 +617,35 @@ &sdhc_2 {
 &tlmm {
 	gpio-reserved-ranges = <8 4>;
 
-	ts_int_active: ts-int-active {
+	ts_int_active: ts-int-active-state {
 		pins = "gpio45";
+		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
 	};
 
-	ts_lcd_id_active: ts-lcd-id-active {
+	ts_lcd_id_active: ts-lcd-id-active-state {
 		pins = "gpio56";
+		function = "gpio";
 		drive-strength = <8>;
 		bias-disable;
 	};
 
-	imx300_vana_default: imx300-vana-default {
+	imx300_vana_default: imx300-vana-default-state {
 		pins = "gpio50";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	imx219_vana_default: imx219-vana-default {
+	imx219_vana_default: imx219-vana-default-state {
 		pins = "gpio51";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	cam_vdig_default: cam-vdig-default {
+	cam_vdig_default: cam-vdig-default-state {
 		pins = "gpio52";
 		function = "gpio";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 796c19b9b2eb..41481493c1e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -721,35 +721,36 @@ tlmm: pinctrl@3100000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			blsp1_uart1_default: blsp1-uart1-default {
+			blsp1_uart1_default: blsp1-uart1-default-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "blsp_uart1";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_uart1_sleep: blsp1-uart1-sleep {
+			blsp1_uart1_sleep: blsp1-uart1-sleep-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_uart2_default: blsp1-uart2-default {
+			blsp1_uart2_default: blsp1-uart2-default-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_uart1_default: blsp2-uart1-active {
-				tx-rts {
+			blsp2_uart1_default: blsp2-uart1-active-state {
+				tx-rts-pins {
 					pins = "gpio16", "gpio19";
 					function = "blsp_uart5";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				rx {
+				rx-pins {
 					/*
 					 * Avoid garbage data while BT module
 					 * is powered off or not driving signal
@@ -760,7 +761,7 @@ rx {
 					bias-pull-up;
 				};
 
-				cts {
+				cts-pins {
 					/* Match the pull of the BT module */
 					pins = "gpio18";
 					function = "blsp_uart5";
@@ -769,15 +770,15 @@ cts {
 				};
 			};
 
-			blsp2_uart1_sleep: blsp2-uart1-sleep {
-				tx {
+			blsp2_uart1_sleep: blsp2-uart1-sleep-state {
+				tx-pins {
 					pins = "gpio16";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				rx-cts-rts {
+				rx-cts-rts-pins {
 					pins = "gpio17", "gpio18", "gpio19";
 					function = "gpio";
 					drive-strength = <2>;
@@ -785,228 +786,216 @@ rx-cts-rts {
 				};
 			};
 
-			i2c1_default: i2c1-default {
+			i2c1_default: i2c1-default-state {
 				pins = "gpio2", "gpio3";
 				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c1_sleep: i2c1-sleep {
+			i2c1_sleep: i2c1-sleep-state {
 				pins = "gpio2", "gpio3";
 				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c2_default: i2c2-default {
+			i2c2_default: i2c2-default-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c2_sleep: i2c2-sleep {
+			i2c2_sleep: i2c2-sleep-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c3_default: i2c3-default {
+			i2c3_default: i2c3-default-state {
 				pins = "gpio10", "gpio11";
 				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c3_sleep: i2c3-sleep {
+			i2c3_sleep: i2c3-sleep-state {
 				pins = "gpio10", "gpio11";
 				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c4_default: i2c4-default {
+			i2c4_default: i2c4-default-state {
 				pins = "gpio14", "gpio15";
 				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c4_sleep: i2c4-sleep {
+			i2c4_sleep: i2c4-sleep-state {
 				pins = "gpio14", "gpio15";
 				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c5_default: i2c5-default {
+			i2c5_default: i2c5-default-state {
 				pins = "gpio18", "gpio19";
 				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c5_sleep: i2c5-sleep {
+			i2c5_sleep: i2c5-sleep-state {
 				pins = "gpio18", "gpio19";
 				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c6_default: i2c6-default {
+			i2c6_default: i2c6-default-state {
 				pins = "gpio22", "gpio23";
 				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c6_sleep: i2c6-sleep {
+			i2c6_sleep: i2c6-sleep-state {
 				pins = "gpio22", "gpio23";
 				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c7_default: i2c7-default {
+			i2c7_default: i2c7-default-state {
 				pins = "gpio26", "gpio27";
 				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c7_sleep: i2c7-sleep {
+			i2c7_sleep: i2c7-sleep-state {
 				pins = "gpio26", "gpio27";
 				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c8_default: i2c8-default {
+			i2c8_default: i2c8-default-state {
 				pins = "gpio30", "gpio31";
 				function = "blsp_i2c8_a";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c8_sleep: i2c8-sleep {
+			i2c8_sleep: i2c8-sleep-state {
 				pins = "gpio30", "gpio31";
 				function = "blsp_i2c8_a";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			cci0_default: cci0_default {
-				pinmux {
-					pins = "gpio36","gpio37";
-					function = "cci_i2c";
-				};
-
-				pinconf {
-					pins = "gpio36","gpio37";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
+			cci0_default: cci0-default-state {
+				pins = "gpio36","gpio37";
+				function = "cci_i2c";
+				bias-pull-up;
+				drive-strength = <2>;
 			};
 
-			cci1_default: cci1_default {
-				pinmux {
-					pins = "gpio38","gpio39";
-					function = "cci_i2c";
-				};
-
-				pinconf {
-					pins = "gpio38","gpio39";
-					bias-pull-up;
-					drive-strength = <2>;
-				};
+			cci1_default: cci1-default-state {
+				pins = "gpio38","gpio39";
+				function = "cci_i2c";
+				bias-pull-up;
+				drive-strength = <2>;
 			};
 
-			sdc1_state_on: sdc1-on {
-				clk {
+			sdc1_state_on: sdc1-on-state {
+				clk-pins {
 					pins = "sdc1_clk";
 					bias-disable;
 					drive-strength = <16>;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc1_cmd";
 					bias-pull-up;
 					drive-strength = <10>;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc1_data";
 					bias-pull-up;
 					drive-strength = <10>;
 				};
 
-				rclk {
+				rclk-pins {
 					pins = "sdc1_rclk";
 					bias-pull-down;
 				};
 			};
 
-			sdc1_state_off: sdc1-off {
-				clk {
+			sdc1_state_off: sdc1-off-state {
+				clk-pins {
 					pins = "sdc1_clk";
 					bias-disable;
 					drive-strength = <2>;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc1_cmd";
 					bias-pull-up;
 					drive-strength = <2>;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc1_data";
 					bias-pull-up;
 					drive-strength = <2>;
 				};
 
-				rclk {
+				rclk-pins {
 					pins = "sdc1_rclk";
 					bias-pull-down;
 				};
 			};
 
-			sdc2_state_on: sdc2-on {
-				clk {
+			sdc2_state_on: sdc2-on-state {
+				clk-pins {
 					pins = "sdc2_clk";
 					bias-disable;
 					drive-strength = <16>;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc2_cmd";
 					bias-pull-up;
 					drive-strength = <10>;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc2_data";
 					bias-pull-up;
 					drive-strength = <10>;
 				};
 			};
 
-			sdc2_state_off: sdc2-off {
-				clk {
+			sdc2_state_off: sdc2-off-state {
+				clk-pins {
 					pins = "sdc2_clk";
 					bias-disable;
 					drive-strength = <2>;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "sdc2_cmd";
 					bias-pull-up;
 					drive-strength = <2>;
 				};
 
-				data {
+				data-pins {
 					pins = "sdc2_data";
 					bias-pull-up;
 					drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts b/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
index 58f687fc49e0..9702e5f59a1d 100644
--- a/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
+++ b/arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts
@@ -19,7 +19,7 @@ / {
 };
 
 &sdc2_state_on {
-	clk {
+	clk-pins {
 		drive-strength = <14>;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
index a3559f6e34a5..270091db48fc 100644
--- a/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
+++ b/arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts
@@ -372,16 +372,18 @@ &pm660l_wled {
 };
 
 &sdc2_state_on {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio54";
+		function = "gpio";
 		bias-pull-up;
 		drive-strength = <2>;
 	};
 };
 
 &sdc2_state_off {
-	sd-cd {
+	sd-cd-pins {
 		pins = "gpio54";
+		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
-- 
2.34.1

