Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9685FA147
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJJPk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJJPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:40:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEBF5AC5B;
        Mon, 10 Oct 2022 08:40:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so17593027wrp.10;
        Mon, 10 Oct 2022 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvj/x6rn3XqRrfvMANunCrJNgaDkBBG1HLRWgLFCCts=;
        b=lJHwqXswiUw8wmntvHRyX5e00ZfYBN/jRYxQYlfybGcqaVWFnHToGxSxuvhYf2GaPR
         htU5vweXXw2LHTGgy9OULSRtEHDexsMMdzKM45eBChswWCcNMZqX2DU8JLVCUzhAcYuE
         Py5vQvP9EjSL+afmQsbu2bMkupnM7o+c6jvAjqzIwDcd6m+Fcr9Kx129Pf8zaYwPx/jP
         qFQgcjwnTHlan1Ecr9k9UcV1jdSceg0uNAyISAXzyXOFFzNYzc4ddEpKHDpclYggc271
         BkdjJ6CPt0k0EQ2M4c99TMCErWDLOVgX4G+OkzenOBVfEBidHv6CvAn+U/Y7tEiCXbA9
         IyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvj/x6rn3XqRrfvMANunCrJNgaDkBBG1HLRWgLFCCts=;
        b=7hPvHjNd6DTcxsLXjGLSiKCffpzDBb62NZlHEwgIjOASsr+KsaKZzpBMrjYo1I9KJ7
         5Xw5QQWJYg0fBRDJ0mV3oGqYSsN2R7D/dN6yLygWzeCdOv2lE/LA624ougBirKO4K4sC
         VUzgEvGFi+qzX69pzKN7APdQMZ9fyWJQfzA+YLbQTINowHdtPCSEDd3CPSWUi7Zkme40
         CWjNmQ7V1YEO4vagF1hefzObillelXdoLDrpzzpm/s55wGabYsig88ABV9mf2MddD494
         +PylYOoJV1WGjnsi/AD2LXpWpiKP3gRur9KnwfQttjgabCeem0qqT5Bqg7eHcoJnPL+u
         FL3g==
X-Gm-Message-State: ACrzQf1FwiGB4JT6tErSc5bOaxJcMXg2nENxLsiXgBr11juZFJLJ60YR
        vLY3tCeJgrJjLQsd889kOTSlwIVeVp0=
X-Google-Smtp-Source: AMsMyM7utC3hQFVO5wJICbF1mAHFxmAoVJUd7WzHjKCWnjncqXoZ8r///BfzD5ecf2URQ5+YPy6Qzw==
X-Received: by 2002:a5d:4dc1:0:b0:22e:461:dcf3 with SMTP id f1-20020a5d4dc1000000b0022e0461dcf3mr12218387wru.42.1665416445409;
        Mon, 10 Oct 2022 08:40:45 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id b2-20020adff902000000b0022e66749437sm9068321wrr.93.2022.10.10.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:40:45 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v8 2/2] arm64: dts: qcom: sagit: add initial device tree for sagit
Date:   Mon, 10 Oct 2022 18:40:39 +0300
Message-Id: <20221010154039.1144605-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221010154039.1144605-1-dsankouski@gmail.com>
References: <20221010154039.1144605-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New device support - Xiaomi Mi6 phone

What works:
- storage
- usb
- power regulators

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v2:
- remove memory nodes before redefining
- add board compatible to schema
- remove board msm-id, add chassis type
- remove common dtsi
- move resin to pm8998 dtsi file
- dts formatting
- unsupported properties removed
- add copyright
- rebase on latest master(6.0.0-rc6)
Changes for v3:
- regulators nodes renamed to match pattern 'regulators-[01]'
- duplicate cci1-default node deleted
- add state suffix to '.*(active|suspend|default)' pinctrl
- rebase on latest master(6.0.0)
Changes for v4:
- fix dts compilation errors(rename pinctrl label usages)
Changes for v5:
- use pm8005_regulators label
Changes for v6:
- add state suffix to all pinctrl
- move status nodes to last position
- disable resin node by default
- move the debounce param to pm8998.dtsi file
- place this patch after dt-binding patch
Changes for v7:
- fix Properties must precede subnodes dts compilation error
Changes for v8:
- enable resin node
- rename nodes in reserved memory to comply with 'memory@.*' pattern

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 682 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
 3 files changed, 691 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1d86a33de528..0460aabf1b59 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-dumpling.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
