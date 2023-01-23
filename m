Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91B678152
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAWQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjAWQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:25:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F355EFA7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674491142; x=1706027142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5F+pTXbbpk7pf7RgZ9qcmjhgtU0br58EY++sDU2Qxrg=;
  b=R+O2Q+fkgi6lZANnpI66s4cNBM0VHIdPu073n4j3+HNwRRpD4rg5MuB5
   KNtXhXk4Hm7RvF5g2NieJf4Y4mvuNkNtPM6Bti4ZyMx6OGVc+E3YWI0fO
   bW/nYWpXJHcbTpxV65Kb3dqlZIOu7PXdMctQ2RKwzXPCtsFcgEe2AbRlB
   QbliXTIedwlQ0h869TNLUpKjIW2o8qcPNrgpCY3XwVpsNK7a7FyXPdWfU
   Xipz14/5grl+QatcUW5aV3nGKPNaG7AzUjo6HnSxwYPTYTlBQUERi1vuB
   6epNwOKKDIsMNg1IDz69DbbgroOCsRgWetq8G66IaLUk7qCozHkIRU/37
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="306436788"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="306436788"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:25:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663694296"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663694296"
Received: from rgrachek-mobl.amr.corp.intel.com (HELO [10.212.113.123]) ([10.212.113.123])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:25:07 -0800
Message-ID: <427f4e8a-51a5-7a4b-c2c6-92bc98f6db87@linux.intel.com>
Date:   Mon, 23 Jan 2023 10:25:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
 <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
 <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
 <c8a9ff9b-d1d0-1cef-bf51-e7fa247d24f4@linux.intel.com>
 <3bac8055-2e6e-dc53-d143-f493e18a1e43@opensource.cirrus.com>
 <a54bf135-70ba-4c8f-b373-690a9ad8e7ef@linux.intel.com>
 <d77636dc-f239-9780-edca-fa568582c05f@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d77636dc-f239-9780-edca-fa568582c05f@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/23 10:14, Richard Fitzgerald wrote:
> On 23/01/2023 16:05, Pierre-Louis Bossart wrote:
>>
>>>>> It's nicer to do the check in startup() because then the application
>>>>> open() will fail cleanly. We could delay until prepare - which is the
>>>>> point we really need the hardware to be accessible - and hope the
>>>>> hardware enumerated and initialized by that time. But that's not so
>>>>> nice from the app point of view.
>>>>
>>>> Another way to avoid problems is to rely on the codec component .probe
>>>> to check if the SoundWire device is initialized before registering a
>>>> card.
>>>>
>>>> I just tried with a system where the ACPI info exposes a codec which is
>>>> not connected, it fails nicely. That avoids the pitfalls of creating a
>>>> card which isn't functional since all dependencies are not met.
>>>>
>>>> [   64.616530] snd_soc_sof_sdw:mc_probe: sof_sdw sof_sdw: Entry
>>>> [   64.616549] snd_soc_sof_sdw:log_quirks: sof_sdw sof_sdw: quirk
>>>> SOF_SDW_PCH_DMIC enabled
>>>> [   64.616559] snd_soc_sof_sdw:sof_card_dai_links_create: sof_sdw
>>>> sof_sdw: sdw 2, ssp 0, dmic 2, hdmi 0
>>>> [   64.616587] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
>>>> dai link SDW0-Playback, id 0
>>>> [   64.616600] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
>>>> dai link SDW0-Capture, id 1
>>>> [   64.616607] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
>>>> dai link dmic01, id 2
>>>> [   64.616614] snd_soc_sof_sdw:init_dai_link: sof_sdw sof_sdw: create
>>>> dai link dmic16k, id 3
>>>> [   69.757115] rt5682 sdw:0:025d:5682:00: Initialization not complete,
>>>> timed out
>>>> [   69.757128] rt5682 sdw:0:025d:5682:00: ASoC: error at
>>>> snd_soc_component_probe on sdw:0:025d:5682:00: -110
>>>> [   69.757224] sof_sdw sof_sdw: ASoC: failed to instantiate card -110
>>>> [   69.757734] sof_sdw sof_sdw: snd_soc_register_card failed -110
>>>>
>>>> see
>>>> https://elixir.bootlin.com/linux/latest/source/sound/soc/codecs/rt5682.c#L2927
>>>>
>>>> I think this is compatible with the device model and bind/unbind,
>>>> but it
>>>> could be improved with the removal of the wait if we had a way to
>>>> return
>>>> -EPROBEDEFER, and have a mechanism to force the deferred probe work to
>>>> be triggered when a device actually shows up. It's a generic problem
>>>> that the probe cannot always be a synchronous function but may complete
>>>> 'later'.
>>>
>>> I see what you've done in your patch, but I had already experimented
>>> with this idea and found that the wait_for_completion() can deadlock the
>>> Soundwire core.
>>
>> That's not good. Do you have any logs or explanation on what the
>> root-cause of this deadlock might be? If something's broken, we might as
>> well fix it.
> 
> I suspect it might be the big mutex lock around the call to probe(),
> that I removed in one of my pending patches
> (https://lore.kernel.org/all/20221121162453.1834170-1-rf@opensource.cirrus.com/)
> So fixing that might make the problem go away.
> 
> Charles just pointed out to me that whether component_probe() is
> called within probe() depends whether everything needed to create
> a soundcard is already present. Most likely in my case everything is
> available and so snd_soc_register_component() immediately calls
> my component_probe(). So probably in your case not everything is
> ready and so the call to component_probe() is deferred and you
> don't see the deadlock.

In the case I tested, the codec driver was probed based on the presence
of ACPI information and the register component did happen. That means
all the resources were present for the card to be created, except that
the codec hardware was not connected to the bus so the initialization
never happened of course.
