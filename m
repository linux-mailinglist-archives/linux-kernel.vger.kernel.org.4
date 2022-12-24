Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4917F655AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 18:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiLXRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 12:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 12:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877719F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671901279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwbO8aetiymc8USYx00SlW0UU+lEJdIpUp8WjZIYvSA=;
        b=ImIKN6mC/E8Jo1ak2Mb7+l+GOJy2urCt2tjLIV8iRZlxJQf5UHdGHXwBJlrFnFtc4i1Nc/
        uDc5dcleGl2pjOfBBOXdL7M6nD0EhAis4dIMWKib8lrfepu1v9p2OsA2WhL5GxJFhvvQRK
        hJgNH/DeeuYPfZdxMTg+9fSC7RwedNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-Z3ClrBZuNluMTlp2F-eUxA-1; Sat, 24 Dec 2022 12:01:17 -0500
X-MC-Unique: Z3ClrBZuNluMTlp2F-eUxA-1
Received: by mail-wr1-f70.google.com with SMTP id v4-20020adfa1c4000000b002753317406aso383045wrv.21
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 09:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwbO8aetiymc8USYx00SlW0UU+lEJdIpUp8WjZIYvSA=;
        b=Kl84qmORlrGEkDGzopcVLmK58qkHtKKTk8EGJC1IIOBo0jzFY5x2Ql5FL9G9VBzHNy
         X6UVHlATxsY2Dt72RWZglePD9W8vaf0tYdGlUhSRAKfT8XK7XxYi29H10m1i7TjSbMdC
         FJBs9M5k3YhOXvlUEaXWEaNz0hfjJPqHm4vzsqdwL7qwD+Mp/5osKozvDNj58iWHZv5E
         XxBRhy5QaU+XKliJwaJUk2mBk9VSK7T3HP3/HySg+FtWlOyOnLYWBGFfk6mH2yPTC+Wr
         h2dWbBKBbeuSSYjxej0VGqgrQYWIo1aKjw6nJsa/TdQr7vSYxjSxK96lDsfw6Nq7UPyA
         PmTQ==
X-Gm-Message-State: AFqh2krRCR9GG2opHxg4ntVWJn9UE1pPeFg3mhPx0HF/KkQHc3WRstz8
        RglARSFHxJijWmHbaDJrtUOeA9KzKrCO0D5N/2CFUB4QzOVShwUBRKUVkQNoTISRLKlYzb8jHxX
        l5w7nrjgqLy7lVtZYQsitMIFCG0vj77ehXkDZfhp7QHwli8q9PIwdAiND4rv2yMES4ia+TqG7
X-Received: by 2002:a05:600c:3b93:b0:3d3:43ae:4d10 with SMTP id n19-20020a05600c3b9300b003d343ae4d10mr10334982wms.11.1671901276734;
        Sat, 24 Dec 2022 09:01:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu69zJB67skVTScKbwc6lKTQUqPaONoZ8CnApfkkAeSSx0dGGEwnpdyc06xrriycDFh+t+wRA==
X-Received: by 2002:a05:600c:3b93:b0:3d3:43ae:4d10 with SMTP id n19-20020a05600c3b9300b003d343ae4d10mr10334965wms.11.1671901276436;
        Sat, 24 Dec 2022 09:01:16 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b003b95ed78275sm8836047wmq.20.2022.12.24.09.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 09:01:15 -0800 (PST)
Message-ID: <5084ff1c-ebb3-f918-6a60-bacabf550a88@redhat.com>
Date:   Sat, 24 Dec 2022 18:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 2/2] mm/mprotect: drop pgprot_t parameter from
 change_protection()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221223155616.297723-1-david@redhat.com>
 <20221223155616.297723-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221223155616.297723-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.12.22 16:56, David Hildenbrand wrote:
