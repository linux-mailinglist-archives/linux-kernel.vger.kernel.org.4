Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86C65EAD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjAEMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjAEMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:43:27 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD330A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:43:24 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8199EA0046;
        Thu,  5 Jan 2023 13:43:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8199EA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1672922601; bh=HPxVdaGm3p7dRKMlhONBaN84Inmu1RDW/L/BoIC8/iI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vwdFDrk8fgYYJLRFP5PICpuUdOuHtOU2b9kx+eRT/h80iu3rUtpAnb4V4JCLmMydh
         y75F/1z3RiU9SeY3raDq/q5TKPCagw10YjSOvS9jS+0IxPylCW2jmyNYOBfiXTBhhu
         zSkWvu+yceph7TzTUaA39TAGUwKBmjclCTiqUdmE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu,  5 Jan 2023 13:43:15 +0100 (CET)
Message-ID: <144a8a27-ac7a-6d3b-1744-26fe0806deee@perex.cz>
Date:   Thu, 5 Jan 2023 13:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ALSA: hda: Skip creating captures in SOF context
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     tiwai@suse.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220719144753.252231-1-kai.heng.feng@canonical.com>
 <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz>
 <CAAd53p6ru7CJ=pJ2knCL5pgU_Y+nA=yTPscKk225zTD-fv4qQg@mail.gmail.com>
 <34bddb2f-dc57-c08c-358e-26cf7824c203@perex.cz>
 <514f0fda-9475-e163-fd64-0bc675dd3447@linux.intel.com>
 <CAAd53p5xkjKkpvZu2nNu5EaJC9d060g5GAhV_gRD2ouGjKY9AQ@mail.gmail.com>
 <CAAd53p4Jcfo1_jsCd98_HxzkfqhUxS_7h7vM5a2dcK4fRYS1RA@mail.gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <CAAd53p4Jcfo1_jsCd98_HxzkfqhUxS_7h7vM5a2dcK4fRYS1RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 01. 23 13:36, Kai-Heng Feng wrote:
> On Mon, Aug 15, 2022 at 3:55 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> On Wed, Jul 20, 2022 at 9:31 PM Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 7/20/22 02:52, Jaroslav Kysela wrote:
>>>> Dne 20. 07. 22 v 3:45 Kai-Heng Feng napsal(a):
>>>>> On Tue, Jul 19, 2022 at 11:41 PM Jaroslav Kysela <perex@perex.cz> wrote:
>>>>>>
>>>>>> Dne 19. 07. 22 v 16:47 Kai-Heng Feng napsal(a):
>>>>>>> On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
>>>>>>> light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
>>>>>>> topology: use new sound control LED layer").
>>>>>>>
>>>>>>> The micmute LED itself is still working via sysfs, but it doesn't follow
>>>>>>> mute anymore. That's because unlike vendors like Dell and Lenovo, HP
>>>>>>> laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
>>>>>>> laptops, both SOF and HDA create captures with
>>>>>>> SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
>>>>>>> there are two different kcontrols and one of them is not muted.
>>>>>>
>>>>>> It does not mean that it's a wrong behavior. When both controls are muted, the
>>>>>> LED should be turned on. It just requires that all inputs are off (and it may
>>>>>> be the default - probably we can set in UCM or so). If you turn the "Capture
>>>>>> Switch" off in amixer / alsamixer, do things work as expected ?
>>>>>
>>>>> Yes. When all captures are muted the micmute LED is on.
>>>>>
>>>>>>
>>>>>>> So skip creating captures for HDA when it's called from SOF, the
>>>>>>> captures are already handled by SOF.
>>>>>>
>>>>>> The capture controls are for other inputs like external analog microphone. If
>>>>>> it is required to suppress the MIC LED for some hardware, just skip the
>>>>>> "spec->mic_mute_led = 1" assignment in hda_generic.c . Also, the check
>>>>>> "codec->core.type != HDA_DEV_ASOC" is not sufficient, because you don't know,
>>>>>> if the topology really sets the MIC LED flag.
>>>>>
>>>>> AFAIK the external analog microphone on DMIC laptop is driven by SOF driver too.
>>>>> If those capture controls are indeed needed for external analog mics,
>>>>> use UCM to mute them by default won't work either.
>>>>
>>>> Could you describe this ? I though that only DMIC is handled by SOF when HDA
>>>> codec is in the system. There is a separate analog codec for external analog
>>>> microphone or the HDA codec is somehow connected to SOF/DSP ? If so, how ?
>>>
>>> The HDA codec is connected in the same way in all cases, there's no
>>> hardware/electrical/routing difference.
>>>
>>> When used, the SOF driver will handle ALL links, be they DMIC or
>>> HDAudio. The difference for HDaudio is that instead of a single DMA
>>> transfer (DDR->FIFO), we have a first 'Host' DMA into the DSP SRAM, some
>>> processing and a second 'Link' DMA from DSP SRAM to the HDaudio FIFO
>>> (reversed flow for capture).
>>
>> So is this approach sufficient for this issue? Or should I explore
>> other possibilities?
> 
> A gentle ping...

This Mic LED problem was resolved through UCM for the moment:

https://github.com/alsa-project/alsa-ucm-conf/commit/79a8ec44d3dcf097f4a4492c506cbcf338324175

More discussion:

https://bugzilla.redhat.com/show_bug.cgi?id=2134824

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
