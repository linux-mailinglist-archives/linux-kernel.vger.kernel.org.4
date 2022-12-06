Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E55644818
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiLFPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiLFPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:34:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483EF2CE15
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670340852; x=1701876852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QCUoX14tfclkO5GylbtI8GdrNBAy8EpB3v8UADUVB/8=;
  b=IJt1arGqmUl+WDQzTSE6YggTXeZ/KYCANfwQvlUs+cCLKQXy0sesazyd
   TRiBCF4JY3NXiYycEL+tO1vVSdIACqStRMsm+8CKOLzWkX3c6ZqerHPtE
   zmWc/DKua9pLRE5gweaYFePF0Vv6P3I4kEP1bRgj8J/JHtHt1jAmdGZ63
   87jzx77C5oLkUUdBzXNuL50p2addZrDFiXmZsWwtjuarvwi/JG4c5m9t0
   HZIxvVYgJYrL876h4Jyq7bdYF2D0pPerQp3+DmTZ2Rw9rDw0cnUi13FjU
   VB9Ui5oUkT18WqgFKhvOcDfgammsem5AIIIQCiXtIAgxBhbdp54J1iFIq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315362203"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="315362203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 07:34:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="770760262"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="770760262"
Received: from cjian12x-mobl.amr.corp.intel.com (HELO [10.212.125.207]) ([10.212.125.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 07:34:10 -0800
Message-ID: <186a5111-617d-c8f0-ba7e-1f39663c65dd@linux.intel.com>
Date:   Tue, 6 Dec 2022 09:34:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] ALSA: compress: Add AC3, EAC3, TrueHD, DTS, MPEG-H 3D
 Audio Stream (MHAS)
Content-Language: en-US
To:     Carlos Rafael Giani <crg7475@mailbox.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221206145317.99934-1-crg7475@mailbox.org>
 <d6da4f2f-d6d8-bab6-66f0-a4b2486d1922@linux.intel.com>
 <cdee3f7d-3f98-02dc-9fc6-18ffc489c6f8@mailbox.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <cdee3f7d-3f98-02dc-9fc6-18ffc489c6f8@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/22 09:16, Carlos Rafael Giani wrote:
> IEC61937 is quite commonly used, yes. However, I have been working with
> a commercial system that is getting support for these formats
> implemented via compress-offload. Since these formats aren't exactly
> uncommon, I figured that adding these could be useful, especially since
> only the #defines need to be added, nothing else.

please don't top-post on mailing lists.

Nothing else? That sounds to good to be true. Specifically for
spatialization, there's got to be some sort of interface to control
where the objects are located, either in reference to the listener
position or the listening room setup.

The compressed API was developed back in the early 2010s for elementary
streams, it's not been extended since and IMHO it's far too limited to
support Atmos and newer systems optimally.

> On 06.12.22 16:07, Pierre-Louis Bossart wrote:
>>
>> On 12/6/22 08:53, Carlos Rafael Giani wrote:
>>> These audio codecs are used in sound bars and digital TVs, and benefit
>>> from off-loading to a DSP. In particular, Dolby Atmos and MPEG-H 3D
>>> audio
>>> spatialization is done in dedicated DSPs. Thus, adding these codecs  to
>>> the Compress-Offload API makes sense.
>> The question is "how is the stream transported". In most implementations
>> for these formats, the DSP is on the receiver side and the transport
>> happens with an IEC61937 format - which does not require the use of the
>> compressed API.
>>
>>> Signed-off-by: Carlos Rafael Giani <crg7475@mailbox.org>
>>> ---
>>>   include/uapi/sound/compress_params.h | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/sound/compress_params.h
>>> b/include/uapi/sound/compress_params.h
>>> index ddc77322d571..7a58e2026be3 100644
>>> --- a/include/uapi/sound/compress_params.h
>>> +++ b/include/uapi/sound/compress_params.h
>>> @@ -43,7 +43,13 @@
>>>   #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>>>   #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>>>   #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
>>> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
>>> +#define SND_AUDIOCODEC_AC3                   ((__u32) 0x00000011)
>>> +#define SND_AUDIOCODEC_EAC3                  ((__u32) 0x00000012)
>>> +#define SND_AUDIOCODEC_TRUEHD                ((__u32) 0x00000013)
>>> +#define SND_AUDIOCODEC_DTS                   ((__u32) 0x00000014)
>> IIRC there are multiple flavors of DTS, off the top of my head DTS-ES,
>> 96, HD, Master Audio. "DTS" only doesn't even begin to describe the
>> possible variants.

And IIRC2 there is some level of backwards compatibility between
flavors, but the decoder may or may not be able to generate the number
of channels and formats supported in the initial stream. That's a
problem if you need to configure audio codecs or interfaces and the DSP
doesn't tell you what it decoded or upmixed.

>>> +/* MPEG-H 3D Audio Stream (MHAS) as defined in ISO/IEC 23008-3 */
>>> +#define SND_AUDIOCODEC_MHAS                  ((__u32) 0x00000015)
>> Doesn't this need the definition of profiles and various types of
>> formats - classic problem with designed-by-committee MPEG codecs.
>>
>>> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_MHAS
>>
>>>   /*
>>>    * Profile and modes are listed with bit masks. This allows for a
