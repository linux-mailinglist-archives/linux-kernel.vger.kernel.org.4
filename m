Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C26AC7A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCFQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjCFQTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:19:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28562005F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:17:27 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22750660220E;
        Mon,  6 Mar 2023 16:09:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678118984;
        bh=Vkn/rMgW6eljfwE0ar+016H5SDONTodEhQeQta3af6o=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=C1JC4W5auAUJSBb1V9/dum7PJFsXh0GLWayXV+blK6whAgxUtPjoTdlCImgyfD93L
         DZXx76GDf4ORjA3l6zDv0BiFGgWQgKgNUCf7tC3Mv/3Vce00x8CqpMoJwzPu74+NzY
         J32Ke2fvLAC1gax3t5dHWmkEfGCWk9VlwqO7HPN+BTUjh8My/dxUxkiJjYdcsoyyQG
         FsNKrBt/D8orQivGkdibQJmI1NOJj9gQnGVQoxMiObm3Oo6IPjLbGYIkIngCCfLL8a
         ezUe+s3E8GQLqNhnDTXQ2egv8aU2ey3uQohI/X8JsJ39nFCjREx0Cib3/2L2D4U9UB
         c1JFY2FEpKt5w==
Message-ID: <7d09f101-d116-91cc-d1d5-5b1479318933@collabora.com>
Date:   Mon, 6 Mar 2023 21:09:38 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <9aa69bfb-c726-ac2c-127a-b21fd35ab40b@collabora.com>
 <92f2fd13-59f2-468d-d989-9b998a098795@redhat.com> <ZAEhY5lrxziDqpv5@x1n>
 <d0eb0a13-16dc-1ac1-653a-78b7273781e3@collabora.com> <ZAIkrxKgrlF05zaL@x1n>
 <6de09751-7c6d-1819-4aab-ff91f27a414b@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6de09751-7c6d-1819-4aab-ff91f27a414b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 2:03 PM, Muhammad Usama Anjum wrote:
