Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9345BAF31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIPOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiIPOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:23:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E562EB24B2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338236; x=1694874236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=quqz7w40+JN9mVdBdAp9nLJxD/EREdSo/n19syqzaqY=;
  b=elsJYRGg5iNtHA1encTaGtTnHNlu7pcB6PsXbq3oLGdK83tygUrNlU2z
   jAo/NPQGgj6Ylz8uBrniwv2mJm0vx9sXipBZPHJJ0AJ2hqjAK693hVE4m
   ldGs+QCZ2vpdqpvzl9MRDiGONhUwctRJ6njCjs8P1Yu4jaP0jAiwI6eB7
   JVCr7g7ryP+aaVqfBuSZ2EoJ1o3LTKcv2azqd7ulE3ra2YhxXGq+IkVtZ
   ZVUcwcROQMhdp9BK7D2EPvggkwEXM1JCrq38hHDs5qXSaILM5wLCPdWEt
   5SMDF0+OViIsc30Zecndqc9QDz5OIUY/OXGYtcKrcuM20NFW988E77KbJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299824145"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="299824145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:23:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650888893"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:23:50 -0700
Message-ID: <0cc74fa6-a9f0-ac99-0cba-ca61929feeaf@linux.intel.com>
Date:   Fri, 16 Sep 2022 10:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_nau8825: use function
 devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To:     cgel.zte@gmail.com, broonie@kernel.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, mac.chiang@intel.com,
        yong.zhi@intel.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220916062320.153456-1-ye.xingchen@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062320.153456-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 08:23, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  sound/soc/intel/boards/sof_nau8825.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
> index 8d7e5ba9e516..5585c217f78d 100644
> --- a/sound/soc/intel/boards/sof_nau8825.c
> +++ b/sound/soc/intel/boards/sof_nau8825.c
> @@ -355,10 +355,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  	int i, id = 0;
>  
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
> -			     sof_audio_card_nau8825.num_links, GFP_KERNEL);
> -	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
> -			     sof_audio_card_nau8825.num_links, GFP_KERNEL);
> +	links = devm_kcalloc(dev, sof_audio_card_nau8825.num_links,
> +			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	cpus = devm_kcalloc(dev, sof_audio_card_nau8825.num_links,
> +			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!links || !cpus)
>  		goto devm_err;
>  
> @@ -421,9 +421,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  
>  	/* HDMI */
>  	if (hdmi_num > 0) {
> -		idisp_components = devm_kzalloc(dev,
> -						sizeof(struct snd_soc_dai_link_component) *
> -						hdmi_num, GFP_KERNEL);
> +		idisp_components = devm_kcalloc(dev,
> +						hdmi_num,
> +						sizeof(struct snd_soc_dai_link_component),
> +						GFP_KERNEL);
>  		if (!idisp_components)
>  			goto devm_err;
>  	}
