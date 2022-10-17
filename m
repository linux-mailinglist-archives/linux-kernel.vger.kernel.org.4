Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF96600CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJQKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJQKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:42:12 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45860689;
        Mon, 17 Oct 2022 03:42:04 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 9975D60531;
        Mon, 17 Oct 2022 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666003322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnTCROv3X19Z7P6kVOzp8ULzhTYeWecn13CoES5G1ww=;
        b=cDlse4K+aChkkMdmY5QsKXkqUQqvVofB4RkK1SFkvNmq1LVUaVWgpO41MenDGHRnBlFkrj
        9MBnrh+HAHHno1Yj1MAr73yluBOT8Ni0XbdHpN/fcdgnbF5KUrYpKG/YN9b0QDtfYFFyMA
        a6EgsBXSapyiNMylq05JIHjAx0A0tdU=
Received: from frank-G5.. (fttx-pool-217.61.154.127.bambit.de [217.61.154.127])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id E0F63403ED;
        Mon, 17 Oct 2022 10:42:01 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v1 12/12] arm64: dts: mt7986: add Bananapi R3
Date:   Mon, 17 Oct 2022 12:41:41 +0200
Message-Id: <20221017104141.7338-13-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017104141.7338-1-linux@fw-web.de>
References: <20221017104141.7338-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f9fa3922-9c17-41cf-bb5a-ddb6037dd69a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add support for Bananapi R3 SBC.

- SD/eMMC support (switching first 4 bits of data-bus with sw6/D)
- all rj45 ports and both SFP working (eth1/lan4)
- PCIe and all USB-Ports + SIM-Slot tested
- i2c and all uarts tested
- wifi tested

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
SPI-NAND/NOR switched (CS by sw5/C) not yet included
  this is done with DT-Overlays in my tree, but i have no idea yet,
  how to upstream

break some lines in wifi-eeprom-data because of checkpatch warnings.
originally there were 8 x int32 per line
---
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  34 +
 .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  29 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 609 ++++++++++++++++++
 4 files changed, 674 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 0ec90cb3ef28..c22cd3e6b98f 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
