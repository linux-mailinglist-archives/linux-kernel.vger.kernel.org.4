Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE336A6878
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCAH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:56:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15D311CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:56:00 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 25841660035B;
        Wed,  1 Mar 2023 07:55:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677657358;
        bh=BbfNtQPnACGWLjxystJr489MF9PkPbOm0YLmC80+ESw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=l69jCCiM9TtlG3RkbMTtF0qVkWMC8uM5lLRmIBcNKuoPhvk8yWNp4a8PXmKXJfI/r
         yOmHWmSG/SEclccVDdthT1uUw4OF3BXymSw+Hcue10t9yf+r68xN360Di2j3H2sirs
         zSP27VrdZuFc3ZofVedkTw8oZp+wcvE2QUyEx4n5OKftWHDEZRwvwoMrIuJyZGH/4Y
         Xu7h5U/DUS2Yk6uL85GVrPwxTryLCLdAm6LAQOx+LTV9bpZ5O/6DK6rsY+IVdz1sYb
         frdH2tBfH8EVp4Bd5F/M+19UosZsOaG2fwzlt0mhNpKnzLHR6Hh4OnLXBQh3kniyHE
         CoKvHAGm0hv4A==
Message-ID: <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com>
Date:   Wed, 1 Mar 2023 12:55:51 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
To:     Peter Xu <peterx@redhat.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n> <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Finally I've found the bug.

On 2/28/23 9:24 PM, Muhammad Usama Anjum wrote:
> On 2/28/23 8:58 PM, Peter Xu wrote:
>> On Tue, Feb 28, 2023 at 12:21:45PM +0500, Muhammad Usama Anjum wrote:
>>> Hi Peter,
>>
>> Hi, Muhammad,
>>
>>>
>>> Thank you so much for sending.
>>>
>>> On 2/28/23 5:36 AM, Peter Xu wrote:
>>>> On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
>>>>> This is a new feature that controls how uffd-wp handles none ptes.  When
>>>>> it's set, the kernel will handle anonymous memory the same way as file
>>>>> memory, by allowing the user to wr-protect unpopulated ptes.
>>>>>
>>>>> File memories handles none ptes consistently by allowing wr-protecting of
>>>>> none ptes because of the unawareness of page cache being exist or not.  For
>>>>> anonymous it was not as persistent because we used to assume that we don't
>>>>> need protections on none ptes or known zero pages.
>>>>>
>>>>> One use case of such a feature bit was VM live snapshot, where if without
>>>>> wr-protecting empty ptes the snapshot can contain random rubbish in the
>>>>> holes of the anonymous memory, which can cause misbehave of the guest when
>>>>> the guest OS assumes the pages should be all zeros.
>>>>>
>>>>> QEMU worked it around by pre-populate the section with reads to fill in
>>>>> zero page entries before starting the whole snapshot process [1].
>>>>>
>>>>> Recently there's another need raised on using userfaultfd wr-protect for
>>>>> detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
>>>>> case if without being able to wr-protect none ptes by default, the dirty
>>>>> info can get lost, since we cannot treat every none pte to be dirty (the
>>>>> current design is identify a page dirty based on uffd-wp bit being cleared).
>>>>>
>>>>> In general, we want to be able to wr-protect empty ptes too even for
>>>>> anonymous.
>>>>>
>>>>> This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
>>>>> uffd-wp handling on none ptes being consistent no matter what the memory
>>>>> type is underneath.  It doesn't have any impact on file memories so far
>>>>> because we already have pte markers taking care of that.  So it only
>>>>> affects anonymous.
>>>>>
>>>>> The feature bit is by default off, so the old behavior will be maintained.
>>>>> Sometimes it may be wanted because the wr-protect of none ptes will contain
>>>>> overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
>>>>> anonymous), but also on creating the pgtables to store the pte markers. So
>>>>> there's potentially less chance of using thp on the first fault for a none
>>>>> pmd or larger than a pmd.
>>>>>
>>>>> The major implementation part is teaching the whole kernel to understand
>>>>> pte markers even for anonymously mapped ranges, meanwhile allowing the
>>>>> UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
>>>>> new feature bit is set.
>>>>>
>>>>> Note that even if the patch subject starts with mm/uffd, there're a few
>>>>> small refactors to major mm path of handling anonymous page faults. But
>>>>> they should be straightforward.
>>>>>
>>>>> So far, add a very light smoke test within the userfaultfd kselftest
>>>>> pagemap unit test to make sure anon pte markers work.
>>>>>
>>>>> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
>>>>> [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>> v1->v2:
>>>>> - Use pte markers rather than populate zero pages when protect [David]
>>>>> - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
>>>>
>>>> Some very initial performance numbers (I only ran in a VM but it should be
>>>> similar, unit is "us") below as requested.  The measurement is about time
>>>> spent when wr-protecting 10G range of empty but mapped memory.  It's done
>>>> in a VM, assuming we'll get similar results on bare metal.
>>>>
>>>> Four test cases:
>>>>
>>>>         - default UFFDIO_WP
>>>>         - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
>>>>         - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
>>>>         - UFFDIO_WP with WP_UNPOPULATED
>>>>
>>>> Results:
>>>>
>>>>         Test DEFAULT: 2
>>>>         Test PRE-READ: 3277099 (pre-fault 3253826)
>>>>         Test MADVISE: 2250361 (pre-fault 2226310)
>>>>         Test WP-UNPOPULATE: 20850
>>>>
>>>> I'll add these information into the commit message when there's a new
>>>> version.
>>> I'm hitting a bug where I'm unable to write to the memory after adding this
>>> patch and wp the memory. I'm hitting this case in your test and my tests as
>>> well. Please apply the following diff to your test to reproduce on your end:
>>>
>>> --- uffd_wp_perf.c.orig 2023-02-28 12:09:38.971820791 +0500
>>> +++ uffd_wp_perf.c      2023-02-28 12:13:11.077827160 +0500
>>> @@ -114,6 +114,7 @@
>>>          start1 = get_usec();
>>>      }
>>>      wp_range(uffd, buffer, SIZE, true);
>>> +    buffer[0] = 'a';
While using WP_UNPOPULATED, we get stuck if newly allocated memory is read
without initialization. This can be reproduced by either of the following
statements:
    printf("%c", buffer[0]);
    buffer[0]++;

