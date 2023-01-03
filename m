Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFDC65B8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjACBKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbjACBJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5401958A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 17:09:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jo4so70149727ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 17:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITVfpdPf3a310VIwKg2KFOluTJMzjEvedNkW7y9+Vdk=;
        b=VmW8Gfd0wckTayEMmBn3snBAiIRv9OD2/IpQmGjjvv9+TTvbOZekAqBlZeK1Zbf2XQ
         6aeYYzRpqCMAu8i9TiM5eZiMBaBh/VRe1PXIyLyx3wawz8PFPyEufxf4xqKaXBIHDCF4
         /wYGoVL2Pf0c4n4l8ncFqUZvfhVlORH1ByU5TuSgnQhyXU2y0aRzhI6Cux/raQKoQtjF
         YfFfxhG2yMmc67avZDAnq0Nzo7RHOB7p3FwWBzi65twrRnc+fE0AhMOPxEtlDco4+rKi
         FK6NJez318LqoiqzUd4IoYc2BnH2MZfve69LZ+MUa46RoK7NGf92Pku+b28w6mPKah4X
         YPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITVfpdPf3a310VIwKg2KFOluTJMzjEvedNkW7y9+Vdk=;
        b=7ESRyj7djVlrXnioYsYU6L3Cco3nv96+ALjHiWUzCAYuzNRcKm9294pZvapoAAeWwC
         NQ6tIK2x6jkA5WDTFAUAtWNHEfguawfbOKvbCjc4+1fNjO98X88o5icQE7/spLS0M/xr
         sg6I27PIVnq312mfXHithhAcNDtTBiVmOn+2jvaN4uYG7cGLZ8wysVM9b+R/RdlFcmKH
         gZVhZJN5mqTVWl83mJh1Gj54sJzxpBGhKHZ1ZSD197UF4g9nj+ybr2nQ1hN0mgM5a7JV
         q6e6DPF0XpJZnYgjKHsEzC4NBVXUELYROlft2l73kx4cdlN4s+TbZs3ijazGn+k8tW77
         AFyw==
X-Gm-Message-State: AFqh2krbhO6Pe5LIgZaCaTMskP9A8g+AE1qhAsWsf2fDdDY1Qqg19ZBU
        tJym5cHHpdwpkAvKPtUWLNO4Hw==
X-Google-Smtp-Source: AMrXdXsIavLhdyrkkKlCCEogDd5BW8O6PongdBy9DGRDLT/D/0nLltdVq8jzagfBcGAxmoLqEhpU4A==
X-Received: by 2002:a17:906:6d97:b0:81d:3231:591e with SMTP id h23-20020a1709066d9700b0081d3231591emr37132223ejt.49.1672708157226;
        Mon, 02 Jan 2023 17:09:17 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-b443-9db7-1e5c-4fd5.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:b443:9db7:1e5c:4fd5])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b008302732f569sm13564648ejn.78.2023.01.02.17.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:09:16 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v2 7/7] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Date:   Tue,  3 Jan 2023 01:09:04 +0000
Message-Id: <20230103010904.3201835-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
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

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 472 ++++++++++++++++++
 2 files changed, 473 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 8d8dab62c66df..7056036351df8 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
new file mode 100644
index 0000000000000..ff93b69bda679
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -0,0 +1,472 @@
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
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	model = "Sony Xperia M4 Aqua";
+	compatible = "sony,kanuti-tulip", "qcom,msm8939";
+	qcom,board-id = <8 0>;
+
+	aliases {
+		serial0 = &blsp1_uart2;
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	negative5_reg: negative5-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&negative5_reg_default>;
+		regulator-name = "negative5_reg";
+		gpio = <&msmgpio 17 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <0>;
+	};
+
+	positive5_reg: positive5-regulator {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&positive5_reg_default>;
+		regulator-name = "positive5_reg";
+		gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <0>;
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_id_default>;
+	};
+};
+
+&blsp_dma {
+	status = "okay";
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	vdda-supply = <&pm8916_l2>;
+	vddio-supply = <&pm8916_l16>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&panel_in>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+
+	panel@0 {
+		compatible = "sony,tulip-truly-nt35521";
+		reg = <0>;
+		positive5-supply = <&positive5_reg>;
+		negative5-supply = <&negative5_reg>;
+		reset-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&msmgpio 10 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				panel_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+		};
+
+	};
+};
+
+&dsi_phy0 {
+	vddio-supply = <&pm8916_l16>;
+	status = "okay";
+};
+
+&msmgpio {
+
+	ak8963_default: ak8963-default-state {
+		pins = "gpio69";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	ak8963_sleep: ak8963-sleep-state {
+		pins = "gpio69";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	/* Ambient light and proximity sensor apds9930 and apds9900 */
+	apds99xx_default: apds99xx-default-state {
+		pins = "gpio113";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	apds99xx_sleep: apds99xx-sleep-state {
+		pins = "gpio113";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
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
+		drive-strength = <2>;
+		bias-disable;
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
+		drive-strength = <2>;
+		bias-disable;
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
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	cross_conn_det_act: lines-on-state {
+		pins = "gpio120";
+		function = "gpio";
+		drive-strength = <8>;
+		output-low;
+		bias-pull-down;
+	};
+
+	cross_conn_det_sus: lines-off-state {
+		pins = "gpio120";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
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
+		drive-strength = <8>;
+	};
+
+	ext_cdc_tlmm_lines_sus: tlmm-lines-off-state {
+		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	gpio_key_suspend: gpio-key-suspend-state {
+		pins = "gpio107", "gpio108", "gpio109";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
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
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	mpu6050_sleep: mpu6050-sleep-state {
+		pins = "gpio115";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	nfc_disable_active: nfc-disable-active-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_disable_suspend: nfc-disable-suspend-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	nfc_int_active: nfc-int-active-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_int_suspend: nfc-int-suspend-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nt35521_te_default: nt35521-te-default-state {
+		pins = "gpio24";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-down;
+	};
+
+	nt35521_backlight: nt35521-backlight-default-state {
+		pins = "gpio10";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-down;
+	};
+
+	smb_int: smb-int-default-state {
+		pins = "gpio62";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	/* add pingrp for touchscreen */
+	ts_int_active: ts-int-active-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+	};
+
+	ts_int_suspend: ts-int-suspend-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_reset_active: ts-reset-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+	};
+
+	ts_reset_suspend: ts-reset-suspend-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	ts_release: ts-release-default-state {
+		pins = "gpio13", "gpio12";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};
+
+&pronto {
+	status = "okay";
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
+		regulator-max-microvolt = <2950000>;
+	};
+
+	pm8916_l12: l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
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
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
+	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+	extcon = <&usb_id>, <&usb_id>;
+
+	ulpi {
+		usb_hs_phy: phy {
+			v1p8-supply = <&pm8916_l7>;
+			v3p3-supply = <&pm8916_l13>;
+		};
+	};
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
-- 
2.34.1

