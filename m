Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7606BA953
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCOHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCOHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F36C1AD;
        Wed, 15 Mar 2023 00:29:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cn6so5261533pjb.2;
        Wed, 15 Mar 2023 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxf2iuQCA7nEtSMFt+3Of43dgLj8kzulTG3yBMHVzIk=;
        b=WxxYlTV5kHOUj12ysBMBsJpzBPqVDgM+hhnbBssqv+wpaHVRoBWHAZQYX++u8WSoZ6
         wsI5S5Scw41VhKLawzko2xQR4LRFnHVF9Y9uBuAZMmA//4o1oWtpyHJooJdMbLhJrlnd
         M8+UyXl4Ey8M2QZokZLdSoK+kWpDYsOOK7UATUGQFJ89y5OXVAG+QPC2ySXmXZQdu21E
         j6r7qBadYSM2UzGfUZAs9zPg8rIbLv5TQd1GIR2Trd+eEvh9ZiZGqWces6Z98jJu/vOT
         Bzj9oyIR/E17v7QwTEbOZijsnWW/Ylt9/dlraKQGxz7mrfpbQ+UqrfThfF3U+RPGn58R
         CvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxf2iuQCA7nEtSMFt+3Of43dgLj8kzulTG3yBMHVzIk=;
        b=5crIZU6NZxSErEnWgavGba/if49cwiQQFj8syeqtFP475Muu2IuZHh1aln6CCR9oca
         KO2y03DqNCReSTauhVsXUzgkqUeXAKbA8px+7RQzGeyzNnAFlTr8IL32zSgIJLHi/WIV
         1Bztd5V6RsC686fFt55XgfqvHQFSlJc0rWetenDXVRQKeOQF2JpDzQV+gqQRa0jJS1kd
         dx5QpvVsPwyEE7makot85WD0PTNcA6tSXSUlA7QiH6wexmPWvA7fdAdLlQOypX4UJ8Ga
         nwDd8wWPCnYvbXKjncL8FmWfoz3C6NC1ocVDgS6YKX1vst8yQ3GDwJQvGtpqhMAdZ0Jc
         kZ9Q==
X-Gm-Message-State: AO0yUKWK+44kr3VSFmqsb/3FtgXaKdPe6mRsMHFnV+5u/2SSZ/9W1qb1
        NL7rVtrrZZudzFmceUCa/iw=
X-Google-Smtp-Source: AK7set/OpbEZ1OSLmu8a+XAiyrbXKulXANL1WZM4L8qqiY0W4sIUxVpt+grwwpQLztGLeXqo6I2d8A==
X-Received: by 2002:a17:903:120b:b0:19d:14c:e590 with SMTP id l11-20020a170903120b00b0019d014ce590mr1869475plh.9.1678865376311;
        Wed, 15 Mar 2023 00:29:36 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:36 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Date:   Wed, 15 Mar 2023 07:28:58 +0000
Message-Id: <20230315072902.9298-12-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  24 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  23 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 272 ++++++++++++++++++
 4 files changed, 321 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi

diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
index a99dab90472a..c11ab4eac9c7 100644
--- a/arch/arm64/boot/dts/nuvoton/Makefile
+++ b/arch/arm64/boot/dts/nuvoton/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-evb.dtb
+dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-iot-512m.dtb
+dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-som-256m.dtb
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
new file mode 100644
index 000000000000..dffcaef1e6d8
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -0,0 +1,24 @@
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
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	mem: memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
+	};
+};
+
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
new file mode 100644
index 000000000000..3e6c3d5469ac
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -0,0 +1,23 @@
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
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	mem: memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x10000000>; /* 256M DRAM */
+	};
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
new file mode 100644
index 000000000000..8c855f6b330a
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -0,0 +1,272 @@
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
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
+		serial15 = &uart15;
+		serial16 = &uart16;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+		L2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	clk_hxt: clock_hxt {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clk_hxt";
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
+		clock-frequency = <12000000>;
+		interrupt-parent = <&gic>;
+	};
+
+	sys: system-management@40460000 {
+		compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
+		reg = <0x0 0x40460000 0x0 0x200>;
+
+		reset: reset-controller {
+			compatible = "nuvoton,ma35d1-reset";
+			regmap = <&sys>;
+			#reset-cells = <1>;
+		};
+	};
+
+	clk: clock-controller@40460200 {
+		compatible = "nuvoton,ma35d1-clk", "syscon";
+		reg = <0x00000000 0x40460200 0x0 0x100>;
+		#clock-cells = <1>;
+		clocks = <&clk_hxt>;
+		clock-names = "clk_hxt";
+		assigned-clocks = <&clk CAPLL>,
+				  <&clk DDRPLL>,
+				  <&clk APLL>,
+				  <&clk EPLL>,
+				  <&clk VPLL>;
+		assigned-clock-rates = <800000000>,
+				       <266000000>,
+				       <180000000>,
+				       <500000000>,
+				       <102000000>;
+		nuvoton,pll-mode = <0>, <1>, <0>, <0>, <0>;
+		nuvoton,sys = <&sys>;
+	};
+
+	gic: interrupt-controller@50801000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		reg =   <0x0 0x50801000 0 0x1000>, /* GICD */
+			<0x0 0x50802000 0 0x2000>, /* GICC */
+			<0x0 0x50804000 0 0x2000>, /* GICH */
+			<0x0 0x50806000 0 0x2000>; /* GICV */
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	uart0:serial@40700000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40700000 0x0 0x100>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART0_GATE>;
+		status = "okay";
+	};
+
+	uart1:serial@40710000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40710000 0x0 0x100>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART1_GATE>;
+		status = "disabled";
+	};
+
+	uart2:serial@40720000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40720000 0x0 0x100>;
+		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART2_GATE>;
+		status = "disabled";
+	};
+
+	uart3:serial@40730000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40730000 0x0 0x100>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART3_GATE>;
+		status = "disabled";
+	};
+
+	uart4:serial@40740000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40740000 0x0 0x100>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART4_GATE>;
+		status = "disabled";
+	};
+
+	uart5:serial@40750000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40750000 0x0 0x100>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART5_GATE>;
+		status = "disabled";
+	};
+
+	uart6:serial@40760000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40760000 0x0 0x100>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART6_GATE>;
+		status = "disabled";
+	};
+
+	uart7:serial@40770000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40770000 0x0 0x100>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART7_GATE>;
+		status = "disabled";
+	};
+
+	uart8:serial@40780000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40780000 0x0 0x100>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART8_GATE>;
+		status = "disabled";
+	};
+
+	uart9:serial@40790000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40790000 0x0 0x100>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART9_GATE>;
+		status = "disabled";
+	};
+
+	uart10:serial@407a0000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x407a0000 0x0 0x100>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART10_GATE>;
+		status = "disabled";
+	};
+
+	uart11:serial@407b0000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x407b0000 0x0 0x100>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART11_GATE>;
+		status = "disabled";
+	};
+
+	uart12:serial@407c0000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x407c0000 0x0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART12_GATE>;
+		status = "disabled";
+	};
+
+	uart13:serial@407d0000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x407d0000 0x0 0x100>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART13_GATE>;
+		status = "disabled";
+	};
+
+	uart14:serial@407e0000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x407e0000 0x0 0x100>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART14_GATE>;
+		status = "disabled";
+	};
+
+	uart15:serial@407f0000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x407f0000 0x0 0x100>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART15_GATE>;
+		status = "disabled";
+	};
+
+	uart16:serial@40880000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40880000 0x0 0x100>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART16_GATE>;
+		status = "disabled";
+	};
+};
-- 
2.34.1

