Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182DE6A87BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCBRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCBRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:19:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC4FF2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:19:30 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F57F6602F64;
        Thu,  2 Mar 2023 17:19:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677777569;
        bh=7RnD/iUTxYbiKeSPS2PQXidFyIoI+DO5y3jtIWYTtc4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ca0wdVQ9DgkifR9V85cyhbUhwFyj2NDR4NPMEJnDXLZpqXYWrS5Rj9yUmvq/J4m/C
         FYqluzIg6AJPDL6IU88b4W6SBZxGiG2oHrBqKxzHhGERMTT7qZNlDSgvNv9KbcNpUJ
         uKi74yGLlasI/J3pMeP3ggdXebzihYA4ydiQ86M4YDn3MN8UrTs2wV97y4jw5ShIr9
         K/0TBUuSs6XaCb2fKaj6NStqDgcxlKiLGBvdcCb/7X3MYmBHWlKZoKm3LtkJFQZWGb
         EMLfZPaEQW2coyQbSZTju5KeJoII6qS5e/xqtlTGTNJNwQC2A6I/1sgS5fRMrK1FfO
         bUDJohI06/OMQ==
Message-ID: <9aa69bfb-c726-ac2c-127a-b21fd35ab40b@collabora.com>
Date:   Thu, 2 Mar 2023 22:19:22 +0500
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n>
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
In your case:
Default < WP-UNPOPULATE < MADVISE < PRE-READ


In my testing on next-20230228 with this patch and my uffd async patch:

Test DEFAULT: 6
Test PRE-READ: 37157 (pre-fault 37006)
Test MADVISE: 4884 (pre-fault 4465)
Test WP-UNPOPULATE: 17794

DEFAULT < MADVISE < WP-UNPOPULATE < PRE-READ

On my setup, MADVISE is performing better than WP-UNPOPULATE consistently.
I'm not sure why I'm getting this discrepancy here. I've liked your results
to be honest where we perform better with WP-UNPOPULATE than MADVISE. What
can be done to get consistent benchmarks over your and my side?

> 
> I'll add these information into the commit message when there's a new
> version.
> 
> [1] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c
> 

-- 
BR,
Muhammad Usama Anjum
