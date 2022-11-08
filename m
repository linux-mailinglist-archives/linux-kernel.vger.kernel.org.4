Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE066620BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiKHJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiKHJG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:06:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF21DA5A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:06:56 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1osKZD-0004wI-4U; Tue, 08 Nov 2022 10:06:47 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1osKZC-0001Jg-6J; Tue, 08 Nov 2022 10:06:46 +0100
Date:   Tue, 8 Nov 2022 10:06:46 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        Sherry Sun <sherry.sun@nxp.com>, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
 support wifi
Message-ID: <20221108090646.n4qbhouc7vxtwir5@pengutronix.de>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
 <20221108021820.1854971-13-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108021820.1854971-13-peng.fan@oss.nxp.com>
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

On 22-11-08, Peng Fan (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Enable usdhc1 which is used for wifi.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 23 +++++++++++
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 39 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index a2b24d4d4e3e..898735965ac9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -15,6 +15,17 @@ / {
>  	aliases {
>  		spi0 = &flexspi;
>  	};
> +
> +	reg_sd1_vmmc: sd1_regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "WLAN_EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <20000>;
> +		startup-delay-us = <100>;
> +		enable-active-high;
> +	};

This is a bit inconsistent with the imx8mn-evk.dtsi where you used
mmc-pwrseq instead of vmmc-supply. Also Do you really need the delay
here?

Regards,
  Marco

>  };
>  
>  &ddrc {
> @@ -53,6 +64,18 @@ flash@0 {
>  	};
>  };
>  
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_sd1_vmmc>;
> +	keep-power-in-suspend;
> +	non-removable;
> +	status = "okay";
> +};
> +
>  &usdhc3 {
>  	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
>  	assigned-clock-rates = <400000000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 7d6317d95b13..ce450965e837 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -559,6 +559,45 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
>  		>;
>  	};
>  
> +	pinctrl_usdhc1_gpio: usdhc1grpgpio {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
> +		>;
> +	};
> +
>  	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
> -- 
> 2.37.1
> 
> 
> 
