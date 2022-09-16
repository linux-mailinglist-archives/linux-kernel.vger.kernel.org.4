Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69BC5BAF34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiIPOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiIPOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38504324
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338267; x=1694874267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TUTrrnnUNzMDWn7idCm1PdQx1UFNwdQB3+BXN34GGsE=;
  b=Rfw6l4tGrz16/rS1r9o5gH3fw2Lgs+Wc/t3w+6WKjmGwdu/T/gebyJ+h
   djV+hTKmtq1zBBQ4EcAMMgj3RFqxsxzVT39Gv0dMs1C/6bQGR6CN7L5YM
   w0sJ4machLtClSUNgm5WFsI2vkc8838KjM+byM6WHZB0qOmNLe8qTn/dh
   +jYdnn50c9UKVz2aA9YRrr2yrA5doengk+NAkZjHit+bU5cTsteP0s/8c
   VQrL0cQ5AS2ueWIjrkuEfEwpNPxpX/WuMI8pH5NcjnTVHLknapa97W6if
   dRKLEs9frso/DnjNfsFCoaz7v7UJ5wwlo+vE7o4SG1wlcWH5cbDnyNNqn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="278729565"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="278729565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650889049"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:15 -0700
Message-ID: <60ca20b7-c636-000c-c146-a46e52762691@linux.intel.com>
Date:   Fri, 16 Sep 2022 10:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_ssp_amp: use devm_kcalloc()
 instead of devm_kzalloc()
Content-Language: en-US
To:     cgel.zte@gmail.com, broonie@kernel.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, brent.lu@intel.com,
        akihiko.odaki@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220916062549.154114-1-ye.xingchen@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062549.154114-1-ye.xingchen@zte.com.cn>
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
>  sound/soc/intel/boards/sof_ssp_amp.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
> index 4a762e002ac7..94d25aeb6e7c 100644
> --- a/sound/soc/intel/boards/sof_ssp_amp.c
> +++ b/sound/soc/intel/boards/sof_ssp_amp.c
> @@ -210,10 +210,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  	int i, id = 0;
>  
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
> -					sof_ssp_amp_card.num_links, GFP_KERNEL);
> -	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
> -					sof_ssp_amp_card.num_links, GFP_KERNEL);
> +	links = devm_kcalloc(dev, sof_ssp_amp_card.num_links,
> +					sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	cpus = devm_kcalloc(dev, sof_ssp_amp_card.num_links,
> +					sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!links || !cpus)
>  		return NULL;
>  
> @@ -306,9 +306,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	if (sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT) {
>  		/* HDMI */
>  		if (hdmi_num > 0) {
> -			idisp_components = devm_kzalloc(dev,
> -					   sizeof(struct snd_soc_dai_link_component) *
> -					   hdmi_num, GFP_KERNEL);
> +			idisp_components = devm_kcalloc(dev,
> +					   hdmi_num,
> +					   sizeof(struct snd_soc_dai_link_component),
> +					   GFP_KERNEL);
>  			if (!idisp_components)
>  				goto devm_err;
>  		}
