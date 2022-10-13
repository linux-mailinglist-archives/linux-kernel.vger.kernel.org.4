Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD05FE3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJMVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJMVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:12:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DE8190E49
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:11:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a18so1332459qko.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ub6qoL3GH1nCOhdUTOK4zRECboSSxMBuyBjPkiNYf8=;
        b=Bf7RQjQ8yuc930zwWyEVFmN/0MnETbBaczMaEy3e0blSxvKkBc/tbaYcbffFz/EaCa
         7htSAscLjuB3fmOr8C1tenUdjToXDOr8io2SRRuklfCvuWW/OmP3vbQHjS3dGS7BmhGT
         3NSk4okWpBuOWOsEe70iHOgdn/vwjbvZH6VMM4vQx5tzDEG+dQZisy/70qvQrzfmLzDD
         XhLPITTbxlnh6K9/0ZW81bKJFljYPyy7dKhUPMNzVsuzkJitRo9GHVIRm1b0hljaawfp
         DXQDlbCarUqmuuhhFFwpfBk5ii9PGtotz/IT6/MOvnR582FaTa2Cl0oH9C5HGuLK4FZu
         zn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ub6qoL3GH1nCOhdUTOK4zRECboSSxMBuyBjPkiNYf8=;
        b=UzYYoBoQ2d0yu4g78FXOw02eW6y3w84FkSSd5Pm+iEjjBFbY2IyZbcFrpU2zM3mwnL
         BFiOjOy2LebTo0nFG/fJHxE4ryhIf7udrDa3ofqN/tvqu7Q6f9BcS5JibCfgpJVXjiZB
         9Vv/hILxUVNXUZTXWJkrvNn7UlllI7vzhujrvOgdDwMBGKCOmnFinNShNjcZW/qFOZTe
         lnSjicuYnVr7kx/MFmrLstCraBex5gCCN+8BPKBaykkDdHgmHlJaljB65YmEJhSEdpyB
         QazA5Vatf+xke5lHii2iGmr2b2esR2KkJYukcYmcvGZDJJQScMU4EcErnJfY7fc6h5kW
         knXw==
X-Gm-Message-State: ACrzQf10frkzKOXKQSc/KAZgcnmvQqvIBq7bOGfkG0cp7lGZCAWkw7ba
        6FTnzbHwEIgcMZVCsXUXkrBIjg==
