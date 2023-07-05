Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B9D748FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGEVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGEVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:32:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1999119B9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:31:57 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.137.5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 273C96600B9D;
        Wed,  5 Jul 2023 22:31:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688592715;
        bh=jh5Rm3wTiTgdIPqZurNeEEgGjpGLTPcGzW6ZzoTpIhQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LD6EtXLhaVUngxCpx5poLbPut4matVhG+XwQUqULp8UkQfF1eoIoDAjktEXXuqwnS
         mnDvclWSE74xYYpW/huTSi6XY6OFkcAaVpmoGqIvlR1LTpjXnArGws0l62kI7VZu7L
         GbdeAQExK92rPRq16jKv4OIfezUrXbBnKS/OHZp0NN2pzGKp+EDLKuOlY+2FupYoBI
         5bJ+Clv3A0rulATX+dimS2sGos5pUzpK0Glfrj+EyMaSDegmYFSGAD7s0sQm/4Kod7
         k2aUCB/swKfTaFybg/0FLsAFUWKnH1uiKpBkA9+9sRKoXkvmwVaJMjpR3mj0Yw/HVg
         Cbrp/4HVHDR3A==
Message-ID: <8a404cb2-ef2d-4df5-1f91-e5562f8204af@collabora.com>
Date:   Thu, 6 Jul 2023 00:31:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] ASoC: amd: vangogh: Add support for
 NAU8821/MAX98388 variant
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
 <20230705134341.175889-4-cristian.ciocaltea@collabora.com>
 <a414b971-381b-4695-9ba4-d2c777bff330@sirena.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <a414b971-381b-4695-9ba4-d2c777bff330@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 19:16, Mark Brown wrote:
> On Wed, Jul 05, 2023 at 04:43:41PM +0300, Cristian Ciocaltea wrote:
> 
>> +static int acp5x_max98388_hw_params(struct snd_pcm_substream *substream,
>> +				    struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>> +	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(rtd->card,
>> +							     ACP5X_MAX98388_DAI_NAME);
>> +	int ret;
>> +
>> +	ret = snd_soc_dai_set_fmt(dai,
>> +				  SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
>> +				  SND_SOC_DAIFMT_NB_NF);
>> +	if (ret < 0)
>> +		dev_err(dai->dev, "Failed to set format: %d\n", ret);
>> +
>> +	return ret;
>> +}
> 
> This never varies, why not just set it up statically in the dai_link?

Right, will handle this in v3.

Thanks,
Cristian
