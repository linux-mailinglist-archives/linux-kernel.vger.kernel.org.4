Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98487731DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFOQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFOQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:30:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F710273E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686846629; x=1718382629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hHorKwkvMaXScgaTfz57xKmtaDnDz2rWRcEaMGckwwE=;
  b=dziF2WCP7oa12G5KT27JRrmQfHD8BGHXwka/9GGv0dHdASSqvRLQtIne
   8a1XqQ8c+a5hrrTgzOXcIKIgc2hWLhyPtXnWv7cIqc9XLSAjnYC6eJl9d
   zE+eVZgrxTzQJZAoPs/mxND1oaHR4O45l0EiozRfMxTEoNKnBZFUTbHY5
   D3U9P7bSQ61Qar/TOlS+c1YNiyywzssBa/oLx98A/Q6iDAMlyyw7fz/u8
   PKiFRT1VPzB945FAW5Y5oEvL5GTlLdOAgmyulNxlbsORM5pUmjqZr7r9a
   L03pS2PY7333pOucyRIgKHKsW1xbNdo4LFOypy8KvQ4KRdZQ7iTPjThJD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="422603122"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="422603122"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:24:20 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745640888"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745640888"
Received: from mrejmak-mobl.ger.corp.intel.com (HELO [10.252.36.104]) ([10.252.36.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:24:16 -0700
Message-ID: <45ede657-f715-e38a-fdc6-130cdf74b604@linux.intel.com>
Date:   Thu, 15 Jun 2023 18:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V4 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-5-Vijendar.Mukunda@amd.com>
 <0dbd1c24-0006-7956-9b82-780c7f005927@linux.intel.com>
 <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
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



On 6/13/23 09:00, Mukunda,Vijendar wrote:
> On 12/06/23 23:36, Pierre-Louis Bossart wrote:
>>> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
>>> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
>>> +#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
>> that's a fairly small max period. That's 21ms for 2ch S32_LE 48kHz.
>>
>> Does this come from specific limitations or is this an arbitrary number?
>>
>> A comment on this wouldn't hurt.
> This is the initial version. We haven't exercised different sample
> rates/bit depth combinations much. Currently, targeted for 2Ch, 48Khz,
> 16bit audio streams only with 64k as buffer size.
> 
> We will extend support for different sample rates/bit depths combinations
> in the future.
>>> +static u32 sdw0_dma_enable_reg[ACP63_SDW0_DMA_MAX_STREAMS] = {
>>> +	ACP_SW0_AUDIO0_TX_EN,
>>> +	ACP_SW0_AUDIO1_TX_EN,
>>> +	ACP_SW0_AUDIO2_TX_EN,
>>> +	ACP_SW0_AUDIO0_RX_EN,
>>> +	ACP_SW0_AUDIO1_RX_EN,
>>> +	ACP_SW0_AUDIO2_RX_EN,
>>> +};
>>> +
>>> +static u32 sdw1_dma_enable_reg[ACP63_SDW1_DMA_MAX_STREAMS] = {
>>> +	ACP_SW1_AUDIO1_TX_EN,
>>> +	ACP_SW1_AUDIO1_RX_EN,
>>> +};
>> Still no explanation as to why SDW0 indices start at zero and SDW1
>> indices start at one?
> We have already provided reply in previous thread, i.e. for v3 patch set.
> 
> https://lore.kernel.org/alsa-devel/de3c86cc-6cba-0cbd-0e04-43711b4c9bc2@amd.com/

That reply was

"
Currently, SDW0 instance uses 3 TX, 3 RX  ports whereas SDW1 instance
uses 1 TX, 1 RX ports.

For SDW1 instance, It uses AUDIO1 register set as per our register spec.
We have mantained similar mapping convention here for enums as well.
"

It wouldn't hurt to add a comment in the code to remind the reviewer
that this is intentional and aligned with the hardware documentation.


>>> +static int acp63_sdw_dma_open(struct snd_soc_component *component,
>>> +			      struct snd_pcm_substream *substream)
>>> +{
>>> +	struct snd_pcm_runtime *runtime;
>>> +	struct acp_sdw_dma_stream *stream;
>>> +	struct snd_soc_dai *cpu_dai;
>>> +	struct amd_sdw_manager *amd_manager;
>>> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
>>> +	int ret;
>>> +
>>> +	runtime = substream->runtime;
>>> +	cpu_dai = asoc_rtd_to_cpu(prtd, 0);
>>> +	amd_manager = snd_soc_dai_get_drvdata(cpu_dai);
>>> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>>> +	if (!stream)
>>> +		return -ENOMEM;
>>> +
>>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>> +		runtime->hw = acp63_sdw_hardware_playback;
>>> +	else
>>> +		runtime->hw = acp63_sdw_hardware_capture;
>>> +	ret = snd_pcm_hw_constraint_integer(runtime,
>>> +					    SNDRV_PCM_HW_PARAM_PERIODS);
>>> +	if (ret < 0) {
>>> +		dev_err(component->dev, "set integer constraint failed\n");
>>> +		kfree(stream);
>>> +		return ret;
>>> +	}
>> it's not clear to me why you have to add this specific constraint, isn't
>> this checked already with the sdw_hardware_playback information.
> In above code, first we are assigning runtime->hw structures.
> As per our understanding, we are not assigning any hw_constraints.
> 
> This snd_pcm_hw_constraint_integer(runtime,
> SNDRV_PCM_HW_PARAM_PERIODS) constraint assures that the number
> of periods is integer, hence the buffer size is aligned with the period size.

This is surprising, I thought this was already ensured by the hw_info stuff?

>>> +static u64 acp63_sdw_get_byte_count(struct acp_sdw_dma_stream *stream, void __iomem *acp_base)
>>> +{
>>> +	union acp_sdw_dma_count byte_count;
>>> +	u32 pos_low_reg, pos_high_reg;
>>> +
>>> +	byte_count.bytescount = 0;
>>> +	switch (stream->instance) {
>>> +	case ACP_SDW0:
>>> +		pos_low_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>>> +		pos_high_reg = sdw0_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>>> +		break;
>>> +	case ACP_SDW1:
>>> +		pos_low_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_low_reg;
>>> +		pos_high_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>> returning -EINVAL as a u64 doesn't seem quite right to me?
> Agreed. Default case needs to be corrected. In case of invalid
> SDW instance, it should return default byte count which is zero
> instead of returning -EINVAL.
> 
> We have identified similar fix has to be implemented in our other
> dma driver as well.
> https://elixir.bootlin.com/linux/v6.4-rc6/source/sound/soc/amd/acp/amd.h#L174
> 
> Will push a supplement patch to fix it at one go.

ok