> Being able to provide a custom protection opens the door for
> inconsistencies and BUGs: for example, accidentally allowing for more
> permissions than desired by other mechanisms (e.g., softdirty tracking).
> vma->vm_page_prot should be the single source of truth.
> 
> Only PROT_NUMA is special: there is no way we can erroneously allow
> for more permissions when removing all permissions. Special-case using
> the MM_CP_PROT_NUMA flag.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h |  3 +--
>   mm/mempolicy.c     |  3 +--
>   mm/mprotect.c      | 14 +++++++++++---
>   mm/userfaultfd.c   |  3 +--
>   4 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3f196e4d66d..b8be8c33ca20 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2148,8 +2148,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>   			     pte_t pte);
>   extern unsigned long change_protection(struct mmu_gather *tlb,
>   			      struct vm_area_struct *vma, unsigned long start,
> -			      unsigned long end, pgprot_t newprot,
> -			      unsigned long cp_flags);
> +			      unsigned long end, unsigned long cp_flags);
>   extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   			  struct vm_area_struct **pprev, unsigned long start,
>   			  unsigned long end, unsigned long newflags);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 61aa9aedb728..c3f02703a710 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -635,8 +635,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>   
>   	tlb_gather_mmu(&tlb, vma->vm_mm);
>   
> -	nr_updated = change_protection(&tlb, vma, addr, end, PAGE_NONE,
> -				       MM_CP_PROT_NUMA);
> +	nr_updated = change_protection(&tlb, vma, addr, end, MM_CP_PROT_NUMA);
>   	if (nr_updated)
>   		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
>   
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 908df12caa26..569cefa668a6 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -503,13 +503,21 @@ static unsigned long change_protection_range(struct mmu_gather *tlb,
>   
>   unsigned long change_protection(struct mmu_gather *tlb,
>   		       struct vm_area_struct *vma, unsigned long start,
> -		       unsigned long end, pgprot_t newprot,
> -		       unsigned long cp_flags)
> +		       unsigned long end, unsigned long cp_flags)
>   {
> +	pgprot_t newprot = vma->vm_page_prot;
>   	unsigned long pages;
>   
>   	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
>   
> +	/*
> +	 * Ordinary protection updates (mprotect, uffd-wp, softdirty tracking)
> +	 * are expected to reflect their requirements via VMA flags such that
> +	 * vma_set_page_prot() will adjust vma->vm_page_prot accordingly.
> +	 */
> +	if (cp_flags & MM_CP_PROT_NUMA)
> +		newprot = PAGE_NONE;
> +
>   	if (is_vm_hugetlb_page(vma))
>   		pages = hugetlb_change_protection(vma, start, end, newprot,
>   						  cp_flags);
> @@ -638,7 +646,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
>   	vma_set_page_prot(vma);
>   
> -	change_protection(tlb, vma, start, end, vma->vm_page_prot, mm_cp_flags);
> +	change_protection(tlb, vma, start, end, mm_cp_flags);
>   
>   	/*
>   	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 351e8d6b398b..be7ee9d82e72 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -744,8 +744,7 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
>   	if (vma_wants_manual_pte_write_upgrade(dst_vma))
>   		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
>   	tlb_gather_mmu(&tlb, dst_mm);
> -	change_protection(&tlb, dst_vma, start, start + len, vma->vm_page_prot,
> -			  mm_cp_flags);
> +	change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
>   	tlb_finish_mmu(&tlb);
>   }
>   

The following fix for compilation errors without PAGE_NONE:


 From a164d6cf728e353294aa9e65b8ead5241c800421 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sat, 24 Dec 2022 15:01:18 +0100
Subject: [PATCH] fixup: mm/mprotect: drop pgprot_t parameter from
  change_protection()

PAGE_NONE might not be defined without CONFIG_NUMA_BALANCING

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/mprotect.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 569cefa668a6..809832954898 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -510,6 +510,7 @@ unsigned long change_protection(struct mmu_gather *tlb,
  
  	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
  
+#ifdef CONFIG_NUMA_BALANCING
  	/*
  	 * Ordinary protection updates (mprotect, uffd-wp, softdirty tracking)
  	 * are expected to reflect their requirements via VMA flags such that
@@ -517,6 +518,9 @@ unsigned long change_protection(struct mmu_gather *tlb,
  	 */
  	if (cp_flags & MM_CP_PROT_NUMA)
  		newprot = PAGE_NONE;
+#else
+	WARN_ON_ONCE(cp_flags & MM_CP_PROT_NUMA);
+#endif
  
  	if (is_vm_hugetlb_page(vma))
  		pages = hugetlb_change_protection(vma, start, end, newprot,
-- 
2.38.1



-- 
Thanks,

David / dhildenb

