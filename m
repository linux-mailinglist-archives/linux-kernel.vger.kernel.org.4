Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8307363EC8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiLAJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLAJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:31:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747F880F6;
        Thu,  1 Dec 2022 01:31:47 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42E176602AC1;
        Thu,  1 Dec 2022 09:31:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669887103;
        bh=D7I5+RS4sfjfylRTQ21IejiMBeD86qi+gjwBXVqgI/I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S6VK4D3YY9dod7+SUYRC0d/qqTnYK91XRDgclgfBFlzvW811p7iGakDubCo6O6HnQ
         TegGow5zu5+dKubdcC3PGhSA+oHtUB7+oSmVP1UvOwoEBmlqOXIdB62wmV+X64Bkf0
         uM6T5HNL7FKgrnGRHHXXv1PsEd8Yio+sRTFPcGcfwcSU6lrzVPCeArbQvGduA0il1H
         ezgzJDBxDU0qdd3Cc8Mqfo2zuVhtqlUdLieniD2sfNwrtGXXkkibdANMDTOREQtsE3
         tiSnEQTbmL4yT0gPtCkxMN74VG8x3stzg7oYNEZnbNmydF4FKdCpcNNiU5l0tYKxRf
         qBE4438sIpDBg==
Message-ID: <5250d7d3-ff46-e08d-926c-4efd92390d88@collabora.com>
Date:   Thu, 1 Dec 2022 10:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183: Fix systimer 13 MHz
 clock description
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20221201084229.3464449-1-wenst@chromium.org>
 <20221201084229.3464449-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221201084229.3464449-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/22 09:42, Chen-Yu Tsai ha scritto:
> The systimer block derives its 13 MHz clock by dividing the main 26 MHz
> oscillator clock by 2 internally, not through the TOPCKGEN clock
> controller.
> 
> On the MT8183 this divider is set either by power-on-reset or by the
> bootloader. The bootloader may then make the divider unconfigurable to,
> but can be read out by, the operating system.
> 
> Making the systimer block take the 26 MHz clock directly requires
> changing the implementations. As an ABI compatible fix, change the
> input clock of the systimer block a fixed factor divide-by-2 clock
> that takes the 26 MHz oscillator as its input.
> 
> Fixes: 5bc8e2875ffb ("arm64: dts: mt8183: add systimer0 device node")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I generally not just like - but *love* - this change, I had that in my mind
for a couple of months now and forgot about it because reasons.

There's just one thing that, since we're doing this now, we can clarify (and
that's important to avoid questions like "why isn't this board-specific"):
the 26MHz clock "clk26m" oscillator that we're using for the system timers
is a SoC-provided clock, and its name is "SYSCLK" as in "System bus clock".

I know that your target is to describe how we get from 26M to 13M, but at
this point it may be worth it to use the right names to help preventing
confusion about that clock not being an external crystal on the board but
something internal to the SoC.

So, I propose:
1. Change `clk26m: oscillator` to `clk26m: sysclk` or `clk26m: sysclk-26m`;
2. Add the divider as `clk13m: sysclk-div2`.

What do you think?

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 19ff1babc359..0cbbaebe1213 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -585,6 +585,15 @@ psci {
>   		method = "smc";
>   	};
>   
> +	clk13m: fixed-factor-clock-13m {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&clk26m>;
> +		clock-div = <2>;
> +		clock-mult = <1>;
> +		clock-output-names = "clk13m";
> +	};
> +
>   	clk26m: oscillator {
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> @@ -968,8 +977,7 @@ systimer: timer@10017000 {
>   				     "mediatek,mt6765-timer";
>   			reg = <0 0x10017000 0 0x1000>;
>   			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&topckgen CLK_TOP_CLK13M>;
> -			clock-names = "clk13m";
> +			clocks = <&clk13m>;
>   		};
>   
>   		iommu: iommu@10205000 {


