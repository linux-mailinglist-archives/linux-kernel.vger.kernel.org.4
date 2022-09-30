Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB15F129F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiI3Tam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiI3TaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE82DA80
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 10so8353145lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vV/cYAYUSlG6HvRioJalDE5TWt4HpxOXyxYIAlVceYw=;
        b=y7TNFi3frgYeLhmBkq5prA/HRwLPiFoPrPfmm/U9KVqIEop36TLC4ce9nyAT28EzKq
         Fqo3LG/bebcR/vKnofCJMj2tAv2lGJCcOR+u9Y9c+FiQWzzPmfzWIcC1fdDUN0YWWQi3
         SKl9EUXkgZ+PPvwuHZyPk1noFKSktS4bkr3lIqV+LMc6wAb88QoJc9KMxJfvHAbpHMsp
         75f77mHxisZxRJB0j9/L+ehzpKooKyOPaDIsHp3BRhlRcmVchj0IMAA2WDcy1dwRuRgB
         Zpy1ssckkSLP+7IdrlfN3NF2FJCHmar0u478Nnfqncqa//ne4M6TfXlOUMl3Ono26+uV
         E8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vV/cYAYUSlG6HvRioJalDE5TWt4HpxOXyxYIAlVceYw=;
        b=rNFQMHMJ3whHL76owHK/T4VuMsvn+AFjxzzt2NOj6qKUz0Iwcy07wzuNSzmx6f8EEq
         tM2a/MFkVDlsqA5/plzQvi8Xuj41sZxADfcdzQZ1CsagDB78xm8hkD/ej3gEn1giE0CH
         nrHj9rS9z9aiFcTcpKGGRShK8pXgM/JPavuNoTmiAO3c0ScuKgFNw59ff6vOA7a6ldlu
         8yNzeZMKZpsCDR3JUQtupGWI1iYAxbM7nS1tNqONBMsF7yAyLu4g3D5wnZMCvstBJwPE
         GDd/cVRyi+PGfCC8PNlKXW/7R/VXJnKNf103SfI9LVj2h6sIN5sxQ+g9i1nq38rwylbs
         mN2Q==
X-Gm-Message-State: ACrzQf0qMU29Uv1tUiK71TTu33cI7HiQNnd79IG/RWG+jZJw4VZRXJbm
        NtJxsVQXpezjEdO6B8rUerNGTw==
X-Google-Smtp-Source: AMsMyM6S+b969C9GUoTrmbdjirw4/b68yLKkpIsXyqFwA7fEem28IczXRY1Wm+PegpUm5WFPvKAjLA==
X-Received: by 2002:a05:6512:1699:b0:4a2:1924:af2a with SMTP id bu25-20020a056512169900b004a21924af2amr749819lfb.491.1664566201535;
        Fri, 30 Sep 2022 12:30:01 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:30:01 -0700 (PDT)
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
Subject: [PATCH v2 04/16] arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema (really)
Date:   Fri, 30 Sep 2022 21:29:42 +0200
Message-Id: <20220930192954.242546-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
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

