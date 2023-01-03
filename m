Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887065CA26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjACXFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjACXFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C513F3C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672787097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsV4iw9XRai6TVSACmsV0RGWy9G55hSnzu9m14iwstk=;
        b=HKyurcJilufKQDSYGOZtpzFLaIJLWEJpebgbfdwWVJoHhfGYiSKBbIv8feuaUT4YzNSmDT
        CB5L/Nt4mH1nGr8iSw4MxM6SSZ1vtpsIWzNIZ3qHGJ3scBsGGbg41sCreNyyXB+J3o1z3o
        d4e3+bQzj71QeEvCP1/j9qlcNcSE9Z8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-3amrKK11PPuHN8ZMWVxHbQ-1; Tue, 03 Jan 2023 18:04:54 -0500
X-MC-Unique: 3amrKK11PPuHN8ZMWVxHbQ-1
Received: by mail-qt1-f199.google.com with SMTP id cf23-20020a05622a401700b003ab6e87db28so9980031qtb.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsV4iw9XRai6TVSACmsV0RGWy9G55hSnzu9m14iwstk=;
        b=04RuUC76v2WyRIj+Hq2MDSD1SVdrcxnKelFhcdwvHAC1sfwonaY38TJnAkJZEijkAY
         ujmIbUKOQMJdlQXT3lBVAb6/mIzQ+g3O4sVE4QVbaEDoiBt0zsouRGfrTlXnCSFmDszj
         1FRpERn+/9KjnUNunqq+1/O5HiUO4guViCcMJlTH12p7Fr6ernsA4YI6sn/N3ti1yaDq
         dOd+wBbv8ba8N+qbogANLe9J1xI1OgV5Xd7i3edY0JRoSpR91LzlyeWbboNJgWJSQmPu
         NuYLCd2E31VPwLKyvPdSQb4JQsfjHDdVkp5oQXwyOrLwFI47JgeDm4lxp2gmgzIcgQdZ
         BPCg==
X-Gm-Message-State: AFqh2kouuZLQN6YabEwodohlUSMg4S1noba/x+6wbCPvwyiRU6eyNvCT
        UiNU7lA3EspxnYzmMixRiFJSpuSU4XSDMEuhiKY9tX+UqwgHyx2/ypURz2P5N6tTbtbCm+qvr7y
        SmCcmIG6bHFXNNq5oDdtgYRlZ
X-Received: by 2002:ac8:5c12:0:b0:3a6:18ff:c6e2 with SMTP id i18-20020ac85c12000000b003a618ffc6e2mr90195692qti.28.1672787094133;
        Tue, 03 Jan 2023 15:04:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtJiAAjxhaa62K5E5gNgeQKrZG8BuWoDHlLV08V4CS0/xU1yn0QB/vH5nE+HdfgaY4+fQco0g==
X-Received: by 2002:ac8:5c12:0:b0:3a6:18ff:c6e2 with SMTP id i18-20020ac85c12000000b003a618ffc6e2mr90195666qti.28.1672787093875;
        Tue, 03 Jan 2023 15:04:53 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id h24-20020ac87458000000b003a7ef7a758dsm19434981qtr.59.2023.01.03.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:04:53 -0800 (PST)
Date:   Tue, 3 Jan 2023 18:04:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7S0lDCeBYLMHBvR@x1n>
References: <20230101230042.244286-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230101230042.244286-1-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 11:00:42PM +0000, James Houghton wrote:
> PMD sharing can only be done in PUD_SIZE-aligned pieces of VMAs;
> however, it is possible that HugeTLB VMAs are split without unsharing
> the PMDs first.
> 
> In some (most?) cases, this is a non-issue, like userfaultfd_register
> and mprotect, where PMDs are unshared before anything is done. However,
> mbind() and madvise() (like MADV_DONTDUMP) can cause a split without
> unsharing first.
> 
> It might seem ideal to unshare in hugetlb_vm_op_open, but that would
> only unshare PMDs in the new VMA.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b39b74e0591a..bf7a1f628357 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -94,6 +94,8 @@ static int hugetlb_acct_memory(struct hstate *h, long delta);
>  static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
>  static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
> +static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end);
>  
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> @@ -4828,6 +4830,23 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	if (addr & ~(huge_page_mask(hstate_vma(vma))))
>  		return -EINVAL;
> +
> +	/* We require PUD_SIZE VMA alignment for PMD sharing. */

I can get the point, but it reads slightly awkward.  How about:

        /*
         * If the address to split can be in the middle of a shared pmd
         * range, unshare before split the vma.
         */

I remember you had a helper to check pmd sharing possibility.  Can use here
depending on whether that existed in the code base or in your hgm series
(or just pick that up with this one?).

> +	if (addr & ~PUD_MASK) {
> +		/*
> +		 * hugetlb_vm_op_split is called right before we attempt to
> +		 * split the VMA. We will need to unshare PMDs in the old and
> +		 * new VMAs, so let's unshare before we split.
> +		 */
> +		unsigned long floor = addr & PUD_MASK;
> +		unsigned long ceil = floor + PUD_SIZE;
> +
> +		if (floor < vma->vm_start || ceil >= vma->vm_end)

s/>=/>/?

> +			/* PMD sharing is already impossible. */
> +			return 0;

IMHO slightly cleaner to write in the reversed way and let it fall through:

  if (floor >= vma->vm_start && ceil <= vma->vm_end)
      hugetlb_unshare_pmds(vma, floor, ceil);

Thanks,

> +		hugetlb_unshare_pmds(vma, floor, ceil);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -7313,26 +7332,21 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
>  	}
>  }
>  
> -/*
> - * This function will unconditionally remove all the shared pmd pgtable entries
> - * within the specific vma for a hugetlbfs memory range.
> - */
> -void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> +				   unsigned long start,
> +				   unsigned long end)
>  {
>  	struct hstate *h = hstate_vma(vma);
>  	unsigned long sz = huge_page_size(h);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> -	unsigned long address, start, end;
> +	unsigned long address;
>  	spinlock_t *ptl;
>  	pte_t *ptep;
>  
>  	if (!(vma->vm_flags & VM_MAYSHARE))
>  		return;
>  
> -	start = ALIGN(vma->vm_start, PUD_SIZE);
> -	end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
> -
>  	if (start >= end)
>  		return;
>  
> @@ -7364,6 +7378,16 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> +/*
> + * This function will unconditionally remove all the shared pmd pgtable entries
> + * within the specific vma for a hugetlbfs memory range.
> + */
> +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +{
> +	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
> +			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
> +}
> +
>  #ifdef CONFIG_CMA
>  static bool cma_reserve_called __initdata;
>  
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Peter Xu

