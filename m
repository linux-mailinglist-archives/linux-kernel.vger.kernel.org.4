Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A091561E6E5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKFWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKFWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:35:07 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58873AE6E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:35:05 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id 431E3378510
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fowr9dGzPI3g for <linux-kernel@vger.kernel.org>;
        Sun,  6 Nov 2022 23:40:01 +0100 (CET)
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by mail.rnplus.nl (Postfix) with ESMTPSA id 61799377D7B;
        Sun,  6 Nov 2022 23:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1667774396; bh=PGh4TeK6Tq1WKGcotdl2MGS+Gx9fUkonV1urhUlF+lo=;
        h=Date:From:To:Cc:Subject;
        b=Wma/hVliRzlfkzXviTrjigSePjeRBE2MthcmttOgqrBZdt+0iWQ1pfYavXgshYuHV
         m38tZuuV6FzV2IkqiHzEsmg0BHZ0MlHhuEjgKEV/zw+DghDDpEL7uMevRh0mmNMWKj
         DmrcfHdjB6LI6WLj48MfPNUKt0r+MJ+mhX965qKk=
MIME-Version: 1.0
Date:   Sun, 06 Nov 2022 23:39:55 +0100
From:   Renze Nicolai <renze@rnplus.nl>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] ARM: dts: aspeed: Add ASRock X570D4U BMC
User-Agent: RN+ Webmail
Message-ID: <7baebe77f0f8963e06d5ddeec6c737f5@rnplus.nl>
X-Sender: renze@rnplus.nl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a relatively low-cost AST2500-based Amd Ryzen 5000 Series
micro-ATX board that we hope can provide a decent platform for OpenBMC
development.

This initial device-tree provides the necessary configuration for
basic BMC functionality such as serial console, KVM support
and POST code snooping.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
  arch/arm/boot/dts/Makefile                    |   1 +
  .../boot/dts/aspeed-bmc-asrock-x570d4u.dts    | 360 ++++++++++++++++++
  2 files changed, 361 insertions(+)
  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-x570d4u.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6aa7dc4db2fc..adbbf27dfcee 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1587,6 +1587,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
  	aspeed-bmc-asrock-e3c246d4i.dtb \
  	aspeed-bmc-asrock-romed8hm3.dtb \
+	aspeed-bmc-asrock-x570d4u.dtb \
  	aspeed-bmc-bytedance-g220a.dtb \
  	aspeed-bmc-facebook-bletchley.dtb \
  	aspeed-bmc-facebook-cloudripper.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-x570d4u.dts 
