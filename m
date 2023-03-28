Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE86CB3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjC1CUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjC1CUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:20:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D662D43;
        Mon, 27 Mar 2023 19:19:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u10so10270754plz.7;
        Mon, 27 Mar 2023 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFrXoxem3Mk2t/wbJ6T/hevh5Qt8IdNNYKI1lE0XPKU=;
        b=Bs9r7JnKERuV2Ig6U2ZCTF/U4Z9WYOU8M6NImpM6GNVA60RB0689wTWM2+9qAAL+ds
         ZK6ch6th0eCStZS4R5m1ttzfB/3BQ37T5jGPrRSsiliZQYCeyt7V2EscNi4W4R4/+lHX
         hDuIxpMP3v3x8XUlFV9slZUE/mYgtQZs7CkvSIpigszMfkRNNTKjxT4HpGvz2b28mPzF
         IutJB2mr/sPNpbU5K6cUdsTOtcd4zT7fbRh9TT4UK0B6smWHHNrByAOrVP+FHupqMpi8
         Id9tG3I7fJG5sOTmNO79NcYhlqOgeSHPJS3b06jos99XxETzgJP1LuuovvJM3lFYD6/2
         SrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFrXoxem3Mk2t/wbJ6T/hevh5Qt8IdNNYKI1lE0XPKU=;
        b=wlM+ziIFFAuVKPzJ6CQNHHQ8YdW0PeQ25Of+KCMuFATDRa2CaiFXB26bXRysMeWRfC
         jdZz6m9lzI4o7mh+TP2wDoxRKWZMICLjQCbJtsQiUMCKLt3zPj+Z7XE54gygh+IdznB3
         R5Mf1k4tOol5RYc6H4x5wx7QaSiYl9i58IqtOJQ1rpySgzCDdthxR16wVN8hes7AzgqV
         fpArAj0OV9nnIiFKnCNRoAIwyKazP5K1NzrR36aJBtoKXHCCBpDfLegFJBt5aAdZD89u
         7f3GPooRQuaTKBiCCb48+fK8yYzbv6bkmWeQxuQa+rckgFDysSskJngJT4g+LcCNfQAh
         whew==
X-Gm-Message-State: AAQBX9ejLB3u3mI9H/M3W3oToUtWRxFy6tCd16xPoAZVgDbvbzoPSpaX
        MamuUnCzkTqG1Cmk3qUM23Q=
X-Google-Smtp-Source: AKy350Z03lsXrQXud7zaAFrauVw00FwT5D6MCr5DcJvWGLGxot2qTSNQ78RW43A+bbqGc/NvGAlX3g==
X-Received: by 2002:a17:90b:1b46:b0:237:5834:294b with SMTP id nv6-20020a17090b1b4600b002375834294bmr14528023pjb.41.1679969982896;
        Mon, 27 Mar 2023 19:19:42 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:42 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device tree
Date:   Tue, 28 Mar 2023 02:19:08 +0000
Message-Id: <20230328021912.177301-9-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  56 +++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  56 +++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 231 ++++++++++++++++++
 4 files changed, 345 insertions(+)
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
index 000000000000..0740b0b218a7
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -0,0 +1,231 @@
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
+			#reset-cells = <1>;
+		};
+	};
+
+	clk: clock-controller@40460200 {
+		compatible = "nuvoton,ma35d1-clk", "syscon";
+		reg = <0x00000000 0x40460200 0x0 0x100>;
+		#clock-cells = <1>;
+		clocks = <&clk_hxt>;
+		nuvoton,sys = <&sys>;
+	};
+
+	gic: interrupt-controller@50801000 {
+		compatible = "arm,gic-400";
+		reg =   <0x0 0x50801000 0 0x1000>, /* GICD */
+			<0x0 0x50802000 0 0x2000>, /* GICC */
+			<0x0 0x50804000 0 0x2000>, /* GICH */
+			<0x0 0x50806000 0 0x2000>; /* GICV */
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	uart0:serial@40700000 {
+		compatible = "nuvoton,ma35d1-uart";
+		reg = <0x0 0x40700000 0x0 0x100>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk UART0_GATE>;
+		status = "disabled";
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

