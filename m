Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4166794C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjALPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjALP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:29:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81295A1A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536990; x=1705072990;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=D0hNIdfv9EWyP1RVxQgqv7k1sO7+UaCb9F79/VZ74AM=;
  b=a6Pkf11cwTb0P/s5Bjlhh3x10EMKqRkaMdMf22nj0UbGU+1bGbjYfa2r
   s0QDAp87mMHC0/J1WIJeJTXl75gD+ht4tikr5qvMtRwfYcGVY/pgzGDgx
   wDWMRyehX2SsJTqC7uq2L1J1XXQD5bl85tBO0PRVPGn+SRNwg0Q+tfKwl
   hiXlCYYV8R0j+j6CtGn8FcqapyJ73LeFnsI3+I4A5EjIdSmmOODDYpr8e
   8Rpz2NIuwwNGgU1Zh4WKtvTacV8Ko+J0bElYLLOF0MlCfUxHSWnVryy1t
   ClXRpMF5dy8QcHyBozgZYZF14D8vRu9MqZXLK3056IIpJtFlGFAYiT7+X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388212558"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388212558"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="607816924"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="607816924"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:10 -0800
Message-ID: <d83615ae-10d9-ca5b-26aa-522b3f10b43f@linux.intel.com>
Date:   Thu, 12 Jan 2023 08:19:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: soc-pcm.c: Introduce a count to record the times of
 setting DAIs parameters
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230112065834.580192-1-chancel.liu@nxp.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230112065834.580192-1-chancel.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 00:58, Chancel Liu wrote:
> The commit 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after
> stream_active is updated") tries to make sure DAIs parameters can be
> cleared properly through moving the cleanup to the place where
> stream_active is updated. However, it will cause the cleanup only
> happening in soc_pcm_close().
> 
> Suppose a case: aplay -Dhw:0 44100.wav 48000.wav. The case calls
> soc_pcm_open()->soc_pcm_hw_params()->soc_pcm_hw_free()->
> soc_pcm_hw_params()->soc_pcm_hw_free()->soc_pcm_close() in order. The
> parameters would be remained in the system even if the playback of
> 44100.wav is finished.
> 
> The case requires us clearing parameters in phase of soc_pcm_hw_free().
> We shouldn't use stream_active to decide if we must do the cleanup
> since it is finally updated in soc_pcm_close().
> 
> This patch introduces a usage count called hw_params_count in
> snd_soc_dai structure. It records the times of setting parameters to
> this DAI then decreases each time soc_pcm_hw_free() is called. If the
> count decreases to 0, it means this DAI is not used now and we should
> clear the parameters.

what makes you think that the use of hw_params and hw_free is symmetrical?

A couple of years ago we found a case where the FE hw_params failed, and
in that case the BE hw_free was called without the BE hw_params ever
being invoked first. This is due to the DPCM error handling, and as a
result all our hw_free implementations test if the resources are
actually allocated/valid and never assume hw_params was used.

IIRC it's also valid to call hw_params multiple times without calling
hw_free every time.

> Fixes: 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated")
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  include/sound/soc-dai.h |  3 +++
>  sound/soc/soc-pcm.c     | 16 +++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index ea7509672086..a7e589a0fe72 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -451,6 +451,9 @@ struct snd_soc_dai {
>  	unsigned int channels;
>  	unsigned int sample_bits;
>  
> +	/* Count of setting DAI parameters */
> +	unsigned int hw_params_count;
> +
>  	/* parent platform/codec */
>  	struct snd_soc_component *component;
>  
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 579a44d81d9a..2c2a5dcf9e06 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -711,14 +711,10 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
>  
>  	if (!rollback) {
>  		snd_soc_runtime_deactivate(rtd, substream->stream);
> -		/* clear the corresponding DAIs parameters when going to be inactive */
> -		for_each_rtd_dais(rtd, i, dai) {
> -			if (snd_soc_dai_active(dai) == 0)
> -				soc_pcm_set_dai_params(dai, NULL);
>  
> +		for_each_rtd_dais(rtd, i, dai)
>  			if (snd_soc_dai_stream_active(dai, substream->stream) == 0)
>  				snd_soc_dai_digital_mute(dai, 1, substream->stream);
> -		}
>  	}
>  
>  	for_each_rtd_dais(rtd, i, dai)
> @@ -949,6 +945,14 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
>  
>  	snd_soc_dpcm_mutex_assert_held(rtd);
>  
> +	/* clear the corresponding DAIs parameters when hw_params_count decreases to 0 */
> +	for_each_rtd_dais(rtd, i, dai)
> +		if (snd_soc_dai_stream_valid(dai, substream->stream)) {
> +			dai->hw_params_count--;
> +			if (dai->hw_params_count == 0)
> +				soc_pcm_set_dai_params(dai, NULL);
> +		}
> +
>  	/* run the stream event */
>  	snd_soc_dapm_stream_stop(rtd, substream->stream);
>  
> @@ -1051,6 +1055,7 @@ static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
>  
>  		soc_pcm_set_dai_params(codec_dai, &codec_params);
>  		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
> +		codec_dai->hw_params_count++;
>  	}
>  
>  	for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
> @@ -1068,6 +1073,7 @@ static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
>  		/* store the parameters for each DAI */
>  		soc_pcm_set_dai_params(cpu_dai, params);
>  		snd_soc_dapm_update_dai(substream, params, cpu_dai);
> +		cpu_dai->hw_params_count++;
>  	}
>  
>  	ret = snd_soc_pcm_component_hw_params(substream, params);
