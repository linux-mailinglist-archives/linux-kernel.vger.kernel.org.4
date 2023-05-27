Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56E07134B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjE0M2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE0M2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A296F3;
        Sat, 27 May 2023 05:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F18460C1B;
        Sat, 27 May 2023 12:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DACC433D2;
        Sat, 27 May 2023 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685190510;
        bh=1iMnQe4ZeKEJMWC5skppQHzR97BKQlp3LeIvmwoswQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdFBxippZT2hxK1NKSkVGdw9Ndco1MYWBGfWsAu2B4rWIZR6CVrM+vQh2mWEzttsD
         nx9DmRz7RRgpqflMekaqmASx/H/C8ULtbakpnBEH4FG2z3DyY+41eubKhPzMYiZBLf
         6H+V7nTNrBiQFSqSAlZIeKfGvo7p58BFdsTv3cn3iv+lJbkMa5cS7j6TEHaXm0M7lG
         wRRPKHoZoJHQrypIlXA0kXSExbyhW/Hfmp9VhwTjBMZk8o6agxgdw8qTCoVToL8TTo
         DYS1rIF/xWGtCQ549YamNPkDtIqf/+XXGfvmw0n8uPvPv1gXdeegqhT2YdwlwqJIXI
         NobRXP0UGEFBg==
Date:   Sat, 27 May 2023 20:28:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio CODEC
Message-ID: <20230527122819.GR528183@dragon>
References: <20230521230902.167280-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521230902.167280-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 06:09:02PM -0500, Adam Ford wrote:
> The baseboard has an WM8962 Audio CODEC connected to the SAI3
> peripheral.  The CODEC supports stereo in and out
> and a microphone input connected to the headphone jack.
> Route this CODEC through the simple-audio-card driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index cdae45a48c2c..3480fb522230 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -118,6 +118,15 @@ pcie0_refclk: clock-pcie {
>  		clock-frequency = <100000000>;
>  	};
>  
> +	reg_audio: regulator-wm8962 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3_aud";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VSD_3V3";
> @@ -137,6 +146,30 @@ reg_usb1_host_vbus: regulator-usb1-vbus {
>  		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	sound-wm8962 {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm8962";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets = "Headphone", "Headphones",
> +					    "Microphone", "Headset Mic",
> +					    "Speaker", "Speaker";
> +		simple-audio-card,routing = "Headphones", "HPOUTL",
> +					    "Headphones", "HPOUTR",
> +					    "Speaker", "SPKOUTL",
> +					    "Speaker", "SPKOUTR",
> +					    "Headset Mic", "MICBIAS",
> +					    "IN3R", "Headset Mic";

Have a newline between property list and child node.

> +		simple-audio-card,cpu {
> +			sound-dai = <&sai3>;
> +		};

Have a newline between nodes.

Shawn

> +		simple-audio-card,codec {
> +			sound-dai = <&wm8962>;
> +			clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +	};
>  };
>  
>  &ecspi2 {
> @@ -239,6 +272,34 @@ &i2c4 {
>  	clock-frequency = <384000>;
>  	status = "okay";
>  
> +	wm8962: audio-codec@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wm8962>;
> +		clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> +		assigned-clocks = <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> +		assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +		assigned-clock-rates = <22576000>;
> +		DCVDD-supply = <&reg_audio>;
> +		DBVDD-supply = <&reg_audio>;
> +		AVDD-supply = <&reg_audio>;
> +		CPVDD-supply = <&reg_audio>;
> +		MICVDD-supply = <&reg_audio>;
> +		PLLVDD-supply = <&reg_audio>;
> +		SPKVDD1-supply = <&reg_audio>;
> +		SPKVDD2-supply = <&reg_audio>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +		#sound-dai-cells = <0>;
> +	};
> +
>  	pca6416: gpio@20 {
>  		compatible = "nxp,pcal6416";
>  		reg = <0x20>;
> @@ -315,6 +376,16 @@ &pcie_phy {
>  	status = "okay";
>  };
>  
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +	assigned-clock-rates = <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -477,6 +548,16 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
>  		>;
>  	};
>  
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
> +			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
> +			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
> +			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
> +			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
> +		>;
> +	};
> +
>  	pinctrl_tpm: tpmgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19 /* Reset */
> @@ -547,4 +628,10 @@ pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
>  		>;
>  	};
> +
> +	pinctrl_wm8962: wm8962grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1	0x59
> +		>;
> +	};
>  };
> -- 
> 2.39.2
> 