new file mode 100644
index 000000000000..aa5bf48e0ab8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Xiaomi Mi 6 (sagit) device tree source based on msm8998-mtp.dtsi
+ *
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Degdag Mohamed <degdagmohamed@gmail.com>
+ * Copyright (c) 2022, Dzmitry Sankouski <dsankouski@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "msm8998.dtsi"
+#include "pm8005.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/*
+ * Delete following upstream (msm8998.dtsi) reserved
+ * memory mappings which are different in this device.
+ */
+/delete-node/ &mpss_mem;
+/delete-node/ &venus_mem;
+/delete-node/ &mba_mem;
+/delete-node/ &slpi_mem;
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &ipa_gsi_mem;
+/delete-node/ &gpu_mem;
+/delete-node/ &wlan_msa_mem;
+
+/ {
+	model = "Xiaomi Mi 6";
+	compatible = "xiaomi,sagit", "qcom,msm8998";
+	chassis-type = "handset";
+	/* Required for bootloader to select correct board */
+	qcom,board-id = <30 0>;
+
+	reserved-memory {
+		/*
+		 * The following memory regions on downstream are "dynamically allocated"
+		 * but given the same addresses every time. Hard code them as these addresses
+		 * are where the Xiaomi signed firmware expects them to be.
+		 */
+		ipa_fws_region: memory@f7800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xf7800000 0x0 0x5000>;
+			no-map;
+		};
+
+		zap_shader_region: memory@f7900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xf7900000 0x0 0x2000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8d000000 {
+			reg = <0x0 0x8d000000 0x0 0x7000000>;
+			no-map;
+		};
+
+		venus_mem: memory@94000000 {
+			reg = <0x0 0x94000000 0x0 0x500000>;
+			no-map;
+		};
+
+		mba_mem: memory@94500000 {
+			reg = <0x0 0x94500000 0x0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: memory@94700000 {
+			reg = <0x0 0x94700000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@95600000 {
+			reg = <0x0 0x95600000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@95610000 {
+			reg = <0x0 0x95610000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@95615000 {
+			reg = <0x0 0x95615000 0x0 0x100000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@95715000 {
+			reg = <0x0 0x95715000 0x0 0x100000>;
+			no-map;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "Volume buttons";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_key_default>;
+
+		key-vol-up {
+			label = "Volume up";
+			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+			wakeup-source;
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+		label = "Hall effect sensor";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hall_sensor_default_state>;
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	disp_vddts_vreg: disp-vddts-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "disp-vddts-regulator";
+		gpio = <&tlmm 50 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&blsp1_i2c5 {
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ts_active_state>;
+		pinctrl-1 = <&ts_int_suspend_state &ts_reset_suspend_state>;
+
+		vdd-supply = <&disp_vddts_vreg>;
+		vio-supply = <&vreg_l6a_1p8>;
+
+		syna,reset-delay-ms = <20>;
+		syna,startup-delay-ms = <20>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			touchscreen-x-mm = <64>;
+			touchscreen-y-mm = <114>;
+			syna,sensor-type = <1>;
+			syna,rezero-wait-ms = <20>;
+		};
+
+		rmi4-f1a@1a {
+			reg = <0x1a>;
+			syna,codes = <KEY_BACK KEY_APPSELECT>;
+		};
+	};
+};
+
+&blsp1_i2c5_sleep {
+	/delete-property/ bias-pull-up;
+	bias-disable;
+};
+
+&blsp1_uart3 {
+	status = "okay";
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&blsp1_uart3_on {
+	rx {
+		/delete-property/ bias-disable;
+		/*
+		 * Configure a pull-up on 46 (RX). This is needed to
+		 * avoid garbage data when the TX pin of the Bluetooth
+		 * module is in tri-state (module powered off or not
+		 * driving the signal yet).
+		 */
+		bias-pull-up;
+	};
+
+	cts {
+		/delete-property/ bias-disable;
+		/*
+		 * Configure a pull-down on 47 (CTS) to match the pull
+		 * of the Bluetooth module.
+		 */
+		bias-pull-down;
+	};
+};
+
+&blsp2_uart1 {
+	status = "okay";
+};
+
+&pm8005_regulators {
+	compatible = "qcom,pm8005-regulators";
+
+	vdd_s1-supply = <&vph_pwr>;
+
+	pm8005_s1: s1 { /* VDD_GFX supply */
+		regulator-min-microvolt = <524000>;
+		regulator-max-microvolt = <1100000>;
+		regulator-enable-ramp-delay = <500>;
+
+		/* hack until we rig up the gpu consumer */
+		regulator-always-on;
+	};
+};
+
+&pm8998_gpio {
+	vol_up_key_default: vol-up-key-default-state {
+		pins = "gpio6";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+
+	audio_mclk_pin: audio-mclk-pin-active-state {
+		pins = "gpio13";
+		function = "func2";
+		power-source = <0>;
+	};
+};
+
+&qusb2phy {
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm8998-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_s8-supply = <&vph_pwr>;
+		vdd_s9-supply = <&vph_pwr>;
+		vdd_s10-supply = <&vph_pwr>;
+		vdd_s11-supply = <&vph_pwr>;
+		vdd_s12-supply = <&vph_pwr>;
+		vdd_s13-supply = <&vph_pwr>;
+		vdd_l1_l27-supply = <&vreg_s7a_1p025>;
+		vdd_l2_l8_l17-supply = <&vreg_s3a_1p35>;
+		vdd_l3_l11-supply = <&vreg_s7a_1p025>;
+		vdd_l4_l5-supply = <&vreg_s7a_1p025>;
+		vdd_l6-supply = <&vreg_s5a_2p04>;
+		vdd_l7_l12_l14_l15-supply = <&vreg_s5a_2p04>;
+		vdd_l9-supply = <&vreg_bob>;
+		vdd_l10_l23_l25-supply = <&vreg_bob>;
+		vdd_l13_l19_l21-supply = <&vreg_bob>;
+		vdd_l16_l28-supply = <&vreg_bob>;
+		vdd_l18_l22-supply = <&vreg_bob>;
+		vdd_l20_l24-supply = <&vreg_bob>;
+		vdd_l26-supply = <&vreg_s3a_1p35>;
+		vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
+
+		vreg_s3a_1p35: s3 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_s4a_1p8: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_s5a_2p04: s5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s7a_1p025: s7 {
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1028000>;
+		};
+
+		vreg_l1a_0p875: l1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+		};
+
+		vreg_l2a_1p2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_l3a_1p0: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a_0p8: l5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		vreg_l6a_1p8: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l7a_1p8: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l8a_1p2: l8 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l11a_1p0: l11 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l13a_2p95: l13 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l14a_1p8: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l15a_1p8: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l16a_2p7: l16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+		};
+
+		vreg_l17a_1p3: l17 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l18a_2p7: l18 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+		};
+
+		vreg_l19a_3p0: l19 {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+		};
+
+		vreg_l20a_2p95: l20 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l21a_2p95: l21 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-system-load = <800000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l22a_2p85: l22 {
+			regulator-min-microvolt = <2864000>;
+			regulator-max-microvolt = <2864000>;
+		};
+
+		vreg_l23a_3p3: l23 {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3312000>;
+		};
+
+		vreg_l24a_3p075: l24 {
+			regulator-min-microvolt = <3088000>;
+			regulator-max-microvolt = <3088000>;
+		};
+
+		vreg_l25a_3p3: l25 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3312000>;
+		};
+
+		vreg_l26a_1p2: l26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l28_3p0: l28 {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+		};
+
+		vreg_lvs1a_1p8: lvs1 { };
+
+		vreg_lvs2a_1p8: lvs2 { };
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pmi8998-regulators";
+
+		vdd_bob-supply = <&vph_pwr>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	cci1_default_state: cci1-default-state {
+		pins = "gpio19", "gpio20";
+		function = "cci_i2c";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cdc_reset_n_state: cdc-reset-n-state {
+		pins = "gpio64";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <16>;
+		output-high;
+	};
+
+	hall_sensor_default_state: hall-sensor-default-state {
+		pins = "gpio124";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
+	mdss_dsi_active_state: mdss-dsi-active-state {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	mdss_dsi_suspend_state: mdss-dsi-suspend-state {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdss_te_active_state: mdss-te-active-state {
+		pins = "gpio10";
+		function = "mdp_vsync_a";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdss_te_suspend_state: mdss-te-suspend-state {
+		pins = "gpio10";
+		function = "mdp_vsync_a";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	msm_mclk0_active_state: msm-mclk0-active-state {
+		pins = "gpio13";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_mclk0_suspend_state: msm-mclk0-suspend-state {
+		pins = "gpio13";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	msm_mclk1_active_state: msm-mclk1-active-state {
+		pins = "gpio14";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_mclk1_suspend_state: msm-mclk1-suspend-state {
+		pins = "gpio14";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	nfc_int_active_state: nfc-int-active-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_int_suspend_state: nfc-int-suspend-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_enable_active_state: nfc-enable-active-state {
+		pins = "gpio12", "gpio116";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_enable_suspend_state: nfc-enable-suspend-state {
+		pins = "gpio12", "gpio116";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	ts_active_state: ts-active-state {
+		pins = "gpio89", "gpio125";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	ts_int_suspend_state: ts-int-suspend-state {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	ts_reset_suspend_state: ts-reset-suspend-state {
+		pins = "gpio89";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	wcd_int_n_state: wcd-int-n-state {
+		pins = "gpio54";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+		input-enable;
+	};
+
+	wsa_leftspk_pwr_n_state: wsa-leftspk-pwr-n-state {
+		pins = "gpio65";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
+	};
+
+	wsa_rightspk_pwr_n_state: wsa-rightspk-pwr-n-state {
+		pins = "gpio66";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
+	};
+};
+
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&ufshc {
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l26a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vcc-max-microamp = <750000>;
+	vccq-max-microamp = <560000>;
+	vccq2-max-microamp = <750000>;
+	status = "okay";
+};
+
+&ufsphy {
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
+	status = "okay";
+};
+
+&usb3 {
+	/* Disable USB3 clock requirement as the device only supports USB2 */
+	qcom,select-utmi-as-pipe-clk;
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	/* Drop the unused USB 3 PHY */
+	phys = <&qusb2phy>;
+	phy-names = "usb2-phy";
+
+	/* Fastest mode for USB 2 */
+	maximum-speed = "high-speed";
+
+	/* Force to peripheral until we can switch modes */
+	dr_mode = "peripheral";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index d09f2954b6f9..7929fa64e1ef 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -52,6 +52,14 @@ pm8998_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm8998_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				bias-pull-up;
+				interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				status = "disabled";
+			};
 		};
 
 		pm8998_temp: temp-alarm@2400 {
-- 
2.30.2

