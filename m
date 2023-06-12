Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4672B9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjFLIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjFLIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:06:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF29C1980
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686557151; x=1718093151;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=7A21HmaRay4LWuG9bVQutg9tF4DSDeHyHi3nObJLshQ=;
  b=eginvoy9W4PcIdGdsEGT0czS1x0zI4takNaqDbR6yVvO9ahbVh4VhUue
   ZNZyRihi9p8rLMTrRWGrH5ZfFgJtmXFyMi4+Ud+DbpTT/etaLnBnP+JRe
   JZuZmVNT08PuiidFJ9cOiFKVwhQaJLNN977iMVqfwPs7s7LRMsvdAKjG7
   eNxDxJpJQAXV24cuGbpl0MavjqQBpxQcdPoYKosC08+tBCgEauK/+ntXJ
   j17Scqd/qQNaVFNCTkSegx3VRR0KC9HSPmhMSLfa/ipap9k8VJRuZxper
   Y5VkR5SspkHRwwXRTn8rHmmSmHheN4WjtlXI8wMq6vndnGyiZF8TuAjYO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="421568195"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421568195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="823886922"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="823886922"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:04:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 31/32] mm/swap: swap_vma_readahead() do the
 pte_offset_map()
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
        <b7c64ab3-9e44-aac0-d2b-c57de578af1c@google.com>
Date:   Mon, 12 Jun 2023 16:03:18 +0800
In-Reply-To: <b7c64ab3-9e44-aac0-d2b-c57de578af1c@google.com> (Hugh Dickins's
        message of "Thu, 8 Jun 2023 18:52:17 -0700 (PDT)")
Message-ID: <87legp6rax.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

Sorry for late reply.

Hugh Dickins <hughd@google.com> writes:

> swap_vma_readahead() has been proceeding in an unconventional way, its
> preliminary swap_ra_info() doing the pte_offset_map() and pte_unmap(),
> then relying on that pte pointer even after the pte_unmap() - in its
> CONFIG_64BIT case (I think !CONFIG_HIGHPTE was intended; whereas 32-bit
> copied ptes to stack while they were mapped, but had to limit how many).
>
> Though it would be difficult to construct a failing testcase, accessing
> page table after pte_unmap() will become bad practice, even on 64-bit:
> an rcu_read_unlock() in pte_unmap() will allow page table to be freed.
>
> Move relevant definitions from include/linux/swap.h to mm/swap_state.c,
> nothing else used them.  Delete the CONFIG_64BIT distinction and buffer,
> delete all reference to ptes from swap_ra_info(), use pte_offset_map()
> repeatedly in swap_vma_readahead(), breaking from the loop if it fails.
>
> (Will the repeated "map" and "unmap" show up as a slowdown anywhere?
> If so, maybe modify __read_swap_cache_async() to do the pte_unmap()
> only when it does not find the page already in the swapcache.)
>
> Use ptep_get_lockless(), mainly for its READ_ONCE().  Correctly advance
> the address passed down to each call of __read__swap_cache_async().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/swap.h | 19 -------------------
>  mm/swap_state.c      | 45 +++++++++++++++++++++++---------------------
>  2 files changed, 24 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3c69cb653cb9..1b9f2d92fc10 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -337,25 +337,6 @@ struct swap_info_struct {
>  					   */
>  };
>  
> -#ifdef CONFIG_64BIT
> -#define SWAP_RA_ORDER_CEILING	5
> -#else
> -/* Avoid stack overflow, because we need to save part of page table */
> -#define SWAP_RA_ORDER_CEILING	3
> -#define SWAP_RA_PTE_CACHE_SIZE	(1 << SWAP_RA_ORDER_CEILING)
> -#endif
> -
> -struct vma_swap_readahead {
> -	unsigned short win;
> -	unsigned short offset;
> -	unsigned short nr_pte;
> -#ifdef CONFIG_64BIT
> -	pte_t *ptes;
> -#else
> -	pte_t ptes[SWAP_RA_PTE_CACHE_SIZE];
> -#endif
> -};
> -
>  static inline swp_entry_t folio_swap_entry(struct folio *folio)
>  {
>  	swp_entry_t entry = { .val = page_private(&folio->page) };
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index b76a65ac28b3..a43b41975da2 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -698,6 +698,14 @@ void exit_swap_address_space(unsigned int type)
>  	swapper_spaces[type] = NULL;
>  }
>  
> +#define SWAP_RA_ORDER_CEILING	5
> +
> +struct vma_swap_readahead {
> +	unsigned short win;
> +	unsigned short offset;
> +	unsigned short nr_pte;
> +};
> +

