Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0AF6A573C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjB1Kz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjB1Kyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:54:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8D2CC4B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:53:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i5so8261201pla.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677581607;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRaRJQujxEovvpNBmWWw2pEpFxn8UUlJ/UEqlgQi6ZI=;
        b=aeBXG6iyFD5PwjINMCmQ6lI7EG0Ji5j7gwGjAi8iefCQ8oCF8/ysjEyYS3IQRbVjcS
         sLA1vpJT6p6kSc1PRhfLJHUOZeIIJgoYtdJGZligmPUZqa9dGgR1cbNjm6960kbXX7/c
         AjysLvXdzvvycJ/MRJXHyu3q1ukNKmBHwhDs5HLeSdFdAzsIaQf9dj//FIJHPJMcNZco
         P/E5ambolomWxcwMInH/Sa7V9cNfJUtSnAFpxCSnUO4+S1q7OLonzyB2povhcYzsXRsD
         01FiBLMb7sGWw4dQamc4Q1UXC+NM2Z2eEXf1Y0C3lT8fvyTKWGDZeJJNeLPvNGL/Rh4V
         7wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677581607;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRaRJQujxEovvpNBmWWw2pEpFxn8UUlJ/UEqlgQi6ZI=;
        b=nB3+iR96keCopp667EC7Y6xIg4NY4cuWEUeug0wk4G3TUgknjgMYWt8IcCEE9hnoZ2
         /wRMrxT+vOOEnXHy3pr6hLF/OGQ1WjyafTfhArmTEm1ZBbnFLCF/KkxXkJyLaQWPLK+S
         llAVe0Q+0Ff4KxTeVMBAL8NFJBvThQtESNDoZmIuVMDVsEfFTRWYs4fysopW059q/gA2
         IdPIaEo06KMGYtThbSzdbsJYvt2eD1tJaloXtBHzAehy9/Zope0iK5XNhiMtMjAeMzbs
         D4J8same0HJhZJB932Clxm87nNymAaPgj4CqzM7kdFv9sNZYHnIiNKJs7XKc2gTts4wS
         15GQ==
X-Gm-Message-State: AO0yUKU0pQbOchKrkm0Jxt8jfIXreiRVRJO1PjOOGk/VahvDqFVtae1q
        M+eLYyA39HZxWnz8Il+6njk1j1T5UbY23UG2
X-Google-Smtp-Source: AK7set8oPq+zjY95hL7VZvhmfFuroc5InJJqtSGtiOK3eHEN//wiiSs0C0NJ55KxfhblWw7OquRzWQ==
X-Received: by 2002:a17:902:7109:b0:19a:839d:b67a with SMTP id a9-20020a170902710900b0019a839db67amr2571695pll.5.1677581606989;
        Tue, 28 Feb 2023 02:53:26 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b00185402cfedesm1528426plp.246.2023.02.28.02.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:53:26 -0800 (PST)
Message-ID: <36c737e1-7e1c-7098-8bd5-1767869489d9@bytedance.com>
Date:   Tue, 28 Feb 2023 18:53:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, sultan@kerneltoast.com,
        dave@stgolabs.net, penguin-kernel@i-love.sakura.ne.jp,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/zHbhxnQ2YsP+wX@kernel.org>
 <63a16f0e-d6e9-29a1-069e-dc76bfd82319@bytedance.com>
