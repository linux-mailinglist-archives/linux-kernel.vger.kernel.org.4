Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4865F56AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJEOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJEOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:47:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553887822A;
        Wed,  5 Oct 2022 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664981246; x=1696517246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dNQBsbtOaMCABt+PbDrwoClydLLiJCNOgq0glzVcLcs=;
  b=DoWiCKfYJLDo9rOZCVhI8KFcFxjPBx/Pg3wV4eDZcnatebYyKVGYg31w
   I5PO+3ctrIOFJU/uXubTSBww4MrYpZKCofQ8CVW9Bn5mG1qIl36xh4JCF
   Cab3TV0Dwj0iZeH/gte0RcQRZATKW8TsP8zN9I0lzHhcK2TpSB7JijK9O
   NoohXZkAnOC0l3uOBy+LiRP+Jk3p2lsCMrmTYzPaYwFnS8TFFaK1TWbeo
   PhKOjm578N0KIjIMAJrquYFHQvCLx3Nu49VmLOnd/z/iXNj936mQcKNYJ
   oS73ut92oA0yxABFpNl+VvnQ7zo05uThL7P7++Y0bEr5A4EQaQoIpPSAw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="282891911"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="282891911"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:47:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="766747457"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="766747457"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.167]) ([10.99.241.167])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:47:23 -0700
Message-ID: <cd3918c8-64c2-fc8f-c184-3fec3ae01e3c@linux.intel.com>
Date:   Wed, 5 Oct 2022 16:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use
 macros
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Mohan Kumar D <mkumard@nvidia.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
 <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
 <657d2418-0c3e-296f-8f4a-dc10ced2dffe@nvidia.com>
 <87a66av4gk.wl-tiwai@suse.de>
 <9677f39a-5297-bb1c-d4e3-62484ec1cf25@nvidia.com>
 <87lepugy85.wl-tiwai@suse.de>
 <d2772c7b-bea9-e3bd-3b6b-c657566649d8@nvidia.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <d2772c7b-bea9-e3bd-3b6b-c657566649d8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2022 4:26 PM, Jon Hunter wrote:
> 
> 
> On 05/10/2022 15:07, Takashi Iwai wrote:
>> On Wed, 05 Oct 2022 15:52:01 +0200,
>> Jon Hunter wrote:
>>>
>>>
>>> On 05/10/2022 13:29, Takashi Iwai wrote:
>>>
>>> ...
>>>
>>>>> HDA playback is failing on -next for various Tegra boards. Bisect is
>>>>> point to this commit and reverting it fixes the problem. I was a bit
>>>>> puzzled why this change is causing a problem, but looking closer there
>>>>> is a difference between the previous code that was calling
>>>>> snd_hdac_stream_readb() and the new code that is calling
>>>>> snd_hdac_stream_readb_poll(). The function snd_hdac_stream_readb()
>>>>> calls snd_hdac_aligned_mmio() is see if the device has an aligned MMIO
>>>>> which Tegra does and then would call snd_hdac_aligned_read(). However,
>>>>> now the code always call readb() and this is breaking Tegra.
>>>>>
>>>>> So it is either necessary to update snd_hdac_stream_readb_poll() to
>>>>> handle this or revert this change.
>>>>
>>>> Does the patch below work?
>>>>
>>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>>
>>>> -- 8< --
>>>> --- a/include/sound/hdaudio.h
>>>> +++ b/include/sound/hdaudio.h
>>>> @@ -592,8 +592,8 @@ int snd_hdac_get_stream_stripe_ctl(struct 
>>>> hdac_bus *bus,
>>>>    #define snd_hdac_stream_readb(dev, reg) \
>>>>        snd_hdac_reg_readb((dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
>>>>    #define snd_hdac_stream_readb_poll(dev, reg, val, cond, delay_us, 
>>>> timeout_us) \
>>>> -    readb_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
>>>> -               delay_us, timeout_us)
>>>> +    read_poll_timeout(snd_hdac_reg_readb, val, cond, delay_us, 
>>>> timeout_us,\
>>>> +              false, (dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
>>>>    #define snd_hdac_stream_readl_poll(dev, reg, val, cond, delay_us, 
>>>> timeout_us) \
>>>>        readl_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, 
>>>> cond, \
>>>>                   delay_us, timeout_us)
>>>
>>>
>>> Amazingly it does not work. I would have thought that would, but it
>>> does not. I am a bit puzzled by that?
>>
>> Interesting, it must be a subtle difference.
>> What about passing true?  It seems that the original code has the
>> udelay(3) before the loop.
> 
> 
> I wondered the same and tried that, but still not working.
> 
> Jon
> 

Well in worse case we can revert the patch in question, but I would like 
to get it working...

Maybe also try to raise timeout to 1000, as what original code called 
timeout, was actually number of retries? So 300 * udelay(3) which is 
more or less 900us, so we can round it up for test?

I mean, something like:

--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -176,7 +176,7 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
         snd_hdac_stream_updateb(azx_dev, SD_CTL, 0, SD_CTL_STREAM_RESET);

         /* wait for hardware to report that the stream entered reset */
-       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & 
SD_CTL_STREAM_RESET), 3, 300);
+       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & 
SD_CTL_STREAM_RESET), 3, 1000);

         if (azx_dev->bus->dma_stop_delay && dma_run_state)
                 udelay(azx_dev->bus->dma_stop_delay);
@@ -184,7 +184,7 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
         snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_CTL_STREAM_RESET, 0);

         /* wait for hardware to report that the stream is out of reset */
-       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & 
SD_CTL_STREAM_RESET), 3, 300);
+       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & 
SD_CTL_STREAM_RESET), 3, 1000);

         /* reset first position - may not be synced with hw at this time */
         if (azx_dev->posbuf)


in addition to Takashi suggestion?

