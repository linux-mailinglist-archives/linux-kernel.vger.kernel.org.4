Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAE738685
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjFUOOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjFUONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:13:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECA5213E;
        Wed, 21 Jun 2023 07:13:12 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D7A2105;
        Wed, 21 Jun 2023 16:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687356755;
        bh=Q6gLfttyYNyv7Ic+tR22YEZY26euzVq7wKTAMWUvU0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0DIjYKo+0Osx2KQHLVhCXXDUegjqBJgOiv4hf304R3UPHjMjZ8nQ0wVZeyEXalxT
         gV0t0DaAq7dJd75bX46mprnyebvJybDFpD7pivybx4CdqGA8gOqKE8WqJfhccnfDo7
         k4TqFlenzwRU3GVLTqT13XMCeKvhVDMh9RflR/NM=
Date:   Wed, 21 Jun 2023 17:13:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: zynqmp: Fix dwc3 usb interrupt description
Message-ID: <20230621141307.GC18703@pendragon.ideasonboard.com>
References: <6544d13afd9f3d8f5413e32684aa16e4d155e331.1687160244.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6544d13afd9f3d8f5413e32684aa16e4d155e331.1687160244.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Mon, Jun 19, 2023 at 09:37:54AM +0200, Michal Simek wrote:
> Based on DT binding dwc_usb3 is single entry without anything else. That's
> why combination dwc3_usb3, otg is not allowed. That's why split it to host
> and peripheral pair which both points to the same IRQ.
> DWC3 code is reading these two properties first before generic dwc_usb3.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 02cfcc716936..e8104ffc6663 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -888,8 +888,8 @@ dwc3_0: usb@fe200000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x0 0xfe200000 0x0 0x40000>;
>  				interrupt-parent = <&gic>;
> -				interrupt-names = "dwc_usb3", "otg";
> -				interrupts = <0 65 4>, <0 69 4>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				interrupts = <0 65 4>, <0 65 4>, <0 69 4>;

This should read

				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;

The issue isn't introduced by this patch, so it should probably be fixed
by a separate patch on top, to convert the whole zynqmp.dtsi file. Do
you have any plan to do so, or should I ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  				clock-names = "bus_early", "ref";
>  				iommus = <&smmu 0x860>;
>  				snps,quirk-frame-length-adjustment = <0x20>;
> @@ -915,8 +915,8 @@ dwc3_1: usb@fe300000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x0 0xfe300000 0x0 0x40000>;
>  				interrupt-parent = <&gic>;
> -				interrupt-names = "dwc_usb3", "otg";
> -				interrupts = <0 70 4>, <0 74 4>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				interrupts = <0 70 4>, <0 70 4>, <0 74 4>;
>  				clock-names = "bus_early", "ref";
>  				iommus = <&smmu 0x861>;
>  				snps,quirk-frame-length-adjustment = <0x20>;

-- 
Regards,

Laurent Pinchart