In-Reply-To: <63a16f0e-d6e9-29a1-069e-dc76bfd82319@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 18:04, Qi Zheng wrote:
> 
> 
> On 2023/2/27 23:08, Mike Rapoport wrote:
>> Hi,
>>
>> On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
>>>
>>>
>>> On 2023/2/27 03:51, Andrew Morton wrote:
>>>> On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng 
>>>> <zhengqi.arch@bytedance.com> wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> This patch series aims to make slab shrink lockless.
>>>>
>>>> What an awesome changelog.
>>>>
>>>>> 2. Survey
>>>>> =========
>>>>
>>>> Especially this part.
>>>>
>>>> Looking through all the prior efforts and at this patchset I am not
>>>> immediately seeing any statements about the overall effect upon
>>>> real-world workloads.  For a good example, does this patchset
>>>> measurably improve throughput or energy consumption on your servers?
>>>
>>> Hi Andrew,
>>>
>>> I re-tested with the following physical machines:
>>>
>>> Architecture:        x86_64
>>> CPU(s):              96
>>> On-line CPU(s) list: 0-95
>>> Model name:          Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz
>>>
>>> I found that the reason for the hotspot I described in cover letter is
>>> wrong. The reason for the down_read_trylock() hotspot is not because of
>>> the failure to trylock, but simply because of the atomic operation
>>> (cmpxchg). And this will lead to a significant reduction in IPC (insn
>>> per cycle).
>>
>> ...
>>> Then we can use the following perf command to view hotspots:
>>>
>>> perf top -U -F 999
>>>
>>> 1) Before applying this patchset:
>>>
>>>    32.31%  [kernel]           [k] down_read_trylock
>>>    19.40%  [kernel]           [k] pv_native_safe_halt
>>>    16.24%  [kernel]           [k] up_read
>>>    15.70%  [kernel]           [k] shrink_slab
>>>     4.69%  [kernel]           [k] _find_next_bit
>>>     2.62%  [kernel]           [k] shrink_node
>>>     1.78%  [kernel]           [k] shrink_lruvec
>>>     0.76%  [kernel]           [k] do_shrink_slab
>>>
>>> 2) After applying this patchset:
>>>
>>>    27.83%  [kernel]           [k] _find_next_bit
>>>    16.97%  [kernel]           [k] shrink_slab
>>>    15.82%  [kernel]           [k] pv_native_safe_halt
>>>     9.58%  [kernel]           [k] shrink_node
>>>     8.31%  [kernel]           [k] shrink_lruvec
>>>     5.64%  [kernel]           [k] do_shrink_slab
>>>     3.88%  [kernel]           [k] mem_cgroup_iter
>>>
>>> 2. At the same time, we use the following perf command to capture IPC
>>> information:
>>>
>>> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
>>>
>>> 1) Before applying this patchset:
>>>
>>>   Performance counter stats for 'system wide' (5 runs):
>>>
>>>        454187219766      cycles                    
>>> test                    (
>>> +-  1.84% )
>>>         78896433101      instructions              test #    0.17  
>>> insn per
>>> cycle           ( +-  0.44% )
>>>
>>>          10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
>>>
>>> 2) After applying this patchset:
>>>
>>>   Performance counter stats for 'system wide' (5 runs):
>>>
>>>        841954709443      cycles                    
>>> test                    (
>>> +- 15.80% )  (98.69%)
>>>        527258677936      instructions              test #    0.63  
>>> insn per
>>> cycle           ( +- 15.11% )  (98.68%)
>>>
>>>            10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
>>>
>>> We can see that IPC drops very seriously when calling
>>> down_read_trylock() at high frequency. After using SRCU,
>>> the IPC is at a normal level.
>>
>> The results you present do show improvement in IPC for an artificial test
>> script. But more interesting would be to see how a real world workloads
>> benefit from your changes.
> 
> Hi Mike and Andrew,
> 
> I did encounter this problem under the real workload of our online
> server. At the end of this email, I posted another call stack and
> hot spot that I found before.
> 
> I scanned the hotspots of all our online servers yesterday and today, 
> but unfortunately did not find the live environment.
> 
> Some of our servers have a large number of containers, and each
> container will mount some file systems. This is likely to trigger
> down_read_trylock() hotspots when the memory pressure of the whole
> machine or the memory pressure of memcg is high.

And the servers where this hotspot has happened (we have a hotspot alarm
record), basically have 96 cores, or 128 cores or even more.

> 
> So I just found a physical server with a similar configuration to the
> online server yesterday for a simulation test. The call stack and the 
> hot spot in the simulation test are almost exactly the same, so in
> theory, when such a hot spot appears on the online server, we can also
> enjoy the improvement of IPC. This will improve the performance of the
> server in memory exhaustion scenarios (memcg or global level).
> 
> And the above scenario is only one aspect, and the other aspect is the
> lock competition scenario mentioned by Kirill. After applying this patch 
> set, slab shrink and register_shrinker() can be completely parallelized,
> which can fix that problem.
> 
> These are the two main benefits for real workloads that I consider.
> 
> Thanks,
> Qi
> 
> call stack
> ----------
> 
> @[
>      down_read_trylock+1
>      shrink_slab+128
>      shrink_node+371
>      do_try_to_free_pages+232
>      try_to_free_pages+243
>      _alloc_pages_slowpath+771
>      _alloc_pages_nodemask+702
>      pagecache_get_page+255
>      filemap_fault+1361
>      ext4_filemap_fault+44
>      __do_fault+76
>      handle_mm_fault+3543
>      do_user_addr_fault+442
>      do_page_fault+48
>      page_fault+62
> ]: 1161690
> @[
>      down_read_trylock+1
>      shrink_slab+128
>      shrink_node+371
>      balance_pgdat+690
>      kswapd+389
>      kthread+246
>      ret_from_fork+31
> ]: 8424884
> @[
>      down_read_trylock+1
>      shrink_slab+128
>      shrink_node+371
>      do_try_to_free_pages+232
>      try_to_free_pages+243
>      __alloc_pages_slowpath+771
>      __alloc_pages_nodemask+702
>      __do_page_cache_readahead+244
>      filemap_fault+1674
>      ext4_filemap_fault+44
>      __do_fault+76
>      handle_mm_fault+3543
>      do_user_addr_fault+442
>      do_page_fault+48
>      page_fault+62
> ]: 20917631
> 
> hotspot
> -------
> 
> 52.22% [kernel]        [k] down_read_trylock
> 19.60% [kernel]        [k] up_read
>   8.86% [kernel]        [k] shrink_slab
>   2.44% [kernel]        [k] idr_find
>   1.25% [kernel]        [k] count_shadow_nodes
>   1.18% [kernel]        [k] shrink lruvec
>   0.71% [kernel]        [k] mem_cgroup_iter
>   0.71% [kernel]        [k] shrink_node
>   0.55% [kernel]        [k] find_next_bit
> 
> 
>>> Thanks,
>>> Qi
>>
> 

-- 
Thanks,
Qi
