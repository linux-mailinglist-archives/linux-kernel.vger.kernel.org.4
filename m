Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6B652154
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiLTNRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiLTNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:17:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733A219C37
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:17:28 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7cUg-0003tS-Mi; Tue, 20 Dec 2022 14:17:18 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7cUd-0004wG-Ba; Tue, 20 Dec 2022 14:17:15 +0100
Date:   Tue, 20 Dec 2022 14:17:15 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, linux@armlinux.org.uk, jernej.skrabec@gmail.com,
        kernel@pengutronix.de, alistair23@gmail.com, festevam@gmail.com
Subject: Re: [PATCH v2 3/3] ARM: dts: imx7d-remarkable2: Enable the
 rohm,bd71815
Message-ID: <20221220131715.femjybikqcnm4lyg@pengutronix.de>
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220112927.440506-4-alistair@alistair23.me>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

thanks for your patch, please see below.

On 22-12-20, Alistair Francis wrote:
> Add support for the rohm,bd71815 power controller controller for the
> reMarkable 2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 159 ++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index a138b292ec6a..4387d30d6180 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck1_reg>;
> +};
> +
>  &clks {
>  	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
>  			  <&clks IMX7D_CLKO2_ROOT_DIV>;
> @@ -119,6 +123,148 @@ wacom_digitizer: digitizer@9 {
>  	};
>  };
>  
> +&i2c2 {
> +	clock-frequency = <100000>;

We can set this now to 400kHz since the driver can handle quirks now
internal.

> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2>;

Do we need a "sleep" config here since this will be the same
configuration as the "default" one.

> +	status = "okay";
> +
> +	bd71815: pmic@4b {
> +		compatible = "rohm,bd71815";
> +		reg = <0x4b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_bd71815>;
> +		interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-controller;
> +		clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
> +		clock-output-names = "bd71815-32k-out";
> +		#clock-cells = <0>;
> +		#gpio-cells = <1>;
> +
> +		regulators {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			buck1_reg: regulator@0 {
> +				reg = <0>;
> +				regulator-compatible = "buck1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck2_reg: regulator@1 {
> +				reg = <1>;
> +				regulator-compatible = "buck2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck3_reg: regulator@2 {
> +				reg = <2>;
> +				regulator-compatible = "buck3";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <2700000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4_reg: regulator@3 {
> +				reg = <3>;
> +				regulator-compatible = "buck4";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5_reg: regulator@4 {
> +				reg = <4>;
> +				regulator-compatible = "buck5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: regulator@5 {
> +				reg = <5>;
> +				regulator-compatible = "ldo1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: regulator@6 {
> +				reg = <6>;
> +				regulator-compatible = "ldo2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: regulator@7 {
> +				reg = <7>;
> +				regulator-compatible = "ldo3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: regulator@8 {
> +				reg = <8>;
> +				regulator-compatible = "ldo4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5_reg: regulator@9 {
> +				reg = <9>;
> +				regulator-compatible = "ldo5";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			dvref_reg: regulator@a {
> +				reg = <0xa>;
> +				regulator-compatible = "dvref";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			lpsr_reg: regulator@b {
> +				reg = <0xb>;
> +				regulator-compatible = "lpsr";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			wled_reg: regulator@c {
> +				reg = <0xc>;
> +				regulator-compatible = "wled";
> +				regulator-min-microamp = <10>;
> +				regulator-max-microamp = <25000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};

Note: You have marked all regulators as always on, this is rather
suboptimal due to power consumption.

Regards,
  Marco

> +		};
> +	};
> +};
> +
>  &i2c3 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -293,6 +439,12 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
>  };
>  
>  &iomuxc {
> +	pinctrl_bd71815: bd71815grp {
> +		fsl,pins = <
> +			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x59
> +		>;
> +	};
> +
>  	pinctrl_brcm_reg: brcmreggrp {
>  		fsl,pins = <
>  			/* WIFI_PWR_EN */
> @@ -323,6 +475,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
> +			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
> +		>;
> +	};
> +
>  	pinctrl_i2c3: i2c3grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
> -- 
> 2.38.1
> 
> 
> 