> On 3/3/23 9:47 PM, Peter Xu wrote:
>> On Fri, Mar 03, 2023 at 11:42:46AM +0500, Muhammad Usama Anjum wrote:
>>> On 3/3/23 3:21 AM, Peter Xu wrote:
>>>> On Thu, Mar 02, 2023 at 06:38:20PM +0100, David Hildenbrand wrote:
>>>>> On 02.03.23 18:19, Muhammad Usama Anjum wrote:
>>>>>> On 2/28/23 5:36 AM, Peter Xu wrote:
>>>>>>> On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
>>>>>>>> This is a new feature that controls how uffd-wp handles none ptes.  When
>>>>>>>> it's set, the kernel will handle anonymous memory the same way as file
>>>>>>>> memory, by allowing the user to wr-protect unpopulated ptes.
>>>>>>>>
>>>>>>>> File memories handles none ptes consistently by allowing wr-protecting of
>>>>>>>> none ptes because of the unawareness of page cache being exist or not.  For
>>>>>>>> anonymous it was not as persistent because we used to assume that we don't
>>>>>>>> need protections on none ptes or known zero pages.
>>>>>>>>
>>>>>>>> One use case of such a feature bit was VM live snapshot, where if without
>>>>>>>> wr-protecting empty ptes the snapshot can contain random rubbish in the
>>>>>>>> holes of the anonymous memory, which can cause misbehave of the guest when
>>>>>>>> the guest OS assumes the pages should be all zeros.
>>>>>>>>
>>>>>>>> QEMU worked it around by pre-populate the section with reads to fill in
>>>>>>>> zero page entries before starting the whole snapshot process [1].
>>>>>>>>
>>>>>>>> Recently there's another need raised on using userfaultfd wr-protect for
>>>>>>>> detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
>>>>>>>> case if without being able to wr-protect none ptes by default, the dirty
>>>>>>>> info can get lost, since we cannot treat every none pte to be dirty (the
>>>>>>>> current design is identify a page dirty based on uffd-wp bit being cleared).
>>>>>>>>
>>>>>>>> In general, we want to be able to wr-protect empty ptes too even for
>>>>>>>> anonymous.
>>>>>>>>
>>>>>>>> This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
>>>>>>>> uffd-wp handling on none ptes being consistent no matter what the memory
>>>>>>>> type is underneath.  It doesn't have any impact on file memories so far
>>>>>>>> because we already have pte markers taking care of that.  So it only
>>>>>>>> affects anonymous.
>>>>>>>>
>>>>>>>> The feature bit is by default off, so the old behavior will be maintained.
>>>>>>>> Sometimes it may be wanted because the wr-protect of none ptes will contain
>>>>>>>> overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
>>>>>>>> anonymous), but also on creating the pgtables to store the pte markers. So
>>>>>>>> there's potentially less chance of using thp on the first fault for a none
>>>>>>>> pmd or larger than a pmd.
>>>>>>>>
>>>>>>>> The major implementation part is teaching the whole kernel to understand
>>>>>>>> pte markers even for anonymously mapped ranges, meanwhile allowing the
>>>>>>>> UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
>>>>>>>> new feature bit is set.
>>>>>>>>
>>>>>>>> Note that even if the patch subject starts with mm/uffd, there're a few
>>>>>>>> small refactors to major mm path of handling anonymous page faults. But
>>>>>>>> they should be straightforward.
>>>>>>>>
>>>>>>>> So far, add a very light smoke test within the userfaultfd kselftest
>>>>>>>> pagemap unit test to make sure anon pte markers work.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
>>>>>>>> [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
>>>>>>>>
>>>>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>>>>> ---
>>>>>>>> v1->v2:
>>>>>>>> - Use pte markers rather than populate zero pages when protect [David]
>>>>>>>> - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
>>>>>>>
>>>>>>> Some very initial performance numbers (I only ran in a VM but it should be
>>>>>>> similar, unit is "us") below as requested.  The measurement is about time
>>>>>>> spent when wr-protecting 10G range of empty but mapped memory.  It's done
>>>>>>> in a VM, assuming we'll get similar results on bare metal.
>>>>>>>
>>>>>>> Four test cases:
>>>>>>>
>>>>>>>          - default UFFDIO_WP
>>>>>>>          - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
>>>>>>>          - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
>>>>>>>          - UFFDIO_WP with WP_UNPOPULATED
>>>>>>>
>>>>>>> Results:
>>>>>>>
>>>>>>>          Test DEFAULT: 2
>>>>>>>          Test PRE-READ: 3277099 (pre-fault 3253826)
>>>>>>>          Test MADVISE: 2250361 (pre-fault 2226310)
>>>>>>>          Test WP-UNPOPULATE: 20850
>>>>>> In your case:
>>>>>> Default < WP-UNPOPULATE < MADVISE < PRE-READ
>>>>>>
>>>>>>
>>>>>> In my testing on next-20230228 with this patch and my uffd async patch:
>>>>>>
>>>>>> Test DEFAULT: 6
>>>>>> Test PRE-READ: 37157 (pre-fault 37006)
>>>>>> Test MADVISE: 4884 (pre-fault 4465)
>>>>>> Test WP-UNPOPULATE: 17794
>>>>>>
>>>>>> DEFAULT < MADVISE < WP-UNPOPULATE < PRE-READ
>>>>>>
>>>>>> On my setup, MADVISE is performing better than WP-UNPOPULATE consistently.
>>>>>> I'm not sure why I'm getting this discrepancy here. I've liked your results
>>>>>> to be honest where we perform better with WP-UNPOPULATE than MADVISE. What
>>>>>> can be done to get consistent benchmarks over your and my side?
>>>>>
>>>>> Probably because the current approach from Peter uses uffd-wp markers, and
>>>>> these markers can currently only reside on the PTE level, not on the PMD
>>>>> level yet.
>>>>>
>>>>> With MADVISE you get a huge zeropage and avoid dealing with PTEs.
>>>>
>>>> Yes, probably.  But then when write happens it'll be done there when split,
>>>> so the overhead was delayed.
>>>>
>>>> Meanwhile I'll retest again (probably tomorrow..) with bare metals with THP
>>>> on/off to double check.
>>> Turning on/off THP has effect.
>>>
>>> (1) With huge page disabled
>>> echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
>>> ./uffd_wp_perf
>>> Test DEFAULT: 4
>>> Test PRE-READ: 1111453 (pre-fault 1101011)
>>> Test MADVISE: 278276 (pre-fault 266378)
>>> Test WP-UNPOPULATE: 11712
> Hi Paul,
> 
> We were reading, touching or faulting memory before engaging wp. This
> reading is called pre-read in this benchmark. We can fault the memory
> through madvise as well, it is called madvise here. WP-Unpopulated is being
> added in this patch which will remove the need to pre-fault the memory and
> it is way faster as shown by the numbers.
> 
>>>
>>> (2) With Huge page enabled
>>> echo always > /sys/kernel/mm/transparent_hugepage/enabled
>>> ./uffd_wp_perf
>>> Test DEFAULT: 4
>>> Test PRE-READ: 22521 (pre-fault 22348)
>>> Test MADVISE: 4909 (pre-fault 4743)
>>> Test WP-UNPOPULATE: 14448
>>
>> Thanks. Yes then this is explaine-able to me.  As mentioned previously, thp
>> will drastically speedup everything during prefault+ioctl(UFFDIO_WP),
>> though that overhead will be applied when the 1st write triggers later,
>> afaik.
>>
>>>
>>>>
>>>> Muhammad, do you think the current performance will work for you?
>>> Yes, the current performance is good enough for now. We'll be using normal
>>> pages for memory on which PAGEMAP_IOCTL will be used for emulating Windows
>>> syscall. When normal size pages are used, (1) show that WP-UNPOPULATE has
>>> really good performance (278276 --> 11712). Lets proceed with it.
>>
>> OK.
>>
>>>
>>>>
>>>> Especially I want to double check with you again on whether
>>>> XFS/EXT4/... will be needed for the tracking purpose so you can reply here
>>>> together.  We shouldn't merge anything that doesn't have at least one
>>>> existing good use case, and we may need to rethink if it's not.
>>> We have been trying to find soft dirty pages correctly on anon memory.
>>> Right now with UN_POPULATED, ASYNC and PAGEMAP_IOCTL, we'll be able to
>>> achieve this correctly.
>>>
>>> We want to track the file mapped memory the same way for another Windows
>>> api translation in which file memory will be tracked to find out soft-dirty
>>> pages. I believe once it is supported in the mm, filesystem doesn't matter
>>> as we'll be tracking memory mapped files.
>>
>> Some more elaboration would be great here.
> There is something called "writecopy" in Windows. Paul has given me some
> details.
> 
> @Paul can you share more details that:
> 1) What is writecopy?
> 2) If there is no documentation or documented behavior, Can you please
> share the current reference implementation in Wine even though it is buggy
> at the time? (I can implement correct implementation with this patch and my
> wip v11 pagemap_ioctl patches for testing purpose.)
Hi Peter,

