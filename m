Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3C5BEA51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiITPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiITPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:35:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76431186EB;
        Tue, 20 Sep 2022 08:35:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k10so4442721lfm.4;
        Tue, 20 Sep 2022 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ecl+PWLDeZRsl3HvJzzHIyYVRQuW/pyjkIJTbZd04H8=;
        b=RNlHVAjfkoyBRu0CwzveM4sC8XOt7QdKhURZQmrGi9sDmLvnDaukL9mWZ6T/B99XzQ
         4thoznu8SkHt7oJsk7e9m99Yx0jEAnjYbhZdyTMkGbMmEC1vItv1iYR3Jeu79aaJMFlf
         m5BoiRws36L4oQQFl1nO85lhvoaIENxmubWqSPBkMOPmUCJbswVeCM0xPDLcnv8vbAXP
         KGn8XBcDM6wno37VibaVvXKMWzLdFECNrDugOcs/KAVCPPQgP2JMK2cTBjr0tc4aFH8P
         99Hwdex0iehySTrmGBDpd7kepLRjKD5oAA/xR8x5jDqIC3Rwixy6Jhj5Etol+y3q8jOG
         wD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ecl+PWLDeZRsl3HvJzzHIyYVRQuW/pyjkIJTbZd04H8=;
        b=EWPGGnOj5PWaWvWhLLejkKoe1fEsW1gOTgk8lGxl/o74uBsBW82iM5Se8GshwD4uIz
         APsBlBgRsSl3eNEfWbKeNEe7BjmVTpeNdKR66iB0UFXsb4o2I+7aDmVXQeJLhc1MVxYy
         RhuWn2rM85bq4tE7NUJ2AnKEIwxBtK7uThy5oFcbwGw01dwPyHsdfaURZEwAYdU4RM54
         VpH1cYsqyh3casN0XuU+eEvmiIN4s51uiqiZI3y1Ak1IryvgNkf9zisV/yMBaJJ0KLcI
         1W45mtWXc49RQhPnNafLsAHlDtf0bhcllXbRHMTYkJzK2+anIVYbRe4Lu92Ob2Gjhr8H
         uwqQ==
X-Gm-Message-State: ACrzQf3GSMkcaB3aCm1P1hvb3iuMPNWAQ2o+FjLczsYbcpdRkQV+RXlu
        X2abMCj+9btqZ4O77ugCGnY=
X-Google-Smtp-Source: AMsMyM5ln4dVFz2FBFN9t5bsti+KvFWOTbsMIIZKTLUUE+kGN0MohjETWnEfiIu3TOxgZQTcIF1oCQ==
X-Received: by 2002:ac2:5d26:0:b0:49e:cc05:cc4b with SMTP id i6-20020ac25d26000000b0049ecc05cc4bmr7970690lfb.621.1663688115657;
        Tue, 20 Sep 2022 08:35:15 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-10-176.ip.moscow.rt.ru. [46.242.10.176])
        by smtp.gmail.com with ESMTPSA id b22-20020a05651c033600b00268bfa6ffacsm6248ljp.108.2022.09.20.08.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:35:15 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
Date:   Tue, 20 Sep 2022 18:34:07 +0300
Message-Id: <20220920153409.6288-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial version of device tree for the BMC in the AMD DaytonaX
platform.

AMD DaytonaX platform is a customer reference board (CRB) with an
Aspeed ast2500 BMC manufactured by AMD.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts | 320 ++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts |  14 +-
 3 files changed, 333 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..9eff88d410aa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1575,6 +1575,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2600-evb-a1.dtb \
 	aspeed-ast2600-evb.dtb \
 	aspeed-bmc-amd-ethanolx.dtb \
+	aspeed-bmc-amd-daytonax.dtb \
 	aspeed-bmc-ampere-mtjade.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
new file mode 100644
index 000000000000..0e066b5ae0fb
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "AMD DaytonaX BMC";
+	compatible = "amd,daytonax-bmc", "aspeed,ast2500";
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlycon";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fault {
+			gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
+			<&adc 10>, <&adc 11>, <&adc 12>, <&adc 13>, <&adc 14>,
+			<&adc 15>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+};
+
+&uart1 {
+	//Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		&pinctrl_rxd1_default
+		&pinctrl_nrts1_default
+		&pinctrl_ndtr1_default
+		&pinctrl_ndsr1_default
+		&pinctrl_ncts1_default
+		&pinctrl_ndcd1_default
+		&pinctrl_nri1_default>;
+};
+
+&uart5 {
+	//BMC Console
+	status = "okay";
+};
+
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x3f8>;
+	aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default
+		&pinctrl_adc8_default
+		&pinctrl_adc9_default
+		&pinctrl_adc10_default
+		&pinctrl_adc11_default
+		&pinctrl_adc12_default
+		&pinctrl_adc13_default
+		&pinctrl_adc14_default
+		&pinctrl_adc15_default>;
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","","led-fault","led-identify","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"id-button","","","","","","","",
+	/*D0-D7*/	"","","ASSERT_BMC_READY","","","","","",
+	/*E0-E7*/	"reset-button","reset-control","power-button","power-control","",
+			"power-good","power-ok","",
+	/*F0-F7*/	"","","","","","","BATTERY_DETECT","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","",
+	/*AA0-AA7*/	"","","","","","","","",
+	/*AB0-AB7*/	"FM_BMC_READ_SPD_TEMP","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
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
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>, <0x81>;
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		&pinctrl_pwm1_default
+		&pinctrl_pwm2_default
+		&pinctrl_pwm3_default
+		&pinctrl_pwm4_default
+		&pinctrl_pwm5_default
+		&pinctrl_pwm6_default
+		&pinctrl_pwm7_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@1 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan@2 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan@3 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
+	};
+
+	fan@4 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+
+	fan@5 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05>;
+	};
+
+	fan@6 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06>;
+	};
+
+	fan@7 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07>;
+	};
+
+	fan@8 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x08>;
+	};
+
+	fan@9 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x09>;
+	};
+
+	fan@10 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0a>;
+	};
+
+	fan@11 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0b>;
+	};
+
+	fan@12 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0c>;
+	};
+
+	fan@13 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0d>;
+	};
+
+	fan@14 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0e>;
+	};
+
+	fan@15 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0f>;
+	};
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vhub {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 6406a0f080ee..90feac5ec628 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -5,6 +5,7 @@
 
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "AMD EthanolX BMC";
@@ -58,6 +59,7 @@ &fmc {
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
+		label = "bmc";
 		#include "openbmc-flash-layout.dtsi"
 	};
 };
@@ -78,7 +80,9 @@ &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
+		     &pinctrl_rxd1_default
+		     &pinctrl_nrts1_default
+		     &pinctrl_ncts1_default>;
 };
 
 &uart5 {
@@ -160,7 +164,7 @@ &i2c2 {
 &i2c3 {
 	status = "okay";
 	eeprom@50 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <64>;
 	};
@@ -261,6 +265,12 @@ &lpc_ctrl {
 	status = "okay";
 };
 
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x3f8>;
+	aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1

