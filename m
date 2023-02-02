Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A122687728
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjBBITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjBBITb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:19:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F984B72
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:19:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n13so1074817plf.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACnHvTU7gEng4y82wmBORUtHHJ+pZWFgrAC6kuRsmqw=;
        b=NMUw1kDV1vh/37ahrFVcLgkXqHwgpoAEMOEnrhVN9bL4We5HZsYq26dfsmkM6Pl84c
         VeMhy8rJoCDnQeBl8e7/kIT17ltOL1wdxy2DeGEbRxYNpM6xv6oux5dZ2DUvyqnysiYU
         JjX2ddfuHXKmOXAFJd3NQK0ehBmF0EedWdKgU34O2uxiAr3uEWQhShZtDT4KyEc4wURk
         dBuyica5JYPQorNvA5i51jMx9nAvvoO68HsyM1azeYr5JIaG3dZ1uY1eyIcXejF1TcFg
         bMMU7u/SV//XsKAJ5jknGIIBdPec113SmDcyp5gFxM9JPQA7kq7ih6sIijp+USBoL7kX
         nFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACnHvTU7gEng4y82wmBORUtHHJ+pZWFgrAC6kuRsmqw=;
        b=1JozgxS1g+8visVFqTYnXYvLWJxo+zHHzsL4oUElEiPKx3dwlKmzOvCog2j4ljUUPA
         L36venoEWoBgAZwSu1o3XX2QsmapqOG6RfkAhWcP4gk2Dbv8nIhhOySMXVVM1Z+OgCpd
         7KU3wqhQx1KDyIlQdpZrMfVSaOBcW+rNiXTpDjLqvjFcuY+cViO7qBcRRpVOVCxhefWk
         EQn49HmlegGj9ck5Zhm+1edK2rt0BcxbAktx7BWcJCG5APFe6G7WwmT4qYN4B7gKWtfQ
         uJq+M0p5B+DhJWZnfEhhUTZ0tzY+/feh87KNok+1gYpHbDAFg7/lryFHwFyIdtawXY6k
         zWMA==
X-Gm-Message-State: AO0yUKUrY9p9EWUnXSLHfPa/mecYaLlHSfNn5Ayp0pERoS+4FwglPfrv
        Vy3IoUxU1sSH0ADdQQBIEm1Lf3GzgL8d1e0HLtswuA==
X-Google-Smtp-Source: AK7set9NtY7wkF+Wxsy+aSeRILayZS+raEsGDMwKyw9dWkNSuor4NmO8YE4bZYM27q1x/r/RPUSFXg==
X-Received: by 2002:a17:903:2345:b0:198:a338:b9c5 with SMTP id c5-20020a170903234500b00198a338b9c5mr7249431plh.2.1675325968172;
        Thu, 02 Feb 2023 00:19:28 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b0019324fbec59sm13187552plp.41.2023.02.02.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 00:19:27 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC
Date:   Thu,  2 Feb 2023 16:18:43 +0800
Message-Id: <20230202081843.2358-4-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202081843.2358-1-jordan.chang@ufispace.com>
References: <20230202081843.2358-1-jordan.chang@ufispace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial version of device tree for Ufispace NCPLite platform
which is equipped with AST2600-based BMC.

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2ee9c043218b..d26e0651e805 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1626,6 +1626,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-inventec-transformers.dtb \
 	aspeed-bmc-tyan-s7106.dtb \
 	aspeed-bmc-tyan-s8036.dtb \
+	aspeed-bmc-ufispace-ncplite.dtb \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
 	aspeed-bmc-vegman-sx20.dtb
diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
new file mode 100644
index 000000000000..a3853bdcae9d
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2022 Ufispace Co., Ltd.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Ufispace NCPLite BMC";
+	compatible = "ufispace,ncplite-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		event-fan-alert {
+			label = "fan-alert";
+			gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(M, 2)>;
+		};
+
+		event-allpwr-good {
+			label = "allpwr-good";
+			gpios = <&gpio0 ASPEED_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(V, 4)>;
+		};
+
+		event-psu0-alert {
+			label = "psu0-alert";
+			gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(V, 1)>;
+		};
+
+		event-psu1-alert {
+			label = "psu1-alert";
+			gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(V, 2)>;
+		};
+
+		event-thermal-alert {
+			label = "thermal-alert";
+			gpios = <&gpio0 ASPEED_GPIO(P, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(P, 2)>;
+		};
+
+		event-cpu-caterr {
+			label = "cpu-caterr";
+			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(N, 3)>;
+		};
+
+		event-cpu-thermtrip {
+			label = "cpu-thermtrip";
+			gpios = <&gpio0 ASPEED_GPIO(V, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(V, 5)>;
+		};
+
+		event-psu0-presence {
+			label = "psu0-presence";
+			gpios = <&gpio0 ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 6)>;
+		};
+
+		event-psu1-presence {
+			label = "psu1-presence";
+			gpios = <&gpio0 ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 7)>;
+		};
+
+		event-psu0-power-ok {
+			label = "psu0-power-ok";
+			gpios = <&gpio0 ASPEED_GPIO(M, 4) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(M, 4)>;
+		};
+
+		event-psu1-power-ok {
+			label = "psu1-power-ok";
+			gpios = <&gpio0 ASPEED_GPIO(M, 5) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(M, 5)>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <1000>;
+
+		event-fan0-presence {
+			label = "fan0-presence";
+			gpios = <&fan_ioexp 2 GPIO_ACTIVE_LOW>;
+			linux,code = <2>;
+		};
+
+		event-fan1-presence {
+			label = "fan1-presence";
+			gpios = <&fan_ioexp 6 GPIO_ACTIVE_LOW>;
+			linux,code = <6>;
+		};
+
+		event-fan2-presence {
+			label = "fan2-presence";
+			gpios = <&fan_ioexp 10 GPIO_ACTIVE_LOW>;
+			linux,code = <10>;
+		};
+
+		event-fan3-presence {
+			label = "fan3-presence";
+			gpios = <&fan_ioexp 14 GPIO_ACTIVE_LOW>;
+			linux,code = <14>;
+		};
+	};
+};
+
+&mac2 {
+	status = "okay";
+	use-ncsi;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64-alt.dtsi"
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&lpc_reset {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&udc {
+	status = "okay";
+};
+
+&adc0 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	temperature-sensor@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	temperature-sensor@49 {
+		compatible = "national,lm75";
+		reg = <0x49>;
+	};
+
+	temperature-sensor@4c {
+		compatible = "national,lm86";
+		reg = <0x4c>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	temperature-sensor@4f {
+		cpmpatible = "national,lm75";
+		reg = <0x4f>;
+	};
+
+	fan_ioexp: i2c-expander@20 {
+		compatible = "nxp,pca9535";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","","presence-fan0","",
+		"","","presence-fan1","",
+		"","","presence-fan2","",
+		"","","presence-fan3","";
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	psu@58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <1>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	psu@58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <1>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+
+	temperature-sensor@4d {
+		compatible = "national,lm75";
+		reg = <0x4d>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"CPU_PWRGD","","","power-button","host0-ready","","presence-ps0","presence-ps1",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","reset-button","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"power-chassis-control0","power-chassis-control1","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","power-chassis-good","","","";
+};
-- 
2.39.0