I already tried to do this in commit d801357a0573 ("arm64: dts: qcom:
sc7280: align TLMM pin configuration with DT schema") and I missed the
fact that these nodes were not part of "state" node.  Bindings did not
catch these errors due to its own issues.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts    |   8 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  44 +--
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |   8 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  26 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  20 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 316 +++++++++---------
 6 files changed, 211 insertions(+), 211 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index dddb505e220b..1185141f348e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -118,25 +118,25 @@ &wcd9385 {
 };
 
 &tlmm {
-	tp_int_odl: tp-int-odl {
+	tp_int_odl: tp-int-odl-state {
 		pins = "gpio7";
 		function = "gpio";
 		bias-disable;
 	};
 
-	ts_int_l: ts-int-l {
+	ts_int_l: ts-int-l-state {
 		pins = "gpio55";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	ts_reset_l: ts-reset-l {
+	ts_reset_l: ts-reset-l-state {
 		pins = "gpio54";
 		function = "gpio";
 		bias-disable;
 	};
 
-	us_euro_hs_sel: us-euro-hs-sel {
+	us_euro_hs_sel: us-euro-hs-sel-state {
 		pins = "gpio81";
 		function = "gpio";
 		bias-pull-down;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index c11e37160f34..6a9389c40159 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -744,27 +744,27 @@ &tlmm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&bios_flash_wp_od>;
 
-	amp_en: amp-en-pins {
+	amp_en: amp-en-state {
 		pins = "gpio63";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	ap_ec_int_l: ap-ec-int-l-pins {
+	ap_ec_int_l: ap-ec-int-l-state {
 		pins = "gpio18";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	bios_flash_wp_od: bios-flash-wp-od-pins {
+	bios_flash_wp_od: bios-flash-wp-od-state {
 		pins = "gpio16";
 		function = "gpio";
 		/* Has external pull */
 		bias-disable;
 	};
 
-	en_fp_rails: en-fp-rails-pins {
+	en_fp_rails: en-fp-rails-state {
 		pins = "gpio77";
 		function = "gpio";
 		bias-disable;
@@ -772,60 +772,60 @@ en_fp_rails: en-fp-rails-pins {
 		output-high;
 	};
 
-	en_pp3300_codec: en-pp3300-codec-pins {
+	en_pp3300_codec: en-pp3300-codec-state {
 		pins = "gpio105";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	en_pp3300_dx_edp: en-pp3300-dx-edp-pins {
+	en_pp3300_dx_edp: en-pp3300-dx-edp-state {
 		pins = "gpio80";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	fp_rst_l: fp-rst-l-pins {
+	fp_rst_l: fp-rst-l-state {
 		pins = "gpio78";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	fp_to_ap_irq_l: fp-to-ap-irq-l-pins {
+	fp_to_ap_irq_l: fp-to-ap-irq-l-state {
 		pins = "gpio61";
 		function = "gpio";
 		/* Has external pullup */
 		bias-disable;
 	};
 
-	fpmcu_boot0: fpmcu-boot0-pins {
+	fpmcu_boot0: fpmcu-boot0-state {
 		pins = "gpio68";
 		function = "gpio";
 		bias-disable;
 	};
 
-	gsc_ap_int_odl: gsc-ap-int-odl-pins {
+	gsc_ap_int_odl: gsc-ap-int-odl-state {
 		pins = "gpio104";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	hp_irq: hp-irq-pins {
+	hp_irq: hp-irq-state {
 		pins = "gpio101";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	hub_en: hub-en-pins {
+	hub_en: hub-en-state {
 		pins = "gpio157";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	pe_wake_odl: pe-wake-odl-pins {
+	pe_wake_odl: pe-wake-odl-state {
 		pins = "gpio3";
 		function = "gpio";
 		/* Has external pull */
@@ -834,45 +834,45 @@ pe_wake_odl: pe-wake-odl-pins {
 	};
 
 	/* For ap_spi_fp */
-	qup_spi9_cs_gpio_init_high: qup-spi9-cs-gpio-init-high-pins {
+	qup_spi9_cs_gpio_init_high: qup-spi9-cs-gpio-init-high-state {
 		pins = "gpio39";
 		function = "gpio";
 		output-high;
 	};
 
 	/* For ap_ec_spi */
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-pins {
+	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-state {
 		pins = "gpio43";
 		function = "gpio";
 		output-high;
 	};
 
-	sar0_irq_odl: sar0-irq-odl-pins {
+	sar0_irq_odl: sar0-irq-odl-state {
 		pins = "gpio141";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	sar1_irq_odl: sar1-irq-odl-pins {
+	sar1_irq_odl: sar1-irq-odl-state {
 		pins = "gpio140";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	sd_cd_odl: sd-cd-odl-pins {
+	sd_cd_odl: sd-cd-odl-state {
 		pins = "gpio91";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	ssd_en: ssd-en-pins {
+	ssd_en: ssd-en-state {
 		pins = "gpio51";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	ssd_rst_l: ssd-rst-l-pins {
+	ssd_rst_l: ssd-rst-l-state {
 		pins = "gpio2";
 		function = "gpio";
 		bias-disable;
@@ -880,14 +880,14 @@ ssd_rst_l: ssd-rst-l-pins {
 		output-low;
 	};
 
-	tp_int_odl: tp-int-odl-pins {
+	tp_int_odl: tp-int-odl-state {
 		pins = "gpio7";
 		function = "gpio";
 		/* Has external pullup */
 		bias-disable;
 	};
 
-	wf_cam_en: wf-cam-en-pins {
+	wf_cam_en: wf-cam-en-state {
 		pins = "gpio119";
 		function = "gpio";
 		/* Has external pulldown */
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index 7f5143e9bb80..b35f3738933c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -79,26 +79,26 @@ cr50: tpm@0 {
 };
 
 &tlmm {
-	ap_ec_int_l: ap-ec-int-l-pins {
+	ap_ec_int_l: ap-ec-int-l-state {
 		pins = "gpio18";
 		function = "gpio";
 		input-enable;
 		bias-pull-up;
 	};
 
-	h1_ap_int_odl: h1-ap-int-odl-pins {
+	h1_ap_int_odl: h1-ap-int-odl-state {
 		pins = "gpio104";
 		function = "gpio";
 		input-enable;
 		bias-pull-up;
 	};
 
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-pins {
+	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high-state {
 		pins = "gpio43";
 		output-high;
 	};
 
-	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high-pins {
+	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high-state {
 		pins = "gpio59";
 		output-high;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index cd432a2856a7..11982c14b704 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -747,24 +747,24 @@ &sdc2_data {
 };
 
 &tlmm {
-	amp_en: amp-en {
+	amp_en: amp-en-state {
 		pins = "gpio63";
 		bias-pull-down;
 		drive-strength = <2>;
 	};
 
-	bt_en: bt-en-pins {
+	bt_en: bt-en-state {
 		pins = "gpio85";
 		function = "gpio";
 		output-low;
 		bias-disable;
 	};
 
-	nvme_pwren: nvme-pwren-pins {
+	nvme_pwren: nvme-pwren-state {
 		function = "gpio";
 	};
 
-	pcie1_reset_n: pcie1-reset-n-pins {
+	pcie1_reset_n: pcie1-reset-n-state {
 		pins = "gpio2";
 		function = "gpio";
 
@@ -773,7 +773,7 @@ pcie1_reset_n: pcie1-reset-n-pins {
 		bias-disable;
 	};
 
-	pcie1_wake_n: pcie1-wake-n-pins {
+	pcie1_wake_n: pcie1-wake-n-state {
 		pins = "gpio3";
 		function = "gpio";
 
@@ -781,7 +781,7 @@ pcie1_wake_n: pcie1-wake-n-pins {
 		bias-pull-up;
 	};
 
-	qup_uart7_sleep_cts: qup-uart7-sleep-cts-pins {
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
 		pins = "gpio28";
 		function = "gpio";
 		/*
@@ -794,7 +794,7 @@ qup_uart7_sleep_cts: qup-uart7-sleep-cts-pins {
 		bias-bus-hold;
 	};
 
-	qup_uart7_sleep_rts: qup-uart7-sleep-rts-pins {
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
 		pins = "gpio29";
 		function = "gpio";
 		/*
@@ -806,7 +806,7 @@ qup_uart7_sleep_rts: qup-uart7-sleep-rts-pins {
 		bias-pull-down;
 	};
 
-	qup_uart7_sleep_tx: qup-uart7-sleep-tx-pins {
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
 		pins = "gpio30";
 		function = "gpio";
 		/*
@@ -816,7 +816,7 @@ qup_uart7_sleep_tx: qup-uart7-sleep-tx-pins {
 		bias-pull-up;
 	};
 
-	qup_uart7_sleep_rx: qup-uart7-sleep-rx-pins {
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
 		pins = "gpio31";
 		function = "gpio";
 		/*
@@ -827,25 +827,25 @@ qup_uart7_sleep_rx: qup-uart7-sleep-rx-pins {
 		bias-pull-up;
 	};
 
-	sd_cd: sd-cd-pins {
+	sd_cd: sd-cd-state {
 		pins = "gpio91";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	sw_ctrl: sw-ctrl-pins {
+	sw_ctrl: sw-ctrl-state {
 		pins = "gpio86";
 		function = "gpio";
 		bias-pull-down;
 	};
 
-	wcd_reset_n: wcd-reset-n {
+	wcd_reset_n: wcd-reset-n-state {
 		pins = "gpio83";
 		function = "gpio";
 		drive-strength = <8>;
 	};
 
-	wcd_reset_n_sleep: wcd-reset-n-sleep {
+	wcd_reset_n_sleep: wcd-reset-n-sleep-state {
 		pins = "gpio83";
 		function = "gpio";
 		drive-strength = <8>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 4b8c676b0bb1..a42b5878a75f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -595,7 +595,7 @@ pmic_edp_bl_pwm: pmic-edp-bl-pwm-state {
 };
 
 &tlmm {
-	mos_bt_en: mos-bt-en-pins {
+	mos_bt_en: mos-bt-en-state {
 		pins = "gpio85";
 		function = "gpio";
 		drive-strength = <2>;
@@ -603,7 +603,7 @@ mos_bt_en: mos-bt-en-pins {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_cts: qup-uart7-sleep-cts-pins {
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
 		pins = "gpio28";
 		function = "gpio";
 		/*
@@ -617,7 +617,7 @@ qup_uart7_sleep_cts: qup-uart7-sleep-cts-pins {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_rts: qup-uart7-sleep-rts-pins {
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
 		pins = "gpio29";
 		function = "gpio";
 		/*
@@ -630,7 +630,7 @@ qup_uart7_sleep_rts: qup-uart7-sleep-rts-pins {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_rx: qup-uart7-sleep-rx-pins {
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
 		pins = "gpio31";
 		function = "gpio";
 		/*
@@ -642,7 +642,7 @@ qup_uart7_sleep_rx: qup-uart7-sleep-rx-pins {
 	};
 
 	/* For mos_bt_uart */
-	qup_uart7_sleep_tx: qup-uart7-sleep-tx-pins {
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
 		pins = "gpio30";
 		function = "gpio";
 		/*
@@ -652,32 +652,32 @@ qup_uart7_sleep_tx: qup-uart7-sleep-tx-pins {
 		bias-pull-up;
 	};
 
-	ts_int_conn: ts-int-conn-pins {
+	ts_int_conn: ts-int-conn-state {
 		pins = "gpio55";
 		function = "gpio";
 		bias-pull-up;
 	};
 
-	ts_rst_conn: ts-rst-conn-pins {
+	ts_rst_conn: ts-rst-conn-state {
 		pins = "gpio54";
 		function = "gpio";
 		drive-strength = <2>;
 	};
 
-	us_euro_hs_sel: us-euro-hs-sel {
+	us_euro_hs_sel: us-euro-hs-sel-state {
 		pins = "gpio81";
 		function = "gpio";
 		bias-pull-down;
 		drive-strength = <2>;
 	};
 
-	wcd_reset_n: wcd-reset-n {
+	wcd_reset_n: wcd-reset-n-state {
 		pins = "gpio83";
 		function = "gpio";
 		drive-strength = <8>;
 	};
 
-	wcd_reset_n_sleep: wcd-reset-n-sleep {
+	wcd_reset_n_sleep: wcd-reset-n-sleep-state {
 		pins = "gpio83";
 		function = "gpio";
 		drive-strength = <8>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 28e3fb9992d9..1a603cf61d8b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4253,791 +4253,791 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 175>;
 			wakeup-parent = <&pdc>;
 
-			dp_hot_plug_det: dp-hot-plug-det-pins {
+			dp_hot_plug_det: dp-hot-plug-det-state {
 				pins = "gpio47";
 				function = "dp_hot";
 			};
 
-			edp_hot_plug_det: edp-hot-plug-det-pins {
+			edp_hot_plug_det: edp-hot-plug-det-state {
 				pins = "gpio60";
 				function = "edp_hot";
 			};
 
-			mi2s0_data0: mi2s0-data0-pins {
+			mi2s0_data0: mi2s0-data0-state {
 				pins = "gpio98";
 				function = "mi2s0_data0";
 			};
 
-			mi2s0_data1: mi2s0-data1-pins {
+			mi2s0_data1: mi2s0-data1-state {
 				pins = "gpio99";
 				function = "mi2s0_data1";
 			};
 
-			mi2s0_mclk: mi2s0-mclk-pins {
+			mi2s0_mclk: mi2s0-mclk-state {
 				pins = "gpio96";
 				function = "pri_mi2s";
 			};
 
-			mi2s0_sclk: mi2s0-sclk-pins {
+			mi2s0_sclk: mi2s0-sclk-state {
 				pins = "gpio97";
 				function = "mi2s0_sck";
 			};
 
-			mi2s0_ws: mi2s0-ws-pins {
+			mi2s0_ws: mi2s0-ws-state {
 				pins = "gpio100";
 				function = "mi2s0_ws";
 			};
 
-			mi2s1_data0: mi2s1-data0-pins {
+			mi2s1_data0: mi2s1-data0-state {
 				pins = "gpio107";
 				function = "mi2s1_data0";
 			};
 
-			mi2s1_sclk: mi2s1-sclk-pins {
+			mi2s1_sclk: mi2s1-sclk-state {
 				pins = "gpio106";
 				function = "mi2s1_sck";
 			};
 
-			mi2s1_ws: mi2s1-ws-pins {
+			mi2s1_ws: mi2s1-ws-state {
 				pins = "gpio108";
 				function = "mi2s1_ws";
 			};
 
-			pcie1_clkreq_n: pcie1-clkreq-n-pins {
+			pcie1_clkreq_n: pcie1-clkreq-n-state {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";
 			};
 
-			qspi_clk: qspi-clk-pins {
+			qspi_clk: qspi-clk-state {
 				pins = "gpio14";
 				function = "qspi_clk";
 			};
 
-			qspi_cs0: qspi-cs0-pins {
+			qspi_cs0: qspi-cs0-state {
 				pins = "gpio15";
 				function = "qspi_cs";
 			};
 
-			qspi_cs1: qspi-cs1-pins {
+			qspi_cs1: qspi-cs1-state {
 				pins = "gpio19";
 				function = "qspi_cs";
 			};
 
-			qspi_data01: qspi-data01-pins {
+			qspi_data01: qspi-data01-state {
 				pins = "gpio12", "gpio13";
 				function = "qspi_data";
 			};
 
-			qspi_data12: qspi-data12-pins {
+			qspi_data12: qspi-data12-state {
 				pins = "gpio16", "gpio17";
 				function = "qspi_data";
 			};
 
-			qup_i2c0_data_clk: qup-i2c0-data-clk-pins {
+			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
 				pins = "gpio0", "gpio1";
 				function = "qup00";
 			};
 
-			qup_i2c1_data_clk: qup-i2c1-data-clk-pins {
+			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
 				pins = "gpio4", "gpio5";
 				function = "qup01";
 			};
 
-			qup_i2c2_data_clk: qup-i2c2-data-clk-pins {
+			qup_i2c2_data_clk: qup-i2c2-data-clk-state {
 				pins = "gpio8", "gpio9";
 				function = "qup02";
 			};
 
-			qup_i2c3_data_clk: qup-i2c3-data-clk-pins {
+			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
 				pins = "gpio12", "gpio13";
 				function = "qup03";
 			};
 
-			qup_i2c4_data_clk: qup-i2c4-data-clk-pins {
+			qup_i2c4_data_clk: qup-i2c4-data-clk-state {
 				pins = "gpio16", "gpio17";
 				function = "qup04";
 			};
 
-			qup_i2c5_data_clk: qup-i2c5-data-clk-pins {
+			qup_i2c5_data_clk: qup-i2c5-data-clk-state {
 				pins = "gpio20", "gpio21";
 				function = "qup05";
 			};
 
-			qup_i2c6_data_clk: qup-i2c6-data-clk-pins {
+			qup_i2c6_data_clk: qup-i2c6-data-clk-state {
 				pins = "gpio24", "gpio25";
 				function = "qup06";
 			};
 
-			qup_i2c7_data_clk: qup-i2c7-data-clk-pins {
+			qup_i2c7_data_clk: qup-i2c7-data-clk-state {
 				pins = "gpio28", "gpio29";
 				function = "qup07";
 			};
 
-			qup_i2c8_data_clk: qup-i2c8-data-clk-pins {
+			qup_i2c8_data_clk: qup-i2c8-data-clk-state {
 				pins = "gpio32", "gpio33";
 				function = "qup10";
 			};
 
-			qup_i2c9_data_clk: qup-i2c9-data-clk-pins {
+			qup_i2c9_data_clk: qup-i2c9-data-clk-state {
 				pins = "gpio36", "gpio37";
 				function = "qup11";
 			};
 
-			qup_i2c10_data_clk: qup-i2c10-data-clk-pins {
+			qup_i2c10_data_clk: qup-i2c10-data-clk-state {
 				pins = "gpio40", "gpio41";
 				function = "qup12";
 			};
 
-			qup_i2c11_data_clk: qup-i2c11-data-clk-pins {
+			qup_i2c11_data_clk: qup-i2c11-data-clk-state {
 				pins = "gpio44", "gpio45";
 				function = "qup13";
 			};
 
-			qup_i2c12_data_clk: qup-i2c12-data-clk-pins {
+			qup_i2c12_data_clk: qup-i2c12-data-clk-state {
 				pins = "gpio48", "gpio49";
 				function = "qup14";
 			};
 
-			qup_i2c13_data_clk: qup-i2c13-data-clk-pins {
+			qup_i2c13_data_clk: qup-i2c13-data-clk-state {
 				pins = "gpio52", "gpio53";
 				function = "qup15";
 			};
 
-			qup_i2c14_data_clk: qup-i2c14-data-clk-pins {
+			qup_i2c14_data_clk: qup-i2c14-data-clk-state {
 				pins = "gpio56", "gpio57";
 				function = "qup16";
 			};
 
-			qup_i2c15_data_clk: qup-i2c15-data-clk-pins {
+			qup_i2c15_data_clk: qup-i2c15-data-clk-state {
 				pins = "gpio60", "gpio61";
 				function = "qup17";
 			};
 
-			qup_spi0_data_clk: qup-spi0-data-clk-pins {
+			qup_spi0_data_clk: qup-spi0-data-clk-state {
 				pins = "gpio0", "gpio1", "gpio2";
 				function = "qup00";
 			};
 
-			qup_spi0_cs: qup-spi0-cs-pins {
+			qup_spi0_cs: qup-spi0-cs-state {
 				pins = "gpio3";
 				function = "qup00";
 			};
 
-			qup_spi0_cs_gpio: qup-spi0-cs-gpio-pins {
+			qup_spi0_cs_gpio: qup-spi0-cs-gpio-state {
 				pins = "gpio3";
 				function = "gpio";
 			};
 
-			qup_spi1_data_clk: qup-spi1-data-clk-pins {
+			qup_spi1_data_clk: qup-spi1-data-clk-state {
 				pins = "gpio4", "gpio5", "gpio6";
 				function = "qup01";
 			};
 
-			qup_spi1_cs: qup-spi1-cs-pins {
+			qup_spi1_cs: qup-spi1-cs-state {
 				pins = "gpio7";
 				function = "qup01";
 			};
 
-			qup_spi1_cs_gpio: qup-spi1-cs-gpio-pins {
+			qup_spi1_cs_gpio: qup-spi1-cs-gpio-state {
 				pins = "gpio7";
 				function = "gpio";
 			};
 
-			qup_spi2_data_clk: qup-spi2-data-clk-pins {
+			qup_spi2_data_clk: qup-spi2-data-clk-state {
 				pins = "gpio8", "gpio9", "gpio10";
 				function = "qup02";
 			};
 
-			qup_spi2_cs: qup-spi2-cs-pins {
+			qup_spi2_cs: qup-spi2-cs-state {
 				pins = "gpio11";
 				function = "qup02";
 			};
 
-			qup_spi2_cs_gpio: qup-spi2-cs-gpio-pins {
+			qup_spi2_cs_gpio: qup-spi2-cs-gpio-state {
 				pins = "gpio11";
 				function = "gpio";
 			};
 
-			qup_spi3_data_clk: qup-spi3-data-clk-pins {
+			qup_spi3_data_clk: qup-spi3-data-clk-state {
 				pins = "gpio12", "gpio13", "gpio14";
 				function = "qup03";
 			};
 
-			qup_spi3_cs: qup-spi3-cs-pins {
+			qup_spi3_cs: qup-spi3-cs-state {
 				pins = "gpio15";
 				function = "qup03";
 			};
 
-			qup_spi3_cs_gpio: qup-spi3-cs-gpio-pins {
+			qup_spi3_cs_gpio: qup-spi3-cs-gpio-state {
 				pins = "gpio15";
 				function = "gpio";
 			};
 
-			qup_spi4_data_clk: qup-spi4-data-clk-pins {
+			qup_spi4_data_clk: qup-spi4-data-clk-state {
 				pins = "gpio16", "gpio17", "gpio18";
 				function = "qup04";
 			};
 
-			qup_spi4_cs: qup-spi4-cs-pins {
+			qup_spi4_cs: qup-spi4-cs-state {
 				pins = "gpio19";
 				function = "qup04";
 			};
 
-			qup_spi4_cs_gpio: qup-spi4-cs-gpio-pins {
+			qup_spi4_cs_gpio: qup-spi4-cs-gpio-state {
 				pins = "gpio19";
 				function = "gpio";
 			};
 
-			qup_spi5_data_clk: qup-spi5-data-clk-pins {
+			qup_spi5_data_clk: qup-spi5-data-clk-state {
 				pins = "gpio20", "gpio21", "gpio22";
 				function = "qup05";
 			};
 
-			qup_spi5_cs: qup-spi5-cs-pins {
+			qup_spi5_cs: qup-spi5-cs-state {
 				pins = "gpio23";
 				function = "qup05";
 			};
 
-			qup_spi5_cs_gpio: qup-spi5-cs-gpio-pins {
+			qup_spi5_cs_gpio: qup-spi5-cs-gpio-state {
 				pins = "gpio23";
 				function = "gpio";
 			};
 
-			qup_spi6_data_clk: qup-spi6-data-clk-pins {
+			qup_spi6_data_clk: qup-spi6-data-clk-state {
 				pins = "gpio24", "gpio25", "gpio26";
 				function = "qup06";
 			};
 
-			qup_spi6_cs: qup-spi6-cs-pins {
+			qup_spi6_cs: qup-spi6-cs-state {
 				pins = "gpio27";
 				function = "qup06";
 			};
 
-			qup_spi6_cs_gpio: qup-spi6-cs-gpio-pins {
+			qup_spi6_cs_gpio: qup-spi6-cs-gpio-state {
 				pins = "gpio27";
 				function = "gpio";
 			};
 
-			qup_spi7_data_clk: qup-spi7-data-clk-pins {
+			qup_spi7_data_clk: qup-spi7-data-clk-state {
 				pins = "gpio28", "gpio29", "gpio30";
 				function = "qup07";
 			};
 
-			qup_spi7_cs: qup-spi7-cs-pins {
+			qup_spi7_cs: qup-spi7-cs-state {
 				pins = "gpio31";
 				function = "qup07";
 			};
 
-			qup_spi7_cs_gpio: qup-spi7-cs-gpio-pins {
+			qup_spi7_cs_gpio: qup-spi7-cs-gpio-state {
 				pins = "gpio31";
 				function = "gpio";
 			};
 
-			qup_spi8_data_clk: qup-spi8-data-clk-pins {
+			qup_spi8_data_clk: qup-spi8-data-clk-state {
 				pins = "gpio32", "gpio33", "gpio34";
 				function = "qup10";
 			};
 
-			qup_spi8_cs: qup-spi8-cs-pins {
+			qup_spi8_cs: qup-spi8-cs-state {
 				pins = "gpio35";
 				function = "qup10";
 			};
 
-			qup_spi8_cs_gpio: qup-spi8-cs-gpio-pins {
+			qup_spi8_cs_gpio: qup-spi8-cs-gpio-state {
 				pins = "gpio35";
 				function = "gpio";
 			};
 
-			qup_spi9_data_clk: qup-spi9-data-clk-pins {
+			qup_spi9_data_clk: qup-spi9-data-clk-state {
 				pins = "gpio36", "gpio37", "gpio38";
 				function = "qup11";
 			};
 
-			qup_spi9_cs: qup-spi9-cs-pins {
+			qup_spi9_cs: qup-spi9-cs-state {
 				pins = "gpio39";
 				function = "qup11";
 			};
 
-			qup_spi9_cs_gpio: qup-spi9-cs-gpio-pins {
+			qup_spi9_cs_gpio: qup-spi9-cs-gpio-state {
 				pins = "gpio39";
 				function = "gpio";
 			};
 
-			qup_spi10_data_clk: qup-spi10-data-clk-pins {
+			qup_spi10_data_clk: qup-spi10-data-clk-state {
 				pins = "gpio40", "gpio41", "gpio42";
 				function = "qup12";
 			};
 
-			qup_spi10_cs: qup-spi10-cs-pins {
+			qup_spi10_cs: qup-spi10-cs-state {
 				pins = "gpio43";
 				function = "qup12";
 			};
 
-			qup_spi10_cs_gpio: qup-spi10-cs-gpio-pins {
+			qup_spi10_cs_gpio: qup-spi10-cs-gpio-state {
 				pins = "gpio43";
 				function = "gpio";
 			};
 
-			qup_spi11_data_clk: qup-spi11-data-clk-pins {
+			qup_spi11_data_clk: qup-spi11-data-clk-state {
 				pins = "gpio44", "gpio45", "gpio46";
 				function = "qup13";
 			};
 
-			qup_spi11_cs: qup-spi11-cs-pins {
+			qup_spi11_cs: qup-spi11-cs-state {
 				pins = "gpio47";
 				function = "qup13";
 			};
 
-			qup_spi11_cs_gpio: qup-spi11-cs-gpio-pins {
+			qup_spi11_cs_gpio: qup-spi11-cs-gpio-state {
 				pins = "gpio47";
 				function = "gpio";
 			};
 
-			qup_spi12_data_clk: qup-spi12-data-clk-pins {
+			qup_spi12_data_clk: qup-spi12-data-clk-state {
 				pins = "gpio48", "gpio49", "gpio50";
 				function = "qup14";
 			};
 
-			qup_spi12_cs: qup-spi12-cs-pins {
+			qup_spi12_cs: qup-spi12-cs-state {
 				pins = "gpio51";
 				function = "qup14";
 			};
 
-			qup_spi12_cs_gpio: qup-spi12-cs-gpio-pins {
+			qup_spi12_cs_gpio: qup-spi12-cs-gpio-state {
 				pins = "gpio51";
 				function = "gpio";
 			};
 
-			qup_spi13_data_clk: qup-spi13-data-clk-pins {
+			qup_spi13_data_clk: qup-spi13-data-clk-state {
 				pins = "gpio52", "gpio53", "gpio54";
 				function = "qup15";
 			};
 
-			qup_spi13_cs: qup-spi13-cs-pins {
+			qup_spi13_cs: qup-spi13-cs-state {
 				pins = "gpio55";
 				function = "qup15";
 			};
 
-			qup_spi13_cs_gpio: qup-spi13-cs-gpio-pins {
+			qup_spi13_cs_gpio: qup-spi13-cs-gpio-state {
 				pins = "gpio55";
 				function = "gpio";
 			};
 
-			qup_spi14_data_clk: qup-spi14-data-clk-pins {
+			qup_spi14_data_clk: qup-spi14-data-clk-state {
 				pins = "gpio56", "gpio57", "gpio58";
 				function = "qup16";
 			};
 
-			qup_spi14_cs: qup-spi14-cs-pins {
+			qup_spi14_cs: qup-spi14-cs-state {
 				pins = "gpio59";
 				function = "qup16";
 			};
 
-			qup_spi14_cs_gpio: qup-spi14-cs-gpio-pins {
+			qup_spi14_cs_gpio: qup-spi14-cs-gpio-state {
 				pins = "gpio59";
 				function = "gpio";
 			};
 
-			qup_spi15_data_clk: qup-spi15-data-clk-pins {
+			qup_spi15_data_clk: qup-spi15-data-clk-state {
 				pins = "gpio60", "gpio61", "gpio62";
 				function = "qup17";
 			};
 
-			qup_spi15_cs: qup-spi15-cs-pins {
+			qup_spi15_cs: qup-spi15-cs-state {
 				pins = "gpio63";
 				function = "qup17";
 			};
 
-			qup_spi15_cs_gpio: qup-spi15-cs-gpio-pins {
+			qup_spi15_cs_gpio: qup-spi15-cs-gpio-state {
 				pins = "gpio63";
 				function = "gpio";
 			};
 
-			qup_uart0_cts: qup-uart0-cts-pins {
+			qup_uart0_cts: qup-uart0-cts-state {
 				pins = "gpio0";
 				function = "qup00";
 			};
 
-			qup_uart0_rts: qup-uart0-rts-pins {
+			qup_uart0_rts: qup-uart0-rts-state {
 				pins = "gpio1";
 				function = "qup00";
 			};
 
-			qup_uart0_tx: qup-uart0-tx-pins {
+			qup_uart0_tx: qup-uart0-tx-state {
 				pins = "gpio2";
 				function = "qup00";
 			};
 
-			qup_uart0_rx: qup-uart0-rx-pins {
+			qup_uart0_rx: qup-uart0-rx-state {
 				pins = "gpio3";
 				function = "qup00";
 			};
 
-			qup_uart1_cts: qup-uart1-cts-pins {
+			qup_uart1_cts: qup-uart1-cts-state {
 				pins = "gpio4";
 				function = "qup01";
 			};
 
-			qup_uart1_rts: qup-uart1-rts-pins {
+			qup_uart1_rts: qup-uart1-rts-state {
 				pins = "gpio5";
 				function = "qup01";
 			};
 
-			qup_uart1_tx: qup-uart1-tx-pins {
+			qup_uart1_tx: qup-uart1-tx-state {
 				pins = "gpio6";
 				function = "qup01";
 			};
 
-			qup_uart1_rx: qup-uart1-rx-pins {
+			qup_uart1_rx: qup-uart1-rx-state {
 				pins = "gpio7";
 				function = "qup01";
 			};
 
-			qup_uart2_cts: qup-uart2-cts-pins {
+			qup_uart2_cts: qup-uart2-cts-state {
 				pins = "gpio8";
 				function = "qup02";
 			};
 
-			qup_uart2_rts: qup-uart2-rts-pins {
+			qup_uart2_rts: qup-uart2-rts-state {
 				pins = "gpio9";
 				function = "qup02";
 			};
 
-			qup_uart2_tx: qup-uart2-tx-pins {
+			qup_uart2_tx: qup-uart2-tx-state {
 				pins = "gpio10";
 				function = "qup02";
 			};
 
-			qup_uart2_rx: qup-uart2-rx-pins {
+			qup_uart2_rx: qup-uart2-rx-state {
 				pins = "gpio11";
 				function = "qup02";
 			};
 
-			qup_uart3_cts: qup-uart3-cts-pins {
+			qup_uart3_cts: qup-uart3-cts-state {
 				pins = "gpio12";
 				function = "qup03";
 			};
 
-			qup_uart3_rts: qup-uart3-rts-pins {
+			qup_uart3_rts: qup-uart3-rts-state {
 				pins = "gpio13";
 				function = "qup03";
 			};
 
-			qup_uart3_tx: qup-uart3-tx-pins {
+			qup_uart3_tx: qup-uart3-tx-state {
 				pins = "gpio14";
 				function = "qup03";
 			};
 
-			qup_uart3_rx: qup-uart3-rx-pins {
+			qup_uart3_rx: qup-uart3-rx-state {
 				pins = "gpio15";
 				function = "qup03";
 			};
 
-			qup_uart4_cts: qup-uart4-cts-pins {
+			qup_uart4_cts: qup-uart4-cts-state {
 				pins = "gpio16";
 				function = "qup04";
 			};
 
-			qup_uart4_rts: qup-uart4-rts-pins {
+			qup_uart4_rts: qup-uart4-rts-state {
 				pins = "gpio17";
 				function = "qup04";
 			};
 
-			qup_uart4_tx: qup-uart4-tx-pins {
+			qup_uart4_tx: qup-uart4-tx-state {
 				pins = "gpio18";
 				function = "qup04";
 			};
 
-			qup_uart4_rx: qup-uart4-rx-pins {
+			qup_uart4_rx: qup-uart4-rx-state {
 				pins = "gpio19";
 				function = "qup04";
 			};
 
-			qup_uart5_cts: qup-uart5-cts-pins {
+			qup_uart5_cts: qup-uart5-cts-state {
 				pins = "gpio20";
 				function = "qup05";
 			};
 
-			qup_uart5_rts: qup-uart5-rts-pins {
+			qup_uart5_rts: qup-uart5-rts-state {
 				pins = "gpio21";
 				function = "qup05";
 			};
 
-			qup_uart5_tx: qup-uart5-tx-pins {
+			qup_uart5_tx: qup-uart5-tx-state {
 				pins = "gpio22";
 				function = "qup05";
 			};
 
-			qup_uart5_rx: qup-uart5-rx-pins {
+			qup_uart5_rx: qup-uart5-rx-state {
 				pins = "gpio23";
 				function = "qup05";
 			};
 
-			qup_uart6_cts: qup-uart6-cts-pins {
+			qup_uart6_cts: qup-uart6-cts-state {
 				pins = "gpio24";
 				function = "qup06";
 			};
 
-			qup_uart6_rts: qup-uart6-rts-pins {
+			qup_uart6_rts: qup-uart6-rts-state {
 				pins = "gpio25";
 				function = "qup06";
 			};
 
-			qup_uart6_tx: qup-uart6-tx-pins {
+			qup_uart6_tx: qup-uart6-tx-state {
 				pins = "gpio26";
 				function = "qup06";
 			};
 
-			qup_uart6_rx: qup-uart6-rx-pins {
+			qup_uart6_rx: qup-uart6-rx-state {
 				pins = "gpio27";
 				function = "qup06";
 			};
 
-			qup_uart7_cts: qup-uart7-cts-pins {
+			qup_uart7_cts: qup-uart7-cts-state {
 				pins = "gpio28";
 				function = "qup07";
 			};
 
-			qup_uart7_rts: qup-uart7-rts-pins {
+			qup_uart7_rts: qup-uart7-rts-state {
 				pins = "gpio29";
 				function = "qup07";
 			};
 
-			qup_uart7_tx: qup-uart7-tx-pins {
+			qup_uart7_tx: qup-uart7-tx-state {
 				pins = "gpio30";
 				function = "qup07";
 			};
 
-			qup_uart7_rx: qup-uart7-rx-pins {
+			qup_uart7_rx: qup-uart7-rx-state {
 				pins = "gpio31";
 				function = "qup07";
 			};
 
-			qup_uart8_cts: qup-uart8-cts-pins {
+			qup_uart8_cts: qup-uart8-cts-state {
 				pins = "gpio32";
 				function = "qup10";
 			};
 
-			qup_uart8_rts: qup-uart8-rts-pins {
+			qup_uart8_rts: qup-uart8-rts-state {
 				pins = "gpio33";
 				function = "qup10";
 			};
 
-			qup_uart8_tx: qup-uart8-tx-pins {
+			qup_uart8_tx: qup-uart8-tx-state {
 				pins = "gpio34";
 				function = "qup10";
 			};
 
-			qup_uart8_rx: qup-uart8-rx-pins {
+			qup_uart8_rx: qup-uart8-rx-state {
 				pins = "gpio35";
 				function = "qup10";
 			};
 
-			qup_uart9_cts: qup-uart9-cts-pins {
+			qup_uart9_cts: qup-uart9-cts-state {
 				pins = "gpio36";
 				function = "qup11";
 			};
 
-			qup_uart9_rts: qup-uart9-rts-pins {
+			qup_uart9_rts: qup-uart9-rts-state {
 				pins = "gpio37";
 				function = "qup11";
 			};
 
-			qup_uart9_tx: qup-uart9-tx-pins {
+			qup_uart9_tx: qup-uart9-tx-state {
 				pins = "gpio38";
 				function = "qup11";
 			};
 
-			qup_uart9_rx: qup-uart9-rx-pins {
+			qup_uart9_rx: qup-uart9-rx-state {
 				pins = "gpio39";
 				function = "qup11";
 			};
 
-			qup_uart10_cts: qup-uart10-cts-pins {
+			qup_uart10_cts: qup-uart10-cts-state {
 				pins = "gpio40";
 				function = "qup12";
 			};
 
-			qup_uart10_rts: qup-uart10-rts-pins {
+			qup_uart10_rts: qup-uart10-rts-state {
 				pins = "gpio41";
 				function = "qup12";
 			};
 
-			qup_uart10_tx: qup-uart10-tx-pins {
+			qup_uart10_tx: qup-uart10-tx-state {
 				pins = "gpio42";
 				function = "qup12";
 			};
 
-			qup_uart10_rx: qup-uart10-rx-pins {
+			qup_uart10_rx: qup-uart10-rx-state {
 				pins = "gpio43";
 				function = "qup12";
 			};
 
-			qup_uart11_cts: qup-uart11-cts-pins {
+			qup_uart11_cts: qup-uart11-cts-state {
 				pins = "gpio44";
 				function = "qup13";
 			};
 
-			qup_uart11_rts: qup-uart11-rts-pins {
+			qup_uart11_rts: qup-uart11-rts-state {
 				pins = "gpio45";
 				function = "qup13";
 			};
 
-			qup_uart11_tx: qup-uart11-tx-pins {
+			qup_uart11_tx: qup-uart11-tx-state {
 				pins = "gpio46";
 				function = "qup13";
 			};
 
-			qup_uart11_rx: qup-uart11-rx-pins {
+			qup_uart11_rx: qup-uart11-rx-state {
 				pins = "gpio47";
 				function = "qup13";
 			};
 
-			qup_uart12_cts: qup-uart12-cts-pins {
+			qup_uart12_cts: qup-uart12-cts-state {
 				pins = "gpio48";
 				function = "qup14";
 			};
 
-			qup_uart12_rts: qup-uart12-rts-pins {
+			qup_uart12_rts: qup-uart12-rts-state {
 				pins = "gpio49";
 				function = "qup14";
 			};
 
-			qup_uart12_tx: qup-uart12-tx-pins {
+			qup_uart12_tx: qup-uart12-tx-state {
 				pins = "gpio50";
 				function = "qup14";
 			};
 
-			qup_uart12_rx: qup-uart12-rx-pins {
+			qup_uart12_rx: qup-uart12-rx-state {
 				pins = "gpio51";
 				function = "qup14";
 			};
 
-			qup_uart13_cts: qup-uart13-cts-pins {
+			qup_uart13_cts: qup-uart13-cts-state {
 				pins = "gpio52";
 				function = "qup15";
 			};
 
-			qup_uart13_rts: qup-uart13-rts-pins {
+			qup_uart13_rts: qup-uart13-rts-state {
 				pins = "gpio53";
 				function = "qup15";
 			};
 
-			qup_uart13_tx: qup-uart13-tx-pins {
+			qup_uart13_tx: qup-uart13-tx-state {
 				pins = "gpio54";
 				function = "qup15";
 			};
 
-			qup_uart13_rx: qup-uart13-rx-pins {
+			qup_uart13_rx: qup-uart13-rx-state {
 				pins = "gpio55";
 				function = "qup15";
 			};
 
-			qup_uart14_cts: qup-uart14-cts-pins {
+			qup_uart14_cts: qup-uart14-cts-state {
 				pins = "gpio56";
 				function = "qup16";
 			};
 
-			qup_uart14_rts: qup-uart14-rts-pins {
+			qup_uart14_rts: qup-uart14-rts-state {
 				pins = "gpio57";
 				function = "qup16";
 			};
 
-			qup_uart14_tx: qup-uart14-tx-pins {
+			qup_uart14_tx: qup-uart14-tx-state {
 				pins = "gpio58";
 				function = "qup16";
 			};
 
-			qup_uart14_rx: qup-uart14-rx-pins {
+			qup_uart14_rx: qup-uart14-rx-state {
 				pins = "gpio59";
 				function = "qup16";
 			};
 
-			qup_uart15_cts: qup-uart15-cts-pins {
+			qup_uart15_cts: qup-uart15-cts-state {
 				pins = "gpio60";
 				function = "qup17";
 			};
 
-			qup_uart15_rts: qup-uart15-rts-pins {
+			qup_uart15_rts: qup-uart15-rts-state {
 				pins = "gpio61";
 				function = "qup17";
 			};
 
-			qup_uart15_tx: qup-uart15-tx-pins {
+			qup_uart15_tx: qup-uart15-tx-state {
 				pins = "gpio62";
 				function = "qup17";
 			};
 
-			qup_uart15_rx: qup-uart15-rx-pins {
+			qup_uart15_rx: qup-uart15-rx-state {
 				pins = "gpio63";
 				function = "qup17";
 			};
 
-			sdc1_clk: sdc1-clk-pins {
+			sdc1_clk: sdc1-clk-state {
 				pins = "sdc1_clk";
 			};
 
-			sdc1_cmd: sdc1-cmd-pins {
+			sdc1_cmd: sdc1-cmd-state {
 				pins = "sdc1_cmd";
 			};
 
-			sdc1_data: sdc1-data-pins {
+			sdc1_data: sdc1-data-state {
 				pins = "sdc1_data";
 			};
 
-			sdc1_rclk: sdc1-rclk-pins {
+			sdc1_rclk: sdc1-rclk-state {
 				pins = "sdc1_rclk";
 			};
 
-			sdc1_clk_sleep: sdc1-clk-sleep-pins {
+			sdc1_clk_sleep: sdc1-clk-sleep-state {
 				pins = "sdc1_clk";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc1_cmd_sleep: sdc1-cmd-sleep-pins {
+			sdc1_cmd_sleep: sdc1-cmd-sleep-state {
 				pins = "sdc1_cmd";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc1_data_sleep: sdc1-data-sleep-pins {
+			sdc1_data_sleep: sdc1-data-sleep-state {
 				pins = "sdc1_data";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc1_rclk_sleep: sdc1-rclk-sleep-pins {
+			sdc1_rclk_sleep: sdc1-rclk-sleep-state {
 				pins = "sdc1_rclk";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc2_clk: sdc2-clk-pins {
+			sdc2_clk: sdc2-clk-state {
 				pins = "sdc2_clk";
 			};
 
-			sdc2_cmd: sdc2-cmd-pins {
+			sdc2_cmd: sdc2-cmd-state {
 				pins = "sdc2_cmd";
 			};
 
-			sdc2_data: sdc2-data-pins {
+			sdc2_data: sdc2-data-state {
 				pins = "sdc2_data";
 			};
 
-			sdc2_clk_sleep: sdc2-clk-sleep-pins {
+			sdc2_clk_sleep: sdc2-clk-sleep-state {
 				pins = "sdc2_clk";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc2_cmd_sleep: sdc2-cmd-sleep-pins {
+			sdc2_cmd_sleep: sdc2-cmd-sleep-state {
 				pins = "sdc2_cmd";
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
 
-			sdc2_data_sleep: sdc2-data-sleep-pins {
+			sdc2_data_sleep: sdc2-data-sleep-state {
 				pins = "sdc2_data";
 				drive-strength = <2>;
 				bias-bus-hold;
-- 
2.34.1

