Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4AB6A87FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCBRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCBRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7C113D6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677778704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orZXB9gcfRN1e3opRAWGH7mQL5diYEXzfZCK0Pyo9o8=;
        b=HAwYiYVPzoKCinJCMUbzwhpKXR6dj+bimzZb+wAcGRQ69MpLf2pa8KpTgfff77raqKwx2H
        JLgRIiUOjE/KoChe0cQJVkEF73e6ddzvdcs0cpA2aAvPbHkjOZomljUD4jwJNpFnmYGkoh
        nva0/8RaUjHBHakwNxaBVTzS2+BVq2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-u7zINRcPOXiVdib9wQKwMQ-1; Thu, 02 Mar 2023 12:38:23 -0500
X-MC-Unique: u7zINRcPOXiVdib9wQKwMQ-1
Received: by mail-wm1-f71.google.com with SMTP id bi21-20020a05600c3d9500b003e836e354e0so1395842wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 09:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orZXB9gcfRN1e3opRAWGH7mQL5diYEXzfZCK0Pyo9o8=;
        b=Rn5IKJ5FMSBwSbaMf2psqN7aJYYH5tVhzlaWNr4rPTriRGQGdk40H92mrSZGo29O7M
         2tnDtnbw7pyZwaJlZvRxoTqjUKEDMh8ulOOash1PcrDCbW/nP8ZBA0oiLLTNM7aGe96a
         3MZF1DhTSZSLEKvfTsOr/+tDg0Vn17iiSVQXmz/yHzADRHHi39Y83wzYmToeFobIp8BV
         FgCxrjRyiBgE5iDXjtbyAdGIdmUc4YHdfLjz1nFbYOGdsCQNAnRF2Vn5C6k9ZRoJstQH
         vcLO0Cr9X/Tw7L1Aat63KJBs84ZyT4q4eL1JIskbDRN/dO5UnQhyAGaScQVAXdJiUqGu
         wVRQ==
X-Gm-Message-State: AO0yUKUnoJ/70oI+m8N8eqscG9gN4ipneNb1rERNY2zzuNMV8NR26n+p
        t7Mn8kgkoUS88M127VZ68BnKhxVXtOmbs8fS87iudu5SZ7eJ+BS2vB30UOptMw3ZsgzWSDf0C1V
        lhAXM3xYbf5RpdtSdcIcLH8sRDuVRCg==
X-Received: by 2002:a05:600c:18a1:b0:3eb:39e2:915b with SMTP id x33-20020a05600c18a100b003eb39e2915bmr7773261wmp.31.1677778702383;
        Thu, 02 Mar 2023 09:38:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/wCXT/T4ew5RsMoTxfXp4eHM/sGKmKi2k65woDzwFseBEJ6tIxbuFXaTP+ttDnt4lhxKCdSg==
X-Received: by 2002:a05:600c:18a1:b0:3eb:39e2:915b with SMTP id x33-20020a05600c18a100b003eb39e2915bmr7773246wmp.31.1677778702025;
        Thu, 02 Mar 2023 09:38:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003e01493b136sm4015269wmq.43.2023.03.02.09.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 09:38:21 -0800 (PST)
