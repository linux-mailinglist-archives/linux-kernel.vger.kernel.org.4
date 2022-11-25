Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A463867E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKYJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKYJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB043AC30
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669369427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXKhQtd5gZA2xfcOJEvAfZHIl8ApkOHUD9XqmlMRrRQ=;
        b=SInfbFadxybSDu6hbnsNh5G00tjtXFweTanHC8RRb4+ZJ8BnMB0tAbFdDgBss6wc5mXd+n
        KRwWNYf9Io8BxwhEbdhrqozK/Nc6nVrFhNTYo3zBkhST6hmBTftDcxhorwsKEaVHkDdS29
        vDTynUFPKjx9Ule4mEXWQgvuFRUf/9M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-cU4YlnbJP1WvcRjA16tINQ-1; Fri, 25 Nov 2022 04:43:46 -0500
X-MC-Unique: cU4YlnbJP1WvcRjA16tINQ-1
Received: by mail-wm1-f69.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso1588527wml.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXKhQtd5gZA2xfcOJEvAfZHIl8ApkOHUD9XqmlMRrRQ=;
        b=wZ0C7MOQUwfmEzrLlzFi1mKgTk/HgsnfW8xYyxD6RNSjV2fZKbgyn2RqnkbxM9rXZ/
         xdJG1jPNQxBbTKCZqOBy7UOKTeub0qgyEb0GICht1ivvSjCeb8lXIHYKSueycyYeWjDv
         A4jHQc6XSaPZH/LuCdXq5xztq+kM3gl6wPH+U689KjzbNh+hA5EjzIGnWg6qI7ZT6TKX
         BqwRGzenKXDsh8fcR0IuW3hS9CUWHPCb/qA02fKUJrxbmDWQTUGadpCdv4Z2aYWQmjau
         KV1eYTuQtTxCOyOo9p7ZgKT3wRtkssihGXlgsH04jB6pb0vYRSkNRTaP79+m+bhkaeF9
         GSdA==
X-Gm-Message-State: ANoB5plb+R+WA02JzQ8egjAo00dbsnol508oAfzp4FC1b8D9znU8t/yo
        hDYfKCKL9Yt8Pd+bj5kYosqhx3zVAhIEqIJU8zrgsh3wjrSIBuEQN4wgBO/yrOnnek0Unj1iBsN
        HJslSS9BBA38P4C+NGPEwu4UE
X-Received: by 2002:a05:6000:235:b0:241:ebff:2db1 with SMTP id l21-20020a056000023500b00241ebff2db1mr7384592wrz.312.1669369424984;
        Fri, 25 Nov 2022 01:43:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7VIiPoSoU3Ki5OwEbdTwSzvsxV8hpzYvFC/I3WD5zI0Z5T2XOyqyoVn3IUyACdDDfisx52wQ==
X-Received: by 2002:a05:6000:235:b0:241:ebff:2db1 with SMTP id l21-20020a056000023500b00241ebff2db1mr7384564wrz.312.1669369424581;
        Fri, 25 Nov 2022 01:43:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08? (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de. [2003:cb:c704:d800:887:cbec:f31f:a08])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003cf6e1df4a8sm4604419wmb.15.2022.11.25.01.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:43:44 -0800 (PST)
