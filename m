Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAA6F8074
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjEEJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjEEJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:58:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CBD918852;
        Fri,  5 May 2023 02:58:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0051FB;
        Fri,  5 May 2023 02:58:57 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BCAE3F64C;
        Fri,  5 May 2023 02:58:11 -0700 (PDT)
Date:   Fri, 5 May 2023 10:58:05 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add SPI0 controller node
Message-ID: <20230505105805.548d1a1b@donnerap.cambridge.arm.com>
In-Reply-To: <20230505074701.1030980-1-bigunclemax@gmail.com>
References: <20230505074701.1030980-1-bigunclemax@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 May 2023 10:46:51 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maksim,

thanks for sending a patch!

> Some boards form the MangoPi family (MQ\MQ-Dual\MQ-R) may have
> an optional SPI flash that connects to the SPI0 controller.
> This controller is already supported by sun8i-h3-spi driver.
> So let's add its DT node.

Interesting, I see SPI mentioned in the D1 platform support cover letter,
but indeed there is no DT node. From a quick glance at the manuals, it
looks like there are not quite the same, though: the D1/R528/T113s
mentions a SPI_SAMP_DL register @0x28, whereas the older IP has a SPI_CCR
register @0x24 - which is not mentioned in the newer manuals. The driver
relies on that clock control register, so it wouldn't really work
reliably, if that register is not there. It *might* work by pure chance
because of a particular setup or clock rate, though.

Samuel, did you investigate SPI support on the D1/T113s? I see it marked
as "WIP" in the Wiki status page, so where there any patches floating
around?


Regardless of that, one comment that would apply anyway:

> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index 922e8e0e2c09..d2de211d67d7 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -108,6 +108,12 @@ rmii_pe_pins: rmii-pe-pins {
>  				function = "emac";
>  			};
>  
> +			/omit-if-no-ref/
> +			spi0_pins: spi0-pins {
> +				pins = "PC2", "PC3", "PC4", "PC5";
> +				function = "spi0";
> +			};
> +
>  			/omit-if-no-ref/
>  			uart1_pg6_pins: uart1-pg6-pins {
>  				pins = "PG6", "PG7";
> @@ -447,6 +453,20 @@ mmc2: mmc@4022000 {
>  			#size-cells = <0>;
>  		};
>  
> +		spi0: spi@4025000 {
> +			compatible = "allwinner,sun8i-h3-spi";

Even if it would be compatible, we need to use a more specific compatible
first, with the H3 one as a fallback:

			compatible = "allwinner,sun20i-d1-spi",
				     "allwinner,sun8i-h3-spi";

But that would require that the H3 is a strict subset of the D1 SPI IP.

Cheers,
Andre


> +			reg = <0x04025000 0x300>;
> +			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +			clock-names = "ahb", "mod";
> +			dmas = <&dma 22>, <&dma 22>;
> +			dma-names = "rx", "tx";
> +			resets = <&ccu RST_BUS_SPI0>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		usb_otg: usb@4100000 {
>  			compatible = "allwinner,sun20i-d1-musb",
>  				     "allwinner,sun8i-a33-musb";

