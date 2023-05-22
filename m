Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9604D70C539
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjEVSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjEVScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:32:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E08FE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684780332; x=1716316332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwdz15fUCXCtoEVD6kRwMHhqO3XrNhvirt4nBQx8GFE=;
  b=eHAcBOHHcywNbRwUQ1/K2EBHuGp2b9HFl/uAQbMuQD6SAzDC0HaGMh7Z
   qjDVvTOAYCz6s0/g18MBjCsQclWwSs2Ms9EacZlj31skMeUl057zFbuwI
   9ETL/pKU6DLNFcMpkl6R4G45skYBKkmWYgOypY3xrHmZVQtbptI+Vqrw1
   /MXbNFiNR01Fk8RR1iG1GU70ejwUjRx2QBbPEK434xGyRHMWgPKNQmKTP
   3J6Jru5P66i7utuFVLQdRZIahWBmxAtJz9FT+o9NJT8X01zQs4xCpAVJ8
   BEgH282OMv3CiyZGN9K1jYKOVdgy/m8Nu02rBzQ7JBHsAjaU0V0Zfk3/R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356235175"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356235175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697740860"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="697740860"
Received: from ljgreene-mobl.amr.corp.intel.com (HELO [10.209.124.121]) ([10.209.124.121])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 11:31:51 -0700
Message-ID: <b3812c08-96fe-f125-66c6-a7db518a37ba@linux.intel.com>
Date:   Mon, 22 May 2023 13:20:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 6/9] ASoC: amd: ps: add pm ops support for SoundWire
 dma driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-7-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230522133122.166841-7-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -464,16 +488,79 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
>  	status = devm_snd_soc_register_component(&pdev->dev,
>  						 &acp63_sdw_component,
>  						 NULL, 0);
> -	if (status)
> +	if (status) {
>  		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
> +		return status;
> +	}
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);

Can you remind me why you need the pm_runtime_allow()? I can't recall
where the _forbid() is done.

Also is there not a pm_runtime_set_active() missing?

> +	return 0;
> +}
>  
> -	return status;
> +static int acp63_sdw_platform_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
>  }
>  
> +static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
> +{
> +	struct sdw_dma_dev_data *sdw_data;
> +	struct acp_sdw_dma_stream *stream;
> +	struct snd_pcm_runtime *runtime;
> +	u32 period_bytes, buf_size, water_mark_size_reg;
> +	int ret;
> +	int index;
> +
> +	sdw_data = dev_get_drvdata(dev);
> +	for (index = 0; index < ACP63_SDW0_DMA_MAX_STREAMS; index++) {
> +		if (sdw_data->sdw0_dma_stream[index] &&
> +		    sdw_data->sdw0_dma_stream[index]->runtime) {
> +			water_mark_size_reg = sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
> +			runtime = sdw_data->sdw0_dma_stream[index]->runtime;
> +			stream = runtime->private_data;
> +			period_bytes = frames_to_bytes(runtime, runtime->period_size);
> +			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> +			acp63_config_dma(stream, sdw_data->acp_base, index);
> +			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
> +							     buf_size, ACP_SDW0);
> +			if (ret)
> +				return ret;
> +			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
> +		}
> +	}
> +	for (index = 0; index < ACP63_SDW1_DMA_MAX_STREAMS; index++) {
> +		if (sdw_data->sdw1_dma_stream[index] &&
> +		    sdw_data->sdw1_dma_stream[index]->runtime) {
> +			water_mark_size_reg = sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
> +			runtime = sdw_data->sdw1_dma_stream[index]->runtime;
> +			stream = runtime->private_data;
> +			period_bytes = frames_to_bytes(runtime, runtime->period_size);
> +			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> +			acp63_config_dma(stream, sdw_data->acp_base, index);
> +			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
> +							     buf_size, ACP_SDW1);
> +			if (ret)
> +				return ret;
> +			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
> +		}
> +	}

Isn't this set of configurations something that needs to be done already
somewhere else, i.e. could there be a common helper?

> +	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops acp63_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp63_sdw_pcm_resume)
> +};
> +
>  static struct platform_driver acp63_sdw_dma_driver = {
>  	.probe = acp63_sdw_platform_probe,
> +	.remove = acp63_sdw_platform_remove,
>  	.driver = {
>  		.name = "amd_ps_sdw_dma",
> +		.pm = &acp63_pm_ops,
>  	},
>  };
>  