This bug has start to appear on this patch. How are you handling reading
newly allocated memory when WP_UNPOPULATED is defined?



Running my pagemap_ioctl selftest as benchmark in a VM:
without zeropage / wp_unpopulated (decide from pte_none() if page is dirty
or not, buggy and wrong implementation, just for reference)
26.608 seconds
with zeropage
39.203 seconds
with wp_unpopulated
62.907 seconds

136% worse performance overall
60% worse performance of unpopulated than zeropage

>>>      if (start1 == 0)
>>>           printf("%"PRIu64"\n", get_usec() - start);
>>>      else
>>
>> This is expected, because the test didn't start any fault resolving thread,
>> so the write will block until someone unprotects the page.
> Ohh.. sorry. Wrong reproducer.
> 
>>
>> But it shouldn't happen to your use case if you applied both WP_UNPOPULATED
>> & WP_ASYNC.
> I'm using both WP_UNPOPULATED and ASYNC. The program gets stuck at right time:
> 
> 
> 1..57
> ok 1 sanity_tests_sd wrong flag specified
> ok 2 sanity_tests_sd wrong mask specified
> ok 3 sanity_tests_sd wrong return mask specified
> ok 4 sanity_tests_sd mixture of correct and wrong flag
> ok 5 sanity_tests_sd PM_SCAN_OP_WP cannot be used without get
> ok 6 sanity_tests_sd Clear area with larger vec size
> ^C
> Program received signal SIGINT, Interrupt.
> 0x000000000040220c in sanity_tests_sd () at pagemap_ioctl.c:198
> 198                     mem[i]++;
> (gdb) bt
> #0  0x000000000040220c in sanity_tests_sd () at pagemap_ioctl.c:198
> #1  0x0000000000404e14 in main () at pagemap_ioctl.c:846
> ()
> 
> /proc/$PID/stack is empty. Not sure why. I can see stack trace of other
> applications, but not this one's.
> 
> Let me send better reproducer for you.
> 
>>
>> Could you try "cat /proc/$PID/stack" to see where does your thread stuck
>> at?
>>
> 

-- 
BR,
Muhammad Usama Anjum
