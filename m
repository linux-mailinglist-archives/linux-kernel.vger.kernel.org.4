Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296B86226D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKIJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKIJYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:24:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C119C22
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:24:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oshJI-00051Y-JP; Wed, 09 Nov 2022 10:23:52 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oshJG-0004y5-8A; Wed, 09 Nov 2022 10:23:50 +0100
Date:   Wed, 9 Nov 2022 10:23:50 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v3] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221109092350.2ke6sbgbcp3wpelc@pengutronix.de>
References: <20221108191543.1752080-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108191543.1752080-1-andreas@kemnade.info>
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

On 22-11-08, Andreas Kemnade wrote:
> Add the touchscreen now, since the driver is available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3: no phandles pointing from dtsi to dts

Thanks for this change...

> Changes in v2: fix pinmux naming
> 
>  arch/arm/boot/dts/e60k02.dtsi              |  9 ++++++++-
>  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 12 ++++++++++++
>  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 12 ++++++++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
> index 935e2359f8df..99091db3ab2a 100644
> --- a/arch/arm/boot/dts/e60k02.dtsi
> +++ b/arch/arm/boot/dts/e60k02.dtsi
> @@ -104,7 +104,14 @@ &i2c2 {
>  	clock-frequency = <100000>;
>  	status = "okay";
>  
> -	/* TODO: CYTTSP5 touch controller at 0x24 */
> +	cyttsp5: touchscreen@24 {
> +		compatible = "cypress,tt21000";
> +		reg = <0x24>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&ldo5_reg>;
> +	};

but we still have a cross-reference to the .dtsi file here. Therefore I
said to move the interrupt/reset-gpio into the dts file too. I know this
is a kind of a nitpick but I really don't like such cross-references.

Regards,
  Marco

>  
>  	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
>  
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> index e3f1e8d79528..e98dc302e2e3 100644
> --- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> @@ -26,6 +26,11 @@ / {
>  	compatible = "kobo,tolino-shine3", "fsl,imx6sl";
>  };
>  
> +&cyttsp5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
> +};
> +
>  &gpio_keys {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpio_keys>;
> @@ -52,6 +57,13 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> +	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x17059 /* TP_INT */
> +			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
> +		>;
> +	};
> +
>  	pinctrl_gpio_keys: gpio-keysgrp {
>  		fsl,pins = <
>  			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* PWR_SW */
> diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> index 90b32f5eb529..6bb80720ea66 100644
> --- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> +++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> @@ -36,6 +36,11 @@ &cpu0 {
>  	soc-supply = <&dcdc1_reg>;
>  };
>  
> +&cyttsp5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
> +};
> +
>  &gpio_keys {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpio_keys>;
> @@ -62,6 +67,13 @@ &iomuxc {
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
>  	pinctrl_gpio_keys: gpio-keysgrp {
>  		fsl,pins = <
>  			MX6SLL_PAD_SD1_DATA1__GPIO5_IO08	0x17059	/* PWR_SW */
> -- 
> 2.30.2
> 
> 
> 
