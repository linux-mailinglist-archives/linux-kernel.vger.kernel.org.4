Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47DC737E84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFUJQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjFUJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:16:25 -0400
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 02:16:18 PDT
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3DD1B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:16:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 9233E3FA9A;
        Wed, 21 Jun 2023 11:06:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.201
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n0VbiRymwsKG; Wed, 21 Jun 2023 11:06:58 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 5645E3FA67;
        Wed, 21 Jun 2023 11:06:57 +0200 (CEST)
Received: from [192.168.0.209] (unknown [134.191.232.81])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 16B553631FE;
        Wed, 21 Jun 2023 11:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1687338416; bh=ASHe5V5zHsS9gHNX0/ImqDfplWNdOYDmwlVBv/l+V5U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ahm6S886OmI+vdOHzg4L1cVK8vLVBmZrhYjLIAVqt3PSzQ7efHi5TZbOv1o6fOGFV
         2QL6tStvv7uVzKKraE4pgvthvBHSjKSVEGuWxmvUsDRqhwihq6A+AHkjh4vUF6Mg0v
         ifVIyJshfIiyBrsM4Zf+yPpecBRw/RHJlDYiA9aY=
Message-ID: <79e1f37f-3ffa-0195-860b-08cc890d810e@shipmail.org>
Date:   Wed, 21 Jun 2023 11:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v2] drm/i915: Replace kmap() with kmap_local_page()
Content-Language: en-US
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
References: <20230620180759.GA419158@sumitra.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
In-Reply-To: <20230620180759.GA419158@sumitra.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/23 20:07, Sumitra Sharma wrote:
> On Tue, Jun 20, 2023 at 06:23:38AM -0700, Ira Weiny wrote:
>> Sumitra Sharma wrote:
>>> On Sun, Jun 18, 2023 at 11:11:08AM -0700, Ira Weiny wrote:
>>>> Sumitra Sharma wrote:
>>>>> kmap() has been deprecated in favor of the kmap_local_page()
>>>>> due to high cost, restricted mapping space, the overhead of a
>>>>> global lock for synchronization, and making the process sleep
>>>>> in the absence of free slots.
>>>>>
>>>>> kmap_local_page() is faster than kmap() and offers thread-local
>>>>> and CPU-local mappings, take pagefaults in a local kmap region
>>>>> and preserves preemption by saving the mappings of outgoing tasks
>>>>> and restoring those of the incoming one during a context switch.
>>>>>
>>>>> The mapping is kept thread local in the function
>>>>> “i915_vma_coredump_create” in i915_gpu_error.c
>>>>>
>>>>> Therefore, replace kmap() with kmap_local_page().
>>>>>
>>>>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>>>>>
>>>> NIT: No need for the line break between Suggested-by and your signed off line.
>>>>
>>> Hi Ira,
>>>
>>> What does NIT stand for?
>> Shorthand for 'nitpicking'.
>>
>> "giving too much attention to details that are not important, especially
>> as a way of criticizing: "
>>
>> 	- https://dictionary.cambridge.org/dictionary/english/nitpicking
>>
>> Via email this is a way for authors of an email to indicate something is
>> technically wrong but while nicely acknowledging that it is not very
>> significant and could be seen as overly critical.
>>
>> For this particular comment I'm showing something to pay attention to next
>> time but that was not a big deal this time around.
>>
> Hi Ira,
>
> Thank for your explanation on NIT.
>
>
>>> Thank you. I will take care about the line breaks.
>>>
>>>>> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> 	- Replace kmap() with kmap_local_page().
>>>> Generally it is customary to attribute a change like this to those who
>>>> suggested it in a V1 review.
>>>>
>>>> For example:
>>>>
>>>>   	- Tvrtko/Thomas: Use kmap_local_page() instead of page_address()
>>>>
>>>> Also I don't see Thomas on the new email list.  Since he took the time to
>>>> review V1 he might want to check this version out.  I've added him to the
>>>> 'To:' list.
>>>>
>>>> Also a link to V1 is nice.  B4 formats it like this:
>>>>
>>>> - Link to v1: https://lore.kernel.org/all/20230614123556.GA381200@sumitra.com/
>>>>
>>>> All that said the code looks good to me.  So with the above changes.
>>>>
>>>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>>>
>>> I have noted down the points mentioned above. Thank you again.
>>>
>>> I am not supposed to create another version of this patch for
>>> adding the above mentions, as you and Thomas both gave this patch
>>> a reviewed-by tag. Right?
>>>
>> Based on this response[*] from Tvrtko I think this version can move
>> through without a v3.
> Okay!
>
>
> Thanks & regards
> Sumitra

I think one thing worth mentioning in the context of this patch is that 
IIRC kmap_local_page() will block offlining of the mapping CPU until 
kunmap_local(), so while I haven't seen any guidelines around the usage 
of this api for long-held mappings, I figure it's wise to keep the 
mapping duration short, or at least avoid sleeping with a 
kmap_local_page() map active.

I figured, while page compression is probably to be considered "slow" 
it's probably not slow enough to motivate kmap() instead of 
kmap_local_page(), but if anyone feels differently, perhaps it should be 
considered.

With that said, my Reviewed-by: still stands.

/Thomas

>
>> Thanks!
>> Ira
>>
>> [*] https://lore.kernel.org/all/bcb0a1d2-cd4d-a56f-1ee6-7ccfdd2f7b38@linux.intel.com/
>>
>> <quote>
>> Thanks all! I'll just re-send the patch for our CI, since it didn't get
>> picked up automatically (stuck in moderation perhaps), with all r-b tags
>> added and extra line space removed and merge it if results will be green.
>>
>> Regards,
>>
>> Tvrtko
>> </quote>
>>
>>
>>> Thanks & regards
>>> Sumitra
>>>
>>> PS: I am new to the open source vocabulary terms.
>>>
>>>>> 	- Change commit subject and message.
>>>>>
>>>>>   drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
>>>>> index f020c0086fbc..bc41500eedf5 100644
>>>>> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
>>>>> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
>>>>> @@ -1164,9 +1164,9 @@ i915_vma_coredump_create(const struct intel_gt *gt,
>>>>>   
>>>>>   			drm_clflush_pages(&page, 1);
>>>>>   
>>>>> -			s = kmap(page);
>>>>> +			s = kmap_local_page(page);
>>>>>   			ret = compress_page(compress, s, dst, false);
>>>>> -			kunmap(page);
>>>>> +			kunmap_local(s);
>>>>>   
>>>>>   			drm_clflush_pages(&page, 1);
>>>>>   
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>
>>
