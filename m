Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE967066F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjEQLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:40:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81837F5;
        Wed, 17 May 2023 04:40:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 70613660574E;
        Wed, 17 May 2023 12:40:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684323636;
        bh=T9QRvTUI9a2/9gMxw4EVMYbBrsZXmiyXdxxur97JjRs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UDe0ONrNUP6O+7KKxqro1r1AwJ8T+J6mjKbO/Sug2Bdx51DW7SkNwsZfzLMixIaO6
         0pUIPHll3JiHy14znIc//PsdbS4Y3iYsv2U94yIVkadCwIN60PKdjja2ZQA+gr89t/
         dXZLex8/5/X4olr9pf9EPgUIgmFSB0DRt7ynZfxdSSWJNPppN6SOVaHoaqNXIXN8Ae
         8yGkkj020lLJmGhQc+aEy+6OYYRfuTQidYgcRlWf6DxxqiqXBBIfPqs8XnW2/cflpj
         NQJVE1G5/bcKV7RJVoLZEPaEP80djdiUTimzzl0AjH7bPT3HF6dbrrCdNiHBxzMdY5
         DOt6wVtvUooMQ==
Message-ID: <678f3582-ff1e-033a-f8d9-f73910156d15@collabora.com>
Date:   Wed, 17 May 2023 13:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/5] ASoC: mediatek: mt8188: separate ADDA playback dai
 from capture dai
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
 <20230517111534.32630-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230517111534.32630-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/23 13:15, Trevor Wu ha scritto:
> MT8188 will support SOF. In SOF, be_hw_params_fixup callback are used to
> configure BE hardware parameters. However, playback and capture stream
> share the same callback function in which it can't know the stream type.
> 
> It's possible to require different paremters for playback and capture
> stream, so separate them into two dais for SOF usage.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-afe-common.h |  3 +-
>   sound/soc/mediatek/mt8188/mt8188-dai-adda.c   | 76 ++++++++++---------
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 34 +++++++--
>   3 files changed, 68 insertions(+), 45 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-common.h b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
> index eb7e57c239bd..1304d685a306 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-afe-common.h
> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
> @@ -39,7 +39,7 @@ enum {
>   	MT8188_AFE_MEMIF_END,
>   	MT8188_AFE_MEMIF_NUM = (MT8188_AFE_MEMIF_END - MT8188_AFE_MEMIF_START),
>   	MT8188_AFE_IO_START = MT8188_AFE_MEMIF_END,
> -	MT8188_AFE_IO_ADDA = MT8188_AFE_IO_START,
> +	MT8188_AFE_IO_DL_SRC = MT8188_AFE_IO_START,
>   	MT8188_AFE_IO_DMIC_IN,
>   	MT8188_AFE_IO_DPTX,
>   	MT8188_AFE_IO_ETDM_START,
> @@ -52,6 +52,7 @@ enum {
>   	MT8188_AFE_IO_ETDM_NUM =
>   		(MT8188_AFE_IO_ETDM_END - MT8188_AFE_IO_ETDM_START),
>   	MT8188_AFE_IO_PCM = MT8188_AFE_IO_ETDM_END,
> +	MT8188_AFE_IO_UL_SRC,
>   	MT8188_AFE_IO_END,
>   	MT8188_AFE_IO_NUM = (MT8188_AFE_IO_END - MT8188_AFE_IO_START),
>   	MT8188_DAI_END = MT8188_AFE_IO_END,
> diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
> index fed9f927e623..9a6673a6f28a 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
> @@ -53,8 +53,7 @@ enum {
>   };
>   
>   struct mtk_dai_adda_priv {
> -	unsigned int dl_rate;
> -	unsigned int ul_rate;
> +	bool hires_required;
>   };
>   
>   static unsigned int afe_adda_dl_rate_transform(struct mtk_base_afe *afe,

..snip..

> @@ -503,13 +495,15 @@ static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
>   	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %u\n",
>   		__func__, id, substream->stream, rate);
>   
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		adda_priv->dl_rate = rate;
> +	if (rate > ADDA_HIRES_THRES)
> +		adda_priv->hires_required = 1;
> +	else
> +		adda_priv->hires_required = 0;
> +

hires_required is a boolean, so assigning 1 or 0 should be replaced with
assigning true or false; regardless of that, what about...

	adda_priv->hires_required = (rate > ADDA_HIRES_THRES);

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>   		ret = mtk_dai_da_configure(afe, rate, id);
> -	} else {
> -		adda_priv->ul_rate = rate;
> +	else
>   		ret = mtk_dai_ad_configure(afe, rate, id);
> -	}
>   
>   	return ret;
>   }

Regards,
Angelo
