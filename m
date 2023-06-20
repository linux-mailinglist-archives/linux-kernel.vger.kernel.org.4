Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75B736694
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFTIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjFTIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D436E72
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0935E61049
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54080C433C0;
        Tue, 20 Jun 2023 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687250770;
        bh=TQjPtAYxTNuXGasBPn7DviEY9IbqSVODbZ5OTQJzlDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERSorwLzotKCYA7nLdIx8+nEcpGIIEqMMwz1RxTBzfi0JEjB1LTH6CntGV/xnrElf
         HY26odflX72zv/1dHt3ZucTnLJ1SnsxfO8BNySz3YZkaTLHoErUT9sRWPxasPc9Fjb
         yTb3tLckFhTim9Tsy/asVZOFqQl9+m36mjUu6VTrNsfBcMmXl7RVfdjPHEFe6T77nX
         Pk+YpVfZEK5mKVWO/DPaPeeWfT7LEMYO9DPiZwKI/9SC/S0GTL1UB18zzmh61cNtCq
         SHAQeK2pQhD/YirKg6RGh5nYTfW2oMaWT9Y2qXx4Yb5iwCp9u/Fptk0F5NqaCj6OWQ
         U6Cb+/LoVjG5Q==
Date:   Tue, 20 Jun 2023 11:45:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] mm: pass nid to reserve_bootmem_region()
Message-ID: <20230620084530.GD52412@kernel.org>
References: <20230619023406.424298-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619023406.424298-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 10:34:06AM +0800, Yajun Deng wrote:
> early_pfn_to_nid() is called frequently in init_reserved_page(), it
> returns the node id of the PFN. These PFN are probably from the same
> memory region, they have the same node id. It's not necessary to call
> early_pfn_to_nid() for each PFN.
> 
> Pass nid to reserve_bootmem_region() and drop the call to
> early_pfn_to_nid() in init_reserved_page(). Also, set nid on all
> reserved pages before doing this, as some reserved memory regions may
> not be set nid.
> 
> The most beneficial function is memmap_init_reserved_pages() if
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> The following data was tested on an x86 machine with 190GB of RAM.
> 
> before:
> memmap_init_reserved_pages()  67ms
> 
> after:
> memmap_init_reserved_pages()  20ms
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306160145.juJMr3Bi-lkp@intel.com

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> V3 -> V4: make the test for early_page_initialised() inside if
> 	  (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
> V2 -> V3: set nid on all reserved pages before pass nid.
> V1 -> V2: fix build error when CONFIG_NUMA is not enabled.
> ---
>  include/linux/mm.h |  3 ++-
>  mm/memblock.c      | 31 +++++++++++++++++++++----------
>  mm/mm_init.c       | 30 +++++++++++++++++-------------
>  3 files changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fdd966b11f79..a7a0e692d44d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2960,7 +2960,8 @@ extern unsigned long free_reserved_area(void *start, void *end,
>  
>  extern void adjust_managed_page_count(struct page *page, long count);
>  
> -extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
> +extern void reserve_bootmem_region(phys_addr_t start,
> +				   phys_addr_t end, int nid);
>  
>  /* Free the reserved page into the buddy system, so it gets managed. */
>  static inline void free_reserved_page(struct page *page)
> diff --git a/mm/memblock.c b/mm/memblock.c
> index ff0da1858778..f9e61e565a53 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2091,19 +2091,30 @@ static void __init memmap_init_reserved_pages(void)
>  {
>  	struct memblock_region *region;
>  	phys_addr_t start, end;
> -	u64 i;
> +	int nid;
> +
> +	/*
> +	 * set nid on all reserved pages and also treat struct
> +	 * pages for the NOMAP regions as PageReserved
> +	 */
> +	for_each_mem_region(region) {
> +		nid = memblock_get_region_node(region);
> +		start = region->base;
> +		end = start + region->size;
> +
> +		if (memblock_is_nomap(region))
> +			reserve_bootmem_region(start, end, nid);
> +
> +		memblock_set_node(start, end, &memblock.reserved, nid);
> +	}
>  
>  	/* initialize struct pages for the reserved regions */
> -	for_each_reserved_mem_range(i, &start, &end)
> -		reserve_bootmem_region(start, end);
> +	for_each_reserved_mem_region(region) {
> +		nid = memblock_get_region_node(region);
> +		start = region->base;
> +		end = start + region->size;
>  
> -	/* and also treat struct pages for the NOMAP regions as PageReserved */
> -	for_each_mem_region(region) {
> -		if (memblock_is_nomap(region)) {
> -			start = region->base;
> -			end = start + region->size;
> -			reserve_bootmem_region(start, end);
> -		}
> +		reserve_bootmem_region(start, end, nid);
>  	}
>  }
>  
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index d393631599a7..a1963c3322af 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -646,10 +646,8 @@ static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
>  }
>  
>  /* Returns true if the struct page for the pfn is initialised */
> -static inline bool __meminit early_page_initialised(unsigned long pfn)
> +static inline bool __meminit early_page_initialised(unsigned long pfn, int nid)
>  {
> -	int nid = early_pfn_to_nid(pfn);
> -
>  	if (node_online(nid) && pfn >= NODE_DATA(nid)->first_deferred_pfn)
>  		return false;
>  
> @@ -695,15 +693,14 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  	return false;
>  }
>  
> -static void __meminit init_reserved_page(unsigned long pfn)
> +static void __meminit init_reserved_page(unsigned long pfn, int nid)
>  {
>  	pg_data_t *pgdat;
> -	int nid, zid;
> +	int zid;
>  
> -	if (early_page_initialised(pfn))
> +	if (early_page_initialised(pfn, nid))
>  		return;
>  
> -	nid = early_pfn_to_nid(pfn);
>  	pgdat = NODE_DATA(nid);
>  
>  	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> @@ -717,7 +714,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
>  #else
>  static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
>  
> -static inline bool early_page_initialised(unsigned long pfn)
> +static inline bool early_page_initialised(unsigned long pfn, int nid)
>  {
>  	return true;
>  }
> @@ -727,7 +724,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  	return false;
>  }
>  
> -static inline void init_reserved_page(unsigned long pfn)
> +static inline void init_reserved_page(unsigned long pfn, int nid)
>  {
>  }
>  #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
> @@ -738,7 +735,8 @@ static inline void init_reserved_page(unsigned long pfn)
>   * marks the pages PageReserved. The remaining valid pages are later
>   * sent to the buddy page allocator.
>   */
> -void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
> +void __meminit reserve_bootmem_region(phys_addr_t start,
> +				      phys_addr_t end, int nid)
>  {
>  	unsigned long start_pfn = PFN_DOWN(start);
>  	unsigned long end_pfn = PFN_UP(end);
> @@ -747,7 +745,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
>  		if (pfn_valid(start_pfn)) {
>  			struct page *page = pfn_to_page(start_pfn);
>  
> -			init_reserved_page(start_pfn);
> +			init_reserved_page(start_pfn, nid);
>  
>  			/* Avoid false-positive PageTail() */
>  			INIT_LIST_HEAD(&page->lru);
> @@ -2579,8 +2577,14 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
>  void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
> -	if (!early_page_initialised(pfn))
> -		return;
> +
> +	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
> +		int nid = early_pfn_to_nid(pfn);
> +
> +		if (!early_page_initialised(pfn, nid))
> +			return;
> +	}
> +
>  	if (!kmsan_memblock_free_pages(page, order)) {
>  		/* KMSAN will take care of these pages. */
>  		return;
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
