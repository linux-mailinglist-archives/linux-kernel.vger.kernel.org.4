Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A970671D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEQLsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQLsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:48:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE010FE;
        Wed, 17 May 2023 04:48:04 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36796660574E;
        Wed, 17 May 2023 12:48:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684324083;
        bh=pdURUQBQCGZwUYqLO8wHO9znW+z0Fce579FBz8y/290=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n5EEQbPvjfAzCHlxP0Yv0FWn8la8yKekCCiB7eUFzyS5QfzfhMeV8qiQsdFMJ9ORU
         R94ccrA5DvKOsA5U1vkVnwc62L7Rjy2TkRKo8KKqiGqNNe/XeV19/VBM8oPhqk/EZJ
         6FdOSm8P4sQbofdXZ+NFIpnHlWJehch51ubTROSluORGI8pOIWI8SGgm+ENd4JnzMo
         AfzfmNhk5rPs5Tf6tRUvUEC+hMTmND+BTH/G+cAL9iujQ+ap+w+M4EW2xNC7xpoIvT
         7UWj4ZBGLHJp7Gbke8YgVnRg2TzSK8up/K4rXu0J7DH7lOD04z6zZEWFhVIXjPwrpT
         6Og2dQOJgMVOA==
Message-ID: <daac5c71-e6d3-04b0-f628-c53a4e12640d@collabora.com>
Date:   Wed, 17 May 2023 13:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/5] ASoC: mediatek: common: soundcard driver add dai_fmt
 support
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
 <20230517111534.32630-4-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230517111534.32630-4-trevor.wu@mediatek.com>
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
> There are two changes included in the patch.
> 
> First, add set_dailink_daifmt() function, so dai_fmt can be updated by
> the configuration in dai-link sub node.
> 
> Second, remove codec phandle from required property in dai-link sub node.
> For example, user possibly needs to update dai-format for all etdm
> co-clock dai-links, but codec doesn't need to be specified in capture
> dai-link for a speaker amp.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   .../mediatek/common/mtk-soundcard-driver.c    | 49 ++++++++++++++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
> index 738093451ccb..5e291092046b 100644
> --- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
> +++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
> @@ -22,7 +22,7 @@ static int set_card_codec_info(struct snd_soc_card *card,
>   
>   	codec_node = of_get_child_by_name(sub_node, "codec");
>   	if (!codec_node)
> -		return -EINVAL;
> +		return 0;
>   
>   	/* set card codec info */
>   	ret = snd_soc_of_get_dai_link_codecs(dev, codec_node, dai_link);
> @@ -36,6 +36,47 @@ static int set_card_codec_info(struct snd_soc_card *card,
>   	return 0;
>   }
>   
> +static int set_dailink_daifmt(struct snd_soc_card *card,
> +			      struct device_node *sub_node,
> +			      struct snd_soc_dai_link *dai_link)
> +{
> +	unsigned int daifmt;
> +	const char *str;
> +	int ret;
> +	struct {
> +		char *name;
> +		unsigned int val;
> +	} of_clk_table[] = {
> +		{ "cpu",	SND_SOC_DAIFMT_CBC_CFC },
> +		{ "codec",	SND_SOC_DAIFMT_CBP_CFP },
> +	};
> +

This is an optional property and this function should not do anything if that
property is not found, so....

	/*
	 * Check "mediatek,clk-provider" to select the clock provider
	 * in SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK area, if specified.
	 */
	if (!of_property_read_string(sub_node, "mediatek,clk-provider", &str))
		return 0;

...this allows you to reduce indentation as well.

> +	daifmt = snd_soc_daifmt_parse_format(sub_node, NULL);
> +	if (daifmt) {
> +		dai_link->dai_fmt &= SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
> +		dai_link->dai_fmt |= daifmt;
> +	}
> +
> +	/*
> +	 * check "mediatek,clk-provider = xxx"
> +	 * SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK area
> +	 */
> +	ret = of_property_read_string(sub_node, "mediatek,clk-provider", &str);
> +	if (ret == 0) {
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(of_clk_table); i++) {
> +			if (strcmp(str, of_clk_table[i].name) == 0) {
> +				dai_link->dai_fmt &= ~SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
> +				dai_link->dai_fmt |= of_clk_table[i].val;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   int parse_dai_link_info(struct snd_soc_card *card)
>   {
>   	struct device *dev = card->dev;
> @@ -67,6 +108,12 @@ int parse_dai_link_info(struct snd_soc_card *card)
>   			of_node_put(sub_node);
>   			return ret;
>   		}
> +
> +		ret = set_dailink_daifmt(card, sub_node, dai_link);
> +		if (ret < 0) {

if (ret) {
  ...
}

> +			of_node_put(sub_node);
> +			return ret;
> +		}

Regards,
Angelo

