Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67D60EF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiJ0EwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiJ0EwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:52:06 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD00472FED;
        Wed, 26 Oct 2022 21:52:03 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Oct 2022 13:52:03 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E79372059027;
        Thu, 27 Oct 2022 13:52:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Oct 2022 13:52:02 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5A788B62A4;
        Thu, 27 Oct 2022 13:52:02 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/4] arm64: dts: uniphier: Add NX1 SoC and boards support
Date:   Thu, 27 Oct 2022 13:51:57 +0900
Message-Id: <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
References: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial version of devicetree sources for NX1 SoC and boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/Makefile        |   3 +
 .../boot/dts/socionext/uniphier-nx1-evb.dts   |  83 +++
 .../boot/dts/socionext/uniphier-nx1-ref.dts   | 109 +++
 .../boot/dts/socionext/uniphier-nx1-som.dts   |  50 ++
 .../boot/dts/socionext/uniphier-nx1.dtsi      | 704 ++++++++++++++++++
 5 files changed, 949 insertions(+)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-evb.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-som.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi

diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index 33989a9643ac..0f198888484a 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -5,6 +5,9 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ld20-akebi96.dtb \
 	uniphier-ld20-global.dtb \
 	uniphier-ld20-ref.dtb \
+	uniphier-nx1-evb.dtb \
+	uniphier-nx1-ref.dtb \
+	uniphier-nx1-som.dtb \
 	uniphier-pxs3-ref.dtb \
 	uniphier-pxs3-ref-gadget0.dtb \
 	uniphier-pxs3-ref-gadget1.dtb
