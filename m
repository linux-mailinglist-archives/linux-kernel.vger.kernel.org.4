Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE7617B16
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKCKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C35FEF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667472690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfIKIj2BjovO2d1TGoZmkvSnm5ERGLD9n+Op2feiHhQ=;
        b=gPYVOwkOTGn8dV+KQvkAMoefKUOVNlBpjF7NZaN8k4IZGnxwe5H9c0vM4DoC8tFlnRjNOQ
        OR/RiEWBAK+VlVJXsZT9tQHNR9hNUztOs5KXwLEOp5sMLEJ+LNAyZe89gDkC6tuiAd2K4w
        mrSVG+780DrPHX5BiXtdSFljENRW7R0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-KjVhIcaAPtWo-AaHNtJaHA-1; Thu, 03 Nov 2022 06:51:29 -0400
X-MC-Unique: KjVhIcaAPtWo-AaHNtJaHA-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso364084wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 03:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfIKIj2BjovO2d1TGoZmkvSnm5ERGLD9n+Op2feiHhQ=;
        b=SFqIGYbwMFGXkbE/8DMfEaEAda0VCh/s4hfa9DJoe1Sy8vbmJvOdnilMCb0WANf679
         Thgpc6ZKocqC7eDf6Kw5yMowubMUMLI0rcnYsj7oAZ1XudojJxJse32WzqZfNu2gUv/s
         T0/q1vgMupfr6VsO6v7BVu01OR/3PoIJYe8SwqKxVKfRsJzqr/WJPDzxIVn2OvzR0HR1
         kfx9tjUG2rUi6jER5dFPOHUemCeK9v9XzoayH9x97m9JjKC9Qs2DcA267r6YLUnDoOVF
         PLbTtKJ33wS+V/6XcnNNklGdLIFb4NNtiZu5jTJ8qw1fcbOM1hC36+dAApEaLw4wAJAb
         Tlew==
X-Gm-Message-State: ACrzQf0NQ/IByWSUZfP3iAt3kZwqXl9vXbzXrLypThCK8Y9S1uYsQP1L
        A2x3/PyzJcvhaEewZ+Pjlfp6i5dxnWgDBVk0vMl0bJrll6zlHW900rEwQL8UZHLxaPwO5PB0lbN
        BgsQvJmW5EUW+DaPpHYpwGORz
X-Received: by 2002:adf:ef04:0:b0:236:b58b:3166 with SMTP id e4-20020adfef04000000b00236b58b3166mr17225496wro.330.1667472687951;
        Thu, 03 Nov 2022 03:51:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM52izUu3gFCfTKRloSM1S8x1tX0BSlp+bZPkawxYPtXps575wscWANLRETsddgGMrTKtKfmIQ==
X-Received: by 2002:adf:ef04:0:b0:236:b58b:3166 with SMTP id e4-20020adfef04000000b00236b58b3166mr17225473wro.330.1667472687582;
        Thu, 03 Nov 2022 03:51:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:a400:e2d7:3ee3:8d35:ac8? (p200300cbc707a400e2d73ee38d350ac8.dip0.t-ipconnect.de. [2003:cb:c707:a400:e2d7:3ee3:8d35:ac8])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003b4ac05a8a4sm5720194wmo.27.2022.11.03.03.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 03:51:27 -0700 (PDT)
Message-ID: <ea2b584d-ce66-dcb0-a667-bdf259bdf194@redhat.com>
Date:   Thu, 3 Nov 2022 11:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 4/6] mm/autonuma: use can_change_(pte|pmd)_writable()
 to replace savedwrite
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Chinner <david@fromorbit.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20221102191209.289237-1-david@redhat.com>
 <20221102191209.289237-5-david@redhat.com>
 <F3022E28-3BB5-40F5-B33A-9BDBD69ACC78@vmware.com>
 <37192084-fc78-2d51-3bcf-1454248dcc74@redhat.com>
