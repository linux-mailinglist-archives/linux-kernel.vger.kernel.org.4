Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68BB680EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjA3N2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjA3N2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:28:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8177418154
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675085315; x=1706621315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y3uOpscp6FQEPLwJB+DgR4ftPrTIh5c6tQ5X5DY1sUs=;
  b=iwesKAeJ2ONDPvL1b7DHDm2vkdpKUNw10xjFibYv1Wky8YV76xDY7gdo
   XAZIqmYTf63uDshZCgywlFLK01fbvY7BSQMfwbTSJvs2tNF/UpfFR3evl
   s/Aus7h80noF8rPzpHWAcG2zVSkNS5E7DGnxC4zSwQPe3Qmxip8tRh1XG
   4gB3K2Avsm++ZbYCMHToLCzF2cPHZqzvC3sSjGn6GNXn/iQJpH6qbLSUZ
   wGMjn/rOMnqR3DN+FXrYtSvs4laHqE1KGp1KY3C7lo/qYl15+pMrJOXsC
   Maj/CqDpQq1hk76wjNomrxnUwBmJfQeOTzMSZVdRyAwQChIOTIq6Vb5Ou
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="354869485"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="354869485"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:28:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788027124"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="788027124"
Received: from bradym3x-mobl.ger.corp.intel.com (HELO [10.252.0.233]) ([10.252.0.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:28:12 -0800
Message-ID: <81c25623-8689-759a-026e-b49190bc19cf@linux.intel.com>
Date:   Mon, 30 Jan 2023 15:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: amd: acp: Refactor bit width calculation
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Vijendar.Mukunda@amd.com,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230130100104.4076640-1-venkataprasad.potturu@amd.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230130100104.4076640-1-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2023 12:01, Venkata Prasad Potturu wrote:
> Refactor bit width calculation using params_physical_width()
> instead hard-code values.

I would have added a Reported-by tag for Pierre...
A Fixes tag might also help this patch to follow
ca9d237994db ("ASoC: amd: acp: Refactor i2s clocks programming sequence")

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
> ---
>  sound/soc/amd/acp/acp-mach-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
> index b83ae946b3e4..b4dcce4fbae9 100644
> --- a/sound/soc/amd/acp/acp-mach-common.c
> +++ b/sound/soc/amd/acp/acp-mach-common.c
> @@ -186,7 +186,7 @@ static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
>  
>  	srate = params_rate(params);
>  	ch = params_channels(params);
> -	format = 8 * params_format(params);
> +	format = params_physical_width(params);
>  
>  	if (drvdata->tdm_mode)
>  		fmt = SND_SOC_DAIFMT_DSP_A;
> @@ -330,7 +330,7 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
>  
>  	srate = params_rate(params);
>  	ch = params_channels(params);
> -	format = 8 * params_format(params);
> +	format = params_physical_width(params);
>  
>  	if (drvdata->tdm_mode)
>  		fmt = SND_SOC_DAIFMT_DSP_A;
> @@ -475,7 +475,7 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
>  
>  	srate = params_rate(params);
>  	ch = params_channels(params);
> -	format = 8 * params_format(params);
> +	format = params_physical_width(params);
>  
>  	if (drvdata->amp_codec_id != RT1019)
>  		return -EINVAL;
> @@ -616,7 +616,7 @@ static int acp_card_maxim_hw_params(struct snd_pcm_substream *substream,
>  
>  	srate = params_rate(params);
>  	ch = params_channels(params);
> -	format = 8 * params_format(params);
> +	format = params_physical_width(params);
>  
>  	if (drvdata->tdm_mode)
>  		fmt = SND_SOC_DAIFMT_DSP_A;

-- 
Péter
