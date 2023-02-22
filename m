Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D369F401
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjBVMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjBVMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:05:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5713A0A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:04:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so211515wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/tJ2JMtTtWdrvRORgn45WjOaYptTrhld5Ae5l8mf8Y=;
        b=zd37dD/y6/90tOjmHv/IMzqn3bfjhlJzajgQ4iUiOFJVeWHB8Gl+MSF1TIVp3qDgIv
         DrOx58WZVVD91y4eLQcwE0uexElRYkKI6XTr5dl4ZydykWe9jIz9ZZVPpvnlcyEkUGgw
         jcPaGF+RFfAJPrVM6M1jZ6fbIn7QJcWu7xvVQsc5CCakQb+6WajNFIzI86OEny8sLyD5
         84vPXAXhrFwyqVtXpl8ImZDbis7HljMckmcQxJul/nZeu1X2G2aqvhlz4QJBxYkzDn6d
         kH5K48xSYH0sSoDaFbpYi3dKoYG1pXLRcLYSVqANou40PYBuPEoC71l+59Fo7zHuh63v
         QLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/tJ2JMtTtWdrvRORgn45WjOaYptTrhld5Ae5l8mf8Y=;
        b=pfOxxPPI+6srRixCMSWfRpT60jKqMnn2Bj2kiilr0hbryVVBauhLG47CvX5uF26vPL
         EERgr2VJI8olQKY6YHSdu1xjj01AeA3HNGwMY36LSmyaYDcIuVfJoMZwF9+we2INEBjp
         i692NmBYbR6fkRCsm9jzTjROwNqANK1jjX9xWA+w67aSYX++1dS3ZigWzCsgEuCjKBbo
         3hkPLowk7QFvfvpHOmLOl5YsSsIS6p5/ITU3pHOQ004o63SRMLCMK+tBfP8KTrfZq2KH
         xtoj0e1Zo76W6gjWYJR/VkJwRUd/eAcX3nXwv0CB2nxBYThhMzLfw4R4pef1U7iS5EZU
         ChDg==
X-Gm-Message-State: AO0yUKUd7S6vkQle5FZBWXhMSvk13B+NgPcKP/OWeITBGDCZv+Oc6PU5
        A4Vnf2gf1aNVgWGTA3FJNw2C+g==
X-Google-Smtp-Source: AK7set962qevwX6vz+Ko3a2VfC9xKMIIiysXs3OLv/F3ex27CMOwdB4nF7h3GBs0SDsuIZ0LwfFRnQ==
X-Received: by 2002:a05:600c:16c7:b0:3de:e8c5:d826 with SMTP id l7-20020a05600c16c700b003dee8c5d826mr252196wmn.28.1677067462726;
        Wed, 22 Feb 2023 04:04:22 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003e21dcccf9fsm8447722wms.16.2023.02.22.04.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:04:22 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v6 5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Date:   Wed, 22 Feb 2023 12:04:11 +0000
Message-Id: <20230222120411.55197-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
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

Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".

Tulip is paired with:

- wcn3660
- smb1360 battery charger
- 720p Truly NT35521 Panel

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 457 ++++++++++++++++++
 2 files changed, 458 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2983e83a19061..81a38d46deba5 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
new file mode 100644
index 0000000000000..c646fada11a5a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -0,0 +1,457 @@
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
+&mdss {
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

