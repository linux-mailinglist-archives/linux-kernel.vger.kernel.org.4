Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8C69AC29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBQNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBQNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:09:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B409E68566;
        Fri, 17 Feb 2023 05:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676639382; x=1708175382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EipxcAyNbRifMzOG9QwPzSpk0i0NDRf5+rYrpaSO3p8=;
  b=cLQlwnfHWyjMjGtSDWKR1BT6YtuUD8zpLxcbfTSIGnoZ02UOWTzT+x5x
   Y93KLCl2yGvs+/zihYHLjy5/K5nw6F5nYst7ZDVkOB+RRUMYJhEgOAewS
   AJaBVFPT5kZ0oyI4M54wO0PEFzL96qnHaj2Ta8cmrxIkuW9nCCkxyway9
   3Ah5GpHZ7fASopqyDqirP1Zgu2zzjVQE5JT/MGnEF8B0SJuhAwh32IWkw
   uwMG6jdafhzO+ybNcf725zNtVfiQuq85DOISbcCq/HPXl3Fjzclzs3EzX
   AGLfdsZNP29Ss+9YKcHIVqH3a7wZjsGY15ny11kKTU6CLAsjcKWRfBzs7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="329702791"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="329702791"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:09:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="648077433"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="648077433"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:09:25 -0800
Message-ID: <bd634d42-ebab-f713-365d-6936fdb5d77f@linux.intel.com>
Date:   Fri, 17 Feb 2023 14:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/3] ASoC: soc-pcm: add option to start DMA after DAI
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
 <20230217124151.236216-2-claudiu.beznea@microchip.com>
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230217124151.236216-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/2023 1:41 PM, Claudiu Beznea wrote:
> Add option to start DMA component after DAI trigger. This is done
> by filling the new struct snd_soc_component_driver::start_dma_last.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   include/sound/soc-component.h |  2 ++
>   sound/soc/soc-pcm.c           | 27 ++++++++++++++++++++++-----
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
> index 3203d35bc8c1..0814ed143864 100644
> --- a/include/sound/soc-component.h
> +++ b/include/sound/soc-component.h
> @@ -190,6 +190,8 @@ struct snd_soc_component_driver {
>   	bool use_dai_pcm_id;	/* use DAI link PCM ID as PCM device number */
>   	int be_pcm_base;	/* base device ID for all BE PCMs */
>   
> +	unsigned int start_dma_last;
> +
>   #ifdef CONFIG_DEBUG_FS
>   	const char *debugfs_prefix;
>   #endif
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 005b179a770a..5eb056b942ce 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1088,22 +1088,39 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
>   static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>   {
>   	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> -	int ret = -EINVAL, _ret = 0;
> +	struct snd_soc_component *component;
> +	int ret = -EINVAL, _ret = 0, start_dma_last = 0, i;
>   	int rollback = 0;
>   
>   	switch (cmd) {
>   	case SNDRV_PCM_TRIGGER_START:
>   	case SNDRV_PCM_TRIGGER_RESUME:
>   	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		/* Do we need to start dma last? */
> +		for_each_rtd_components(rtd, i, component) {
> +			if (component->driver->start_dma_last) {
> +				start_dma_last = 1;
> +				break;
> +			}
> +		}
> +
>   		ret = snd_soc_link_trigger(substream, cmd, 0);
>   		if (ret < 0)
>   			goto start_err;
>   
> -		ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
> -		if (ret < 0)
> -			goto start_err;
> +		if (start_dma_last) {
> +			ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
> +			if (ret < 0)
> +				goto start_err;
> +
> +			ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
> +		} else {
> +			ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
> +			if (ret < 0)
> +				goto start_err;
>   
> -		ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
> +			ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
> +		}
>   start_err:
>   		if (ret < 0)
>   			rollback = 1;

Can all of the above be implemented similarly to already present 
stop_dma_first? It looks similar and I don't see reason to have one flag 
in snd_soc_component_driver and other in snd_soc_dai_link.


