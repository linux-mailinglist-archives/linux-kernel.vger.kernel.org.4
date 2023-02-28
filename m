Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E016A539F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjB1HV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjB1HVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:21:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C3B1EFE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:21:53 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7907666021EB;
        Tue, 28 Feb 2023 07:21:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677568911;
        bh=f5T0rkBaJGbSHgZ//rCIzdBQQ68DfSJ5UEg364ciCPA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=TxsSbM4cSmxx07zkqDrsNXv7qCnBXbTw+NOe71HpgdzS871eUKEcidHPEVnmMRDSX
         LDClER+v3H7XaKbM/N3OMgGidfY2t1kBcpZlPHOrxVfM6I/Y/phGIFOk8OTgLq2r9B
         J7RtHC8B4A58M0xDohLaL+U6wns05tbePRzlPKcR3ohIn721a6j0cgkCGUyWBxBUT/
         jeXtuIuQ6WjvNqLgm5lU7uGOnMbrz14zCUBei6jUduvEO7IFwVG9l9C6MwmgtRbv2y
         x8eiaWvNi1NDu+A0S1HzaDhX5Jhk4WyTdVPMR2BhBSchevErRmCT+pJANati4d1/4W
         TUjMDO4B3y41w==
Message-ID: <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
Date:   Tue, 28 Feb 2023 12:21:45 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y/1Mh5uivFt+zWKM@x1n>
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

Thank you so much for sending.

On 2/28/23 5:36 AM, Peter Xu wrote:
> On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
>> This is a new feature that controls how uffd-wp handles none ptes.  When
>> it's set, the kernel will handle anonymous memory the same way as file
>> memory, by allowing the user to wr-protect unpopulated ptes.
>>
>> File memories handles none ptes consistently by allowing wr-protecting of
>> none ptes because of the unawareness of page cache being exist or not.  For
>> anonymous it was not as persistent because we used to assume that we don't
>> need protections on none ptes or known zero pages.
>>
>> One use case of such a feature bit was VM live snapshot, where if without
>> wr-protecting empty ptes the snapshot can contain random rubbish in the
>> holes of the anonymous memory, which can cause misbehave of the guest when
>> the guest OS assumes the pages should be all zeros.
>>
>> QEMU worked it around by pre-populate the section with reads to fill in
>> zero page entries before starting the whole snapshot process [1].
>>
>> Recently there's another need raised on using userfaultfd wr-protect for
>> detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
>> case if without being able to wr-protect none ptes by default, the dirty
>> info can get lost, since we cannot treat every none pte to be dirty (the
>> current design is identify a page dirty based on uffd-wp bit being cleared).
>>
>> In general, we want to be able to wr-protect empty ptes too even for
>> anonymous.
>>
>> This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
>> uffd-wp handling on none ptes being consistent no matter what the memory
>> type is underneath.  It doesn't have any impact on file memories so far
>> because we already have pte markers taking care of that.  So it only
>> affects anonymous.
>>
>> The feature bit is by default off, so the old behavior will be maintained.
>> Sometimes it may be wanted because the wr-protect of none ptes will contain
>> overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
>> anonymous), but also on creating the pgtables to store the pte markers. So
>> there's potentially less chance of using thp on the first fault for a none
>> pmd or larger than a pmd.
>>
>> The major implementation part is teaching the whole kernel to understand
>> pte markers even for anonymously mapped ranges, meanwhile allowing the
>> UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
>> new feature bit is set.
>>
>> Note that even if the patch subject starts with mm/uffd, there're a few
>> small refactors to major mm path of handling anonymous page faults. But
>> they should be straightforward.
>>
>> So far, add a very light smoke test within the userfaultfd kselftest
>> pagemap unit test to make sure anon pte markers work.
>>
>> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
>> [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>> v1->v2:
>> - Use pte markers rather than populate zero pages when protect [David]
>> - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
> 
> Some very initial performance numbers (I only ran in a VM but it should be
> similar, unit is "us") below as requested.  The measurement is about time
> spent when wr-protecting 10G range of empty but mapped memory.  It's done
> in a VM, assuming we'll get similar results on bare metal.
> 
> Four test cases:
> 
>         - default UFFDIO_WP
>         - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
>         - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
>         - UFFDIO_WP with WP_UNPOPULATED
> 
> Results:
> 
>         Test DEFAULT: 2
>         Test PRE-READ: 3277099 (pre-fault 3253826)
>         Test MADVISE: 2250361 (pre-fault 2226310)
>         Test WP-UNPOPULATE: 20850
> 
> I'll add these information into the commit message when there's a new
> version.
I'm hitting a bug where I'm unable to write to the memory after adding this
patch and wp the memory. I'm hitting this case in your test and my tests as
well. Please apply the following diff to your test to reproduce on your end:

--- uffd_wp_perf.c.orig 2023-02-28 12:09:38.971820791 +0500
+++ uffd_wp_perf.c      2023-02-28 12:13:11.077827160 +0500
@@ -114,6 +114,7 @@
         start1 = get_usec();
     }
     wp_range(uffd, buffer, SIZE, true);
+    buffer[0] = 'a';
     if (start1 == 0)
          printf("%"PRIu64"\n", get_usec() - start);
     else


> 
> [1] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c
> 

-- 
BR,
Muhammad Usama Anjum