Organization: Red Hat
In-Reply-To: <37192084-fc78-2d51-3bcf-1454248dcc74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.22 11:45, David Hildenbrand wrote:
> On 02.11.22 22:22, Nadav Amit wrote:
>> On Nov 2, 2022, at 12:12 PM, David Hildenbrand <david@redhat.com> wrote:
>>
>>> !! External Email
>>>
>>> commit b191f9b106ea ("mm: numa: preserve PTE write permissions across a
>>> NUMA hinting fault") added remembering write permissions using ordinary
>>> pte_write() for PROT_NONE mapped pages to avoid write faults when
>>> remapping the page !PROT_NONE on NUMA hinting faults.
>>>
>>
>> [ snip ]
>>
>> Here’s a very shallow reviewed with some minor points...
> 
> Appreciated.
> 
>>
>>> ---
>>> include/linux/mm.h |  2 ++
>>> mm/huge_memory.c   | 28 +++++++++++++++++-----------
>>> mm/ksm.c           |  9 ++++-----
>>> mm/memory.c        | 19 ++++++++++++++++---
>>> mm/mprotect.c      |  7 ++-----
>>> 5 files changed, 41 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 25ff9a14a777..a0deeece5e87 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1975,6 +1975,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
>>> #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>>>                                              MM_CP_UFFD_WP_RESOLVE)
>>>
>>> +bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>>> +                            pte_t pte);
>>
>> It might not be customary, but how about marking it as __pure?
> 
> Right, there is no a single use of __pure in the mm domain.
> 
>>
>>> extern unsigned long change_protection(struct mmu_gather *tlb,
>>>                                struct vm_area_struct *vma, unsigned long start,
>>>                                unsigned long end, pgprot_t newprot,
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2ad68e91896a..45abd27d75a0 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1462,8 +1462,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>          unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>>          int page_nid = NUMA_NO_NODE;
>>>          int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>>> -       bool migrated = false;
>>> -       bool was_writable = pmd_savedwrite(oldpmd);
>>> +       bool try_change_writable, migrated = false;
>>>          int flags = 0;
>>>
>>>          vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>> @@ -1472,13 +1471,22 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>                  goto out;
>>>          }
>>>
>>> +       /* See mprotect_fixup(). */
>>> +       if (vma->vm_flags & VM_SHARED)
>>> +               try_change_writable = vma_wants_writenotify(vma, vma->vm_page_prot);
>>> +       else
>>> +               try_change_writable = !!(vma->vm_flags & VM_WRITE);
>>
>> Do you find it better to copy the code instead of extracting it to a
>> separate function?
> 
> Yeah, you're right ;) usually the issue is coming up with a suitable name. Let me try.
> 
> vma_wants_manual_writability_change() hmm ...
> 
>>
>>> +
>>>          pmd = pmd_modify(oldpmd, vma->vm_page_prot);
>>>          page = vm_normal_page_pmd(vma, haddr, pmd);
>>>          if (!page)
>>>                  goto out_map;
>>>
>>>          /* See similar comment in do_numa_page for explanation */
>>> -       if (!was_writable)
>>> +       if (try_change_writable && !pmd_write(pmd) &&
>>> +            can_change_pmd_writable(vma, vmf->address, pmd))
>>> +               pmd = pmd_mkwrite(pmd);
>>> +       if (!pmd_write(pmd))
>>>                  flags |= TNF_NO_GROUP;
>>>
>>>          page_nid = page_to_nid(page);
>>> @@ -1523,8 +1531,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>          /* Restore the PMD */
>>>          pmd = pmd_modify(oldpmd, vma->vm_page_prot);
>>>          pmd = pmd_mkyoung(pmd);
>>> -       if (was_writable)
>>> +
>>> +       /* Similar to mprotect() protection updates, avoid write faults. */
>>> +       if (try_change_writable && !pmd_write(pmd) &&
>>> +            can_change_pmd_writable(vma, vmf->address, pmd))
>>
>> Why do I have a deja-vu? :)
>>
>> There must be a way to avoid the redundant code and specifically the call to
>> can_change_pmd_writable(), no?
> 
> The issue is that as soon as we drop the page table lock, that information is stale.
> Especially, after we fail migration.
> 
> So the following should work, however, if we fail migration we wouldn't map the
> page writable and would have to re-calculate:
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c5599a9279b1..a997625641e4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4674,10 +4674,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>           struct vm_area_struct *vma = vmf->vma;
>           struct page *page = NULL;
>           int page_nid = NUMA_NO_NODE;
> +       bool writable = false;
>           int last_cpupid;
>           int target_nid;
>           pte_t pte, old_pte;
> -       bool was_writable = pte_savedwrite(vmf->orig_pte);
>           int flags = 0;
>    
>           /*
> @@ -4696,6 +4696,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>           old_pte = ptep_get(vmf->pte);
>           pte = pte_modify(old_pte, vma->vm_page_prot);
>    
> +       /*
> +        * Detect now whether the PTE is or can be writable. Note that this
> +        * information is valid as long as we're holding the PT lock, so also on
> +        * the remap path below.
> +        */
> +       writable = pte_write(pte);
> +       if (!writable && vma_wants_manual_writability_change(vma) &&
> +           can_change_pte_writable(vma, vmf->address, pte);
> +           writable = true;
> +       }
> +
>           page = vm_normal_page(vma, vmf->address, pte);
>           if (!page || is_zone_device_page(page))
>                   goto out_map;
> @@ -4712,7 +4723,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>            * pte_dirty has unpredictable behaviour between PTE scan updates,
>            * background writeback, dirty balancing and application behaviour.
>            */
> -       if (!was_writable)
> +       if (!writable)
>                   flags |= TNF_NO_GROUP;
>    
>           /*
> @@ -4738,6 +4749,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>                   put_page(page);
>                   goto out_map;
>           }
> +       writable = false;
>           pte_unmap_unlock(vmf->pte, vmf->ptl);
>    
>           /* Migrate to the requested node */
> @@ -4767,7 +4779,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>           old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
>           pte = pte_modify(old_pte, vma->vm_page_prot);
>           pte = pte_mkyoung(pte);
> -       if (was_writable)
> +       if (writable)
>                   pte = pte_mkwrite(pte);
>           ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
>           update_mmu_cache(vma, vmf->address, vmf->pte);
> 
> 
> To me, the less error-prone approach is to re-calculate.

Hmm, thinking again, the "if (unlikely(!pte_same(*vmf->pte, 
vmf->orig_pte))) {" check might actually not require us to recalculate.

-- 
Thanks,

David / dhildenb

