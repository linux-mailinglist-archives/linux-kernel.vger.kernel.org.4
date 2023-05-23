Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD370D89E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjEWJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjEWJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:13:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B1E4139;
        Tue, 23 May 2023 02:13:46 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q1O5K-0007MY-03; Tue, 23 May 2023 11:13:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B2B70C02E6; Tue, 23 May 2023 11:08:22 +0200 (CEST)
Date:   Tue, 23 May 2023 11:08:22 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        paul@crapouillou.net, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v1 3/3] mips: dts: ingenic: x1000: Add AIC device tree
 node
Message-ID: <20230523090822.GD9484@alpha.franken.de>
References: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
 <20230509124238.195191-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509124238.195191-3-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 01:42:38PM +0100, Aidan MacDonald wrote:
> Add a node for the on-board I2S audio controller.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 42e69664efd9..cc264cfff826 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -417,4 +417,22 @@ otg: usb@13500000 {
>  
>  		status = "disabled";
>  	};
> +
> +	aic: audio-controller@10020000 {
> +		compatible = "ingenic,x1000-i2s";
> +		reg = <0x10020000 0x38>;
> +
> +		#sound-dai-cells = <0>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <1>;
> +
> +		clocks = <&cgu X1000_CLK_AIC>,
> +			 <&cgu X1000_CLK_I2S>;
> +		clock-names = "aic", "i2s";
> +
> +		dmas = <&pdma X1000_DMA_I2S0_RX 0xffffffff>,
> +			   <&pdma X1000_DMA_I2S0_TX 0xffffffff>;
> +		dma-names = "rx", "tx";
> +	};
>  };
> -- 
> 2.39.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
