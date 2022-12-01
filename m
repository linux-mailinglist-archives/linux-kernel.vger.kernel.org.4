Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC463EBFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLAJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLAJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:07:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E763EB99;
        Thu,  1 Dec 2022 01:07:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 053B06602B84;
        Thu,  1 Dec 2022 09:07:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669885651;
        bh=8jHjmSVTbJv8cbYTXsHL50wkv2nBgikOZ1z0ILT8YM0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z4JeI8M/qnmFg2yXh5HVGszAWAtnij7NwUGovyCw1VDdq8aJFaU/BOAgypQoa4QuG
         zmxc1FKTKI4uJH7RQ9TibRk1ssye11o17QFXQKwdqFoopg2wdbvyKx3QXqndaIef/L
         hGna4xjprrkUiRqy/czXncySOVxq52/npCTKiiz7vjiwJ7gc9eM2XMvbaAQFym49oK
         vbvFi81vJUlY1M/l/xZMl7luMFM2v/D+6iQ9nyZ62+qXGGlyc7w5vJTkhqXXZEoGS5
         QusJN0MzKb6ib1LAhZyQ5w3jUrv19hdmnydvz6gpaX/87pFI01+JBuufV9PNP7ZkTH
         nd/iPGPb0L4Tw==
Message-ID: <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com>
Date:   Thu, 1 Dec 2022 10:07:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
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

Il 01/12/22 08:33, Allen-KH Cheng ha scritto:
> Add adsp power domain controller node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
> Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
>      [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
>   include/dt-bindings/power/mt8192-power.h | 1 +
>   2 files changed, 9 insertions(+)
> 

Allen, thanks for this one, but it's incomplete...

First of all, you must add the power domain on the driver itself, specifically,
in drivers/soc/mediatek/mt8192-pm-domains.h - otherwise this change will have no
effect!

...Then, as Chen-Yu said, you should also add the power domain to the scp_adsp
clock node as that's solving the lockup issue...

.......and last, but not least: we need a Fixes tag to backport this fix, here
and on the commit that adds the missing power domain in the driver.

Thanks,
Angelo

> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 424fc89cc6f7..e71afba871fc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -514,6 +514,14 @@
>   						};
>   					};
>   				};
> +
> +				power-domain@MT8192_POWER_DOMAIN_ADSP {
> +					reg = <MT8192_POWER_DOMAIN_ADSP>;
> +					clocks = <&topckgen CLK_TOP_ADSP_SEL>;
> +					clock-names = "adsp";
> +					mediatek,infracfg = <&infracfg>;
> +					#power-domain-cells = <0>;
> +				};
>   			};
>   		};
>   
> diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
> index 4eaa53d7270a..63e81cd0d06d 100644
> --- a/include/dt-bindings/power/mt8192-power.h
> +++ b/include/dt-bindings/power/mt8192-power.h
> @@ -28,5 +28,6 @@
>   #define MT8192_POWER_DOMAIN_CAM_RAWA	18
>   #define MT8192_POWER_DOMAIN_CAM_RAWB	19
>   #define MT8192_POWER_DOMAIN_CAM_RAWC	20
> +#define MT8192_POWER_DOMAIN_ADSP	21
>   
>   #endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
> 

