Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A59611577
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJ1PGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJ1PFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:05:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2921BC152
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:05:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQvb-0005o4-9u; Fri, 28 Oct 2022 17:05:47 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ooQva-0002bp-U5; Fri, 28 Oct 2022 17:05:46 +0200
Date:   Fri, 28 Oct 2022 17:05:46 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 12/15] arm64: dts: imx8mn-evk: enable usdhc1
Message-ID: <20221028150546.cavkbayw6jakd2d6@pengutronix.de>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-13-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024031351.4135651-13-peng.fan@oss.nxp.com>
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

On 22-10-24, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable usdhc1 for wlan usage, the wifi device node not included.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index f137eb406c24..50553359401f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -28,6 +28,13 @@ memory@40000000 {
>  		reg = <0x0 0x40000000 0 0x80000000>;
>  	};
>  
> +	usdhc1_pwrseq: usdhc1_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
> +		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -271,6 +278,22 @@ &uart3 {
>  	status = "okay";
>  };
>  
> +&usdhc1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Nit: it is rather uncommon, to place it on-top if you have more than
these two properties to add.

Regards,
  Marco

> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
> +	bus-width = <4>;
> +	keep-power-in-suspend;
> +	non-removable;
> +	wakeup-source;
> +	fsl,sdio-async-interrupt-enabled;
> +	mmc-pwrseq = <&usdhc1_pwrseq>;
> +	status = "okay";
> +};
> +
>  &usbotg1 {
>  	dr_mode = "otg";
>  	hnp-disable;
> @@ -474,6 +497,45 @@ MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x140
>  		>;
>  	};
>  
> +	pinctrl_usdhc1_gpio: usdhc1grpgpio {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
> +			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
> +			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
> +			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
> +			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
> +			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
> +			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
> +			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
> +			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
> +			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
> +			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
> +			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
> +			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
> +			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
> +			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
> +			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
> +		>;
> +	};
> +
>  	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
> @@ -569,4 +631,11 @@ pinctrl_wdog: wdoggrp {
>  			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
>  		>;
>  	};
> +
> +	pinctrl_wlan: wlangrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
> +			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9		0x159
> +		>;
> +	};
>  };
> -- 
> 2.37.1
> 
> 
> 
