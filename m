Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF25BACF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiIPMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiIPMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE25AFAD0;
        Fri, 16 Sep 2022 05:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4163B82681;
        Fri, 16 Sep 2022 12:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A424CC433C1;
        Fri, 16 Sep 2022 12:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330068;
        bh=WC4VvAJYYKJVw/vMeKdu4prcV6pqAqVXKadEN3iBG5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4U68EZj8EG/aSWZ0SAu2e+83+OzL0scCS7LtKbtD4tf+gGwy3q1KOYjsJc0e0VEC
         4dnxzJHkENXX7fZqfQbJzm9yUejXC+VLYknZW0gDID8oDWnFMR2zOyQ1HCBEjc8ldH
         QrHgd9/ghCevCGE/53fAnNyr2cudhjTzoR5h3e2Ax6zpoA54xTevSg50YdqgpY3MRi
         czxvvVYUGQF0USg0tI5Jn65zW2TqcpaNzPtm1S6gKz4vqInUu+k+/VvEhioON/CD5O
         qVCbXvH/vyoIxKBZHBrwiAZ2NSiVc43l0C6qw2ENPCCprDG+jzPvTCGZJaJxrllyM3
         bankcFNHLfxTA==
Date:   Fri, 16 Sep 2022 20:07:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw52xx: add CAN regulator
Message-ID: <20220916120742.GN1728671@dragon>
References: <20220912215312.964722-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912215312.964722-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:53:12PM -0700, Tim Harvey wrote:
> The GW52xx has a tranceiver with a STBY pin connected to an IMX6 GPIO.
> Configure this as a regulator to drive it low when CAN is in use.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index b1df2beb2832..ec6b55bf77d9 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -137,6 +137,16 @@ reg_5p0v: regulator-5p0v {
>  		regulator-always-on;
>  	};
>  
> +	reg_can1_stby: regulator-can1-stby {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_can1>;
> +		compatible = "regulator-fixed";

Can we have properties start with 'compatible' just like other nodes?

Shawn

> +		regulator-name = "can1_stby";
> +		gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
>  	reg_usb_otg_vbus: regulator-usb-otg-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "usb_otg_vbus";
> @@ -170,6 +180,7 @@ &audmux {
>  &can1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can1_stby>;
>  	status = "okay";
>  };
>  
> @@ -612,7 +623,6 @@ pinctrl_flexcan1: flexcan1grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
>  			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
> -			MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x4001b0b0 /* CAN_STBY */
>  		>;
>  	};
>  
> @@ -702,6 +712,12 @@ MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
>  		>;
>  	};
>  
> +	pinctrl_reg_can1: regcan1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x4001b0b0 /* CAN_STBY */
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
> -- 
> 2.25.1
> 
