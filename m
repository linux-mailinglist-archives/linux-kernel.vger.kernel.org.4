Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7B654115
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiLVMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiLVMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:33:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7D4222523;
        Thu, 22 Dec 2022 04:33:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B07152F4;
        Thu, 22 Dec 2022 04:33:42 -0800 (PST)
Received: from e126835.arm.com (unknown [10.57.87.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C08C3FA32;
        Thu, 22 Dec 2022 04:32:56 -0800 (PST)
From:   Emekcan Aras <emekcan.aras@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emekcan Aras <emekcan.aras@arm.com>
Subject: [PATCH v3 1/2] arm: dts: arm: add arm corstone500 device tree
Date:   Thu, 22 Dec 2022 12:32:43 +0000
Message-Id: <20221222123244.147238-2-emekcan.aras@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222123244.147238-1-emekcan.aras@arm.com>
References: <20221222123244.147238-1-emekcan.aras@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corstone500[0] is a platform from arm, which includes Cortex-A cores and
ideal starting point for feature rich System on Chip (SoC) designs
based on the Cortex-A5 core.

These device trees contains the necessary bits to support the
Corstone 500 FVP (Fixed Virtual Platform) and the
FPGA MPS3 board.

0: https://developer.arm.com/documentation/102262/0000

Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
---
 arch/arm/boot/dts/Makefile        |   3 +-
 arch/arm/boot/dts/corstone500.dts | 182 ++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/corstone500.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6aa7dc4db2fc..4dc4df0707dc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1465,7 +1465,8 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += \
 	vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
-	vexpress-v2p-ca15_a7.dtb
+	vexpress-v2p-ca15_a7.dtb \
+	corstone500.dtb
 dtb-$(CONFIG_ARCH_VIRT) += \
 	xenvm-4.2.dtb
 dtb-$(CONFIG_ARCH_VT8500) += \
diff --git a/arch/arm/boot/dts/corstone500.dts b/arch/arm/boot/dts/corstone500.dts
new file mode 100644
index 000000000000..bcca7d736c85
--- /dev/null
+++ b/arch/arm/boot/dts/corstone500.dts
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/*
+ * Copyright (c) 2022, Arm Limited. All rights reserved.
+ *
+ */
+
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "ARM Corstone500";
+	compatible = "arm,corstone500";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+		cpu_on = <0x84000003>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "psci";
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x7f000000>;
+	};
+
+	L2: cache-controller@1c010000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x1c010000 0x1000>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		cache-level = <2>;
+		cache-unified;
+		arm,data-latency = <1 1 1>;
+		arm,tag-latency = <1 1 1>;
+	};
+
+	refclk7500khz: clock-refclk7500khz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <7500000>;
+		clock-output-names = "apb_pclk";
+	};
+
+	refclk24mhz: clock-refclk24mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "apb_pclk";
+	};
+
+	smbclk: clock-refclk24mhzx2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+		clock-output-names = "smclk";
+	};
+
+
+	gic: interrupt-controller@1c001000 {
+		compatible = "arm,cortex-a5-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg =	<0x1c001000 0x1000>,
+			<0x1c000100 0x100>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+			IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	soc{
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clock_frequency = <50000000>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		uart0: serial@1a200000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1a200000 0x1000>;
+			interrupts = <GIC_SPI 8 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&refclk7500khz>;
+			clock-names = "apb_pclk";
+		};
+
+		uart1: serial@1a210000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1a210000 0x1000>;
+			interrupts = <GIC_SPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&refclk7500khz>;
+			clock-names = "apb_pclk";
+		};
+
+		timer0: timer@1a040000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x1a040000 0x1000>;
+			clock-frequency = <7500000>;
+
+			frame@1a050000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 2 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+				reg = <0x1a050000 0x1000>;
+			};
+		};
+
+		smsc: ethernet@4020000 {
+			compatible = "smsc,lan9220", "smsc,lan9115";
+			reg = <0x40200000 0x10000>;
+			interrupts = <GIC_SPI 43 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+			reg-io-width = <4>;
+			phy-mode = "mii";
+			smsc,irq-active-high;
+			vdd33a-supply = <&v2m_fixed_3v3>;
+			vddvario-supply = <&v2m_fixed_3v3>;
+		};
+
+		rtc@1a220000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x1a220000 0x1000>;
+			clocks = <&refclk24mhz>;
+			interrupts = <GIC_SPI 6 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
+			clock-names = "apb_pclk";
+		};
+	};
+
+	v2m_fixed_3v3: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
-- 
2.25.1

