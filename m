Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31F65CF77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjADJWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbjADJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A213D24
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672824056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QImjhOOloK+pXhrUnbGTzQOZj09SqLqo9+7GOgPxUls=;
        b=IarpIBuK91MwxX1TY7vmZBkT/mEs+06XdSdOF/q6Hn8+6SjaGGBFGK7O392m92zmCvTNFu
        iM5qUUIaiK94+VbNV4taiTUj3xZtGlMxmiT4HyUV2GflaShTVYPyxGGQRTM4HsxFf5rYHH
        VM8ou4EHC4eFpXqZH1bqn7CEAxHoD60=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-HeM064lVMeKcx-o-ubk2tw-1; Wed, 04 Jan 2023 04:20:54 -0500
X-MC-Unique: HeM064lVMeKcx-o-ubk2tw-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cf00b003d9a14517b2so8398277wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QImjhOOloK+pXhrUnbGTzQOZj09SqLqo9+7GOgPxUls=;
        b=sUKmVE3NocgkWmvp6Iz6jkVjG2eX8IN1L0DAygaU0KHQiRAsLJrfAuXa/G6NijyA08
         m1WVNk7IEPOTnL2zqdtD81rhkdeg3tBn91Q3QEU4z9c93bT3amlccJ3ZAOCzPBYWfUP0
         OBGfCgoHowrv7PkBFu5RPjthX0mQsQgtymk31thjWIR56pCoCmlCaZCnn5OQjzI8/R4F
         dPVUPaqZWFRBe4xwyeBV7uIevg21VRTGTceEbGj39fJjZ+UuxXZoU68Gqe/gTkc/2CBD
         pcPJpyhYabXRXZPNf60SmpXp1HSMSAUVibqlwGWz3zrxkGIuZ1A5j/xVxAdKaz9NtIdX
         IQIw==
X-Gm-Message-State: AFqh2kq495APugCQk/+x24eXRchTQ7YvsCtSz3kHGM7HAPerVL2mXiNa
        d3hQsJyijkf5ngfCWjWE7ABjaBeBQHCYuokthSYPHDC/3B7ztKSfWo4QYkaXiYlQ/FGXYyk1owe
        ic/OuU69YiMWOqTcuhyRyuTUY
X-Received: by 2002:a7b:c4c8:0:b0:3d3:5a4a:9101 with SMTP id g8-20020a7bc4c8000000b003d35a4a9101mr36678243wmk.23.1672824053247;
        Wed, 04 Jan 2023 01:20:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuQGb/xlc8uVJfpF+0B9Kv9Yf6rBAZA/sTj1jXoQbUI6TjsIqRmKP5YuBzh4FDJj7hqyhEs1A==
X-Received: by 2002:a7b:c4c8:0:b0:3d3:5a4a:9101 with SMTP id g8-20020a7bc4c8000000b003d35a4a9101mr36678230wmk.23.1672824052962;
        Wed, 04 Jan 2023 01:20:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:f100:8100:5a6c:eb:fd3b? (p200300cbc703f10081005a6c00ebfd3b.dip0.t-ipconnect.de. [2003:cb:c703:f100:8100:5a6c:eb:fd3b])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003d04e4ed873sm34465384wmo.22.2023.01.04.01.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 01:20:52 -0800 (PST)
Message-ID: <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com>
Date:   Wed, 4 Jan 2023 10:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
 <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
