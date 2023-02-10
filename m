Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596D691EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjBJL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:59:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CA34035;
        Fri, 10 Feb 2023 03:59:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 571F766020D7;
        Fri, 10 Feb 2023 11:59:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676030369;
        bh=bpaFyMldZTemYDmlIiJTHOVsApZQsioHYrMkbmQ6/LU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lBokYII07z+WYmzFL4P7ME8cC9wZNHNmtiYRwdPmR1zv36WPFu63NWRLg4GDBMMjD
         eUisN7cGtvRZyV+kbqNBLGCwYskG9v4bx53SzeAbghQYXl56XuEkn0gXsCUt8jHn37
         uQpHxxsShNsSYvBfSd/CdgA9BPebkunoGjHUNEjIeYy60Fgvr/hPA1YqkXGz9rmmzL
         32nk9Ubr5A+wjzdROR0izIxYy9cnSAUoE8Q9cKGpybus31wLNmpz4mZY2fYQfjUHVX
         o/Sl5xp5faY7BoHG5HLVpuzNtIx4lpll74SWoChIBdGUmUamU4Af7kjn8NMfEkRNB2
         duJ0ybuyuMutg==
Message-ID: <3db45ca3-9104-826c-9f92-549e07471296@collabora.com>
Date:   Fri, 10 Feb 2023 12:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 4/4] Revert "arm64: dts: mt8173: add mmsel clocks for
 4K support"
Content-Language: en-US
To:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
 <20230209160357.19307-4-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209160357.19307-4-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 17:03, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> This reverts commit fc6634ac0e5380aeb1063275a2e9a583d41b2306.
> 
> The mmsys is a clock provider but does not have any clocks connected to
> it. Therefore assigned-clock properties should be applied to the users of mmsys.
> 
> This fixes the DT schema check:
> mediatek/mt8173-elm.dtb: syscon@14000000: 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

About solving schema checks: agreed.

Since this is impacting on multiple subsystems (display, vdec, venc), can we
instead move this to the topckgen node?
I didn't check if that would trigger another schema check, but I remember
doing that on Qualcomm DTs a bit of time ago.

The alternative would be to copy that over more than 10 nodes, which would
be a bit ... ugly.

Cheers,
Angelo

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index c47d7d900f283..b753547e250fe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -988,8 +988,6 @@ mmsys: syscon@14000000 {
>   			compatible = "mediatek,mt8173-mmsys", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
>   			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
> -			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
> -			assigned-clock-rates = <400000000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
>   			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,