diff --git a/arch/arm64/boot/dts/socionext/uniphier-nx1-evb.dts b/arch/arm64/boot/dts/socionext/uniphier-nx1-evb.dts
new file mode 100644
index 000000000000..dfdb39b68d44
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-nx1-evb.dts
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+//
+// Device Tree Source for UniPhier NX1 Evaluation Board
+//
+// Copyright (C) 2021 Socionext Inc.
+//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+/dts-v1/;
+#include "uniphier-nx1.dtsi"
+
+/ {
+	model = "UniPhier NX1 Evaluation Board";
+	compatible = "socionext,uniphier-nx1-evb", "socionext,uniphier-nx1";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		spi0 = &spi0;
+		ethernet = &eth;
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0 0x20000000 1 0x00000000>;
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy@0 {
+		reg = <0>;
+	};
+};
+
+&usb {
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+&sd {
+	status = "okay";
+};
+
+&pinctrl_sd {
+	sd {
+		pins = "SDCLK", "SDCMD", "SDDAT0",
+		       "SDDAT1", "SDDAT2", "SDDAT3";
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-nx1-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-nx1-ref.dts
new file mode 100644
index 000000000000..7c373eba7a81
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-nx1-ref.dts
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+//
+// Device Tree Source for UniPhier NX1 Reference Board
+//
+// Copyright (C) 2021 Socionext Inc.
+//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+/dts-v1/;
+#include "uniphier-nx1-som.dts"
+
+/ {
+	model = "UniPhier NX1 Reference Board";
+	compatible = "socionext,uniphier-nx1-ref", "socionext,uniphier-nx1";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		ethernet = &eth;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led0 {
+			label = "user0";
+			gpios = <&pca9536 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led1 {
+			label = "user1";
+			gpios = <&pca9536 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led2 {
+			label = "user2";
+			gpios = <&pca9536 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led3 {
+			label = "user3";
+			gpios = <&pca9536 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	pca9536: gpio@41 {
+		compatible = "ti,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&usb {
+	status = "okay";
+};
+
+&pcie_ep {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-nx1-som.dts b/arch/arm64/boot/dts/socionext/uniphier-nx1-som.dts
new file mode 100644
index 000000000000..af7b9671dd2c
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-nx1-som.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+//
+// Device Tree Source for UniPhier NX1 SOM Board
+//
+// Copyright (C) 2021 Socionext Inc.
+//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+/dts-v1/;
+#include "uniphier-nx1.dtsi"
+
+/ {
+	model = "UniPhier NX1 SOM Board";
+	compatible = "socionext,uniphier-nx1-som", "socionext,uniphier-nx1";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		i2c1 = &i2c1;
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0 0x20000000 1 0x00000000>;
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "st,24c64", "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+};
+
+&emmc {
+	status = "okay";
+};
+
+&sd {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi b/arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi
new file mode 100644
index 000000000000..e401763de86e
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+//
+// Device Tree Source for UniPhier NX1 SoC
+//
+// Copyright (C) 2021 Socionext Inc.
+//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible = "socionext,uniphier-nx1";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 0x000>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 0x001>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 0x002>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 0x003>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	cluster0_opp: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-78125000 {
+			opp-hz = /bits/ 64 <78125000>;
+			clock-latency-ns = <300>;
+		};
+		opp-156250000 {
+			opp-hz = /bits/ 64 <156250000>;
+			clock-latency-ns = <300>;
+		};
+		opp-312500000 {
+			opp-hz = /bits/ 64 <312500000>;
+			clock-latency-ns = <300>;
+		};
+		opp-625000000 {
+			opp-hz = /bits/ 64 <625000000>;
+			clock-latency-ns = <300>;
+		};
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			clock-latency-ns = <300>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	clocks {
+		refclk: ref {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(3, 0) GPIO_ACTIVE_LOW>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu-crit {
+					temperature = <120000>;	/* 120C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu-alert {
+					temperature = <110000>;	/* 110C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure-memory@21000000 {
+			reg = <0x0 0x21000000 0x0 0x01000000>;
+			no-map;
+		};
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+
+		sysctrl: sysctrl@11840000 {
+			compatible = "socionext,uniphier-nx1-sysctrl",
+				     "simple-mfd", "syscon";
+			reg = <0x11840000 0x10000>;
+
+			sys_clk: clock {
+				compatible = "socionext,uniphier-nx1-clock";
+				#clock-cells = <1>;
+			};
+
+			sys_rst: reset {
+				compatible = "socionext,uniphier-nx1-reset";
+				#reset-cells = <1>;
+			};
+
+			watchdog {
+				compatible = "socionext,uniphier-wdt";
+			};
+
+			pvtctl: thermal-sensor {
+				compatible = "socionext,uniphier-nx1-thermal";
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				#thermal-sensor-cells = <0>;
+				socionext,tmod-calibration = <0x0f22 0x68ee>;
+			};
+		};
+
+		spi0: spi@14006000 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x14006000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi0>;
+			clocks = <&peri_clk 11>;
+			resets = <&peri_rst 11>;
+		};
+
+		spi1: spi@14006100 {
+			compatible = "socionext,uniphier-scssi";
+			status = "disabled";
+			reg = <0x14006100 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1>;
+			clocks = <&peri_clk 12>;
+			resets = <&peri_rst 12>;
+		};
+
+		serial0: serial@14006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x14006800 0x40>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
+			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
+		};
+
+		serial1: serial@14006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x14006900 0x40>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
+			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
+		};
+
+		serial2: serial@14006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x14006a00 0x40>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
+			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
+		};
+
+		serial3: serial@14006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x14006b00 0x40>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
+			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
+		};
+
+		gpio: gpio@14007000 {
+			compatible = "socionext,uniphier-gpio";
+			reg = <0x14007000 0x200>;
+			interrupt-parent = <&aidet>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 0>,
+				      <&pinctrl 49 0 0>,
+				      <&pinctrl 53 0 0>,
+				      <&pinctrl 96 0 0>,
+				      <&pinctrl 120 0 0>;
+			gpio-ranges-group-names = "gpio_range0",
+						  "gpio_range1",
+						  "gpio_range2",
+						  "gpio_range3",
+						  "gpio_range4";
+			ngpios = <126>;
+			socionext,interrupt-ranges = <0 48 6>;
+		};
+
+		eth: ethernet@15000000 {
+			compatible = "socionext,uniphier-nx1-ave4";
+			status = "disabled";
+			reg = <0x15000000 0x8500>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clock-names = "ether";
+			clocks = <&sys_clk 6>;
+			reset-names = "ether";
+			resets = <&sys_rst 6>;
+			phy-mode = "rgmii-id";
+			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 0>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		usb: usb@15a00000 {
+			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
+			status = "disabled";
+			reg = <0x15a00000 0xcd00>;
+			interrupt-names = "host";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb1>;
+			clock-names = "ref", "bus_early", "suspend";
+			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
+			resets = <&usb_rst 15>;
+			phys = <&usb_hsphy0>, <&usb_hsphy1>,
+			       <&usb_ssphy0>, <&usb_ssphy1>;
+			dr_mode = "host";
+		};
+
+		usb-controller@15b00000 {
+			compatible = "socionext,uniphier-nx1-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x15b00000 0x400>;
+
+			usb_rst: reset@0 {
+				compatible = "socionext,uniphier-nx1-usb3-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+				clock-names = "link";
+				clocks = <&sys_clk 12>;
+				reset-names = "link";
+				resets = <&sys_rst 12>;
+			};
+
+			usb_vbus0: regulator@100 {
+				compatible = "socionext,uniphier-nx1-usb3-regulator";
+				reg = <0x100 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 12>;
+				reset-names = "link";
+				resets = <&sys_rst 12>;
+			};
+
+			usb_vbus1: regulator@110 {
+				compatible = "socionext,uniphier-nx1-usb3-regulator";
+				reg = <0x110 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 12>;
+				reset-names = "link";
+				resets = <&sys_rst 12>;
+			};
+
+			usb_hsphy0: hs-phy@200 {
+				compatible = "socionext,uniphier-nx1-usb3-hsphy";
+				reg = <0x200 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 12>, <&sys_clk 16>,
+					 <&sys_clk 13>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 16>;
+				vbus-supply = <&usb_vbus0>;
+			};
+
+			usb_hsphy1: hs-phy@210 {
+				compatible = "socionext,uniphier-nx1-usb3-hsphy";
+				reg = <0x210 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 12>, <&sys_clk 16>,
+					 <&sys_clk 13>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 16>;
+				vbus-supply = <&usb_vbus1>;
+			};
+
+			usb_ssphy0: ss-phy@300 {
+				compatible = "socionext,uniphier-nx1-usb3-ssphy";
+				reg = <0x300 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 12>, <&sys_clk 17>,
+					 <&sys_clk 13>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 17>;
+				vbus-supply = <&usb_vbus0>;
+			};
+
+			usb_ssphy1: ss-phy@310 {
+				compatible = "socionext,uniphier-nx1-usb3-ssphy";
+				reg = <0x310 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 12>, <&sys_clk 18>,
+					 <&sys_clk 13>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 18>;
+				vbus-supply = <&usb_vbus1>;
+			};
+		};
+
+		pcie: pcie@16000000 {
+			compatible = "socionext,uniphier-pcie";
+			status = "disabled";
+			reg-names = "dbi", "link", "config", "atu";
+			reg = <0x16000000 0x1000>, <0x179a0000 0x10000>,
+			      <0x0fff0000 0x10000>, <0x16300000 0x1000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			clocks = <&sys_clk 24>;
+			resets = <&sys_rst 24>;
+			num-lanes = <2>;
+			num-viewport = <1>;
+			bus-range = <0x0 0xff>;
+			device_type = "pci";
+			ranges =
+			/* downstream I/O */
+				<0x81000000 0 0x00000000 0x0ffe0000 0 0x00010000>,
+			/* non-prefetchable memory */
+				<0x82000000 0 0x20000000 0x04200000 0 0x0bde0000>;
+			#interrupt-cells = <1>;
+			interrupt-names = "dma", "msi";
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,	/* INTA */
+					<0 0 0 2 &pcie_intc 1>,	/* INTB */
+					<0 0 0 3 &pcie_intc 2>,	/* INTC */
+					<0 0 0 4 &pcie_intc 3>;	/* INTD */
+			phy-names = "pcie-phy";
+			phys = <&pcie_phy>;
+
+			pcie_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		pcie_ep: pcie-ep@16000000 {
+			compatible = "socionext,uniphier-nx1-pcie-ep";
+			status = "disabled";
+			reg-names = "dbi", "dbi2", "link", "addr_space", "atu";
+			reg = <0x16000000 0x1000>, <0x16100000 0x1000>,
+			      <0x179a0000 0x10000>, <0x04200000 0xbe00000>,
+			      <0x16300000 0x1000>;
+			clock-names = "link";
+			clocks = <&sys_clk 24>;
+			reset-names = "link";
+			resets = <&sys_rst 24>;
+			num-ib-windows = <16>;
+			num-ob-windows = <16>;
+			num-lanes = <2>;
+			phy-names = "pcie-phy";
+			phys = <&pcie_phy>;
+		};
+
+		pcie_phy: phy@179b8000 {
+			compatible = "socionext,uniphier-nx1-pcie-phy";
+			reg = <0x179b8000 0x4000>;
+			#phy-cells = <0>;
+			clock-names = "link";
+			clocks = <&sys_clk 24>;
+			reset-names = "link";
+			resets = <&sys_rst 24>;
+			socionext,syscon = <&sysctrl>;
+		};
+
+		i2c0: i2c@18780000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18780000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c0>;
+			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
+			clock-frequency = <400000>;
+		};
+
+		i2c1: i2c@18781000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18781000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
+			clock-frequency = <400000>;
+		};
+
+		i2c2: i2c@18782000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18782000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
+			clock-frequency = <400000>;
+		};
+
+		i2c3: i2c@18783000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18783000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
+			clock-frequency = <400000>;
+		};
+
+		i2c4: i2c@18784000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18784000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c4>;
+			clocks = <&peri_clk 8>;
+			resets = <&peri_rst 8>;
+			clock-frequency = <100000>;
+		};
+
+		i2c5: i2c@18785000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18785000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c5>;
+			clocks = <&peri_clk 9>;
+			resets = <&peri_rst 9>;
+			clock-frequency = <100000>;
+		};
+
+		i2c6: i2c@18786000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x18786000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c6>;
+			clocks = <&peri_clk 10>;
+			resets = <&peri_rst 10>;
+			clock-frequency = <100000>;
+		};
+
+		sdctrl@19810000 {
+			compatible = "socionext,uniphier-nx1-sdctrl",
+				     "simple-mfd", "syscon";
+			reg = <0x19810000 0x400>;
+
+			sd_clk: clock {
+				compatible = "socionext,uniphier-nx1-sd-clock";
+				#clock-cells = <1>;
+			};
+
+			sd_rst: reset {
+				compatible = "socionext,uniphier-nx1-sd-reset";
+				#reset-cells = <1>;
+			};
+		};
+
+		perictrl@19820000 {
+			compatible = "socionext,uniphier-nx1-perictrl",
+				     "simple-mfd", "syscon";
+			reg = <0x19820000 0x200>;
+
+			peri_clk: clock {
+				compatible = "socionext,uniphier-nx1-peri-clock";
+				#clock-cells = <1>;
+			};
+
+			peri_rst: reset {
+				compatible = "socionext,uniphier-nx1-peri-reset";
+				#reset-cells = <1>;
+			};
+		};
+
+		emmc: mmc@1a000000 {
+			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
+			reg = <0x1a000000 0x400>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&sys_clk 4>;
+			resets = <&sys_rst 4>;
+			bus-width = <8>;
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			mmc-pwrseq = <&emmc_pwrseq>;
+			cdns,phy-input-delay-legacy = <9>;
+			cdns,phy-input-delay-mmc-highspeed = <2>;
+			cdns,phy-input-delay-mmc-ddr = <3>;
+			cdns,phy-dll-delay-sdclk = <21>;
+			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
+		};
+
+		sd: mmc@1a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x1a400000 0x800>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
+		soc_glue: soc-glue@1f800000 {
+			compatible = "socionext,uniphier-nx1-soc-glue",
+				     "simple-mfd", "syscon";
+			reg = <0x1f800000 0x2000>;
+
+			pinctrl: pinctrl {
+				compatible = "socionext,uniphier-nx1-pinctrl";
+			};
+		};
+
+		soc-glue@1f900000 {
+			compatible = "socionext,uniphier-nx1-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1f900000 0x2000>;
+		};
+
+		xdmac: dma-controller@1fa10000 {
+			compatible = "socionext,uniphier-xdmac";
+			reg = <0x1fa10000 0x5300>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <16>;
+			#dma-cells = <2>;
+		};
+
+		aidet: aidet@1fb20000 {
+			compatible = "socionext,uniphier-nx1-aidet";
+			reg = <0x1fb20000 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gic: interrupt-controller@1fd00000 {
+			compatible = "arm,gic-v3";
+			reg = <0x1fd00000 0x10000>,	/* GICD */
+			      <0x1fd80000 0x80000>;	/* GICR */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
+
+#include "uniphier-pinctrl.dtsi"
-- 
2.25.1

