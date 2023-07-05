Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA277481D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGEKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:16:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33736180
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:16:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8D916F2;
        Wed,  5 Jul 2023 03:16:50 -0700 (PDT)
Received: from [10.57.76.116] (unknown [10.57.76.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B23A3F762;
        Wed,  5 Jul 2023 03:16:05 -0700 (PDT)
Message-ID: <700df6bb-8005-21be-f39a-cca6a628887b@arm.com>
Date:   Wed, 5 Jul 2023 11:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     Yu Zhao <yuzhao@google.com>, Yin Fengwei <fengwei.yin@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
 <69aada71-0b3f-e928-6413-742fe7926576@intel.com>
 <CAOUHufYsOdywAJMxdh6W-=uLykD=7JrUwgBvUJWvfWJeQ5XxnA@mail.gmail.com>
 <467afd30-c85a-8b9d-97b9-a9ef9d0983af@arm.com>
 <449183bd-76ef-2a3a-c3f5-0478a7c574ef@intel.com>
 <CAOUHufZkMbgsTU+MqDVDjPbavvisT6EXfcNnWO8oN4XtK9Bgvw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZkMbgsTU+MqDVDjPbavvisT6EXfcNnWO8oN4XtK9Bgvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 01:21, Yu Zhao wrote:
> On Tue, Jul 4, 2023 at 5:53 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/4/23 23:36, Ryan Roberts wrote:
>>> On 04/07/2023 08:11, Yu Zhao wrote:
>>>> On Tue, Jul 4, 2023 at 12:22 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>> On 7/4/2023 10:18 AM, Yu Zhao wrote:
>>>>>> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>
>>>>>>> Hi All,
>>>>>>>
>>>>>>> This is v2 of a series to implement variable order, large folios for anonymous
>>>>>>> memory. The objective of this is to improve performance by allocating larger
>>>>>>> chunks of memory during anonymous page faults. See [1] for background.
>>>>>>
>>>>>> Thanks for the quick response!
>>>>>>
>>>>>>> I've significantly reworked and simplified the patch set based on comments from
>>>>>>> Yu Zhao (thanks for all your feedback!). I've also renamed the feature to
>>>>>>> VARIABLE_THP, on Yu's advice.
>>>>>>>
>>>>>>> The last patch is for arm64 to explicitly override the default
>>>>>>> arch_wants_pte_order() and is intended as an example. If this series is accepted
>>>>>>> I suggest taking the first 4 patches through the mm tree and the arm64 change
>>>>>>> could be handled through the arm64 tree separately. Neither has any build
>>>>>>> dependency on the other.
>>>>>>>
>>>>>>> The one area where I haven't followed Yu's advice is in the determination of the
>>>>>>> size of folio to use. It was suggested that I have a single preferred large
>>>>>>> order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, or there
>>>>>>> being existing overlapping populated PTEs, etc) then fallback immediately to
>>>>>>> order-0. It turned out that this approach caused a performance regression in the
>>>>>>> Speedometer benchmark.
>>>>>>
>>>>>> I suppose it's regression against the v1, not the unpatched kernel.
>>>>> From the performance data Ryan shared, it's against unpatched kernel:
>>>>>
>>>>> Speedometer 2.0:
>>>>>
>>>>> | kernel                         |   runs_per_min |
>>>>> |:-------------------------------|---------------:|
>>>>> | baseline-4k                    |           0.0% |
>>>>> | anonfolio-lkml-v1              |           0.7% |
>>>>> | anonfolio-lkml-v2-simple-order |          -0.9% |
>>>>> | anonfolio-lkml-v2              |           0.5% |
>>>>
>>>> I see. Thanks.
>>>>
>>>> A couple of questions:
>>>> 1. Do we have a stddev?
>>>
>>> | kernel                    |   mean_abs |   std_abs |   mean_rel |   std_rel |
>>> |:------------------------- |-----------:|----------:|-----------:|----------:|
>>> | baseline-4k               |      117.4 |       0.8 |       0.0% |      0.7% |
>>> | anonfolio-v1              |      118.2 |         1 |       0.7% |      0.9% |
>>> | anonfolio-v2-simple-order |      116.4 |       1.1 |      -0.9% |      0.9% |
>>> | anonfolio-v2              |        118 |       1.2 |       0.5% |      1.0% |
>>>
>>> This is with 3 runs per reboot across 5 reboots, with first run after reboot
>>> trimmed (it's always a bit slower, I assume due to cold page cache). So 10 data
>>> points per kernel in total.
>>>
>>> I've rerun the test multiple times and see similar results each time.
>>>
>>> I've also run anonfolio-v2 with Kconfig FLEXIBLE_THP=disabled and in this case I
>>> see the same performance as baseline-4k.
>>>
>>>
>>>> 2. Do we have a theory why it regressed?
>>>
>>> I have a woolly hypothesis; I think Chromium is doing mmap/munmap in ways that
>>> mean when we fault, order-4 is often too big to fit in the VMA. So we fallback
>>> to order-0. I guess this is happening so often for this workload that the cost
>>> of doing the checks and fallback is outweighing the benefit of the memory that
>>> does end up with order-4 folios.
>>>
>>> I've sampled the memory in each bucket (once per second) while running and its
>>> roughly:
>>>
>>> 64K: 25%
>>> 32K: 15%
>>> 16K: 15%
>>> 4K: 45%
>>>
>>> 32K and 16K obviously fold into the 4K bucket with anonfolio-v2-simple-order.
>>> But potentially, I suspect there is lots of mmap/unmap for the smaller sizes and
>>> the 64K contents is more static - that's just a guess though.
>> So this is like out of vma range thing.
>>
>>>
>>>> Assuming no bugs, I don't see how a real regression could happen --
>>>> falling back to order-0 isn't different from the original behavior.
>>>> Ryan, could you `perf record` and `cat /proc/vmstat` and share them?
>>>
>>> I can, but it will have to be a bit later in the week. I'll do some more test
>>> runs overnight so we have a larger number of runs - hopefully that might tell us
>>> that this is noise to a certain extent.
>>>
>>> I'd still like to hear a clear technical argument for why the bin-packing
>>> approach is not the correct one!
>> My understanding to Yu's (Yu, correct me if I am wrong) comments is that we
>> postpone this part of change and make basic anon large folio support in. Then
>> discuss which approach we should take. Maybe people will agree retry is the
>> choice, maybe other approach will be taken...
>>
>> For example, for this out of VMA range case, per VMA order should be considered.
>> We don't need make decision that the retry should be taken now.
> 
> I've articulated the reasons in another email. Just summarize the most
> important point here:
> using more fallback orders makes a system reach equilibrium faster, at
> which point it can't allocate the order of arch_wants_pte_order()
> anymore. IOW, this best-fit policy can reduce the number of folios of
> the h/w prefered order for a system running long enough.

Thanks for taking the time to write all the arguments down. I understand what
you are saying. If we are considering the whole system, then we also need to
think about the page cache though, and that will allocate multiple orders, so
you are still going to suffer fragmentation from that user.

That said, I like the proposal patch posted where we have up to 3 orders that we
try in order of preference; hw-preferred, PAGE_ALLOC_COSTLY_ORDER and 0. That
feels like a good compromise that allows me to fulfil my objectives. I'm going
to pull this together into a v3 patch set and aim to post towards the end of the
week.

Are you ok for me to add a Suggested-by: for you? (submitting-patches.rst says I
need your explicit permission).

On the regression front, I've done a much bigger test run and see the regression
is still present (although the mean has shifted a little bit). I've also built a
kernel based on anonfolio-lkml-v2 but where arch_wants_pte_order() returns
order-3. The aim was to test your hypothesis that 64K allocation is slow. This
kernel is performing even better, so I think that confirms your hypothesis:

| kernel                         |   runs_per_min |   runs |   sessions |
|:-------------------------------|---------------:|-------:|-----------:|
| baseline-4k                    |           0.0% |     75 |         15 |
| anonfolio-lkml-v1              |           1.0% |     75 |         15 |
| anonfolio-lkml-v2-simple-order |          -0.4% |     75 |         15 |
| anonfolio-lkml-v2              |           0.9% |     75 |         15 |
| anonfolio-lkml-v2-32k          |           1.4% |     10 |          5 |

Thanks,
Ryan

