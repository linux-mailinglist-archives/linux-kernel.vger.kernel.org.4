Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C25B8F72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiINUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiINUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:01:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2908275E;
        Wed, 14 Sep 2022 13:01:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dv25so37230819ejb.12;
        Wed, 14 Sep 2022 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=GqSVl2wuF3SdqA6bpwUS/1MpYYqFvRrH95FXWD7+cCo=;
        b=HM824CHX0lfxr/BSdkos2oStz+oOatti92+QU4prOEOVtSIc1RIGDg5EOX1FhkM5b7
         BT8eOnRTMU2j3KxSOeFzvlo8KwDB5YXj3Mg2fxL0H/kbiw0UpWn8kDufCE/JCf8DS+2x
         KXDwUNr0PMiCmyLJxRkWXkkbDOXnITDxW4cvRPHQQHDtWUuJOR2xEdSLlCVdNrTIUNdf
         N4fsrT3f/P6rJ8UOag+CvYMLYDimGlrLmQaQuDl0u92Flzw5JdnAzZubVVZaRiCMqi91
         3Au53a4NukiJoc5BGERTWClKDi2GT/oXuTTp4T9gPgQDDpJlRGuy7gOEHUw0bOEpciio
         e1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GqSVl2wuF3SdqA6bpwUS/1MpYYqFvRrH95FXWD7+cCo=;
        b=5383fsbqN7KFT2W8JAlPdbiHNGeykqP9qjcuSZe98452XYjN8TYKNEfLMW3JkgNWtl
         s2E2Fp8PCzhNGtdW1R3lXAJDeopc0kggOYYAm9wl26MP6GJAy7z5wGR8dgGu/SFPFMEJ
         P1hd+YbfDtaMKUEXf/bVpM38dD0ZYcSDlF4QfyGjIG2YDHVT7yAe6nE2i60i4AaJ+IV/
         s4AzOrJfiRsUUy4b7ST/tVkGmsg3BbXX6+XbMf4ySjPdrojfenSonVAU687xm6DgglCR
         YYAH/a8CPeGxKgGmhyHf2UGvUJxY1Jg4IrBJtaa4GG9Kbfajd1QBIR1QfGIITN2FAcgx
         S+Pw==
X-Gm-Message-State: ACgBeo3toZ54C9aSyj7awRi1PRfqHqszM5ViQk4ccWIEQss7PzaqbvGk
        ddDp+oXOmMYhP9CB3OOouL5eV66WGvL8Trgp
X-Google-Smtp-Source: AA6agR6hyzyn5YMfU7IdsCcsn44gAbjSx/rzxY+b0zCE8i8R1UyqGZf8Nhz6lasfVAui3C4IoyT3vA==
X-Received: by 2002:a17:907:6d90:b0:77c:68a8:a5b with SMTP id sb16-20020a1709076d9000b0077c68a80a5bmr13617621ejc.342.1663185677288;
        Wed, 14 Sep 2022 13:01:17 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id bo24-20020a0564020b3800b0044e8ecb9d25sm10266619edb.52.2022.09.14.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 13:01:16 -0700 (PDT)
Date:   Wed, 14 Sep 2022 19:59:31 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Changes phy configuration to expose sata in place of usb3 on
 quartz64-a board
Message-ID: <YyIyo42QWvgJTBjL@lab.hqhome163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64 board is built upon Rockchip RK3566.
Rockchip RK3566 has two combo phys.
The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
ctrl2.
The second combo phy is hardwired to the PCIe slot, where for the first,
the hardware on the board provides both the USB3 connector and the SATA
connector.
This DT allows the users to switch the combo phy to the SATA connector.

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 .../dts/rockchip/rk3566-quartz64-a.sata.dts   | 839 ++++++++++++++++++
 1 file changed, 839 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
