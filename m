Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184C1655AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiLXRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLXRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 12:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2568C2603
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671901191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zi9z1mc5tct2OqLs3x0XC3e3royxe6qT3uotyRD/VDI=;
        b=d1vRuQpG4htN1432hlk4bN3eDNi9JBodZwrh9yh6NJK1BKbLaeZhNm9dY6LGEsK4owv5xM
        vgPFz3YLF0KWEzFnB1wwMXEBaY+3WYQeAVRnPffGSI4kEYohteWppuuDpL/NS/rQQ1t25g
        9f19yJgUFvgwPms18U75rvJ68WJ6YVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-hSzByjxeNZSX84wzxHQvYQ-1; Sat, 24 Dec 2022 11:59:49 -0500
X-MC-Unique: hSzByjxeNZSX84wzxHQvYQ-1
Received: by mail-wm1-f72.google.com with SMTP id m8-20020a05600c3b0800b003d96bdce12fso2102243wms.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi9z1mc5tct2OqLs3x0XC3e3royxe6qT3uotyRD/VDI=;
        b=hXuse6U6S7NMovtxP27nq1uIfwCkGyY+WVoD7bSl3mHs8HGvUl8LQDH0Wt9FAB/IyM
         LNyA2YaVcKt2Ax3tqN9ysrGoWGg+sntx9M+DRjR4seVSPg8ONulLYfXInX32HzY+ar+k
         DgzTaZlBTm4too+dypW58u1z1ATlDDDLL+8C3ZrxS/VuAI7ADI+xVYVuRWJ7Ctu8L57j
         mvGihlXmipssqYNB+vMNNttP9MIdam527ugwBBtNID5HaJxRU6VFHq8xjefMGmijGKRD
         7H+oLi0BcRPfSftQnuEezeROH9fqwYr1sVsdh3CeMxNOx5b7bUAqVlweaQ0avyiMEnGz
         72dQ==
X-Gm-Message-State: AFqh2kreEXwFugaNeZzeJxPvVSps7hNkegVO9h+4qTeA10e+u5ZHq2A8
        fH6yNstQte0I/g2iLETAsQSd0B7uyFP2FcPpFdp/SbJWZ7s3slbgeKRQM5IkcR4Ws6WJdbmCHgp
        nv2T0YqghNTKIC24xz2XaJphsrmW/Pm9FqfXyHTXlRJhGv7EWBmHjiw7bIS3XlCM6NhJHBReN
X-Received: by 2002:a05:600c:34d3:b0:3c6:e61e:ae74 with SMTP id d19-20020a05600c34d300b003c6e61eae74mr11675832wmq.4.1671901188847;
        Sat, 24 Dec 2022 08:59:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtDOuWW0o5NMKEEoENCst0sHVaIxFgrtRrGiP7J3uJ4XL6zV86Juaiob1DDiIFd9D6T2mG2ZA==
X-Received: by 2002:a05:600c:34d3:b0:3c6:e61e:ae74 with SMTP id d19-20020a05600c34d300b003c6e61eae74mr11675815wmq.4.1671901188517;
        Sat, 24 Dec 2022 08:59:48 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c191400b003b4fe03c881sm14564744wmq.48.2022.12.24.08.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 08:59:48 -0800 (PST)