In-Reply-To: <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Or am I wrong?
>>
>>> Is anon_vma lock required?  Almost not: if any page other than expected
>>> subpage of the non-anon huge page is found in the page table, collapse is
>>> aborted without making any change.  However, it is possible that an anon
>>> page was CoWed from this extent in another mm or vma, in which case a
>>> concurrent lookup might look here: so keep it away while clearing pmd
>>> (but perhaps we shall go back to using pmd_lock() there in future).
>>>
>>> Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
>>> without having cleared its ptes: I'm uneasy about that, and had thought
>>> pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
>>> and we would have to move the mmu_notification if clearing those ptes.
>>>
>>> Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table
>>> retraction")
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> Cc: Jann Horn <jannh@google.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Zach O'Keefe <zokeefe@google.com>
>>> Cc: Song Liu <songliubraving@fb.com>
>>> Cc: <stable@vger.kernel.org>    [5.4+]
>>> ---
>>> What this fixes is not a dangerous instability!  But I suggest Cc stable
>>> because uprobes "healing" has regressed in that way, so this should follow
>>> 8d3c106e19e8 into those stable releases where it was backported (and may
>>> want adjustment there - I'll supply backports as needed).
>>
>> If it's really something that doesn't matter in practice (e.g., -1%
>> performance while debugging :) ), I guess no CC is needed. If there are real
>> production workloads that suffer, I guess ccing stable is fine.
> 
> It's about recovering performance *after* debugging.  It is not something
> that is of any value to me personally, nor (so far as I know) to anyone
> whom I work with.  But it is something which Song Liu went to the trouble
> to make possible in his "THP aware uprobe" series three years ago, and it
> is something which Jann unintentionally regressed in his recent commit:
> so I thought it proper to reinstate where regressed.

Right, although I wonder if that original series fixed a real 
performance issue or was more a "this makes sense, let's just optimize 
this corner case by some serious complexity". I hope it's not the latter :)

> 
> (What I do have more of an investment in, is for MADV_COLLAPSE to be able
> to collapse some extents in a large vma where some other extent got CoWed,
> so giving the whole vma an anon_vma.  But that's not an issue for -stable,
> and I cannot tell you offhand whether undoing this anon_vma exclusion is
> enough to enable that or not - I suspect not, I suspect a result code or
> switch statement needs to be adjusted too.)

Yeah, having a single COWed page in a large MAP_PRIVATE file/shmem 
mapping would disable collapse, so it's the right thing to do.

Thinking about it some more, and the effective code change, stable 
doesn't sound wrong.

>>
>>
>> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
>> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
>> writable or not. Turns out it's communicated via vm_fault->flags. Just
>> horrible.
> 
> I firmly disagree - it's from 2022! and much too small to be ugliest;
> but I haven't thought about the aspect that is bothering you there.

The ugliest I stumbled over in early 2023 -- until January 2nd :D

> 
> What's bothered me most about it, is the way its name, and the naming of
> the do_set_pmd() it interfaces with, give no hint that they are entirely
> about file (or shmem) vmas, and would not work right on anon vmas
> (I forget whether it's just a matter of which stats updated, or more).

Yes. I dug very deep into in-place collapse yesterday because I was 
briefly concerned about anon THP, and it took me longer to understand 
that whole machinery than it should (and that anon THP never ever 
collapse in-place).

Some of that khugepaged stuff needs some *serious* cleanups and 
refactoring. do_set_pmd() is not an exception.


Some more examples:

if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
	...
	hpage_collapse_scan_file()
} else {
	hpage_collapse_scan_pmd()
	...
}


1) hpage_collapse_scan_pmd() is only for anon memory. Totally obvious
    from the name. But why are we potentially calling it for VMAs that
    are not applicable? For maximum David confusion?

2) "IS_ENABLED(CONFIG_SHMEM) && vma->vm_file" is also supposed to cover
    ordinary file-thp. Totally obvious from the IS_ENABLED(CONFIG_SHMEM)
    ... I probably spent 30minutes understanding what's happening here.
    Just misleading and wrong without CONFIG_SHMEM.


... and what's easier to get than this magic set of boolean flags:

	hugepage_vma_check(vma, vma->vm_flags, false, false, true)

... and obviously
	hugepage_vma_revalidate()
is supposed to be a follow up to a previous
	hugepage_vma_check()
and totally different from
	transhuge_vma_suitable()

Hard to make it even less consistent.

Also, it's very clear from the code that SCAN_PTE_MAPPED_HUGEPAGE only 
applies to file-thp, right? No.

-- 
Thanks,

David / dhildenb