Message-ID: <21278883-46a6-5a6a-fcf5-9a6ee6f632a9@redhat.com>
Date:   Fri, 25 Nov 2022 10:43:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com> <Y343kIQ9l2d8wViz@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
In-Reply-To: <Y343kIQ9l2d8wViz@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.22 16:09, Peter Xu wrote:
> Hi, David,
> 
> Thanks for taking a look.
> 
> On Wed, Nov 23, 2022 at 10:40:40AM +0100, David Hildenbrand wrote:
>> On 18.11.22 02:10, Peter Xu wrote:
>>> Based on latest mm-unstable (96aa38b69507).
>>>
>>> This can be seen as a follow-up series to Mike's recent hugetlb vma lock
>>> series for pmd unsharing, so this series also depends on that one.
>>> Hopefully this series can make it a more complete resolution for pmd
>>> unsharing.
>>>
>>> PS: so far no one strongly ACKed this, let me keep the RFC tag.  But I
>>> think I'm already more confident than many of the RFCs I posted.
>>>
>>> PS2: there're a lot of changes comparing to rfcv1, so I'm just not adding
>>> the changelog.  The whole idea is still the same, though.
>>>
>>> Problem
>>> =======
>>>
>>> huge_pte_offset() is a major helper used by hugetlb code paths to walk a
>>> hugetlb pgtable.  It's used mostly everywhere since that's needed even
>>> before taking the pgtable lock.
>>>
>>> huge_pte_offset() is always called with mmap lock held with either read or
>>> write.
>>>
>>> For normal memory types that's far enough, since any pgtable removal
>>> requires mmap write lock (e.g. munmap or mm destructions).  However hugetlb
>>> has the pmd unshare feature, it means not only the pgtable page can be gone
>>> from under us when we're doing a walking, but also the pgtable page we're
>>> walking (even after unshared, in this case it can only be the huge PUD page
>>> which contains 512 huge pmd entries, with the vma VM_SHARED mapped).  It's
>>> possible because even though freeing the pgtable page requires mmap write
>>> lock, it doesn't help us when we're walking on another mm's pgtable, so
>>> it's still on risk even if we're with the current->mm's mmap lock.
>>>
>>> The recent work from Mike on vma lock can resolve most of this already.
>>> It's achieved by forbidden pmd unsharing during the lock being taken, so no
>>> further risk of the pgtable page being freed.  It means if we can take the
>>> vma lock around all huge_pte_offset() callers it'll be safe.
> 
> [1]
> 
>>>
>>> There're already a bunch of them that we did as per the latest mm-unstable,
>>> but also quite a few others that we didn't for various reasons.  E.g. it
>>> may not be applicable for not-allow-to-sleep contexts like FOLL_NOWAIT.
>>> Or, huge_pmd_share() is actually a tricky user of huge_pte_offset(),
> 
> [2]
> 
>>> because even if we took the vma lock, we're walking on another mm's vma!
>>> Taking vma lock for all the vmas are probably not gonna work.
>>>
>>> I have totally no report showing that I can trigger such a race, but from
>>> code wise I never see anything that stops the race from happening.  This
>>> series is trying to resolve that problem.
>>
>> Let me try understand the basic problem first:
>>
>> hugetlb walks page tables semi-lockless: while we hold the mmap lock, we
>> don't grab the page table locks. That's very hugetlb specific handling and I
>> assume hugetlb uses different mechanisms to sync against MADV_DONTNEED,
>> concurrent page fault s... but that's no news. hugetlb is weird in many ways
>> :)
>>
>> So, IIUC, you want a mechanism to synchronize against PMD unsharing. Can't
>> we use some very basic locking for that?
> 

Sorry for the delay, finally found time to look into this again. :)

> Yes we can in most cases.  Please refer to above paragraph [1] where I
> referred Mike's recent work on vma lock.  That's the basic locking we need
> so far to protect pmd unsharing.  I'll attach the link too in the next
> post, which is here:
> 
> https://lore.kernel.org/r/20220914221810.95771-1-mike.kravetz@oracle.com
> 
>>
>> Using RCU / disabling local irqs seems a bit excessive because we *are*
>> holding the mmap lock and only care about concurrent unsharing
> 
> The series wanted to address where the vma lock is not easy to take.  It
> originates from when I was reading Mike's other patch, I forgot why I did
> that but I just noticed there's some code path that we may not want to take
> a sleepable lock, e.g. in follow page code.

As I stated, whenever we already take the (expensive) mmap lock, the 
least thing we should have to worry about is taking another sleepable 
lock IMHO. Please correct me if I'm wrong.

> 
> The other one is huge_pmd_share() where we may have the mmap lock for
> current mm but we're fundamentally walking another mm.  It'll be tricky to
> take a sleepable lock in such condition too.

We're already grabbing the i_mmap_lock_read(mapping), and the VMAs are 
should be stable in that interval tree IIUC. So I wonder if taking VMA 
locks would really be problematic here. Anything obvious I am missing?

> 
> I mentioned these cases in the other paragraph above [2].  Let me try to
> expand that in my next post too.

That would be great. I yet have to dedicate more time to understand all 
that complexity.

> 
> It's debatable whether all the rest places can only work with either RCU or
> irq disabled, but the idea is at least it should speed up those paths when
> we still can.  Here, irqoff might be a bit heavy, but RCU lock should be
> always superior to vma lock when possible, the payoff is we may still see
> stale pgtable data (since unsharing can still happen in parallel), while
> that can be completely avoided when we take the vma lock.

IRQ disabled is frowned upon by RT folks, that's why I'd like to 
understand if this is really required. Also, adding RCU to an already 
complex mechanism doesn't necessarily make it easier :)

Let me dedicate some time today to dig into some details.

-- 
Thanks,

David / dhildenb

