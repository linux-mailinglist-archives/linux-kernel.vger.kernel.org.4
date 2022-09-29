Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA45EF065
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiI2I0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiI2I0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:26:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8546B1114E0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:26:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F60B6601EB5;
        Thu, 29 Sep 2022 09:26:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664439976;
        bh=DVzLEPop4CuCNatrUBECX75Ksw2U4KOEH2nhFf8Ak84=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L5+R2TdKe+UVbDcG5czLQSYYGs5azJgidjWS3No9OjOXO4fmF+DEYaRb6bESyZV/b
         XK8gf4A6VWxQ45/D6Xz6fuK4gzh2XAMoRhHYhUjRdH/900QAwYodj9E4Q2ebY6oF0g
         PmMK1mXgTgFaL7AGmEJPcWh6Ksk66PuxW2pMvX6n+X+MbDyfb0Eg7/Z+BiOLeRup9M
         G1BcrfeTcgY04HX/UKvQQd5oNlLBhXw+ytbz3AQHc7CF2OyScy2rwZ8k0lmV/WEG2B
         Se0fq8uc1J6wM7WvDFoKVFJiJC8cNWwlKO/FfLgJJ7qEWQxJ+4Z1Y6ivyEohEFA3kQ
         xif/Gb4ARe6zg==
Message-ID: <66e1ddad-a7c2-215c-28b6-49e2b7f583a6@collabora.com>
Date:   Thu, 29 Sep 2022 10:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 8/8] soc: mtk-svs: mt8192: fix bank data
Content-Language: en-US
To:     matthias.bgg@kernel.org, roger.lu@mediatek.com,
        jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
 <20220928155519.31977-9-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928155519.31977-9-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 17:55, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Values vmax and dvt_fixed are not changed at runtime, set them as needed
> in the svs_banks struct.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

Honestly, I'm undecided on this one... because the vmax += dvt_fixed is something
descriptive of how the SVS works.
Since you're simply removing one addition, in a path that gets executed only once
in a kernel boot life, that's not even going to improve performance at all...

Right now, I'm more for dropping this change than keeping it.

Cheers,
Angelo

> ---
> 
>   drivers/soc/mediatek/mt8192-svs.h     | 4 ++--
>   drivers/soc/mediatek/mtk-svs-mt8192.c | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mt8192-svs.h b/drivers/soc/mediatek/mt8192-svs.h
> index 6571ebcb2c0f..bf8c6030428f 100644
> --- a/drivers/soc/mediatek/mt8192-svs.h
> +++ b/drivers/soc/mediatek/mt8192-svs.h
> @@ -16,7 +16,7 @@ static struct svs_bank svs_mt8192_banks[] = {
>   		.turn_freq_base		= 688000000,
>   		.volt_step		= 6250,
>   		.volt_base		= 400000,
> -		.vmax			= 0x60,
> +		.vmax			= 0x61,
>   		.vmin			= 0x1a,
>   		.age_config		= 0x555555,
>   		.dc_config		= 0x1,
> @@ -41,7 +41,7 @@ static struct svs_bank svs_mt8192_banks[] = {
>   		.turn_freq_base		= 688000000,
>   		.volt_step		= 6250,
>   		.volt_base		= 400000,
> -		.vmax			= 0x60,
> +		.vmax			= 0x66,
>   		.vmin			= 0x1a,
>   		.age_config		= 0x555555,
>   		.dc_config		= 0x1,
> diff --git a/drivers/soc/mediatek/mtk-svs-mt8192.c b/drivers/soc/mediatek/mtk-svs-mt8192.c
> index 838a94834741..183acf2829f0 100644
> --- a/drivers/soc/mediatek/mtk-svs-mt8192.c
> +++ b/drivers/soc/mediatek/mtk-svs-mt8192.c
> @@ -40,8 +40,6 @@ bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
>   			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
>   			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
>   		}
> -
> -		svsb->vmax += svsb->dvt_fixed;
>   	}
>   
>   	ret = svs_thermal_efuse_get_data(svsp);

