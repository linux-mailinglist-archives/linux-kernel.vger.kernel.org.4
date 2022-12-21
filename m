Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527EA65329E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLUOpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiLUOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:45:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972B1103
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 06:45:44 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p80Le-0000R1-QQ; Wed, 21 Dec 2022 15:45:34 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p80Le-00017C-6X; Wed, 21 Dec 2022 15:45:34 +0100
Date:   Wed, 21 Dec 2022 15:45:34 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        aford@beaconembedded.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable spba-bus on AIPS3
Message-ID: <20221221144534.dnkcvgpypml5u3y7@pengutronix.de>
References: <20221218170545.1472746-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218170545.1472746-1-aford173@gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 22-12-18, Adam Ford wrote:
> There is an SPBA bus on AIPS3 which includes ecspi1-3,
> UART1-3, and Flexcan1-2 according to the TRM.

LGTM

> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 2ce45e7cbbdf..9b0a47e7b8fd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -719,121 +719,129 @@ aips3: bus@30800000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> -			ecspi1: spi@30820000 {
> +			spba-bus@30800000 {
> +				compatible = "fsl,spba-bus", "simple-bus";
> +				reg = <0x30800000 0x100000>;
>  				#address-cells = <1>;
> -				#size-cells = <0>;
> -				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> -				reg = <0x30820000 0x10000>;
> -				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_ECSPI1_ROOT>,
> -					 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
> -				clock-names = "ipg", "per";
> -				assigned-clock-rates = <80000000>;
> -				assigned-clocks = <&clk IMX8MP_CLK_ECSPI1>;
> -				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
> -				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				#size-cells = <1>;
> +				ranges;
>  
> -			ecspi2: spi@30830000 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> -				reg = <0x30830000 0x10000>;
> -				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_ECSPI2_ROOT>,
> -					 <&clk IMX8MP_CLK_ECSPI2_ROOT>;
> -				clock-names = "ipg", "per";
> -				assigned-clock-rates = <80000000>;
> -				assigned-clocks = <&clk IMX8MP_CLK_ECSPI2>;
> -				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
> -				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				ecspi1: spi@30820000 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> +					reg = <0x30820000 0x10000>;
> +					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_ECSPI1_ROOT>,
> +						 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
> +					clock-names = "ipg", "per";
> +					assigned-clock-rates = <80000000>;
> +					assigned-clocks = <&clk IMX8MP_CLK_ECSPI1>;
> +					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
> +					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			ecspi3: spi@30840000 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> -				reg = <0x30840000 0x10000>;
> -				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_ECSPI3_ROOT>,
> -					 <&clk IMX8MP_CLK_ECSPI3_ROOT>;
> -				clock-names = "ipg", "per";
> -				assigned-clock-rates = <80000000>;
> -				assigned-clocks = <&clk IMX8MP_CLK_ECSPI3>;
> -				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
> -				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				ecspi2: spi@30830000 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> +					reg = <0x30830000 0x10000>;
> +					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_ECSPI2_ROOT>,
> +						 <&clk IMX8MP_CLK_ECSPI2_ROOT>;
> +					clock-names = "ipg", "per";
> +					assigned-clock-rates = <80000000>;
> +					assigned-clocks = <&clk IMX8MP_CLK_ECSPI2>;
> +					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
> +					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			uart1: serial@30860000 {
> -				compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
> -				reg = <0x30860000 0x10000>;
> -				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_UART1_ROOT>,
> -					 <&clk IMX8MP_CLK_UART1_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				ecspi3: spi@30840000 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
> +					reg = <0x30840000 0x10000>;
> +					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_ECSPI3_ROOT>,
> +						 <&clk IMX8MP_CLK_ECSPI3_ROOT>;
> +					clock-names = "ipg", "per";
> +					assigned-clock-rates = <80000000>;
> +					assigned-clocks = <&clk IMX8MP_CLK_ECSPI3>;
> +					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
> +					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			uart3: serial@30880000 {
> -				compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
> -				reg = <0x30880000 0x10000>;
> -				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_UART3_ROOT>,
> -					 <&clk IMX8MP_CLK_UART3_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				uart1: serial@30860000 {
> +					compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
> +					reg = <0x30860000 0x10000>;
> +					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_UART1_ROOT>,
> +						 <&clk IMX8MP_CLK_UART1_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			uart2: serial@30890000 {
> -				compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
> -				reg = <0x30890000 0x10000>;
> -				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_UART2_ROOT>,
> -					 <&clk IMX8MP_CLK_UART2_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				uart3: serial@30880000 {
> +					compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
> +					reg = <0x30880000 0x10000>;
> +					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_UART3_ROOT>,
> +						 <&clk IMX8MP_CLK_UART3_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			flexcan1: can@308c0000 {
> -				compatible = "fsl,imx8mp-flexcan";
> -				reg = <0x308c0000 0x10000>;
> -				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> -					 <&clk IMX8MP_CLK_CAN1_ROOT>;
> -				clock-names = "ipg", "per";
> -				assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
> -				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> -				assigned-clock-rates = <40000000>;
> -				fsl,clk-source = /bits/ 8 <0>;
> -				fsl,stop-mode = <&gpr 0x10 4>;
> -				status = "disabled";
> -			};
> +				uart2: serial@30890000 {
> +					compatible = "fsl,imx8mp-uart", "fsl,imx6q-uart";
> +					reg = <0x30890000 0x10000>;
> +					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_UART2_ROOT>,
> +						 <&clk IMX8MP_CLK_UART2_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			flexcan2: can@308d0000 {
> -				compatible = "fsl,imx8mp-flexcan";
> -				reg = <0x308d0000 0x10000>;
> -				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> -					 <&clk IMX8MP_CLK_CAN2_ROOT>;
> -				clock-names = "ipg", "per";
> -				assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
> -				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> -				assigned-clock-rates = <40000000>;
> -				fsl,clk-source = /bits/ 8 <0>;
> -				fsl,stop-mode = <&gpr 0x10 5>;
> -				status = "disabled";
> +				flexcan1: can@308c0000 {
> +					compatible = "fsl,imx8mp-flexcan";
> +					reg = <0x308c0000 0x10000>;
> +					interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> +						 <&clk IMX8MP_CLK_CAN1_ROOT>;
> +					clock-names = "ipg", "per";
> +					assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
> +					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> +					assigned-clock-rates = <40000000>;
> +					fsl,clk-source = /bits/ 8 <0>;
> +					fsl,stop-mode = <&gpr 0x10 4>;
> +					status = "disabled";
> +				};
> +
> +				flexcan2: can@308d0000 {
> +					compatible = "fsl,imx8mp-flexcan";
> +					reg = <0x308d0000 0x10000>;
> +					interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> +						 <&clk IMX8MP_CLK_CAN2_ROOT>;
> +					clock-names = "ipg", "per";
> +					assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
> +					assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> +					assigned-clock-rates = <40000000>;
> +					fsl,clk-source = /bits/ 8 <0>;
> +					fsl,stop-mode = <&gpr 0x10 5>;
> +					status = "disabled";
> +				};
>  			};
>  
>  			crypto: crypto@30900000 {
> -- 
> 2.34.1
> 
> 
> 
