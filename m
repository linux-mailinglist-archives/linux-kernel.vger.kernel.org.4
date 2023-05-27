Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D407134F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjE0NWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0NWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ADAA9;
        Sat, 27 May 2023 06:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440CF6123A;
        Sat, 27 May 2023 13:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8233C433D2;
        Sat, 27 May 2023 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685193720;
        bh=PzjEt2/h0CjY0WOMNH3YjbhNNTjlWbDN5hX9cNubPHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0SwLySGnNOhn2Y0lSKqrlRuS9SHuObCdg6BxMAsdmJDay+GzGgObr42vXYvZ5r7v
         Oiklt2+Rhhm7oeLvlq+i1V4fHxrY59dXG56UQZDeEwKzBCeGcBREM8ep0MQjP8rmKm
         K9mtfGlH0ahDpWcBF4mC3w+ZZ3FhM39w52nwpszbMxMzDOD9ckYnizV2ydT7xG/jul
         vOMf9LckBOa9ieC1mq9bGO5aHavYhOlG1Xv2pNr0NSxvR+CJtl5Rq3YhO3oJRVj9Hi
         wsvo2a65OM3rnmO80XhRxfDU7w42XjZAzRWvfqfNEuIig+p4h6zUjDvjgt0xfCiQdi
         Wty34T0cfJU5Q==
Date:   Sat, 27 May 2023 21:21:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp-msc-sm2s: Add sound card
Message-ID: <20230527132149.GD560301@dragon>
References: <20230525104755.286282-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525104755.286282-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 12:47:55PM +0200, Luca Ceresoli wrote:
> The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
> NXP SGTL5000 audio codec connected to I2S-0 (sai2).
> 
> This requires to:
> 
>  * add the power supplies (always on)
>  * enable sai2 with pinmuxes
>  * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
>    IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v2:
> 
>  - switch to simple-audio-card
>  - fix typo in commit message
>  - no underscores in node names
>  - rename "sgtl5000-sound" node to "sound"
> ---
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> index 470ff8e31e32..cd651e1e3262 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -14,6 +14,67 @@ / {
>  	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
>  		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>  		     "fsl,imx8mp";
> +
> +	reg_vcc_3v3_audio: 3v3-audio-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3_AUD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_vcc_1v8_audio: 1v8-audio-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V8_AUD";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "sgtl5000-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&codec_dai>;
> +		simple-audio-card,bitclock-master = <&codec_dai>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		codec_dai: simple-audio-card,codec {
> +			sound-dai = <&sgtl5000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	sgtl5000: sgtl5000@a {

audio-codec for node name.

Shawn

> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +
> +		assigned-clocks = <&clk IMX8MP_CLK_CLKOUT1_SEL>;
> +		assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> +		assigned-clock-rates = <24000000>;
> +		clocks = <&clk IMX8MP_CLK_CLKOUT1>;
> +		clock-names = "mclk";
> +		#sound-dai-cells = <0>;
> +
> +		VDDA-supply  = <&reg_vcc_3v3_audio>;
> +		VDDD-supply  = <&reg_vcc_1v8_audio>;
> +		VDDIO-supply = <&reg_vcc_1v8_audio>;
> +	};
> +};
> +
> +/* I2S-0 = sai2 */
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <12288000>;
> +
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
>  };
>  
>  &flexcan1 {
> @@ -32,6 +93,15 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_smarc_gpio>;
>  
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC   0xd6
> +			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK    0xd6
> +			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0xd6
> +			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00 0xd6
> +		>;
> +	};
> +
>  	pinctrl_smarc_gpio: smarcgpiosgrp {
>  		fsl,pins =
>  			<MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x19>, /* GPIO0 */
> 
> base-commit: efdde75fee54667153a5fa236907b55452fddbfa
> -- 
> 2.34.1
> 
