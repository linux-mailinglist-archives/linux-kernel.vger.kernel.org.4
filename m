Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DC629550
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiKOKI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiKOKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:08:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D524BFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:08:08 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ousrN-0002UD-TS; Tue, 15 Nov 2022 11:08:05 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ousrN-0007Ai-Hd; Tue, 15 Nov 2022 11:08:05 +0100
Date:   Tue, 15 Nov 2022 11:08:05 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 10/12] arm64: dts: imx8mn-evk: enable uart1
Message-ID: <20221115100805.lusj3iwbvo72tac6@pengutronix.de>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
 <20221115091709.2865997-11-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115091709.2865997-11-peng.fan@oss.nxp.com>
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

On 22-11-15, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable uart1 for BT usage
> Configure the clock to source from IMX8MN_SYS_PLL1_80M, because the uart
> could only support max 1.5M buadrate if using OSC_24M as clock source.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 1971f095e4c2..12dc5d398a03 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -247,6 +247,15 @@ &spdif1 {
>  	status = "okay";
>  };
>  
> +&uart1 { /* BT */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
>  &uart2 { /* console */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
> @@ -440,6 +449,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
>  		>;
>  	};
>  
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
> +			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
> +			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
> +			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> -- 
> 2.37.1
> 
> 
> 
