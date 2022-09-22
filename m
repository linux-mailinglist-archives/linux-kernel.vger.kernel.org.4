Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C75E5F89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiIVKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiIVKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:12:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D44D62FD;
        Thu, 22 Sep 2022 03:12:48 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 1797140008;
        Thu, 22 Sep 2022 10:12:43 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, foss+kernel@0leil.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 2/3] =?UTF-8?q?arm64:=20dts:=20rockchip:=20add=20PX30-?= =?UTF-8?q?=C2=B5Q7=20(Ringneck)=20SoM=20with=20Haikou=20baseboard?=
Date:   Thu, 22 Sep 2022 12:12:10 +0200
Message-Id: <20220922101211.3215888-3-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922101211.3215888-1-foss+kernel@0leil.net>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The PX30-uQ7 (Ringneck) SoM is a µQseven-compatible (40mmx70mm, MXM-230
connector) system-on-module from Theobroma Systems[1], featuring the
Rockchip PX30.

It provides the following feature set:
 * up to 4GB DDR4
 * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
 * SD card (on a baseboard) via edge connector
 * Fast Ethernet with on-module TI DP83825I PHY
 * MIPI-DSI/LVDS
 * MIPI-CSI
 * USB
   - 1x USB 2.0 dual-role
   - 3x USB 2.0 host
 * on-module STM32 Cortex-M0 companion controller, implementing:
   - low-power RTC functionality (ISL1208 emulation)
   - fan controller (AMC6821 emulation)
   - USB<->CAN bridge controller
 * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
 * on-module NXP SE05x Secure Element

[1] https://www.theobroma-systems.com/som-product/px30-%C2%B5q7/

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/px30-ringneck-haikou.dts     | 239 ++++++++++++
 .../boot/dts/rockchip/px30-ringneck.dtsi      | 347 ++++++++++++++++++
 3 files changed, 587 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a..1e3b9d7c1a8b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
new file mode 100644
index 000000000000..6304d6f7baa3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include "px30-ringneck.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Theobroma Systems PX30-µQ7 SoM on Haikou devkit";
+	compatible = "tsd,px30-ringneck-haikou", "rockchip,px30";
+
+	aliases {
+		mmc2 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio_keys: haikou-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&haikou_keys_pin>;
+		pinctrl-names = "default";
+
+		BATLOWn {
+			label = "BATLOW#";
+			linux,code = <KEY_BATTERY>;
+			gpios = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
+		};
+
+		BIOS_DISABLEn {
+			label = "BIOS_DISABLE#";
+			linux,code = <SW_BOOT_ALT>;
+			linux,input-type = <EV_SW>;
+			gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_HIGH>;
+		};
+
+		LID_BTNn {
+			label = "LID_BTN#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_LOW>;
+		};
+
+		SLP_BTNn {
+			label = "SLP_BTN#";
+			linux,code = <KEY_SLEEP>;
+			gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_LOW>;
+		};
+
+		WAKEn {
+			label = "WAKE#";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
+
+		sd_card_led: led-1 {
+			label = "sd_card_led";
+			gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc2";
+		};
+	};
+
+	i2s0-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Haikou,I2S-codec";
+		simple-audio-card,mclk-fs = <512>;
+
+		simple-audio-card,codec {
+			clocks = <&sgtl5000_clk>;
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			bitclock-master;
+			frame-master;
+			sound-dai = <&i2s0_8ch>;
+		};
+	};
+
+	sgtl5000_clk: sgtl5000-oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency  = <24576000>;
+	};
+
+	dc_12v: dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc3v3_baseboard: vcc3v3-baseboard {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_baseboard: vcc5v0-baseboard {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vdda_codec: vdda-codec {
+		compatible = "regulator-fixed";
+		regulator-name = "vdda_codec";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+
+	vddd_codec: vddd-codec {
+		compatible = "regulator-fixed";
+		regulator-name = "vddd_codec";
+		regulator-boot-on;
+		regulator-min-microvolt = <1600000>;
+		regulator-max-microvolt = <1600000>;
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&sgtl5000_clk>;
+		#sound-dai-cells = <0>;
+		VDDA-supply = <&vdda_codec>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+		VDDD-supply = <&vddd_codec>;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	eeprom@50 {
+		reg = <0x50>;
+		compatible = "atmel,24c01";
+		pagesize = <8>;
+		size = <128>;
+		vcc-supply = <&vcc3v3_baseboard>;
+	};
+};
+
+&i2s0_8ch {
+	status = "okay";
+};
+
+&gmac {
+	status = "okay";
+};
+
+&pinctrl {
+	haikou {
+		haikou_keys_pin: haikou-keys-pin {
+			rockchip,pins =
+			  /* WAKE# */
+			  <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* SLP_BTN# */
+			  <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* LID_BTN */
+			  <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* BATLOW# */
+			  <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+			  /* BIOS_DISABLE# */
+			  <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		sd_card_led_pin: sd-card-led-pin {
+			rockchip,pins =
+			  <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	vmmc-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-0 = <&uart5_xfer>;
+	status = "okay";
+};
+
+&usb20_otg {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
new file mode 100644
index 000000000000..74a7f1182c21
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include "px30.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &emmc;
+		mmc1 = &sdio;
+		rtc0 = &rtc_twi;
+		rtc1 = &rk809;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&emmc_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&module_led_pin>;
+		status = "okay";
+
+		module_led: led-0 {
+			label = "module_led";
+			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vcc5v0_sys: vccsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	supports-emmc;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_emmc>;
+
+	status = "okay";
+};
+
+/* On-module TI DP83825I PHY but no connector, enable in carrierboard */
+&gmac {
+	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 50000 50000>;
+	phy-supply = <&vcc_3v3>;
+	clock_in_out = "output";
+};
+
+&gpu {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pmic_int>;
+		pinctrl-names = "default";
+		#clock-cells = <0>;
+		clock-output-names = "xin32k";
+		rockchip,system-power-controller;
+		wakeup-source;
+		status = "okay";
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc_3v3>;
+		vcc6-supply = <&vcc_3v3>;
+		vcc7-supply = <&vcc_3v3>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		regulators {
+			vdd_log: DCDC_REG1 {
+				regulator-name = "vdd_log";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v0_1v8: vcc_emmc: DCDC_REG4 {
+				regulator-name = "vcc_3v0_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_3v3: DCDC_REG5 {
+				regulator-name = "vcc_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG2 {
+				regulator-name = "vcc_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_1v0: LDO_REG3 {
+				regulator-name = "vcc_1v0";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_lcd: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vcc_lcd";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_1v8_lcd: LDO_REG8 {
+				regulator-name = "vcc_1v8_lcd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG9 {
+				regulator-name = "vcca_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	/* SE05x is limited to Fast Mode */
+	clock-frequency = <400000>;
+
+	fan: fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		#cooling-cells = <2>;
+	};
+
+	rtc_twi: rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2s0_8ch {
+	rockchip,trcm-sync-tx-only;
+
+	pinctrl-0 = <&i2s0_8ch_sclktx &i2s0_8ch_lrcktx
+		     &i2s0_8ch_sdo0 &i2s0_8ch_sdi0>;
+};
+
+&io_domains {
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vccio_sd>;
+	vccio3-supply = <&vcc_3v3>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_emmc>;
+	vccio-oscgpi-supply = <&vcc_3v3>;
+
+	status = "okay";
+};
+
+&pinctrl {
+	emmc {
+		emmc_reset: emmc-reset {
+			rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		module_led_pin: module-led-pin {
+			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins =
+				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+/* Mule UCAN */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.37.3

