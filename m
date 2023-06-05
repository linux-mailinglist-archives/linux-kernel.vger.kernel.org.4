Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5407721B31
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjFEAWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEAWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6249CC;
        Sun,  4 Jun 2023 17:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4509E60BBF;
        Mon,  5 Jun 2023 00:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741BCC433EF;
        Mon,  5 Jun 2023 00:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685924534;
        bh=txO3Oea/MAFL2H+6EmnHqNe0dqHZwszaXJbuYwZkdaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpuQwwD3hSDq8P3TJogujK+5+JwtOeHLml25Osju4qjK2CydySAAXjTUwhu4lEaNV
         9UiXudZeqBK2232QQPtMwnw9sbQEA4C5rN5HRJdiV/JzYoS6HopzWmuEdX8POIRZol
         /ZX6aHxKsLHeotFa8WWwaBc4Oluoq98LnL0aXQHxp1wef5u9SA8BvZfjrMKblHOVf5
         A0hjHjI9bQ/g8fYE/wZUBIeFIDS6Zg4ISsW3bZ/v/PMhxRI8/mbAxWVZ+p+3IAo46+
         EkHp8fgwarJsmh5kVWgQu5wZxSKpYZBI+B+oSlRuws2Qftsow8sFGXadLXyVfDzs6e
         LhBb2hHYeTg1Q==