new file mode 100644
index 000000000000..859b4180ca11
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+#include "mt7986a-bananapi-bpi-r3.dtsi"
+
+/ {
+	model = "Bananapi BPI-R3 (emmc)";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x14014>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
new file mode 100644
index 000000000000..57200407ab86
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+#include "mt7986a-bananapi-bpi-r3.dtsi"
+
+/ {
+	model = "Bananapi BPI-R3 (sdmmc)";
+};
+
+&mmc0 {
+	//sdcard
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <52000000>;
+	cap-sd-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
new file mode 100644
index 000000000000..b2317e894855
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
@@ -0,0 +1,609 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Authors: Sam.Shih <sam.shih@mediatek.com>
+ *          Frank Wunderlich <frank-w@public-files.de>
+ *          Daniel Golle <daniel@makrotopia.org>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+#include "mt7986a.dtsi"
+
+/ {
+	model = "Bananapi BPI-R3";
+	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		factory {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	/* i2c of the left SFP cage (wan) */
+	i2c_sfp1: i2c-gpio-0 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&pio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	/* i2c of the right SFP cage (lan) */
+	i2c_sfp2: i2c-gpio-1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&pio 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green_led: led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		blue_led: led-1 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 86 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	/* left SFP cage (wan) */
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp1>;
+		los-gpio = <&pio 46 GPIO_ACTIVE_HIGH>;
+		moddef0-gpio = <&pio 49 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&pio 20 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&pio 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* right SFP cage (lan) */
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp2>;
+		los-gpios = <&pio 31 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 15 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 48 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-mode = "2500base-x";
+
+		fixed-link {
+			speed = <2500>;
+			full-duplex;
+			pause;
+		};
+	};
+
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "2500base-x";
+		sfp = <&sfp1>;
+		managed = "in-band-status";
+	};
+
+	mdio: mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&mdio {
+	switch: switch@0 {
+		compatible = "mediatek,mt7531";
+		reg = <31>;
+		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins>;
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pio {
+	i2c_pins: i2c-pins-3-4 {
+		mux {
+			function = "i2c";
+			groups = "i2c";
+		};
+	};
+
+	mmc0_pins_default: mmc0-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+	};
+
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clk",/* "pcie_wake",*/ "pcie_pereset";
+		};
+	};
+
+	spi_flash_pins: spi-flash-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+	};
+
+	spic_pins: spic-pins {
+		mux {
+			function = "spi";
+			groups = "spi1_0";
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		mux {
+			function = "uart";
+			groups = "uart1_rx_tx";
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		mux {
+			function = "uart";
+			groups = "uart2_0_rx_tx";
+		};
+	};
+
+	wf_2g_5g_pins: wf-2g-5g-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_2g", "wf_5g";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
+			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
+			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
+			       "WF1_TOP_CLK", "WF1_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+
+	wf_dbdc_pins: wf-dbdc-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_dbdc";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
+			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
+			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
+			       "WF1_TOP_CLK", "WF1_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+
+	wf_led_pins: wf-led-pins {
+		mux {
+			function = "led";
+			groups = "wifi_led";
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_flash_pins>;
+	cs-gpios = <0>, <0>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spic_pins>;
+	cs-gpios = <0>, <0>;
+	status = "okay";
+};
+
+&ssusb {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&switch {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			label = "wan";
+		};
+
+		port@1 {
+			reg = <1>;
+			label = "lan0";
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan1";
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "lan2";
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "lan3";
+		};
+
+		port5: port@5 {
+			reg = <5>;
+			label = "lan4";
+			phy-mode = "2500base-x";
+			sfp = <&sfp2>;
+			managed = "in-band-status";
+		};
+
+		port@6 {
+			reg = <6>;
+			label = "cpu";
+			ethernet = <&gmac0>;
+			phy-mode = "2500base-x";
+
+			fixed-link {
+				speed = <2500>;
+				full-duplex;
+				pause;
+			};
+		};
+	};
+};
+
+&trng {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&usb_phy {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&wifi {
+	status = "okay";
+	pinctrl-names = "default", "dbdc";
+	pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
+	pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
+
+	mediatek,eeprom-data = <0x86790900 0xc4326 0x60000000 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x1000000
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x800 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x24649090 0x280000 0x5100000 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x21e00 0x21e0002 0x1e00021e 0x22800 0x2280002 0x28000228 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x8080 0x8080fdf7
+				0x903150d 0x80808080 0x80808080 0x5050d0d 0x1313c6c6 0xc3c3c200
+				0xc200c2 0x8182
+				0x8585c2c2 0x82828282 0x858500c2 0xc2000081 0x82858587 0x87c2c200
+				0x81818285 0x858787c2
+				0xc2000081 0x82858587 0x87c2c200 0x818285 0x858787c2 0xc2000081
+				0x82858587 0x87c4c4c2
+				0xc100c300 0xc3c3c100 0x818383c3 0xc3c3c100 0x81838300 0xc2c2c2c0
+				0x81828484 0xc3
+				0xc3c3c100 0x81838386 0x86c3c3c3 0xc1008183 0x838686c2 0xc2c2c081
+				0x82848486 0x86c3c3c3
+				0xc1008183 0x838686c3 0xc3c3c100 0x81838386 0x86c3c3c3 0xc1008183
+				0x83868622 0x28002228
+				0x222800 0x22280000 0xdddddddd 0xdddddddd 0xddbbbbbb 0xccccccdd
+				0xdddddddd 0xdddddddd
+				0xeeeeeecc 0xccccdddd 0xdddddddd 0x4a5662 0x4a 0x56620000 0x4a5662
+				0x4a
+				0x56620000 0x88888888 0x33333326 0x26262626 0x26262600 0x33333326
+				0x26262626 0x26262600
+				0x33333326 0x26262626 0x26262600 0x33333326 0x26262626 0x26262600
+				0x00 0xf0f0cc00
+				0x00 0xaaaa 0xaabbbbbb 0xcccccccc 0xccccbbbb 0xbbbbbbbb 0xbbbbbbaa
+				0xaaaabbbb
+				0xbbaaaaaa 0x999999aa 0xaaaabbbb 0xbbcccccc 0x00 0xaaaa 0xaa000000
+				0xbbbbbbbb
+				0xbbbbaaaa 0xaa999999 0xaaaaaaaa 0xaaaaaaaa 0xaaaaaaaa 0xaaaaaaaa
+				0xaaaabbbb 0xbbbbbbbb
+				0x00 0x00 0x00 0x99999999 0x9999aaaa 0xaaaaaaaa 0x999999aa
+				0xaaaaaaaa
+				0xaaaaaaaa 0xaaaaaaaa 0xaaaabbbb 0xbbbbbbbb 0x00 0xeeee 0xeeffffff
+				0xcccccccc
+				0xccccdddd 0xddbbbbbb 0xccccccbb 0xbbbbbbbb 0xbbbbbbbb 0xbbbbbbbb
+				0xbbbbcccc 0xccdddddd
+				0x516200 0x686e0051 0x6200686e 0x516200 0x686e0051 0x6200686e
+				0x516200 0x686e0051
+				0x6200686e 0x516200 0x686e0051 0x6200686e 0x516200 0x686e0051
+				0x6200686e 0x516200
+				0x686e0051 0x6200686e 0x516200 0x686e0051 0x6200686e 0x516200
+				0x686e0051 0x6200686e
+				0x516200 0x686e0051 0x6200686e 0x516200 0x686e0051 0x6200686e
+				0x516200 0x686e0051
+				0x6200686e 0x516200 0x686e0051 0x6200686e 0x516200 0x686e0051
+				0x6200686e 0x516200
+				0x686e0051 0x6200686e 0x516200 0x686e0051 0x6200686e 0x516200
+				0x686e0051 0x6200686e
+				0x88888888 0x88888888 0x88888888 0x88888888 0x88888888 0x88888888
+				0x88888888 0x88888888
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x01 0x6000100 0x1050002 0xff0300
+				0xf900fe03 0x00 0x00 0x9b 0x6e370000 0x00 0xfc0009 0xa00fe00
+				0x60700fe 0x70800 0x5000b0a 0x00 0x00 0xe2 0x96460000 0x00
+				0x400f7 0xf8000300 0xfcfe0003 0xfbfc00 0xee00e3f2 0x00 0x00 0x11
+				0xbb550000 0x00 0x600f6 0xfc000300 0xfbfe0004 0xfafe00 0xf600ecf2
+				0x00
+				0x00 0x1f 0xbf580000 0x00 0x600f5 0xf6000400 0xf8f90004 0xf7f800
+				0xf700f0f4 0x00 0x00 0x24 0xbe570000 0x00 0x800f8 0xfe000600
+				0xf8fd0007 0xf9fe00 0xf500f0f4 0x00 0x00 0x2d 0xd6610000 0x00
+				0x400f7 0xfc000500 0xf7fc0005 0xf7fc00 0xf900f5f8 0x00 0x00 0x26
+				0xd96e0000 0x00 0x400f7 0xf9000600 0xf5f70005 0xf5f800 0xf900f4f7
+				0x00
+				0x00 0x1b 0xce690000 0x00 0x300f8 0xf8000600 0xf6f60004 0xf6f700
+				0xf900f4f7 0x00 0x00 0x18 0xd8720000 0x00 0x00 0x2404002
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0xc1c2c1c2 0x41c341c3 0x3fc13fc1 0x40c13fc2 0x3fc240c1 0x41c040c0
+				0x3fc23fc2 0x40c13fc2
+				0x3fc140c0 0x41c040c0 0x3fc33fc3 0x40c23fc2 0x3fc240c1 0x41c040c0
+				0x3fc23fc2 0x40c23fc2
+				0x3fc140c1 0x41c040c0 0x00 0x00 0x41c741c7 0xc1c7c1c7 0x00 0x00
+				0x3fc03fc0 0x3fc03fc0 0x3fc03fc0 0x3fc03fc0 0x3fc03fc0 0x3fc03fc0
+				0x3fc03fc0 0x3fc03fc0
+				0x3fc03fc0 0x3fc03fc0 0x3fc03fc0 0x3fc03fc0 0x3fc03fc0 0x3fc03fc0
+				0x3fc03fc0 0x3fc03fc0
+				0xa0ce00 0x00 0xb6840000 0x00 0x00 0x00 0x18181818 0x18181818
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x4b5763 0x4b 0x57630000 0x4b5763 0x4b 0x57630000 0x88888888
+				0x8474759
+				0x69780849 0x49596d7a 0x849495a 0x6d790848 0x48596c78 0x8484858
+				0x6a780848 0x48586a78
+				0x8484858 0x6c78084a 0x4a5b6d79 0x8474759 0x697a0848 0x48596b79
+				0x8484859 0x6c7a0848
+				0x48586c79 0x8484857 0x68770848 0x48576877 0x8484857 0x6a77084a
+				0x4a5a6a77 0x8464659
+				0x69790848 0x48586b79 0x8484858 0x6c7a0848 0x48596c79 0x8484857
+				0x68770848 0x48576877
+				0x8494958 0x6d7a084b 0x4b5c6c77 0x847475a 0x6a7b0849 0x495a6e7c
+				0x849495a 0x6e7c0849
+				0x495b6e7c 0x8494959 0x6a7a0849 0x49596a7a 0x84a4a5a 0x6f7d084b
+				0x4b5c6e7b 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x85848484
+				0xc3c4c4c5 0xc4c3c33f 0xc3c3c2c2 0xc2c2c03f 0xc3c3c3c4 0xc4c4c33f
+				0xc2c2c2c2 0xc1c3c1c1
+				0xc0c08282 0x83848686 0x88880000 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x1111 0x00
+				0x8080f703 0x10808080 0x80050d13 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0xa4 0xce000000 0xb684 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+				0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00>;
+};
+
-- 
2.34.1

