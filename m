Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3F65215D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiLTNUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLTNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:20:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C86182
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:20:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7cXq-0004mg-2Q; Tue, 20 Dec 2022 14:20:34 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7cXp-000574-G1; Tue, 20 Dec 2022 14:20:33 +0100
Date:   Tue, 20 Dec 2022 14:20:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, linux@armlinux.org.uk, jernej.skrabec@gmail.com,
        kernel@pengutronix.de, alistair23@gmail.com, festevam@gmail.com
Subject: Re: [PATCH v2 1/3] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Message-ID: <20221220132033.s5idqrol5kqxjasy@pengutronix.de>
References: <20221220112927.440506-1-alistair@alistair23.me>
 <20221220112927.440506-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220112927.440506-2-alistair@alistair23.me>
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
> Add support for the cyttsp5 touchscreen controller for the reMarkable 2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 98 +++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 8b2f11e85e05..a138b292ec6a 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>  
>  #include "imx7d.dtsi"
> +#include <dt-bindings/input/linux-event-codes.h>
>  
>  / {
>  	model = "reMarkable 2.0";
> @@ -69,6 +70,18 @@ reg_digitizer: regulator-digitizer {
>  		startup-delay-us = <100000>; /* 100 ms */
>  	};
>  
> +	reg_touch: regulator-touch {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_3V3_TOUCH";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pinctrl_touch_reg>;
> +		pinctrl-1 = <&pinctrl_touch_reg>;

Why do we need a "sleep" state here?

> +		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
> @@ -106,6 +119,68 @@ wacom_digitizer: digitizer@9 {
>  	};
>  };
>  
> +&i2c3 {
> +	clock-frequency = <100000>;

This can be set to 400kHz, the driver handle the quirks internal.

Regards,
  Marco

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	touchscreen@24 {
> +		compatible = "cypress,tt21000";
> +		reg = <0x24>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touch>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&reg_touch>;
> +		touchscreen-size-x = <880>;
> +		touchscreen-size-y = <1280>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		button@0 {
> +			reg = <0>;
> +			linux,keycodes = <KEY_HOMEPAGE>;
> +		};
> +
> +		button@1 {
> +			reg = <1>;
> +			linux,keycodes = <KEY_MENU>;
> +		};
> +
> +		button@2 {
> +			reg = <2>;
> +			linux,keycodes = <KEY_BACK>;
> +		};
> +
> +		button@3 {
> +			reg = <3>;
> +			linux,keycodes = <KEY_SEARCH>;
> +		};
> +
> +		button@4 {
> +			reg = <4>;
> +			linux,keycodes = <KEY_VOLUMEDOWN>;
> +		};
> +
> +		button@5 {
> +			reg = <5>;
> +			linux,keycodes = <KEY_VOLUMEUP>;
> +		};
> +
> +		button@6 {
> +			reg = <6>;
> +			linux,keycodes = <KEY_CAMERA>;
> +		};
> +
> +		button@7 {
> +			reg = <7>;
> +			linux,keycodes = <KEY_POWER>;
> +		};
> +	};
> +};
> +
>  &i2c4 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default", "sleep";
> @@ -232,6 +307,15 @@ MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x00000014
>  		>;
>  	};
>  
> +	pinctrl_touch: touchgrp {
> +		fsl,pins = <
> +			/* CYTTSP interrupt */
> +			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x54
> +			/* CYTTSP reset */
> +			MX7D_PAD_GPIO1_IO13__GPIO1_IO13		0x04
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> @@ -239,6 +323,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
> +			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
> +		>;
> +	};
> +
>  	pinctrl_i2c4: i2c4grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
> @@ -246,6 +337,13 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_touch_reg: touchreggrp {
> +		fsl,pins = <
> +			/* TOUCH_PWR_EN */
> +			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x14
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> -- 
> 2.38.1
> 
> 
> 
