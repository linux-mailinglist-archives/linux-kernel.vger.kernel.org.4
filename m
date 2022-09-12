Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2D5B5479
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiILGWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiILGVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:21:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B8C2C674
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:19:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bt10so13202918lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kCmef+I4ubqqGDCcAcc+6D54ls+qXxrTz9AD5rjIgz8=;
        b=xTRopjT8RULABlCJHqxtuxh/0qxNvnYELgRRhlf/yV20satUbzwzOvennLl0Qd4m9N
         Qvjj19khSdT/mfewd5E+BA8QWXkYFp6AdFi0+/epYrwaTZdSUnH4yRMLlZAABiisa/p3
         /ekgfLNYibWpqe4R7G4RK5aJ0y/qKdSVuoaF6nPPQQ8Ik/In7ed2mZ9KU5kUoVQY72+7
         6Cg9V7+xSGFgfS0AAxWM+iZvSk0FoeQrGiq4rFiK2R+AhvnpeOLfOUMQoHexLWeY/PQm
         mzgigqoLplRq5U7DqGmW7wanEZt4gAeAGSmA+jCHyF9/GnVufOZy6duWj7m+3M/tjAv7
         yaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kCmef+I4ubqqGDCcAcc+6D54ls+qXxrTz9AD5rjIgz8=;
        b=ZGPPS+05ijY0ZdHEhTpj4iBflwe9ENVD+bodSk49AjUtjzwARtHtYmsMWcXu/GGhJL
         t9Kzcb57a1DJS6+EECSEgD1RBZGdJuSwRUtkOn6i75QHEio0juukIOO6Fjz5DP9WMSxG
         3kx/h62ah+XrZNCRILOv02YE1yzrQVG3s/kp2x3JW82yt4mRZoORTdmlS42eaLWlSeCQ
         xjPC+VXoS4UkIq8T5uLVLl0+HD+imAccj7+z3An0q3XDSPFE93zk6Wr/xBkvgz+TWABV
         jbrk2sZG0Zza3hbho7T5YccUNo+17xvCbTEHPRUbMK3ke5xRN1SNp119PLGQcg9AeNNE
         MywA==
X-Gm-Message-State: ACgBeo3WYVtGR+Q9bZKXHsC1oXdJ8JUF+h7tAYqYkxYixQQNgKiQN7qM
        qmFG4hzNo7pNO96ClM2JrZFaNw==
X-Google-Smtp-Source: AA6agR6lUpkimdHOgaaptYrNlgGPNjggTiAYrXWDC3WCH4/ehXWMlFBARLmq0/i+k0tWHlAUvSIdHg==
X-Received: by 2002:a05:6512:3a87:b0:499:2069:17af with SMTP id q7-20020a0565123a8700b00499206917afmr4524286lfu.38.1662963528144;
        Sun, 11 Sep 2022 23:18:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 39/40] arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema
Date:   Mon, 12 Sep 2022 08:17:45 +0200
Message-Id: <20220912061746.6311-40-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects TLMM pin configuration nodes to be named with '-state'
suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  44 +--
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |   8 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  20 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  14 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 316 +++++++++---------
 5 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 45f6a1e1002e..82307722222a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -717,27 +717,27 @@ &tlmm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&bios_flash_wp_od>;
 
