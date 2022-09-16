Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6625BAF62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIPO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiIPOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:25:59 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32407B2D89;
        Fri, 16 Sep 2022 07:25:56 -0700 (PDT)
Received: from robin.home.jannau.net (unknown [91.200.110.112])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 29A6426F07D;
        Fri, 16 Sep 2022 16:25:54 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/10] arm64: dts: apple: Add initial t6000/t6001/t6002 DTs
Date:   Fri, 16 Sep 2022 16:25:45 +0200
Message-Id: <20220916142550.269905-6-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916142550.269905-1-j@jannau.net>
References: <20220916142550.269905-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

These SoCs are found in Apple devices with M1 Pro (t6000), M1 Max
(t6001) and M1 Ultra (t6002).

t6000 is a cut-down version of t6001, so the former just includes the
latter and disables the missing bits (This is currently just one PMGR
node and all of its domains.

t6002 is two connected t6001 dies. The implementation seems to use
t6001 with blocks disabled (mostly on the second die). MMIO addresses on
the second die have a constant offset. The interrupt controller is
multi-die aware. This setup can be represented in the device tree with
two top level "soc" nodes. The MMIO offset is applied via "ranges" and
devices are included with preproceesor macros to make the node labels
unique and to specify the die number for the interrupt definition.

Device nodes are distributed over dtsi files based on whether they are
present on both dies or just on the first die. The only execption is the
NVMe controller which resides on the second die. Its nodes are in a
separate file.

Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>

---

Changes in v1:
- added proper ranges for t6002 soc nodes
- use unit addresses from ranges for t6002 soc nodes
- C preprocessor cleanup

 arch/arm64/boot/dts/apple/multi-die-cpp.h     |   22 +
 arch/arm64/boot/dts/apple/t6000.dtsi          |   18 +
 arch/arm64/boot/dts/apple/t6001.dtsi          |   63 +
 arch/arm64/boot/dts/apple/t6002.dtsi          |  175 ++
 arch/arm64/boot/dts/apple/t600x-common.dtsi   |  128 ++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi     |  298 +++
 arch/arm64/boot/dts/apple/t600x-dieX.dtsi     |  103 +
 .../arm64/boot/dts/apple/t600x-gpio-pins.dtsi |   45 +
 arch/arm64/boot/dts/apple/t600x-nvme.dtsi     |   42 +
 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi     | 2012 +++++++++++++++++
 10 files changed, 2906 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
 create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/multi-die-cpp.h b/arch/arm64/boot/dts/apple/multi-die-cpp.h
new file mode 100644
index 000000000000..39e8953bf809
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/multi-die-cpp.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT
+ *
+ * C preprocessor macros for t600x multi die support.
+ */
+
+#ifndef __DTS_APPLE_MULTI_DIE_CPP_H
+#define __DTS_APPLE_MULTI_DIE_CPP_H
+
+#ifndef __stringify
+#define __stringify_1(x...)     #x
+#define __stringify(x...)       __stringify_1(x)
+#endif
+
+#ifndef __concat
+#define __concat_1(x, y...)     x ## y
+#define __concat(x, y...)       __concat_1(x, y)
+#endif
+
+#define DIE_NODE(a) __concat(a, DIE)
+#define DIE_LABEL(a) __stringify(__concat(a, DIE))
+
+#endif /* !__DTS_APPLE_MULTI_DIE_CPP_H */
diff --git a/arch/arm64/boot/dts/apple/t6000.dtsi b/arch/arm64/boot/dts/apple/t6000.dtsi
new file mode 100644
index 000000000000..89c3b211b116
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6000.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6000 "M1 Pro" SoC
+ *
+ * Other names: H13J, "Jade Chop"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/* This chip is just a cut down version of t6001, so include it and disable the missing parts */
+
+#include "t6001.dtsi"
+
+/ {
+	compatible = "apple,t6000", "apple,arm-platform";
+};
+
+/delete-node/ &pmgr_south;
diff --git a/arch/arm64/boot/dts/apple/t6001.dtsi b/arch/arm64/boot/dts/apple/t6001.dtsi
new file mode 100644
index 000000000000..620b17e4031f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6001.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6001 "M1 Max" SoC
+ *
+ * Other names: H13J, "Jade"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+#include "multi-die-cpp.h"
+
+#include "t600x-common.dtsi"
+
+/ {
+	compatible = "apple,t6001", "apple,arm-platform";
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges;
+		nonposted-mmio;
+
+		// filled via templated includes at the end of the file
+	};
+};
+
+#define DIE
+#define DIE_NO 0
+
+&{/soc} {
+	#include "t600x-die0.dtsi"
+	#include "t600x-dieX.dtsi"
+	#include "t600x-nvme.dtsi"
+};
+
+#include "t600x-gpio-pins.dtsi"
+#include "t600x-pmgr.dtsi"
+
+#undef DIE
+#undef DIE_NO
+
+
+&aic {
+	affinities {
+		e-core-pmu-affinity {
+			apple,fiq-index = <AIC_CPU_PMU_E>;
+			cpus = <&cpu_e00 &cpu_e01>;
+		};
+
+		p-core-pmu-affinity {
+			apple,fiq-index = <AIC_CPU_PMU_P>;
+			cpus = <&cpu_p00 &cpu_p01 &cpu_p02 &cpu_p03
+				&cpu_p10 &cpu_p11 &cpu_p12 &cpu_p13>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
new file mode 100644
index 000000000000..3b1677ba5262
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6002.dtsi
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6002 "M1 Ultra" SoC
+ *
+ * Other names: H13J, "Jade 2C"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+#include "multi-die-cpp.h"
+
+#include "t600x-common.dtsi"
+
+/ {
+	compatible = "apple,t6002", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		cpu_e10: cpu@800 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x800>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_e11: cpu@801 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x801>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p20: cpu@10900 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10900>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p21: cpu@10901 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10901>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p22: cpu@10902 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10902>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p23: cpu@10903 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10903>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p30: cpu@10a00 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10a00>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p31: cpu@10a01 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10a01>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p32: cpu@10a02 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10a02>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p33: cpu@10a03 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10a03>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+	};
+
+	die0: soc@200000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x2 0x0 0x2 0x0 0x4 0x0>,
+			 <0x5 0x80000000 0x5 0x80000000 0x1 0x80000000>,
+			 <0x7 0x0 0x7 0x0 0xf 0x80000000>;
+		nonposted-mmio;
+
+		// filled via templated includes at the end of the file
+	};
+
+	die1: soc@2200000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x2 0x0 0x22 0x0 0x4 0x0>,
+			 <0x7 0x0 0x27 0x0 0xf 0x80000000>;
+		nonposted-mmio;
+
+		// filled via templated includes at the end of the file
+	};
+};
+
+#define DIE
+#define DIE_NO 0
+
+&die0 {
+	#include "t600x-die0.dtsi"
+	#include "t600x-dieX.dtsi"
+};
+
+#include "t600x-pmgr.dtsi"
+#include "t600x-gpio-pins.dtsi"
+
+#undef DIE
+#undef DIE_NO
+
+#define DIE _die1
+#define DIE_NO 1
+
+&die1 {
+	#include "t600x-dieX.dtsi"
+	#include "t600x-nvme.dtsi"
+};
+
+#include "t600x-pmgr.dtsi"
+
+#undef DIE
+#undef DIE_NO
+
+
+&aic {
+	affinities {
+		e-core-pmu-affinity {
+			apple,fiq-index = <AIC_CPU_PMU_E>;
+			cpus = <&cpu_e00 &cpu_e01
+				&cpu_e10 &cpu_e11>;
+		};
+
+		p-core-pmu-affinity {
+			apple,fiq-index = <AIC_CPU_PMU_P>;
+			cpus = <&cpu_p00 &cpu_p01 &cpu_p02 &cpu_p03
+				&cpu_p10 &cpu_p11 &cpu_p12 &cpu_p13
+				&cpu_p20 &cpu_p21 &cpu_p22 &cpu_p23
+				&cpu_p30 &cpu_p31 &cpu_p32 &cpu_p33>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-common.dtsi b/arch/arm64/boot/dts/apple/t600x-common.dtsi
new file mode 100644
index 000000000000..e29b88e2c853
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-common.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Common Apple T6000 / T6001 / T6002 "M1 Pro/Max/Ultra" SoC
+ *
+ * Other names: H13J, "Jade Chop", "Jade", "Jade 2C"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu_e00: cpu@0 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_e01: cpu@1 {
+			compatible = "apple,icestorm";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p00: cpu@10100 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p01: cpu@10101 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p02: cpu@10102 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p03: cpu@10103 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p10: cpu@10200 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p11: cpu@10201 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p12: cpu@10202 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10202>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+
+		cpu_p13: cpu@10203 {
+			compatible = "apple,firestorm";
+			device_type = "cpu";
+			reg = <0x0 0x10203>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+		};
+	};
+
+	pmu-e {
+		compatible = "apple,icestorm-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,firestorm-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ 0 AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <AIC_FIQ 0 AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ 0 AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ 0 AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ 0 AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
new file mode 100644
index 000000000000..2d66eead8aee
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Devices used on die 0 on the Apple T6002 "M1 Ultra" SoC and present on
+ * Apple T6000 / T6001 "M1 Pro" / "M1 Max".
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+
+	aic: interrupt-controller@28e100000 {
+		compatible = "apple,t6000-aic", "apple,aic2";
+		#interrupt-cells = <4>;
+		interrupt-controller;
+		reg = <0x2 0x8e100000 0x0 0xc000>,
+			<0x2 0x8e10c000 0x0 0x4>;
+		reg-names = "core", "event";
+		power-domains = <&ps_aic>;
+	};
+
+	pinctrl_smc: pinctrl@290820000 {
+		compatible = "apple,t6000-pinctrl", "apple,pinctrl";
+		reg = <0x2 0x90820000 0x0 0x4000>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl_smc 0 0 30>;
+		apple,npins = <30>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 743 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 744 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 745 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 746 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 747 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 748 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 749 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	wdt: watchdog@2922b0000 {
+		compatible = "apple,t6000-wdt", "apple,wdt";
+		reg = <0x2 0x922b0000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 631 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	i2c0: i2c@39b040000 {
+		compatible = "apple,t6000-i2c", "apple,i2c";
+		reg = <0x3 0x9b040000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1119 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c0_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c0>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+	};
+
+	i2c1: i2c@39b044000 {
+		compatible = "apple,t6000-i2c", "apple,i2c";
+		reg = <0x3 0x9b044000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1120 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c1_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c1>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@39b048000 {
+		compatible = "apple,t6000-i2c", "apple,i2c";
+		reg = <0x3 0x9b048000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1121 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c2_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c2>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@39b04c000 {
+		compatible = "apple,t6000-i2c", "apple,i2c";
+		reg = <0x3 0x9b04c000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1122 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c3_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c3>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c4: i2c@39b050000 {
+		compatible = "apple,t6000-i2c", "apple,i2c";
+		reg = <0x3 0x9b050000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1123 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c4_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c4>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c5: i2c@39b054000 {
+		compatible = "apple,t6000-i2c", "apple,i2c";
+		reg = <0x3 0x9b054000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1124 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c5_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c5>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	serial0: serial@39b200000 {
+		compatible = "apple,s5l-uart";
+		reg = <0x3 0x9b200000 0x0 0x1000>;
+		reg-io-width = <4>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1097 IRQ_TYPE_LEVEL_HIGH>;
+		/*
+		 * TODO: figure out the clocking properly, there may
+		 * be a third selectable clock.
+		 */
+		clocks = <&clkref>, <&clkref>;
+		clock-names = "uart", "clk_uart_baud0";
+		power-domains = <&ps_uart0>;
+		status = "disabled";
+	};
+
+	pcie0_dart_0: dart@581008000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x5 0x81008000 0x0 0x4000>;
+		#iommu-cells = <1>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1271 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&ps_apcie_gp_sys>;
+	};
+
+	pcie0_dart_1: dart@582008000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x5 0x82008000 0x0 0x4000>;
+		#iommu-cells = <1>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1274 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&ps_apcie_gp_sys>;
+	};
+
+	pcie0_dart_2: dart@583008000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x5 0x83008000 0x0 0x4000>;
+		#iommu-cells = <1>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1277 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&ps_apcie_gp_sys>;
+	};
+
+	pcie0_dart_3: dart@584008000 {
+		compatible = "apple,t6000-dart";
+		reg = <0x5 0x84008000 0x0 0x4000>;
+		#iommu-cells = <1>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1280 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&ps_apcie_gp_sys>;
+	};
+
+	pcie0: pcie@590000000 {
+		compatible = "apple,t6000-pcie", "apple,pcie";
+		device_type = "pci";
+
+		reg = <0x5 0x90000000 0x0 0x1000000>,
+			<0x5 0x80000000 0x0 0x100000>,
+			<0x5 0x81000000 0x0 0x4000>,
+			<0x5 0x82000000 0x0 0x4000>,
+			<0x5 0x83000000 0x0 0x4000>,
+			<0x5 0x84000000 0x0 0x4000>;
+		reg-names = "config", "rc", "port0", "port1", "port2", "port3";
+
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1270 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 1273 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 1276 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 1279 IRQ_TYPE_LEVEL_HIGH>;
+
+		msi-controller;
+		msi-parent = <&pcie0>;
+		msi-ranges = <&aic AIC_IRQ 0 1581 IRQ_TYPE_EDGE_RISING 32>;
+
+
+		iommu-map = <0x100 &pcie0_dart_0 1 1>,
+				<0x200 &pcie0_dart_1 1 1>,
+				<0x300 &pcie0_dart_2 1 1>,
+				<0x400 &pcie0_dart_3 1 1>;
+		iommu-map-mask = <0xff00>;
+
+		bus-range = <0 4>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x43000000 0x5 0xa0000000 0x5 0xa0000000 0x0 0x20000000>,
+				<0x02000000 0x0 0xc0000000 0x5 0xc0000000 0x0 0x40000000>;
+
+		power-domains = <&ps_apcie_gp_sys>;
+		pinctrl-0 = <&pcie_pins>;
+		pinctrl-names = "default";
+
+		port00: pci@0,0 {
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			reset-gpios = <&pinctrl_ap 4 GPIO_ACTIVE_LOW>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
+					<0 0 0 2 &port00 0 0 0 1>,
+					<0 0 0 3 &port00 0 0 0 2>,
+					<0 0 0 4 &port00 0 0 0 3>;
+		};
+
+		port01: pci@1,0 {
+			device_type = "pci";
+			reg = <0x800 0x0 0x0 0x0 0x0>;
+			reset-gpios = <&pinctrl_ap 5 GPIO_ACTIVE_LOW>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &port01 0 0 0 0>,
+					<0 0 0 2 &port01 0 0 0 1>,
+					<0 0 0 3 &port01 0 0 0 2>,
+					<0 0 0 4 &port01 0 0 0 3>;
+		};
+
+		port02: pci@2,0 {
+			device_type = "pci";
+			reg = <0x1000 0x0 0x0 0x0 0x0>;
+			reset-gpios = <&pinctrl_ap 6 GPIO_ACTIVE_LOW>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &port02 0 0 0 0>,
+					<0 0 0 2 &port02 0 0 0 1>,
+					<0 0 0 3 &port02 0 0 0 2>,
+					<0 0 0 4 &port02 0 0 0 3>;
+		};
+
+		port03: pci@3,0 {
+			device_type = "pci";
+			reg = <0x1800 0x0 0x0 0x0 0x0>;
+			reset-gpios = <&pinctrl_ap 7 GPIO_ACTIVE_LOW>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &port03 0 0 0 0>,
+					<0 0 0 2 &port03 0 0 0 1>,
+					<0 0 0 3 &port03 0 0 0 2>,
+					<0 0 0 4 &port03 0 0 0 3>;
+		};
+	};
diff --git a/arch/arm64/boot/dts/apple/t600x-dieX.dtsi b/arch/arm64/boot/dts/apple/t600x-dieX.dtsi
new file mode 100644
index 000000000000..0a437b68e86c
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-dieX.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Devices used on both dies on the Apple T6002 "M1 Ultra" and present on
+ * Apple T6000/T6001 "M1 Pro/Max".
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+	DIE_NODE(pmgr): power-management@28e080000 {
+		compatible = "apple,t6000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x2 0x8e080000 0 0x4000>;
+	};
+
+	DIE_NODE(pmgr_east): power-management@28e580000 {
+		compatible = "apple,t6000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x2 0x8e580000 0 0xc000>;
+	};
+
+	DIE_NODE(pmgr_south): power-management@28e680000 {
+		compatible = "apple,t6000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x2 0x8e680000 0 0xc000>;
+	};
+
+	DIE_NODE(pinctrl_nub): pinctrl@2921f0000 {
+		compatible = "apple,t6000-pinctrl", "apple,pinctrl";
+		reg = <0x2 0x921f0000 0x0 0x4000>;
+		power-domains = <&DIE_NODE(ps_nub_gpio)>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&DIE_NODE(pinctrl_nub) 0 0 16>;
+		apple,npins = <16>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 623 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 624 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 625 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 626 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 627 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 628 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 629 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	DIE_NODE(pmgr_mini): power-management@292280000 {
+		compatible = "apple,t6000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x2 0x92280000 0 0x4000>;
+	};
+
+	DIE_NODE(pinctrl_aop): pinctrl@293820000 {
+		compatible = "apple,t6000-pinctrl", "apple,pinctrl";
+		reg = <0x2 0x93820000 0x0 0x4000>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&DIE_NODE(pinctrl_aop) 0 0 63>;
+		apple,npins = <63>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 567 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 568 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 569 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 570 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 571 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 572 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 573 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	DIE_NODE(pinctrl_ap): pinctrl@39b028000 {
+		compatible = "apple,t6000-pinctrl", "apple,pinctrl";
+		reg = <0x3 0x9b028000 0x0 0x4000>;
+
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 427 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 428 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 429 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 430 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 431 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 432 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 433 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&clkref>;
+		power-domains = <&DIE_NODE(ps_gpio)>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&DIE_NODE(pinctrl_ap) 0 0 255>;
+		apple,npins = <255>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
diff --git a/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi b/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
new file mode 100644
index 000000000000..b31f1a7a2b3f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * GPIO pin mappings for Apple T600x SoCs.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pinctrl_ap {
+	i2c0_pins: i2c0-pins {
+		pinmux = <APPLE_PINMUX(92, 1)>,
+			<APPLE_PINMUX(93, 1)>;
+	};
+
+	i2c1_pins: i2c1-pins {
+		pinmux = <APPLE_PINMUX(94, 1)>,
+			<APPLE_PINMUX(95, 1)>;
+	};
+
+	i2c2_pins: i2c2-pins {
+		pinmux = <APPLE_PINMUX(96, 1)>,
+			<APPLE_PINMUX(97, 1)>;
+	};
+
+	i2c3_pins: i2c3-pins {
+		pinmux = <APPLE_PINMUX(98, 1)>,
+			<APPLE_PINMUX(99, 1)>;
+	};
+
+	i2c4_pins: i2c4-pins {
+		pinmux = <APPLE_PINMUX(8, 1)>,
+			<APPLE_PINMUX(9, 1)>;
+	};
+
+	i2c5_pins: i2c5-pins {
+		pinmux = <APPLE_PINMUX(100, 1)>,
+			<APPLE_PINMUX(101, 1)>;
+	};
+
+	pcie_pins: pcie-pins {
+		pinmux = <APPLE_PINMUX(0, 1)>,
+				<APPLE_PINMUX(1, 1)>,
+				<APPLE_PINMUX(2, 1)>,
+				<APPLE_PINMUX(3, 1)>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-nvme.dtsi b/arch/arm64/boot/dts/apple/t600x-nvme.dtsi
new file mode 100644
index 000000000000..7dff738d317e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-nvme.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * NVMe related devices for Apple T600x SoCs.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+	DIE_NODE(ans_mbox): mbox@38f408000 {
+		compatible = "apple,t6000-asc-mailbox", "apple,asc-mailbox-v4";
+		reg = <0x3 0x8f408000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 1069 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ DIE_NO 1070 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ DIE_NO 1071 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ DIE_NO 1072 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "send-empty", "send-not-empty",
+			"recv-empty", "recv-not-empty";
+		power-domains = <&DIE_NODE(ps_ans2)>;
+		#mbox-cells = <0>;
+	};
+
+	DIE_NODE(sart): sart@393c50000 {
+		compatible = "apple,t6000-sart";
+		reg = <0x3 0x93c50000 0x0 0x10000>;
+		power-domains = <&DIE_NODE(ps_ans2)>;
+	};
+
+	DIE_NODE(nvme): nvme@393cc0000 {
+		compatible = "apple,t6000-nvme-ans2", "apple,nvme-ans2";
+		reg = <0x3 0x93cc0000 0x0 0x40000>, <0x3 0x8f400000 0x0 0x4000>;
+		reg-names = "nvme", "ans";
+		interrupt-parent = <&aic>;
+		/* The NVME interrupt is always routed to die */
+		interrupts = <AIC_IRQ 0 1613 IRQ_TYPE_LEVEL_HIGH>;
+		mboxes = <&DIE_NODE(ans_mbox)>;
+		apple,sart = <&DIE_NODE(sart)>;
+		power-domains = <&DIE_NODE(ps_ans2)>,
+			<&DIE_NODE(ps_apcie_st_sys)>,
+			<&DIE_NODE(ps_apcie_st1_sys)>;
+		power-domain-names = "ans", "apcie0", "apcie1";
+		resets = <&DIE_NODE(ps_ans2)>;
+	};
diff --git a/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi b/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
new file mode 100644
index 000000000000..b8daeb0368d5
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
@@ -0,0 +1,2012 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T6001 "M1 Max" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&DIE_NODE(pmgr) {
+	DIE_NODE(ps_pms_bridge): power-controller@100 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_bridge);
+		apple,always-on; /* Core device */
+	};
+
+	DIE_NODE(ps_aic): power-controller@108 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(aic);
+		apple,always-on; /* Core device */
+	};
+
+	DIE_NODE(ps_dwi): power-controller@110 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dwi);
+		apple,always-on; /* Core device */
+	};
+
+	DIE_NODE(ps_pms): power-controller@118 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms);
+		apple,always-on; /* Core device */
+	};
+
+	DIE_NODE(ps_gpio): power-controller@120 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(gpio);
+		power-domains = <&DIE_NODE(ps_pms)>, <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_soc_dpe): power-controller@128 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(soc_dpe);
+		apple,always-on; /* Core device */
+	};
+
+	DIE_NODE(ps_pmgr_soc_ocla): power-controller@130 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pmgr_soc_ocla);
+		power-domains = <&DIE_NODE(ps_pms)>;
+	};
+
+	DIE_NODE(ps_pcie0_ref): power-controller@138 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pcie0_ref);
+	};
+
+	DIE_NODE(ps_pcie1_ref): power-controller@140 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pcie1_ref);
+	};
+
+	DIE_NODE(ps_apcie_st): power-controller@148 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_st);
+		power-domains = <&DIE_NODE(ps_pcie1_ref)>;
+	};
+
+	DIE_NODE(ps_apcie_gp): power-controller@150 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_gp);
+		power-domains = <&DIE_NODE(ps_pcie0_ref)>;
+	};
+
+	DIE_NODE(ps_devc0_ivdmc): power-controller@180 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(devc0_ivdmc);
+	};
+
+	DIE_NODE(ps_amcc0): power-controller@188 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc0);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_amcc2): power-controller@190 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc2);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_dcs_00): power-controller@198 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_00);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_01): power-controller@1a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_01);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_02): power-controller@1a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_02);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_03): power-controller@1b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_03);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_08): power-controller@1b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_08);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_09): power-controller@1c0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_09);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_10): power-controller@1c8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_10);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_11): power-controller@1d0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_11);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_afi): power-controller@1d8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afi);
+		apple,always-on; /* Apple Fabric, CPU interface is here */
+	};
+
+	DIE_NODE(ps_afc): power-controller@1e0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afc);
+		apple,always-on; /* Apple Fabric, CPU interface is here */
+	};
+
+	DIE_NODE(ps_afr): power-controller@1e8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afr);
+		/* Apple Fabric, media DIE_NODE(stuff): this can power down */
+	};
+
+	DIE_NODE(ps_afnc1_ioa): power-controller@1f0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_ioa);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc0_ioa): power-controller@1f8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc0_ioa);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc1_ls): power-controller@200 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_ls);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc1_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc0_ls): power-controller@208 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc0_ls);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc0_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc1_lw0): power-controller@210 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_lw0);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc1_ls)>;
+	};
+
+	DIE_NODE(ps_afnc1_lw1): power-controller@218 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_lw1);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc1_ls)>;
+	};
+
+	DIE_NODE(ps_afnc1_lw2): power-controller@220 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_lw2);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc1_ls)>;
+	};
+
+	DIE_NODE(ps_afnc0_lw0): power-controller@228 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc0_lw0);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc0_ls)>;
+	};
+
+	DIE_NODE(ps_scodec): power-controller@230 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(scodec);
+		power-domains = <&DIE_NODE(ps_afnc1_lw0)>;
+	};
+
+	DIE_NODE(ps_atc0_common): power-controller@238 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_common);
+		power-domains = <&DIE_NODE(ps_afnc1_lw1)>;
+	};
+
+	DIE_NODE(ps_atc1_common): power-controller@240 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_common);
+		power-domains = <&DIE_NODE(ps_afnc1_lw1)>;
+	};
+
+	DIE_NODE(ps_c0_usb31drd): power-controller@248 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(c0_usb31drd);
+		power-domains = <&DIE_NODE(ps_usb)>;
+	};
+
+	DIE_NODE(ps_c1_usb31drd): power-controller@250 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(c1_usb31drd);
+		power-domains = <&DIE_NODE(ps_usb)>;
+	};
+
+	DIE_NODE(ps_dispext0_fe): power-controller@258 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext0_fe);
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_dispext1_fe): power-controller@260 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext1_fe);
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_ane_sys): power-controller@268 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_sys);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_avd_sys): power-controller@270 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(avd_sys);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_dispext0_cpu0): power-controller@280 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext0_cpu0);
+		power-domains = <&DIE_NODE(ps_dispext0_fe)>;
+	};
+
+	DIE_NODE(ps_dispext1_cpu0): power-controller@2a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext1_cpu0);
+		power-domains = <&DIE_NODE(ps_dispext1_fe)>;
+	};
+
+	DIE_NODE(ps_ane_sys_cpu): power-controller@2c8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_sys_cpu);
+		power-domains = <&DIE_NODE(ps_ane_sys)>;
+	};
+
+#if DIE_NO == 0
+	/* PMP is only present on die 0 of the M1 Ultra */
+	DIE_NODE(ps_pmp): power-controller@2d8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pmp);
+	};
+#endif
+
+	DIE_NODE(ps_pms_sram): power-controller@2e0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_sram);
+	};
+
+	DIE_NODE(ps_apcie_st_sys): power-controller@2e8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_st_sys);
+		power-domains = <&DIE_NODE(ps_apcie_st)>, <&DIE_NODE(ps_ans2)>;
+	};
+
+	DIE_NODE(ps_apcie_st1_sys): power-controller@2f0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_st1_sys);
+		power-domains = <&DIE_NODE(ps_apcie_st)>, <&DIE_NODE(ps_ans2)>;
+	};
+
+	DIE_NODE(ps_atc2_common): power-controller@2f8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_common);
+		power-domains = <&DIE_NODE(ps_afnc1_lw1)>;
+	};
+
+	DIE_NODE(ps_atc3_common): power-controller@300 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_common);
+		power-domains = <&DIE_NODE(ps_afnc1_lw1)>;
+	};
+
+	DIE_NODE(ps_usb): power-controller@318 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(usb);
+		power-domains = <&DIE_NODE(ps_afnc1_lw2)>;
+	};
+
+	DIE_NODE(ps_apcie_gp_sys): power-controller@320 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_gp_sys);
+		power-domains = <&DIE_NODE(ps_afnc1_lw2)>, <&DIE_NODE(ps_apcie_gp)>;
+		apple,always-on; /* Breaks things if shut down */
+	};
+
+	DIE_NODE(ps_atc0_cio): power-controller@328 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_cio);
+		power-domains = <&DIE_NODE(ps_atc0_common)>;
+	};
+
+	DIE_NODE(ps_atc0_pcie): power-controller@330 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_pcie);
+		power-domains = <&DIE_NODE(ps_atc0_common)>;
+	};
+
+	DIE_NODE(ps_atc1_cio): power-controller@338 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_cio);
+		power-domains = <&DIE_NODE(ps_atc1_common)>;
+	};
+
+	DIE_NODE(ps_atc1_pcie): power-controller@340 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_pcie);
+		power-domains = <&DIE_NODE(ps_atc1_common)>;
+	};
+
+	DIE_NODE(ps_atc2_cio): power-controller@348 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_cio);
+		power-domains = <&DIE_NODE(ps_atc2_common)>;
+	};
+
+	DIE_NODE(ps_atc2_pcie): power-controller@350 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_pcie);
+		power-domains = <&DIE_NODE(ps_atc2_common)>;
+	};
+
+	DIE_NODE(ps_atc3_cio): power-controller@358 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_cio);
+		power-domains = <&DIE_NODE(ps_atc3_common)>;
+	};
+
+	DIE_NODE(ps_atc3_pcie): power-controller@360 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_pcie);
+		power-domains = <&DIE_NODE(ps_atc3_common)>;
+	};
+
+	DIE_NODE(ps_c0_usbctl): power-controller@368 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(c0_usbctl);
+		power-domains = <&DIE_NODE(ps_usb)>;
+	};
+
+	DIE_NODE(ps_c1_usbctl): power-controller@370 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(c1_usbctl);
+		power-domains = <&DIE_NODE(ps_usb)>;
+	};
+
+	DIE_NODE(ps_atc0_cio_pcie): power-controller@378 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc0_cio)>;
+	};
+
+	DIE_NODE(ps_atc0_cio_usb): power-controller@380 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc0_cio)>;
+	};
+
+	DIE_NODE(ps_atc1_cio_pcie): power-controller@388 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc1_cio)>;
+	};
+
+	DIE_NODE(ps_atc1_cio_usb): power-controller@390 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc1_cio)>;
+	};
+
+	DIE_NODE(ps_atc2_cio_pcie): power-controller@398 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc2_cio)>;
+	};
+
+	DIE_NODE(ps_atc2_cio_usb): power-controller@3a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc2_cio)>;
+	};
+
+	DIE_NODE(ps_atc3_cio_pcie): power-controller@3a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc3_cio)>;
+	};
+
+	DIE_NODE(ps_atc3_cio_usb): power-controller@3b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc3_cio)>;
+	};
+
+	DIE_NODE(ps_trace_fab): power-controller@3b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(trace_fab);
+	};
+};
+
+&DIE_NODE(pmgr_east) {
+	DIE_NODE(ps_clvr_spmi0): power-controller@100 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(clvr_spmi0);
+		apple,always-on; /* PCPU voltage regulator interface (used by SMC) */
+	};
+
+	DIE_NODE(ps_clvr_spmi1): power-controller@108 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(clvr_spmi1);
+		apple,always-on; /* GPU voltage regulator interface (used by SMC) */
+	};
+
+	DIE_NODE(ps_clvr_spmi2): power-controller@110 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(clvr_spmi2);
+		apple,always-on; /* ANE, fabric, AFR voltage regulator interface (used by SMC) */
+	};
+
+	DIE_NODE(ps_clvr_spmi3): power-controller@118 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(clvr_spmi3);
+		apple,always-on; /* Additional voltage regulator, probably used on T6001 (SMC) */
+	};
+
+	DIE_NODE(ps_clvr_spmi4): power-controller@120 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(clvr_spmi4);
+		apple,always-on; /* Additional voltage regulator, probably used on T6001 (SMC) */
+	};
+
+	DIE_NODE(ps_ispsens0): power-controller@128 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ispsens0);
+	};
+
+	DIE_NODE(ps_ispsens1): power-controller@130 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ispsens1);
+	};
+
+	DIE_NODE(ps_ispsens2): power-controller@138 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ispsens2);
+	};
+
+	DIE_NODE(ps_ispsens3): power-controller@140 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ispsens3);
+	};
+
+	DIE_NODE(ps_afnc2_ioa): power-controller@148 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_ioa);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc2_ls): power-controller@150 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_ls);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc2_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc2_lw0): power-controller@158 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_lw0);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc2_ls)>;
+	};
+
+	DIE_NODE(ps_afnc2_lw1): power-controller@160 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_lw1);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc2_ls)>;
+	};
+
+	DIE_NODE(ps_afnc3_ioa): power-controller@168 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_ioa);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc3_ls): power-controller@170 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_ls);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc3_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc3_lw0): power-controller@178 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_lw0);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc3_ls)>;
+	};
+
+	DIE_NODE(ps_sio): power-controller@180 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_sio_cpu): power-controller@188 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_cpu);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_fpwm0): power-controller@190 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(fpwm0);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_fpwm1): power-controller@198 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(fpwm1);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_fpwm2): power-controller@1a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(fpwm2);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c0): power-controller@1a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c0);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c1): power-controller@1b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c1);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c2): power-controller@1b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c2);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c3): power-controller@1c0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c3);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c4): power-controller@1c8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c4);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c5): power-controller@1d0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c5);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c6): power-controller@1d8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c6);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c7): power-controller@1e0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c7);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_spi_p): power-controller@1e8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi_p);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_spi0): power-controller@1f0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi0);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi1): power-controller@1f8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi1);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi2): power-controller@200 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi2);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi3): power-controller@208 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi3);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi4): power-controller@210 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi4);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_sio_spmi0): power-controller@218 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_spmi0);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_sio_spmi1): power-controller@220 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_spmi1);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_sio_spmi2): power-controller@228 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_spmi2);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_uart_p): power-controller@230 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart_p);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_uart_n): power-controller@238 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart_n);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart0): power-controller@240 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart0);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart1): power-controller@248 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart1);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart2): power-controller@250 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart2);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart3): power-controller@258 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart3);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart4): power-controller@260 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart4);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart6): power-controller@268 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart6);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart7): power-controller@270 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart7);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_audio_p): power-controller@278 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(audio_p);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_sio_adma): power-controller@280 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_adma);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_mca0): power-controller@288 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca0);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_mca1): power-controller@290 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca1);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_mca2): power-controller@298 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca2);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_mca3): power-controller@2a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca3);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_dpa0): power-controller@2a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa0);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa1): power-controller@2b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa1);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa2): power-controller@2b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa2);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa3): power-controller@2c0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa3);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa4): power-controller@2c8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa4);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_aes): power-controller@2d0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(aes);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_amcc1): power-controller@2d8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc1);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_amcc3): power-controller@2e0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc3);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_dcs_04): power-controller@2e8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_04);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_05): power-controller@2f0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_05);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_06): power-controller@2f8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_06);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_07): power-controller@300 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_07);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_12): power-controller@308 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_12);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_13): power-controller@310 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_13);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_14): power-controller@318 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_14);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_15): power-controller@320 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_15);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_disp0_fe): power-controller@328 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(disp0_fe);
+		power-domains = <&DIE_NODE(ps_afnc2_lw0)>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+	};
+
+	DIE_NODE(ps_disp0_cpu0): power-controller@350 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(disp0_cpu0);
+		power-domains = <&DIE_NODE(ps_disp0_fe)>;
+		apple,always-on; /* TODO: figure out if we can enable PM here */
+		apple,min-state = <4>;
+	};
+
+	DIE_NODE(ps_dispdfr_fe): power-controller@378 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispdfr_fe);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_dispdfr_be): power-controller@380 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispdfr_be);
+		power-domains = <&DIE_NODE(ps_dispdfr_fe)>;
+	};
+
+	DIE_NODE(ps_mipi_dsi): power-controller@388 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mipi_dsi);
+		power-domains = <&DIE_NODE(ps_dispdfr_be)>;
+	};
+
+	DIE_NODE(ps_jpg): power-controller@390 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(jpg);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_msr0): power-controller@398 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr0);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_msr0_ase_core): power-controller@3a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr0_ase_core);
+		power-domains = <&DIE_NODE(ps_msr0)>;
+	};
+
+	DIE_NODE(ps_isp_sys): power-controller@3a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_sys);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_venc_sys): power-controller@3b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc_sys);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_ans2): power-controller@3b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ans2);
+		/*
+		 * The ADT makes ps_apcie_st[1]_sys depend on ps_ans2 instead,
+		 * but we'd rather have a single power domain for the downstream
+		 * device to depend on, so use this node as the child.
+		 * This makes more sense anyway (since ANS2 uses APCIE_ST).
+		 */
+		power-domains = <&DIE_NODE(ps_afnc2_lw0)>;
+	};
+
+	DIE_NODE(ps_gfx): power-controller@3c0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(gfx);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_sep): power-controller@c00 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sep);
+		apple,always-on; /* Locked on */
+	};
+
+	DIE_NODE(ps_venc_dma): power-controller@8000 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc_dma);
+		power-domains = <&DIE_NODE(ps_venc_sys)>;
+	};
+
+	DIE_NODE(ps_venc_pipe4): power-controller@8008 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc_pipe4);
+		power-domains = <&DIE_NODE(ps_venc_dma)>;
+	};
+
+	DIE_NODE(ps_venc_pipe5): power-controller@8010 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc_pipe5);
+		power-domains = <&DIE_NODE(ps_venc_dma)>;
+	};
+
+	DIE_NODE(ps_venc_me0): power-controller@8018 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc_me0);
+		power-domains = <&DIE_NODE(ps_venc_pipe5)>, <&DIE_NODE(ps_venc_pipe4)>;
+	};
+
+	DIE_NODE(ps_venc_me1): power-controller@8020 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc_me1);
+		power-domains = <&DIE_NODE(ps_venc_me0)>;
+	};
+};
+
+&DIE_NODE(pmgr_south) {
+	DIE_NODE(ps_amcc4): power-controller@100 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc4);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_amcc5): power-controller@108 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc5);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_amcc6): power-controller@110 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc6);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_amcc7): power-controller@118 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc7);
+		apple,always-on; /* Memory controller */
+	};
+
+	DIE_NODE(ps_dcs_16): power-controller@120 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_16);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_17): power-controller@128 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_17);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_18): power-controller@130 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_18);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_19): power-controller@138 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_19);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_20): power-controller@140 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_20);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_21): power-controller@148 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_21);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_22): power-controller@150 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_22);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_23): power-controller@158 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_23);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_24): power-controller@160 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_24);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_25): power-controller@168 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_25);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_26): power-controller@170 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_26);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_27): power-controller@178 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_27);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_28): power-controller@180 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_28);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_29): power-controller@188 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_29);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_30): power-controller@190 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_30);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_dcs_31): power-controller@198 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_31);
+		apple,always-on; /* LPDDR5 interface */
+	};
+
+	DIE_NODE(ps_afnc4_ioa): power-controller@1a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc4_ioa);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc4_ls): power-controller@1a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc4_ls);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc4_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc4_lw0): power-controller@1b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc4_lw0);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc4_ls)>;
+	};
+
+	DIE_NODE(ps_afnc5_ioa): power-controller@1b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc5_ioa);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc5_ls): power-controller@1c0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc5_ls);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc5_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc5_lw0): power-controller@1c8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc5_lw0);
+		apple,always-on; /* Apple Fabric */
+		power-domains = <&DIE_NODE(ps_afnc5_ls)>;
+	};
+
+	DIE_NODE(ps_dispext2_fe): power-controller@1d0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext2_fe);
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+
+	DIE_NODE(ps_dispext2_cpu0): power-controller@1e8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext2_cpu0);
+		power-domains = <&DIE_NODE(ps_dispext2_fe)>;
+	};
+
+	DIE_NODE(ps_dispext3_fe): power-controller@210 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext3_fe);
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+
+	DIE_NODE(ps_dispext3_cpu0): power-controller@228 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext3_cpu0);
+		power-domains = <&DIE_NODE(ps_dispext3_fe)>;
+	};
+
+	DIE_NODE(ps_msr1): power-controller@250 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr1);
+		power-domains = <&DIE_NODE(ps_afnc5_lw0)>, <&DIE_NODE(ps_afr)>;
+	};
+
+	DIE_NODE(ps_msr1_ase_core): power-controller@258 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr1_ase_core);
+		power-domains = <&DIE_NODE(ps_msr1)>;
+	};
+
+	DIE_NODE(ps_venc1_sys): power-controller@260 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_sys);
+		power-domains = <&DIE_NODE(ps_afnc5_lw0)>, <&DIE_NODE(ps_afr)>;
+	};
+
+	/* Seems to be disabled on shipping hardware */
+#if 0
+	DIE_NODE(ps_ane1_sys): power-controller@268 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane1_sys);
+		power-domains = <&DIE_NODE(ps_afnc5_lw0)>;
+	};
+
+	DIE_NODE(ps_ane1_sys_cpu): power-controller@270 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane1_sys_cpu);
+		power-domains = <&DIE_NODE(ps_ane1_sys)>;
+	};
+#endif
+
+	DIE_NODE(ps_venc1_dma): power-controller@8000 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_dma);
+		power-domains = <&DIE_NODE(ps_venc1_sys)>;
+	};
+
+	DIE_NODE(ps_venc1_pipe4): power-controller@8008 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_pipe4);
+		power-domains = <&DIE_NODE(ps_venc1_dma)>;
+	};
+
+	DIE_NODE(ps_venc1_pipe5): power-controller@8010 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_pipe5);
+		power-domains = <&DIE_NODE(ps_venc1_dma)>;
+	};
+
+	DIE_NODE(ps_venc1_me0): power-controller@8018 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_me0);
+		power-domains = <&DIE_NODE(ps_venc1_pipe4)>, <&DIE_NODE(ps_venc1_pipe5)>;
+	};
+
+	DIE_NODE(ps_venc1_me1): power-controller@8020 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_me1);
+		power-domains = <&DIE_NODE(ps_venc1_me0)>;
+	};
+
+	DIE_NODE(ps_prores): power-controller@c000 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(prores);
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+};
+
+&DIE_NODE(pmgr_mini) {
+	DIE_NODE(ps_debug): power-controller@58 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(debug);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_nub_spmi0): power-controller@60 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi0);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_nub_spmi1): power-controller@68 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi1);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_nub_aon): power-controller@70 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_aon);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_msg): power-controller@78 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msg);
+	};
+
+	DIE_NODE(ps_nub_gpio): power-controller@80 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_gpio);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_atc0_usb_aon): power-controller@88 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_usb_aon);
+		apple,always-on; /* Needs to stay on for dwc3 to work */
+	};
+
+	DIE_NODE(ps_atc1_usb_aon): power-controller@90 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_usb_aon);
+		apple,always-on; /* Needs to stay on for dwc3 to work */
+	};
+
+	DIE_NODE(ps_atc2_usb_aon): power-controller@98 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x98 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_usb_aon);
+		apple,always-on; /* Needs to stay on for dwc3 to work */
+	};
+
+	DIE_NODE(ps_atc3_usb_aon): power-controller@a0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_usb_aon);
+		apple,always-on; /* Needs to stay on for dwc3 to work */
+	};
+
+	DIE_NODE(ps_gp_usb_aon): power-controller@a8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(gp_usb_aon);
+	};
+
+	DIE_NODE(ps_nub_fabric): power-controller@b0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_fabric);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_nub_sram): power-controller@b8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_sram);
+		apple,always-on; /* Core AON device */
+	};
+
+	DIE_NODE(ps_debug_usb): power-controller@c0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(debug_usb);
+		apple,always-on; /* Core AON device */
+		power-domains = <&DIE_NODE(ps_debug)>;
+	};
+
+	DIE_NODE(ps_debug_auth): power-controller@c8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xc8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(debug_auth);
+		apple,always-on; /* Core AON device */
+		power-domains = <&DIE_NODE(ps_debug)>;
+	};
+
+	DIE_NODE(ps_atc0_usb): power-controller@d0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xd0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_usb);
+		power-domains = <&DIE_NODE(ps_atc0_usb_aon)>, <&DIE_NODE(ps_atc0_common)>;
+	};
+
+	DIE_NODE(ps_atc1_usb): power-controller@d8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xd8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_usb);
+		power-domains = <&DIE_NODE(ps_atc1_usb_aon)>, <&DIE_NODE(ps_atc1_common)>;
+	};
+
+	DIE_NODE(ps_atc2_usb): power-controller@e0 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xe0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_usb);
+		power-domains = <&DIE_NODE(ps_atc2_usb_aon)>, <&DIE_NODE(ps_atc2_common)>;
+	};
+
+	DIE_NODE(ps_atc3_usb): power-controller@e8 {
+		compatible = "apple,t6000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0xe8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_usb);
+		power-domains = <&DIE_NODE(ps_atc3_usb_aon)>, <&DIE_NODE(ps_atc3_common)>;
+	};
+};
-- 
2.35.1