Message-ID: <71412742-a71f-9c74-865f-773ad83db7a5@redhat.com>
Date:   Sat, 24 Dec 2022 17:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/2] mm/userfaultfd: rely on vma->vm_page_prot in
 uffd_wp_range()
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221223155616.297723-1-david@redhat.com>
 <20221223155616.297723-2-david@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221223155616.297723-2-david@redhat.com>
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
> uffd_wp_range() currently calculates page protection manually using
> vm_get_page_prot(). This will ignore any other reason for active
> writenotify: one mechanism applicable to shmem is softdirty tracking.
> 
> For example, the following sequence
> 
> 1) Write to mapped shmem page
> 2) Clear softdirty
> 3) Register uffd-wp covering the mapped page
> 4) Unregister uffd-wp covering the mapped page
> 5) Write to page again
> 
> will not set the modified page softdirty, because uffd_wp_range() will
> ignore that writenotify is required for softdirty tracking and simply map
> the page writable again using change_protection(). Similarly, instead of
> unregistering, protecting followed by un-protecting the page using
> uffd-wp would result in the same situation.
> 
> Now that we enable writenotify whenever enabling uffd-wp on a VMA,
> vma->vm_page_prot will already properly reflect our requirements: the
> default is to write-protect all PTEs. However, for shared mappings we
> would now not remap the PTEs writable if possible when unprotecting, just
> like for private mappings (COW). To compensate, set
> MM_CP_TRY_CHANGE_WRITABLE just like mprotect() does to try mapping
> individual PTEs writable.
> 
> For private mappings, this change implies that we will now always try
> setting PTEs writable when un-protecting, just like when upgrading write
> permissions using mprotect(), which is an improvement.
> 
> For shared mappings, we will only set PTEs writable if
> can_change_pte_writable()/can_change_pmd_writable() indicates that it's
> ok. For ordinary shmem, this will be the case when PTEs are dirty, which
> should usually be the case -- otherwise we could special-case shmem in
> can_change_pte_writable()/can_change_pmd_writable() easily, because
> shmem itself doesn't require writenotify.
> 
> Note that hugetlb does not yet implement MM_CP_TRY_CHANGE_WRITABLE, so we
> won't try setting PTEs writable when unprotecting or when unregistering
> uffd-wp. This can be added later on top by implementing
> MM_CP_TRY_CHANGE_WRITABLE.
> 
> While commit ffd05793963a ("userfaultfd: wp: support write protection for
> userfault vma range") introduced that code, it should only be applicable
> to uffd-wp on shared mappings -- shmem (hugetlb does not support softdirty
> tracking). I don't think this corner cases justifies to cc stable. Let's
> just handle it correctly and prepare for change_protection() cleanups.
> 
> Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/userfaultfd.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 0499907b6f1a..351e8d6b398b 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -727,17 +727,25 @@ ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
>   void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
>   		   unsigned long start, unsigned long len, bool enable_wp)
>   {
> +	unsigned int mm_cp_flags;
>   	struct mmu_gather tlb;
> -	pgprot_t newprot;
>   
>   	if (enable_wp)
> -		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
> +		mm_cp_flags = MM_CP_UFFD_WP;
>   	else
> -		newprot = vm_get_page_prot(dst_vma->vm_flags);
> +		mm_cp_flags = MM_CP_UFFD_WP_RESOLVE;
>   
> +	/*
> +	 * vma->vm_page_prot already reflects that uffd-wp is enabled for this
> +	 * VMA (see userfaultfd_set_vm_flags()) and that all PTEs are supposed
> +	 * to be write-protected as default whenever protection changes.
> +	 * Try upgrading write permissions manually.
> +	 */
> +	if (vma_wants_manual_pte_write_upgrade(dst_vma))
> +		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
>   	tlb_gather_mmu(&tlb, dst_mm);
> -	change_protection(&tlb, dst_vma, start, start + len, newprot,
> -			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
> +	change_protection(&tlb, dst_vma, start, start + len, vma->vm_page_prot,
> +			  mm_cp_flags);
>   	tlb_finish_mmu(&tlb);
>   }
>   

The following optimization makes sense:

 From 779b36768328d99dbcc96fbba7be8b50536ce350 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sat, 24 Dec 2022 15:02:36 +0100
Subject: [PATCH] fixup: mm/userfaultfd: enable writenotify while
  userfaultfd-wp is enabled for a VMA

No need for additional harmless checks if we're wr-protecting either way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/userfaultfd.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index be7ee9d82e72..1ac1de527719 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -741,7 +741,7 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
  	 * to be write-protected as default whenever protection changes.
  	 * Try upgrading write permissions manually.
  	 */
-	if (vma_wants_manual_pte_write_upgrade(dst_vma))
+	if (!enable_wp && vma_wants_manual_pte_write_upgrade(dst_vma))
  		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
  	tlb_gather_mmu(&tlb, dst_mm);
  	change_protection(&tlb, dst_vma, start, start + len, mm_cp_flags);
-- 
2.38.1


-- 
Thanks,

David / dhildenb

