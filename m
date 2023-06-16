Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8420D7328C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFPHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbjFPHXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5781FF7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04977628B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18DFC433C8;
        Fri, 16 Jun 2023 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686900203;
        bh=3+y7L/GkTqx/QAUxlRlgLXh+T2UIJ5lInwfKENXuokw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8qn+XjlCElPQuXotlU5yUQ1ks1s8spNQrU6wxRgDSdyYsXAmXo65777DZdk9Tfa1
         nW4p9NK/WlMY4TE4C26EpIxpd1fXf1CyXS0ErDMl0T7RWTe/7AIubwfS3RmnYwhRn4
         6FVJV/+fF5TfGExWwjD0bEKI0Qz1QgB4otapPIJDzedr8ddZOebWJWashXdxGYPdZf
         PS9AftXFdDlDTODbWIAWlULWFEu3XU+IQg11saO230APPrIJXapplhqaDKTCqiTowH
         tTJy0MdzwSBKZcc8omO9EzzR2YmohKXzCpJQQad3uqYh1JZB/6mnrwwSvhRC99GAI+
         tkP68KEt09vJA==
Date:   Fri, 16 Jun 2023 10:22:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] mm: pass nid to reserve_bootmem_region()
Message-ID: <20230616072247.GL52412@kernel.org>
References: <20230616023011.2952211-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616023011.2952211-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:30:11AM +0800, Yajun Deng wrote:
> early_pfn_to_nid() is called frequently in init_reserved_page(), it
> returns the node id of the PFN. These PFN are probably from the same
> memory region, they have the same node id. It's not necessary to call
> early_pfn_to_nid() for each PFN.
> 
> Pass nid to eserve_bootmem_region() and drop the call to
> early_pfn_to_nid() in init_reserved_page().
> 
> The most beneficial function is memmap_init_reserved_pages() if define
> CONFIG_DEFERRED_STRUCT_PAGE_INIT.
> The following data was tested on x86 machine, it has 190GB RAM,
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
> ---
>  include/linux/mm.h |  3 ++-
>  mm/memblock.c      |  9 ++++++---
>  mm/mm_init.c       | 31 +++++++++++++++++++------------
>  3 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 17317b1673b0..39e72ca6bf22 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2964,7 +2964,8 @@ extern unsigned long free_reserved_area(void *start, void *end,
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
> index ff0da1858778..6dc51dc845e5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2091,18 +2091,21 @@ static void __init memmap_init_reserved_pages(void)
>  {
>  	struct memblock_region *region;
>  	phys_addr_t start, end;
> +	int nid;
>  	u64 i;
>  
>  	/* initialize struct pages for the reserved regions */
> -	for_each_reserved_mem_range(i, &start, &end)
> -		reserve_bootmem_region(start, end);
> +	__for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,
> +			     MEMBLOCK_NONE, &start, &end, &nid)
> +		reserve_bootmem_region(start, end, nid);

I'd prefer to see for_each_reserved_mem_region() loop here

>  
>  	/* and also treat struct pages for the NOMAP regions as PageReserved */
>  	for_each_mem_region(region) {
>  		if (memblock_is_nomap(region)) {
>  			start = region->base;
>  			end = start + region->size;
> -			reserve_bootmem_region(start, end);
> +			nid = memblock_get_region_node(region);
> +			reserve_bootmem_region(start, end, nid);
>  		}
>  	}
>  }
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index d393631599a7..1499efbebc6f 100644
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
> @@ -738,16 +735,20 @@ static inline void init_reserved_page(unsigned long pfn)
>   * marks the pages PageReserved. The remaining valid pages are later
>   * sent to the buddy page allocator.
>   */
> -void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
> +void __meminit reserve_bootmem_region(phys_addr_t start,
> +				      phys_addr_t end, int nid)
>  {
>  	unsigned long start_pfn = PFN_DOWN(start);
>  	unsigned long end_pfn = PFN_UP(end);
>  
> +	if (nid == MAX_NUMNODES)
> +		nid = first_online_node;

How can this happen?

> +
>  	for (; start_pfn < end_pfn; start_pfn++) {
>  		if (pfn_valid(start_pfn)) {
>  			struct page *page = pfn_to_page(start_pfn);
>  
> -			init_reserved_page(start_pfn);
> +			init_reserved_page(start_pfn, nid);
>  
>  			/* Avoid false-positive PageTail() */
>  			INIT_LIST_HEAD(&page->lru);
> @@ -2579,7 +2580,13 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
>  void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
> -	if (!early_page_initialised(pfn))
> +	int nid = 0;
> +
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +	nid = early_pfn_to_nid(pfn);
> +#endif

Wen can pass nid to memblock_free_pages, no?

> +
> +	if (!early_page_initialised(pfn, nid))
>  		return;
>  	if (!kmsan_memblock_free_pages(page, order)) {
>  		/* KMSAN will take care of these pages. */
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
