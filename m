Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC214675E73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjATTzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:55:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB466197
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674244507; x=1705780507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BBdBbDkOeQZTC5ebPeDBvlm+1/6DpUsVVDUC9OEfcSM=;
  b=FMrzHqq0zIz3ul/kf9DWXfKW0bvHAzfJ4UNkm7s3nNll1Mp4+z+ermeL
   F4ryW98xeIjQ1I/qQ6pb5cv5ytzu9+2RMnJXjSsdwfxNvRTmZjLwxY6kD
   LYy4RseJFH430oFMyJVmjTSjFgQvgFHGDVwhO0Q9FbA+RHvu1/sQmaVoA
   L0IvqYcDY2BvGRJ5FM0Ebv+dk1AxvU6fnrnuftIg0m+3wor7azsf5Pdna
   cKCu4TvlNK8eZjTwovjUJXV07gpB2W9O6s+FEEuDFW6Y8nlU+XyCWM7hU
   h42VYKOyPDrRo99D0/Qkaf46TvY3wbKDz1qWipZqqvCLsfc86AR0fqIuN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="352933741"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="352933741"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:55:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="768800209"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="768800209"
Received: from gallegos-mobl1.amr.corp.intel.com (HELO [10.212.24.2]) ([10.212.24.2])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 11:55:01 -0800
Message-ID: <c8a9ff9b-d1d0-1cef-bf51-e7fa247d24f4@linux.intel.com>
Date:   Fri, 20 Jan 2023 13:55:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
 <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
 <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 09:35, Richard Fitzgerald wrote:
> On 19/1/23 14:48, Pierre-Louis Bossart wrote:
>>
>>>>> +static int cs42l42_sdw_dai_startup(struct snd_pcm_substream
>>>>> *substream,
>>>>> +                   struct snd_soc_dai *dai)
>>>>> +{
>>>>> +    struct cs42l42_private *cs42l42 =
>>>>> snd_soc_component_get_drvdata(dai->component);
>>>>> +
>>>>> +    if (!cs42l42->init_done)
>>>>> +        return -ENODEV;
>>>>
>>>> Can this happen? IIRC the ASoC framework would use
>>>> pm_runtime_resume_and_get() before .startup, which would guarantee that
>>>> the device is initialized, no?
>>>>
>>>
>>> Yes, this can happen. Because of the way that the SoundWire enumeration
>>> was implemented in the core code, it isn't a probe event so we cannot
>>> call snd_soc_register_component() on enumeration because -EPROBE_DEFER
>>> wouldn't be handled. So the snd_soc_register_component() must be called
>>> from probe(). This leaves a limbo situation where we've registered the
>>> driver but in fact don't yet have any hardware. ALSA/ASoC doesn't know
>>> that we've registered before we are functional so they are happy to
>>> go ahead and try to use the soundcard. If for some reason the hardware
>>> failed to enumerate we can get here without having enumerated.
>>
>> Humm, yes, but you've also made the regmap cache-only, so is there
>> really a problem?
>>
> 
> It's true that normally we go past these stages in cache-only, but that
> is because normally (non-Soundwire) we already initialized the hardware
> to good state during probe().
> If we just carry on when it hasn't enumerated and we haven't initialized
> it yet, who knows what will happen if it enumerates some time later.
> 
> We could just ignore it and see if anyone has a problem but for the sake
> of a couple of lines of code I feel like I'd rather check for it.
> 
>> FWIW I don't see a startup callback in any other codec driver. It may be
>> wrong but it's also a sign that this isn't a problem we've seen so far
>> on existing Intel-based platforms.
>>
> 
> It's nicer to do the check in startup() because then the application
> open() will fail cleanly. We could delay until prepare - which is the
> point we really need the hardware to be accessible - and hope the
> hardware enumerated and initialized by that time. But that's not so
> nice from the app point of view.

Another way to avoid problems is to rely on the codec component .probe
to check if the SoundWire device is initialized before registering a card.

I just tried with a system where the ACPI info exposes a codec which is
not connected, it fails nicely. That avoids the pitfalls of creating a
card which isn't functional since all dependencies are not met.

[   64.616530] snd_soc_sof_sdw:mc_probe: sof_sdw sof_sdw: Entry
[   64.616549] snd_soc_sof_sdw:log_quirks: sof_sdw sof_sdw: quirk
SOF_SDW_PCH_DMIC enabled
[   64.616559] snd_soc_sof_sdw:sof_card_dai_links_create: sof_sdw
sof_sdw: sdw 2, ssp 0, dmic 2, hdmi 0
[   64.616587] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
dai link SDW0-Playback, id 0
[   64.616600] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
dai link SDW0-Capture, id 1
[   64.616607] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
dai link dmic01, id 2
[   64.616614] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
dai link dmic16k, id 3
[   69.757115] rt5682 sdw:0:025d:5682:00: Initialization not complete,
timed out
[   69.757128] rt5682 sdw:0:025d:5682:00: ASoC: error at
snd_soc_component_probe on sdw:0:025d:5682:00: -110
[   69.757224] sof_sdw sof_sdw: ASoC: failed to instantiate card -110
[   69.757734] sof_sdw sof_sdw: snd_soc_register_card failed -110

see
https://elixir.bootlin.com/linux/latest/source/sound/soc/codecs/rt5682.c#L2927

I think this is compatible with the device model and bind/unbind, but it
could be improved with the removal of the wait if we had a way to return
-EPROBEDEFER, and have a mechanism to force the deferred probe work to
be triggered when a device actually shows up. It's a generic problem
that the probe cannot always be a synchronous function but may complete
'later'.
