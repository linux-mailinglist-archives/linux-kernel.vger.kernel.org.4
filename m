Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D27188BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjEaRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:46:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E3125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685555208; x=1717091208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hTqd3Pee3flh4HGEZ53S3n5CSuBCfvBltkaD8gL0ZSg=;
  b=eXkYIwxRGAabB5n9oMABoK1lz0/JTSWxGfA9J49E1HNAzJ2UsoEw6pFY
   G5O+FJkaGbjkNl6uSzaF06S3LKD2fzGQi2cpEY18aZKWABEkNFSsU6Jr4
   FOOnGHryVcRM9A2L1wDgej22/HBzvQWJf3nNovSmBz56ZRo028wUrEhUo
   kzV5f97z2tUhMMhSVNVPXjhi7h5KmfBp/rO0Ja4aVodCUgfXJWl17Ahal
   AHSr2D3aaADfowrWHGSDyHs7laeYMaEZDNz3XxdobUtNCpsAaLF7afPbm
   W93eT6y0IcQ3J2sLuX7I60ghZLfc2JnMs1o+4wEbLBrWTZPcPw6n18HxR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344832465"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="344832465"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 10:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="707004433"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="707004433"
Received: from tkam-mobl1.amr.corp.intel.com (HELO [10.212.252.148]) ([10.212.252.148])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 10:46:45 -0700
Message-ID: <5048a207-4ec4-e954-0fe8-88ed25320c1b@linux.intel.com>
Date:   Wed, 31 May 2023 08:53:07 -0500
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
 <f11f3370-0b72-cb1f-21cf-c574ef03fd72@linux.intel.com>
 <017abf89-a1aa-0c85-e244-a56c05b7c6e2@amd.com>
 <af5b0669-2621-7fce-358c-76dca7b521c5@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <af5b0669-2621-7fce-358c-76dca7b521c5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/23 02:28, Mukunda,Vijendar wrote:
> On 24/05/23 13:15, Mukunda,Vijendar wrote:
>> On 23/05/23 20:30, Pierre-Louis Bossart wrote:
>>> On 5/23/23 02:36, Mukunda,Vijendar wrote:
>>>> On 22/05/23 23:42, Pierre-Louis Bossart wrote:
>>>>> On 5/22/23 08:31, Vijendar Mukunda wrote:
>>>>>> Initialize workqueue for SoundWire DMA interrupts handling.
>>>>>> Whenever audio data equal to the SoundWire FIFO watermark level
>>>>>> are produced/consumed, interrupt is generated.
>>>>>> Acknowledge the interrupt and schedule the workqueue.
>>>>> It would help to explain why a work queue is needed is the first place,
>>>>> as opposed to handling periods in the interrupt thread.
>>>> For SoundWire DAI link, we are setting nonatomic flag to true.
>>>> If we return period elapsed from hard irq handler instead of workqueue,
>>>> soft lock up is observed during stream closure.
>>>>
>>>> We can use interrupt thread as well. To have a symmetry with
>>>> SoundWire manager work queues, we have used workqueue for
>>>> DMA interrupts.
>>> Oh, I completely missed the model here.
>>>
>>> If you are using the bottom half/hard irq handler to read status
>>> information, the natural thing to do would be to have an irq thread, no?
>>>
>>> Not sure I see the benefit of aligning with the manager work queues -
>>> unless it makes your life simpler to avoid race conditions with
>>> cancel_work_sync()?
>> We can implement request_threaded_irq() and move the handling of
>> DMA interrupts to thread function whereas we need to handle SoundWire
>> manager interrupts in top half only. Reason as follows.
>>
>> As per our design, we are not masking the interrupts in top half and
>> restoring mask after thread execution like Intel and
>> our IP supports line based interrupts. If we move SoundWire manager
>> interrupt handling to thread function, we have observed interrupts are
>> reported but not handled properly due to thread execution is in progress
>> sometimes.
>> we will add comments for this design constraint in the code if we have to
>> go with threaded_irq implementation.
>>
>> @Bossart: we are waiting for your reply.

I am not sure I get the point about using workqueues v. threads for the
manager, which in turn makes it difficult to understand why the DMA
interrupt handling should be aligned with that of the manager interrupt
handling.

Using the combination of hard irq handler + workqueue feels odd. I may
very well 'work' but others should chime in since I am far from the most
knowledgeable reviewer in this area.

>>>>>> +static void acp63_sdw_dma_workthread(struct work_struct *work)
>>>>>> +{
>>>>>> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
>>>>>> +						    acp_sdw_dma_work);
>>>>>> +	struct sdw_dma_dev_data *sdw_dma_data;
>>>>>> +	u32 stream_index;
>>>>>> +	u16 pdev_index;
>>>>>> +
>>>>>> +	pdev_index = adata->sdw_dma_dev_index;
>>>>>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>>>>> +
>>>>>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>>>>>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>>>>>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
>>>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>>>>>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>>>>>> +		}
>>>>>> +	}
>>>>>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>>>>>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>>>>>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
>>>>>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>>>>>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>>>>>> +		}
>>>>>> +	}
>>>>> I am not clear on the benefits of the workqueue which only tests a flag
>>>>> that's set ...
>>>> In top half, we are checking all stream irq mask and setting
>>>> corresponding stream id index in interrupt status array when dma
>>>> irq is raised.
>>>>
>>>> Our intention is to handle snd_pcm_period_elapsed in process context.
>>>> if the flag is set, call the period elapsed for the substream based on stream
>>>> id in work queue.
> 
