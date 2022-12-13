Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4711264C0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiLMXoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiLMXn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:43:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A026CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a16so20183404edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wElmBlp8lUK13LpJTSFSUhrGzeF0MlEpla7yl2XGcO4=;
        b=sQ70ALCRsY/r6d6tHGxxQUM+xO3ur6675gBHnIVWWb/VtnuzC6gM9hI8jCbgry6+JX
         dUDYuOesVVo8sTbwO4icoUhBqbmp7uo/MRgcouZFs3nI6C9Sz3pu6YD5RTyYJL2bcBc9
         8zuagp87Kmey+rgpyo4jv3FtwUaXk5UW6wcdTUuL2QnIPO0dt7zP7aVFb/YQHaD1H0cz
         1mk/R02ab91SzTCbKkDk2BSHbc8eO3Ig/0Xg6DEDQAhT7Ri7HEyw9liNBsHIBdAW6ehh
         sDpSGA//+Guq9LuLOWG7naqOJCnNJMiI2/75QhUUjjmwluPW306FJNRdYiYryKh4bCe4
         iMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wElmBlp8lUK13LpJTSFSUhrGzeF0MlEpla7yl2XGcO4=;
        b=xv+BCTfIuAXAxB7z5zp2094j6h/A4wZMhhmxGVis9kBSZfBFdiOOjpV8H+SenCPPcV
         EVweEkQ91/gsyLSF0eMD0IHkgSSBXrIf0Vx8Sg89j/fMjvG0YQPhUK4fKQiWy0uztkbb
         ymI2IVH0M3XCcovAlDs2SV5ophMxZDpelUazCoTrLKMykWWFtDF2uQoTPsExdVc+OyQP
         AVO2sZ8f3mdpPzr8TWDLFAXaEGNJB/0XqjYrd2yKzUvbA6UmQV1auz1guYBgu8ByPIye
         kTu4dDsZvE9IBnZvoNp0Jv+MCfATQwoXO1DvAF1LntFbc1mMItjmG00ARODrgLGOCP13
         4Dzg==
X-Gm-Message-State: ANoB5pm4J11NgO+qGycK2vW7pevzm3g9NBhWEjtr5zTtzodSnKNowXMc
        TOmSDMrfjyh4J1g+fJ13jLctzg==
X-Google-Smtp-Source: AA0mqf5ksi0oTpp4Tw2+DYBZK4aJECPzh2L0O4O8xS1tkvj+wYg5m4llIj8aFwMkiK6ahYtVSidqHg==
X-Received: by 2002:a05:6402:c2:b0:461:568b:fb22 with SMTP id i2-20020a05640200c200b00461568bfb22mr18080941edu.8.1670975036217;
        Tue, 13 Dec 2022 15:43:56 -0800 (PST)
Received: from predatorhelios.fritz.box (dynamic-093-129-109-038.93.129.pool.telefonica.de. [93.129.109.38])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b00458b41d9460sm5407498edx.92.2022.12.13.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:43:55 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v5 7/7] arm64: dts: mediatek: Initial mt8365-evk support
Date:   Wed, 14 Dec 2022 00:43:46 +0100
Message-Id: <20221213234346.2868828-8-bero@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213234346.2868828-1-bero@baylibre.com>
References: <20221213234346.2868828-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

This adds minimal support for the Mediatek 8365 SOC and the EVK reference
board, allowing the board to boot to initramfs with serial port I/O.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
[bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add L2 cache]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 163 ++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 343 ++++++++++++++++++++
 3 files changed, 507 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 813e735c5b96d..d78523c5a7dd6 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -47,4 +47,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
