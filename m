Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613B70470F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEPHxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjEPHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:53:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8749DC;
        Tue, 16 May 2023 00:52:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab13da70a3so133838735ad.1;
        Tue, 16 May 2023 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684223570; x=1686815570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8OhEt4GIuw43ahn9BPzsd8d+JekOssXjgymx9BYUKc=;
        b=O62EutE8wBuqNF/k2H0gdfnJG5oKug966OvBaMDETvpMjLxWdXrLVYEP0F+tUm6oDY
         SMkfG1xd5nVmDZugzT4gcNCG6rOArZBU4i1Sf2r2X3STBvNubvyQXqqFcVzhvaxMpDrs
         DXG52P5+7DgAgVpsknLqidqtM70cHyutsUlZGkqxUg4lT0Ica7vljZJN8MV1tgzo9zr+
         umxa9sNNh6Row3BnFqwef3zexmsqhBy6l55+3TzvHZgKcNdnFpvlSgyj/Babi7uKtlBv
         GaHHl3zufPt06xgOmweBIlLSXXp9aphT6xzc3DnGi+ttmwYvcocLCEisNYvtxowSI+Ad
         k3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223570; x=1686815570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8OhEt4GIuw43ahn9BPzsd8d+JekOssXjgymx9BYUKc=;
        b=DaICca+On2WJN+NisOjEgwOL9XBeCnGF9mrgpDQNt1CC/tm0t5Y36OvHAFu3MK+41+
         EtXRcpieMV+hpar/3dOyypdZoWVoGpQIkNbR2zvn9hUMW+ViZvFg4My6vK9r/8Q0UDLY
         5DoijD1/q2444PfGgvfTPCAjrKARKbqKFOPGH66DdzqSrN7Jz0EA/BsubFPTod81VYGR
         5ZlO+cpp64TxKttvXi0t40lfvYnMPGHD/YpaUfsEJeQk2157s9evNUyNgZugG/aNztWj
         eK8VWn5GMWPCWu6Zc26m36vL2IlpTrTv1dtKEyzrshz6pb25340opbl0lZC7AwDqt5g0
         zefg==
X-Gm-Message-State: AC+VfDzyCXyLjMz/YnxlYv8nT0BXTq33cIXWlt1gv/LUigjccURmFJVH
        f/GQPue8OPM7Eoh1h83Ujk8=
X-Google-Smtp-Source: ACHHUZ7ukRSUoQIlfcEE13bVDxtfSSci0Di+Mq7CZrE9RxgWc2Evu/vTqdNzkYDV5fFMk4vFv+IhEg==
X-Received: by 2002:a17:902:ec88:b0:1aa:fbaa:ee09 with SMTP id x8-20020a170902ec8800b001aafbaaee09mr49879280plg.49.1684223570121;
        Tue, 16 May 2023 00:52:50 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001ab061e352bsm4793043plh.195.2023.05.16.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:52:49 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 07/10] arm64: dts: nuvoton: Add initial ma35d1 device tree
Date:   Tue, 16 May 2023 07:52:14 +0000
Message-Id: <20230516075217.205401-8-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516075217.205401-1-ychuang570808@gmail.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add initial device tree support for Nuvoton ma35d1 SoC, including
cpu, clock, reset, and serial controllers.
Add reference boards som-256m and iot-512m.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  56 +++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  56 +++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 234 ++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi

diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
index a99dab90472a..3bc9787801a5 100644
--- a/arch/arm64/boot/dts/nuvoton/Makefile
+++ b/arch/arm64/boot/dts/nuvoton/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MA35) += ma35d1-iot-512m.dtb
+dtb-$(CONFIG_ARCH_MA35) += ma35d1-som-256m.dtb
 dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-evb.dtb
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
new file mode 100644
index 000000000000..b89e2be6abae
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ * Author: Shan-Chun Hung <schung@nuvoton.com>
+ *         Jacky huang <ychuang3@nuvoton.com>
+ */
+
+/dts-v1/;
+#include "ma35d1.dtsi"
+
+/ {
+	model = "Nuvoton MA35D1-IoT";
+	compatible = "nuvoton,ma35d1-iot", "nuvoton,ma35d1";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	mem: memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
+	};
+
+	clk_hxt: clock-hxt {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clk_hxt";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&clk {
+	assigned-clocks = <&clk CAPLL>,
+			  <&clk DDRPLL>,
+			  <&clk APLL>,
+			  <&clk EPLL>,
+			  <&clk VPLL>;
+	assigned-clock-rates = <800000000>,
+			       <266000000>,
+			       <180000000>,
+			       <500000000>,
+			       <102000000>;
+	nuvoton,pll-mode = "integer",
+			   "fractional",
+			   "integer",
+			   "integer",
+			   "integer";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
new file mode 100644
index 000000000000..a1ebddecb7f8
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ * Author: Shan-Chun Hung <schung@nuvoton.com>
+ *         Jacky huang <ychuang3@nuvoton.com>
+ */
+
+/dts-v1/;
+#include "ma35d1.dtsi"
+
+/ {
+	model = "Nuvoton MA35D1-SOM";
+	compatible = "nuvoton,ma35d1-som", "nuvoton,ma35d1";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	mem: memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x10000000>; /* 256M DRAM */
+	};
+
+	clk_hxt: clock-hxt {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clk_hxt";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&clk {
+	assigned-clocks = <&clk CAPLL>,
+			  <&clk DDRPLL>,
+			  <&clk APLL>,
+			  <&clk EPLL>,
+			  <&clk VPLL>;
+	assigned-clock-rates = <800000000>,
+			       <266000000>,
+			       <180000000>,
+			       <500000000>,
+			       <102000000>;
+	nuvoton,pll-mode = "integer",
+			   "fractional",
+			   "integer",
+			   "integer",
+			   "integer";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
new file mode 100644
index 000000000000..781cdae566a0
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ * Author: Shan-Chun Hung <schung@nuvoton.com>
+ *         Jacky huang <ychuang3@nuvoton.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+/ {
+	compatible = "nuvoton,ma35d1";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	gic: interrupt-controller@50801000 {
+		compatible = "arm,gic-400";
+		reg = <0x0 0x50801000 0 0x1000>, /* GICD */
+		      <0x0 0x50802000 0 0x2000>, /* GICC */
+		      <0x0 0x50804000 0 0x2000>, /* GICH */
+		      <0x0 0x50806000 0 0x2000>; /* GICV */
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
+		interrupt-parent = <&gic>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		sys: system-management@40460000 {
+			compatible = "nuvoton,ma35d1-reset";
+			reg = <0x0 0x40460000 0x0 0x200>;
+			#reset-cells = <1>;
+		};
+
+		clk: clock-controller@40460200 {
+			compatible = "nuvoton,ma35d1-clk";
+			reg = <0x00000000 0x40460200 0x0 0x100>;
+			#clock-cells = <1>;
+			clocks = <&clk_hxt>;
+		};
+
+		uart0: serial@40700000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40700000 0x0 0x100>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART0_GATE>;
+			status = "disabled";
+		};
+
+		uart1: serial@40710000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40710000 0x0 0x100>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART1_GATE>;
+			status = "disabled";
+		};
+
+		uart2: serial@40720000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40720000 0x0 0x100>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART2_GATE>;
+			status = "disabled";
+		};
+
+		uart3: serial@40730000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40730000 0x0 0x100>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART3_GATE>;
+			status = "disabled";
+		};
+
+		uart4: serial@40740000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40740000 0x0 0x100>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART4_GATE>;
+			status = "disabled";
+		};
+
+		uart5: serial@40750000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40750000 0x0 0x100>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART5_GATE>;
+			status = "disabled";
+		};
+
+		uart6: serial@40760000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40760000 0x0 0x100>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART6_GATE>;
+			status = "disabled";
+		};
+
+		uart7: serial@40770000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40770000 0x0 0x100>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART7_GATE>;
+			status = "disabled";
+		};
+
+		uart8: serial@40780000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40780000 0x0 0x100>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART8_GATE>;
+			status = "disabled";
+		};
+
+		uart9: serial@40790000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40790000 0x0 0x100>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART9_GATE>;
+			status = "disabled";
+		};
+
+		uart10: serial@407a0000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x407a0000 0x0 0x100>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART10_GATE>;
+			status = "disabled";
+		};
+
+		uart11: serial@407b0000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x407b0000 0x0 0x100>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART11_GATE>;
+			status = "disabled";
+		};
+
+		uart12: serial@407c0000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x407c0000 0x0 0x100>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART12_GATE>;
+			status = "disabled";
+		};
+
+		uart13: serial@407d0000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x407d0000 0x0 0x100>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART13_GATE>;
+			status = "disabled";
+		};
+
+		uart14: serial@407e0000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x407e0000 0x0 0x100>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART14_GATE>;
+			status = "disabled";
+		};
+
+		uart15: serial@407f0000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x407f0000 0x0 0x100>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART15_GATE>;
+			status = "disabled";
+		};
+
+		uart16: serial@40880000 {
+			compatible = "nuvoton,ma35d1-uart";
+			reg = <0x0 0x40880000 0x0 0x100>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk UART16_GATE>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.34.1

