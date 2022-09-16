Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299165BAF32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiIPOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiIPOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CBB2DA6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338253; x=1694874253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T2ApI7SubI2WKPmQQuZyAnZCYaKcuIBCP/Z0I7W79Zc=;
  b=P3JnOIouPYI4DZ5ih0Fr4Zg4q0ZGWy03N8GrA42Dge294Hr5sGKB0UOC
   PPe3MiKPUX21ZJXMBkEiaZl3ndNIkjnYJz/4ZC8qeqp0pY6/FOqI1nnC7
   rshyDa7rxTt6UobLK6gyhB5C7LFV5aTgN8MnGJTPuqaGlmvAlEDNjei9C
   MelkxszvIAyXpYF7mZMbZsm/LwDzujopSK9UueZg7wR2g9sqgZbtY7DQ4
   q4M/nz2t+kp/xniN8nyTR4ouTcuUJW0L8x8N6KgDu8Wk4TtRgIjmR9JZ/
   lMBVCCRBjVjdtRMaZGt0pzRERzLubXQOPrBeIDIk9Dz/KLMy0W4LwYx8p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300362851"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="300362851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650888953"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:07 -0700
Message-ID: <3d95caba-7a4b-7f28-10a4-abdad75f999f@linux.intel.com>
Date:   Fri, 16 Sep 2022 10:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASOC: SOF: use devm_kcalloc() instead of
 devm_kzalloc()
Content-Language: en-US
To:     cgel.zte@gmail.com, broonie@kernel.org
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220916062511.153962-1-ye.xingchen@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062511.153962-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 08:25, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/nocodec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
> index 356497fe4f4c..3537805070ad 100644
> --- a/sound/soc/sof/nocodec.c
> +++ b/sound/soc/sof/nocodec.c
> @@ -32,7 +32,7 @@ static int sof_nocodec_bes_setup(struct device *dev,
>  
>  	/* set up BE dai_links */
>  	for (i = 0; i < link_num; i++) {
> -		dlc = devm_kzalloc(dev, 3 * sizeof(*dlc), GFP_KERNEL);
> +		dlc = devm_kcalloc(dev, 3, sizeof(*dlc), GFP_KERNEL);
>  		if (!dlc)
>  			return -ENOMEM;
>  
> @@ -78,7 +78,7 @@ static int sof_nocodec_setup(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  
>  	/* create dummy BE dai_links */
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) * num_dai_drivers, GFP_KERNEL);
> +	links = devm_kcalloc(dev, num_dai_drivers, sizeof(struct snd_soc_dai_link), GFP_KERNEL);
>  	if (!links)
>  		return -ENOMEM;
>  
