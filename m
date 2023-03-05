Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737906AAFE2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCENVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCENU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:20:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DF12F0D;
        Sun,  5 Mar 2023 05:20:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q16so6336448wrw.2;
        Sun, 05 Mar 2023 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqXrc5vpLFEXqIOLK5+asnO/IPa6WfwXsqwh2Pebo0o=;
        b=It9CAxzQqsBgnxKg4qnWlaAKMzm4pJdnVlywM27ASvhAtMgsXWrXrvu+lOkG7HLp5/
         qY4etttWF6fWzT7zg8c6ViRGngXGPCURxA6xDs4KYVJJA1K8ddLCmEcA7fO0xNmerqTu
         zLuafsgkFH6O5OMQL8fCbtZcTyxfPNndIkjgDLOGkAtTnwSca4XxBelmmZug42PVlN/P
         CjDn6QXbpmeeCHpg2KmBL51/stqc5JfNcJevlRqPtfNXM8nPQ84yW1MT6S83yxkTjAMR
         TFYbHXO/ifW8A9u0L77uUIAJKKHIwcujXO6gu3YbRJVpctdU61y0J2DbX6iiJ3yCelaX
         HHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqXrc5vpLFEXqIOLK5+asnO/IPa6WfwXsqwh2Pebo0o=;
        b=xKjSlxvzhJhsCg46JDsJ/CKaA9Ly/4CvwJ94HlTeUHZ52MqiWhcVQ0uWlqcFUEYvp5
         UacuaA18RW+uq4C5XuPWgh/2KrjeF0XMvWLqS3d86eAfFQRqhOXY8A8nBL/ah71F8dp7
         oepr4mx1J/3bs98qFIseKUbGvHMIsu1YND6SeGF0A1fM4Wg3X9Izmuv9IP27nXFMbaXR
         ZIrLvYmq/mswzUhDH4F/tJZ5wK3/AQBolil+GMAD/WaxCcQcGDUaoMbCsC6TARP5yTlK
         5sgaOhynW6IzS7hMa+y1PR8IBtGxjXZZ8T2Fqjds01gg3Sa0w/iOS71lfSmTUjxtQChn
         3QDA==
X-Gm-Message-State: AO0yUKVENnQE+Xu3iDNzCR4L5GqhzTishUWHmsiZDiI0QbcR6wI1OQQo
        nD0U4/K5vAoIIZ/EO5uXUP4=
X-Google-Smtp-Source: AK7set9oQnGi3UjZEDhxwJmrVCKKYlcZas/8sbviyL0t9LRwr0M6a9Cb74Pf+AZKyuqLzsUMoSRz0Q==
X-Received: by 2002:adf:e7ce:0:b0:2c8:cdde:c28a with SMTP id e14-20020adfe7ce000000b002c8cddec28amr4947091wrn.59.1678022454792;
        Sun, 05 Mar 2023 05:20:54 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d6087000000b002c567b58e9asm7496851wrt.56.2023.03.05.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:20:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: add support for BananaPi M2S variants
Date:   Sun,  5 Mar 2023 13:20:44 +0000
Message-Id: <20230305132044.1596320-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305132044.1596320-1-christianshewitt@gmail.com>
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
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

BananaPi M2S ships in Amlogic S922X and A311D variants with the
following common specifications:

- 16GB eMMC
- HDMI 2.1a video
- 2x 10/100/1000 Base-T Ethernet (1x RTL8211F, 1x RTL811H)
- 2x USB 2.0 ports
- 2x Status LED's (green/blue)
- 1x Power/Reset button
- 1x micro SD card slot
- 40-pin GPIO header
- PWM fan header
- UART header

The S992X variant has:
- 2GB LPDDR4 RAM

The A311D variant has:

- 4GB LPDDR4 RAM
- NPU (5.0 TOPS)
- MIPI DSI header
- MIPI CSI header

An optional RTL8822CS SDIO WiFi/BT mezzanine is available for
both board variants.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-g12b-a311d-bananapi-m2s.dts |  37 ++
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi | 521 ++++++++++++++++++
 .../amlogic/meson-g12b-s922x-bananapi-m2s.dts |  14 +
 4 files changed, 574 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index ccf1ba57fa87..2bb9f1d4bc1a 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-radxa-zero.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-bananapi-m2s.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
