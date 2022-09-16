Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070B5BAF30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIPOXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiIPOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:23:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA4B2848
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338228; x=1694874228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9tPEr/H6IzDstmNvVzD+zOCEBT6Sewon5wngnegWEOA=;
  b=LFKSpCn/fgMSHRobXFkVvvX7h0CVg1Wh5dUwsNe2qoRrvxLjWw/rU9pj
   MswFOgfGeCBDnFS1DhZCI/EhfeBpzxuABl8GOjibRrC1vUHpWYGgB7Yf2
   skyW+QAC4bMwWO1nuhn72XDVCcJl68avmEdwR8dPbXDH4+iBmVOl+0tcb
   VNWvfsWVa4pxTr5IDGTKC8/SdGORhymu70xLqd9vb9wU50LdAHKteLKWi
   bCr/Jjxeqra0QFm6Nn7pmQCzEZOU0Mh9rjnWVlBkzDbludKX0gEEzryjr
   WBD6MBFXU+s4P52iOYyHZoDuMdKStw54xGk9LQk+Eza1gZMn/A3Y9eDlX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325275172"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="325275172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:23:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650888874"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:23:42 -0700
Message-ID: <95073ce7-6f4e-0adf-0c23-44351af0061b@linux.intel.com>
Date:   Fri, 16 Sep 2022 10:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_cs42l42: use function
 devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To:     cgel.zte@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, cezary.rojewski@intel.com,
        kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
        Zeal Robot <zealci@zte.com.cn>, tiwai@suse.com,
        ranjani.sridharan@linux.intel.com, liam.r.girdwood@linux.intel.com,
        akihiko.odaki@gmail.com, ye xingchen <ye.xingchen@zte.com.cn>,
        yung-chuan.liao@linux.intel.com, brent.lu@intel.com,
        linux-kernel@vger.kernel.org
References: <20220916062234.153275-1-ye.xingchen@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062234.153275-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 08:22, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_cs42l42.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
> index 85ffd065895d..e38bd2831e6a 100644
> --- a/sound/soc/intel/boards/sof_cs42l42.c
> +++ b/sound/soc/intel/boards/sof_cs42l42.c
> @@ -445,9 +445,9 @@ static int create_hdmi_dai_links(struct device *dev,
>  	if (hdmi_num <= 0)
>  		return 0;
>  
> -	idisp_components = devm_kzalloc(dev,
> -					sizeof(struct snd_soc_dai_link_component) *
> -					hdmi_num, GFP_KERNEL);
> +	idisp_components = devm_kcalloc(dev,
> +					hdmi_num,
> +					sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!idisp_components)
>  		goto devm_err;
>  
> @@ -543,10 +543,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  	int ret, id = 0, link_seq;
>  
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
> -			     sof_audio_card_cs42l42.num_links, GFP_KERNEL);
> -	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
> -			     sof_audio_card_cs42l42.num_links, GFP_KERNEL);
> +	links = devm_kcalloc(dev, sof_audio_card_cs42l42.num_links,
> +			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	cpus = devm_kcalloc(dev, sof_audio_card_cs42l42.num_links,
> +			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!links || !cpus)
>  		goto devm_err;
>  
