Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4964FF33
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLRPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:00:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A1D71;
        Sun, 18 Dec 2022 07:00:36 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3A0A825;
        Sun, 18 Dec 2022 16:00:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671375634;
        bh=kKRrKB/nJyp0eDTeiuSFhpxZVfNJx1NwPZwHj85dT18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AllE6tS/wunTMQ4N29E0QV/VcJcZqGZy1A2ZGb+XOLYaSdYbXNuxqIhBNuOqeVnDo
         3Y/rVf1JbQKJKIHmws4Z39JMkD/B6GcNK0XsvSfRfePQIZBi0O9bFTzycrUyjl7vHd
         gU9B0xCZ43Wyyuov0i5arXqq3wU9Om/Kiiq2dL5g=
Date:   Sun, 18 Dec 2022 17:00:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Fix missing GPC Interrupt
Message-ID: <Y58rDppqQEI+vZ5U@pendragon.ideasonboard.com>
References: <20221217180849.775718-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221217180849.775718-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for the patch.

On Sat, Dec 17, 2022 at 12:08:48PM -0600, Adam Ford wrote:
> The GPC node references an interrupt parent, but it doesn't
> state the interrupt itself.  According to the TRM, this IRQ
> is 87. This also eliminate an error detected from dt_binding_check

The interrupt isn't used by the driver as far as I can see, so I can't
test this, but the patch matches the reference manual, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Fixes: fc0f05124621 ("arm64: dts: imx8mp: add GPC node with GPU power domains")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 7a6e6221f421..7a8ca56e48b6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -524,6 +524,7 @@ gpc: gpc@303a0000 {
>  				compatible = "fsl,imx8mp-gpc";
>  				reg = <0x303a0000 0x1000>;
>  				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-controller;
>  				#interrupt-cells = <3>;
>  

-- 
Regards,

Laurent Pinchart