Just had some offline discussion with Paul, lets leave this second use case
for future. We don't want to make discussions more entangled. There isn't
much clarity on it right now. Lets only complete the first use case.

The current patch seems good. Please can you post the next version by
including the missing part. Then I'll also be able to send the v11 of
pagemap_ioctl by basing on it.

> 
>>
>> For example, what is the other windows API?  What will you do with the
>> dirty information?  What is the impact of supporting only shmem/hugetlbfs
>> for "!anon"?
>>
>>>
>>> So we have use cases for both soft-dirty tracking on anon and file backed
>>> memories.
>>>
>>>>
>>>> For performance, one approach is probably making uffd-wp async separate
>>>> from other features, where we can revert the meaning of uffd-wp bit to
>>>> mimic what soft-dirty does (I think this will look closer to what David
>>>> mentioned in the other thread), by defining uffd-wp=1 as "written" and
>>>> uffd-wp=0 as clean.
>>> I'm happy with current state of things. WP Async is just a feature where
>>> faults are resolved automatically. The page is WP or not perfectly
>>> translates if page is written (dirty) or not with just not (!) operation.
>>> If we go and change the meanings of uffd_wp=1 as written, it would cause
>>> confusion and probably we'll need a lot more changes to add async feature
>>> which is right now quite small changeset.
>>
>> Yes, that's also why I wanted to keep it like this unless necessary.  It
>> makes all uffd features still more aligned with everything so more maintainable.
>>
>>>
>>>>
>>>> IIUC that'll make it one bit and work as fast as soft-dirty, meanwhile all
>>>> uffd-wp marker things can hopefully still be maintained.  However I really
>>>> don't like it to violate a lot of things, e.g., when UFFDIO_WRITEPROTECT
>>>> another round we'll need to DROP uffd-wp if async, but APPLY uffd-wp if
>>>> sync...  So in general it'll need more thoughts and slower to do.
>>> Sorry, I'm unable to understand your example here. Can you please elaborate?
>>
>> I think it's mostly what you stated above, the changeset will just get more
>> involved because of either the redefinition of uffd-wp depending on feature
>> enabled, or using yet another bit (e.g., if you still remember the very
>> original reply I was planning to reuse soft-dirty bit but used together
>> with VM_UFFD_WP; I think that resolves the degraded perf on unpopulated
>> memory too because it'll work more like soft-dirty).
>>
>> This is some detail which, IMHO, we can leave that for later.  To me I'm
>> more curious on knowing more details of your use case, and how uffd could
>> suite that the best way it could, assuming that (or part of it like the
>> unpopulate work here) can also be leveraged by others.  Your answers to
>> above questions may help.
>>
>> Thanks,
>>
> 

-- 
BR,
Muhammad Usama Anjum
