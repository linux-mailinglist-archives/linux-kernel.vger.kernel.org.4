Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3D35BAF33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiIPOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiIPOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41FB2878
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338245; x=1694874245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IoMPuMCwvjabVDhEb84AfPRn+hsVrAew00VjwYolvs4=;
  b=aRkjkrS6wUVNxPC9Mueth66yjkUoxNCXPw+UOLU5vjASHItYRLXVoDm4
   WFgkj0IiH5RPFJuH2/CxIGqWx360+RPjuC/sMvMqCqslQ3gm1qsg1N8H3
   z66rHrK76odYDf4hszPxdswpMarN1gL8sXnfqfaol8sxr0C0A5RW+7kUS
   QzzL7nrjPIb0NgcC0obX0cYwMkEF7FkfO89ZBKe7KBJrMXg9Jd4YcKv4m
   0YFKftefcLOSl1j7otIJutCLqdRoHUV7RYTGcdnul0BgYeS2E66euecTJ
   bohhTO89jiKNj6kzp/b4isH8X/g5gHZ2Tf88MA9X1IodzRxMv2y62f74e
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325275255"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="325275255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650888925"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:23:59 -0700
Message-ID: <fd74f04a-b4ef-565e-5b1e-a2f901d311a0@linux.intel.com>
Date:   Fri, 16 Sep 2022 10:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_es8336: use function
 devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To:     cgel.zte@gmail.com, broonie@kernel.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, mchehab@kernel.org,
        andrey.turkin@gmail.com, muralidhar.reddy@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220916062415.153659-1-ye.xingchen@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062415.153659-1-ye.xingchen@zte.com.cn>
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



On 9/16/22 08:24, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>


Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  sound/soc/intel/boards/sof_es8336.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
> index 606cc3242a60..fbb42e54947a 100644
> --- a/sound/soc/intel/boards/sof_es8336.c
> +++ b/sound/soc/intel/boards/sof_es8336.c
> @@ -481,9 +481,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
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
