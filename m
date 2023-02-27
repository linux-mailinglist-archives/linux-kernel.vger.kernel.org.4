Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1D6A4ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjB0TVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjB0TVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:21:08 -0500
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA024137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:21:04 -0800 (PST)
Received: from iva1-adaa4d2a0364.qloud-c.yandex.net (iva1-adaa4d2a0364.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:a0e:0:640:adaa:4d2a])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id B08535EDB6;
        Mon, 27 Feb 2023 22:21:02 +0300 (MSK)
Received: by iva1-adaa4d2a0364.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id xKZILZ3bhCg1-e9UFgARs;
        Mon, 27 Feb 2023 22:21:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1677525661;
        bh=KSrParIYUkxINHtLKh2KCtz9ZcTDaCdwZzXqsjqWlSU=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=CKaNx827G1T2hCOB9pINzSsmBK7Qh+AaeEjdopSSUV+f0jeQW3mFuo4Sc9EgUWPNi
         c4ONxLLDn//8HFAhmF7NxTXAnk6AoAbpOSShZeb9kkl1n5+KMmLWzHS5lpLYnwzAaZ
         kwfAV6dFPHPfcb0ahbi6qMOsM7IJRQOXcoQOcawk=
Authentication-Results: iva1-adaa4d2a0364.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <dcf1d336-cfe1-964e-efe7-4aa40d4a3520@ya.ru>
Date:   Mon, 27 Feb 2023 22:20:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/zHbhxnQ2YsP+wX@kernel.org>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <Y/zHbhxnQ2YsP+wX@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.2023 18:08, Mike Rapoport wrote:
> Hi,
> 
> On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/2/27 03:51, Andrew Morton wrote:
>>> On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>> Hi all,
>>>>
>>>> This patch series aims to make slab shrink lockless.
>>>
>>> What an awesome changelog.
>>>
>>>> 2. Survey
>>>> =========
>>>
>>> Especially this part.
>>>
>>> Looking through all the prior efforts and at this patchset I am not
>>> immediately seeing any statements about the overall effect upon
>>> real-world workloads.  For a good example, does this patchset
>>> measurably improve throughput or energy consumption on your servers?
>>
>> Hi Andrew,
>>
>> I re-tested with the following physical machines:
>>
>> Architecture:        x86_64
>> CPU(s):              96
>> On-line CPU(s) list: 0-95
>> Model name:          Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz
>>
>> I found that the reason for the hotspot I described in cover letter is
>> wrong. The reason for the down_read_trylock() hotspot is not because of
>> the failure to trylock, but simply because of the atomic operation
>> (cmpxchg). And this will lead to a significant reduction in IPC (insn
>> per cycle).
> 
> ... 
>  
>> Then we can use the following perf command to view hotspots:
>>
>> perf top -U -F 999
>>
>> 1) Before applying this patchset:
>>
>>   32.31%  [kernel]           [k] down_read_trylock
>>   19.40%  [kernel]           [k] pv_native_safe_halt
>>   16.24%  [kernel]           [k] up_read
>>   15.70%  [kernel]           [k] shrink_slab
>>    4.69%  [kernel]           [k] _find_next_bit
>>    2.62%  [kernel]           [k] shrink_node
>>    1.78%  [kernel]           [k] shrink_lruvec
>>    0.76%  [kernel]           [k] do_shrink_slab
>>
>> 2) After applying this patchset:
>>
>>   27.83%  [kernel]           [k] _find_next_bit
>>   16.97%  [kernel]           [k] shrink_slab
>>   15.82%  [kernel]           [k] pv_native_safe_halt
>>    9.58%  [kernel]           [k] shrink_node
>>    8.31%  [kernel]           [k] shrink_lruvec
>>    5.64%  [kernel]           [k] do_shrink_slab
>>    3.88%  [kernel]           [k] mem_cgroup_iter
>>
>> 2. At the same time, we use the following perf command to capture IPC
>> information:
>>
>> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
>>
>> 1) Before applying this patchset:
>>
>>  Performance counter stats for 'system wide' (5 runs):
>>
>>       454187219766      cycles                    test                    (
>> +-  1.84% )
>>        78896433101      instructions              test #    0.17  insn per
>> cycle           ( +-  0.44% )
>>
>>         10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
>>
>> 2) After applying this patchset:
>>
>>  Performance counter stats for 'system wide' (5 runs):
>>
>>       841954709443      cycles                    test                    (
>> +- 15.80% )  (98.69%)
>>       527258677936      instructions              test #    0.63  insn per
>> cycle           ( +- 15.11% )  (98.68%)
>>
>>           10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
>>
>> We can see that IPC drops very seriously when calling
>> down_read_trylock() at high frequency. After using SRCU,
>> the IPC is at a normal level.
> 
> The results you present do show improvement in IPC for an artificial test
> script. But more interesting would be to see how a real world workloads
> benefit from your changes.

One of the real workloads from my experience is start of an overcommitted node
containing many starting containers after node crash (or many resuming containers
after reboot for kernel update). In these cases memory pressure is huge, and
the node goes round in long reclaim.

This patch patchset makes prealloc_memcg_shrinker() independent of do_shrink_slab(),
so prealloc_memcg_shrinker() won't have to wait till shrink_slab_memcg() completes its
current bit iteration, sees rwsem_is_contended() and the iteration breaks.

Also, it's important to mention that currently we have the strange behavior:

prealloc_memcg_shrinker()
  down_write(&shrinker_rwsem)
  idr_alloc()
    reclaim
      for each child memcg
        shrink_slab_memcg()
          down_read_trylock(&shrinker_rwsem) -> fail

All the slab reclaim in this behavior is just a parasite work, and it just wastes
our cpu time, which does not look a good design.

Kirill
