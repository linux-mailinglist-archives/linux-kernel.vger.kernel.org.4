Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD005F132A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiI3UGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiI3UFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:05:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68915C1EC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:05:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j16so8474273lfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B6aX4T6UtyDeRH49MhEn/OQObHDcY7KSstMEBHBCZZo=;
        b=oTBJkAIr6b+GyEV/kMpbt4LHhtROAnPQiY6mW0ryc52E2eH2jfhF22kETBdlxX/5ze
         BIUtDIWd/FmvzGwvvFqxUvXutbIAwSYBtYo8K9atziUqgrx9xZ7WAQTPrtqWwkFNOjzJ
         xNhi4u6Smr/4uKlTLMdJN6n9LCs7uWx3Cu0tMOajvNxcOiF1Zuj8watpSzZkEoes8wh+
         Z294WLxntuqcSuwZFyJ1aG9o2WXfvWH0+6kcW3rbWVOxxZpZYu1eA6F4qV2NgSoJE3WQ
         74bH/RbEXw8ZLxD985HkiYygtc/qYZI4VS8Xftofqjyh4vhRPnGp4liyiTTXzoLYkpb8
         W1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B6aX4T6UtyDeRH49MhEn/OQObHDcY7KSstMEBHBCZZo=;
        b=rwNJEOhTI6p2xt9w0JJ+aQ66qQZGRwCaUoADVZPuUyKo2h3TnDAdGY7R6ycCKltlcI
         rt0zyxAMyMVh3beStmEKsd83Ih4B7DiLhrMMwYQ+zDivW6+cELLhmp1Eu0Hpe7UvO6q0
         qvKFiWVmaQI3jMVvuI9FRtSX9gtf0NAgpy4dfOcbY+lyWJCPSmOmzjH5dWsJzSeFoxC3
         kEnBzgslFmECZM+u6EvT4hYCqEYNCe4zkxk9RYycjsCsAaemVckZg9WDMZHf7HvntWjQ
         CgR4neujrY8vHCh29YI6InSuNjh5zoJTCLJ7ySrzfjjUXjWBSeP61DAsXC707majm5NI
         DEIQ==
X-Gm-Message-State: ACrzQf2+QZd0iDhyDhdlTdi7RlCrytasLUaUGih5JwVyQ261p++OFxXN
        Pp5afgVe4bX/dEe6PjUy8FlqfYdfpa6Utw==
X-Google-Smtp-Source: AMsMyM6LI94Pqqf4bT/TUMrLyGtx7lqCLfjkOo/DNn8/z1z5fegObcg9Ty0ys8yjilBCKR+EqE+o5Q==
X-Received: by 2002:ac2:4f03:0:b0:496:d15:e70c with SMTP id k3-20020ac24f03000000b004960d15e70cmr3553681lfr.102.1664568343326;
        Fri, 30 Sep 2022 13:05:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d10-20020ac2544a000000b00492f45cbbfcsm398876lfn.302.2022.09.30.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:05:42 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
Date:   Fri, 30 Sep 2022 22:05:28 +0200
Message-Id: <20220930200529.331223-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
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

