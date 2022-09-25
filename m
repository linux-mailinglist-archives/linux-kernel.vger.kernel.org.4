Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E65E9264
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiIYLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiIYLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:06:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301131DFD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l12so4587563ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o1mFpMLUbASgLi1HG/QRzvVKk8bhvMjWVGO4WudSR4w=;
        b=Lc0xE4IhgTrZoDCWcLvwOo/w//hQMa5Fem7HzJi0o9TXPvMcZbOgXPI0lrp7GFagbt
         CNDoCKP05A8RBo8E7pQRN4TUAzbKHuNIQSB2toBza7qqTuC3v7ZANBkJogH8Rxi1GAp0
         /EAUzXiE/EwFxnrWo11gO1U2L6uGwhRXdgiOpEcVJRqHJOyM5FraIUg8++qMaCPhgiZ7
         oGUb/Q0YOZJekKcORWVZOtmgSOQ6ihhBhqcOvBkfu2ByOzYLWitj1m7FrEYwGuOxcn5H
         Tg1PSYibEkvwbjmwyBm/vMBvXZlZmmg0PuTi20+9fQXdqedXcwKiQO/mZh+bgNFVtNwF
         tZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o1mFpMLUbASgLi1HG/QRzvVKk8bhvMjWVGO4WudSR4w=;
        b=rp63BdSZestzAbEurfPSvSkkWw4t/4SnToUHUilO9p60cDJbZlBgZG4YsfDetpBtn0
         0bT21vsEGHtNB+UnLXc14WDEGRUOiCnmYbLD6Tou5Xcu8IdqG37S7LrHJN58HZpF9g+J
         2snu+CIu2CK8rvP73eo/vjjY+T2+n8/U+eJA1RAF+JRwGaqeDhw4zeCJ5JCxpYMkXkGb
         a+88gzu5wGHMtb9wG7EvSOCaCUtMAcsHXT6GsNi5ZdkUE17ibsjNopde4IbXMJEdVEiD
         MOaGzispoANQL+10miYVF0+G5npx1qoA9AbGaRDwmCcke4NTiEnwpxeJo/d5anpExWsL
         gWKg==
X-Gm-Message-State: ACrzQf2aczjiK3df9fDDKPkZi0/ZK4PYzQbVJvVLPMztS9St4WbOJoH7
        PJhVvhmyWHbI7Uasjl2b+pODdQ==
X-Google-Smtp-Source: AMsMyM7AFnS9O7GoQa5ICxsMmbOpKAo0uJ9dlxWW7GqI4PctOI3lcJu6zVsULHK3N1NczOKM9WiI6Q==
X-Received: by 2002:a05:651c:1111:b0:26c:6b0f:472c with SMTP id e17-20020a05651c111100b0026c6b0f472cmr5643635ljo.384.1664103974685;
        Sun, 25 Sep 2022 04:06:14 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b00492dadd8143sm2177265lfo.168.2022.09.25.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:06:14 -0700 (PDT)
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
Subject: [PATCH 01/15] arm64: dts: qcom: sm8250: align TLMM pin configuration with DT schema
Date:   Sun, 25 Sep 2022 13:05:54 +0200
Message-Id: <20220925110608.145728-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
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

Drop also unneeded split between mux and config.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  12 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       |  38 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  16 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 556 +++++++-----------
 4 files changed, 239 insertions(+), 383 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index bf8077a1cf9a..62aa32f460ad 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1210,33 +1210,33 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