-	amp_en: amp-en {
+	amp_en: amp-en-pins {
 		pins = "gpio63";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	ap_ec_int_l: ap-ec-int-l {
+	ap_ec_int_l: ap-ec-int-l-pins {
 		pins = "gpio18";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	bios_flash_wp_od: bios-flash-wp-od {
+	bios_flash_wp_od: bios-flash-wp-od-pins {
 		pins = "gpio16";
 		function = "gpio";
 		/* Has external pull */
 		bias-disable;
 	};
 
-	en_fp_rails: en-fp-rails {
+	en_fp_rails: en-fp-rails-pins {
 		pins = "gpio77";
 		function = "gpio";
 		bias-disable;
@@ -745,60 +745,60 @@ en_fp_rails: en-fp-rails {
 		output-high;
 	};
 
-	en_pp3300_codec: en-pp3300-codec {
+	en_pp3300_codec: en-pp3300-codec-pins {
 		pins = "gpio105";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	en_pp3300_dx_edp: en-pp3300-dx-edp {
+	en_pp3300_dx_edp: en-pp3300-dx-edp-pins {
 		pins = "gpio80";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	fp_rst_l: fp-rst-l {
+	fp_rst_l: fp-rst-l-pins {
 		pins = "gpio78";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	fp_to_ap_irq_l: fp-to-ap-irq-l {
+	fp_to_ap_irq_l: fp-to-ap-irq-l-pins {
 		pins = "gpio61";
 		function = "gpio";
 		/* Has external pullup */
 		bias-disable;
 	};
 
-	fpmcu_boot0: fpmcu-boot0 {
+	fpmcu_boot0: fpmcu-boot0-pins {
 		pins = "gpio68";
 		function = "gpio";
 		bias-disable;
 	};
 
-	gsc_ap_int_odl: gsc-ap-int-odl {
+	gsc_ap_int_odl: gsc-ap-int-odl-pins {
 		pins = "gpio104";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	hp_irq: hp-irq {
+	hp_irq: hp-irq-pins {
 		pins = "gpio101";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	hub_en: hub-en {
+	hub_en: hub-en-pins {
 		pins = "gpio157";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	pe_wake_odl: pe-wake-odl {
+	pe_wake_odl: pe-wake-odl-pins {
 		pins = "gpio3";
 		function = "gpio";
 		/* Has external pull */
@@ -807,45 +807,45 @@ pe_wake_odl: pe-wake-odl {
 	};
 
 	/* For ap_spi_fp */
-	qup_spi9_cs_gpio_init_high: qup-spi9-cs-gpio-init-high {
+	qup_spi9_cs_gpio_init_high: qup-spi9-cs-gpio-init-high-pins {
 		pins = "gpio39";
 		function = "gpio";
 		output-high;
 	};
 
 	/* For ap_ec_spi */
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
+	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-pins {
 		pins = "gpio43";
 		function = "gpio";
 		output-high;
 	};
 
-	sar0_irq_odl: sar0-irq-odl {
+	sar0_irq_odl: sar0-irq-odl-pins {
 		pins = "gpio141";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	sar1_irq_odl: sar1-irq-odl {
+	sar1_irq_odl: sar1-irq-odl-pins {
 		pins = "gpio140";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	sd_cd_odl: sd-cd-odl {
+	sd_cd_odl: sd-cd-odl-pins {
 		pins = "gpio91";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	ssd_en: ssd-en {
+	ssd_en: ssd-en-pins {
 		pins = "gpio51";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	ssd_rst_l: ssd-rst-l {
+	ssd_rst_l: ssd-rst-l-pins {
 		pins = "gpio2";
 		function = "gpio";
 		bias-disable;
@@ -853,14 +853,14 @@ ssd_rst_l: ssd-rst-l {
 		output-low;
 	};
 
-	tp_int_odl: tp-int-odl {
+	tp_int_odl: tp-int-odl-pins {
 		pins = "gpio7";
 		function = "gpio";
 		/* Has external pullup */
 		bias-disable;
 	};
 
-	wf_cam_en: wf-cam-en {
+	wf_cam_en: wf-cam-en-pins {
 		pins = "gpio119";
 		function = "gpio";
 		/* Has external pulldown */
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index a7c346aa3b02..7f5143e9bb80 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -79,26 +79,26 @@ cr50: tpm@0 {
 };
 
 &tlmm {
-	ap_ec_int_l: ap-ec-int-l {
+	ap_ec_int_l: ap-ec-int-l-pins {
 		pins = "gpio18";
 		function = "gpio";
 		input-enable;
 		bias-pull-up;
 	};
 
-	h1_ap_int_odl: h1-ap-int-odl {
+	h1_ap_int_odl: h1-ap-int-odl-pins {
 		pins = "gpio104";
 		function = "gpio";
 		input-enable;
 		bias-pull-up;
 	};
 
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
+	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-pins {
 		pins = "gpio43";
 		output-high;
 	};
 
-	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high {
+	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high-pins {
 		pins = "gpio59";
 		output-high;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 0c48db69e1ef..89ecf0d25a12 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -550,18 +550,18 @@ &sdc2_data {
 };
 
 &tlmm {
-	bt_en: bt-en {
+	bt_en: bt-en-pins {
 		pins = "gpio85";
 		function = "gpio";
 		output-low;
 		bias-disable;
 	};
 
-	nvme_pwren: nvme-pwren {
+	nvme_pwren: nvme-pwren-pins {
 		function = "gpio";
 	};
 
-	pcie1_reset_n: pcie1-reset-n {
+	pcie1_reset_n: pcie1-reset-n-pins {
 		pins = "gpio2";
 		function = "gpio";
 
@@ -570,7 +570,7 @@ pcie1_reset_n: pcie1-reset-n {
 		bias-disable;
 	};
 
-	pcie1_wake_n: pcie1-wake-n {
+	pcie1_wake_n: pcie1-wake-n-pins {
 		pins = "gpio3";
 		function = "gpio";
 
@@ -578,7 +578,7 @@ pcie1_wake_n: pcie1-wake-n {
 		bias-pull-up;
 	};
 
-	qup_uart7_sleep_cts: qup-uart7-sleep-cts {
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-pins {
 		pins = "gpio28";
 		function = "gpio";
 		/*
@@ -591,7 +591,7 @@ qup_uart7_sleep_cts: qup-uart7-sleep-cts {
 		bias-bus-hold;
 	};
 
-	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-pins {
 		pins = "gpio29";
 		function = "gpio";
 		/*
@@ -603,7 +603,7 @@ qup_uart7_sleep_rts: qup-uart7-sleep-rts {
 		bias-pull-down;
 	};
 
-	qup_uart7_sleep_tx: qup-uart7-sleep-tx {
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-pins {
 		pins = "gpio30";
 		function = "gpio";
 		/*
@@ -613,7 +613,7 @@ qup_uart7_sleep_tx: qup-uart7-sleep-tx {
 		bias-pull-up;
 	};
 
-	qup_uart7_sleep_rx: qup-uart7-sleep-rx {
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-pins {
 		pins = "gpio31";
 		function = "gpio";
 		/*
@@ -624,13 +624,13 @@ qup_uart7_sleep_rx: qup-uart7-sleep-rx {
 		bias-pull-up;
 	};
 
-	sd_cd: sd-cd {
+	sd_cd: sd-cd-pins {
 		pins = "gpio91";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	sw_ctrl: sw-ctrl {
+	sw_ctrl: sw-ctrl-pins {
 		pins = "gpio86";
 		function = "gpio";
 		bias-pull-down;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 7cd91df7a118..0b56aecf857b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -542,7 +542,7 @@ pmic_edp_bl_pwm: pmic-edp-bl-pwm-state {
 };
 
 &tlmm {
-	mos_bt_en: mos-bt-en {
+	mos_bt_en: mos-bt-en-pins {
 		pins = "gpio85";
 		function = "gpio";
 		drive-strength = <2>;
@@ -550,7 +550,7 @@ mos_bt_en: mos-bt-en {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_cts: qup-uart7-sleep-cts {
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-pins {
 		pins = "gpio28";
 		function = "gpio";
 		/*
@@ -564,7 +564,7 @@ qup_uart7_sleep_cts: qup-uart7-sleep-cts {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-pins {
 		pins = "gpio29";
 		function = "gpio";
 		/*
@@ -577,7 +577,7 @@ qup_uart7_sleep_rts: qup-uart7-sleep-rts {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_rx: qup-uart7-sleep-rx {
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-pins {
 		pins = "gpio31";
 		function = "gpio";
 		/*
@@ -589,7 +589,7 @@ qup_uart7_sleep_rx: qup-uart7-sleep-rx {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_tx: qup-uart7-sleep-tx {
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-pins {
 		pins = "gpio30";
 		function = "gpio";
 		/*
@@ -599,13 +599,13 @@ qup_uart7_sleep_tx: qup-uart7-sleep-tx {
 		bias-pull-up;
 	};
 
-	ts_int_conn: ts-int-conn {
+	ts_int_conn: ts-int-conn-pins {
 		pins = "gpio55";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	ts_rst_conn: ts-rst-conn {
+	ts_rst_conn: ts-rst-conn-pins {
 		pins = "gpio54";
 		function = "gpio";
 		drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ad04025a8a1a..07fa3e417a96 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4061,791 +4061,791 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 175>;
 			wakeup-parent = <&pdc>;
 
-			dp_hot_plug_det: dp-hot-plug-det {
+			dp_hot_plug_det: dp-hot-plug-det-pins {
 				pins = "gpio47";
 				function = "dp_hot";
 			};
 
-			edp_hot_plug_det: edp-hot-plug-det {
+			edp_hot_plug_det: edp-hot-plug-det-pins {
 				pins = "gpio60";
 				function = "edp_hot";
 			};
 
-			mi2s0_data0: mi2s0-data0 {
+			mi2s0_data0: mi2s0-data0-pins {
 				pins = "gpio98";
 				function = "mi2s0_data0";
 			};
 
-			mi2s0_data1: mi2s0-data1 {
+			mi2s0_data1: mi2s0-data1-pins {
 				pins = "gpio99";
 				function = "mi2s0_data1";
 			};
 
-			mi2s0_mclk: mi2s0-mclk {
+			mi2s0_mclk: mi2s0-mclk-pins {
 				pins = "gpio96";
 				function = "pri_mi2s";
 			};
 
-			mi2s0_sclk: mi2s0-sclk {
+			mi2s0_sclk: mi2s0-sclk-pins {
 				pins = "gpio97";
 				function = "mi2s0_sck";
 			};
 
-			mi2s0_ws: mi2s0-ws {
+			mi2s0_ws: mi2s0-ws-pins {
 				pins = "gpio100";
 				function = "mi2s0_ws";
 			};
 
-			mi2s1_data0: mi2s1-data0 {
+			mi2s1_data0: mi2s1-data0-pins {
 				pins = "gpio107";
 				function = "mi2s1_data0";
 			};
 
-			mi2s1_sclk: mi2s1-sclk {
+			mi2s1_sclk: mi2s1-sclk-pins {
 				pins = "gpio106";
 				function = "mi2s1_sck";
 			};
 
-			mi2s1_ws: mi2s1-ws {
+			mi2s1_ws: mi2s1-ws-pins {
 				pins = "gpio108";
 				function = "mi2s1_ws";
 			};
 
-			pcie1_clkreq_n: pcie1-clkreq-n {
+			pcie1_clkreq_n: pcie1-clkreq-n-pins {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";
 			};
 
-			qspi_clk: qspi-clk {
+			qspi_clk: qspi-clk-pins {
 				pins = "gpio14";
 				function = "qspi_clk";
 			};
 
-			qspi_cs0: qspi-cs0 {
+			qspi_cs0: qspi-cs0-pins {
 				pins = "gpio15";
 				function = "qspi_cs";
 			};
 
-			qspi_cs1: qspi-cs1 {
+			qspi_cs1: qspi-cs1-pins {
 				pins = "gpio19";
 				function = "qspi_cs";
 			};
 
-			qspi_data01: qspi-data01 {
+			qspi_data01: qspi-data01-pins {
 				pins = "gpio12", "gpio13";
 				function = "qspi_data";
 			};
 
-			qspi_data12: qspi-data12 {
+			qspi_data12: qspi-data12-pins {
 				pins = "gpio16", "gpio17";
 				function = "qspi_data";
 			};
 
-			qup_i2c0_data_clk: qup-i2c0-data-clk {
+			qup_i2c0_data_clk: qup-i2c0-data-clk-pins {
 				pins = "gpio0", "gpio1";
 				function = "qup00";
 			};
 
-			qup_i2c1_data_clk: qup-i2c1-data-clk {
+			qup_i2c1_data_clk: qup-i2c1-data-clk-pins {
 				pins = "gpio4", "gpio5";
 				function = "qup01";
 			};
 
-			qup_i2c2_data_clk: qup-i2c2-data-clk {
+			qup_i2c2_data_clk: qup-i2c2-data-clk-pins {
 				pins = "gpio8", "gpio9";
 				function = "qup02";
 			};
 
-			qup_i2c3_data_clk: qup-i2c3-data-clk {
+			qup_i2c3_data_clk: qup-i2c3-data-clk-pins {
 				pins = "gpio12", "gpio13";
 				function = "qup03";
 			};
 
-			qup_i2c4_data_clk: qup-i2c4-data-clk {
+			qup_i2c4_data_clk: qup-i2c4-data-clk-pins {
 				pins = "gpio16", "gpio17";
 				function = "qup04";
 			};
 
-			qup_i2c5_data_clk: qup-i2c5-data-clk {
+			qup_i2c5_data_clk: qup-i2c5-data-clk-pins {
 				pins = "gpio20", "gpio21";
 				function = "qup05";
 			};
 
-			qup_i2c6_data_clk: qup-i2c6-data-clk {
+			qup_i2c6_data_clk: qup-i2c6-data-clk-pins {
 				pins = "gpio24", "gpio25";
 				function = "qup06";
 			};
 
-			qup_i2c7_data_clk: qup-i2c7-data-clk {
+			qup_i2c7_data_clk: qup-i2c7-data-clk-pins {
 				pins = "gpio28", "gpio29";
 				function = "qup07";
 			};
 
-			qup_i2c8_data_clk: qup-i2c8-data-clk {
+			qup_i2c8_data_clk: qup-i2c8-data-clk-pins {
 				pins = "gpio32", "gpio33";
 				function = "qup10";
 			};
 
-			qup_i2c9_data_clk: qup-i2c9-data-clk {
+			qup_i2c9_data_clk: qup-i2c9-data-clk-pins {
 				pins = "gpio36", "gpio37";
 				function = "qup11";
 			};
 
-			qup_i2c10_data_clk: qup-i2c10-data-clk {
+			qup_i2c10_data_clk: qup-i2c10-data-clk-pins {
 				pins = "gpio40", "gpio41";
 				function = "qup12";
 			};
 
-			qup_i2c11_data_clk: qup-i2c11-data-clk {
+			qup_i2c11_data_clk: qup-i2c11-data-clk-pins {
 				pins = "gpio44", "gpio45";
 				function = "qup13";
 			};
 
-			qup_i2c12_data_clk: qup-i2c12-data-clk {
+			qup_i2c12_data_clk: qup-i2c12-data-clk-pins {
 				pins = "gpio48", "gpio49";
 				function = "qup14";
 			};
 
-			qup_i2c13_data_clk: qup-i2c13-data-clk {
+			qup_i2c13_data_clk: qup-i2c13-data-clk-pins {
 				pins = "gpio52", "gpio53";
 				function = "qup15";
 			};
 
-			qup_i2c14_data_clk: qup-i2c14-data-clk {
+			qup_i2c14_data_clk: qup-i2c14-data-clk-pins {
 				pins = "gpio56", "gpio57";
 				function = "qup16";
 			};
 
-			qup_i2c15_data_clk: qup-i2c15-data-clk {
+			qup_i2c15_data_clk: qup-i2c15-data-clk-pins {
 				pins = "gpio60", "gpio61";
 				function = "qup17";
 			};
 
-			qup_spi0_data_clk: qup-spi0-data-clk {
+			qup_spi0_data_clk: qup-spi0-data-clk-pins {
 				pins = "gpio0", "gpio1", "gpio2";
 				function = "qup00";
 			};
 
-			qup_spi0_cs: qup-spi0-cs {
+			qup_spi0_cs: qup-spi0-cs-pins {
 				pins = "gpio3";
 				function = "qup00";
 			};
 
-			qup_spi0_cs_gpio: qup-spi0-cs-gpio {
+			qup_spi0_cs_gpio: qup-spi0-cs-gpio-pins {
 				pins = "gpio3";
 				function = "gpio";
 			};
 
-			qup_spi1_data_clk: qup-spi1-data-clk {
+			qup_spi1_data_clk: qup-spi1-data-clk-pins {
 				pins = "gpio4", "gpio5", "gpio6";
 				function = "qup01";
 			};
 
-			qup_spi1_cs: qup-spi1-cs {
+			qup_spi1_cs: qup-spi1-cs-pins {
 				pins = "gpio7";
 				function = "qup01";
 			};
 
-			qup_spi1_cs_gpio: qup-spi1-cs-gpio {
+			qup_spi1_cs_gpio: qup-spi1-cs-gpio-pins {
 				pins = "gpio7";
 				function = "gpio";
 			};
 
-			qup_spi2_data_clk: qup-spi2-data-clk {
+			qup_spi2_data_clk: qup-spi2-data-clk-pins {
 				pins = "gpio8", "gpio9", "gpio10";
 				function = "qup02";
 			};
 
-			qup_spi2_cs: qup-spi2-cs {
+			qup_spi2_cs: qup-spi2-cs-pins {
 				pins = "gpio11";
 				function = "qup02";
 			};
 
-			qup_spi2_cs_gpio: qup-spi2-cs-gpio {
+			qup_spi2_cs_gpio: qup-spi2-cs-gpio-pins {
 				pins = "gpio11";
 				function = "gpio";
 			};
 
-			qup_spi3_data_clk: qup-spi3-data-clk {
+			qup_spi3_data_clk: qup-spi3-data-clk-pins {
 				pins = "gpio12", "gpio13", "gpio14";
 				function = "qup03";
 			};
 
-			qup_spi3_cs: qup-spi3-cs {
+			qup_spi3_cs: qup-spi3-cs-pins {
 				pins = "gpio15";
 				function = "qup03";
 			};
 
-			qup_spi3_cs_gpio: qup-spi3-cs-gpio {
+			qup_spi3_cs_gpio: qup-spi3-cs-gpio-pins {
 				pins = "gpio15";
 				function = "gpio";
 			};
 
-			qup_spi4_data_clk: qup-spi4-data-clk {
+			qup_spi4_data_clk: qup-spi4-data-clk-pins {
 				pins = "gpio16", "gpio17", "gpio18";
 				function = "qup04";
 			};
 
-			qup_spi4_cs: qup-spi4-cs {
+			qup_spi4_cs: qup-spi4-cs-pins {
 				pins = "gpio19";
 				function = "qup04";
 			};
 
-			qup_spi4_cs_gpio: qup-spi4-cs-gpio {
+			qup_spi4_cs_gpio: qup-spi4-cs-gpio-pins {
 				pins = "gpio19";
 				function = "gpio";
 			};
 
-			qup_spi5_data_clk: qup-spi5-data-clk {
+			qup_spi5_data_clk: qup-spi5-data-clk-pins {
 				pins = "gpio20", "gpio21", "gpio22";
 				function = "qup05";
 			};
 
-			qup_spi5_cs: qup-spi5-cs {
+			qup_spi5_cs: qup-spi5-cs-pins {
 				pins = "gpio23";
 				function = "qup05";
 			};
 
-			qup_spi5_cs_gpio: qup-spi5-cs-gpio {
+			qup_spi5_cs_gpio: qup-spi5-cs-gpio-pins {
 				pins = "gpio23";
 				function = "gpio";
 			};
 
-			qup_spi6_data_clk: qup-spi6-data-clk {
+			qup_spi6_data_clk: qup-spi6-data-clk-pins {
 				pins = "gpio24", "gpio25", "gpio26";
 				function = "qup06";
 			};
 
-			qup_spi6_cs: qup-spi6-cs {
+			qup_spi6_cs: qup-spi6-cs-pins {
 				pins = "gpio27";
 				function = "qup06";
 			};
 
-			qup_spi6_cs_gpio: qup-spi6-cs-gpio {
+			qup_spi6_cs_gpio: qup-spi6-cs-gpio-pins {
 				pins = "gpio27";
 				function = "gpio";
 			};
 
-			qup_spi7_data_clk: qup-spi7-data-clk {
+			qup_spi7_data_clk: qup-spi7-data-clk-pins {
 				pins = "gpio28", "gpio29", "gpio30";
 				function = "qup07";
 			};
 
-			qup_spi7_cs: qup-spi7-cs {
+			qup_spi7_cs: qup-spi7-cs-pins {
 				pins = "gpio31";
 				function = "qup07";
 			};
 
-			qup_spi7_cs_gpio: qup-spi7-cs-gpio {
+			qup_spi7_cs_gpio: qup-spi7-cs-gpio-pins {
 				pins = "gpio31";
 				function = "gpio";
 			};
 
-			qup_spi8_data_clk: qup-spi8-data-clk {
+			qup_spi8_data_clk: qup-spi8-data-clk-pins {
 				pins = "gpio32", "gpio33", "gpio34";
 				function = "qup10";
 			};
 
-			qup_spi8_cs: qup-spi8-cs {
+			qup_spi8_cs: qup-spi8-cs-pins {
 				pins = "gpio35";
 				function = "qup10";
 			};
 
-			qup_spi8_cs_gpio: qup-spi8-cs-gpio {
+			qup_spi8_cs_gpio: qup-spi8-cs-gpio-pins {
 				pins = "gpio35";
 				function = "gpio";
 			};
 
-			qup_spi9_data_clk: qup-spi9-data-clk {
+			qup_spi9_data_clk: qup-spi9-data-clk-pins {
 				pins = "gpio36", "gpio37", "gpio38";
 				function = "qup11";
 			};
 
-			qup_spi9_cs: qup-spi9-cs {
+			qup_spi9_cs: qup-spi9-cs-pins {
 				pins = "gpio39";
 				function = "qup11";
 			};
 
-			qup_spi9_cs_gpio: qup-spi9-cs-gpio {
+			qup_spi9_cs_gpio: qup-spi9-cs-gpio-pins {
 				pins = "gpio39";
 				function = "gpio";
 			};
 
-			qup_spi10_data_clk: qup-spi10-data-clk {
+			qup_spi10_data_clk: qup-spi10-data-clk-pins {
 				pins = "gpio40", "gpio41", "gpio42";
 				function = "qup12";
 			};
 
-			qup_spi10_cs: qup-spi10-cs {
+			qup_spi10_cs: qup-spi10-cs-pins {
 				pins = "gpio43";
 				function = "qup12";
 			};
 
-			qup_spi10_cs_gpio: qup-spi10-cs-gpio {
+			qup_spi10_cs_gpio: qup-spi10-cs-gpio-pins {
 				pins = "gpio43";
 				function = "gpio";
 			};
 
-			qup_spi11_data_clk: qup-spi11-data-clk {
+			qup_spi11_data_clk: qup-spi11-data-clk-pins {
 				pins = "gpio44", "gpio45", "gpio46";
 				function = "qup13";
 			};
 
-			qup_spi11_cs: qup-spi11-cs {
+			qup_spi11_cs: qup-spi11-cs-pins {
 				pins = "gpio47";
 				function = "qup13";
 			};
 
-			qup_spi11_cs_gpio: qup-spi11-cs-gpio {
+			qup_spi11_cs_gpio: qup-spi11-cs-gpio-pins {
 				pins = "gpio47";
 				function = "gpio";
 			};
 
-			qup_spi12_data_clk: qup-spi12-data-clk {
+			qup_spi12_data_clk: qup-spi12-data-clk-pins {
 				pins = "gpio48", "gpio49", "gpio50";
 				function = "qup14";
 			};
 
-			qup_spi12_cs: qup-spi12-cs {
+			qup_spi12_cs: qup-spi12-cs-pins {
 				pins = "gpio51";
 				function = "qup14";
 			};
 
-			qup_spi12_cs_gpio: qup-spi12-cs-gpio {
+			qup_spi12_cs_gpio: qup-spi12-cs-gpio-pins {
 				pins = "gpio51";
 				function = "gpio";
 			};
 
-			qup_spi13_data_clk: qup-spi13-data-clk {
+			qup_spi13_data_clk: qup-spi13-data-clk-pins {
 				pins = "gpio52", "gpio53", "gpio54";
 				function = "qup15";
 			};
 
-			qup_spi13_cs: qup-spi13-cs {
+			qup_spi13_cs: qup-spi13-cs-pins {
 				pins = "gpio55";
 				function = "qup15";
 			};
 
-			qup_spi13_cs_gpio: qup-spi13-cs-gpio {
+			qup_spi13_cs_gpio: qup-spi13-cs-gpio-pins {
 				pins = "gpio55";
 				function = "gpio";
 			};
 
-			qup_spi14_data_clk: qup-spi14-data-clk {
+			qup_spi14_data_clk: qup-spi14-data-clk-pins {
 				pins = "gpio56", "gpio57", "gpio58";
 				function = "qup16";
 			};
 
-			qup_spi14_cs: qup-spi14-cs {
+			qup_spi14_cs: qup-spi14-cs-pins {
 				pins = "gpio59";
 				function = "qup16";
 			};
 
-			qup_spi14_cs_gpio: qup-spi14-cs-gpio {
+			qup_spi14_cs_gpio: qup-spi14-cs-gpio-pins {
 				pins = "gpio59";
 				function = "gpio";
 			};
 
-			qup_spi15_data_clk: qup-spi15-data-clk {
+			qup_spi15_data_clk: qup-spi15-data-clk-pins {
 				pins = "gpio60", "gpio61", "gpio62";
 				function = "qup17";
 			};
 
-			qup_spi15_cs: qup-spi15-cs {
+			qup_spi15_cs: qup-spi15-cs-pins {
 				pins = "gpio63";
 				function = "qup17";
 			};
 
-			qup_spi15_cs_gpio: qup-spi15-cs-gpio {
+			qup_spi15_cs_gpio: qup-spi15-cs-gpio-pins {
 				pins = "gpio63";
 				function = "gpio";
 			};
 
-			qup_uart0_cts: qup-uart0-cts {
+			qup_uart0_cts: qup-uart0-cts-pins {
 				pins = "gpio0";
 				function = "qup00";
 			};
 
-			qup_uart0_rts: qup-uart0-rts {
+			qup_uart0_rts: qup-uart0-rts-pins {
 				pins = "gpio1";
 				function = "qup00";
 			};
 
-			qup_uart0_tx: qup-uart0-tx {
+			qup_uart0_tx: qup-uart0-tx-pins {
 				pins = "gpio2";
 				function = "qup00";
 			};
 
-			qup_uart0_rx: qup-uart0-rx {
+			qup_uart0_rx: qup-uart0-rx-pins {
 				pins = "gpio3";
 				function = "qup00";
 			};
 
-			qup_uart1_cts: qup-uart1-cts {
+			qup_uart1_cts: qup-uart1-cts-pins {
 				pins = "gpio4";
 				function = "qup01";
 			};
 
-			qup_uart1_rts: qup-uart1-rts {
+			qup_uart1_rts: qup-uart1-rts-pins {
 				pins = "gpio5";
 				function = "qup01";
 			};
 
-			qup_uart1_tx: qup-uart1-tx {
+			qup_uart1_tx: qup-uart1-tx-pins {
 				pins = "gpio6";
 				function = "qup01";
 			};
 
-			qup_uart1_rx: qup-uart1-rx {
+			qup_uart1_rx: qup-uart1-rx-pins {
 				pins = "gpio7";
 				function = "qup01";
 			};
 
-			qup_uart2_cts: qup-uart2-cts {
+			qup_uart2_cts: qup-uart2-cts-pins {
 				pins = "gpio8";
 				function = "qup02";
 			};
 
-			qup_uart2_rts: qup-uart2-rts {
+			qup_uart2_rts: qup-uart2-rts-pins {
 				pins = "gpio9";
 				function = "qup02";
 			};
 
-			qup_uart2_tx: qup-uart2-tx {
+			qup_uart2_tx: qup-uart2-tx-pins {
 				pins = "gpio10";
 				function = "qup02";
 			};
 
-			qup_uart2_rx: qup-uart2-rx {
+			qup_uart2_rx: qup-uart2-rx-pins {
 				pins = "gpio11";
 				function = "qup02";
 			};
 
-			qup_uart3_cts: qup-uart3-cts {
+			qup_uart3_cts: qup-uart3-cts-pins {
 				pins = "gpio12";
 				function = "qup03";
 			};
 
-			qup_uart3_rts: qup-uart3-rts {
+			qup_uart3_rts: qup-uart3-rts-pins {
 				pins = "gpio13";
 				function = "qup03";
 			};
 
-			qup_uart3_tx: qup-uart3-tx {
+			qup_uart3_tx: qup-uart3-tx-pins {
 				pins = "gpio14";
 				function = "qup03";
 			};
 
-			qup_uart3_rx: qup-uart3-rx {
+			qup_uart3_rx: qup-uart3-rx-pins {
 				pins = "gpio15";
 				function = "qup03";
 			};
 
-			qup_uart4_cts: qup-uart4-cts {
+			qup_uart4_cts: qup-uart4-cts-pins {
 				pins = "gpio16";
 				function = "qup04";
 			};
 
-			qup_uart4_rts: qup-uart4-rts {
+			qup_uart4_rts: qup-uart4-rts-pins {
 				pins = "gpio17";
 				function = "qup04";
 			};
 
-			qup_uart4_tx: qup-uart4-tx {
+			qup_uart4_tx: qup-uart4-tx-pins {
 				pins = "gpio18";
 				function = "qup04";
 			};
 
-			qup_uart4_rx: qup-uart4-rx {
+			qup_uart4_rx: qup-uart4-rx-pins {
 				pins = "gpio19";
 				function = "qup04";
 			};
 
-			qup_uart5_cts: qup-uart5-cts {
+			qup_uart5_cts: qup-uart5-cts-pins {
 				pins = "gpio20";
 				function = "qup05";
 			};
 
-			qup_uart5_rts: qup-uart5-rts {
+			qup_uart5_rts: qup-uart5-rts-pins {
 				pins = "gpio21";
 				function = "qup05";
 			};
 
-			qup_uart5_tx: qup-uart5-tx {
+			qup_uart5_tx: qup-uart5-tx-pins {
 				pins = "gpio22";
 				function = "qup05";
 			};
 
-			qup_uart5_rx: qup-uart5-rx {
+			qup_uart5_rx: qup-uart5-rx-pins {
 				pins = "gpio23";
 				function = "qup05";
 			};
 
-			qup_uart6_cts: qup-uart6-cts {
+			qup_uart6_cts: qup-uart6-cts-pins {
 				pins = "gpio24";
 				function = "qup06";
 			};
 
-			qup_uart6_rts: qup-uart6-rts {
+			qup_uart6_rts: qup-uart6-rts-pins {
 				pins = "gpio25";
 				function = "qup06";
 			};
 
-			qup_uart6_tx: qup-uart6-tx {
+			qup_uart6_tx: qup-uart6-tx-pins {
 				pins = "gpio26";
 				function = "qup06";
 			};
 
-			qup_uart6_rx: qup-uart6-rx {
+			qup_uart6_rx: qup-uart6-rx-pins {
 				pins = "gpio27";
 				function = "qup06";
 			};
 
-			qup_uart7_cts: qup-uart7-cts {
+			qup_uart7_cts: qup-uart7-cts-pins {
 				pins = "gpio28";
 				function = "qup07";
 			};
 
-			qup_uart7_rts: qup-uart7-rts {
+			qup_uart7_rts: qup-uart7-rts-pins {
 				pins = "gpio29";
 				function = "qup07";
 			};
 
-			qup_uart7_tx: qup-uart7-tx {
+			qup_uart7_tx: qup-uart7-tx-pins {
 				pins = "gpio30";
 				function = "qup07";
 			};
 
-			qup_uart7_rx: qup-uart7-rx {
+			qup_uart7_rx: qup-uart7-rx-pins {
 				pins = "gpio31";
 				function = "qup07";
 			};
 
-			qup_uart8_cts: qup-uart8-cts {
+			qup_uart8_cts: qup-uart8-cts-pins {
 				pins = "gpio32";
 				function = "qup10";
 			};
 
-			qup_uart8_rts: qup-uart8-rts {
+			qup_uart8_rts: qup-uart8-rts-pins {
 				pins = "gpio33";
 				function = "qup10";
 			};
 
-			qup_uart8_tx: qup-uart8-tx {
+			qup_uart8_tx: qup-uart8-tx-pins {
 				pins = "gpio34";
 				function = "qup10";
 			};
 
-			qup_uart8_rx: qup-uart8-rx {
+			qup_uart8_rx: qup-uart8-rx-pins {
 				pins = "gpio35";
 				function = "qup10";
 			};
 
-			qup_uart9_cts: qup-uart9-cts {
+			qup_uart9_cts: qup-uart9-cts-pins {
 				pins = "gpio36";
 				function = "qup11";
 			};
 
-			qup_uart9_rts: qup-uart9-rts {
+			qup_uart9_rts: qup-uart9-rts-pins {
 				pins = "gpio37";
 				function = "qup11";
 			};
 
-			qup_uart9_tx: qup-uart9-tx {
+			qup_uart9_tx: qup-uart9-tx-pins {
 				pins = "gpio38";
 				function = "qup11";
 			};
 
-			qup_uart9_rx: qup-uart9-rx {
+			qup_uart9_rx: qup-uart9-rx-pins {
 				pins = "gpio39";
 				function = "qup11";
 			};
 
-			qup_uart10_cts: qup-uart10-cts {
+			qup_uart10_cts: qup-uart10-cts-pins {
 				pins = "gpio40";
 				function = "qup12";
 			};
 
-			qup_uart10_rts: qup-uart10-rts {
+			qup_uart10_rts: qup-uart10-rts-pins {
 				pins = "gpio41";
 				function = "qup12";
 			};
 
-			qup_uart10_tx: qup-uart10-tx {
+			qup_uart10_tx: qup-uart10-tx-pins {
 				pins = "gpio42";
 				function = "qup12";
 			};
 
-			qup_uart10_rx: qup-uart10-rx {
+			qup_uart10_rx: qup-uart10-rx-pins {
 				pins = "gpio43";
 				function = "qup12";
 			};
 
-			qup_uart11_cts: qup-uart11-cts {
+			qup_uart11_cts: qup-uart11-cts-pins {
 				pins = "gpio44";
 				function = "qup13";
 			};
 
-			qup_uart11_rts: qup-uart11-rts {
+			qup_uart11_rts: qup-uart11-rts-pins {
 				pins = "gpio45";
 				function = "qup13";
 			};
 
-			qup_uart11_tx: qup-uart11-tx {
+			qup_uart11_tx: qup-uart11-tx-pins {
 				pins = "gpio46";
 				function = "qup13";
 			};
 
-			qup_uart11_rx: qup-uart11-rx {
+			qup_uart11_rx: qup-uart11-rx-pins {
 				pins = "gpio47";
 				function = "qup13";
 			};
 
-			qup_uart12_cts: qup-uart12-cts {
+			qup_uart12_cts: qup-uart12-cts-pins {
 				pins = "gpio48";
 				function = "qup14";
 			};
 
-			qup_uart12_rts: qup-uart12-rts {
+			qup_uart12_rts: qup-uart12-rts-pins {
 				pins = "gpio49";
 				function = "qup14";
 			};
 
-			qup_uart12_tx: qup-uart12-tx {
+			qup_uart12_tx: qup-uart12-tx-pins {
 				pins = "gpio50";
 				function = "qup14";
 			};
 
-			qup_uart12_rx: qup-uart12-rx {
+			qup_uart12_rx: qup-uart12-rx-pins {
 				pins = "gpio51";
 				function = "qup14";
 			};
 
-			qup_uart13_cts: qup-uart13-cts {
+			qup_uart13_cts: qup-uart13-cts-pins {
 				pins = "gpio52";
 				function = "qup15";
 			};
 
-			qup_uart13_rts: qup-uart13-rts {
+			qup_uart13_rts: qup-uart13-rts-pins {
 				pins = "gpio53";
 				function = "qup15";
 			};
 
-			qup_uart13_tx: qup-uart13-tx {
+			qup_uart13_tx: qup-uart13-tx-pins {
 				pins = "gpio54";
 				function = "qup15";
 			};
 
-			qup_uart13_rx: qup-uart13-rx {
+			qup_uart13_rx: qup-uart13-rx-pins {
 				pins = "gpio55";
 				function = "qup15";
 			};
 
-			qup_uart14_cts: qup-uart14-cts {
+			qup_uart14_cts: qup-uart14-cts-pins {
 				pins = "gpio56";
 				function = "qup16";
 			};
 
-			qup_uart14_rts: qup-uart14-rts {
+			qup_uart14_rts: qup-uart14-rts-pins {
 				pins = "gpio57";
 				function = "qup16";
 			};
 
-			qup_uart14_tx: qup-uart14-tx {
+			qup_uart14_tx: qup-uart14-tx-pins {
 				pins = "gpio58";
 				function = "qup16";
 			};
 
-			qup_uart14_rx: qup-uart14-rx {
+			qup_uart14_rx: qup-uart14-rx-pins {
 				pins = "gpio59";
 				function = "qup16";
 			};
 
-			qup_uart15_cts: qup-uart15-cts {
+			qup_uart15_cts: qup-uart15-cts-pins {
 				pins = "gpio60";
 				function = "qup17";
 			};
 
-			qup_uart15_rts: qup-uart15-rts {
+			qup_uart15_rts: qup-uart15-rts-pins {
 				pins = "gpio61";
 				function = "qup17";
 			};
 
-			qup_uart15_tx: qup-uart15-tx {
+			qup_uart15_tx: qup-uart15-tx-pins {
 				pins = "gpio62";
 				function = "qup17";
 			};
 
-			qup_uart15_rx: qup-uart15-rx {
+			qup_uart15_rx: qup-uart15-rx-pins {
 				pins = "gpio63";
 				function = "qup17";
 			};
 
-			sdc1_clk: sdc1-clk {
+			sdc1_clk: sdc1-clk-pins {
 				pins = "sdc1_clk";
 			};
 
-			sdc1_cmd: sdc1-cmd {
+			sdc1_cmd: sdc1-cmd-pins {
 				pins = "sdc1_cmd";
 			};
 
-			sdc1_data: sdc1-data {
+			sdc1_data: sdc1-data-pins {
 				pins = "sdc1_data";
 			};
 
-			sdc1_rclk: sdc1-rclk {
+			sdc1_rclk: sdc1-rclk-pins {
 				pins = "sdc1_rclk";
 			};
 
-			sdc1_clk_sleep: sdc1-clk-sleep {
+			sdc1_clk_sleep: sdc1-clk-sleep-pins {
 				pins = "sdc1_clk";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc1_cmd_sleep: sdc1-cmd-sleep {
+			sdc1_cmd_sleep: sdc1-cmd-sleep-pins {
 				pins = "sdc1_cmd";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc1_data_sleep: sdc1-data-sleep {
+			sdc1_data_sleep: sdc1-data-sleep-pins {
 				pins = "sdc1_data";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc1_rclk_sleep: sdc1-rclk-sleep {
+			sdc1_rclk_sleep: sdc1-rclk-sleep-pins {
 				pins = "sdc1_rclk";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc2_clk: sdc2-clk {
+			sdc2_clk: sdc2-clk-pins {
 				pins = "sdc2_clk";
 			};
 
-			sdc2_cmd: sdc2-cmd {
+			sdc2_cmd: sdc2-cmd-pins {
 				pins = "sdc2_cmd";
 			};
 
-			sdc2_data: sdc2-data {
+			sdc2_data: sdc2-data-pins {
 				pins = "sdc2_data";
 			};
 
-			sdc2_clk_sleep: sdc2-clk-sleep {
+			sdc2_clk_sleep: sdc2-clk-sleep-pins {
 				pins = "sdc2_clk";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc2_cmd_sleep: sdc2-cmd-sleep {
+			sdc2_cmd_sleep: sdc2-cmd-sleep-pins {
 				pins = "sdc2_cmd";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc2_data_sleep: sdc2-data-sleep {
+			sdc2_data_sleep: sdc2-data-sleep-pins {
 				pins = "sdc2_data";
 				drive-strength = <2>;
 				bias-bus-hold;
-- 
2.34.1

