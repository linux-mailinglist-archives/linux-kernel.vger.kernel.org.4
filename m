Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8386BE384
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCQI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCQI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08AE2501
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50F46220B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8064C433EF;
        Fri, 17 Mar 2023 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041503;
        bh=IJACNKHIMb3VFfqK/F0n1ocUFyj5JkV9qD04tkUiy+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I98xJ1+R5+Q4vUrRCuN3h1Z0L/EO9nUXMCZes6aAGimw8aKjPg6DXS5iGBKnNpi7b
         0/RbqwoPvXAfNOo8cBQXsFMGqRhacpD/iVBsywCYl9HTlxNgbnQlFbe6zO9/VpHkZM
         n3UgqsbEPGEpefsLcHZQnY4aAoHQMuYnGSnYFlhS5H+onzap+PpMZWgdJbjj0ydsav
         wkAHS/bfI3S3NZNLQQBvPDI2gK5Lv4avbDVonmBpusH0N334glBCsZwmn7mL9YPWVZ
         T7IWac1Ljl7KHmGLsjLF4dqiJh2yef8JCd2innzJwStG4wIuL+i/+tWs7CJlJygS9K
         bJrDf1L22rHuQ==
Date:   Fri, 17 Mar 2023 10:24:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm: prefer xxx_page() alloc/free functions for order-0
 pages
Message-ID: <ZBQjz9vzFaLjW0MM@kernel.org>
References: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:27:14PM +0000, Lorenzo Stoakes wrote:
> Update instances of alloc_pages(..., 0), __get_free_pages(..., 0) and
> __free_pages(..., 0) to use alloc_page(), __get_free_page() and
> __free_page() respectively in core code.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

But why limit this only to mm?
> ---
>  include/asm-generic/pgalloc.h | 4 ++--
>  mm/debug_vm_pgtable.c         | 4 ++--
>  mm/hugetlb_vmemmap.c          | 2 +-
>  mm/mmu_gather.c               | 2 +-
>  mm/page_alloc.c               | 2 +-
>  mm/vmalloc.c                  | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 977bea16cf1b..a7cf825befae 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -123,11 +123,11 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> 
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	page = alloc_pages(gfp, 0);
> +	page = alloc_page(gfp);
>  	if (!page)
>  		return NULL;
>  	if (!pgtable_pmd_page_ctor(page)) {
> -		__free_pages(page, 0);
> +		__free_page(page);
>  		return NULL;
>  	}
>  	return (pmd_t *)page_address(page);
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 7887cc2b75bf..4362021b1ce7 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1048,7 +1048,7 @@ static void __init destroy_args(struct pgtable_debug_args *args)
> 
>  	if (args->pte_pfn != ULONG_MAX) {
>  		page = pfn_to_page(args->pte_pfn);
> -		__free_pages(page, 0);
> +		__free_page(page);
> 
>  		args->pte_pfn = ULONG_MAX;
>  	}
> @@ -1290,7 +1290,7 @@ static int __init init_args(struct pgtable_debug_args *args)
>  		}
>  	}
> 
> -	page = alloc_pages(GFP_KERNEL, 0);
> +	page = alloc_page(GFP_KERNEL);
>  	if (page)
>  		args->pte_pfn = page_to_pfn(page);
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index a15cc56cf70a..1198064f80eb 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -400,7 +400,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>  	return 0;
>  out:
>  	list_for_each_entry_safe(page, next, list, lru)
> -		__free_pages(page, 0);
> +		__free_page(page);
>  	return -ENOMEM;
>  }
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 2b93cf6ac9ae..ea9683e12936 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
>  		return false;
> 
> -	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
> +	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>  	if (!batch)
>  		return false;
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 680a4d76460e..256e8d3c8742 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5538,7 +5538,7 @@ EXPORT_SYMBOL(__get_free_pages);
> 
>  unsigned long get_zeroed_page(gfp_t gfp_mask)
>  {
> -	return __get_free_pages(gfp_mask | __GFP_ZERO, 0);
> +	return __get_free_page(gfp_mask | __GFP_ZERO);
>  }
>  EXPORT_SYMBOL(get_zeroed_page);
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5e60e9792cbf..978194dc2bb8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2739,7 +2739,7 @@ void vfree(const void *addr)
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
>  		 */
> -		__free_pages(page, 0);
> +		__free_page(page);
>  		cond_resched();
>  	}
>  	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
> --
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