Message-ID: <92f2fd13-59f2-468d-d989-9b998a098795@redhat.com>
Date:   Thu, 2 Mar 2023 18:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <9aa69bfb-c726-ac2c-127a-b21fd35ab40b@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9aa69bfb-c726-ac2c-127a-b21fd35ab40b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 18:19, Muhammad Usama Anjum wrote:
> On 2/28/23 5:36 AM, Peter Xu wrote:
>> On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
>>> This is a new feature that controls how uffd-wp handles none ptes.  When
>>> it's set, the kernel will handle anonymous memory the same way as file
>>> memory, by allowing the user to wr-protect unpopulated ptes.
>>>
>>> File memories handles none ptes consistently by allowing wr-protecting of
>>> none ptes because of the unawareness of page cache being exist or not.  For
>>> anonymous it was not as persistent because we used to assume that we don't
>>> need protections on none ptes or known zero pages.
>>>
>>> One use case of such a feature bit was VM live snapshot, where if without
>>> wr-protecting empty ptes the snapshot can contain random rubbish in the
>>> holes of the anonymous memory, which can cause misbehave of the guest when
>>> the guest OS assumes the pages should be all zeros.
>>>
>>> QEMU worked it around by pre-populate the section with reads to fill in
>>> zero page entries before starting the whole snapshot process [1].
>>>
>>> Recently there's another need raised on using userfaultfd wr-protect for
>>> detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
>>> case if without being able to wr-protect none ptes by default, the dirty
>>> info can get lost, since we cannot treat every none pte to be dirty (the
>>> current design is identify a page dirty based on uffd-wp bit being cleared).
>>>
>>> In general, we want to be able to wr-protect empty ptes too even for
>>> anonymous.
>>>
>>> This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
>>> uffd-wp handling on none ptes being consistent no matter what the memory
>>> type is underneath.  It doesn't have any impact on file memories so far
>>> because we already have pte markers taking care of that.  So it only
>>> affects anonymous.
>>>
>>> The feature bit is by default off, so the old behavior will be maintained.
>>> Sometimes it may be wanted because the wr-protect of none ptes will contain
>>> overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
>>> anonymous), but also on creating the pgtables to store the pte markers. So
>>> there's potentially less chance of using thp on the first fault for a none
>>> pmd or larger than a pmd.
>>>
>>> The major implementation part is teaching the whole kernel to understand
>>> pte markers even for anonymously mapped ranges, meanwhile allowing the
>>> UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
>>> new feature bit is set.
>>>
>>> Note that even if the patch subject starts with mm/uffd, there're a few
>>> small refactors to major mm path of handling anonymous page faults. But
>>> they should be straightforward.
>>>
>>> So far, add a very light smoke test within the userfaultfd kselftest
>>> pagemap unit test to make sure anon pte markers work.
>>>
>>> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
>>> [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>> v1->v2:
>>> - Use pte markers rather than populate zero pages when protect [David]
>>> - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
>>
>> Some very initial performance numbers (I only ran in a VM but it should be
>> similar, unit is "us") below as requested.  The measurement is about time
>> spent when wr-protecting 10G range of empty but mapped memory.  It's done
>> in a VM, assuming we'll get similar results on bare metal.
>>
>> Four test cases:
>>
>>          - default UFFDIO_WP
>>          - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
>>          - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
>>          - UFFDIO_WP with WP_UNPOPULATED
>>
>> Results:
>>
>>          Test DEFAULT: 2
>>          Test PRE-READ: 3277099 (pre-fault 3253826)
>>          Test MADVISE: 2250361 (pre-fault 2226310)
>>          Test WP-UNPOPULATE: 20850
> In your case:
> Default < WP-UNPOPULATE < MADVISE < PRE-READ
> 
> 
> In my testing on next-20230228 with this patch and my uffd async patch:
> 
> Test DEFAULT: 6
> Test PRE-READ: 37157 (pre-fault 37006)
> Test MADVISE: 4884 (pre-fault 4465)
> Test WP-UNPOPULATE: 17794
> 
> DEFAULT < MADVISE < WP-UNPOPULATE < PRE-READ
> 
> On my setup, MADVISE is performing better than WP-UNPOPULATE consistently.
> I'm not sure why I'm getting this discrepancy here. I've liked your results
> to be honest where we perform better with WP-UNPOPULATE than MADVISE. What
> can be done to get consistent benchmarks over your and my side?

Probably because the current approach from Peter uses uffd-wp markers, 
and these markers can currently only reside on the PTE level, not on the 
PMD level yet.

With MADVISE you get a huge zeropage and avoid dealing with PTEs.

-- 
Thanks,

David / dhildenb