new file mode 100644
index 0000000000000..972843f9e4e9d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2022 BayLibre, SAS.
+ * Authors:
+ * Fabien Parent <fparent@baylibre.com>
+ * Bernhard Rosenkränzer <bero@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
+#include "mt8365.dtsi"
+
+/ {
+	model = "MediaTek MT8365 Open Platform EVK";
+	compatible = "mediatek,mt8365-evk", "mediatek,mt8365";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys>;
+
+		key-volume-up {
+			gpios = <&pio 24 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0xc0000000>;
+	};
+
+	usb_otg_vbus: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+	};
+};
+
+&pio {
+	gpio_keys: gpio-keys-pins {
+		pins {
+			pinmux = <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <MT8365_PIN_35_URXD0__FUNC_URXD0>,
+				 <MT8365_PIN_36_UTXD0__FUNC_UTXD0>;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux = <MT8365_PIN_37_URXD1__FUNC_URXD1>,
+				 <MT8365_PIN_38_UTXD1__FUNC_UTXD1>;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins {
+			pinmux = <MT8365_PIN_39_URXD2__FUNC_URXD2>,
+				 <MT8365_PIN_40_UTXD2__FUNC_UTXD2>;
+		};
+	};
+
+	usb_pins: usb-pins {
+		pins-id {
+			pinmux = <MT8365_PIN_17_GPIO17__FUNC_GPIO17>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-usb0-vbus {
+			pinmux = <MT8365_PIN_16_GPIO16__FUNC_USB_DRVVBUS>;
+			output-high;
+		};
+
+		pin-usb1-vbus {
+			pinmux = <MT8365_PIN_18_GPIO18__FUNC_GPIO18>;
+			output-high;
+		};
+	};
+
+	pwm_pins: pwm-pins {
+		pins {
+			pinmux = <MT8365_PIN_19_DISP_PWM__FUNC_PWM_A>,
+				 <MT8365_PIN_116_I2S_BCK__FUNC_PWM_C>;
+		};
+	};
+};
+
+&pwm {
+	pinctrl-0 = <&pwm_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
new file mode 100644
index 0000000000000..2c4ef9b92b68b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * (C) 2018 MediaTek Inc.
+ * Copyright (C) 2022 BayLibre SAS
+ * Fabien Parent <fparent@baylibre.com>
+ * Bernhard Rosenkränzer <bero@baylibre.com>
+ */
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible = "mediatek,mt8365";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0: cluster0 {
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
+			reg = <0x0>;
+			#cooling-cells = <2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			#cooling-cells = <2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			#cooling-cells = <2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			#cooling-cells = <2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	clk26m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@43000000 {
+			no-map;
+			reg = <0 0x43000000 0 0x20000>;
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x80000>, <0 0x0c080000 0 0x80000>;
+
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		topckgen: syscon@10000000 {
+			compatible = "mediatek,mt8365-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: syscon@10001000 {
+			compatible = "mediatek,mt8365-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: syscon@10003000 {
+			compatible = "mediatek,mt8365-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		syscfg_pctl: syscfg-pctl@10005000 {
+			compatible = "mediatek,mt8365-syscfg", "syscon";
+			reg = <0 0x10005000 0 0x1000>;
+		};
+
+		pio: pinctrl@1000b000 {
+			compatible = "mediatek,mt8365-pinctrl";
+			reg = <0 0x1000b000 0 0x1000>;
+			mediatek,pctl-regmap = <&syscfg_pctl>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		apmixedsys: syscon@1000c000 {
+			compatible = "mediatek,mt8365-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		keypad: keypad@10010000 {
+			compatible = "mediatek,mt6779-keypad";
+			reg = <0 0x10010000 0 0x1000>;
+			wakeup-source;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_EDGE_FALLING>;
+			clocks = <&clk26m>;
+			clock-names = "kpd";
+			status = "disabled";
+		};
+
+		mcucfg: syscon@10200000 {
+			compatible = "mediatek,mt8365-mcucfg", "syscon";
+			reg = <0 0x10200000 0 0x2000>;
+			#clock-cells = <1>;
+		};
+
+		sysirq: interrupt-controller@10200a80 {
+			compatible = "mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200a80 0 0x20>;
+		};
+
+		infracfg_nao: infracfg@1020e000 {
+			compatible = "mediatek,mt8365-infracfg", "syscon";
+			reg = <0 0x1020e000 0 0x1000>;
+		};
+
+		rng: rng@1020f000 {
+			compatible = "mediatek,mt8365-rng", "mediatek,mt7623-rng";
+			reg = <0 0x1020f000 0 0x100>;
+			clocks = <&infracfg CLK_IFR_TRNG>;
+			clock-names = "rng";
+		};
+
+		apdma: dma-controller@11000280 {
+			compatible = "mediatek,mt8365-uart-dma", "mediatek,mt6577-uart-dma";
+			reg = <0 0x11000280 0 0x80>,
+			      <0 0x11000300 0 0x80>,
+			      <0 0x11000380 0 0x80>,
+			      <0 0x11000400 0 0x80>,
+			      <0 0x11000580 0 0x80>,
+			      <0 0x11000600 0 0x80>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+			dma-requests = <6>;
+			clocks = <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "apdma";
+			#dma-cells = <1>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&infracfg CLK_IFR_UART0>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 0>, <&apdma 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&infracfg CLK_IFR_UART1>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 2>, <&apdma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x1000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&infracfg CLK_IFR_UART2>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 4>, <&apdma 5>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		pwm: pwm@11006000 {
+			compatible = "mediatek,mt8365-pwm";
+			reg = <0 0x11006000 0 0x1000>;
+			#pwm-cells = <2>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_IFR_PWM_HCLK>,
+				 <&infracfg CLK_IFR_PWM>,
+				 <&infracfg CLK_IFR_PWM1>,
+				 <&infracfg CLK_IFR_PWM2>,
+				 <&infracfg CLK_IFR_PWM3>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
+		};
+
+		spi: spi@1100a000 {
+			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
+			reg = <0 0x1100a000 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_IFR_SPI0>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk";
+			status = "disabled";
+		};
+
+		ssusb: usb@11201000 {
+			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u2port1 PHY_TYPE_USB2>;
+			clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
+				 <&infracfg CLK_IFR_SSUSB_REF>,
+				 <&infracfg CLK_IFR_SSUSB_SYS>,
+				 <&infracfg CLK_IFR_ICUSB>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host: usb@11200000 {
+				compatible = "mediatek,mt8365-xhci", "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>;
+				clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
+					 <&infracfg CLK_IFR_SSUSB_REF>,
+					 <&infracfg CLK_IFR_SSUSB_SYS>,
+					 <&infracfg CLK_IFR_ICUSB>,
+					 <&infracfg CLK_IFR_SSUSB_XHCI>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck",
+					      "dma_ck", "xhci_ck";
+				status = "disabled";
+			};
+		};
+
+		u3phy: phy@11cc0000 {
+			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#phy-cells = <1>;
+			ranges;
+
+			u2port0: usb-phy@11cc0000 {
+				reg = <0 0x11cc0000 0 0x400>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
+					 <&topckgen CLK_TOP_USB20_48M_EN>;
+				clock-names = "ref", "da_ref";
+				#phy-cells = <1>;
+			};
+
+			u2port1: usb-phy@11cc1000 {
+				reg = <0 0x11cc1000 0 0x400>;
+				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
+					 <&topckgen CLK_TOP_USB20_48M_EN>;
+				clock-names = "ref", "da_ref";
+				#phy-cells = <1>;
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};
-- 
2.39.0

