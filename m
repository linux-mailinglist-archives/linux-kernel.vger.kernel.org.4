Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED50C70E495
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbjEWSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbjEWSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:24:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A68F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684866279; x=1716402279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QyHEP8tfyMQbyJYczp7OSH5grNvNuPCgF28/QY/9JrA=;
  b=lsAV5fzKutVJBP5GneRm+9rzwDx2LTT8RuimGrb2vsjVZQNwHY/zrJlk
   wG+95x62LEOqXDXuDR9sZCgdAhyOh/t1r9Xu93kCfV8yHmzET5sBPbbaH
   +3hxhp2CYW9VvF8xG1PmmX5n4+ACUkCohmReSesNsGRYHKonjattsPlaN
   8bg1ryjZ5DzzBQz10UTm67OEDf0Kn8AM0qGeRjGtN6X6CIyIttTzU48aN
   BLXzWuv+ClaTBOdVhqE2wkXX+tnRiRYnT+MsqmBcD7yJZAQmcjFZOl3Zf
   tAQtnQ67mTTFEUEth4HdbvR2/pOPKJWmlB8J1NYaR7YTXP9qwZon5tupX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342786255"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="342786255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="736974298"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="736974298"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:24:38 -0700
Message-ID: <f11f3370-0b72-cb1f-21cf-c574ef03fd72@linux.intel.com>
Date:   Tue, 23 May 2023 10:00:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 5/9] ASoC: amd: ps: add support for SoundWire DMA
 interrupts
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-6-Vijendar.Mukunda@amd.com>
 <fea3c862-1470-7911-ff77-5d945b1d77cf@linux.intel.com>
 <2dfeee7c-32bd-c054-22ff-3a2266e62c90@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2dfeee7c-32bd-c054-22ff-3a2266e62c90@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 5/23/23 02:36, Mukunda,Vijendar wrote:
> On 22/05/23 23:42, Pierre-Louis Bossart wrote:
>>
>> On 5/22/23 08:31, Vijendar Mukunda wrote:
>>> Initialize workqueue for SoundWire DMA interrupts handling.
>>> Whenever audio data equal to the SoundWire FIFO watermark level
>>> are produced/consumed, interrupt is generated.
>>> Acknowledge the interrupt and schedule the workqueue.
>> It would help to explain why a work queue is needed is the first place,
>> as opposed to handling periods in the interrupt thread.
> For SoundWire DAI link, we are setting nonatomic flag to true.
> If we return period elapsed from hard irq handler instead of workqueue,
> soft lock up is observed during stream closure.
> 
> We can use interrupt thread as well. To have a symmetry with
> SoundWire manager work queues, we have used workqueue for
> DMA interrupts.

Oh, I completely missed the model here.

If you are using the bottom half/hard irq handler to read status
information, the natural thing to do would be to have an irq thread, no?

Not sure I see the benefit of aligning with the manager work queues -
unless it makes your life simpler to avoid race conditions with
cancel_work_sync()?

>>> +static void acp63_sdw_dma_workthread(struct work_struct *work)
>>> +{
>>> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
>>> +						    acp_sdw_dma_work);
>>> +	struct sdw_dma_dev_data *sdw_dma_data;
>>> +	u32 stream_index;
>>> +	u16 pdev_index;
>>> +
>>> +	pdev_index = adata->sdw_dma_dev_index;
>>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>> +
>>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>>> +		}
>>> +	}
>>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>>> +		}
>>> +	}
>> I am not clear on the benefits of the workqueue which only tests a flag
>> that's set ...
> In top half, we are checking all stream irq mask and setting
> corresponding stream id index in interrupt status array when dma
> irq is raised.
> 
> Our intention is to handle snd_pcm_period_elapsed in process context.
> if the flag is set, call the period elapsed for the substream based on stream
> id in work queue.

