Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63A605E82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJTLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJTLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:12:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75561D63B0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:12:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTTc-0005sK-KM; Thu, 20 Oct 2022 13:12:40 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTTb-00048X-Ud; Thu, 20 Oct 2022 13:12:39 +0200
Date:   Thu, 20 Oct 2022 13:12:39 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, Han Xu <han.xu@nxp.com>,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/15] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp
 evk
Message-ID: <20221020111239.vunok2je26tl2nko@pengutronix.de>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020095934.1659449-7-peng.fan@oss.nxp.com>
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

Hi Peng,

On 22-10-20, Peng Fan (OSS) wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> enable fspi nor on imx8mp evk dts
> 
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 366f709f8790..f36033b9cebb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -85,6 +85,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  	};
>  };
>  
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +	status = "okay";
> +
> +	flash0: mt25qu256aba@0 {
                     ^
This should throw a warning. You need to name it flash@0.
Nit: The phandle name is not very useful, instead I would name it
nor_flash or so.

> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";

compatible is the first property followed by the reg.

> +		spi-max-frequency = <80000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
>  &A53_0 {
>  	cpu-supply = <&reg_arm>;
>  };
> @@ -585,6 +601,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
>  		>;
>  	};
>  
> +	pinctrl_flexspi0: flexspi0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
> +			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
> +			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
> +			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
> +			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
> +			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
> +		>;
> +	};
> +
>  	pinctrl_gpio_led: gpioledgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
> -- 
> 2.37.1
> 
> 
> 