The sdm854.dtsi file defined several pin configuration nodes which are
customized by the boards.  Therefore keep a additional "default-pins"
node inside so the boards can add more of configuration nodes.  Such
additional configuration nodes always need 'function' property now
(required by DT schema).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 344 +++++++-----------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  76 ++--
 .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 ++-
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  60 ++-
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  88 ++---
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 138 +++----
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  26 +-
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  30 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 305 +++++++---------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  33 +-
 .../boot/dts/qcom/sdm850-samsung-w737.dts     |  96 ++---
 13 files changed, 513 insertions(+), 751 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b5f11fbcc300..3403cdcdd49c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -993,21 +993,21 @@ &wifi {
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qspi_cs0 {
-	pinconf {
+	default-pins {
 		pins = "gpio90";
 		bias-disable;
 	};
 };
 
 &qspi_clk {
-	pinconf {
+	default-pins {
 		pins = "gpio95";
 		bias-disable;
 	};
 };
 
 &qspi_data01 {
-	pinconf {
+	default-pins {
 		pins = "gpio91", "gpio92";
 
 		/* High-Z when no transfers; nice to park the lines */
@@ -1016,7 +1016,7 @@ pinconf {
 };
 
 &qup_i2c3_default {
-	pinconf {
+	default-pins {
 		pins = "gpio41", "gpio42";
 		drive-strength = <2>;
 
@@ -1026,7 +1026,7 @@ pinconf {
 };
 
 &qup_i2c11_default {
-	pinconf {
+	default-pins {
 		pins = "gpio31", "gpio32";
 		drive-strength = <2>;
 
@@ -1036,7 +1036,7 @@ pinconf {
 };
 
 &qup_i2c12_default {
-	pinconf {
+	default-pins {
 		pins = "gpio49", "gpio50";
 		drive-strength = <2>;
 
@@ -1046,7 +1046,7 @@ pinconf {
 };
 
 &qup_i2c14_default {
-	pinconf {
+	default-pins {
 		pins = "gpio33", "gpio34";
 		drive-strength = <2>;
 
@@ -1056,7 +1056,7 @@ pinconf {
 };
 
 &qup_spi0_default {
-	pinconf {
+	default-pins {
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		drive-strength = <2>;
 		bias-disable;
@@ -1064,7 +1064,7 @@ pinconf {
 };
 
 &qup_spi5_default {
-	pinconf {
+	default-pins {
 		pins = "gpio85", "gpio86", "gpio87", "gpio88";
 		drive-strength = <2>;
 		bias-disable;
@@ -1072,7 +1072,7 @@ pinconf {
 };
 
 &qup_spi10_default {
-	pinconf {
+	default-pins {
 		pins = "gpio53", "gpio54", "gpio55", "gpio56";
 		drive-strength = <2>;
 		bias-disable;
@@ -1081,28 +1081,25 @@ pinconf {
 
 &qup_uart6_default {
 	/* Change pinmux to all 4 pins since CTS and RTS are connected */
-	pinmux {
-		pins = "gpio45", "gpio46",
-		       "gpio47", "gpio48";
-	};
-
-	pinconf-cts {
+	cts-pins {
 		/*
 		 * Configure a pull-down on 45 (CTS) to match the pull of
 		 * the Bluetooth module.
 		 */
 		pins = "gpio45";
+		function = "qup6";
 		bias-pull-down;
 	};
 
-	pinconf-rts-tx {
+	rts-tx-pins {
 		/* We'll drive 46 (RTS) and 47 (TX), so no pull */
 		pins = "gpio46", "gpio47";
+		function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	pinconf-rx {
+	rx-pins {
 		/*
 		 * Configure a pull-up on 48 (RX). This is needed to avoid
 		 * garbage data when the TX pin of the Bluetooth module is
@@ -1110,19 +1107,22 @@ pinconf-rx {
 		 * signal yet).
 		 */
 		pins = "gpio48";
+		function = "qup6";
 		bias-pull-up;
 	};
 };
 
 &qup_uart9_default {
-	pinconf-tx {
+	tx-pins {
 		pins = "gpio4";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	pinconf-rx {
+	rx-pins {
 		pins = "gpio5";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
@@ -1213,243 +1213,153 @@ ap-suspend-l-hog {
 		output-low;
 	};
 
-	ap_edp_bklten: ap-edp-bklten {
-		pinmux {
-			pins = "gpio37";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio37";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	ap_edp_bklten: ap-edp-bklten-state {
+		pins = "gpio37";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	bios_flash_wp_r_l: bios-flash-wp-r-l {
-		pinmux {
-			pins = "gpio128";
-			function = "gpio";
-			input-enable;
-		};
-
-		pinconf {
-			pins = "gpio128";
-			bias-disable;
-		};
+	bios_flash_wp_r_l: bios-flash-wp-r-l-state {
+		pins = "gpio128";
+		function = "gpio";
+		input-enable;
+		bias-disable;
 	};
 
-	ec_ap_int_l: ec-ap-int-l {
-		pinmux {
-		       pins = "gpio122";
-		       function = "gpio";
-		       input-enable;
-		};
-
-		pinconf {
-		       pins = "gpio122";
-		       bias-pull-up;
-		};
+	ec_ap_int_l: ec-ap-int-l-state {
+	       pins = "gpio122";
+	       function = "gpio";
+	       input-enable;
+	       bias-pull-up;
 	};
 
-	edp_brij_en: edp-brij-en {
-		pinmux {
-			pins = "gpio102";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio102";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	edp_brij_en: edp-brij-en-state {
+		pins = "gpio102";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	edp_brij_irq: edp-brij-irq {
-		pinmux {
-			pins = "gpio10";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio10";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	edp_brij_irq: edp-brij-irq-state {
+		pins = "gpio10";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	en_pp3300_dx_edp: en-pp3300-dx-edp {
-		pinmux {
-			pins = "gpio43";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio43";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	en_pp3300_dx_edp: en-pp3300-dx-edp-state {
+		pins = "gpio43";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	h1_ap_int_odl: h1-ap-int-odl {
-		pinmux {
-			pins = "gpio129";
-			function = "gpio";
-			input-enable;
-		};
-
-		pinconf {
-			pins = "gpio129";
-			bias-pull-up;
-		};
+	h1_ap_int_odl: h1-ap-int-odl-state {
+		pins = "gpio129";
+		function = "gpio";
+		input-enable;
+		bias-pull-up;
 	};
 
-	pen_eject_odl: pen-eject-odl {
-		pinmux {
-			pins = "gpio119";
-			function = "gpio";
-			bias-pull-up;
-		};
+	pen_eject_odl: pen-eject-odl-state {
+		pins = "gpio119";
+		function = "gpio";
+		bias-pull-up;
 	};
 
-	pen_irq_l: pen-irq-l {
-		pinmux {
-			pins = "gpio24";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio24";
+	pen_irq_l: pen-irq-l-state {
+		pins = "gpio24";
+		function = "gpio";
 
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	pen_pdct_l: pen-pdct-l {
-		pinmux {
-			pins = "gpio63";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio63";
+	pen_pdct_l: pen-pdct-l-state {
+		pins = "gpio63";
+		function = "gpio";
 
-			/* Has external pullup */
-			bias-disable;
-		};
+		/* Has external pullup */
+		bias-disable;
 	};
 
-	pen_rst_l: pen-rst-l {
-		pinmux  {
-			pins = "gpio23";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio23";
-			bias-disable;
-			drive-strength = <2>;
+	pen_rst_l: pen-rst-l-state {
+		pins = "gpio23";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
 
-			/*
-			 * The pen driver doesn't currently support
-			 * driving this reset line.  By specifying
-			 * output-high here we're relying on the fact
-			 * that this pin has a default pulldown at boot
-			 * (which makes sure the pen was in reset if it
-			 * was powered) and then we set it high here to
-			 * take it out of reset.  Better would be if the
-			 * pen driver could control this and we could
-			 * remove "output-high" here.
-			 */
-			output-high;
-		};
+		/*
+		 * The pen driver doesn't currently support
+		 * driving this reset line.  By specifying
+		 * output-high here we're relying on the fact
+		 * that this pin has a default pulldown at boot
+		 * (which makes sure the pen was in reset if it
+		 * was powered) and then we set it high here to
+		 * take it out of reset.  Better would be if the
+		 * pen driver could control this and we could
+		 * remove "output-high" here.
+		 */
+		output-high;
 	};
 
-	sdc2_clk: sdc2-clk {
-		pinconf {
-			pins = "sdc2_clk";
-			bias-disable;
+	sdc2_clk: sdc2-clk-state {
+		pins = "sdc2_clk";
+		bias-disable;
 
-			/*
-			 * It seems that mmc_test reports errors if drive
-			 * strength is not 16.
-			 */
-			drive-strength = <16>;
-		};
+		/*
+		 * It seems that mmc_test reports errors if drive
+		 * strength is not 16.
+		 */
+		drive-strength = <16>;
 	};
 
-	sdc2_cmd: sdc2-cmd {
-		pinconf {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+	sdc2_cmd: sdc2-cmd-state {
+		pins = "sdc2_cmd";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sdc2_data: sdc2-data {
-		pinconf {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+	sdc2_data: sdc2-data-state {
+		pins = "sdc2_data";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sd_cd_odl: sd-cd-odl {
-		pinmux {
-			pins = "gpio44";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio44";
-			bias-pull-up;
-		};
+	sd_cd_odl: sd-cd-odl-state {
+		pins = "gpio44";
+		function = "gpio";
+		bias-pull-up;
 	};
 
-	ts_int_l: ts-int-l {
-		pinmux  {
-			pins = "gpio125";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio125";
-			bias-pull-up;
-		};
+	ts_int_l: ts-int-l-state {
+		pins = "gpio125";
+		function = "gpio";
+		bias-pull-up;
 	};
 
-	ts_reset_l: ts-reset-l {
-		pinmux  {
-			pins = "gpio118";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio118";
-			bias-disable;
-			drive-strength = <2>;
-		};
+	ts_reset_l: ts-reset-l-state {
+		pins = "gpio118";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
 	};
 
-	ap_suspend_l_assert: ap_suspend_l_assert {
-		config {
-			pins = "gpio126";
-			function = "gpio";
-			bias-disable;
-			drive-strength = <2>;
-			output-low;
-		};
+	ap_suspend_l_assert: ap-suspend-l-assert-state {
+		pins = "gpio126";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
 	};
 
-	ap_suspend_l_deassert: ap_suspend_l_deassert {
-		config {
-			pins = "gpio126";
-			function = "gpio";
-			bias-disable;
-			drive-strength = <2>;
-			output-high;
-		};
+	ap_suspend_l_deassert: ap-suspend-l-deassert-state {
+		pins = "gpio126";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-high;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index a157eab66dee..c5e17a718049 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -820,8 +820,8 @@ &spi2 {
 };
 
 &tlmm {
-	cam0_default: cam0_default {
-		rst {
+	cam0_default: cam0-default-state {
+		rst-pins {
 			pins = "gpio9";
 			function = "gpio";
 
@@ -829,7 +829,7 @@ rst {
 			bias-disable;
 		};
 
-		mclk0 {
+		mclk0-pins {
 			pins = "gpio13";
 			function = "cam_mclk";
 
@@ -838,8 +838,8 @@ mclk0 {
 		};
 	};
 
-	cam3_default: cam3_default {
-		rst {
+	cam3_default: cam3-default-state {
+		rst-pins {
 			function = "gpio";
 			pins = "gpio21";
 
@@ -847,7 +847,7 @@ rst {
 			bias-disable;
 		};
 
-		mclk3 {
+		mclk3-pins {
 			function = "cam_mclk";
 			pins = "gpio16";
 
@@ -856,7 +856,7 @@ mclk3 {
 		};
 	};
 
-	dsi_sw_sel: dsi-sw-sel {
+	dsi_sw_sel: dsi-sw-sel-state {
 		pins = "gpio120";
 		function = "gpio";
 
@@ -865,20 +865,20 @@ dsi_sw_sel: dsi-sw-sel {
 		output-high;
 	};
 
-	lt9611_irq_pin: lt9611-irq {
+	lt9611_irq_pin: lt9611-irq-state {
 		pins = "gpio84";
 		function = "gpio";
 		bias-disable;
 	};
 
-	pcie0_default_state: pcie0-default {
-		clkreq {
+	pcie0_default_state: pcie0-default-state {
+		clkreq-pins {
 			pins = "gpio36";
 			function = "pci_e0";
 			bias-pull-up;
 		};
 
-		reset-n {
+		reset-n-pins {
 			pins = "gpio35";
 			function = "gpio";
 
@@ -887,7 +887,7 @@ reset-n {
 			bias-pull-down;
 		};
 
-		wake-n {
+		wake-n-pins {
 			pins = "gpio37";
 			function = "gpio";
 
@@ -896,7 +896,7 @@ wake-n {
 		};
 	};
 
-	pcie0_pwren_state: pcie0-pwren {
+	pcie0_pwren_state: pcie0-pwren-state {
 		pins = "gpio90";
 		function = "gpio";
 
@@ -904,8 +904,8 @@ pcie0_pwren_state: pcie0-pwren {
 		bias-disable;
 	};
 
-	pcie1_default_state: pcie1-default {
-		perst-n {
+	pcie1_default_state: pcie1-default-state {
+		perst-n-pins {
 			pins = "gpio102";
 			function = "gpio";
 
@@ -913,13 +913,13 @@ perst-n {
 			bias-disable;
 		};
 
-		clkreq {
+		clkreq-pins {
 			pins = "gpio103";
 			function = "pci_e1";
 			bias-pull-up;
 		};
 
-		wake-n {
+		wake-n-pins {
 			pins = "gpio11";
 			function = "gpio";
 
@@ -927,7 +927,7 @@ wake-n {
 			bias-pull-up;
 		};
 
-		reset-n {
+		reset-n-pins {
 			pins = "gpio75";
 			function = "gpio";
 
@@ -937,8 +937,8 @@ reset-n {
 		};
 	};
 
-	sdc2_default_state: sdc2-default {
-		clk {
+	sdc2_default_state: sdc2-default-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 
@@ -949,26 +949,26 @@ clk {
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
 		pins = "gpio126";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	wcd_intr_default: wcd_intr_default {
+	wcd_intr_default: wcd-intr-default-state {
 		pins = <54>;
 		function = "gpio";
 
@@ -1123,20 +1123,20 @@ &wifi {
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 &qup_spi2_default {
-	pinmux {
+	default-pins {
 		drive-strength = <16>;
 	};
 };
 
 &qup_uart3_default{
-	pinmux {
+	default-pins {
 		pins = "gpio41", "gpio42", "gpio43", "gpio44";
 		function = "qup3";
 	};
 };
 
 &qup_i2c10_default {
-	pinconf {
+	default-pins {
 		pins = "gpio55", "gpio56";
 		drive-strength = <2>;
 		bias-disable;
@@ -1144,37 +1144,37 @@ pinconf {
 };
 
 &qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
+	cts-pins {
 		pins = "gpio45";
+		function = "qup6";
 		bias-disable;
 	};
 
-	rts-tx {
+	rts-tx-pins {
 		pins = "gpio46", "gpio47";
+		function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
+	rx-pins {
 		pins = "gpio48";
+		function = "qup6";
 		bias-pull-up;
 	};
 };
 
 &qup_uart9_default {
-	pinconf-tx {
+	tx-pins {
 		pins = "gpio4";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	pinconf-rx {
+	rx-pins {
 		pins = "gpio5";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
@@ -1285,7 +1285,7 @@ ov7251_ep: endpoint {
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 &qup_spi0_default {
-	config {
+	default-pins {
 		drive-strength = <6>;
 		bias-disable;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 1eb423e4be24..3ccfbdb2880e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -558,48 +558,36 @@ &usb_1_qmpphy {
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <81 4>;
 
-	sdc2_clk: sdc2-clk {
-		pinconf {
-			pins = "sdc2_clk";
-			bias-disable;
-
-			/*
-			 * It seems that mmc_test reports errors if drive
-			 * strength is not 16 on clk, cmd, and data pins.
-			 *
-			 * TODO: copy-pasted from mtp, try other values
-			 * on these devices.
-			 */
-			drive-strength = <16>;
-		};
+	sdc2_clk: sdc2-clk-state {
+		pins = "sdc2_clk";
+		bias-disable;
+
+		/*
+		 * It seems that mmc_test reports errors if drive
+		 * strength is not 16 on clk, cmd, and data pins.
+		 *
+		 * TODO: copy-pasted from mtp, try other values
+		 * on these devices.
+		 */
+		drive-strength = <16>;
 	};
 
-	sdc2_cmd: sdc2-cmd {
-		pinconf {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+	sdc2_cmd: sdc2-cmd-state {
+		pins = "sdc2_cmd";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sdc2_data: sdc2-data {
-		pinconf {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+	sdc2_data: sdc2-data-state {
+		pins = "sdc2_data";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sd_card_det_n: sd-card-det-n {
-		pinmux {
-			pins = "gpio126";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio126";
-			bias-pull-up;
-		};
+	sd_card_det_n: sd-card-det-n-state {
+		pins = "gpio126";
+		function = "gpio";
+		bias-pull-up;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
index 7d967a104b3e..a12723310c8b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
@@ -58,7 +58,7 @@ &mss_pil {
 };
 
 &tlmm {
-	thinq_key_default: thinq-key-default {
+	thinq_key_default: thinq-key-default-state {
 		pins = "gpio89";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index de2d10e0315a..b36befe60b08 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -719,7 +719,7 @@ &wifi {
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qup_i2c10_default {
-	pinconf {
+	default-pins {
 		pins = "gpio55", "gpio56";
 		drive-strength = <2>;
 		bias-disable;
@@ -727,14 +727,16 @@ pinconf {
 };
 
 &qup_uart9_default {
-	pinconf-tx {
+	tx-pins {
 		pins = "gpio4";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	pinconf-rx {
+	rx-pins {
 		pins = "gpio5";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
@@ -743,44 +745,32 @@ pinconf-rx {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	sdc2_clk: sdc2-clk {
-		pinconf {
-			pins = "sdc2_clk";
-			bias-disable;
+	sdc2_clk: sdc2-clk-state {
+		pins = "sdc2_clk";
+		bias-disable;
 
-			/*
-			 * It seems that mmc_test reports errors if drive
-			 * strength is not 16 on clk, cmd, and data pins.
-			 */
-			drive-strength = <16>;
-		};
+		/*
+		 * It seems that mmc_test reports errors if drive
+		 * strength is not 16 on clk, cmd, and data pins.
+		 */
+		drive-strength = <16>;
 	};
 
-	sdc2_cmd: sdc2-cmd {
-		pinconf {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+	sdc2_cmd: sdc2-cmd-state {
+		pins = "sdc2_cmd";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sdc2_data: sdc2-data {
-		pinconf {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+	sdc2_data: sdc2-data-state {
+		pins = "sdc2_data";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sd_card_det_n: sd-card-det-n {
-		pinmux {
-			pins = "gpio126";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio126";
-			bias-pull-up;
-		};
+	sd_card_det_n: sd-card-det-n-state {
+		pins = "gpio126";
+		function = "gpio";
+		bias-pull-up;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 392461c29e76..02a1e056f465 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -470,7 +470,7 @@ &qupv3_id_0 {
 };
 
 &qup_i2c12_default {
-	mux {
+	default-pins {
 		pins = "gpio49", "gpio50";
 		function = "qup12";
 		drive-strength = <2>;
@@ -479,7 +479,7 @@ mux {
 };
 
 &qup_i2c10_default {
-	pinconf {
+	default-pins {
 		pins = "gpio55", "gpio56";
 		drive-strength = <2>;
 		bias-disable;
@@ -487,14 +487,16 @@ pinconf {
 };
 
 &qup_uart9_default {
-	pinconf-tx {
+	tx-pins {
 		pins = "gpio4";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	pinconf-rx {
+	rx-pins {
 		pins = "gpio5";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
@@ -504,24 +506,22 @@ pinconf-rx {
  * Prevent garbage data on bluetooth UART lines
  */
 &qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
+	cts-pins {
 		pins = "gpio45";
+		function = "qup6";
 		bias-pull-down;
 	};
 
-	rts-tx {
+	rts-tx-pins {
 		pins = "gpio46", "gpio47";
+		function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
+	rx-pins {
 		pins = "gpio48";
+		function = "qup6";
 		bias-pull-up;
 	};
 };
@@ -607,51 +607,41 @@ &usb_1_hsphy {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	tri_state_key_default: tri_state_key_default {
-		mux {
-			pins = "gpio40", "gpio42", "gpio26";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	tri_state_key_default: tri-state-key-default-state {
+		pins = "gpio40", "gpio42", "gpio26";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	ts_default_pins: ts-int {
-		mux {
-			pins = "gpio99", "gpio125";
-			function = "gpio";
-			drive-strength = <16>;
-			bias-pull-up;
-		};
+	ts_default_pins: ts-int-state {
+		pins = "gpio99", "gpio125";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
 	};
 
-	panel_reset_pins: panel-reset {
-		mux {
-			pins = "gpio6", "gpio25", "gpio26";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
+	panel_reset_pins: panel-reset-state {
+		pins = "gpio6", "gpio25", "gpio26";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
 	};
 
-	panel_te_pin: panel-te {
-		mux {
-			pins = "gpio10";
-			function = "mdp_vsync";
-			drive-strength = <2>;
-			bias-disable;
-			input-enable;
-		};
+	panel_te_pin: panel-te-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
 	};
 
-	panel_esd_pin: panel-esd {
-		mux {
-			pins = "gpio30";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-down;
-			input-enable;
-		};
+	panel_esd_pin: panel-esd-state {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+		input-enable;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 83261c9bb4f2..7c752f621a23 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -559,14 +559,16 @@ led@5 {
 };
 
 &qup_uart9_default {
-	pinconf-rx {
+	rx-pins {
 		pins = "gpio5";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
-	pinconf-tx {
+	tx-pins {
 		pins = "gpio4";
+		function = "qup9";
 		drive-strength = <2>;
 		bias-disable;
 	};
@@ -583,110 +585,62 @@ &qupv3_id_1 {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	sde_dsi_active: sde-dsi-active {
-		mux {
-			pins = "gpio6", "gpio11";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio6", "gpio11";
-			drive-strength = <8>;
-			bias-disable;
-		};
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio6", "gpio11";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
 	};
 
-	sde_dsi_suspend: sde-dsi-suspend {
-		mux {
-			pins = "gpio6", "gpio11";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio6", "gpio11";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio6", "gpio11";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	sde_te_active: sde-te-active {
-		mux {
-			pins = "gpio10";
-			function = "mdp_vsync";
-		};
-
-		config {
-			pins = "gpio10";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	sde_te_active: sde-te-active-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	sde_te_suspend: sde-te-suspend {
-		mux {
-			pins = "gpio10";
-			function = "mdp_vsync";
-		};
-
-		config {
-			pins = "gpio10";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	sde_te_suspend: sde-te-suspend-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	ts_int_active: ts-int-active {
-		mux {
-			pins = "gpio125";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio125";
-			drive-strength = <8>;
-			bias-pull-up;
-			input-enable;
-		};
+	ts_int_active: ts-int-active-state {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		input-enable;
 	};
 
-	ts_int_suspend: ts-int-suspend {
-		mux {
-			pins = "gpio125";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio125";
-			drive-strength = <2>;
-			bias-pull-down;
-			input-enable;
-		};
+	ts_int_suspend: ts-int-suspend-state {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+		input-enable;
 	};
 
-	ts_reset_active: ts-reset-active {
-		mux {
-			pins = "gpio99";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio99";
-			drive-strength = <8>;
-			bias-pull-up;
-		};
+	ts_reset_active: ts-reset-active-state {
+		pins = "gpio99";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
 	};
 
-	ts_reset_suspend: ts-reset-suspend {
-		mux {
-			pins = "gpio99";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio99";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	ts_reset_suspend: ts-reset-suspend-state {
+		pins = "gpio99";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 51ee42e3c995..3a920275dda3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -383,19 +383,19 @@ &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
 	sdc2_default_state: sdc2-default-state {
-		clk {
+		clk-pins {
 			pins = "sdc2_clk";
 			drive-strength = <16>;
 			bias-disable;
 		};
 
-		cmd {
+		cmd-pins {
 			pins = "sdc2_cmd";
 			drive-strength = <10>;
 			bias-pull-up;
 		};
 
-		data {
+		data-pins {
 			pins = "sdc2_data";
 			drive-strength = <10>;
 			bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 0f470cf1ed1c..d6392f3486ae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -442,33 +442,33 @@ codec {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
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
 		pins = "gpio126";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	wcd_intr_default: wcd_intr_default {
+	wcd_intr_default: wcd-intr-default-state {
 		pins = <54>;
 		function = "gpio";
 
@@ -571,24 +571,22 @@ &wifi {
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
+	cts-pins {
 		pins = "gpio45";
+		function = "qup6";
 		bias-disable;
 	};
 
-	rts-tx {
+	rts-tx-pins {
 		pins = "gpio46", "gpio47";
+		function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
+	rx-pins {
 		pins = "gpio48";
+		function = "qup6";
 		bias-pull-up;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index f98259489679..9a4e1ff1d3ba 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -573,7 +573,7 @@ &qupv3_id_1 {
 };
 
 &qup_i2c14_default {
-	pinconf {
+	default-pins {
 		pins = "gpio33", "gpio34";
 		drive-strength = <2>;
 		bias-disable;
@@ -583,14 +583,14 @@ pinconf {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	ts_reset_default: ts-reset-default {
+	ts_reset_default: ts-reset-default-state {
 		pins = "gpio99";
 		function = "gpio";
 		drive-strength = <16>;
 		output-high;
 	};
 
-	ts_int_default: ts-int-default {
+	ts_int_default: ts-int-default-state {
 		pins = "gpio125";
 		function = "gpio";
 		bias-pull-down;
@@ -598,14 +598,14 @@ ts_int_default: ts-int-default {
 		input-enable;
 	};
 
-	ts_reset_sleep: ts-reset-sleep {
+	ts_reset_sleep: ts-reset-sleep-state {
 		pins = "gpio99";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	ts_int_sleep: ts-int-sleep {
+	ts_int_sleep: ts-int-sleep-state {
 		pins = "gpio125";
 		function = "gpio";
 		bias-pull-down;
@@ -613,21 +613,21 @@ ts_int_sleep: ts-int-sleep {
 		input-enable;
 	};
 
-	sde_dsi_active: sde-dsi-active {
+	sde_dsi_active: sde-dsi-active-state {
 		pins = "gpio6", "gpio10";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-disable;
 	};
 
-	sde_dsi_suspend: sde-dsi-suspend {
+	sde_dsi_suspend: sde-dsi-suspend-state {
 		pins = "gpio6", "gpio10";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
 	};
 
-	wcd_intr_default: wcd-intr-default {
+	wcd_intr_default: wcd-intr-default-state {
 		pins = "gpio54";
 		function = "gpio";
 		input-enable;
@@ -739,24 +739,22 @@ &wifi {
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qup_uart6_default {
-	pinmux {
-		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		 function = "qup6";
-	};
-
-	cts {
+	cts-pins {
 		pins = "gpio45";
+		function = "qup6";
 		bias-disable;
 	};
 
-	rts-tx {
+	rts-tx-pins {
 		pins = "gpio46", "gpio47";
+		function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
+	rx-pins {
 		pins = "gpio48";
+		function = "qup6";
 		bias-pull-up;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da47220d..915ef8dda023 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2641,7 +2641,7 @@ tlmm: pinctrl@3400000 {
 			gpio-ranges = <&tlmm 0 0 151>;
 			wakeup-parent = <&pdc_intc>;
 
-			cci0_default: cci0-default {
+			cci0_default: cci0-default-state {
 				/* SDA, SCL */
 				pins = "gpio17", "gpio18";
 				function = "cci_i2c";
@@ -2650,7 +2650,7 @@ cci0_default: cci0-default {
 				drive-strength = <2>; /* 2 mA */
 			};
 
-			cci0_sleep: cci0-sleep {
+			cci0_sleep: cci0-sleep-state {
 				/* SDA, SCL */
 				pins = "gpio17", "gpio18";
 				function = "cci_i2c";
@@ -2659,7 +2659,7 @@ cci0_sleep: cci0-sleep {
 				bias-pull-down;
 			};
 
-			cci1_default: cci1-default {
+			cci1_default: cci1-default-state {
 				/* SDA, SCL */
 				pins = "gpio19", "gpio20";
 				function = "cci_i2c";
@@ -2668,7 +2668,7 @@ cci1_default: cci1-default {
 				drive-strength = <2>; /* 2 mA */
 			};
 
-			cci1_sleep: cci1-sleep {
+			cci1_sleep: cci1-sleep-state {
 				/* SDA, SCL */
 				pins = "gpio19", "gpio20";
 				function = "cci_i2c";
@@ -2677,531 +2677,486 @@ cci1_sleep: cci1-sleep {
 				bias-pull-down;
 			};
 
-			qspi_clk: qspi-clk {
-				pinmux {
+			qspi_clk: qspi-clk-state {
+				default-pins {
 					pins = "gpio95";
 					function = "qspi_clk";
 				};
 			};
 
-			qspi_cs0: qspi-cs0 {
-				pinmux {
+			qspi_cs0: qspi-cs0-state {
+				default-pins {
 					pins = "gpio90";
 					function = "qspi_cs";
 				};
 			};
 
-			qspi_cs1: qspi-cs1 {
-				pinmux {
+			qspi_cs1: qspi-cs1-state {
+				default-pins {
 					pins = "gpio89";
 					function = "qspi_cs";
 				};
 			};
 
-			qspi_data01: qspi-data01 {
-				pinmux-data {
+			qspi_data01: qspi-data01-state {
+				default-pins {
 					pins = "gpio91", "gpio92";
 					function = "qspi_data";
 				};
 			};
 
-			qspi_data12: qspi-data12 {
-				pinmux-data {
+			qspi_data12: qspi-data12-state {
+				default-pins {
 					pins = "gpio93", "gpio94";
 					function = "qspi_data";
 				};
 			};
 
-			qup_i2c0_default: qup-i2c0-default {
-				pinmux {
+			qup_i2c0_default: qup-i2c0-default-state {
+				default-pins {
 					pins = "gpio0", "gpio1";
 					function = "qup0";
 				};
 			};
 
-			qup_i2c1_default: qup-i2c1-default {
-				pinmux {
+			qup_i2c1_default: qup-i2c1-default-state {
+				default-pins {
 					pins = "gpio17", "gpio18";
 					function = "qup1";
 				};
 			};
 
-			qup_i2c2_default: qup-i2c2-default {
-				pinmux {
+			qup_i2c2_default: qup-i2c2-default-state {
+				default-pins {
 					pins = "gpio27", "gpio28";
 					function = "qup2";
 				};
 			};
 
-			qup_i2c3_default: qup-i2c3-default {
-				pinmux {
+			qup_i2c3_default: qup-i2c3-default-state {
+				default-pins {
 					pins = "gpio41", "gpio42";
 					function = "qup3";
 				};
 			};
 
-			qup_i2c4_default: qup-i2c4-default {
-				pinmux {
+			qup_i2c4_default: qup-i2c4-default-state {
+				default-pins {
 					pins = "gpio89", "gpio90";
 					function = "qup4";
 				};
 			};
 
-			qup_i2c5_default: qup-i2c5-default {
-				pinmux {
+			qup_i2c5_default: qup-i2c5-default-state {
+				default-pins {
 					pins = "gpio85", "gpio86";
 					function = "qup5";
 				};
 			};
 
-			qup_i2c6_default: qup-i2c6-default {
-				pinmux {
+			qup_i2c6_default: qup-i2c6-default-state {
+				default-pins {
 					pins = "gpio45", "gpio46";
 					function = "qup6";
 				};
 			};
 
-			qup_i2c7_default: qup-i2c7-default {
-				pinmux {
+			qup_i2c7_default: qup-i2c7-default-state {
+				default-pins {
 					pins = "gpio93", "gpio94";
 					function = "qup7";
 				};
 			};
 
-			qup_i2c8_default: qup-i2c8-default {
-				pinmux {
+			qup_i2c8_default: qup-i2c8-default-state {
+				default-pins {
 					pins = "gpio65", "gpio66";
 					function = "qup8";
 				};
 			};
 
-			qup_i2c9_default: qup-i2c9-default {
-				pinmux {
+			qup_i2c9_default: qup-i2c9-default-state {
+				default-pins {
 					pins = "gpio6", "gpio7";
 					function = "qup9";
 				};
 			};
 
-			qup_i2c10_default: qup-i2c10-default {
-				pinmux {
+			qup_i2c10_default: qup-i2c10-default-state {
+				default-pins {
 					pins = "gpio55", "gpio56";
 					function = "qup10";
 				};
 			};
 
-			qup_i2c11_default: qup-i2c11-default {
-				pinmux {
+			qup_i2c11_default: qup-i2c11-default-state {
+				default-pins {
 					pins = "gpio31", "gpio32";
 					function = "qup11";
 				};
 			};
 
-			qup_i2c12_default: qup-i2c12-default {
-				pinmux {
+			qup_i2c12_default: qup-i2c12-default-state {
+				default-pins {
 					pins = "gpio49", "gpio50";
 					function = "qup12";
 				};
 			};
 
-			qup_i2c13_default: qup-i2c13-default {
-				pinmux {
+			qup_i2c13_default: qup-i2c13-default-state {
+				default-pins {
 					pins = "gpio105", "gpio106";
 					function = "qup13";
 				};
 			};
 
-			qup_i2c14_default: qup-i2c14-default {
-				pinmux {
+			qup_i2c14_default: qup-i2c14-default-state {
+				default-pins {
 					pins = "gpio33", "gpio34";
 					function = "qup14";
 				};
 			};
 
-			qup_i2c15_default: qup-i2c15-default {
-				pinmux {
+			qup_i2c15_default: qup-i2c15-default-state {
+				default-pins {
 					pins = "gpio81", "gpio82";
 					function = "qup15";
 				};
 			};
 
-			qup_spi0_default: qup-spi0-default {
-				pinmux {
+			qup_spi0_default: qup-spi0-default-state {
+				default-pins {
 					pins = "gpio0", "gpio1",
 					       "gpio2", "gpio3";
 					function = "qup0";
-				};
-
-				config {
-					pins = "gpio0", "gpio1",
-					       "gpio2", "gpio3";
 					drive-strength = <6>;
 					bias-disable;
 				};
 			};
 
-			qup_spi1_default: qup-spi1-default {
-				pinmux {
+			qup_spi1_default: qup-spi1-default-state {
+				default-pins {
 					pins = "gpio17", "gpio18",
 					       "gpio19", "gpio20";
 					function = "qup1";
 				};
 			};
 
-			qup_spi2_default: qup-spi2-default {
-				pinmux {
+			qup_spi2_default: qup-spi2-default-state {
+				default-pins {
 					pins = "gpio27", "gpio28",
 					       "gpio29", "gpio30";
 					function = "qup2";
 				};
 			};
 
-			qup_spi3_default: qup-spi3-default {
-				pinmux {
+			qup_spi3_default: qup-spi3-default-state {
+				default-pins {
 					pins = "gpio41", "gpio42",
 					       "gpio43", "gpio44";
 					function = "qup3";
 				};
 			};
 
-			qup_spi4_default: qup-spi4-default {
-				pinmux {
+			qup_spi4_default: qup-spi4-default-state {
+				default-pins {
 					pins = "gpio89", "gpio90",
 					       "gpio91", "gpio92";
 					function = "qup4";
 				};
 			};
 
-			qup_spi5_default: qup-spi5-default {
-				pinmux {
+			qup_spi5_default: qup-spi5-default-state {
+				default-pins {
 					pins = "gpio85", "gpio86",
 					       "gpio87", "gpio88";
 					function = "qup5";
 				};
 			};
 
-			qup_spi6_default: qup-spi6-default {
-				pinmux {
+			qup_spi6_default: qup-spi6-default-state {
+				default-pins {
 					pins = "gpio45", "gpio46",
 					       "gpio47", "gpio48";
 					function = "qup6";
 				};
 			};
 
-			qup_spi7_default: qup-spi7-default {
-				pinmux {
+			qup_spi7_default: qup-spi7-default-state {
+				default-pins {
 					pins = "gpio93", "gpio94",
 					       "gpio95", "gpio96";
 					function = "qup7";
 				};
 			};
 
-			qup_spi8_default: qup-spi8-default {
-				pinmux {
+			qup_spi8_default: qup-spi8-default-state {
+				default-pins {
 					pins = "gpio65", "gpio66",
 					       "gpio67", "gpio68";
 					function = "qup8";
 				};
 			};
 
-			qup_spi9_default: qup-spi9-default {
-				pinmux {
+			qup_spi9_default: qup-spi9-default-state {
+				default-pins {
 					pins = "gpio6", "gpio7",
 					       "gpio4", "gpio5";
 					function = "qup9";
 				};
 			};
 
-			qup_spi10_default: qup-spi10-default {
-				pinmux {
+			qup_spi10_default: qup-spi10-default-state {
+				default-pins {
 					pins = "gpio55", "gpio56",
 					       "gpio53", "gpio54";
 					function = "qup10";
 				};
 			};
 
-			qup_spi11_default: qup-spi11-default {
-				pinmux {
+			qup_spi11_default: qup-spi11-default-state {
+				default-pins {
 					pins = "gpio31", "gpio32",
 					       "gpio33", "gpio34";
 					function = "qup11";
 				};
 			};
 
-			qup_spi12_default: qup-spi12-default {
-				pinmux {
+			qup_spi12_default: qup-spi12-default-state {
+				default-pins {
 					pins = "gpio49", "gpio50",
 					       "gpio51", "gpio52";
 					function = "qup12";
 				};
 			};
 
-			qup_spi13_default: qup-spi13-default {
-				pinmux {
+			qup_spi13_default: qup-spi13-default-state {
+				default-pins {
 					pins = "gpio105", "gpio106",
 					       "gpio107", "gpio108";
 					function = "qup13";
 				};
 			};
 
-			qup_spi14_default: qup-spi14-default {
-				pinmux {
+			qup_spi14_default: qup-spi14-default-state {
+				default-pins {
 					pins = "gpio33", "gpio34",
 					       "gpio31", "gpio32";
 					function = "qup14";
 				};
 			};
 
-			qup_spi15_default: qup-spi15-default {
-				pinmux {
+			qup_spi15_default: qup-spi15-default-state {
+				default-pins {
 					pins = "gpio81", "gpio82",
 					       "gpio83", "gpio84";
 					function = "qup15";
 				};
 			};
 
-			qup_uart0_default: qup-uart0-default {
-				pinmux {
+			qup_uart0_default: qup-uart0-default-state {
+				default-pins {
 					pins = "gpio2", "gpio3";
 					function = "qup0";
 				};
 			};
 
-			qup_uart1_default: qup-uart1-default {
-				pinmux {
+			qup_uart1_default: qup-uart1-default-state {
+				default-pins {
 					pins = "gpio19", "gpio20";
 					function = "qup1";
 				};
 			};
 
-			qup_uart2_default: qup-uart2-default {
-				pinmux {
+			qup_uart2_default: qup-uart2-default-state {
+				default-pins {
 					pins = "gpio29", "gpio30";
 					function = "qup2";
 				};
 			};
 
-			qup_uart3_default: qup-uart3-default {
-				pinmux {
+			qup_uart3_default: qup-uart3-default-state {
+				default-pins {
 					pins = "gpio43", "gpio44";
 					function = "qup3";
 				};
 			};
 
-			qup_uart4_default: qup-uart4-default {
-				pinmux {
+			qup_uart4_default: qup-uart4-default-state {
+				default-pins {
 					pins = "gpio91", "gpio92";
 					function = "qup4";
 				};
 			};
 
-			qup_uart5_default: qup-uart5-default {
-				pinmux {
+			qup_uart5_default: qup-uart5-default-state {
+				default-pins {
 					pins = "gpio87", "gpio88";
 					function = "qup5";
 				};
 			};
 
-			qup_uart6_default: qup-uart6-default {
-				pinmux {
+			qup_uart6_default: qup-uart6-default-state {
+				default-pins {
 					pins = "gpio47", "gpio48";
 					function = "qup6";
 				};
 			};
 
-			qup_uart7_default: qup-uart7-default {
-				pinmux {
+			qup_uart7_default: qup-uart7-default-state {
+				default-pins {
 					pins = "gpio95", "gpio96";
 					function = "qup7";
 				};
 			};
 
-			qup_uart8_default: qup-uart8-default {
-				pinmux {
+			qup_uart8_default: qup-uart8-default-state {
+				default-pins {
 					pins = "gpio67", "gpio68";
 					function = "qup8";
 				};
 			};
 
-			qup_uart9_default: qup-uart9-default {
-				pinmux {
+			qup_uart9_default: qup-uart9-default-state {
+				default-pins {
 					pins = "gpio4", "gpio5";
 					function = "qup9";
 				};
 			};
 
-			qup_uart10_default: qup-uart10-default {
-				pinmux {
+			qup_uart10_default: qup-uart10-default-state {
+				default-pins {
 					pins = "gpio53", "gpio54";
 					function = "qup10";
 				};
 			};
 
-			qup_uart11_default: qup-uart11-default {
-				pinmux {
+			qup_uart11_default: qup-uart11-default-state {
+				default-pins {
 					pins = "gpio33", "gpio34";
 					function = "qup11";
 				};
 			};
 
-			qup_uart12_default: qup-uart12-default {
-				pinmux {
+			qup_uart12_default: qup-uart12-default-state {
+				default-pins {
 					pins = "gpio51", "gpio52";
 					function = "qup12";
 				};
 			};
 
-			qup_uart13_default: qup-uart13-default {
-				pinmux {
+			qup_uart13_default: qup-uart13-default-state {
+				default-pins {
 					pins = "gpio107", "gpio108";
 					function = "qup13";
 				};
 			};
 
-			qup_uart14_default: qup-uart14-default {
-				pinmux {
+			qup_uart14_default: qup-uart14-default-state {
+				default-pins {
 					pins = "gpio31", "gpio32";
 					function = "qup14";
 				};
 			};
 
-			qup_uart15_default: qup-uart15-default {
-				pinmux {
+			qup_uart15_default: qup-uart15-default-state {
+				default-pins {
 					pins = "gpio83", "gpio84";
 					function = "qup15";
 				};
 			};
 
-			quat_mi2s_sleep: quat_mi2s_sleep {
-				mux {
+			quat_mi2s_sleep: quat-mi2s-sleep-state {
+				default-pins {
 					pins = "gpio58", "gpio59";
 					function = "gpio";
-				};
-
-				config {
-					pins = "gpio58", "gpio59";
 					drive-strength = <2>;
 					bias-pull-down;
 					input-enable;
 				};
 			};
 
-			quat_mi2s_active: quat_mi2s_active {
-				mux {
+			quat_mi2s_active: quat-mi2s-active-state {
+				default-pins {
 					pins = "gpio58", "gpio59";
 					function = "qua_mi2s";
-				};
-
-				config {
-					pins = "gpio58", "gpio59";
 					drive-strength = <8>;
 					bias-disable;
 					output-high;
 				};
 			};
 
-			quat_mi2s_sd0_sleep: quat_mi2s_sd0_sleep {
-				mux {
+			quat_mi2s_sd0_sleep: quat-mi2s-sd0-sleep-state {
+				default-pins {
 					pins = "gpio60";
 					function = "gpio";
-				};
-
-				config {
-					pins = "gpio60";
 					drive-strength = <2>;
 					bias-pull-down;
 					input-enable;
 				};
 			};
 
-			quat_mi2s_sd0_active: quat_mi2s_sd0_active {
-				mux {
+			quat_mi2s_sd0_active: quat-mi2s-sd0-active-state {
+				default-pins {
 					pins = "gpio60";
 					function = "qua_mi2s";
-				};
-
-				config {
-					pins = "gpio60";
 					drive-strength = <8>;
 					bias-disable;
 				};
 			};
 
-			quat_mi2s_sd1_sleep: quat_mi2s_sd1_sleep {
-				mux {
+			quat_mi2s_sd1_sleep: quat-mi2s-sd1-sleep-state {
+				default-pins {
 					pins = "gpio61";
 					function = "gpio";
-				};
-
-				config {
-					pins = "gpio61";
 					drive-strength = <2>;
 					bias-pull-down;
 					input-enable;
 				};
 			};
 
-			quat_mi2s_sd1_active: quat_mi2s_sd1_active {
-				mux {
+			quat_mi2s_sd1_active: quat-mi2s-sd1-active-state {
+				default-pins {
 					pins = "gpio61";
 					function = "qua_mi2s";
-				};
-
-				config {
-					pins = "gpio61";
 					drive-strength = <8>;
 					bias-disable;
 				};
 			};
 
-			quat_mi2s_sd2_sleep: quat_mi2s_sd2_sleep {
-				mux {
+			quat_mi2s_sd2_sleep: quat-mi2s-sd2-sleep-state {
+				default-pins {
 					pins = "gpio62";
 					function = "gpio";
-				};
-
-				config {
-					pins = "gpio62";
 					drive-strength = <2>;
 					bias-pull-down;
 					input-enable;
 				};
 			};
 
-			quat_mi2s_sd2_active: quat_mi2s_sd2_active {
-				mux {
+			quat_mi2s_sd2_active: quat-mi2s-sd2-active-state {
+				default-pins {
 					pins = "gpio62";
 					function = "qua_mi2s";
-				};
-
-				config {
-					pins = "gpio62";
 					drive-strength = <8>;
 					bias-disable;
 				};
 			};
 
-			quat_mi2s_sd3_sleep: quat_mi2s_sd3_sleep {
-				mux {
+			quat_mi2s_sd3_sleep: quat-mi2s-sd3-sleep-state {
+				default-pins {
 					pins = "gpio63";
 					function = "gpio";
-				};
-
-				config {
-					pins = "gpio63";
 					drive-strength = <2>;
 					bias-pull-down;
 					input-enable;
 				};
 			};
 
-			quat_mi2s_sd3_active: quat_mi2s_sd3_active {
-				mux {
+			quat_mi2s_sd3_active: quat-mi2s-sd3-active-state {
+				default-pins {
 					pins = "gpio63";
 					function = "qua_mi2s";
-				};
-
-				config {
-					pins = "gpio63";
 					drive-strength = <8>;
 					bias-disable;
 				};
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 74f43da51fa5..e4473b31cea9 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -479,7 +479,7 @@ &mss_pil {
 };
 
 &qup_i2c10_default {
-	pinconf {
+	default-pins {
 		pins = "gpio55", "gpio56";
 		drive-strength = <2>;
 		bias-disable;
@@ -487,31 +487,29 @@ pinconf {
 };
 
 &qup_i2c12_default {
-	pinmux {
+	default-pins {
 		drive-strength = <2>;
 		bias-disable;
 	};
 };
 
 &qup_uart6_default {
-	pinmux {
-		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		 function = "qup6";
-	};
-
-	cts {
+	cts-pins {
 		pins = "gpio45";
+		 function = "qup6";
 		bias-pull-down;
 	};
 
-	rts-tx {
+	rts-tx-pins {
 		pins = "gpio46", "gpio47";
+		 function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
+	rx-pins {
 		pins = "gpio48";
+		 function = "qup6";
 		bias-pull-up;
 	};
 };
@@ -621,13 +619,14 @@ codec {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	sn65dsi86_pin_active: sn65dsi86-enable {
+	sn65dsi86_pin_active: sn65dsi86-enable-state {
 		pins = "gpio96";
+		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	i2c3_hid_active: i2c2-hid-active {
+	i2c3_hid_active: i2c2-hid-active-state {
 		pins = "gpio37";
 		function = "gpio";
 
@@ -636,7 +635,7 @@ i2c3_hid_active: i2c2-hid-active {
 		drive-strength = <2>;
 	};
 
-	i2c5_hid_active: i2c5-hid-active {
+	i2c5_hid_active: i2c5-hid-active-state {
 		pins = "gpio125";
 		function = "gpio";
 
@@ -645,7 +644,7 @@ i2c5_hid_active: i2c5-hid-active {
 		drive-strength = <2>;
 	};
 
-	i2c11_hid_active: i2c11-hid-active {
+	i2c11_hid_active: i2c11-hid-active-state {
 		pins = "gpio92";
 		function = "gpio";
 
@@ -654,7 +653,7 @@ i2c11_hid_active: i2c11-hid-active {
 		drive-strength = <2>;
 	};
 
-	wcd_intr_default: wcd_intr_default {
+	wcd_intr_default: wcd-intr-default-state {
 		pins = "gpio54";
 		function = "gpio";
 
@@ -663,7 +662,7 @@ wcd_intr_default: wcd_intr_default {
 		drive-strength = <2>;
 	};
 
-	lid_pin_active: lid-pin {
+	lid_pin_active: lid-pin-state {
 		pins = "gpio124";
 		function = "gpio";
 
@@ -671,7 +670,7 @@ lid_pin_active: lid-pin {
 		bias-disable;
 	};
 
-	mode_pin_active: mode-pin {
+	mode_pin_active: mode-pin-state {
 		pins = "gpio95";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index d028a7eb364a..75b612fb4775 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -399,7 +399,7 @@ &mss_pil {
 };
 
 &qup_i2c10_default {
-	pinconf {
+	default-pins {
 		pins = "gpio55", "gpio56";
 		drive-strength = <2>;
 		bias-disable;
@@ -407,7 +407,7 @@ pinconf {
 };
 
 &qup_i2c11_default {
-	pinconf {
+	default-pins {
 		pins = "gpio31", "gpio32";
 		drive-strength = <2>;
 		bias-disable;
@@ -415,31 +415,29 @@ pinconf {
 };
 
 &qup_i2c12_default {
-	pinmux {
+	default-pins {
 		drive-strength = <2>;
 		bias-disable;
 	};
 };
 
 &qup_uart6_default {
-	pinmux {
-		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		 function = "qup6";
-	};
-
-	cts {
+	cts-pins {
 		pins = "gpio45";
+		 function = "qup6";
 		bias-pull-down;
 	};
 
-	rts-tx {
+	rts-tx-pins {
 		pins = "gpio46", "gpio47";
+		 function = "qup6";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	rx {
+	rx-pins {
 		pins = "gpio48";
+		 function = "qup6";
 		bias-pull-up;
 	};
 };
@@ -549,59 +547,41 @@ codec {
 &tlmm {
 	gpio-reserved-ranges = <0 6>, <85 4>;
 
-	pen_irq_l: pen-irq-l {
-		pinmux {
-			pins = "gpio119";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio119";
-			bias-disable;
-		};
+	pen_irq_l: pen-irq-l-state {
+		pins = "gpio119";
+		function = "gpio";
+		bias-disable;
 	};
 
-	pen_pdct_l: pen-pdct-l {
-		pinmux {
-			pins = "gpio124";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio124";
-			bias-disable;
-			drive-strength = <2>;
-			output-high;
-		};
+	pen_pdct_l: pen-pdct-l-state {
+		pins = "gpio124";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-high;
 	};
 
-	pen_rst_l: pen-rst-l {
-		pinmux  {
-			pins = "gpio21";
-			function = "gpio";
-		};
-
-		pinconf {
-			pins = "gpio21";
-			bias-disable;
-			drive-strength = <2>;
-
-			/*
-			 * The pen driver doesn't currently support
-			 * driving this reset line.  By specifying
-			 * output-high here we're relying on the fact
-			 * that this pin has a default pulldown at boot
-			 * (which makes sure the pen was in reset if it
-			 * was powered) and then we set it high here to
-			 * take it out of reset.  Better would be if the
-			 * pen driver could control this and we could
-			 * remove "output-high" here.
-			 */
-			output-high;
-		};
+	pen_rst_l: pen-rst-l-state {
+		pins = "gpio21";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+
+		/*
+		 * The pen driver doesn't currently support
+		 * driving this reset line.  By specifying
+		 * output-high here we're relying on the fact
+		 * that this pin has a default pulldown at boot
+		 * (which makes sure the pen was in reset if it
+		 * was powered) and then we set it high here to
+		 * take it out of reset.  Better would be if the
+		 * pen driver could control this and we could
+		 * remove "output-high" here.
+		 */
+		output-high;
 	};
 
-	wcd_intr_default: wcd_intr_default {
+	wcd_intr_default: wcd-intr-default-state {
 		pins = "gpio54";
 		function = "gpio";
 
-- 
2.34.1

