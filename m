Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7629160E6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiJZRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiJZRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:43:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A036097
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:43:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onkQf-0006QE-Pm; Wed, 26 Oct 2022 19:43:01 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onkQe-0006Do-6o; Wed, 26 Oct 2022 19:43:00 +0200
Date:   Wed, 26 Oct 2022 19:43:00 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] arm: dts: imx: e60k02: Add touchscreen
Message-ID: <20221026174300.6f5l6lsg5msrz6op@pengutronix.de>
References: <20221026173015.1172816-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026173015.1172816-1-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 22-10-26, Andreas Kemnade wrote:
> Add the touchscreen now, since the driver is available.

I pulled input/next and grep'ed for the compatible but found nothing.
Where should the driver be available?

Regards,
  Marco

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> runtime/dtbs_check depends
> https://lore.kernel.org/linux-devicetree/20221026114908.191472-1-alistair@alistair23.me/T/#t
>  arch/arm/boot/dts/e60k02.dtsi              | 12 +++++++++++-
>  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 14 ++++++++++++++
>  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 14 ++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
> index 935e2359f8df..4f36cc181a52 100644
> --- a/arch/arm/boot/dts/e60k02.dtsi
> +++ b/arch/arm/boot/dts/e60k02.dtsi
> @@ -104,7 +104,17 @@ &i2c2 {
>  	clock-frequency = <100000>;
>  	status = "okay";
>  
> -	/* TODO: CYTTSP5 touch controller at 0x24 */
> +	touchscreen@24 {
> +		compatible = "cypress,tt21000";
> +		reg = <0x24>;
> +		pinctrl-names = "default","sleep";

Does the driver handle the different states?

> +		pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
> +		pinctrl-1 = <&pinctrl_cyttsp5_gpio_sleep>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&ldo5_reg>;
> +	};
>  
>  	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
>  
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> index e3f1e8d79528..82d9ed91df92 100644
> --- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> @@ -52,6 +52,20 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> +	pinctrl_cyttsp5_gpio: cyttsp5_gpio_grp {

According the below code it should be:
   	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {

and..

> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x17059 /* TP_INT */
> +			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
> +		>;
> +	};
> +
> +	pinctrl_cyttsp5_gpio_sleep: cyttsp5_gpio_grp_sleep {


   	pinctrl_cyttsp5_gpio_sleep: cyttsp5-gpio-sleepgrp {


Regards,
  Marco

> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x10059 /* TP_INT */
> +			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
> +		>;
> +	};
> +
>  	pinctrl_gpio_keys: gpio-keysgrp {
>  		fsl,pins = <
>  			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* PWR_SW */
> diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> index 90b32f5eb529..d743bf4fd8e6 100644
> --- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> +++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> @@ -62,6 +62,20 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> +	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
> +		fsl,pins = <
> +			MX6SLL_PAD_SD1_DATA3__GPIO5_IO06                0x17059 /* TP_INT */
> +			MX6SLL_PAD_SD1_DATA2__GPIO5_IO13                0x10059 /* TP_RST */
> +		>;
> +	};
> +
> +	pinctrl_cyttsp5_gpio_sleep: cyttsp5-gpiogrp-sleep {
> +		fsl,pins = <
> +			MX6SLL_PAD_SD1_DATA3__GPIO5_IO06                0x10059 /* TP_INT */
> +			MX6SLL_PAD_SD1_DATA2__GPIO5_IO13                0x10059 /* TP_RST */
> +		>;
> +	};
> +
>  	pinctrl_gpio_keys: gpio-keysgrp {
>  		fsl,pins = <
>  			MX6SLL_PAD_SD1_DATA1__GPIO5_IO08	0x17059	/* PWR_SW */
> -- 
> 2.30.2
> 
> 
> 
