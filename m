Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD11666CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjALIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbjALIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:50:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C63C52776
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513238; x=1705049238;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=h5m7P3ApwoYtxTr2JyHySDG+hPGAgpKeo5UNspZ01+U=;
  b=Nd1G5EBtWJFbG7H8wDChTDPbhftLMyNhnHgX1tD8zb4I6dMzQhEvFyMF
   uBTTgt4d/seIhSpQEfx53MYHtcQS+NpHO4AJ6hzhmqtRMoN9o+uZiTG+n
   0h68A+kFPd2ddt6XI4Q13u0ClZS0ZSq9XNGbm/03WRfnuMBw8+LgJrVjF
   sUKdxS3zYK23NOsYekC6jYo9aJSzr+ZpUIUwl256jZnt4351DUPOmv1ve
   /STikTgu5IqVU5wkiU2lY0kUc1Vwv5rWbDcbvduW/4DxtvKYwZKS/iH1C
   p0hEqxnluOjQeWRyLZ4HqyPhRJ467VKLGmXNcaf1ZYJCSCb7UQmsWuBly
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325674758"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="325674758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:47:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746475853"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="746475853"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:47:15 -0800
Message-ID: <1eb6b8a5-7955-a283-fcc4-9d0c0f53a71e@linux.intel.com>
Date:   Thu, 12 Jan 2023 09:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: soc-pcm.c: Introduce a count to record the times of
 setting DAIs parameters
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230112065834.580192-1-chancel.liu@nxp.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230112065834.580192-1-chancel.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/2023 7:58 AM, Chancel Liu wrote:
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
> 

Can rtd->dpcm[dir].users be somehow used instead or do DAI users need to 
be count explicitly?

> Fixes: 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated")
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>   include/sound/soc-dai.h |  3 +++
>   sound/soc/soc-pcm.c     | 16 +++++++++++-----
>   2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index ea7509672086..a7e589a0fe72 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -451,6 +451,9 @@ struct snd_soc_dai {
>   	unsigned int channels;
>   	unsigned int sample_bits;
>   
> +	/* Count of setting DAI parameters */
> +	unsigned int hw_params_count;
> +
>   	/* parent platform/codec */
>   	struct snd_soc_component *component;
>   
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 579a44d81d9a..2c2a5dcf9e06 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -711,14 +711,10 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
>   
>   	if (!rollback) {
>   		snd_soc_runtime_deactivate(rtd, substream->stream);
> -		/* clear the corresponding DAIs parameters when going to be inactive */
> -		for_each_rtd_dais(rtd, i, dai) {
> -			if (snd_soc_dai_active(dai) == 0)
> -				soc_pcm_set_dai_params(dai, NULL);
>   
> +		for_each_rtd_dais(rtd, i, dai)
>   			if (snd_soc_dai_stream_active(dai, substream->stream) == 0)
>   				snd_soc_dai_digital_mute(dai, 1, substream->stream);
> -		}
>   	}
>   
>   	for_each_rtd_dais(rtd, i, dai)
> @@ -949,6 +945,14 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
>   
>   	snd_soc_dpcm_mutex_assert_held(rtd);
>   
> +	/* clear the corresponding DAIs parameters when hw_params_count decreases to 0 */
> +	for_each_rtd_dais(rtd, i, dai)
> +		if (snd_soc_dai_stream_valid(dai, substream->stream)) {
> +			dai->hw_params_count--;
> +			if (dai->hw_params_count == 0)
> +				soc_pcm_set_dai_params(dai, NULL);
> +		}
> +
>   	/* run the stream event */
>   	snd_soc_dapm_stream_stop(rtd, substream->stream);
>   
> @@ -1051,6 +1055,7 @@ static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
>   
>   		soc_pcm_set_dai_params(codec_dai, &codec_params);
>   		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
> +		codec_dai->hw_params_count++;
>   	}
>   
>   	for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
> @@ -1068,6 +1073,7 @@ static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
>   		/* store the parameters for each DAI */
>   		soc_pcm_set_dai_params(cpu_dai, params);
>   		snd_soc_dapm_update_dai(substream, params, cpu_dai);
> +		cpu_dai->hw_params_count++;
>   	}
>   
>   	ret = snd_soc_pcm_component_hw_params(substream, params);