new file mode 100644
index 000000000000..6ac21b729be7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
@@ -0,0 +1,839 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3566.dtsi"
+
+/ {
+	model = "Pine64 RK3566 Quartz64-A Board";
+	compatible = "pine64,quartz64-a", "rockchip,rk3566";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	gmac1_clkin: external-gmac1-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "gmac1_clkin";
+		#clock-cells = <0>;
+	};
+
+	fan: gpio_fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0    0
+				      4500 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fan_en_h>;
+		#cooling-cells = <2>;
+	};
+
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-work {
+			label = "work-led";
+			default-state = "off";
+			gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&work_led_enable_h>;
+			retain-state-suspended;
+		};
+
+		led-diy {
+			label = "diy-led";
+			default-state = "on";
+			gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&diy_led_enable_h>;
+			retain-state-suspended;
+		};
+	};
+
+	rk817-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK817";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk817>;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk817 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <5000000>;
+		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+
+	spdif_dit: spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	spdif_sound: spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_dit>;
+		};
+	};
+
+	vcc12v_dcin: vcc12v_dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	/* vbus feeds the rk817 usb input.
+	 * With no battery attached, also feeds vcc_bat+
+	 * via ON/OFF_BAT jumper
+	 */
+	vbus: vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_enable_h>;
+		regulator-name = "vcc3v3_pcie_p";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc5v0_usb: vcc5v0_usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	/* all four ports are controlled by one gpio
+	 * the host ports are sourced from vcc5v0_usb
+	 * the otg port is sourced from vcc5v0_midu
+	 */
+	vcc5v0_usb20_host: vcc5v0_usb20_host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb20_host_en>;
+		regulator-name = "vcc5v0_usb20_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc5v0_usb20_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dcdc_boost>;
+	};
+
+	vcc3v3_sd: vcc3v3_sd {
+		compatible = "regulator-fixed";
+		enable-active-low;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc_sd_h>;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
+	vcc_sys: vcc_sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <4400000>;
+		regulator-max-microvolt = <4400000>;
+		vin-supply = <&vbus>;
+	};
+
+	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
+	vcc_wl: vcc_wl {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_wl";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sys>;
+	};
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_thermal {
+	trips {
+		cpu_hot: cpu_hot {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
+	clock_in_out = "input";
+	phy-supply = <&vcc_3v3>;
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m0_miim
+		     &gmac1m0_tx_bus2
+		     &gmac1m0_rx_bus2
+		     &gmac1m0_rgmii_clk
+		     &gmac1m0_clkinout
+		     &gmac1m0_rgmii_bus>;
+	snps,reset-gpio = <&gpio0 RK_PC3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	phy-handle = <&rgmii_phy1>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdda_0v9>;
+	avdd-1v8-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk817: pmic@20 {
+		compatible = "rockchip,rk817";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
+		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
+		wakeup-source;
+
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc5-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
+		vcc8-supply = <&vcc_sys>;
+		vcc9-supply = <&dcdc_boost>;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_logic";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_gpu";
+					regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v3: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_3v3";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_acodec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8_dvp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc2v8_dvp: LDO_REG9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-name = "vcc2v8_dvp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			dcdc_boost: BOOST {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-name = "boost";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			otg_switch: OTG_SWITCH {
+				regulator-name = "otg_switch";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+/* i2c3 is exposed on con40
+ * pin 3 - i2c3_sda_m0, pullup to vcc_3v3
+ * pin 5 - i2c3_scl_m0, pullup to vcc_3v3
+ */
+&i2c3 {
+	status = "okay";
+};
+
+&i2s0_8ch {
+	status = "okay";
+};
+
+&i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx
+		     &i2s1m0_lrcktx
+		     &i2s1m0_sdi0
+		     &i2s1m0_sdo0>;
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
+	status = "okay";
+};
+
+&pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins = <2 RK_PC0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins = <2 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	fan {
+		fan_en_h: fan-en-h {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		work_led_enable_h: work-led-enable-h {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		diy_led_enable_h: diy-led-enable-h {
+			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie {
+		pcie_enable_h: pcie-enable-h {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb2 {
+		vcc5v0_usb20_host_en: vcc5v0-usb20-host-en {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	vcc_sd {
+		vcc_sd_h: vcc-sd-h {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc1v8_dvp>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_wl>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sfc {
+	pinctrl-0 = <&fspi_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "disabled";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+/* spdif is exposed on con40 pin 18 */
+&spdif {
+	status = "okay";
+};
+
+/* spi1 is exposed on con40
+ * pin 11 - spi1_mosi_m1
+ * pin 13 - spi1_miso_m1
+ * pin 15 - spi1_clk_m1
+ * pin 17 - spi1_cs0_m1
+ */
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1m1_cs0 &spi1m1_pins>;
+};
+
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+/* uart0 is exposed on con40
+ * pin 12 - uart0_tx
+ * pin 14 - uart0_rx
+ */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn>;
+	status = "okay";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk817 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+		vbat-supply = <&vcc_sys>;
+		vddio-supply = <&vcca1v8_pmu>;
+	};
+};
+
+/* uart2 is exposed on con40
+ * pin 8 - uart2_tx_m0_debug
+ * pin 10 - uart2_rx_m0_debug
+ */
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* usb3 controller is muxed with sata1 */
+&sata1 {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_usb20_otg>;
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.34.1

