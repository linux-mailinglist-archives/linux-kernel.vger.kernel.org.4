Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF15673CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjASOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjASOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:48:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51374971
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674139698; x=1705675698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j1RdAoD/wGl8iHKdRlcOQs9OkVUn7Q4Q+LreHOO1Lu0=;
  b=Ka3zwo5jpxxgtEr133L5Yf8ruTd6IiODsiuW25I6wgZ//HfkUTsV4vWJ
   ZDSAxYPwGpmHwXprayEXxshWKiAdSl8jgauI+wifS/Dmto8G+wHwvWPXY
   sPr6XoeHuNJ9J4vsaPKO/j6qXdpl/8Ab+dOtoXv6PY7iVsZGSuaWbOTJL
   +d9Txk8KDB6njUYEBXOATGmCIcn8wleQe4WF9we/anjObnZU6trylEcRZ
   ILV9pAsMDAEyvGec+z9Utxk0W3iWqkTbyFyWArpX5ADRFa9/ax7P27s00
   UiR5AjPteFeq169xPOZ2TQPRa7saK7udvd4yxiIoz4Ebk0NcpWwS96xHI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="305670168"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305670168"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:48:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="784082510"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="784082510"
Received: from sahamad-mobl1.amr.corp.intel.com (HELO [10.213.187.97]) ([10.213.187.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:48:15 -0800
Message-ID: <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
Date:   Thu, 19 Jan 2023 08:48:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static int cs42l42_sdw_dai_startup(struct snd_pcm_substream *substream,
>>> +                   struct snd_soc_dai *dai)
>>> +{
>>> +    struct cs42l42_private *cs42l42 =
>>> snd_soc_component_get_drvdata(dai->component);
>>> +
>>> +    if (!cs42l42->init_done)
>>> +        return -ENODEV;
>>
>> Can this happen? IIRC the ASoC framework would use
>> pm_runtime_resume_and_get() before .startup, which would guarantee that
>> the device is initialized, no?
>>
> 
> Yes, this can happen. Because of the way that the SoundWire enumeration
> was implemented in the core code, it isn't a probe event so we cannot
> call snd_soc_register_component() on enumeration because -EPROBE_DEFER
> wouldn't be handled. So the snd_soc_register_component() must be called
> from probe(). This leaves a limbo situation where we've registered the
> driver but in fact don't yet have any hardware. ALSA/ASoC doesn't know
> that we've registered before we are functional so they are happy to
> go ahead and try to use the soundcard. If for some reason the hardware
> failed to enumerate we can get here without having enumerated.

Humm, yes, but you've also made the regmap cache-only, so is there
really a problem?

FWIW I don't see a startup callback in any other codec driver. It may be
wrong but it's also a sign that this isn't a problem we've seen so far
on existing Intel-based platforms.

> 
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int cs42l42_sdw_dai_hw_params(struct snd_pcm_substream
>>> *substream,
>>> +                     struct snd_pcm_hw_params *params,
>>> +                     struct snd_soc_dai *dai)
>>> +{
>>> +    struct cs42l42_private *cs42l42 =
>>> snd_soc_component_get_drvdata(dai->component);
>>> +    struct sdw_stream_runtime *sdw_stream =
>>> snd_soc_dai_get_dma_data(dai, substream);
>>> +    struct sdw_stream_config stream_config = {0};
>>> +    struct sdw_port_config port_config = {0};
>>> +    int ret;
>>> +
>>> +    if (!sdw_stream)
>>> +        return -EINVAL;
>>> +
>>> +    /* Needed for PLL configuration when we are notified of new bus
>>> config */
>>> +    cs42l42->sample_rate = params_rate(params);
>>
>> wouldn't it be better to check if the sample_rate is supported by the
>> PLL here, instead of in the .prepare step ...
>>
> It depends on the soundwire bus clock. We need to know both to determine
> whether they are valid. IFF we can assume that the call to
> sdw_stream_add_slave() will always invoke the bus_config() callback we
> can call cs42l42_pll_config() from cs42l42_sdw_bus_config() and return
> an error from cs42l42_sdw_bus_config() if the {swire_clk, sample_rate}
> pair isn't valid.

You lost me here. Are you saying the soundwire bus clock is only known
in the prepare stage?


>>> +static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>> void *sdw_stream,
>>> +                      int direction)
>>> +{
>>> +    if (!sdw_stream)
>>> +        return 0;
>>> +
>>> +    if (direction == SNDRV_PCM_STREAM_PLAYBACK)
>>> +        dai->playback_dma_data = sdw_stream;
>>> +    else
>>> +        dai->capture_dma_data = sdw_stream;
>>> +
>>> +    return 0;
>>
>> Humm, this is interesting, you are not using the sdw_stream_data that
>> all other codecs use, but in hindsight I have no idea why we allocate
>> something to only store a pointer.
>>
> 
> Indeed. I can see no reason to wrap this pointer in another struct when
> we can store the pointer direct so I dropped the wrapper struct.

I'll see if we can simplify the other codec drivers.

>>> +static int cs42l42_sdw_update_status(struct sdw_slave *peripheral,
>>> +                     enum sdw_slave_status status);s
>>> +{
>>> +    struct cs42l42_private *cs42l42 =
>>> dev_get_drvdata(&peripheral->dev);
>>> +
>>> +    switch (status) {
>>> +    case SDW_SLAVE_ATTACHED:
>>> +        dev_dbg(cs42l42->dev, "ATTACHED\n");
>>> +        if (!cs42l42->init_done)
>>> +            cs42l42_sdw_init(peripheral);
>>
>> unclear to me what happens is the bus suspends, how would you redo the
>> init?
>>
> 
> We don't need to re-run the init(). A regcache_sync() will restore
> settings.

ah, interesting. Other codec drivers play with specific registers that
aren't in regmap. There's also headset calibration that's done
differently in the first init or later.
