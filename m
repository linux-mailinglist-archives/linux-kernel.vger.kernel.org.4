Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E970FE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEXSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjEXStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CDD18D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07DD6376B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9818C433EF;
        Wed, 24 May 2023 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954179;
        bh=cZOpNNZu1hpbya06Z/YpDzm6RENOLZB3iMFQA7C+Zds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayhgoVY4A5xEvdS3V34XXv3WTLwygyQQMMNe5kJVpbyxskzqRm8UzfK5mAkW10Xyq
         gyFF0adVxmrQnQq9JR6YspCROH6ijc2ODp8UYiIPo6mAx+n16ZbhyuuXbdWEyTbuaU
         zczc0e01kAexMOOsjfZeejQqXIwOYqvzn9m+NuaWOG/VyGREEMEYEMwT5VDi486nAi
         uH70wQBngBGKmyP5deVUuamUGDgnEIig7YguwxfNrbphKiJrEtltCYD7cxqZD580EV
         72c52UXIMjKSvddRucxN4yLu82IHZ0KqinFj9HYLQS2Kg8uSrinngX2+kZWBPAf57S
         bpxmtT93C7Dzw==
Date:   Wed, 24 May 2023 21:49:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: Re: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and
 pmds
Message-ID: <20230524184917.GP4967@kernel.org>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-3-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-3-ryan.roberts@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:07:24PM +0100, Ryan Roberts wrote:
> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information. Further, it is
> bad practice to directly set a pte entry within a table. Instead
> clearing young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
> 
> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/damon/ops-common.c | 16 ++++++----------
>  mm/damon/ops-common.h |  4 ++--
>  mm/damon/paddr.c      |  4 ++--
>  mm/damon/vaddr.c      |  4 ++--
>  4 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index cc63cf953636..acc264b97903 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned long pfn)
>  	return folio;
>  }
>  
> -void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
> +void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
>  {
>  	bool referenced = false;
>  	struct folio *folio = damon_get_folio(pte_pfn(*pte));
> @@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
>  	if (!folio)
>  		return;
>  
> -	if (pte_young(*pte)) {
> +	if (ptep_test_and_clear_young(vma, addr, pte))
>  		referenced = true;
> -		*pte = pte_mkold(*pte);
> -	}
>  
>  #ifdef CONFIG_MMU_NOTIFIER
> -	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
> +	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
>  		referenced = true;
>  #endif /* CONFIG_MMU_NOTIFIER */
>  
> @@ -62,7 +60,7 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
>  	folio_put(folio);
>  }
>  
> -void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
> +void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	bool referenced = false;
> @@ -71,13 +69,11 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
>  	if (!folio)
>  		return;
>  
> -	if (pmd_young(*pmd)) {
> +	if (pmdp_test_and_clear_young(vma, addr, pmd))
>  		referenced = true;
> -		*pmd = pmd_mkold(*pmd);
> -	}
>  
>  #ifdef CONFIG_MMU_NOTIFIER
> -	if (mmu_notifier_clear_young(mm, addr, addr + HPAGE_PMD_SIZE))
> +	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE))
>  		referenced = true;
>  #endif /* CONFIG_MMU_NOTIFIER */
>  
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 14f4bc69f29b..18d837d11bce 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -9,8 +9,8 @@
>  
>  struct folio *damon_get_folio(unsigned long pfn);
>  
> -void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
> -void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
> +void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
> +void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
>  
>  int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
>  			struct damos *s);
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 467b99166b43..5b3a3463d078 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -24,9 +24,9 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		addr = pvmw.address;
>  		if (pvmw.pte)
> -			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
> +			damon_ptep_mkold(pvmw.pte, vma, addr);
>  		else
> -			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
> +			damon_pmdp_mkold(pvmw.pmd, vma, addr);
>  	}
>  	return true;
>  }
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 1fec16d7263e..37994fb6120c 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -311,7 +311,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		}
>  
>  		if (pmd_trans_huge(*pmd)) {
> -			damon_pmdp_mkold(pmd, walk->mm, addr);
> +			damon_pmdp_mkold(pmd, walk->vma, addr);
>  			spin_unlock(ptl);
>  			return 0;
>  		}
> @@ -323,7 +323,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	if (!pte_present(*pte))
>  		goto out;
> -	damon_ptep_mkold(pte, walk->mm, addr);
> +	damon_ptep_mkold(pte, walk->vma, addr);
>  out:
>  	pte_unmap_unlock(pte, ptl);
>  	return 0;
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
