Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09350654404
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiLVPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiLVPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:13:32 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54726DA0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:13:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m29so3126056lfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYxRgf7HZVeEYn/xUl2qJfn8hX6rl1sdKvPmDjlkIvo=;
        b=Gc93i+0/IhPbvj06f9ox1axZtPpRujo5FFvy8nU7boOi1pt4DAhhQDEuTWjRAfA8GL
         Fqstz2FzbNXzciiJU2dlNZ3m0y9VnpQOxvr0pckzDVeP1VtG4QjKrtbVttorbkSXfZZX
         Dx7WvmnUThz6IzZkBN7mlDimhliACURc9xs4ochUlXSPdxWvqMaVUGa1UOozOkYoXe5X
         KVJP6jaKUoUSgkqRFt9QZNymxlptMPBnVXT3njzdUdd0h8ImVDx36cE/2KVsxjqYcYMv
         4X8lXUIvnSAfr5yWfM+ePPmcqhq2bJCCCoVcg70n9ZyJEWpWfEqHSY1/IE9HM90sBvy7
         1qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYxRgf7HZVeEYn/xUl2qJfn8hX6rl1sdKvPmDjlkIvo=;
        b=h9a8wjdHXX5C0NOarHlnvv39dR2riwxFG5rVMkLASb/xbURX54H0vhdhyTYcNfSK6o
         5tpILjYM2BOTTOqRUH7W1Wv3IXVmuy6DGlw5HnH5GkX2RSVafe12pm3rPDJq/vJg80z9
         VqVtaU3ws8HYZvPhQKN8Q/usbkW5yas6lOWkov33qobLPjBasL2W60se2lnM8WnixrIr
         4dQZXHboGM2zgcPaa8HJKeqBdlfSsdZLiwTEMaAdCWz4BslbviEZk4o+0gZlkprFbZgA
         uaFZ6fMh/kLyJMfzbs+m0w4pBPvwAZDf3su5kOjv2uf+KWXas04PPMr4zUV3VAe47Tiu
         M+OA==
X-Gm-Message-State: AFqh2kru5+r8BwBIB0xwLnvXHPVrjAtLEjQDbiFZ2U8x+DNdaakJtiKA
        y/ZongHoeTcs8HChqkEnHoD73w==
X-Google-Smtp-Source: AMrXdXuU5AhiL262KEGL9pzE04eN7CWv3kizF8wcj0lptTMa2kWNv6blbkJ76+9nZz421L8fO2eA9w==
X-Received: by 2002:a05:6512:b90:b0:4b3:fa58:cb52 with SMTP id b16-20020a0565120b9000b004b3fa58cb52mr3993027lfv.66.1671722006253;
        Thu, 22 Dec 2022 07:13:26 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b004947a12232bsm91269lfo.275.2022.12.22.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:13:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 3/4] arm64: dts: qcom: sdm845: align TLMM pin configuration with DT schema
Date:   Thu, 22 Dec 2022 16:13:18 +0100
Message-Id: <20221222151319.122398-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org>
References: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org>
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

Cc: Doug Anderson <dianders@chromium.org>

Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
This should not have an functional impact.

Changes since v3:
1. db845c: drop qup_uart3_default override and use qup_uart3_4pin
   (Doug).

Changes since v2:
1. Bring back UART6 4-pin bias/drive strength to DTSI.

Changes since v1:
1. Address comments and implement conclusion with Doug.  Drop
   default-pins/pinmux/mux/config nodes but instead add subnodes for
   specific pins for UARTs.  This should match approach used for SC7180.

