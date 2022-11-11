Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63C625624
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiKKJEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiKKJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:04:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33077E56
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:02:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1otPvl-0003xp-Pn; Fri, 11 Nov 2022 10:02:33 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1otPvk-00044O-Am; Fri, 11 Nov 2022 10:02:32 +0100
Date:   Fri, 11 Nov 2022 10:02:32 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Sherry Sun <sherry.sun@nxp.com>, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
 support wifi
Message-ID: <20221111090232.6ibqzoivfqsndhxg@pengutronix.de>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
 <20221111032811.2456916-13-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111032811.2456916-13-peng.fan@oss.nxp.com>
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

Hi Peng,

On 22-11-11, Peng Fan (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Enable usdhc1 which is used for wifi.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 27 +++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 39 +++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index a2b24d4d4e3e..7b80f144327d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -15,6 +15,13 @@ / {
>  	aliases {
>  		spi0 = &flexspi;
>  	};
> +
> +	usdhc1_pwrseq: usdhc1_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
> +		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &ddrc {
> @@ -53,6 +60,19 @@ flash@0 {
>  	};
>  };
>  
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
> +	bus-width = <4>;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&usdhc1_pwrseq>;
> +	non-removable;
> +	wakeup-source;
> +	status = "okay";
> +};
> +
>  &usdhc3 {
>  	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
>  	assigned-clock-rates = <400000000>;
> @@ -125,4 +145,11 @@ MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
>  			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
>  		>;
>  	};
> +
> +	pinctrl_wlan: wlangrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
> +			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9		0x159
> +		>;
> +	};

Out of curiousity, this is not shareable with the other ddr4 evk?

Regards,
  Marco

>  };
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
