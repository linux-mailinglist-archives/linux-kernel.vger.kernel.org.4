Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D97691D04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjBJKjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBJKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:38:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB8CC07
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:38:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso8364249pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACnHvTU7gEng4y82wmBORUtHHJ+pZWFgrAC6kuRsmqw=;
        b=upOZiQhd0RX2x1omiYwQGd/DuEYL09P/GjQhlBuW0vwFelDEyyc8CFaHT7keFLvFcN
         WjrjWobT7HGKOeIT2JRwSLzOo+5JzvhzZ0ThhQg8tq4rnYCbdZsTLInvRNz+yljTYcfX
         gevxdzKb0rRa9M/YTS0NmjWOqJR9E7YYF6saw5XQjX5SwBzZ5lYWKXgDE19xa7ubxNof
         UHb5gwwxOLqucZ+7Z30FjdHmXvcsQ1z7dQaDqrR3jiOAywDaZ6a1aSTco2BHI+MsyOME
         s/umcus118s3yqi2pPdsfPxJVLAjzr4Js0453WGh1yzve9x/zEEifjzjoN5mb4xWa26A
         ZHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACnHvTU7gEng4y82wmBORUtHHJ+pZWFgrAC6kuRsmqw=;
        b=fK7jBQrCtVz36M7zXilNPT6kgFJ8SqmH2l48IAyBCJ2MDZL/x/Ch4a5ZHT9FpPTENC
         OPt2bUkmndF/dMqLPumH2WqTX6R96rirBpPax6VbumYuMpMyYN7DFnMQXj3pj3asG3O1
         pz/wwWusdQpBFH/BIc/5YaWxXFen0+sS24+Y6t/ZKAQ7XMTlUJ68yLN/q9fWllO4Z8MK
         L4SaRciKeWzJ+fjEmoyk9XBGB2iCX4H6cimLYLzGlAjDdqPtoYkuxj7L4/9Yok/n46ML
         MHsHftR3T/OENyX8mGTUP+NRReGEz2zEE7X8UjBSveUjeE/zxSGsiu3LRgX+yhFbLUwP
         pqbg==
X-Gm-Message-State: AO0yUKUwEu00Z5/7i0cd6nVWdoH0RdZNLbmogwAU7ZBrRfVaAzSVKAn2
        mwknolEdM8gzYpygr89i44ZpbQ==
X-Google-Smtp-Source: AK7set8jYO4WESox6/84onZMAE53uv1nj/PtAzJnxcrlx13j3y9gqRXLtLfihZRa+keorSrm5w/Qxw==
X-Received: by 2002:a05:6a21:3389:b0:bc:c86a:f60f with SMTP id yy9-20020a056a21338900b000bcc86af60fmr17009625pzb.54.1676025534766;
        Fri, 10 Feb 2023 02:38:54 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b005809d382016sm2973950pfm.74.2023.02.10.02.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:38:54 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC
Date:   Fri, 10 Feb 2023 18:38:29 +0800
Message-Id: <20230210103829.74470-2-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210103829.74470-1-jordan.chang@ufispace.com>
References: <20230210103829.74470-1-jordan.chang@ufispace.com>
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