b/arch/arm/boot/dts/aspeed-bmc-asrock-x570d4u.dts
new file mode 100644
index 000000000000..818c8879e0a0
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-x570d4u.dts
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2022 Renze Nicolai <renze@rnplus.nl>
+
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Asrock Rack X570D4U BMC";
+	compatible = "asrock,x570d4u-bmc";
+
+	chosen {
+			stdout-path = &uart5;
+			bootargs = "console=ttyS4,115200 earlycon";
+	};
+
+	memory@80000000 {
+			reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			flash_memory: region@98000000 {
+					no-map;
+					reg = <0x98000000 0x04000000>; /* 64M */
+			};
+
+			vga_memory: framebuffer@9f000000 {
+				no-map;
+				reg = <0x9f000000 0x01000000>; /* 16M */
+			};
+
+			pci_memory: region@9A000000 {
+				no-map;
+				reg = <0x9A000000 0x00010000>; /* 64K */
+			};
+
+			video_engine_memory: jpegbuffer {
+				size = <0x02800000>;	/* 40M */
+				alignment = <0x01000000>;
+				compatible = "shared-dma-pool";
+				reusable;
+			};
+
+			gfx_memory: framebuffer {
+				size = <0x01000000>;
+				alignment = <0x01000000>;
+				compatible = "shared-dma-pool";
+				reusable;
+			};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			/* BMC_HB_LED_N */
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+
+		system-fault {
+			/* SYSTEM_FAULT_LED_N */
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			panic-indicator;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
+			<&adc 10>, <&adc 11>, <&adc 12>;
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A3*/       "LOCATORLED_STATUS_N",    "",                     
"NMI_BTN_N",          "BMC_NMI",
+	/*A4-A7*/       "",                       "",                     "",  
                  "",
+	/*B0-B3*/       "FM_BIOS_POST_CMPLT_N",   "",                     "",  
                  "",
+	/*B4-B7*/       "",                       "IRQ_BMC_PCH_SMI_LPC_N","",  
                  "",
+	/*C0-C3*/       "",                       "",                     "",  
                  "",
+	/*C4-C7*/       "",                       "",                     
"LOCATORBTN",         "",
+	/*D0-D3*/       "BMC_PSIN",               "BMC_PSOUT",            
"BMC_RESETCON",       "RESETCON",
+	/*D4-D7*/       "",                       "",                     "",  
                  "",
+	/*E0-E3*/       "",                       "",                     "",  
                  "",
+	/*E4-E7*/       "",                       "",                     "",  
                  "",
+	/*F0-F3*/       "",                       "",                     "",  
                  "",
+	/*F4-F7*/       "",                       "",                     "",  
                  "",
+	/*G0-G3*/       "HWM_BAT_EN",             "CHASSIS_ID0",          
"CHASSIS_ID1",        "CHASSIS_ID2",
+	/*G4-G7*/       "BMC_ALERT1_N_R",         "BMC_ALERT2_N_R",       
"BMC_ALERT3_N",       "SML0ALERT",
+	/*H0-H3*/       "",                       "O_PWROK",              "",  
                  "",
+	/*H4-H7*/       "MFG_MODE_N",             "BMC_RTCRST",           
"BMC_HB_LED_N",       "BMC_CASEOPEN",
+	/*I0-I3*/       "",                       "",                     "",  
                  "",
+	/*I4-I7*/       "",                       "",                     "",  
                  "",
+	/*J0-J3*/       "BMC_READY",              "",                     "",  
                  "",
+	/*J4-J7*/       "VGAHS",                  "VGAVS",                
"DDCCLK",             "DDCDAT",
+	/*K0-K3*/       "I2C_SCL4",               "I2C_SDA4",             
"I2C_SCL5",           "I2C_SDA5",
+	/*K4-K7*/       "",                       "",                     
"I2C_SCL7",           "I2C_SDA7",
+	/*L0-L3*/       "BMC_CTS1",               "BMC_DCD1",             
"BMC_DSR1",           "BMC_RI1",
+	/*L4-L7*/       "BMC_DTR1",               "BMC_RTS1",             
"BMC_TXD1",           "BMC_RXD1",
+	/*M0-M3*/       "BMC_LAN0_DIS_N",         "BMC_LAN1_DIS_N",       "",  
                  "",
+	/*M4-M7*/       "",                       "",                     "",  
                  "",
+	/*N0-N3*/       "PWM_FAN1",               "PWM_FAN2",             
"PWM_FAN3",           "PWM_FAN4",
+	/*N4-N7*/       "PWM_FAN6",               "PWM_FAN5",             "",  
                  "",
+	/*O0-O3*/       "TACHO_FAN1",             "TACHO_FAN2",           
"TACHO_FAN3",         "TACHO_FAN4",
+	/*O4-O7*/       "TACHO_FAN5",             "TACHO_FAN6",           "",  
                  "",
+	/*P0-P3*/       "",                       "",                     "",  
                  "PS_PWROK",
+	/*P4-P7*/       "",                       "",                     "",  
                  "",
+	/*Q0-Q3*/       "I2C_SCL2",               "I2C_SDA2",             
"I2C_SCL3",           "I2C_SDA3",
+	/*Q4-Q7*/       "BMC_SBM_PRESENT_1_N",    "BMC_SBM_PRESENT_2_N",  
"BMC_SBM_PRESENT_3_N","BMC_PCIE_WAKE_N",
+	/*R0-R3*/       "",                       "",                     "",  
                  "",
+	/*R4-R7*/       "",                       "",                     "",  
                  "",
+	/*S0-S3*/       "PCHHOT_BMC_N",           "",                     
"RSMRST",             "",
+	/*S4-S7*/       "",                       "",                     "",  
                  "",
+	/*T0-T3*/       "RGMII1TXCK",             "RGMII1TXCL",           
"RGMII1TXD0",         "RGMII1TXD1",
+	/*T4-T7*/       "RGMII1TXD2",            "RGMII1TXD3",           
"RMII2RCLKO",         "RMII2TXEN",
+	/*U0-U3*/       "RMII2TXD0",              "RMII2TXD1",            "",  
                  "",
+	/*U4-U7*/       "RGMII1RXCK",             "RGMII1RXCTL",          
"RGMII1RXD0",         "RGMII1RXD1",
+	/*V0-V3*/       "RGMII1RXD2",             "RGMII1RXD3",           
"RMII2RCLKI",         "",
+	/*V4-V7*/       "RMII2RXD0",              "RMII2RXD1",            
"RMII2CRSDV",         "RMII2RXER",
+	/*W0-W3*/       "",                       "",                     "",  
                  "",
+	/*W4-W7*/       "",                       "",                     "",  
                  "",
+	/*X0-X3*/       "",                       "",                     "",  
                  "",
+	/*X4-X7*/       "",                       "",                     "",  
                  "",
+	/*Y0-Y3*/       "SLP_S3",                 "SLP_S5",               "",  
                  "",
+	/*Y4-Y7*/       "I2C_SCL0",               "I2C_SDA0",             
"I2C_SCL1",           "I2C_SDA1",
+	/*Z0-Z3*/       "",                       "",                     
"SYSTEM_FAULT_LED_N", "BMC_THROTTLE_N",
+	/*Z4-Z7*/       "",                       "",                     "",  
                  "",
+	/*AA0-AA3*/     "CPU1_THERMTRIP_LATCH_N", "",                     
"CPU1_PROCHOT_N",     "",
+	/*AA4-AC7*/     "",                       "",                     "",  
                  "",
+	/*AB0-AB3*/     "",                       "",                     "",  
                  "",
+	/*AB4-AC7*/     "",                       "",                     "",  
                  "",
+	/*AC0-AC3*/     "LAD0",                   "LAD1",                 
"LAD2",               "LAD3",
+	/*AC4-AC7*/     "CK_33M_BMC",             "LFRAME",               
"SERIRQ",             "S_PLTRST";
+
+
+	/* Assert BMC_READY so BIOS doesn't sit around waiting for it */
+	bmc-ready {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
+		output-high;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+			status = "okay";
+			label = "bmc";
+			m25p,fast-read;
+			spi-max-frequency = <10000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&vuart {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii2_default &pinctrl_mdio2_default>;
+	use-ncsi;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	w83773g@4c {
+		compatible = "nuvoton,w83773g";
+		reg = <0x4c>;
+	};
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
+
+	i2c-switch@70 {
+		compatible = "nxp,pca9545";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		interrupt-parent = <&i2c_ic>;
+		interrupts = <4>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+
+	eeprom@57 {
+		compatible = "st,24c128", "atmel,24c128";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+&gfx {
+	status = "okay";
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&vhub {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+&uhci {
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&p2a {
+	status = "okay";
+	memory-region = <&pci_memory>;
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+				&pinctrl_pwm1_default
+				&pinctrl_pwm2_default
+				&pinctrl_pwm3_default
+				&pinctrl_pwm4_default
+				&pinctrl_pwm5_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x01>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x03>;
+	};
+	fan@2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x05>;
+	};
+	fan@3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x07>;
+	};
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x08 0x09>;
+	};
+	fan@5 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0a 0x0b>;
+	};
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+				&pinctrl_adc1_default
+				&pinctrl_adc2_default
+				&pinctrl_adc3_default
+				&pinctrl_adc4_default
+				&pinctrl_adc5_default
+				&pinctrl_adc6_default
+				&pinctrl_adc7_default
+				&pinctrl_adc8_default
+				&pinctrl_adc9_default
+				&pinctrl_adc10_default
+				&pinctrl_adc11_default
+				&pinctrl_adc12_default
+				&pinctrl_adc13_default
+				&pinctrl_adc14_default
+				&pinctrl_adc15_default>;
+};
-- 
2.38.1
