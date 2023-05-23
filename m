Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7375070E496
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbjEWSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbjEWSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:24:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37483E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684866281; x=1716402281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kH22TXuJtFmSJ2fWfIGz1kwHZ5/aELJIPwlWwy6uGcE=;
  b=ZZuJM3yxD23gpDKIkOYPDa0/hAYGkhJkrxGtX5+QVU0nj2BpaR2kWYRv
   Bd7WB/mAkBtYOWtKXbmAg7BLgJOlxvhOWeqmLiqsE7MnAgJu+/T19GmI4
   fUDrL5JB73vtoAUWw8vu+GEI/qdn0rJU7WaQdNrE6bPyTWif8ckEDqvGP
   +5sBZ505BqoIxzDnNqnx2FBIjZFZ9vqJT37X/JQkPlyu/nqgSpptxkBK3
   5GUqrSdLkUTXSX+HSAq6Kkf4GVsS4MDQPTUDzmiaFFZP9c6ulJogDawak
   ftHu9tdFSinqZ54prmmoNUt2AI8c2qQvyZRr0ep8cR0MCcVjeQaF97EYp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342786282"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="342786282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="736974314"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="736974314"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:39 -0700
Message-ID: <64948d51-dc5d-adb7-4929-74a827a004a2@linux.intel.com>
Date:   Tue, 23 May 2023 10:03:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 6/9] ASoC: amd: ps: add pm ops support for SoundWire
 dma driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-7-Vijendar.Mukunda@amd.com>
 <b3812c08-96fe-f125-66c6-a7db518a37ba@linux.intel.com>
 <f69b31e4-79f0-b7f5-097b-0e11699867b9@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <f69b31e4-79f0-b7f5-097b-0e11699867b9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> @@ -464,16 +488,79 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>>  	status = devm_snd_soc_register_component(&pdev->dev,
>>>  						 &acp63_sdw_component,
>>>  						 NULL, 0);
>>> -	if (status)
>>> +	if (status) {
>>>  		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>>> +		return status;
>>> +	}
>>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>> +	pm_runtime_enable(&pdev->dev);
>>> +	pm_runtime_allow(&pdev->dev);
>> Can you remind me why you need the pm_runtime_allow()? I can't recall
>> where the _forbid() is done.
> We have used pm_runtime_allow() to allow the device immediately
> enter runtime suspend state. Yes you are correct. If we use pm_runtime_allow(),
> then in remove sequence we should use pm_runtime_forbid call.
>> Also is there not a pm_runtime_set_active() missing?
> 
> 
> We will change the sequence as mentioned below.
> 
> in probe sequence , we will use
> 
>     pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>     pm_runtime_use_autosuspend(&pdev->dev);
>     pm_runtime_mark_last_busy(&pdev->dev);
>     pm_runtime_set_active(&pdev->dev);
>     pm_runtime_enable(&pdev->dev);
> 
> In remove sequence
> 
> pm_runtime_disable(&pdev->dev);

sounds about right.

>>
>>> +	return 0;
>>> +}
>>>  
>>> -	return status;
>>> +static int acp63_sdw_platform_remove(struct platform_device *pdev)
>>> +{
>>> +	pm_runtime_disable(&pdev->dev);
>>> +	return 0;
>>>  }
>>>  
>>> +static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
>>> +{
>>> +	struct sdw_dma_dev_data *sdw_data;
>>> +	struct acp_sdw_dma_stream *stream;
>>> +	struct snd_pcm_runtime *runtime;
>>> +	u32 period_bytes, buf_size, water_mark_size_reg;
>>> +	int ret;
>>> +	int index;
>>> +
>>> +	sdw_data = dev_get_drvdata(dev);
>>> +	for (index = 0; index < ACP63_SDW0_DMA_MAX_STREAMS; index++) {
>>> +		if (sdw_data->sdw0_dma_stream[index] &&
>>> +		    sdw_data->sdw0_dma_stream[index]->runtime) {
>>> +			water_mark_size_reg = sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
>>> +			runtime = sdw_data->sdw0_dma_stream[index]->runtime;
>>> +			stream = runtime->private_data;
>>> +			period_bytes = frames_to_bytes(runtime, runtime->period_size);
>>> +			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
>>> +			acp63_config_dma(stream, sdw_data->acp_base, index);
>>> +			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
>>> +							     buf_size, ACP_SDW0);
>>> +			if (ret)
>>> +				return ret;
>>> +			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
>>> +		}
>>> +	}
>>> +	for (index = 0; index < ACP63_SDW1_DMA_MAX_STREAMS; index++) {
>>> +		if (sdw_data->sdw1_dma_stream[index] &&
>>> +		    sdw_data->sdw1_dma_stream[index]->runtime) {
>>> +			water_mark_size_reg = sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
>>> +			runtime = sdw_data->sdw1_dma_stream[index]->runtime;
>>> +			stream = runtime->private_data;
>>> +			period_bytes = frames_to_bytes(runtime, runtime->period_size);
>>> +			buf_size = frames_to_bytes(runtime, runtime->buffer_size);
>>> +			acp63_config_dma(stream, sdw_data->acp_base, index);
>>> +			ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
>>> +							     buf_size, ACP_SDW1);
>>> +			if (ret)
>>> +				return ret;
>>> +			writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
>>> +		}
>>> +	}
>> Isn't this set of configurations something that needs to be done already
>> somewhere else, i.e. could there be a common helper?
> In hw_params() callback, we are setting period_bytes and buf_size from
> params structure. We are extracting same variables from runtime structures
> in resume() callback.
> We can implement a helper function to further simplify above logic
> instead of having two separate loops.

ok

