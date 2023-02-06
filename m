Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A017F68B3C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBFBYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBFBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:24:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5117CD4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:23:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o18so9040691wrj.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgNkNRM3gGxKpRD4nltOVcRvNmKzWb32K7gQhj17aZs=;
        b=MvJ391++Yf6eH9WVnFwexBTc3Q++LRdE3NDzBybld/A6A4YqBx8tC/gXpvIk7IKriG
         ufZvyXUF1Li3+TgH9k5K+RocGwK2uiIhYWu8wi3pGvZsAMjlSlbbPSDupg938YIouNx5
         o/dSpfavethlX35xspfdmTIBvXU+05oSZULt/NDEk5cNDy2xKNqMGNwAAKLUKFPf6Acc
         bECFWks2g1T0TRkxPzMSrG7P+19wv0cDsXw3Ky1Ake9Kbb2IM9i5mZwmFnLQVwHhyIhq
         Bor/otOlz7r/+a/Jp8G7hYCm8WcDnMICqiuyrEVhHrNGgvys9Y+uOot8z/33QiBBR73v
         pRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgNkNRM3gGxKpRD4nltOVcRvNmKzWb32K7gQhj17aZs=;
        b=vRoCur2GfyXPGtL6J9wlbAelBedCfHChRZCIk/HvupcKNbUvSHvJcwmp3ZuJYAkPrS
         jvJOJVdRJawSv9E8daYnAsbLb70Lnco4D86LOBEBXg+/vdDTIiKxAtq71PEd/b4HTlxH
         yePxeqqRvcAkF8zDVna+mHXLWvGhmceCAMVxbK2pgzFKh56zZc0CA1vjk/xgSHTxthz/
         6PcTzVsKueaquaKPeNoGd8YkGQhiV0RpqfoKJoV6Jfn+aQorvhAIYZvz7lj9zxXha2jS
         P90AarQWejt7O/UTB9yD35tZjcEE0Hx/q9XiSoNWeYa4VNZh9tcDrr8sRRwMN5Pmsg/w
         Yl8Q==
X-Gm-Message-State: AO0yUKUJl1ERKmx4Mdn+6uA1/Qtl2kG8zsKE/bTBA2rsvwvmJqZEUhqF
        y1kFA3L/T31KXQwMiOF+E4hSLw==
X-Google-Smtp-Source: AK7set84lje3rO1+6cWGaXEn0viLI96IMqRdGAN8ikN8RKp50DPc+7tTH3WfmL15fQHbwN5Mm2qclw==
X-Received: by 2002:a05:6000:184a:b0:2bf:d6fc:580d with SMTP id c10-20020a056000184a00b002bfd6fc580dmr19080106wri.69.1675646635427;
        Sun, 05 Feb 2023 17:23:55 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b002bddd75a83fsm8048027wri.8.2023.02.05.17.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 17:23:55 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v5 5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Date:   Mon,  6 Feb 2023 01:23:36 +0000
Message-Id: <20230206012336.2130341-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
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

Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".

Tulip is paired with:

- wcn3660
- smb1360 battery charger
- 720p Truly NT35521 Panel

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 453 ++++++++++++++++++
 2 files changed, 454 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b85a11f00cea3..421ac9be060c9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5x.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