v1: https://lore.kernel.org/linux-kernel/1b9dcca8-1abd-99a3-da12-a8763bf77f12@linaro.org/
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 397 ++++------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  93 +--
 .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 +-
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  77 +-
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 101 +--
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 150 ++--
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  12 +-
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  21 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 689 ++++++++----------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  53 +-
 .../boot/dts/qcom/sdm850-samsung-w737.dts     | 121 +--
 13 files changed, 701 insertions(+), 1081 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index ca676e04687b..246d9339728c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -995,104 +995,69 @@ &wifi {
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qspi_cs0 {
-	pinconf {
-		pins = "gpio90";
-		bias-disable;
-	};
+	bias-disable;
 };
 
 &qspi_clk {
-	pinconf {
-		pins = "gpio95";
-		bias-disable;
-	};
+	bias-disable;
 };
 
 &qspi_data01 {
-	pinconf {
-		pins = "gpio91", "gpio92";
-
-		/* High-Z when no transfers; nice to park the lines */
-		bias-pull-up;
-	};
+	/* High-Z when no transfers; nice to park the lines */
+	bias-pull-up;
 };
 
 &qup_i2c3_default {
-	pinconf {
-		pins = "gpio41", "gpio42";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c11_default {
-	pinconf {
-		pins = "gpio31", "gpio32";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c12_default {
-	pinconf {
-		pins = "gpio49", "gpio50";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_i2c14_default {
-	pinconf {
-		pins = "gpio33", "gpio34";
-		drive-strength = <2>;
+	drive-strength = <2>;
 
-		/* Has external pullup */
-		bias-disable;
-	};
+	/* Has external pullup */
+	bias-disable;
 };
 
 &qup_spi0_default {
-	pinconf {
-		pins = "gpio0", "gpio1", "gpio2", "gpio3";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_spi5_default {
-	pinconf {
-		pins = "gpio85", "gpio86", "gpio87", "gpio88";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_spi10_default {
-	pinconf {
-		pins = "gpio53", "gpio54", "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_uart9_default {
-	pinconf-tx {
-		pins = "gpio4";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart9_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
 
-	pinconf-rx {
-		pins = "gpio5";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart9_tx {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -1180,243 +1145,153 @@ ap-suspend-l-hog {
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
+	pen_irq_l: pen-irq-l-state {
+		pins = "gpio24";
+		function = "gpio";
 
-		pinconf {
-			pins = "gpio24";
-
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
-		pinmux {
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
-		pinmux {
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
-		pinmux {
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
index 774e4352f299..1b07aceb4845 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -830,8 +830,8 @@ &spi2 {
 };
 
 &tlmm {
-	cam0_default: cam0_default {
-		rst {
+	cam0_default: cam0-default-state {
+		rst-pins {
 			pins = "gpio9";
 			function = "gpio";
 
@@ -839,7 +839,7 @@ rst {
 			bias-disable;
 		};
 
-		mclk0 {
+		mclk0-pins {
 			pins = "gpio13";
 			function = "cam_mclk";
 
@@ -848,8 +848,8 @@ mclk0 {
 		};
 	};
 
-	cam3_default: cam3_default {
-		rst {
+	cam3_default: cam3-default-state {
+		rst-pins {
 			function = "gpio";
 			pins = "gpio21";
 
@@ -857,7 +857,7 @@ rst {
 			bias-disable;
 		};
 
-		mclk3 {
+		mclk3-pins {
 			function = "cam_mclk";
 			pins = "gpio16";
 
@@ -866,7 +866,7 @@ mclk3 {
 		};
 	};
 
-	dsi_sw_sel: dsi-sw-sel {
+	dsi_sw_sel: dsi-sw-sel-state {
 		pins = "gpio120";
 		function = "gpio";
 
@@ -875,20 +875,20 @@ dsi_sw_sel: dsi-sw-sel {
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
 
@@ -897,7 +897,7 @@ reset-n {
 			bias-pull-down;
 		};
 
-		wake-n {
+		wake-n-pins {
 			pins = "gpio37";
 			function = "gpio";
 
@@ -906,7 +906,7 @@ wake-n {
 		};
 	};
 
-	pcie0_pwren_state: pcie0-pwren {
+	pcie0_pwren_state: pcie0-pwren-state {
 		pins = "gpio90";
 		function = "gpio";
 
@@ -914,8 +914,8 @@ pcie0_pwren_state: pcie0-pwren {
 		bias-disable;
 	};
 
-	pcie1_default_state: pcie1-default {
-		perst-n {
+	pcie1_default_state: pcie1-default-state {
+		perst-n-pins {
 			pins = "gpio102";
 			function = "gpio";
 
@@ -923,13 +923,13 @@ perst-n {
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
 
@@ -937,7 +937,7 @@ wake-n {
 			bias-pull-up;
 		};
 
-		reset-n {
+		reset-n-pins {
 			pins = "gpio75";
 			function = "gpio";
 
@@ -947,8 +947,8 @@ reset-n {
 		};
 	};
 
-	sdc2_default_state: sdc2-default {
-		clk {
+	sdc2_default_state: sdc2-default-state {
+		clk-pins {
 			pins = "sdc2_clk";
 			bias-disable;
 
@@ -959,26 +959,26 @@ clk {
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
 		pins = "gpio54";
 		function = "gpio";
 
@@ -990,6 +990,8 @@ wcd_intr_default: wcd_intr_default {
 
 &uart3 {
 	label = "LS-UART0";
+	pinctrl-0 = <&qup_uart3_4pin>;
+
 	status = "disabled";
 };
 
@@ -1135,39 +1137,22 @@ &wifi {
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 &qup_spi2_default {
-	pinconf {
-		pins = "gpio27", "gpio28", "gpio29", "gpio30";
-		drive-strength = <16>;
-	};
-};
-
-&qup_uart3_default {
-	pinmux {
-		pins = "gpio41", "gpio42", "gpio43", "gpio44";
-		function = "qup3";
-	};
+	drive-strength = <16>;
 };
 
 &qup_i2c10_default {
-	pinconf {
-		pins = "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_uart9_default {
-	pinconf-tx {
-		pins = "gpio4";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart9_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
 
-	pinconf-rx {
-		pins = "gpio5";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart9_tx {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &pm8998_gpio {
@@ -1176,8 +1161,6 @@ &pm8998_gpio {
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 &qup_spi0_default {
-	config {
-		drive-strength = <6>;
-		bias-disable;
-	};
+	drive-strength = <6>;
+	bias-disable;
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
index de2d10e0315a..7c5478b71f8b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -719,68 +719,49 @@ &wifi {
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qup_i2c10_default {
-	pinconf {
-		pins = "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_uart9_default {
-	pinconf-tx {
-		pins = "gpio4";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart9_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
 
-	pinconf-rx {
-		pins = "gpio5";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart9_tx {
+	drive-strength = <2>;
+	bias-disable;
 };
 
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
index 42cf4dd5ea28..738c9d0b322f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -474,35 +474,24 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
-&qup_i2c12_default {
-	mux {
-		pins = "gpio49", "gpio50";
-		function = "qup12";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_i2c10_default {
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_i2c10_default {
-	pinconf {
-		pins = "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_i2c12_default {
+	drive-strength = <2>;
+	bias-disable;
 };
 
-&qup_uart9_default {
-	pinconf-tx {
-		pins = "gpio4";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart9_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
 
-	pinconf-rx {
-		pins = "gpio5";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart9_tx {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &uart6 {
@@ -588,51 +577,41 @@ &usb_1_hsphy {
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
index bb77ccfdc68c..563557eb1ada 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -559,18 +559,14 @@ led@5 {
 	};
 };
 
-&qup_uart9_default {
-	pinconf-rx {
-		pins = "gpio5";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
+&qup_uart9_rx {
+	drive-strength = <2>;
+	bias-pull-up;
+};
 
-	pinconf-tx {
-		pins = "gpio4";
-		drive-strength = <2>;
-		bias-disable;
-	};
+&qup_uart9_tx {
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qupv3_id_0 {
@@ -584,110 +580,62 @@ &qupv3_id_1 {
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
index 87dd0fc36747..20c4e4699ac7 100644
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
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 85b8a1b5f0d5..dd1a0adcbf6b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -445,33 +445,33 @@ codec {
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
 		pins = "gpio54";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 38ba809a95cd..d0bc1661faeb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -570,24 +570,21 @@ &qupv3_id_1 {
 };
 
 &qup_i2c14_default {
-	pinconf {
-		pins = "gpio33", "gpio34";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
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
@@ -595,14 +592,14 @@ ts_int_default: ts-int-default {
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
@@ -610,21 +607,21 @@ ts_int_sleep: ts-int-sleep {
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
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..dcea535de9b7 100644
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
@@ -2677,556 +2677,497 @@ cci1_sleep: cci1-sleep {
 				bias-pull-down;
 			};
 
-			qspi_clk: qspi-clk {
-				pinmux {
-					pins = "gpio95";
-					function = "qspi_clk";
-				};
+			qspi_clk: qspi-clk-state {
+				pins = "gpio95";
+				function = "qspi_clk";
 			};
 
-			qspi_cs0: qspi-cs0 {
-				pinmux {
-					pins = "gpio90";
-					function = "qspi_cs";
-				};
+			qspi_cs0: qspi-cs0-state {
+				pins = "gpio90";
+				function = "qspi_cs";
 			};
 
-			qspi_cs1: qspi-cs1 {
-				pinmux {
-					pins = "gpio89";
-					function = "qspi_cs";
-				};
+			qspi_cs1: qspi-cs1-state {
+				pins = "gpio89";
+				function = "qspi_cs";
 			};
 
-			qspi_data01: qspi-data01 {
-				pinmux-data {
-					pins = "gpio91", "gpio92";
-					function = "qspi_data";
-				};
+			qspi_data01: qspi-data01-state {
+				pins = "gpio91", "gpio92";
+				function = "qspi_data";
 			};
 
-			qspi_data12: qspi-data12 {
-				pinmux-data {
-					pins = "gpio93", "gpio94";
-					function = "qspi_data";
-				};
+			qspi_data12: qspi-data12-state {
+				pins = "gpio93", "gpio94";
+				function = "qspi_data";
 			};
 
-			qup_i2c0_default: qup-i2c0-default {
-				pinmux {
-					pins = "gpio0", "gpio1";
-					function = "qup0";
-				};
+			qup_i2c0_default: qup-i2c0-default-state {
+				pins = "gpio0", "gpio1";
+				function = "qup0";
 			};
 
-			qup_i2c1_default: qup-i2c1-default {
-				pinmux {
-					pins = "gpio17", "gpio18";
-					function = "qup1";
-				};
+			qup_i2c1_default: qup-i2c1-default-state {
+				pins = "gpio17", "gpio18";
+				function = "qup1";
 			};
 
-			qup_i2c2_default: qup-i2c2-default {
-				pinmux {
-					pins = "gpio27", "gpio28";
-					function = "qup2";
-				};
+			qup_i2c2_default: qup-i2c2-default-state {
+				pins = "gpio27", "gpio28";
+				function = "qup2";
 			};
 
-			qup_i2c3_default: qup-i2c3-default {
-				pinmux {
-					pins = "gpio41", "gpio42";
-					function = "qup3";
-				};
+			qup_i2c3_default: qup-i2c3-default-state {
+				pins = "gpio41", "gpio42";
+				function = "qup3";
 			};
 
-			qup_i2c4_default: qup-i2c4-default {
-				pinmux {
-					pins = "gpio89", "gpio90";
-					function = "qup4";
-				};
+			qup_i2c4_default: qup-i2c4-default-state {
+				pins = "gpio89", "gpio90";
+				function = "qup4";
 			};
 
-			qup_i2c5_default: qup-i2c5-default {
-				pinmux {
-					pins = "gpio85", "gpio86";
-					function = "qup5";
-				};
+			qup_i2c5_default: qup-i2c5-default-state {
+				pins = "gpio85", "gpio86";
+				function = "qup5";
 			};
 
-			qup_i2c6_default: qup-i2c6-default {
-				pinmux {
-					pins = "gpio45", "gpio46";
-					function = "qup6";
-				};
+			qup_i2c6_default: qup-i2c6-default-state {
+				pins = "gpio45", "gpio46";
+				function = "qup6";
 			};
 
-			qup_i2c7_default: qup-i2c7-default {
-				pinmux {
-					pins = "gpio93", "gpio94";
-					function = "qup7";
-				};
+			qup_i2c7_default: qup-i2c7-default-state {
+				pins = "gpio93", "gpio94";
+				function = "qup7";
 			};
 
-			qup_i2c8_default: qup-i2c8-default {
-				pinmux {
-					pins = "gpio65", "gpio66";
-					function = "qup8";
-				};
+			qup_i2c8_default: qup-i2c8-default-state {
+				pins = "gpio65", "gpio66";
+				function = "qup8";
 			};
 
-			qup_i2c9_default: qup-i2c9-default {
-				pinmux {
-					pins = "gpio6", "gpio7";
-					function = "qup9";
-				};
+			qup_i2c9_default: qup-i2c9-default-state {
+				pins = "gpio6", "gpio7";
+				function = "qup9";
 			};
 
-			qup_i2c10_default: qup-i2c10-default {
-				pinmux {
-					pins = "gpio55", "gpio56";
-					function = "qup10";
-				};
+			qup_i2c10_default: qup-i2c10-default-state {
+				pins = "gpio55", "gpio56";
+				function = "qup10";
 			};
 
-			qup_i2c11_default: qup-i2c11-default {
-				pinmux {
-					pins = "gpio31", "gpio32";
-					function = "qup11";
-				};
+			qup_i2c11_default: qup-i2c11-default-state {
+				pins = "gpio31", "gpio32";
+				function = "qup11";
 			};
 
-			qup_i2c12_default: qup-i2c12-default {
-				pinmux {
-					pins = "gpio49", "gpio50";
-					function = "qup12";
-				};
+			qup_i2c12_default: qup-i2c12-default-state {
+				pins = "gpio49", "gpio50";
+				function = "qup12";
 			};
 
-			qup_i2c13_default: qup-i2c13-default {
-				pinmux {
-					pins = "gpio105", "gpio106";
-					function = "qup13";
-				};
+			qup_i2c13_default: qup-i2c13-default-state {
+				pins = "gpio105", "gpio106";
+				function = "qup13";
 			};
 
-			qup_i2c14_default: qup-i2c14-default {
-				pinmux {
-					pins = "gpio33", "gpio34";
-					function = "qup14";
-				};
+			qup_i2c14_default: qup-i2c14-default-state {
+				pins = "gpio33", "gpio34";
+				function = "qup14";
 			};
 
-			qup_i2c15_default: qup-i2c15-default {
-				pinmux {
-					pins = "gpio81", "gpio82";
-					function = "qup15";
-				};
+			qup_i2c15_default: qup-i2c15-default-state {
+				pins = "gpio81", "gpio82";
+				function = "qup15";
 			};
 
-			qup_spi0_default: qup-spi0-default {
-				pinmux {
-					pins = "gpio0", "gpio1",
-					       "gpio2", "gpio3";
-					function = "qup0";
-				};
+			qup_spi0_default: qup-spi0-default-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "qup0";
+				drive-strength = <6>;
+				bias-disable;
+			};
 
-				config {
-					pins = "gpio0", "gpio1",
-					       "gpio2", "gpio3";
-					drive-strength = <6>;
-					bias-disable;
-				};
+			qup_spi1_default: qup-spi1-default-state {
+				pins = "gpio17", "gpio18", "gpio19", "gpio20";
+				function = "qup1";
 			};
 
-			qup_spi1_default: qup-spi1-default {
-				pinmux {
-					pins = "gpio17", "gpio18",
-					       "gpio19", "gpio20";
-					function = "qup1";
-				};
+			qup_spi2_default: qup-spi2-default-state {
+				pins = "gpio27", "gpio28", "gpio29", "gpio30";
+				function = "qup2";
 			};
 
-			qup_spi2_default: qup-spi2-default {
-				pinmux {
-					pins = "gpio27", "gpio28",
-					       "gpio29", "gpio30";
-					function = "qup2";
-				};
+			qup_spi3_default: qup-spi3-default-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "qup3";
 			};
 
-			qup_spi3_default: qup-spi3-default {
-				pinmux {
-					pins = "gpio41", "gpio42",
-					       "gpio43", "gpio44";
-					function = "qup3";
-				};
+			qup_spi4_default: qup-spi4-default-state {
+				pins = "gpio89", "gpio90", "gpio91", "gpio92";
+				function = "qup4";
 			};
 
-			qup_spi4_default: qup-spi4-default {
-				pinmux {
-					pins = "gpio89", "gpio90",
-					       "gpio91", "gpio92";
-					function = "qup4";
-				};
+			qup_spi5_default: qup-spi5-default-state {
+				pins = "gpio85", "gpio86", "gpio87", "gpio88";
+				function = "qup5";
 			};
 
-			qup_spi5_default: qup-spi5-default {
-				pinmux {
-					pins = "gpio85", "gpio86",
-					       "gpio87", "gpio88";
-					function = "qup5";
-				};
+			qup_spi6_default: qup-spi6-default-state {
+				pins = "gpio45", "gpio46", "gpio47", "gpio48";
+				function = "qup6";
 			};
 
-			qup_spi6_default: qup-spi6-default {
-				pinmux {
-					pins = "gpio45", "gpio46",
-					       "gpio47", "gpio48";
-					function = "qup6";
-				};
+			qup_spi7_default: qup-spi7-default-state {
+				pins = "gpio93", "gpio94", "gpio95", "gpio96";
+				function = "qup7";
 			};
 
-			qup_spi7_default: qup-spi7-default {
-				pinmux {
-					pins = "gpio93", "gpio94",
-					       "gpio95", "gpio96";
-					function = "qup7";
-				};
+			qup_spi8_default: qup-spi8-default-state {
+				pins = "gpio65", "gpio66", "gpio67", "gpio68";
+				function = "qup8";
 			};
 
-			qup_spi8_default: qup-spi8-default {
-				pinmux {
-					pins = "gpio65", "gpio66",
-					       "gpio67", "gpio68";
-					function = "qup8";
-				};
+			qup_spi9_default: qup-spi9-default-state {
+				pins = "gpio6", "gpio7", "gpio4", "gpio5";
+				function = "qup9";
 			};
 
-			qup_spi9_default: qup-spi9-default {
-				pinmux {
-					pins = "gpio6", "gpio7",
-					       "gpio4", "gpio5";
-					function = "qup9";
-				};
+			qup_spi10_default: qup-spi10-default-state {
+				pins = "gpio55", "gpio56", "gpio53", "gpio54";
+				function = "qup10";
 			};
 
-			qup_spi10_default: qup-spi10-default {
-				pinmux {
-					pins = "gpio55", "gpio56",
-					       "gpio53", "gpio54";
-					function = "qup10";
-				};
+			qup_spi11_default: qup-spi11-default-state {
+				pins = "gpio31", "gpio32", "gpio33", "gpio34";
+				function = "qup11";
 			};
 
-			qup_spi11_default: qup-spi11-default {
-				pinmux {
-					pins = "gpio31", "gpio32",
-					       "gpio33", "gpio34";
-					function = "qup11";
-				};
+			qup_spi12_default: qup-spi12-default-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "qup12";
 			};
 
-			qup_spi12_default: qup-spi12-default {
-				pinmux {
-					pins = "gpio49", "gpio50",
-					       "gpio51", "gpio52";
-					function = "qup12";
-				};
+			qup_spi13_default: qup-spi13-default-state {
+				pins = "gpio105", "gpio106", "gpio107", "gpio108";
+				function = "qup13";
 			};
 
-			qup_spi13_default: qup-spi13-default {
-				pinmux {
-					pins = "gpio105", "gpio106",
-					       "gpio107", "gpio108";
-					function = "qup13";
-				};
+			qup_spi14_default: qup-spi14-default-state {
+				pins = "gpio33", "gpio34", "gpio31", "gpio32";
+				function = "qup14";
 			};
 
-			qup_spi14_default: qup-spi14-default {
-				pinmux {
-					pins = "gpio33", "gpio34",
-					       "gpio31", "gpio32";
-					function = "qup14";
-				};
+			qup_spi15_default: qup-spi15-default-state {
+				pins = "gpio81", "gpio82", "gpio83", "gpio84";
+				function = "qup15";
 			};
 
-			qup_spi15_default: qup-spi15-default {
-				pinmux {
-					pins = "gpio81", "gpio82",
-					       "gpio83", "gpio84";
-					function = "qup15";
+			qup_uart0_default: qup-uart0-default-state {
+				qup_uart0_tx: tx-pins {
+					pins = "gpio2";
+					function = "qup0";
 				};
-			};
 
-			qup_uart0_default: qup-uart0-default {
-				pinmux {
-					pins = "gpio2", "gpio3";
+				qup_uart0_rx: rx-pins {
+					pins = "gpio3";
 					function = "qup0";
 				};
 			};
 
-			qup_uart1_default: qup-uart1-default {
-				pinmux {
-					pins = "gpio19", "gpio20";
+			qup_uart1_default: qup-uart1-default-state {
+				qup_uart1_tx: tx-pins {
+					pins = "gpio19";
+					function = "qup1";
+				};
+
+				qup_uart1_rx: rx-pins {
+					pins = "gpio20";
 					function = "qup1";
 				};
 			};
 
-			qup_uart2_default: qup-uart2-default {
-				pinmux {
-					pins = "gpio29", "gpio30";
+			qup_uart2_default: qup-uart2-default-state {
+				qup_uart2_tx: tx-pins {
+					pins = "gpio29";
 					function = "qup2";
 				};
+
+				qup_uart2_rx: rx-pins {
+					pins = "gpio30";
+					function = "qup2";
+				};
+			};
+
+			qup_uart3_default: qup-uart3-default-state {
+				qup_uart3_tx: tx-pins {
+					pins = "gpio43";
+					function = "qup3";
+				};
+
+				qup_uart3_rx: rx-pins {
+					pins = "gpio44";
+					function = "qup3";
+				};
 			};
 
-			qup_uart3_default: qup-uart3-default {
-				pinmux {
-					pins = "gpio43", "gpio44";
+			qup_uart3_4pin: qup-uart3-4pin-state {
+				qup_uart3_4pin_cts: cts-pins {
+					pins = "gpio41";
+					function = "qup3";
+				};
+
+				qup_uart3_4pin_rts_tx: rts-tx-pins {
+					pins = "gpio42", "gpio43";
+					function = "qup3";
+				};
+
+				qup_uart3_4pin_rx: rx-pins {
+					pins = "gpio44";
 					function = "qup3";
 				};
 			};
 
-			qup_uart4_default: qup-uart4-default {
-				pinmux {
-					pins = "gpio91", "gpio92";
+			qup_uart4_default: qup-uart4-default-state {
+				qup_uart4_tx: tx-pins {
+					pins = "gpio91";
+					function = "qup4";
+				};
+
+				qup_uart4_rx: rx-pins {
+					pins = "gpio92";
 					function = "qup4";
 				};
 			};
 
-			qup_uart5_default: qup-uart5-default {
-				pinmux {
-					pins = "gpio87", "gpio88";
+			qup_uart5_default: qup-uart5-default-state {
+				qup_uart5_tx: tx-pins {
+					pins = "gpio87";
+					function = "qup5";
+				};
+
+				qup_uart5_rx: rx-pins {
+					pins = "gpio88";
 					function = "qup5";
 				};
 			};
 
-			qup_uart6_default: qup-uart6-default {
-				pinmux {
-					pins = "gpio47", "gpio48";
+			qup_uart6_default: qup-uart6-default-state {
+				qup_uart6_tx: tx-pins {
+					pins = "gpio47";
+					function = "qup6";
+				};
+
+				qup_uart6_rx: rx-pins {
+					pins = "gpio48";
 					function = "qup6";
 				};
 			};
 
 			qup_uart6_4pin: qup-uart6-4pin-state {
-
-				cts-pins {
+				qup_uart6_4pin_cts: cts-pins {
 					pins = "gpio45";
 					function = "qup6";
 					bias-pull-down;
 				};
 
-				rts-tx-pins {
+				qup_uart6_4pin_rts_tx: rts-tx-pins {
 					pins = "gpio46", "gpio47";
 					function = "qup6";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				rx-pins {
+				qup_uart6_4pin_rx: rx-pins {
 					pins = "gpio48";
 					function = "qup6";
 					bias-pull-up;
 				};
 			};
 
-			qup_uart7_default: qup-uart7-default {
-				pinmux {
-					pins = "gpio95", "gpio96";
+			qup_uart7_default: qup-uart7-default-state {
+				qup_uart7_tx: tx-pins {
+					pins = "gpio95";
 					function = "qup7";
 				};
-			};
 
-			qup_uart8_default: qup-uart8-default {
-				pinmux {
-					pins = "gpio67", "gpio68";
-					function = "qup8";
-				};
-			};
-
-			qup_uart9_default: qup-uart9-default {
-				pinmux {
-					pins = "gpio4", "gpio5";
-					function = "qup9";
+				qup_uart7_rx: rx-pins {
+					pins = "gpio96";
+					function = "qup7";
 				};
 			};
 
-			qup_uart10_default: qup-uart10-default {
-				pinmux {
-					pins = "gpio53", "gpio54";
-					function = "qup10";
+			qup_uart8_default: qup-uart8-default-state {
+				qup_uart8_tx: tx-pins {
+					pins = "gpio67";
+					function = "qup8";
 				};
-			};
 
-			qup_uart11_default: qup-uart11-default {
-				pinmux {
-					pins = "gpio33", "gpio34";
-					function = "qup11";
+				qup_uart8_rx: rx-pins {
+					pins = "gpio68";
+					function = "qup8";
 				};
 			};
 
-			qup_uart12_default: qup-uart12-default {
-				pinmux {
-					pins = "gpio51", "gpio52";
-					function = "qup12";
+			qup_uart9_default: qup-uart9-default-state {
+				qup_uart9_tx: tx-pins {
+					pins = "gpio4";
+					function = "qup9";
 				};
-			};
 
-			qup_uart13_default: qup-uart13-default {
-				pinmux {
-					pins = "gpio107", "gpio108";
-					function = "qup13";
+				qup_uart9_rx: rx-pins {
+					pins = "gpio5";
+					function = "qup9";
 				};
 			};
 
-			qup_uart14_default: qup-uart14-default {
-				pinmux {
-					pins = "gpio31", "gpio32";
-					function = "qup14";
+			qup_uart10_default: qup-uart10-default-state {
+				qup_uart10_tx: tx-pins {
+					pins = "gpio53";
+					function = "qup10";
 				};
-			};
 
-			qup_uart15_default: qup-uart15-default {
-				pinmux {
-					pins = "gpio83", "gpio84";
-					function = "qup15";
+				qup_uart10_rx: rx-pins {
+					pins = "gpio54";
+					function = "qup10";
 				};
 			};
 
-			quat_mi2s_sleep: quat_mi2s_sleep {
-				mux {
-					pins = "gpio58", "gpio59";
-					function = "gpio";
+			qup_uart11_default: qup-uart11-default-state {
+				qup_uart11_tx: tx-pins {
+					pins = "gpio33";
+					function = "qup11";
 				};
 
-				config {
-					pins = "gpio58", "gpio59";
-					drive-strength = <2>;
-					bias-pull-down;
-					input-enable;
+				qup_uart11_rx: rx-pins {
+					pins = "gpio34";
+					function = "qup11";
 				};
 			};
 
-			quat_mi2s_active: quat_mi2s_active {
-				mux {
-					pins = "gpio58", "gpio59";
-					function = "qua_mi2s";
+			qup_uart12_default: qup-uart12-default-state {
+				qup_uart12_tx: tx-pins {
+					pins = "gpio51";
+					function = "qup0";
 				};
 
-				config {
-					pins = "gpio58", "gpio59";
-					drive-strength = <8>;
-					bias-disable;
-					output-high;
+				qup_uart12_rx: rx-pins {
+					pins = "gpio52";
+					function = "qup0";
 				};
 			};
 
-			quat_mi2s_sd0_sleep: quat_mi2s_sd0_sleep {
-				mux {
-					pins = "gpio60";
-					function = "gpio";
+			qup_uart13_default: qup-uart13-default-state {
+				qup_uart13_tx: tx-pins {
+					pins = "gpio107";
+					function = "qup13";
 				};
 
-				config {
-					pins = "gpio60";
-					drive-strength = <2>;
-					bias-pull-down;
-					input-enable;
+				qup_uart13_rx: rx-pins {
+					pins = "gpio108";
+					function = "qup13";
 				};
 			};
 
-			quat_mi2s_sd0_active: quat_mi2s_sd0_active {
-				mux {
-					pins = "gpio60";
-					function = "qua_mi2s";
+			qup_uart14_default: qup-uart14-default-state {
+				qup_uart14_tx: tx-pins {
+					pins = "gpio31";
+					function = "qup14";
 				};
 
-				config {
-					pins = "gpio60";
-					drive-strength = <8>;
-					bias-disable;
+				qup_uart14_rx: rx-pins {
+					pins = "gpio32";
+					function = "qup14";
 				};
 			};
 
-			quat_mi2s_sd1_sleep: quat_mi2s_sd1_sleep {
-				mux {
-					pins = "gpio61";
-					function = "gpio";
+			qup_uart15_default: qup-uart15-default-state {
+				qup_uart15_tx: tx-pins {
+					pins = "gpio83";
+					function = "qup15";
 				};
 
-				config {
-					pins = "gpio61";
-					drive-strength = <2>;
-					bias-pull-down;
-					input-enable;
+				qup_uart15_rx: rx-pins {
+					pins = "gpio84";
+					function = "qup15";
 				};
 			};
 
-			quat_mi2s_sd1_active: quat_mi2s_sd1_active {
-				mux {
-					pins = "gpio61";
-					function = "qua_mi2s";
-				};
+			quat_mi2s_sleep: quat-mi2s-sleep-state {
+				pins = "gpio58", "gpio59";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+				input-enable;
+			};
 
-				config {
-					pins = "gpio61";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			quat_mi2s_active: quat-mi2s-active-state {
+				pins = "gpio58", "gpio59";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+				output-high;
 			};
 
-			quat_mi2s_sd2_sleep: quat_mi2s_sd2_sleep {
-				mux {
-					pins = "gpio62";
-					function = "gpio";
-				};
+			quat_mi2s_sd0_sleep: quat-mi2s-sd0-sleep-state {
+				pins = "gpio60";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+				input-enable;
+			};
 
-				config {
-					pins = "gpio62";
-					drive-strength = <2>;
-					bias-pull-down;
-					input-enable;
-				};
+			quat_mi2s_sd0_active: quat-mi2s-sd0-active-state {
+				pins = "gpio60";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
 			};
 
-			quat_mi2s_sd2_active: quat_mi2s_sd2_active {
-				mux {
-					pins = "gpio62";
-					function = "qua_mi2s";
-				};
+			quat_mi2s_sd1_sleep: quat-mi2s-sd1-sleep-state {
+				pins = "gpio61";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+				input-enable;
+			};
 
-				config {
-					pins = "gpio62";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			quat_mi2s_sd1_active: quat-mi2s-sd1-active-state {
+				pins = "gpio61";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
 			};
 
-			quat_mi2s_sd3_sleep: quat_mi2s_sd3_sleep {
-				mux {
-					pins = "gpio63";
-					function = "gpio";
-				};
+			quat_mi2s_sd2_sleep: quat-mi2s-sd2-sleep-state {
+				pins = "gpio62";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+				input-enable;
+			};
 
-				config {
-					pins = "gpio63";
-					drive-strength = <2>;
-					bias-pull-down;
-					input-enable;
-				};
+			quat_mi2s_sd2_active: quat-mi2s-sd2-active-state {
+				pins = "gpio62";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
 			};
 
-			quat_mi2s_sd3_active: quat_mi2s_sd3_active {
-				mux {
-					pins = "gpio63";
-					function = "qua_mi2s";
-				};
+			quat_mi2s_sd3_sleep: quat-mi2s-sd3-sleep-state {
+				pins = "gpio63";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+				input-enable;
+			};
 
-				config {
-					pins = "gpio63";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			quat_mi2s_sd3_active: quat-mi2s-sd3-active-state {
+				pins = "gpio63";
+				function = "qua_mi2s";
+				drive-strength = <8>;
+				bias-disable;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index f32b7445f7c9..83e4a92430fb 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -479,41 +479,13 @@ &mss_pil {
 };
 
 &qup_i2c10_default {
-	pinconf {
-		pins = "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_i2c12_default {
-	pinmux {
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&qup_uart6_default {
-	pinmux {
-		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		 function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-pull-down;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qupv3_id_0 {
@@ -621,13 +593,14 @@ codec {
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
 
@@ -636,7 +609,7 @@ i2c3_hid_active: i2c2-hid-active {
 		drive-strength = <2>;
 	};
 
-	i2c5_hid_active: i2c5-hid-active {
+	i2c5_hid_active: i2c5-hid-active-state {
 		pins = "gpio125";
 		function = "gpio";
 
@@ -645,7 +618,7 @@ i2c5_hid_active: i2c5-hid-active {
 		drive-strength = <2>;
 	};
 
-	i2c11_hid_active: i2c11-hid-active {
+	i2c11_hid_active: i2c11-hid-active-state {
 		pins = "gpio92";
 		function = "gpio";
 
@@ -654,7 +627,7 @@ i2c11_hid_active: i2c11-hid-active {
 		drive-strength = <2>;
 	};
 
-	wcd_intr_default: wcd_intr_default {
+	wcd_intr_default: wcd-intr-default-state {
 		pins = "gpio54";
 		function = "gpio";
 
@@ -663,7 +636,7 @@ wcd_intr_default: wcd_intr_default {
 		drive-strength = <2>;
 	};
 
-	lid_pin_active: lid-pin {
+	lid_pin_active: lid-pin-state {
 		pins = "gpio124";
 		function = "gpio";
 
@@ -671,7 +644,7 @@ lid_pin_active: lid-pin {
 		bias-disable;
 	};
 
-	mode_pin_active: mode-pin {
+	mode_pin_active: mode-pin-state {
 		pins = "gpio95";
 		function = "gpio";
 
@@ -681,6 +654,8 @@ mode_pin_active: mode-pin {
 };
 
 &uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup_uart6_4pin>;
 	status = "okay";
 
 	bluetooth {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index daca1e0ad62a..9215066146ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -399,49 +399,18 @@ &mss_pil {
 };
 
 &qup_i2c10_default {
-	pinconf {
-		pins = "gpio55", "gpio56";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_i2c11_default {
-	pinconf {
-		pins = "gpio31", "gpio32";
-		drive-strength = <2>;
-		bias-disable;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qup_i2c12_default {
-	pinmux {
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&qup_uart6_default {
-	pinmux {
-		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		 function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-pull-down;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
+	drive-strength = <2>;
+	bias-disable;
 };
 
 &qupv3_id_0 {
@@ -549,59 +518,41 @@ codec {
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
-		pinmux {
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
 
@@ -612,6 +563,8 @@ wcd_intr_default: wcd_intr_default {
 };
 
 &uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup_uart6_4pin>;
 	status = "okay";
 
 	bluetooth {
-- 
2.34.1

