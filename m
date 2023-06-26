Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AFD73DBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjFZJxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjFZJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:53:20 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800829B;
        Mon, 26 Jun 2023 02:52:32 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 26 Jun 2023
 17:52:29 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH 2/2] arm64: dts: add support for T7 based Amlogic AN400
Date:   Mon, 26 Jun 2023 17:52:23 +0800
Message-ID: <20230626095223.721011-3-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic T7 is an advanced application processor designed for smart display.

Add basic support for the T7 based Amlogic AN400 board, which describes
the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/amlogic-t7-a311d2-an400.dts   |  30 ++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 156 ++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 6f61798a109f..99299731f5d4 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
+dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
new file mode 100644
index 000000000000..7ce1975b99e4
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-t7.dtsi"
+
+/ {
+	model = "Amlogic A311D2 AN400 Development Board";
+	compatible = "amlogic,an400", "amlogic,t7";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart_a;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		linux,usable-memory = <0x00000000 0x00000000 0x00000000 0xE0000000
+					0x00000001 0x00000000 0x00000000 0x20000000>;
+	};
+};
+
+&uart_a {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
new file mode 100644
index 000000000000..d3ee864f0d40
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	cpus:cpus {
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
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0:cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1:cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2:cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3:cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+
+		cpu4:cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu5:cpu@101{
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+		};
+
+		cpu6:cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+		};
+
+		cpu7:cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@fff01000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfff01000 0 0x1000>,
+			    <0x0 0xfff02000 0 0x0100>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+		     };
+
+		apb4: bus@fe000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xfe000000 0x0 0x480000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+
+			uart_a: serial@78000 {
+				compatible = "amlogic,meson-s4-uart",
+					     "amlogic,meson-ao-uart";
+				reg = <0x0 0x78000 0x0 0x18>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&xtal>,<&xtal>,<&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+			};
+		};
+	};
+};
-- 
2.37.1

