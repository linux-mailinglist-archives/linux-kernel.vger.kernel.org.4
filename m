Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4D708679
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjERRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjERRN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDAC9F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F7C647D9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA92C433EF;
        Thu, 18 May 2023 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430005;
        bh=/DBLWf58+j65eoP2xEHnqealzR5M1KHu1Lqk9ywqqZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3PfBzrGW/KmSu63/LtrZ8aR70wDbxTz7tU220EljMmlebE6Mgj4ebjppPwci1r+N
         hB7kZ0ybwN9rd/CdhorR27+GsfpmmU3tP6xRqM50WsVAlJeosPTGdLSC3kLwt2IFaw
         GOIeqa0UwVAg1KtSluKOtjYfU7weRVxXVnIaxUtskRT2+k3Un/kBvM4sdGZbtERtyT
         3LPjZxfG0Zn/BAfSJpL60ZJxiD+f3ctvAJCXxxBhjm8LieSD/7hH9ortJqAliQ7blD
         PikY4RpAb3O/uD6lHYzcVLkuOahnx7FMP6sJOcVTfjB/OJ54MFjoenmuZsmaANOjQz
         OR14s6Ptff+AA==
From:   SeongJae Park <sj@kernel.org>
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
Subject: Re: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and pmds
Date:   Thu, 18 May 2023 17:13:23 +0000
Message-Id: <20230518171323.83828-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518110727.2106156-3-ryan.roberts@arm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,


Nit.  For consistency of DAMON commits subjects, I'd prefer something like
"mm/damon/ops-common: atomically test and clear young on ptes and pmds".

On Thu, 18 May 2023 12:07:24 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information. Further, it is
> bad practice to directly set a pte entry within a table. Instead
> clearing young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
> 
> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")

Nit.  The commit is only for refactoring.  The original code camde from commit
3f49584b262c ("mm/damon: implement primitives for the virtual memory address
spaces").

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Other than above nits,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

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
