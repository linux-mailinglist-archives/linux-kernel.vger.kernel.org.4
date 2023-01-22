Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCCA676DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAVO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAVO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:57:41 -0500
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 06:57:36 PST
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14E461A4AB;
        Sun, 22 Jan 2023 06:57:36 -0800 (PST)
Received: from shock.lan (2-248-191-197-no36.tbcn.telia.com [2.248.191.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 4EF221403FD;
        Sun, 22 Jan 2023 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1674399020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4+chmGhtfcgeDE2xesCbIR2C1I5TI+CP2yomJNlyFo=;
        b=TUDJqCj1csOYBG5aG4mztGO+lYCtSfb/RLxsZR4hi2nH+thcmbXALy08YkTIBDvWNKUVfc
        O/LpZk7cac+cUQZmvPKyqD6JO2ayEWegSFT9b5d1rqibNJsGZzdT7xP05NuolytxQ0b0++
        hCELBO9/Jov8JXDCJWA7GlaUrzJF9y8=
From:   Stefan Hansson <newbyte@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        matti.lehtimaki@gmail.com,
        Stefan Hansson <newbyte@postmarketos.org>
Subject: [PATCH 1/3] ARM: dts: qcom: samsung-matisse-common: Add initial common device tree
Date:   Sun, 22 Jan 2023 15:47:48 +0100
Message-Id: <20230122144749.87597-2-newbyte@postmarketos.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230122144749.87597-1-newbyte@postmarketos.org>
References: <20230122144749.87597-1-newbyte@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the dts from the kernel source code released by Samsung,
matissewifi and matisselte only have minor differences in hardware, so
use a shared dtsi to reduce duplicated code. Additionally, this should
make adding support for matisse3g easier should someone want to do that
at a later point.

As such, add a common device tree for all matisse devices by Samsung
based on the matissewifi dts. Support for matisselte will be introduced
in a later patch in this series and will use the common dtsi as well.

Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
---
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 511 +-----------------
 .../qcom-msm8226-samsung-matisse-common.dtsi  | 510 +++++++++++++++++
 2 files changed, 522 insertions(+), 499 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8226-samsung-matisse-common.dtsi

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 91b860e24681..2b03e68c8b72 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -5,516 +5,29 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-#include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
-
-/delete-node/ &adsp_region;
-/delete-node/ &smem_region;
+#include "qcom-msm8226-samsung-matisse-common.dtsi"
 
 / {
 	model = "Samsung Galaxy Tab 4 10.1";
 	compatible = "samsung,matisse-wifi", "qcom,apq8026";
 	chassis-type = "tablet";
-
-	aliases {
-		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
-		mmc1 = &sdhc_2; /* SDC2 SD card slot */
-		display0 = &framebuffer0;
-	};
-
-	chosen {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		stdout-path = "display0";
-
-		framebuffer0: framebuffer@3200000 {
-			compatible = "simple-framebuffer";
-			reg = <0x03200000 0x800000>;
-			width = <1280>;
-			height = <800>;
-			stride = <(1280 * 3)>;
-			format = "r8g8b8";
-		};
-	};
-
-	gpio-hall-sensor {
-		compatible = "gpio-keys";
-
-		event-hall-sensor {
-			label = "Hall Effect Sensor";
-			gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
-			interrupts = <&tlmm 110 IRQ_TYPE_EDGE_FALLING>;
-			linux,input-type = <EV_SW>;
-			linux,code = <SW_LID>;
-			debounce-interval = <15>;
-			wakeup-source;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-
-		key-home {
-			label = "Home";
-			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_HOMEPAGE>;
-			debounce-interval = <15>;
-		};
-
-		key-volume-down {
-			label = "Volume Down";
-			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			debounce-interval = <15>;
-		};
-
-		key-volume-up {
-			label = "Volume Up";
-			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <15>;
-		};
-	};
-
-	i2c-backlight {
-		compatible = "i2c-gpio";
-		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-
-		pinctrl-0 = <&backlight_i2c_default_state>;
-		pinctrl-names = "default";
-
-		i2c-gpio,delay-us = <4>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		backlight@2c {
-			compatible = "ti,lp8556";
-			reg = <0x2c>;
-
-			dev-ctrl = /bits/ 8 <0x80>;
-			init-brt = /bits/ 8 <0x3f>;
-			pwm-period = <100000>;
-
-			pwms = <&backlight_pwm 0 100000>;
-			pwm-names = "lp8556";
-
-			rom-a0h {
-				rom-addr = /bits/ 8 <0xa0>;
-				rom-val = /bits/ 8 <0x44>;
-			};
-
-			rom-a1h {
-				rom-addr = /bits/ 8 <0xa1>;
-				rom-val = /bits/ 8 <0x6c>;
-			};
-
-			rom-a5h {
-				rom-addr = /bits/ 8 <0xa5>;
-				rom-val = /bits/ 8 <0x24>;
-			};
-		};
-	};
-
-	backlight_pwm: pwm {
-		compatible = "clk-pwm";
-		#pwm-cells = <2>;
-		clocks = <&mmcc CAMSS_GP0_CLK>;
-		pinctrl-0 = <&backlight_pwm_default_state>;
-		pinctrl-names = "default";
-	};
-
-	reg_tsp_1p8v: regulator-tsp-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "tsp_1p8v";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-
-		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsp_en_default_state>;
-	};
-
-	reg_tsp_3p3v: regulator-tsp-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "tsp_3p3v";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsp_en1_default_state>;
-	};
-
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		framebuffer@3200000 {
-			reg = <0x03200000 0x800000>;
-			no-map;
-		};
-
-		mpss@8400000 {
-			reg = <0x08400000 0x1f00000>;
-			no-map;
-		};
-
-		mba@a300000 {
-			reg = <0x0a300000 0x100000>;
-			no-map;
-		};
-
-		reserved@cb00000 {
-			reg = <0x0cb00000 0x700000>;
-			no-map;
-		};
-
-		wcnss@d200000 {
-			reg = <0x0d200000 0x700000>;
-			no-map;
-		};
-
-		adsp_region: adsp@d900000 {
-			reg = <0x0d900000 0x1800000>;
-			no-map;
-		};
-
-		venus@f100000 {
-			reg = <0x0f100000 0x500000>;
-			no-map;
-		};
-
-		smem_region: smem@fa00000 {
-			reg = <0x0fa00000 0x100000>;
-			no-map;
-		};
-
-		reserved@fb00000 {
-			reg = <0x0fb00000 0x260000>;
-			no-map;
-		};
-
-		rfsa@fd60000 {
-			reg = <0x0fd60000 0x20000>;
-			no-map;
-		};
-
-		rmtfs@fd80000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0x0fd80000 0x180000>;
-			no-map;
-
-			qcom,client-id = <1>;
-		};
-	};
 };
 
