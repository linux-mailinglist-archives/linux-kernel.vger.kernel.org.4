Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E47066BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjEQLcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjEQLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:32:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A3527D;
        Wed, 17 May 2023 04:31:36 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E3754660563D;
        Wed, 17 May 2023 12:31:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684323094;
        bh=L2mTlsU8VTc247vwq0FkEbhJOgBaKoelge6UNY1Jq28=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dhFlWVbrsUUAUCO8oux7TvXYQVVNG8o7CgMnfFb9gVXKBxIuqSvsNyjv5gSAUIl8d
         wg8O1k+IuiplGKJOsUHlIBMUot1ztw1WVetcQPD9PSAzRZWZTqflbOGbvwPdTeGTyK
         4520iQ01nOUn9j3LLQnt18vv5nioXx26f2eC1DZDBmATH2/6NZ8My2yRS3QMVwNlCm
         CBDdNSHIXOxAZBM6Vnx3C+p+7pvrQwhCHZXl1INby6jQntYFO2mrLPfWstzmvsz9mv
         jk0tYFxkkyzUwqewsjTM6ZiQl10RWVcd63+ssb84QDgT55fHFp+C5m6F4iyljaTLmo
         S8WNE20MwI0nA==
Message-ID: <154497b3-f5c7-45d6-edd5-729642b80be5@collabora.com>
Date:   Wed, 17 May 2023 13:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/5] ASoC: mediatek: mt8188-mt6359: register hdmi/dp jack
 pins
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
 <20230517111534.32630-3-trevor.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230517111534.32630-3-trevor.wu@mediatek.com>
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
> Some userspace applications need jack control events, so register hdmi
> and dp jack pins to activate jack control events.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 27 +++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> index 833bc362dad2..6c3f36e2fffd 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
> @@ -151,6 +151,20 @@ struct mt8188_mt6359_priv {
>   	struct snd_soc_jack hdmi_jack;
>   };
>   
> +static struct snd_soc_jack_pin mt8188_hdmi_jack_pins[] = {
> +	{
> +		.pin = "HDMI",

"HDMI Jack" is more consistent with the snd_soc_jack_new_pins() call performed
later.

> +		.mask = SND_JACK_LINEOUT,
> +	},
> +};
> +
> +static struct snd_soc_jack_pin mt8188_dp_jack_pins[] = {
> +	{
> +		.pin = "DP",

Same here: "DP Jack"

> +		.mask = SND_JACK_LINEOUT,
> +	},
> +};
> +

Regards,
Angelo