Date:   Mon, 5 Jun 2023 08:21:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: update to revB PCB
Message-ID: <20230605002154.GT4199@dragon>
References: <20230601193112.4083934-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601193112.4083934-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 12:31:12PM -0700, Tim Harvey wrote:
> Update the imx8mp-venice-gw74xx for revB:
>  - add CAN1
>  - add TIS-TPM on SPI2
>  - add FAN controller
>  - fix PMIC I2C bus (revA PMIC I2C was non-functional so no need for
>    backward compatible option)
>  - M2 socket GPIO's moved
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../dts/freescale/imx8mp-venice-gw74xx.dts    | 261 +++++++++++-------
>  1 file changed, 159 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index eb51d648359b..0e389ec5c2d4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -125,12 +125,22 @@ reg_usb2_vbus: regulator-usb2 {
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> +	reg_can1_stby: regulator-can1-stby {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_can1>;
> +		regulator-name = "can1_stby";
> +		gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
>  	reg_can2_stby: regulator-can2-stby {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_reg_can>;
> +		pinctrl-0 = <&pinctrl_reg_can2>;
>  		regulator-name = "can2_stby";
> -		gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
> +		gpio = <&gpio5 5 GPIO_ACTIVE_LOW>;
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  	};
> @@ -164,6 +174,21 @@ &A53_3 {
>  	cpu-supply = <&reg_arm>;
>  };
>  
> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	tpm@0 {
> +		compatible = "tcg,tpm_tis-spi";
> +		#address-cells = <0x1>;
> +		#size-cells = <0x1>;
> +		reg = <0x0>;
> +		spi-max-frequency = <36000000>;
> +	};
> +};
> +
>  /* off-board header */
>  &ecspi2 {
>  	pinctrl-names = "default";
> @@ -204,6 +229,13 @@ fixed-link {
>  	};
>  };
>  
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can1_stby>;
> +	status = "okay";
> +};
> +
>  &flexcan2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan2>;
> @@ -214,38 +246,38 @@ &flexcan2 {
>  &gpio1 {
>  	gpio-line-names =
>  		"", "", "", "", "", "", "", "",
> -		"", "", "dio0", "", "dio1", "", "", "",
> +		"", "dio0", "", "dio1", "", "", "", "",
>  		"", "", "", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "";
>  };
>  
>  &gpio2 {
>  	gpio-line-names =
> -		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "", "pcie3_wdis#", "",
> +		"", "", "", "", "", "", "m2_pin20", "",
> +		"", "", "", "", "", "pcie1_wdis#", "pcie3_wdis#", "",
>  		"", "", "pcie2_wdis#", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "";
>  };
>  
>  &gpio3 {
>  	gpio-line-names =
> -		"m2_gdis#", "", "", "", "", "", "", "m2_rst#",
> +		"", "", "", "", "", "", "m2_rst", "",
> +		"", "", "", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "",
> -		"m2_off#", "", "", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "";
>  };
>  
>  &gpio4 {
>  	gpio-line-names =
> +		"", "", "m2_off#", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "", "", "", "",
> -		"", "", "", "", "m2_wdis#", "", "", "",
> -		"", "", "", "", "", "", "", "uart_rs485";
> +		"", "", "m2_wdis#", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "rs485_en";
>  };
>  
>  &gpio5 {
>  	gpio-line-names =
> -		"uart_half", "uart_term", "", "", "", "", "", "",
> +		"rs485_hd", "rs485_term", "", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "",
>  		"", "", "", "", "", "", "", "";
> @@ -286,6 +318,12 @@ channel@8 {
>  				label = "vdd_bat";
>  			};
>  
> +			channel@16 {
> +				gw,mode = <4>;
> +				reg = <0x16>;
> +				label = "fan_tach";
> +			};
> +
>  			channel@82 {
>  				gw,mode = <2>;
>  				reg = <0x82>;
> @@ -358,6 +396,11 @@ channel@a2 {
>  				gw,voltage-divider-ohms = <10000 10000>;
>  			};
>  		};
> +
> +		fan-controller@0 {

The unit-address doesn't match 'reg' property below.

Shawn

> +			compatible = "gw,gsc-fan";
> +			reg = <0x0a>;
> +		};
>  	};
>  
>  	gpio: gpio@23 {
> @@ -369,85 +412,6 @@ gpio: gpio@23 {
>  		interrupts = <4>;
>  	};
>  
> -	pmic@25 {
> -		compatible = "nxp,pca9450c";
> -		reg = <0x25>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_pmic>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -
> -		regulators {
> -			BUCK1 {
> -				regulator-name = "BUCK1";
> -				regulator-min-microvolt = <720000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <3125>;
> -			};
> -
> -			reg_arm: BUCK2 {
> -				regulator-name = "BUCK2";
> -				regulator-min-microvolt = <720000>;
> -				regulator-max-microvolt = <1025000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <3125>;
> -				nxp,dvs-run-voltage = <950000>;
> -				nxp,dvs-standby-voltage = <850000>;
> -			};
> -
> -			BUCK4 {
> -				regulator-name = "BUCK4";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3600000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			BUCK5 {
> -				regulator-name = "BUCK5";
> -				regulator-min-microvolt = <1650000>;
> -				regulator-max-microvolt = <1950000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			BUCK6 {
> -				regulator-name = "BUCK6";
> -				regulator-min-microvolt = <1045000>;
> -				regulator-max-microvolt = <1155000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			LDO1 {
> -				regulator-name = "LDO1";
> -				regulator-min-microvolt = <1650000>;
> -				regulator-max-microvolt = <1950000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			LDO3 {
> -				regulator-name = "LDO3";
> -				regulator-min-microvolt = <1710000>;
> -				regulator-max-microvolt = <1890000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			LDO5 {
> -				regulator-name = "LDO5";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> -
>  	eeprom@50 {
>  		compatible = "atmel,24c02";
>  		reg = <0x50>;
> @@ -559,7 +523,6 @@ fixed-link {
>  	};
>  };
>  
> -/* off-board header */
>  &i2c3 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default", "gpio";
> @@ -568,6 +531,85 @@ &i2c3 {
>  	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			reg_arm: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <720000>;
> +				regulator-max-microvolt = <1025000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1045000>;
> +				regulator-max-microvolt = <1155000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1650000>;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1710000>;
> +				regulator-max-microvolt = <1890000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
>  };
>  
>  /* off-board header */
> @@ -726,12 +768,14 @@ pinctrl_hog: hoggrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09	0x40000040 /* DIO0 */
>  			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x40000040 /* DIO1 */
> -			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x40000040 /* M2SKT_OFF# */
> -			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	0x40000150 /* PCIE2_WDIS# */
> +			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x40000040 /* M2SKT_OFF# */
> +			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x40000150 /* M2SKT_WDIS# */
> +			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40000040 /* M2SKT_PIN20 */
> +			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11	0x40000040 /* M2SKT_PIN22 */
> +			MX8MP_IOMUXC_SD2_CLK__GPIO2_IO13	0x40000150 /* PCIE1_WDIS# */
>  			MX8MP_IOMUXC_SD2_CMD__GPIO2_IO14	0x40000150 /* PCIE3_WDIS# */
> +			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	0x40000150 /* PCIE2_WDIS# */
>  			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	0x40000040 /* M2SKT_RST# */
> -			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x40000150 /* M2SKT_WDIS# */
> -			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00	0x40000150 /* M2SKT_GDIS# */
>  			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x40000104 /* UART_TERM */
>  			MX8MP_IOMUXC_SAI3_TXFS__GPIO4_IO31	0x40000104 /* UART_RS485 */
>  			MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00	0x40000104 /* UART_HALF */
> @@ -784,6 +828,13 @@ MX8MP_IOMUXC_SAI1_RXC__ENET1_1588_EVENT0_OUT	0x140
>  		>;
>  	};
>  
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX		0x154
> +			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX		0x154
> +		>;
> +	};
> +
>  	pinctrl_flexcan2: flexcan2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
> @@ -869,7 +920,7 @@ MX8MP_IOMUXC_SD2_DATA1__GPIO2_IO16	0x10
>  
>  	pinctrl_pcie0: pciegrp {
>  		fsl,pins = <
> -			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	0x110
> +			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	0x106
>  		>;
>  	};
>  
> @@ -885,12 +936,18 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x140
>  		>;
>  	};
>  
> -	pinctrl_reg_can: regcangrp {
> +	pinctrl_reg_can1: regcan1grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x154
>  		>;
>  	};
>  
> +	pinctrl_reg_can2: regcan2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05	0x154
> +		>;
> +	};
> +
>  	pinctrl_reg_usb2: regusb2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06	0x140
> @@ -903,12 +960,12 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x110
>  		>;
>  	};
>  
> -	pinctrl_sai2: sai2grp {
> +	pinctrl_spi1: spi1grp {
>  		fsl,pins = <
> -			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
> -			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
> -			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
> -			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
> +			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK	0x82
> +			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI	0x82
> +			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO	0x82
> +			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x140
>  		>;
>  	};
>  
> -- 
> 2.25.1
> 
