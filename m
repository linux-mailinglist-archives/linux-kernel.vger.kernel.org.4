Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE163C000
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiK2MZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiK2MZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:25:55 -0500
X-Greylist: delayed 266 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 04:25:51 PST
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD30C532C1;
        Tue, 29 Nov 2022 04:25:51 -0800 (PST)
Received: from secure.fukaumi.org ([10.0.0.2])
        by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id 2ATCJw5h015199;
        Tue, 29 Nov 2022 21:19:59 +0900
From:   FUKAUMI Naoki <naoki@radxa.com>
To:     amadeus@jmu.edu.cn
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, pgwipeout@gmail.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK Pi E25
Date:   Tue, 29 Nov 2022 12:19:19 +0000
Message-Id: <20221129121919.366-1-naoki@radxa.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129070614.19720-2-amadeus@jmu.edu.cn>
References: <20221129070614.19720-2-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Radxa ROCK Pi E25 is a Rockchip RK3568 SBC, which is

there is no product called "ROCK Pi E25". it's "Radxa E25".
 https://wiki.radxa.com/Rock3/CM/CM3I/E25

> based on the Radxa ROCK Pi CM3 IO core board.

there is no product called "Radxa ROCK Pi CM3 IO (core board)". it's
"Radxa ROCK 3 Compute Module Industrial". (A.K.A. Radxa CM3I)
 https://wiki.radxa.com/Rock3/CM/CM3I

> It has the following features:
> 
> - MicroSD card socket, on board eMMC flash
> - 2x 2.5GbE Realtek RTL8125B Ethernet transceiver
> - 1x USB Type-C port (Power and Serial console)
> - 1x USB 3.0 OTG port
> - mini PCIe socket (USB or PCIe)
> - ngff PCIe socket [USB (or SATA, not tested)]

SATA is working on my E25. you may refer my dts,
 https://github.com/RadxaNaoki/linux/commits/rock-3

> - 1x User LED and 16x RGB LEDs
> - 26-pin expansion header
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3568-rock-pi-e25.dts  | 623 ++++++++++++++++++
>  2 files changed, 624 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-pi-e25.dts

I think dts should be separated, CM3I dtsi and E25 dts.

> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 0a76a2ebb5f6..dbf72f482636 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -82,3 +82,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-pi-e25.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-pi-e25.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-pi-e25.dts
> new file mode 100644
> index 000000000000..f75a9cf48e02
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-pi-e25.dts
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK Pi E25";
> +	compatible = "radxa,rockpi-e25", "rockchip,rk3568";
> +
> +	aliases {
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};

vendor u-boot/kernel use 115200bps to avoid character loss.
 https://github.com/radxa/u-boot/commit/ef9f6b1caadf81afe77a5d548c375ad7c9152ead
 https://github.com/radxa/kernel/commit/f62b47f7009636336f11fbbb88eaeef8a294f701

> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_user: led-0 {
> +			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_GREEN>;
> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&led_user_en>;
> +		};
> +	};
> +
> +	pwm-leds {
> +		compatible = "pwm-leds-multicolor";
> +
> +		multi-led {
> +			color = <LED_COLOR_ID_RGB>;
> +			max-brightness = <255>;
> +
> +			led-red {
> +				color = <LED_COLOR_ID_RED>;
> +				pwms = <&pwm1 0 1000000 0>;
> +			};
> +
> +			led-green {
> +				color = <LED_COLOR_ID_GREEN>;
> +				pwms = <&pwm2 0 1000000 0>;
> +			};
> +
> +			led-blue {
> +				color = <LED_COLOR_ID_BLUE>;
> +				pwms = <&pwm12 0 1000000 0>;
> +			};
> +		};
> +	};
> +
> +	typec_5v: typec-5v-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "typec_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	/* actually fed by vcc5v0_sys, dependent
> +	 * on pi6c clock generator
> +	 */
> +	vcc3v3_pcie30x1: vcc3v3-pcie30x1-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie30x1_enable_h>;
> +		regulator-name = "vcc3v3_pcie30x1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_pi6c_05>;
> +	};
> +
> +	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_enable_h>;
> +		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&minipcie_enable_h>;
> +		regulator-name = "vcc3v3_minipcie";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_ngff: vcc3v3-ngff-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ngffpcie_enable_h>;
> +		regulator-name = "vcc3v3_ngff";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&typec_5v>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&typec_5v>;
> +	};
> +
> +	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb_otg_en>;
> +		regulator-name = "vcc5v0_usb_otg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&combphy0 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&display_subsystem {
> +	status = "disabled";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-init-microvolt = <900000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-name = "vdd_gpu";
> +				regulator-always-on;
> +				regulator-init-microvolt = <900000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-name = "vdd_npu";
> +				regulator-init-microvolt = <900000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-name = "vdda0v9_image";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-name = "vdda_0v9";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name = "vccio_acodec";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-name = "vcca_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-name = "vcca1v8_image";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-name = "vcc3v3_sd";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&pcie2x1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie20_reset_h>;
> +	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pi6c_05>;
> +	status = "okay";
> +};
> +
> +&pcie30phy {
> +	data-lanes = <1 2>;
> +	status = "okay";
> +};
> +
> +&pcie3x1 {
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x1m0_pins>;
> +	reset-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie30x1>;
> +	status = "okay";
> +};
> +
> +&pcie3x2 {
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x2_reset_h>;
> +	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pi6c_05>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	leds {
> +		led_user_en: led_user_en {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie20_reset_h: pcie20-reset-h {
> +			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x1_enable_h: pcie30x1-enable-h {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x2_reset_h: pcie30x2-reset-h {
> +			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie_enable_h: pcie-enable-h {
> +			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		minipcie_enable_h: minipcie-enable-h {
> +			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		ngffpcie_enable_h: ngffpcie-enable-h {
> +			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_1v8>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&pwm12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm12m1_pins>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	/* Also used in pcie30x1_clkreqnm0 */
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	extcon = <&usb2phy0>;
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +	phy-supply = <&vcc5v0_usb_otg>;
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +&usb2phy1_host {
> +	phy-supply = <&vcc3v3_minipcie>;
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	phy-supply = <&vcc3v3_ngff>;
> +	status = "okay";
> +};

--
FUKAUMI Naoki