X-Google-Smtp-Source: AMsMyM6q+ALTynMZhX4ImgfOAMvQbgaesg9UVhJ2Jxjt8XPpOShz3erLv0nGjPQioQFMIErgMo9xDw==
X-Received: by 2002:a05:620a:48e:b0:6ec:fe1d:c7c with SMTP id 14-20020a05620a048e00b006ecfe1d0c7cmr1552228qkr.651.1665695517889;
        Thu, 13 Oct 2022 14:11:57 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006cec8001bf4sm616969qki.26.2022.10.13.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:11:57 -0700 (PDT)
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
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8996: align TLMM pin configuration with DT schema
Date:   Thu, 13 Oct 2022 17:09:52 -0400
Message-Id: <20221013210953.97806-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013210953.97806-1-krzysztof.kozlowski@linaro.org>
References: <20221013210953.97806-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |  96 ++++------
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts  |  68 ++------
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |  26 +--
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  10 +-
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   8 +-
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  |   4 +-
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |   8 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 164 +++++++++---------
 8 files changed, 153 insertions(+), 231 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 5cdc7ac1a9c0..a3d1ff1aba8f 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -422,82 +422,46 @@ &tlmm {
 		"NC", /* GPIO_148 */
 		"NC"; /* GPIO_149 */
 
-	sdc2_cd_on: sdc2_cd_on {
-		mux {
-			pins = "gpio38";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio38";
-			bias-pull-up;		/* pull up */
-			drive-strength = <16>;	/* 16 MA */
-		};
+	sdc2_cd_on: sdc2-cd-on-state {
+		pins = "gpio38";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <16>;
 	};
 
-	sdc2_cd_off: sdc2_cd_off {
-		mux {
-			pins = "gpio38";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio38";
-			bias-pull-up;		/* pull up */
-			drive-strength = <2>;	/* 2 MA */
-		};
+	sdc2_cd_off: sdc2-cd-off-state {
+		pins = "gpio38";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
 	};
 
-	hdmi_hpd_active: hdmi_hpd_active {
-		mux {
-			pins = "gpio34";
-			function = "hdmi_hot";
-		};
-
-		config {
-			pins = "gpio34";
-			bias-pull-down;
-			drive-strength = <16>;
-		};
+	hdmi_hpd_active: hdmi-hpd-active-state {
+		pins = "gpio34";
+		function = "hdmi_hot";
+		bias-pull-down;
+		drive-strength = <16>;
 	};
 
-	hdmi_hpd_suspend: hdmi_hpd_suspend {
-		mux {
-			pins = "gpio34";
-			function = "hdmi_hot";
-		};
-
-		config {
-			pins = "gpio34";
-			bias-pull-down;
-			drive-strength = <2>;
-		};
+	hdmi_hpd_suspend: hdmi-hpd-suspend-state {
+		pins = "gpio34";
+		function = "hdmi_hot";
+		bias-pull-down;
+		drive-strength = <2>;
 	};
 
-	hdmi_ddc_active: hdmi_ddc_active {
-		mux {
-			pins = "gpio32", "gpio33";
-			function = "hdmi_ddc";
-		};
-
-		config {
-			pins = "gpio32", "gpio33";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
+	hdmi_ddc_active: hdmi-ddc-active-state {
+		pins = "gpio32", "gpio33";
+		function = "hdmi_ddc";
+		drive-strength = <2>;
+		bias-pull-up;
 	};
 
-	hdmi_ddc_suspend: hdmi_ddc_suspend {
-		mux {
-			pins = "gpio32", "gpio33";
-			function = "hdmi_ddc";
-		};
-
-		config {
-			pins = "gpio32", "gpio33";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	hdmi_ddc_suspend: hdmi-ddc-suspend-state {
+		pins = "gpio32", "gpio33";
+		function = "hdmi_ddc";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index 92f264891d84..943dc362faad 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -104,60 +104,22 @@ &mdss {
 	status = "okay";
 };
 
-&tlmm {
-	sdc2_pins_default: sdc2-pins-default {
-		clk {
-			pins = "sdc2_clk";
-			bias-disable;
-			drive-strength = <16>;
-		};
-
-		cmd {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-
-		data {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
+&sdc2_state_on {
+	cd-pins {
+		pins = "gpio38";
+		function = "gpio";
 
-		cd {
-			pins = "gpio38";
-			function = "gpio";
-
-			bias-pull-up;
-			drive-strength = <16>;
-		};
+		bias-pull-up;
+		drive-strength = <16>;
 	};
+};
 
-	sdc2_pins_sleep: sdc2-pins-sleep {
-		clk {
-			pins = "sdc2_clk";
-			bias-disable;
-			drive-strength = <2>;
-		};
-
-		cmd {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-
-		data {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-
-		cd {
-			pins = "gpio38";
-			function = "gpio";
-			bias-pull-up;
-			drive-strength = <2>;
-		};
+&sdc2_state_off {
+	cd-pins {
+		pins = "gpio38";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
 	};
 };
 
@@ -372,10 +334,6 @@ &sdhc2 {
 
 	vmmc-supply = <&vreg_l21a_2p95>;
 	vqmmc-supply = <&vreg_l13a_2p95>;
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_pins_default>;
-	pinctrl-1 = <&sdc2_pins_sleep>;
 };
 
 &ufshc {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 93568fb4bc86..c824aa17f3a7 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -847,28 +847,28 @@ &tlmm {
 	pinctrl-0 = <&sw_service_gpio>;
 	pinctrl-names = "default";
 
-	disp_reset_n_gpio: disp-reset-n {
+	disp_reset_n_gpio: disp-reset-n-state {
 		pins = "gpio8";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	mdp_vsync_p_gpio: mdp-vsync-p {
+	mdp_vsync_p_gpio: mdp-vsync-p-state {
 		pins = "gpio10";
 		function = "mdp_vsync";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	sw_service_gpio: sw-service-gpio {
+	sw_service_gpio: sw-service-gpio-state {
 		pins = "gpio16";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
-	usb_detect: usb-detect {
+	usb_detect: usb-detect-state {
 		pins = "gpio25";
 		function = "gpio";
 		drive-strength = <2>;
@@ -876,7 +876,7 @@ usb_detect: usb-detect {
 		output-high;
 	};
 
-	uim_detect_en: uim-detect-en {
+	uim_detect_en: uim-detect-en-state {
 		pins = "gpio29";
 		function = "gpio";
 		drive-strength = <2>;
@@ -884,14 +884,14 @@ uim_detect_en: uim-detect-en {
 		output-high;
 	};
 
-	tray_det_pin: tray-det {
+	tray_det_pin: tray-det-state {
 		pins = "gpio40";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	tp_vddio_en: tp-vddio-en {
+	tp_vddio_en: tp-vddio-en-state {
 		pins = "gpio50";
 		function = "gpio";
 		drive-strength = <2>;
@@ -899,7 +899,7 @@ tp_vddio_en: tp-vddio-en {
 		output-high;
 	};
 
-	lcd_vddio_en: lcd-vddio-en {
+	lcd_vddio_en: lcd-vddio-en-state {
 		pins = "gpio51";
 		function = "gpio";
 		drive-strength = <2>;
@@ -907,14 +907,14 @@ lcd_vddio_en: lcd-vddio-en {
 		output-low;
 	};
 
-	wl_host_wake: wl-host-wake {
+	wl_host_wake: wl-host-wake-state {
 		pins = "gpio79";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
 	};
 
-	wl_reg_on: wl-reg-on {
+	wl_reg_on: wl-reg-on-state {
 		pins = "gpio84";
 		function = "gpio";
 		drive-strength = <2>;
@@ -922,20 +922,20 @@ wl_reg_on: wl-reg-on {
 		output-low;
 	};
 
-	ts_reset_n: ts-rst-n {
+	ts_reset_n: ts-rst-n-state {
 		pins = "gpio89";
 		function = "gpio";
 		drive-strength = <2>;
 	};
 
-	touch_int_n: touch-int-n {
+	touch_int_n: touch-int-n-state {
 		pins = "gpio125";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
-	touch_int_sleep: touch-int-sleep {
+	touch_int_sleep: touch-int-sleep-state {
 		pins = "gpio125";
 		function = "gpio";
 		drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 77819186086a..2ac2dfc22411 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -694,35 +694,35 @@ divclk4_pin_a: divclk4-state {
 };
 
 &tlmm {
-	mdss_dsi_default: mdss_dsi_default {
+	mdss_dsi_default: mdss-dsi-default-state {
 		pins = "gpio8";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-disable;
 	};
 
-	mdss_dsi_sleep: mdss_dsi_sleep {
+	mdss_dsi_sleep: mdss-dsi-sleep-state {
 		pins = "gpio8";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
 	};
 
-	mdss_te_default: mdss_te_default {
+	mdss_te_default: mdss-te-default-state {
 		pins = "gpio10";
 		function = "mdp_vsync";
 		drive-strength = <2>;
 		bias-pull-down;
 	};
 
-	mdss_te_sleep: mdss_te_sleep {
+	mdss_te_sleep: mdss-te-sleep-state {
 		pins = "gpio10";
 		function = "mdp_vsync";
 		drive-strength = <2>;
 		bias-pull-down;
 	};
 
-	nfc_default: nfc_default {
+	nfc_default: nfc-default-state {
 		pins = "gpio12", "gpio21";
 		function = "gpio";
 		drive-strength = <16>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 4e5264f4116a..54894ccc9785 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -445,28 +445,28 @@ &tlmm {
 		"RFFE1_DATA",		/* GPIO_148 */
 		"RFFE1_CLK";		/* GPIO_149 */
 
-	touchscreen_default: touchscreen_default {
+	touchscreen_default: touchscreen-default-state {
 		pins = "gpio89", "gpio125";
 		function = "gpio";
 		drive-strength = <10>;
 		bias-pull-up;
 	};
 
-	touchscreen_sleep: touchscreen_sleep {
+	touchscreen_sleep: touchscreen-sleep-state {
 		pins = "gpio89", "gpio125";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	vibrator_default: vibrator_default {
+	vibrator_default: vibrator-default-state {
 		pins = "gpio93";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
 	};
 
-	vibrator_sleep: vibrator_sleep {
+	vibrator_sleep: vibrator-sleep-state {
 		pins = "gpio93";
 		function = "gpio";
 		drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
index ff4673ee9e81..44b137f3cfe7 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
@@ -398,14 +398,14 @@ &tlmm {
 		"RFFE1_DATA",		/* GPIO_148 */
 		"RFFE1_CLK";		/* GPIO_149 */
 
-	touchscreen_default: touchscreen-default {
+	touchscreen_default: touchscreen-default-state {
 		pins = "gpio89", "gpio125";
 		function = "gpio";
 		drive-strength = <10>;
 		bias-pull-up;
 	};
 
-	touchscreen_sleep: touchscreen-sleep {
+	touchscreen_sleep: touchscreen-sleep-state {
 		pins = "gpio89", "gpio125";
 		function = "gpio";
 		drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
index 79be5fb1295b..75200ba4c5b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
@@ -468,28 +468,28 @@ &tlmm {
 		"RFFE1_DATA",		/* GPIO_148 */
 		"RFFE1_CLK";		/* GPIO_149 */
 
-	touchkey_default: touchkey_default {
+	touchkey_default: touchkey-default-state {
 		pins = "gpio77";
 		function = "gpio";
 		drive-strength = <16>;
 		bias-pull-up;
 	};
 
-	touchkey_sleep: touchkey_sleep {
+	touchkey_sleep: touchkey-sleep-state {
 		pins = "gpio77";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	touchscreen_default: touchscreen_default {
+	touchscreen_default: touchscreen-default-state {
 		pins = "gpio75", "gpio125";
 		function = "gpio";
 		drive-strength = <10>;
 		bias-pull-up;
 	};
 
-	touchscreen_sleep: touchscreen_sleep {
+	touchscreen_sleep: touchscreen-sleep-state {
 		pins = "gpio75", "gpio125";
 		function = "gpio";
 		drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c0a2baffa49d..3d98cdfc317e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1262,15 +1262,15 @@ tlmm: pinctrl@1010000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			blsp1_spi1_default: blsp1-spi1-default {
-				spi {
+			blsp1_spi1_default: blsp1-spi1-default-state {
+				spi-pins {
 					pins = "gpio0", "gpio1", "gpio3";
 					function = "blsp_spi1";
 					drive-strength = <12>;
 					bias-disable;
 				};
 
-				cs {
+				cs-pins {
 					pins = "gpio2";
 					function = "gpio";
 					drive-strength = <16>;
@@ -1279,42 +1279,42 @@ cs {
 				};
 			};
 
-			blsp1_spi1_sleep: blsp1-spi1-sleep {
+			blsp1_spi1_sleep: blsp1-spi1-sleep-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
 			};
 
-			blsp2_uart2_2pins_default: blsp2-uart1-2pins {
+			blsp2_uart2_2pins_default: blsp2-uart1-2pins-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart8";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp2_uart2_2pins_sleep: blsp2-uart1-2pins-sleep {
+			blsp2_uart2_2pins_sleep: blsp2-uart1-2pins-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c2_default: blsp2-i2c2 {
+			blsp2_i2c2_default: blsp2-i2c2-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c8";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp2_i2c2_sleep: blsp2-i2c2-sleep {
+			blsp2_i2c2_sleep: blsp2-i2c2-sleep-state {
 				pins = "gpio6", "gpio7";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			cci0_default: cci0-default {
+			cci0_default: cci0-default-state {
 				pins = "gpio17", "gpio18";
 				function = "cci_i2c";
 				drive-strength = <16>;
@@ -1322,22 +1322,22 @@ cci0_default: cci0-default {
 			};
 
 			camera0_state_on:
-			camera_rear_default: camera-rear-default {
-				camera0_mclk: mclk0 {
+			camera_rear_default: camera-rear-default-state {
+				camera0_mclk: mclk0-pins {
 					pins = "gpio13";
 					function = "cam_mclk";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				camera0_rst: rst {
+				camera0_rst: rst-pins {
 					pins = "gpio25";
 					function = "gpio";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				camera0_pwdn: pwdn {
+				camera0_pwdn: pwdn-pins {
 					pins = "gpio26";
 					function = "gpio";
 					drive-strength = <16>;
@@ -1345,7 +1345,7 @@ camera0_pwdn: pwdn {
 				};
 			};
 
-			cci1_default: cci1-default {
+			cci1_default: cci1-default-state {
 				pins = "gpio19", "gpio20";
 				function = "cci_i2c";
 				drive-strength = <16>;
@@ -1353,22 +1353,22 @@ cci1_default: cci1-default {
 			};
 
 			camera1_state_on:
-			camera_board_default: camera-board-default {
-				mclk1 {
+			camera_board_default: camera-board-default-state {
+				mclk1-pins {
 					pins = "gpio14";
 					function = "cam_mclk";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				pwdn {
+				pwdn-pins {
 					pins = "gpio98";
 					function = "gpio";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				rst {
+				rst-pins {
 					pins = "gpio104";
 					function = "gpio";
 					drive-strength = <16>;
@@ -1377,22 +1377,22 @@ rst {
 			};
 
 			camera2_state_on:
-			camera_front_default: camera-front-default {
-				camera2_mclk: mclk2 {
+			camera_front_default: camera-front-default-state {
+				camera2_mclk: mclk2-pins {
 					pins = "gpio15";
 					function = "cam_mclk";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				camera2_rst: rst {
+				camera2_rst: rst-pins {
 					pins = "gpio23";
 					function = "gpio";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				pwdn {
+				pwdn-pins {
 					pins = "gpio133";
 					function = "gpio";
 					drive-strength = <16>;
@@ -1400,22 +1400,22 @@ pwdn {
 				};
 			};
 
-			pcie0_state_on: pcie0-state-on {
-				perst {
+			pcie0_state_on: pcie0-state-on-state {
+				perst-pins {
 					pins = "gpio35";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio36";
 					function = "pci_e0";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio37";
 					function = "gpio";
 					drive-strength = <2>;
@@ -1423,22 +1423,22 @@ wake {
 				};
 			};
 
-			pcie0_state_off: pcie0-state-off {
-				perst {
+			pcie0_state_off: pcie0-state-off-state {
+				perst-pins {
 					pins = "gpio35";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio36";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio37";
 					function = "gpio";
 					drive-strength = <2>;
@@ -1446,63 +1446,63 @@ wake {
 				};
 			};
 
-			blsp1_uart2_default: blsp1-uart2-default {
+			blsp1_uart2_default: blsp1-uart2-default-state {
 				pins = "gpio41", "gpio42", "gpio43", "gpio44";
 				function = "blsp_uart2";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp1_uart2_sleep: blsp1-uart2-sleep {
+			blsp1_uart2_sleep: blsp1-uart2-sleep-state {
 				pins = "gpio41", "gpio42", "gpio43", "gpio44";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c3_default: blsp1-i2c2-default {
+			blsp1_i2c3_default: blsp1-i2c2-default-state {
 				pins = "gpio47", "gpio48";
 				function = "blsp_i2c3";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp1_i2c3_sleep: blsp1-i2c2-sleep {
+			blsp1_i2c3_sleep: blsp1-i2c2-sleep-state {
 				pins = "gpio47", "gpio48";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_uart3_4pins_default: blsp2-uart2-4pins {
+			blsp2_uart3_4pins_default: blsp2-uart2-4pins-state {
 				pins = "gpio49", "gpio50", "gpio51", "gpio52";
 				function = "blsp_uart9";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp2_uart3_4pins_sleep: blsp2-uart2-4pins-sleep {
+			blsp2_uart3_4pins_sleep: blsp2-uart2-4pins-sleep-state {
 				pins = "gpio49", "gpio50", "gpio51", "gpio52";
 				function = "blsp_uart9";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c3_default: blsp2-i2c3 {
+			blsp2_i2c3_default: blsp2-i2c3-state-state {
 				pins = "gpio51", "gpio52";
 				function = "blsp_i2c9";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp2_i2c3_sleep: blsp2-i2c3-sleep {
+			blsp2_i2c3_sleep: blsp2-i2c3-sleep-state {
 				pins = "gpio51", "gpio52";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			wcd_intr_default: wcd-intr-default{
+			wcd_intr_default: wcd-intr-default-state {
 				pins = "gpio54";
 				function = "gpio";
 				drive-strength = <2>;
@@ -1510,21 +1510,21 @@ wcd_intr_default: wcd-intr-default{
 				input-enable;
 			};
 
-			blsp2_i2c1_default: blsp2-i2c1 {
+			blsp2_i2c1_default: blsp2-i2c1-state {
 				pins = "gpio55", "gpio56";
 				function = "blsp_i2c7";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp2_i2c1_sleep: blsp2-i2c0-sleep {
+			blsp2_i2c1_sleep: blsp2-i2c0-sleep-state {
 				pins = "gpio55", "gpio56";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp2_i2c5_default: blsp2-i2c5 {
+			blsp2_i2c5_default: blsp2-i2c5-state {
 				pins = "gpio60", "gpio61";
 				function = "blsp_i2c11";
 				drive-strength = <2>;
@@ -1533,7 +1533,7 @@ blsp2_i2c5_default: blsp2-i2c5 {
 
 			/* Sleep state for BLSP2_I2C5 is missing.. */
 
-			cdc_reset_active: cdc-reset-active {
+			cdc_reset_active: cdc-reset-active-state {
 				pins = "gpio64";
 				function = "gpio";
 				drive-strength = <16>;
@@ -1541,7 +1541,7 @@ cdc_reset_active: cdc-reset-active {
 				output-high;
 			};
 
-			cdc_reset_sleep: cdc-reset-sleep {
+			cdc_reset_sleep: cdc-reset-sleep-state {
 				pins = "gpio64";
 				function = "gpio";
 				drive-strength = <16>;
@@ -1549,15 +1549,15 @@ cdc_reset_sleep: cdc-reset-sleep {
 				output-low;
 			};
 
-			blsp2_spi6_default: blsp2-spi5-default {
-				spi {
+			blsp2_spi6_default: blsp2-spi5-default-state {
+				spi-pins {
 					pins = "gpio85", "gpio86", "gpio88";
 					function = "blsp_spi12";
 					drive-strength = <12>;
 					bias-disable;
 				};
 
-				cs {
+				cs-pins {
 					pins = "gpio87";
 					function = "gpio";
 					drive-strength = <16>;
@@ -1566,43 +1566,43 @@ cs {
 				};
 			};
 
-			blsp2_spi6_sleep: blsp2-spi5-sleep {
+			blsp2_spi6_sleep: blsp2-spi5-sleep-state {
 				pins = "gpio85", "gpio86", "gpio87", "gpio88";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
 			};
 
-			blsp2_i2c6_default: blsp2-i2c6 {
+			blsp2_i2c6_default: blsp2-i2c6-state {
 				pins = "gpio87", "gpio88";
 				function = "blsp_i2c12";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp2_i2c6_sleep: blsp2-i2c6-sleep {
+			blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
 				pins = "gpio87", "gpio88";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			pcie1_state_on: pcie1-state-on {
-				perst {
+			pcie1_state_on: pcie1-on-state {
+				perst-pins {
 					pins = "gpio130";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio131";
 					function = "pci_e1";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio132";
 					function = "gpio";
 					drive-strength = <2>;
@@ -1610,16 +1610,16 @@ wake {
 				};
 			};
 
-			pcie1_state_off: pcie1-state-off {
+			pcie1_state_off: pcie1-off-state {
 				/* Perst is missing? */
-				clkreq {
+				clkreq-pins {
 					pins = "gpio131";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio132";
 					function = "gpio";
 					drive-strength = <2>;
@@ -1627,22 +1627,22 @@ wake {
 				};
 			};
 
-			pcie2_state_on: pcie2-state-on {
-				perst {
+			pcie2_state_on: pcie2-on-state {
+				perst-pins {
 					pins = "gpio114";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-pull-down;
 				};
 
-				clkreq {
+				clkreq-pins {
 					pins = "gpio115";
 					function = "pci_e2";
 					drive-strength = <2>;
 					bias-pull-up;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio116";
 					function = "gpio";
 					drive-strength = <2>;
@@ -1650,16 +1650,16 @@ wake {
 				};
 			};
 
-			pcie2_state_off: pcie2-state-off {
+			pcie2_state_off: pcie2-off-state {
 				/* Perst is missing? */
-				clkreq {
+				clkreq-pins {
 					pins = "gpio115";
 					function = "gpio";
 					drive-strength = <2>;
 					bias-disable;
 				};
 
-				wake {
+				wake-pins {
 					pins = "gpio116";
 					function = "gpio";
 					drive-strength = <2>;
@@ -1667,90 +1667,90 @@ wake {
 				};
 			};
 
-			sdc1_state_on: sdc1-state-on {
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
 
-			sdc1_state_off: sdc1-state-off {
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
 
-			sdc2_state_on: sdc2-clk-on {
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
 
-			sdc2_state_off: sdc2-clk-off {
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
-- 
2.34.1

