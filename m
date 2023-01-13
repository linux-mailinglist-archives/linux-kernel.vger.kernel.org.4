Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4366A2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjAMT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjAMT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:27:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D787F25
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673638067; x=1705174067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NoSp4Yj8rM26hkY4skqXoBTM3TREEhqDQjQrCdEQ3rw=;
  b=LP//0Lr4G5WKAZh+B/Pf+GpoYk9t8marGe0Jq7NahEK5Knl5D5dFOxhr
   9wGgh8fCM0MVizG5WIAYICjJUdfyEz+6tVQeNYoYpG8oVjyjDI7MXVF6K
   90UayqjRLG4Avr3vmgHEos7e4Km6OJg9XgiCn+TCHf84ZhoTCzuSOBQR1
   QZ9CWoYStP+nACRPQ+UMZfcpeos02tvTEI38w60fyA6DHVtssBIbzVdlO
   XnXCMn+8eYKUWktRP77cqtXhcJ2CJ6LEir2luXkiW4r6IQMSuEqCMS7LA
   4OFZkDKPrFDAnTmoh/01bj9j1SohkFdt/n9lS8RSdZXCNT4DPvE+SaTpd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322777183"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322777183"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608257437"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608257437"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:44 -0800
Message-ID: <3bb2114c-cd0c-f176-c837-90a665a25343@linux.intel.com>
Date:   Fri, 13 Jan 2023 11:05:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 08/19] ASoC: amd: ps: add soundwire dma driver dma ops
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
 <77e35f54-323e-42d0-9e74-be984eebc0fe@linux.intel.com>
 <6bb9b13c-2829-d7c3-872b-6e9586189300@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <6bb9b13c-2829-d7c3-872b-6e9586189300@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +	sdw_data->sdw_stream[stream_id] = substream;
>>> +	size = params_buffer_bytes(params);
>>> +	period_bytes = params_period_bytes(params);
>>> +	sdw_stream_data->dma_addr = substream->runtime->dma_addr;
>>> +	sdw_stream_data->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
>>> +	acp63_config_dma(sdw_stream_data, stream_id);
>>> +	ret = acp63_configure_sdw_ringbuffer(sdw_stream_data->acp_base, stream_id, size);
>>> +	if (ret) {
>>> +		dev_err(component->dev, "Invalid channel type\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	switch (stream_id) {
>>> +	case ACP_SDW_AUDIO_TX:
>>> +		water_mark_size_reg = ACP_AUDIO_TX_INTR_WATERMARK_SIZE;
>>> +		irq_mask = BIT(ACP_AUDIO_TX_THRESHOLD);
>>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>>> +		break;
>> so there's ONE resource to deal with external codecs? How does this work
>> if you have a headset codec and an amplifier?
> Are you referring to playing a same stream over headset codec and
> amplifier?
> It's all about channel selection from DMA perspective.
> We have tested speaker aggregation and headset playback use cases.

No, I wasn't asking about playing the same content to different sinks.

I was referring to playing/recording different content to/from different
devices.

Even when interfacing with a single device, there are interesting
topologies in the SDCA spec that would require multiple DMA transfers
conveying unrelated content (or processed content from the same source).