@@ -17,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-radxa-zero2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-bananapi-m2s.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dts
new file mode 100644
index 000000000000..ac6f7ae1d103
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-bananapi-m2s.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-a311d.dtsi"
+#include "meson-g12b-bananapi.dtsi"
+
+/ {
+	compatible = "bananapi,bpi-m2s", "amlogic,a311d", "amlogic,g12b";
+	model = "BananaPi M2S";
+
+	aliases {
+		i2c0 = &i2c1;
+		i2c1 = &i2c3;
+	};
+};
+
+/* Camera (CSI) bus */
+&i2c1 {
+	status = "okay";
+	pinctrl-0 = <&i2c1_sda_h6_pins>, <&i2c1_sck_h7_pins>;
+	pinctrl-names = "default";
+};
+
+/* Display (DSI) bus */
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+};
+
+&npu {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
new file mode 100644
index 000000000000..d02b50a0f7a8
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2023 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	aliases {
+		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
+		rtc1 = &vrtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 4 GiB */
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 2>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "RST";
+			linux,code = <KEY_POWER>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		cooling-levels = <0 120 170 220>;
+		pwms = <&pwm_cd 1 40000 0>;
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+
+	dc_in: regulator-dc-in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vcc_3v3: regulator-vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_1v8: regulator-vddao-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+	};
+
+	vddcpu_a: regulator-vddcpu-a {
+		compatible = "pwm-regulator";
+		regulator-name = "VDDCPU_A";
+		regulator-min-microvolt = <690000>;
+		regulator-max-microvolt = <1050000>;
+		pwm-supply = <&dc_in>;
+		pwms = <&pwm_ab 0 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddcpu_b: regulator-vddcpu-b {
+		compatible = "pwm-regulator";
+		regulator-name = "VDDCPU_B";
+		regulator-min-microvolt = <690000>;
+		regulator-max-microvolt = <1050000>;
+		pwm-supply = <&vsys_3v3>;
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vsys_3v3: regulator-vsys-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSYS_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	emmc_1v8: regulator-emmc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "EMMC_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	usb_pwr: regulator-usb-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		gpio = <&gpio GPIOA_6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "BPI-M2S";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu100 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu101 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu102 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu103 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+/* Main i2c bus */
+&i2c2 {
+	status = "okay";
+	pinctrl-0 = <&i2c2_sda_x_pins>, <&i2c2_sck_x_pins>;
+	pinctrl-names = "default";
+};
+
+&pcie {
+	status = "okay";
+	reset-gpios = <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
+};
+
+&pwm_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_a_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin0";
+};
+
+&pwm_cd {
+	status = "okay";
+	pinctrl-0 = <&pwm_d_x6_pins>;
+	pinctrl-names = "default";
+	pwm-gpios = <&gpio GPIOAO_10 GPIO_ACTIVE_HIGH>;
+};
+
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddao_1v8>;
+};
+
+/* SDIO */
+&sd_emmc_a {
+	/* enable if WiFi/BT board connected */
+	status = "disabled";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	sd-uhs-sdr104;
+	max-frequency = <50000000>;
+
+	non-removable;
+	disable-wp;
+
+	/* WiFi firmware requires power in suspend */
+	keep-power-in-suspend;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vsys_3v3>;
+	vqmmc-supply = <&vddao_1v8>;
+
+	rtl8822cs: wifi@1 {
+		reg = <1>;
+	};
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vsys_3v3>;
+	vqmmc-supply = <&vsys_3v3>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_1v8>;
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
+&uart_A {
+	/* enable if WiFi/BT board connected */
+	status = "disabled";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "realtek,rtl8822cs-bt";
+		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
+		device-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb2_phy0 {
+	phy-supply = <&dc_in>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&usb_pwr>;
+};
+
+&usb3_pcie_phy {
+	phy-supply = <&usb_pwr>;
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "peripheral";
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dts
new file mode 100644
index 000000000000..7f66f263a2ce
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-bananapi-m2s.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-s922x.dtsi"
+#include "meson-g12b-bananapi.dtsi"
+
+/ {
+	compatible = "bananapi,bpi-m2s", "amlogic,s922x", "amlogic,g12b";
+	model = "BananaPi M2S";
+};
-- 
2.34.1

