Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50CE7134B6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjE0Mcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE0Mcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E141F3;
        Sat, 27 May 2023 05:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B530A60C70;
        Sat, 27 May 2023 12:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E4C433D2;
        Sat, 27 May 2023 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685190763;
        bh=k53h9mOVcjFm3tFTg03/p1aeDvR4fzTEE2ku4cPFeHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlsVX14e2T2IKMSZk8c+Iq/IVscFUPjlKZr1Il0NGAcTluQUcCYXaoeYbew9KHq1v
         X1IGzuG8NTBrGQC71K0+xHiH5/Uv8XBEhxkXWeRS/zx346Vxwfmi5XJaeDNgWAWnOZ
         giGsVscqG14Z5p95CG7VhctDflj8INqDMDZo63l4vuAHMrx/Ijaz9BlsULJIcZE2yz
         pcGU4k87eXTPECvZ4lwc/lExV9yByIU6fycFW0hJvmroSu00L10vOWjoR+pDyyzKeT
         K38U0E5KZnzZmTwlMNj8l9yp/XensfzQxIcXagf6Xu9bY8ydrXWulLZsHDu7mZQhUx
         da3R65XZ8V4BQ==
Date:   Sat, 27 May 2023 20:32:31 +0800
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
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn-beacon: Migrate sound card to
 simple-audio-card
Message-ID: <20230527123231.GS528183@dragon>
References: <20230521231055.167351-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521231055.167351-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 06:10:54PM -0500, Adam Ford wrote:
> Instead of using a custom glue layer connecting the wm8962 CODEC
> to the SAI3 sound-dai, migrate the sound card to simple-audio-card.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Can you double check both patches?  The changes do not seem to match
subject and commit log.

Shawn

> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index bd84db550053..8be8f090e8b8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -1069,13 +1069,6 @@ lcdif: lcdif@32e00000 {
>  					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
>  					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
>  				clock-names = "pix", "axi", "disp_axi";
> -				assigned-clocks = <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
> -						  <&clk IMX8MN_CLK_DISP_AXI>,
> -						  <&clk IMX8MN_CLK_DISP_APB>;
> -				assigned-clock-parents = <&clk IMX8MN_CLK_DISP_PIXEL>,
> -							 <&clk IMX8MN_SYS_PLL2_1000M>,
> -							 <&clk IMX8MN_SYS_PLL1_800M>;
> -				assigned-clock-rates = <594000000>, <500000000>, <200000000>;
>  				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_LCDIF>;
>  				status = "disabled";
> @@ -1093,12 +1086,6 @@ mipi_dsi: dsi@32e10000 {
>  				clocks = <&clk IMX8MN_CLK_DSI_CORE>,
>  					 <&clk IMX8MN_CLK_DSI_PHY_REF>;
>  				clock-names = "bus_clk", "sclk_mipi";
> -				assigned-clocks = <&clk IMX8MN_CLK_DSI_CORE>,
> -						  <&clk IMX8MN_CLK_DSI_PHY_REF>;
> -				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_266M>,
> -							 <&clk IMX8MN_CLK_24M>;
> -				assigned-clock-rates = <266000000>, <24000000>;
> -				samsung,pll-clock-frequency = <24000000>;
>  				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>  				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_DSI>;
>  				status = "disabled";
> @@ -1142,6 +1129,21 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
>  					      "lcdif-axi", "lcdif-apb", "lcdif-pix",
>  					      "dsi-pclk", "dsi-ref",
>  					      "csi-aclk", "csi-pclk";
> +				assigned-clocks = <&clk IMX8MN_CLK_DSI_CORE>,
> +						  <&clk IMX8MN_CLK_DSI_PHY_REF>,
> +						  <&clk IMX8MN_CLK_DISP_PIXEL>,
> +						  <&clk IMX8MN_CLK_DISP_AXI>,
> +						  <&clk IMX8MN_CLK_DISP_APB>;
> +				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_266M>,
> +							 <&clk IMX8MN_CLK_24M>,
> +							 <&clk IMX8MN_VIDEO_PLL1_OUT>,
> +							 <&clk IMX8MN_SYS_PLL2_1000M>,
> +							 <&clk IMX8MN_SYS_PLL1_800M>;
> +				assigned-clock-rates = <266000000>,
> +						       <24000000>,
> +						       <594000000>,
> +						       <500000000>,
> +						       <200000000>;
>  				#power-domain-cells = <1>;
>  			};
>  
> -- 
> 2.39.2
> 