-	lt9611_irq_pin: lt9611-irq {
+	lt9611_irq_pin: lt9611-irq-state {
 		pins = "gpio63";
 		function = "gpio";
 		bias-disable;
 	};
 
-	sdc2_default_state: sdc2-default {
-		clk {
+	sdc2_default_state: sdc2-default-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 			drive-strength = <16>;
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 
-		data {
+		data-pins {
 			pins = "sdc2_data";
 			bias-pull-up;
 			drive-strength = <10>;
 		};
 	};
 
-	sdc2_card_det_n: sd-card-det-n {
+	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio77";
 		function = "gpio";
 		bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index a102aa5efa32..9db6136321b4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -799,31 +799,19 @@ wcd_tx: wcd9380-tx@0,3 {
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <40 4>;
 
-	wcd938x_reset_default: wcd938x_reset_default {
-		mux {
-			pins = "gpio32";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio32";
-			drive-strength = <16>;
-			output-high;
-		};
-	};
-
-	wcd938x_reset_sleep: wcd938x_reset_sleep {
-		mux {
-			pins = "gpio32";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio32";
-			drive-strength = <16>;
-			bias-disable;
-			output-low;
-		};
+	wcd938x_reset_default: wcd938x-reset-default-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <16>;
+		output-high;
+	};
+
+	wcd938x_reset_sleep: wcd938x-reset-sleep-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index 549e0a2aa9fe..72162852fae7 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -582,34 +582,34 @@ &slpi {
 &tlmm {
 	gpio-reserved-ranges = <40 4>, <52 4>;
 
-	sdc2_default_state: sdc2-default {
-		clk {
+	sdc2_default_state: sdc2-default-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			drive-strength = <16>;
 			bias-disable;
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			drive-strength = <16>;
 			bias-pull-up;
 		};
 
-		data {
+		data-pins {
 			pins = "sdc2_data";
 			drive-strength = <16>;
 			bias-pull-up;
 		};
 	};
 
-	mdm2ap_default: mdm2ap-default {
+	mdm2ap_default: mdm2ap-default-state {
 		pins = "gpio1", "gpio3";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-disable;
 	};
 
-	ts_int_default: ts-int-default {
+	ts_int_default: ts-int-default-state {
 		pins = "gpio39";
 		function = "gpio";
 		drive-strength = <2>;
@@ -617,14 +617,14 @@ ts_int_default: ts-int-default {
 		input-enable;
 	};
 
-	ap2mdm_default: ap2mdm-default {
+	ap2mdm_default: ap2mdm-default-state {
 		pins = "gpio56", "gpio57";
 		function = "gpio";
 		drive-strength = <16>;
 		bias-disable;
 	};
 
-	sdc2_card_det_n: sd-card-det-n {
+	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio77";
 		function = "gpio";
 		bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e0416d611b66..7eac3ba90c63 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3798,8 +3798,8 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 181>;
 			wakeup-parent = <&pdc>;
 
-			cci0_default: cci0-default {
-				cci0_i2c0_default: cci0-i2c0-default {
+			cci0_default: cci0-default-state {
+				cci0_i2c0_default: cci0-i2c0-default-pins {
 					/* SDA, SCL */
 					pins = "gpio101", "gpio102";
 					function = "cci_i2c";
@@ -3808,7 +3808,7 @@ cci0_i2c0_default: cci0-i2c0-default {
 					drive-strength = <2>; /* 2 mA */
 				};
 
-				cci0_i2c1_default: cci0-i2c1-default {
+				cci0_i2c1_default: cci0-i2c1-default-pins {
 					/* SDA, SCL */
 					pins = "gpio103", "gpio104";
 					function = "cci_i2c";
@@ -3818,8 +3818,8 @@ cci0_i2c1_default: cci0-i2c1-default {
 				};
 			};
 
-			cci0_sleep: cci0-sleep {
-				cci0_i2c0_sleep: cci0-i2c0-sleep {
+			cci0_sleep: cci0-sleep-state {
+				cci0_i2c0_sleep: cci0-i2c0-sleep-pins {
 					/* SDA, SCL */
 					pins = "gpio101", "gpio102";
 					function = "cci_i2c";
@@ -3828,7 +3828,7 @@ cci0_i2c0_sleep: cci0-i2c0-sleep {
 					bias-pull-down;
 				};
 
-				cci0_i2c1_sleep: cci0-i2c1-sleep {
+				cci0_i2c1_sleep: cci0-i2c1-sleep-pins {
 					/* SDA, SCL */
 					pins = "gpio103", "gpio104";
 					function = "cci_i2c";
@@ -3838,8 +3838,8 @@ cci0_i2c1_sleep: cci0-i2c1-sleep {
 				};
 			};
 
-			cci1_default: cci1-default {
-				cci1_i2c0_default: cci1-i2c0-default {
+			cci1_default: cci1-default-state {
+				cci1_i2c0_default: cci1-i2c0-default-pins {
 					/* SDA, SCL */
 					pins = "gpio105","gpio106";
 					function = "cci_i2c";
@@ -3848,7 +3848,7 @@ cci1_i2c0_default: cci1-i2c0-default {
 					drive-strength = <2>; /* 2 mA */
 				};
 
-				cci1_i2c1_default: cci1-i2c1-default {
+				cci1_i2c1_default: cci1-i2c1-default-pins {
 					/* SDA, SCL */
 					pins = "gpio107","gpio108";
 					function = "cci_i2c";
@@ -3858,8 +3858,8 @@ cci1_i2c1_default: cci1-i2c1-default {
 				};
 			};
 
-			cci1_sleep: cci1-sleep {
-				cci1_i2c0_sleep: cci1-i2c0-sleep {
+			cci1_sleep: cci1-sleep-state {
+				cci1_i2c0_sleep: cci1-i2c0-sleep-pins {
 					/* SDA, SCL */
 					pins = "gpio105","gpio106";
 					function = "cci_i2c";
@@ -3868,7 +3868,7 @@ cci1_i2c0_sleep: cci1-i2c0-sleep {
 					drive-strength = <2>; /* 2 mA */
 				};
 
-				cci1_i2c1_sleep: cci1-i2c1-sleep {
+				cci1_i2c1_sleep: cci1-i2c1-sleep-pins {
 					/* SDA, SCL */
 					pins = "gpio107","gpio108";
 					function = "cci_i2c";
@@ -3878,22 +3878,22 @@ cci1_i2c1_sleep: cci1-i2c1-sleep {
 				};
 			};
 
-			pri_mi2s_active: pri-mi2s-active {
-				sclk {
+			pri_mi2s_active: pri-mi2s-active-state {
+				sclk-pins {
 					pins = "gpio138";
 					function = "mi2s0_sck";
 					drive-strength = <8>;
 					bias-disable;
 				};
 
-				ws {
+				ws-pins {
 					pins = "gpio141";
 					function = "mi2s0_ws";
 					drive-strength = <8>;
 					output-high;
 				};
 
-				data0 {
+				data0-pins {
 					pins = "gpio139";
 					function = "mi2s0_data0";
 					drive-strength = <8>;
@@ -3901,7 +3901,7 @@ data0 {
 					output-high;
 				};
 
-				data1 {
+				data1-pins {
 					pins = "gpio140";
 					function = "mi2s0_data1";
 					drive-strength = <8>;
@@ -3909,632 +3909,500 @@ data1 {
 				};
 			};
 
-			qup_i2c0_default: qup-i2c0-default {
-				mux {
-					pins = "gpio28", "gpio29";
-					function = "qup0";
-				};
-
-				config {
-					pins = "gpio28", "gpio29";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio28", "gpio29";
+				function = "qup0";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c1_default: qup-i2c1-default {
-				pinmux {
-					pins = "gpio4", "gpio5";
-					function = "qup1";
-				};
-
-				config {
-					pins = "gpio4", "gpio5";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio4", "gpio5";
+				function = "qup1";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c2_default: qup-i2c2-default {
-				mux {
-					pins = "gpio115", "gpio116";
-					function = "qup2";
-				};
-
-				config {
-					pins = "gpio115", "gpio116";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio115", "gpio116";
+				function = "qup2";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c3_default: qup-i2c3-default {
-				mux {
-					pins = "gpio119", "gpio120";
-					function = "qup3";
-				};
-
-				config {
-					pins = "gpio119", "gpio120";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio119", "gpio120";
+				function = "qup3";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c4_default: qup-i2c4-default {
-				mux {
-					pins = "gpio8", "gpio9";
-					function = "qup4";
-				};
-
-				config {
-					pins = "gpio8", "gpio9";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio8", "gpio9";
+				function = "qup4";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c5_default: qup-i2c5-default {
-				mux {
-					pins = "gpio12", "gpio13";
-					function = "qup5";
-				};
-
-				config {
-					pins = "gpio12", "gpio13";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio12", "gpio13";
+				function = "qup5";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c6_default: qup-i2c6-default {
-				mux {
-					pins = "gpio16", "gpio17";
-					function = "qup6";
-				};
-
-				config {
-					pins = "gpio16", "gpio17";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins = "gpio16", "gpio17";
+				function = "qup6";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c7_default: qup-i2c7-default {
-				mux {
-					pins = "gpio20", "gpio21";
-					function = "qup7";
-				};
-
-				config {
-					pins = "gpio20", "gpio21";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio20", "gpio21";
+				function = "qup7";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c8_default: qup-i2c8-default {
-				mux {
-					pins = "gpio24", "gpio25";
-					function = "qup8";
-				};
-
-				config {
-					pins = "gpio24", "gpio25";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins = "gpio24", "gpio25";
+				function = "qup8";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c9_default: qup-i2c9-default {
-				mux {
-					pins = "gpio125", "gpio126";
-					function = "qup9";
-				};
-
-				config {
-					pins = "gpio125", "gpio126";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins = "gpio125", "gpio126";
+				function = "qup9";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c10_default: qup-i2c10-default {
-				mux {
-					pins = "gpio129", "gpio130";
-					function = "qup10";
-				};
-
-				config {
-					pins = "gpio129", "gpio130";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c10_default: qup-i2c10-default-state {
+				pins = "gpio129", "gpio130";
+				function = "qup10";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c11_default: qup-i2c11-default {
-				mux {
-					pins = "gpio60", "gpio61";
-					function = "qup11";
-				};
-
-				config {
-					pins = "gpio60", "gpio61";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c11_default: qup-i2c11-default-state {
+				pins = "gpio60", "gpio61";
+				function = "qup11";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c12_default: qup-i2c12-default {
-				mux {
-					pins = "gpio32", "gpio33";
-					function = "qup12";
-				};
-
-				config {
-					pins = "gpio32", "gpio33";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c12_default: qup-i2c12-default-state {
+				pins = "gpio32", "gpio33";
+				function = "qup12";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c13_default: qup-i2c13-default {
-				mux {
-					pins = "gpio36", "gpio37";
-					function = "qup13";
-				};
-
-				config {
-					pins = "gpio36", "gpio37";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c13_default: qup-i2c13-default-state {
+				pins = "gpio36", "gpio37";
+				function = "qup13";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c14_default: qup-i2c14-default {
-				mux {
-					pins = "gpio40", "gpio41";
-					function = "qup14";
-				};
-
-				config {
-					pins = "gpio40", "gpio41";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c14_default: qup-i2c14-default-state {
+				pins = "gpio40", "gpio41";
+				function = "qup14";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c15_default: qup-i2c15-default {
-				mux {
-					pins = "gpio44", "gpio45";
-					function = "qup15";
-				};
-
-				config {
-					pins = "gpio44", "gpio45";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c15_default: qup-i2c15-default-state {
+				pins = "gpio44", "gpio45";
+				function = "qup15";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c16_default: qup-i2c16-default {
-				mux {
-					pins = "gpio48", "gpio49";
-					function = "qup16";
-				};
-
-				config {
-					pins = "gpio48", "gpio49";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c16_default: qup-i2c16-default-state {
+				pins = "gpio48", "gpio49";
+				function = "qup16";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c17_default: qup-i2c17-default {
-				mux {
-					pins = "gpio52", "gpio53";
-					function = "qup17";
-				};
-
-				config {
-					pins = "gpio52", "gpio53";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c17_default: qup-i2c17-default-state {
+				pins = "gpio52", "gpio53";
+				function = "qup17";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c18_default: qup-i2c18-default {
-				mux {
-					pins = "gpio56", "gpio57";
-					function = "qup18";
-				};
-
-				config {
-					pins = "gpio56", "gpio57";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c18_default: qup-i2c18-default-state {
+				pins = "gpio56", "gpio57";
+				function = "qup18";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_i2c19_default: qup-i2c19-default {
-				mux {
-					pins = "gpio0", "gpio1";
-					function = "qup19";
-				};
-
-				config {
-					pins = "gpio0", "gpio1";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			qup_i2c19_default: qup-i2c19-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup19";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			qup_spi0_cs: qup-spi0-cs {
+			qup_spi0_cs: qup-spi0-cs-state {
 				pins = "gpio31";
 				function = "qup0";
 			};
 
-			qup_spi0_cs_gpio: qup-spi0-cs-gpio {
+			qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
 				pins = "gpio31";
 				function = "gpio";
 			};
 
-			qup_spi0_data_clk: qup-spi0-data-clk {
+			qup_spi0_data_clk: qup-spi0-data-clk-state {
 				pins = "gpio28", "gpio29",
 				       "gpio30";
 				function = "qup0";
 			};
 
-			qup_spi1_cs: qup-spi1-cs {
+			qup_spi1_cs: qup-spi1-cs-state {
 				pins = "gpio7";
 				function = "qup1";
 			};
 
-			qup_spi1_cs_gpio: qup-spi1-cs-gpio {
+			qup_spi1_cs_gpio: qup-spi1-cs-gpio-state {
 				pins = "gpio7";
 				function = "gpio";
 			};
 
-			qup_spi1_data_clk: qup-spi1-data-clk {
+			qup_spi1_data_clk: qup-spi1-data-clk-state {
 				pins = "gpio4", "gpio5",
 				       "gpio6";
 				function = "qup1";
 			};
 
-			qup_spi2_cs: qup-spi2-cs {
+			qup_spi2_cs: qup-spi2-cs-state {
 				pins = "gpio118";
 				function = "qup2";
 			};
 
-			qup_spi2_cs_gpio: qup-spi2-cs-gpio {
+			qup_spi2_cs_gpio: qup-spi2-cs-gpio-state {
 				pins = "gpio118";
 				function = "gpio";
 			};
 
-			qup_spi2_data_clk: qup-spi2-data-clk {
+			qup_spi2_data_clk: qup-spi2-data-clk-state {
 				pins = "gpio115", "gpio116",
 				       "gpio117";
 				function = "qup2";
 			};
 
-			qup_spi3_cs: qup-spi3-cs {
+			qup_spi3_cs: qup-spi3-cs-state {
 				pins = "gpio122";
 				function = "qup3";
 			};
 
-			qup_spi3_cs_gpio: qup-spi3-cs-gpio {
+			qup_spi3_cs_gpio: qup-spi3-cs-gpio-state {
 				pins = "gpio122";
 				function = "gpio";
 			};
 
-			qup_spi3_data_clk: qup-spi3-data-clk {
+			qup_spi3_data_clk: qup-spi3-data-clk-state {
 				pins = "gpio119", "gpio120",
 				       "gpio121";
 				function = "qup3";
 			};
 
-			qup_spi4_cs: qup-spi4-cs {
+			qup_spi4_cs: qup-spi4-cs-state {
 				pins = "gpio11";
 				function = "qup4";
 			};
 
-			qup_spi4_cs_gpio: qup-spi4-cs-gpio {
+			qup_spi4_cs_gpio: qup-spi4-cs-gpio-state {
 				pins = "gpio11";
 				function = "gpio";
 			};
 
-			qup_spi4_data_clk: qup-spi4-data-clk {
+			qup_spi4_data_clk: qup-spi4-data-clk-state {
 				pins = "gpio8", "gpio9",
 				       "gpio10";
 				function = "qup4";
 			};
 
-			qup_spi5_cs: qup-spi5-cs {
+			qup_spi5_cs: qup-spi5-cs-state {
 				pins = "gpio15";
 				function = "qup5";
 			};
 
-			qup_spi5_cs_gpio: qup-spi5-cs-gpio {
+			qup_spi5_cs_gpio: qup-spi5-cs-gpio-state {
 				pins = "gpio15";
 				function = "gpio";
 			};
 
-			qup_spi5_data_clk: qup-spi5-data-clk {
+			qup_spi5_data_clk: qup-spi5-data-clk-state {
 				pins = "gpio12", "gpio13",
 				       "gpio14";
 				function = "qup5";
 			};
 
-			qup_spi6_cs: qup-spi6-cs {
+			qup_spi6_cs: qup-spi6-cs-state {
 				pins = "gpio19";
 				function = "qup6";
 			};
 
-			qup_spi6_cs_gpio: qup-spi6-cs-gpio {
+			qup_spi6_cs_gpio: qup-spi6-cs-gpio-state {
 				pins = "gpio19";
 				function = "gpio";
 			};
 
-			qup_spi6_data_clk: qup-spi6-data-clk {
+			qup_spi6_data_clk: qup-spi6-data-clk-state {
 				pins = "gpio16", "gpio17",
 				       "gpio18";
 				function = "qup6";
 			};
 
-			qup_spi7_cs: qup-spi7-cs {
+			qup_spi7_cs: qup-spi7-cs-state {
 				pins = "gpio23";
 				function = "qup7";
 			};
 
-			qup_spi7_cs_gpio: qup-spi7-cs-gpio {
+			qup_spi7_cs_gpio: qup-spi7-cs-gpio-state {
 				pins = "gpio23";
 				function = "gpio";
 			};
 
-			qup_spi7_data_clk: qup-spi7-data-clk {
+			qup_spi7_data_clk: qup-spi7-data-clk-state {
 				pins = "gpio20", "gpio21",
 				       "gpio22";
 				function = "qup7";
 			};
 
-			qup_spi8_cs: qup-spi8-cs {
+			qup_spi8_cs: qup-spi8-cs-state {
 				pins = "gpio27";
 				function = "qup8";
 			};
 
-			qup_spi8_cs_gpio: qup-spi8-cs-gpio {
+			qup_spi8_cs_gpio: qup-spi8-cs-gpio-state {
 				pins = "gpio27";
 				function = "gpio";
 			};
 
-			qup_spi8_data_clk: qup-spi8-data-clk {
+			qup_spi8_data_clk: qup-spi8-data-clk-state {
 				pins = "gpio24", "gpio25",
 				       "gpio26";
 				function = "qup8";
 			};
 
-			qup_spi9_cs: qup-spi9-cs {
+			qup_spi9_cs: qup-spi9-cs-state {
 				pins = "gpio128";
 				function = "qup9";
 			};
 
-			qup_spi9_cs_gpio: qup-spi9-cs-gpio {
+			qup_spi9_cs_gpio: qup-spi9-cs-gpio-state {
 				pins = "gpio128";
 				function = "gpio";
 			};
 
-			qup_spi9_data_clk: qup-spi9-data-clk {
+			qup_spi9_data_clk: qup-spi9-data-clk-state {
 				pins = "gpio125", "gpio126",
 				       "gpio127";
 				function = "qup9";
 			};
 
-			qup_spi10_cs: qup-spi10-cs {
+			qup_spi10_cs: qup-spi10-cs-state {
 				pins = "gpio132";
 				function = "qup10";
 			};
 
-			qup_spi10_cs_gpio: qup-spi10-cs-gpio {
+			qup_spi10_cs_gpio: qup-spi10-cs-gpio-state {
 				pins = "gpio132";
 				function = "gpio";
 			};
 
-			qup_spi10_data_clk: qup-spi10-data-clk {
+			qup_spi10_data_clk: qup-spi10-data-clk-state {
 				pins = "gpio129", "gpio130",
 				       "gpio131";
 				function = "qup10";
 			};
 
-			qup_spi11_cs: qup-spi11-cs {
+			qup_spi11_cs: qup-spi11-cs-state {
 				pins = "gpio63";
 				function = "qup11";
 			};
 
-			qup_spi11_cs_gpio: qup-spi11-cs-gpio {
+			qup_spi11_cs_gpio: qup-spi11-cs-gpio-state {
 				pins = "gpio63";
 				function = "gpio";
 			};
 
-			qup_spi11_data_clk: qup-spi11-data-clk {
+			qup_spi11_data_clk: qup-spi11-data-clk-state {
 				pins = "gpio60", "gpio61",
 				       "gpio62";
 				function = "qup11";
 			};
 
-			qup_spi12_cs: qup-spi12-cs {
+			qup_spi12_cs: qup-spi12-cs-state {
 				pins = "gpio35";
 				function = "qup12";
 			};
 
-			qup_spi12_cs_gpio: qup-spi12-cs-gpio {
+			qup_spi12_cs_gpio: qup-spi12-cs-gpio-state {
 				pins = "gpio35";
 				function = "gpio";
 			};
 
-			qup_spi12_data_clk: qup-spi12-data-clk {
+			qup_spi12_data_clk: qup-spi12-data-clk-state {
 				pins = "gpio32", "gpio33",
 				       "gpio34";
 				function = "qup12";
 			};
 
-			qup_spi13_cs: qup-spi13-cs {
+			qup_spi13_cs: qup-spi13-cs-state {
 				pins = "gpio39";
 				function = "qup13";
 			};
 
-			qup_spi13_cs_gpio: qup-spi13-cs-gpio {
+			qup_spi13_cs_gpio: qup-spi13-cs-gpio-state {
 				pins = "gpio39";
 				function = "gpio";
 			};
 
-			qup_spi13_data_clk: qup-spi13-data-clk {
+			qup_spi13_data_clk: qup-spi13-data-clk-state {
 				pins = "gpio36", "gpio37",
 				       "gpio38";
 				function = "qup13";
 			};
 
-			qup_spi14_cs: qup-spi14-cs {
+			qup_spi14_cs: qup-spi14-cs-state {
 				pins = "gpio43";
 				function = "qup14";
 			};
 
-			qup_spi14_cs_gpio: qup-spi14-cs-gpio {
+			qup_spi14_cs_gpio: qup-spi14-cs-gpio-state {
 				pins = "gpio43";
 				function = "gpio";
 			};
 
-			qup_spi14_data_clk: qup-spi14-data-clk {
+			qup_spi14_data_clk: qup-spi14-data-clk-state {
 				pins = "gpio40", "gpio41",
 				       "gpio42";
 				function = "qup14";
 			};
 
-			qup_spi15_cs: qup-spi15-cs {
+			qup_spi15_cs: qup-spi15-cs-state {
 				pins = "gpio47";
 				function = "qup15";
 			};
 
-			qup_spi15_cs_gpio: qup-spi15-cs-gpio {
+			qup_spi15_cs_gpio: qup-spi15-cs-gpio-state {
 				pins = "gpio47";
 				function = "gpio";
 			};
 
-			qup_spi15_data_clk: qup-spi15-data-clk {
+			qup_spi15_data_clk: qup-spi15-data-clk-state {
 				pins = "gpio44", "gpio45",
 				       "gpio46";
 				function = "qup15";
 			};
 
-			qup_spi16_cs: qup-spi16-cs {
+			qup_spi16_cs: qup-spi16-cs-state {
 				pins = "gpio51";
 				function = "qup16";
 			};
 
-			qup_spi16_cs_gpio: qup-spi16-cs-gpio {
+			qup_spi16_cs_gpio: qup-spi16-cs-gpio-state {
 				pins = "gpio51";
 				function = "gpio";
 			};
 
-			qup_spi16_data_clk: qup-spi16-data-clk {
+			qup_spi16_data_clk: qup-spi16-data-clk-state {
 				pins = "gpio48", "gpio49",
 				       "gpio50";
 				function = "qup16";
 			};
 
-			qup_spi17_cs: qup-spi17-cs {
+			qup_spi17_cs: qup-spi17-cs-state {
 				pins = "gpio55";
 				function = "qup17";
 			};
 
-			qup_spi17_cs_gpio: qup-spi17-cs-gpio {
+			qup_spi17_cs_gpio: qup-spi17-cs-gpio-state {
 				pins = "gpio55";
 				function = "gpio";
 			};
 
-			qup_spi17_data_clk: qup-spi17-data-clk {
+			qup_spi17_data_clk: qup-spi17-data-clk-state {
 				pins = "gpio52", "gpio53",
 				       "gpio54";
 				function = "qup17";
 			};
 
-			qup_spi18_cs: qup-spi18-cs {
+			qup_spi18_cs: qup-spi18-cs-state {
 				pins = "gpio59";
 				function = "qup18";
 			};
 
-			qup_spi18_cs_gpio: qup-spi18-cs-gpio {
+			qup_spi18_cs_gpio: qup-spi18-cs-gpio-state {
 				pins = "gpio59";
 				function = "gpio";
 			};
 
-			qup_spi18_data_clk: qup-spi18-data-clk {
+			qup_spi18_data_clk: qup-spi18-data-clk-state {
 				pins = "gpio56", "gpio57",
 				       "gpio58";
 				function = "qup18";
 			};
 
-			qup_spi19_cs: qup-spi19-cs {
+			qup_spi19_cs: qup-spi19-cs-state {
 				pins = "gpio3";
 				function = "qup19";
 			};
 
-			qup_spi19_cs_gpio: qup-spi19-cs-gpio {
+			qup_spi19_cs_gpio: qup-spi19-cs-gpio-state {
 				pins = "gpio3";
 				function = "gpio";
 			};
 
-			qup_spi19_data_clk: qup-spi19-data-clk {
+			qup_spi19_data_clk: qup-spi19-data-clk-state {
 				pins = "gpio0", "gpio1",
 				       "gpio2";
 				function = "qup19";
 			};
 
-			qup_uart2_default: qup-uart2-default {
-				mux {
-					pins = "gpio117", "gpio118";
-					function = "qup2";
-				};
+			qup_uart2_default: qup-uart2-default-state {
+				pins = "gpio117", "gpio118";
+				function = "qup2";
 			};
 
-			qup_uart6_default: qup-uart6-default {
-				mux {
-					pins = "gpio16", "gpio17",
-						"gpio18", "gpio19";
-					function = "qup6";
-				};
+			qup_uart6_default: qup-uart6-default-state {
+				pins = "gpio16", "gpio17", "gpio18", "gpio19";
+				function = "qup6";
 			};
 
-			qup_uart12_default: qup-uart12-default {
-				mux {
-					pins = "gpio34", "gpio35";
-					function = "qup12";
-				};
+			qup_uart12_default: qup-uart12-default-state {
+				pins = "gpio34", "gpio35";
+				function = "qup12";
 			};
 
-			qup_uart17_default: qup-uart17-default {
-				mux {
-					pins = "gpio52", "gpio53",
-						"gpio54", "gpio55";
-					function = "qup17";
-				};
+			qup_uart17_default: qup-uart17-default-state {
+				pins = "gpio52", "gpio53", "gpio54", "gpio55";
+				function = "qup17";
 			};
 
-			qup_uart18_default: qup-uart18-default {
-				mux {
-					pins = "gpio58", "gpio59";
-					function = "qup18";
-				};
+			qup_uart18_default: qup-uart18-default-state {
+				pins = "gpio58", "gpio59";
+				function = "qup18";
 			};
 
-			tert_mi2s_active: tert-mi2s-active {
-				sck {
+			tert_mi2s_active: tert-mi2s-active-state {
+				sck-pins {
 					pins = "gpio133";
 					function = "mi2s2_sck";
 					drive-strength = <8>;
 					bias-disable;
 				};
 
-				data0 {
+				data0-pins {
 					pins = "gpio134";
 					function = "mi2s2_data0";
 					drive-strength = <8>;
@@ -4542,7 +4410,7 @@ data0 {
 					output-high;
 				};
 
-				ws {
+				ws-pins {
 					pins = "gpio135";
 					function = "mi2s2_ws";
 					drive-strength = <8>;
@@ -4550,42 +4418,42 @@ ws {
 				};
 			};
 
-			sdc2_sleep_state: sdc2-sleep {
-				clk {
+			sdc2_sleep_state: sdc2-sleep-state {
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
 
-			pcie0_default_state: pcie0-default {
-				perst {
+			pcie0_default_state: pcie0-default-state {
+				perst-pins {
 					pins = "gpio79";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio80";
 					function = "pci_e0";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio81";
 					function = "gpio";
 					drive-strength = <2>;
@@ -4593,22 +4461,22 @@ wake {
 				};
 			};
 
-			pcie1_default_state: pcie1-default {
-				perst {
+			pcie1_default_state: pcie1-default-state {
+				perst-pins {
 					pins = "gpio82";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio83";
 					function = "pci_e1";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio84";
 					function = "gpio";
 					drive-strength = <2>;
@@ -4616,22 +4484,22 @@ wake {
 				};
 			};
 
-			pcie2_default_state: pcie2-default {
-				perst {
+			pcie2_default_state: pcie2-default-state {
+				perst-pins {
 					pins = "gpio85";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio86";
 					function = "pci_e2";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio87";
 					function = "gpio";
 					drive-strength = <2>;
-- 
2.34.1