new file mode 100644
index 0000000000000..029c027ff4fa3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Bryan O'Donoghue.
+ *
+ */
+
+/dts-v1/;
+
+#include "msm8939.dtsi"
+#include "msm8939-pm8916.dtsi"
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	model = "Sony Xperia M4 Aqua";
+	compatible = "sony,kanuti-tulip", "qcom,msm8939";
+
+	qcom,board-id = <8 0>;
+	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>;
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	vreg_negative5_reg: negative5-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&negative5_reg_default>;
+		pinctrl-names = "default";
+		regulator-name = "negative5_reg";
+		gpio = <&tlmm 17 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <0>;
+	};
+
+	vreg_positive5_reg: positive5-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&positive5_reg_default>;
+		pinctrl-names = "default";
+		regulator-name = "positive5_reg";
+		gpio = <&tlmm 114 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <0>;
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&dsi0 {
+	status = "okay";
+
+	panel@0 {
+		compatible = "sony,tulip-truly-nt35521";
+		reg = <0>;
+		positive5-supply = <&vreg_positive5_reg>;
+		negative5-supply = <&vreg_negative5_reg>;
+		reset-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&tlmm 10 GPIO_ACTIVE_LOW>;
+
+		ports {
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+		};
+
+	};
+};
+
+&dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&dsi_phy0 {
+	qcom,dsi-phy-regulator-ldo-mode;
+	status = "okay";
+};
+
+&tlmm {
+	ak8963_default: ak8963-default-state {
+		pins = "gpio69";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <6>;
+	};
+
+	ak8963_sleep: ak8963-sleep-state {
+		pins = "gpio69";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	/* Ambient light and proximity sensor apds9930 and apds9900 */
+	apds99xx_default: apds99xx-default-state {
+		pins = "gpio113";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <6>;
+	};
+
+	apds99xx_sleep: apds99xx-sleep-state {
+		pins = "gpio113";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	cam_sensor_flash_default: cam-sensor-flash-default-state {
+		pins = "gpio98", "gpio97";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cci1_default: cci1-default-state {
+		pins = "gpio31", "gpio32";
+		function = "cci_i2c";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cdc_ext_spk_pa_active: cdc-ext-spk-pa-on-state {
+		pins = "gpio0";
+		function = "gpio";
+		drive-strength = <8>;
+		output-low;
+	};
+
+	cdc_ext_spk_pa_sus: cdc-ext-spk-pa-off-state {
+		pins = "gpio0";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cdc_slim_lines_act: lines-on-state {
+		pins = "gpio63";
+		function = "cdc_pdm0";
+		drive-strength = <8>;
+		output-high;
+	};
+
+	cdc_slim_lines_sus: lines-off-state {
+		pins = "gpio63";
+		function = "cdc_pdm0";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cross_conn_det_act: lines-on-state {
+		pins = "gpio120";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <8>;
+		output-low;
+	};
+
+	cross_conn_det_sus: lines-off-state {
+		pins = "gpio120";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	ext_buck_vsel: vsel0-state {
+		pins = "gpio111";
+		function = "gpio";
+		drive-strength = <2>;
+	};
+
+	ext_cdc_tlmm_lines_act: tlmm-lines-on-state {
+		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <8>;
+	};
+
+	ext_cdc_tlmm_lines_sus: tlmm-lines-off-state {
+		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	gpio_key_suspend: gpio-key-suspend-state {
+		pins = "gpio107", "gpio108", "gpio109";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+
+	negative5_reg_default: negative5-reg-default-state {
+		pins = "gpio17";
+		function = "gpio";
+		output-low;
+	};
+
+	positive5_reg_default: positive5-reg-default-state {
+		pins = "gpio114";
+		function = "gpio";
+		output-low;
+	};
+
+	/* Gyroscope and accelerometer sensor combo */
+	mpu6050_default: mpu6050-default-state {
+		pins = "gpio115";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <6>;
+	};
+
+	mpu6050_sleep: mpu6050-sleep-state {
+		pins = "gpio115";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	nfc_disable_active: nfc-disable-active-state {
+		pins = "gpio20";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <6>;
+	};
+
+	nfc_disable_suspend: nfc-disable-suspend-state {
+		pins = "gpio20";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <6>;
+	};
+
+	nfc_int_active: nfc-int-active-state {
+		pins = "gpio21";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <6>;
+	};
+
+	nfc_int_suspend: nfc-int-suspend-state {
+		pins = "gpio21";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <6>;
+	};
+
+	nt35521_te_default: nt35521-te-default-state {
+		pins = "gpio24";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <6>;
+	};
+
+	nt35521_backlight: nt35521-backlight-default-state {
+		pins = "gpio10";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <6>;
+	};
+
+	smb_int: smb-int-default-state {
+		pins = "gpio62";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+
+	ts_int_active: ts-int-active-state {
+		pins = "gpio13";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <16>;
+	};
+
+	ts_int_suspend: ts-int-suspend-state {
+		pins = "gpio13";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	ts_reset_active: ts-reset-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <16>;
+	};
+
+	ts_reset_suspend: ts-reset-suspend-state {
+		pins = "gpio12";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	ts_release: ts-release-default-state {
+		pins = "gpio13", "gpio12";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <8>;
+	};
+};
+
+&pronto {
+	status = "okay";
+
+	iris {
+		compatible = "qcom,wcn3660";
+	};
+};
+
+&smd_rpm_regulators {
+	vdd_l1_l2_l3-supply = <&pm8916_s3>;
+	vdd_l4_l5_l6-supply = <&pm8916_s4>;
+	vdd_l7-supply = <&pm8916_s4>;
+
+	pm8916_s3: s3 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1300000>;
+	};
+
+	pm8916_s4: s4 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2100000>;
+	};
+
+	pm8916_l2: l2 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	pm8916_l4: l4 {
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
+	};
+
+	pm8916_l5: l5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l6: l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	pm8916_l7: l7 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l8: l8 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	pm8916_l9: l9 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l10: l10 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l11: l11 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-system-load = <200000>;
+		regulator-allow-set-load;
+	};
+
+	pm8916_l12: l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l13: l13 {
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
+	};
+
+	pm8916_l14: l14 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l15: l15 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+
+	pm8916_l18: l18 {
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+	};
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc1_default_state>;
+	pinctrl-1 = <&sdc1_sleep_state>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_default_state>;
+	pinctrl-1 = <&sdc2_sleep_state>;
+	pinctrl-names = "default", "sleep";
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usb {
+	extcon = <&usb_id>, <&usb_id>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
-- 
2.39.1

