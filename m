Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8837C701B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjENDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENDEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128052682;
        Sat, 13 May 2023 20:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E17560B21;
        Sun, 14 May 2023 03:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CCFC433D2;
        Sun, 14 May 2023 03:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684033448;
        bh=qBKHzMDQiTvfzVdcv7w2wZ86uejJYLs96FLiWxr9gDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pt5dlSh8KyrkRWFEyAPyVCZ0gHKN2C8eQizB3ypJRVNDduv0V5UupoBRXwCkiedFC
         wp20xHeXeb2BWTgqH3pCQ892jz6JxYyByskoaaZzSFL7ovYdPuW38zd9trBmYFta49
         UIEhaccS8ZoN6CxNwfah9RsSZjqt5QhXjbcss2nIk6bJxWSNpvhDCV/5m+TJzh2Vmc
         uUdxn3GY/YAhjjy6fNhXASFGq6ermoM1e6vBQNy3p1aIaXxq+QXTqM/EkAgr8zggxH
         dF0kiTXi+571Jy+Km1c929ZUesgAaAy7C+sE3+Hna6NxLUv4IJXag0jYJ5/bqXt/Js
         cT9OCCpe0fbOA==
Date:   Sun, 14 May 2023 11:03:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: colibri-imx8x: fix eval board pin
 configuration
Message-ID: <20230514030354.GJ727834@dragon>
References: <20230417173830.19401-1-andrejs.cainikovs@toradex.com>
 <20230417173830.19401-2-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417173830.19401-2-andrejs.cainikovs@toradex.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:38:27PM +0200, Andrejs Cainikovs wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Fix pinctrl groups to have SODIMM 75 only in one group.
> Remove configuration of the pin at SoM level because it is normally
> used as CSI_MCLK at camera interface connector.
> Without this fix it is not possible, without redefining iomuxc pinctrl,
> to use CSI_MCLK signal and leads to the following error messages:
> 
> imx8qxp-pinctrl scu:pinctrl: pin IMX8QXP_CSI_MCLK already requested
> imx8qxp-pinctrl scu:pinctrl: pin-147 (16-003c) status -22
> 
> Fixes: 4d2adf738169 ("arm64: dts: colibri-imx8x: Split pinctrl_hog1")
> 

Unneeded newline.  Fixes tag can just be part of Signed-off-by section.

Shawn

> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> index 7cad79102e1a..6f88c11f16e1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> @@ -365,7 +365,7 @@ &usdhc2 {
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
> -		    <&pinctrl_hog2>, <&pinctrl_lpspi2_cs2>;
> +		    <&pinctrl_lpspi2_cs2>;
>  
>  	/* On-module touch pen-down interrupt */
>  	pinctrl_ad7879_int: ad7879intgrp {
> @@ -499,8 +499,7 @@ pinctrl_hog0: hog0grp {
>  	};
>  
>  	pinctrl_hog1: hog1grp {
> -		fsl,pins = <IMX8QXP_CSI_MCLK_LSIO_GPIO3_IO01			0x20>,		/* SODIMM  75 */
> -			   <IMX8QXP_QSPI0A_SCLK_LSIO_GPIO3_IO16			0x20>;		/* SODIMM  93 */
> +		fsl,pins = <IMX8QXP_QSPI0A_SCLK_LSIO_GPIO3_IO16			0x20>;		/* SODIMM  93 */
>  	};
>  
>  	pinctrl_hog2: hog2grp {
> -- 
> 2.34.1
> 
