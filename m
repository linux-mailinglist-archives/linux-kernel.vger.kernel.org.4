Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A169FA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBVR75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:59:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D23BDB8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:59:54 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pUtP6-0002FR-9U; Wed, 22 Feb 2023 18:59:44 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pUtP4-0002T7-0d; Wed, 22 Feb 2023 18:59:42 +0100
Date:   Wed, 22 Feb 2023 18:59:41 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
Message-ID: <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
References: <20230222182252.2ad6d82b@booty>
 <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
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

Hi Luca,

On 23-02-22, Luca Ceresoli wrote:
> The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
> NXPP SGTL5000 audio codec connected to I2S-0 (sai2).
> 
> This requires to:
> 
>  * add the power supplies (always on)
>  * enable sai2 with pinmuxes
>  * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
>    IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> index 470ff8e31e32..894d9809f76d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -14,6 +14,57 @@ / {
>  	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
>  		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>  		     "fsl,imx8mp";

...

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

Do you have some downstream patches for the sai interfaces? AFAIR Marek
worked on this but the patches are not mainlien yet.

Regards,
  Marco