Because we don't deal with PTEs in struct vma_swap_readahead anymore, it
appears simpler to record addresses directly, for example,

struct vma_swap_readahead {
	unsigned long start;
	unsigned long end;
};

we can make ra_info.win to be the return value of swap_ra_info().

Anyway, this can be a separate cleanup patch based on this patch.

For the patch itself, feel free to add,

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>  static void swap_ra_info(struct vm_fault *vmf,
>  			 struct vma_swap_readahead *ra_info)
>  {
> @@ -705,11 +713,7 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	unsigned long ra_val;
>  	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
>  	unsigned long start, end;
> -	pte_t *pte, *orig_pte;
>  	unsigned int max_win, hits, prev_win, win;
> -#ifndef CONFIG_64BIT
> -	pte_t *tpte;
> -#endif
>  
>  	max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
>  			     SWAP_RA_ORDER_CEILING);
> @@ -728,12 +732,9 @@ static void swap_ra_info(struct vm_fault *vmf,
>  					       max_win, prev_win);
>  	atomic_long_set(&vma->swap_readahead_info,
>  			SWAP_RA_VAL(faddr, win, 0));
> -
>  	if (win == 1)
>  		return;
>  
> -	/* Copy the PTEs because the page table may be unmapped */
> -	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>  	if (fpfn == pfn + 1) {
>  		lpfn = fpfn;
>  		rpfn = fpfn + win;
> @@ -753,15 +754,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>  
>  	ra_info->nr_pte = end - start;
>  	ra_info->offset = fpfn - start;
> -	pte -= ra_info->offset;
> -#ifdef CONFIG_64BIT
> -	ra_info->ptes = pte;
> -#else
> -	tpte = ra_info->ptes;
> -	for (pfn = start; pfn != end; pfn++)
> -		*tpte++ = *pte++;
> -#endif
> -	pte_unmap(orig_pte);
>  }
>  
>  /**
> @@ -785,7 +777,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  	struct swap_iocb *splug = NULL;
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct page *page;
> -	pte_t *pte, pentry;
> +	pte_t *pte = NULL, pentry;
> +	unsigned long addr;
>  	swp_entry_t entry;
>  	unsigned int i;
>  	bool page_allocated;
> @@ -797,17 +790,25 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  	if (ra_info.win == 1)
>  		goto skip;
>  
> +	addr = vmf->address - (ra_info.offset * PAGE_SIZE);
> +
>  	blk_start_plug(&plug);
> -	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
> -	     i++, pte++) {
> -		pentry = *pte;
> +	for (i = 0; i < ra_info.nr_pte; i++, addr += PAGE_SIZE) {
> +		if (!pte++) {
> +			pte = pte_offset_map(vmf->pmd, addr);
> +			if (!pte)
> +				break;
> +		}
> +		pentry = ptep_get_lockless(pte);
>  		if (!is_swap_pte(pentry))
>  			continue;
>  		entry = pte_to_swp_entry(pentry);
>  		if (unlikely(non_swap_entry(entry)))
>  			continue;
> +		pte_unmap(pte);
> +		pte = NULL;
>  		page = __read_swap_cache_async(entry, gfp_mask, vma,
> -					       vmf->address, &page_allocated);
> +					       addr, &page_allocated);
>  		if (!page)
>  			continue;
>  		if (page_allocated) {
> @@ -819,6 +820,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  		}
>  		put_page(page);
>  	}
> +	if (pte)
> +		pte_unmap(pte);
>  	blk_finish_plug(&plug);
>  	swap_read_unplug(splug);
>  	lru_add_drain();
