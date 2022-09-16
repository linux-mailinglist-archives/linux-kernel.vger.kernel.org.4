Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED05BAF38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiIPOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiIPOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB350DFC2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338277; x=1694874277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S1JSC8Br/8ucG2eLuk9wLNXKmUdcrmGUqFmJDrAJYfc=;
  b=UTEEjXvcQybaqclmhH/NF+skyDzX/r271rN4UDv8jQMbFK7qwHmNHqOg
   ZdjfbPA+J1Tcyk0j7pyeJHBRaSSlrWzvQguLz0RJmUhikiW9hr0ouawmn
   t2X7WVElErwgVIa0WDNtxqthiBtyKmB494MO+AdqiGyhuL6kyJ0bVHfTE
   30wTSrfSuN3Rqnz2ay5LWnPsh2kOsPtfPko49YPxBf5O9+FPjsL1T2A+h
   gCaxG2fNfg31sMJwKVtH/S+kmz8dX/a0G0wr/m2COXqLIBPPMVhmooHqo
   q3Jn5doJpBsYWcMYP2xgVibUqbUP+Qye4CWHCOjl+iyXZzzui+qLVmn2+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="278729639"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="278729639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650889101"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:24 -0700
Message-ID: <5209eae6-8cf4-df16-4b9d-afc91a31db30@linux.intel.com>
Date:   Fri, 16 Sep 2022 10:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_rt5682: use devm_kcalloc()
 instead of devm_kzalloc()
Content-Language: en-US
To:     cgel.zte@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, cezary.rojewski@intel.com,
        linux-kernel@vger.kernel.org, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, Zeal Robot <zealci@zte.com.cn>,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        liam.r.girdwood@linux.intel.com, mac.chiang@intel.com,
        ye xingchen <ye.xingchen@zte.com.cn>, ajye.huang@gmail.com,
        yung-chuan.liao@linux.intel.com, brent.lu@intel.com,
        vamshi.krishna.gopal@intel.com, yong.zhi@intel.com
References: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 08:26, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  sound/soc/intel/boards/sof_rt5682.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 045965312245..1bf9455eaf93 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -600,10 +600,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  	int i, id = 0;
>  
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
> -			     sof_audio_card_rt5682.num_links, GFP_KERNEL);
> -	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
> -			     sof_audio_card_rt5682.num_links, GFP_KERNEL);
> +	links = devm_kcalloc(dev, sof_audio_card_rt5682.num_links,
> +			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	cpus = devm_kcalloc(dev, sof_audio_card_rt5682.num_links,
> +			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!links || !cpus)
>  		goto devm_err;
>  
> @@ -687,9 +687,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  
>  	/* HDMI */
>  	if (hdmi_num > 0) {
> -		idisp_components = devm_kzalloc(dev,
> -				   sizeof(struct snd_soc_dai_link_component) *
> -				   hdmi_num, GFP_KERNEL);
> +		idisp_components = devm_kcalloc(dev,
> +				   hdmi_num,
> +				   sizeof(struct snd_soc_dai_link_component),
> +				   GFP_KERNEL);
>  		if (!idisp_components)
>  			goto devm_err;
>  	}
