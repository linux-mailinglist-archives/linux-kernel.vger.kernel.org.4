Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39961ECAA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKGIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKGIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:12:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74513F83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:12:49 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1orxFF-0001A8-2j; Mon, 07 Nov 2022 09:12:37 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1orxFC-0001MF-5O; Mon, 07 Nov 2022 09:12:34 +0100
Date:   Mon, 7 Nov 2022 09:12:34 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v2] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221107081234.wxup6lq3xph2obfv@pengutronix.de>
References: <20221104204251.1458958-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104204251.1458958-1-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 22-11-04, Andreas Kemnade wrote:
> Add the touchscreen now, since the driver is available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2: fix pinmux naming
> 
>  arch/arm/boot/dts/e60k02.dtsi              | 11 ++++++++++-
>  arch/arm/boot/dts/imx6sl-tolino-shine3.dts |  7 +++++++
>  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts |  7 +++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
> index 935e2359f8df..94944cc21931 100644
> --- a/arch/arm/boot/dts/e60k02.dtsi
> +++ b/arch/arm/boot/dts/e60k02.dtsi
> @@ -104,7 +104,16 @@ &i2c2 {
>  	clock-frequency = <100000>;
>  	status = "okay";
>  
> -	/* TODO: CYTTSP5 touch controller at 0x24 */
> +	touchscreen@24 {
> +		compatible = "cypress,tt21000";
> +		reg = <0x24>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_cyttsp5_gpio>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&ldo5_reg>;
> +	};
>  
>  	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
>  
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> index e3f1e8d79528..db5d8509935f 100644
> --- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> @@ -52,6 +52,13 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> +	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x17059 /* TP_INT */
> +			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
> +		>;
> +	};

Hm.. I don't like that you enable it within the base dtsi and add the
missing dependencies here. I would rather add the touchscreen within the
base dtsi but with with status set to disabled and without specifying
the interrupt and reset gpio. Within the dts and the below you can
reference the touchscreen via phandle and add the missing properties.

Regards,
  Marco

> +
>  	pinctrl_gpio_keys: gpio-keysgrp {
>  		fsl,pins = <
>  			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* PWR_SW */
> diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> index 90b32f5eb529..c7cfe0b70f04 100644
> --- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> +++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> @@ -62,6 +62,13 @@ &iomuxc {
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
