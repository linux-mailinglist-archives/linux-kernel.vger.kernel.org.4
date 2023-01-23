Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F7678089
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjAWPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjAWPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:52:17 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A8315C97
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:52:13 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NAP6Bl007057;
        Mon, 23 Jan 2023 09:52:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=x8YZYbFXKQdJmtjeXHiiDUFDCMx5y/NeokwBWsFHCoI=;
 b=YAcH2adVlyr/VgPnG8Kz0KAZ0YstIh9M/k9gAznLBWnVSeS3+CYux5xydithWgC7m0dT
 t25c0a/HHtkQCzWsMUdYF25ZWrQjsYi2vBt/GERBWVo4Z9SIKZXtwYUU0xDPgO9+6aEl
 rJDdRddBFsggedxuVGxIXsrmdwSRYVO57hf4a3fk9965tLTxw/HKExNUOjOPgdw21HK3
 SQasZzaSTEsETt5+/ueuVADXq9V0aYE49qwPec1AWB+DomgXegcCCBBtTlks3gP6/pOc
 wD+cYQdFlco9O9JhSOJtQXdmN4lF/jgQhcS+uA1QzA+uuH0SHQ2TqgV1r4X4IhEfyQ0D 8Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n8eb5u8xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 09:52:01 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 23 Jan
 2023 09:51:58 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 23 Jan 2023 09:51:58 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CDCC82C5;
        Mon, 23 Jan 2023 15:51:58 +0000 (UTC)
Message-ID: <3bac8055-2e6e-dc53-d143-f493e18a1e43@opensource.cirrus.com>
Date:   Mon, 23 Jan 2023 15:51:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
 <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
 <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
 <c8a9ff9b-d1d0-1cef-bf51-e7fa247d24f4@linux.intel.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c8a9ff9b-d1d0-1cef-bf51-e7fa247d24f4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eTmgLWr3qZwZqY69Pxe4xrHLTHPKQhmP
X-Proofpoint-ORIG-GUID: eTmgLWr3qZwZqY69Pxe4xrHLTHPKQhmP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 19:55, Pierre-Louis Bossart wrote:
> 
> 
> On 1/19/23 09:35, Richard Fitzgerald wrote:
>> On 19/1/23 14:48, Pierre-Louis Bossart wrote:
>>>
>>>>>> +static int cs42l42_sdw_dai_startup(struct snd_pcm_substream
>>>>>> *substream,
>>>>>> +                   struct snd_soc_dai *dai)
>>>>>> +{
>>>>>> +    struct cs42l42_private *cs42l42 =
>>>>>> snd_soc_component_get_drvdata(dai->component);
>>>>>> +
>>>>>> +    if (!cs42l42->init_done)
>>>>>> +        return -ENODEV;
>>>>>
>>>>> Can this happen? IIRC the ASoC framework would use
>>>>> pm_runtime_resume_and_get() before .startup, which would guarantee that
>>>>> the device is initialized, no?
>>>>>
>>>>
>>>> Yes, this can happen. Because of the way that the SoundWire enumeration
>>>> was implemented in the core code, it isn't a probe event so we cannot
>>>> call snd_soc_register_component() on enumeration because -EPROBE_DEFER
>>>> wouldn't be handled. So the snd_soc_register_component() must be called
>>>> from probe(). This leaves a limbo situation where we've registered the
>>>> driver but in fact don't yet have any hardware. ALSA/ASoC doesn't know
>>>> that we've registered before we are functional so they are happy to
>>>> go ahead and try to use the soundcard. If for some reason the hardware
>>>> failed to enumerate we can get here without having enumerated.
>>>
>>> Humm, yes, but you've also made the regmap cache-only, so is there
>>> really a problem?
>>>
>>
>> It's true that normally we go past these stages in cache-only, but that
>> is because normally (non-Soundwire) we already initialized the hardware
>> to good state during probe().
>> If we just carry on when it hasn't enumerated and we haven't initialized
>> it yet, who knows what will happen if it enumerates some time later.
>>
>> We could just ignore it and see if anyone has a problem but for the sake
>> of a couple of lines of code I feel like I'd rather check for it.
>>
>>> FWIW I don't see a startup callback in any other codec driver. It may be
>>> wrong but it's also a sign that this isn't a problem we've seen so far
>>> on existing Intel-based platforms.
>>>
>>
>> It's nicer to do the check in startup() because then the application
>> open() will fail cleanly. We could delay until prepare - which is the
>> point we really need the hardware to be accessible - and hope the
>> hardware enumerated and initialized by that time. But that's not so
>> nice from the app point of view.
> 
> Another way to avoid problems is to rely on the codec component .probe
> to check if the SoundWire device is initialized before registering a card.
> 
> I just tried with a system where the ACPI info exposes a codec which is
> not connected, it fails nicely. That avoids the pitfalls of creating a
> card which isn't functional since all dependencies are not met.
> 
> [   64.616530] snd_soc_sof_sdw:mc_probe: sof_sdw sof_sdw: Entry
> [   64.616549] snd_soc_sof_sdw:log_quirks: sof_sdw sof_sdw: quirk
> SOF_SDW_PCH_DMIC enabled
> [   64.616559] snd_soc_sof_sdw:sof_card_dai_links_create: sof_sdw
> sof_sdw: sdw 2, ssp 0, dmic 2, hdmi 0
> [   64.616587] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
> dai link SDW0-Playback, id 0
> [   64.616600] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
> dai link SDW0-Capture, id 1
> [   64.616607] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
> dai link dmic01, id 2
> [   64.616614] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
> dai link dmic16k, id 3
> [   69.757115] rt5682 sdw:0:025d:5682:00: Initialization not complete,
> timed out
> [   69.757128] rt5682 sdw:0:025d:5682:00: ASoC: error at
> snd_soc_component_probe on sdw:0:025d:5682:00: -110
> [   69.757224] sof_sdw sof_sdw: ASoC: failed to instantiate card -110
> [   69.757734] sof_sdw sof_sdw: snd_soc_register_card failed -110
> 
> see
> https://elixir.bootlin.com/linux/latest/source/sound/soc/codecs/rt5682.c#L2927
> 
> I think this is compatible with the device model and bind/unbind, but it
> could be improved with the removal of the wait if we had a way to return
> -EPROBEDEFER, and have a mechanism to force the deferred probe work to
> be triggered when a device actually shows up. It's a generic problem
> that the probe cannot always be a synchronous function but may complete
> 'later'.

I see what you've done in your patch, but I had already experimented
with this idea and found that the wait_for_completion() can deadlock the
Soundwire core.