-&adsp {
-	status = "okay";
+&pm8226_l3 {
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <1337500>;
+	regulator-always-on;
 };
 
-&blsp1_i2c2 {
-	status = "okay";
-
-	accelerometer@1d {
-		compatible = "st,lis2hh12";
-		reg = <0x1d>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&accel_int_default_state>;
-
-		st,drdy-int-pin = <1>;
-
-		vdd-supply = <&pm8226_l19>;
-		vddio-supply = <&pm8226_lvs1>;
-	};
-};
-
-&blsp1_i2c4 {
-	status = "okay";
-
-	muic: usb-switch@25 {
-		compatible = "siliconmitus,sm5502-muic";
-		reg = <0x25>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&muic_int_default_state>;
-	};
-};
-
-&blsp1_i2c5 {
-	status = "okay";
-
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsp_int_rst_default_state>;
-
-		reset-gpios = <&pm8226_gpios 6 GPIO_ACTIVE_LOW>;
-
-		vdd-supply = <&reg_tsp_1p8v>;
-		vdda-supply = <&reg_tsp_3p3v>;
-	};
-};
-
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-pm8226-regulators";
-
-		pm8226_s3: s3 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pm8226_s4: s4 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_s5: s5 {
-			regulator-min-microvolt = <1150000>;
-			regulator-max-microvolt = <1150000>;
-		};
-
-		pm8226_l1: l1 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1225000>;
-		};
-
-		pm8226_l2: l2 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8226_l3: l3 {
-			regulator-min-microvolt = <750000>;
-			regulator-max-microvolt = <1337500>;
-			regulator-always-on;
-		};
-
-		pm8226_l4: l4 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8226_l5: l5 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8226_l6: l6 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		pm8226_l7: l7 {
-			regulator-min-microvolt = <1850000>;
-			regulator-max-microvolt = <1850000>;
-		};
-
-		pm8226_l8: l8 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		pm8226_l9: l9 {
-			regulator-min-microvolt = <2050000>;
-			regulator-max-microvolt = <2050000>;
-		};
-
-		pm8226_l10: l10 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_l12: l12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_l14: l14 {
-			regulator-min-microvolt = <2750000>;
-			regulator-max-microvolt = <2750000>;
-		};
-
-		pm8226_l15: l15 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		pm8226_l16: l16 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3350000>;
-		};
-
-		pm8226_l17: l17 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-
-			regulator-system-load = <200000>;
-			regulator-allow-set-load;
-			regulator-always-on;
-		};
-
-		pm8226_l18: l18 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8226_l19: l19 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		pm8226_l20: l20 {
-			regulator-min-microvolt = <3075000>;
-			regulator-max-microvolt = <3075000>;
-		};
-
-		pm8226_l21: l21 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8226_l22: l22 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		pm8226_l23: l23 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		pm8226_l24: l24 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1350000>;
-		};
-
-		pm8226_l25: l25 {
-			regulator-min-microvolt = <1775000>;
-			regulator-max-microvolt = <2125000>;
-		};
-
-		pm8226_l26: l26 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pm8226_l27: l27 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_l28: l28 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8226_lvs1: lvs1 {};
-	};
-};
-
-&sdhc_1 {
-	vmmc-supply = <&pm8226_l17>;
-	vqmmc-supply = <&pm8226_l6>;
-
-	bus-width = <8>;
-	non-removable;
-
-	status = "okay";
-};
-
-&sdhc_2 {
-	vmmc-supply = <&pm8226_l18>;
-	vqmmc-supply = <&pm8226_l21>;
-
-	bus-width = <4>;
-	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
-
-	status = "okay";
-};
-
-&tlmm {
-	accel_int_default_state: accel-int-default-state {
-		pins = "gpio54";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	backlight_i2c_default_state: backlight-i2c-default-state {
-		pins = "gpio20", "gpio21";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	backlight_pwm_default_state: backlight-pwm-default-state {
-		pins = "gpio33";
-		function = "gp0_clk";
-	};
-
-	muic_int_default_state: muic-int-default-state {
-		pins = "gpio67";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	tsp_en_default_state: tsp-en-default-state {
-		pins = "gpio31";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	tsp_en1_default_state: tsp-en1-default-state {
-		pins = "gpio73";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	tsp_int_rst_default_state: tsp-int-rst-default-state {
-		pins = "gpio17";
-		function = "gpio";
-		drive-strength = <10>;
-		bias-pull-up;
-	};
+&pm8226_s4 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
 };
 
-&usb {
-	extcon = <&muic>, <&muic>;
-	status = "okay";
+&reg_tsp_3p3v {
+	gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
 };
 
-&usb_hs_phy {
-	extcon = <&muic>;
-	v1p8-supply = <&pm8226_l10>;
-	v3p3-supply = <&pm8226_l20>;
+&tsp_en1_default_state {
+	pins = "gpio73";
 };
diff --git a/arch/arm/boot/dts/qcom-msm8226-samsung-matisse-common.dtsi b/arch/arm/boot/dts/qcom-msm8226-samsung-matisse-common.dtsi
new file mode 100644
index 000000000000..efabc03e5db5
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8226-samsung-matisse-common.dtsi
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
+ * Copyright (c) 2023, Stefan Hansson <newbyte@postmarketos.org>
+ */
+
+#include <dt-bindings/input/input.h>
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/delete-node/ &adsp_region;
+/delete-node/ &smem_region;
+
+/ {
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		display0 = &framebuffer0;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		stdout-path = "display0";
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x03200000 0x800000>;
+			width = <1280>;
+			height = <800>;
+			stride = <(1280 * 3)>;
+			format = "r8g8b8";
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+			interrupts = <&tlmm 110 IRQ_TYPE_EDGE_FALLING>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			debounce-interval = <15>;
+			wakeup-source;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		key-home {
+			label = "Home";
+			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	i2c-backlight {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-0 = <&backlight_i2c_default_state>;
+		pinctrl-names = "default";
+
+		i2c-gpio,delay-us = <4>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x3f>;
+			pwm-period = <100000>;
+
+			pwms = <&backlight_pwm 0 100000>;
+			pwm-names = "lp8556";
+
+			rom-a0h {
+				rom-addr = /bits/ 8 <0xa0>;
+				rom-val = /bits/ 8 <0x44>;
+			};
+
+			rom-a1h {
+				rom-addr = /bits/ 8 <0xa1>;
+				rom-val = /bits/ 8 <0x6c>;
+			};
+
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x24>;
+			};
+		};
+	};
+
+	backlight_pwm: pwm {
+		compatible = "clk-pwm";
+		#pwm-cells = <2>;
+		clocks = <&mmcc CAMSS_GP0_CLK>;
+		pinctrl-0 = <&backlight_pwm_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		/* GPIO is board-specific */
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en1_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x03200000 0x800000>;
+			no-map;
+		};
+
+		mpss@8400000 {
+			reg = <0x08400000 0x1f00000>;
+			no-map;
+		};
+
+		mba@a300000 {
+			reg = <0x0a300000 0x100000>;
+			no-map;
+		};
+
+		reserved@cb00000 {
+			reg = <0x0cb00000 0x700000>;
+			no-map;
+		};
+
+		wcnss@d200000 {
+			reg = <0x0d200000 0x700000>;
+			no-map;
+		};
+
+		adsp_region: adsp@d900000 {
+			reg = <0x0d900000 0x1800000>;
+			no-map;
+		};
+
+		venus@f100000 {
+			reg = <0x0f100000 0x500000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+
+		reserved@fb00000 {
+			reg = <0x0fb00000 0x260000>;
+			no-map;
+		};
+
+		rfsa@fd60000 {
+			reg = <0x0fd60000 0x20000>;
+			no-map;
+		};
+
+		rmtfs@fd80000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0fd80000 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
+};
+
+&adsp {
+	status = "okay";
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	accelerometer@1d {
+		compatible = "st,lis2hh12";
+		reg = <0x1d>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-0 = <&accel_int_default_state>;
+		pinctrl-names = "default";
+
+		st,drdy-int-pin = <1>;
+
+		vdd-supply = <&pm8226_l19>;
+		vddio-supply = <&pm8226_lvs1>;
+	};
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	muic: usb-switch@25 {
+		compatible = "siliconmitus,sm5502-muic";
+		reg = <0x25>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&muic_int_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp1_i2c5 {
+	status = "okay";
+
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&tsp_int_rst_default_state>;
+		pinctrl-names = "default";
+
+		reset-gpios = <&pm8226_gpios 6 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&reg_tsp_1p8v>;
+		vdda-supply = <&reg_tsp_3p3v>;
+	};
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		/* Voltage constraints are board-specific */
+		pm8226_s4: s4 {};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		/* Voltage constraints are board-specific */
+		pm8226_l3: l3 {};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&tlmm {
+	accel_int_default_state: accel-int-default-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_i2c_default_state: backlight-i2c-default-state {
+		pins = "gpio20", "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_pwm_default_state: backlight-pwm-default-state {
+		pins = "gpio33";
+		function = "gp0_clk";
+	};
+
+	muic_int_default_state: muic-int-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en_default_state: tsp-en-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en1_default_state: tsp-en1-default-state {
+		/* pins is board-specific */
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default_state: tsp-int-rst-default-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	extcon = <&muic>, <&muic>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&muic>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.39.0

