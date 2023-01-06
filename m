Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B0C66073E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjAFThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAFThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:37:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D771897
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qd3gcQO/dsMwm40vSdJDrJs6x0c/1tvVsSQuZfcMBco=; b=otkWWnw/kS3HCith14QNhH1zyy
        ZxVupAUZLtwaY8cmQ/tpvupVcu4V6wbxTsSdvqAsZpg/ZxpMBwOTB6yKoYz4I1qcCGzTmxB285DoQ
        VwFdxCn7nd+WeTLGzTbjf9hCk9HXUJ8a0HGFueHEXViZllUVG2Y2/te++AyLYjKsUjHliGmUavKqZ
        kwNRklhkaKFddZNcDVWkknOIyu6uas7zb2PNTwQAe5YKztPctyxQOH9rPW8bLc5WvMpe6bQTV8XKt
        Jf+ziobT/clE+GzYpaIK9DiabT8RzNCRVav9VRkJ985HL1N1juWu0Rl7egIgy7c/UFUbvaPXkbuao
        R9Th1+8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDsXG-00HRj5-QG; Fri, 06 Jan 2023 19:37:50 +0000
Date:   Fri, 6 Jan 2023 19:37:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: use folio_headpage() instead of folio_page()
Message-ID: <Y7h4jsv6jl0XSIsk@casper.infradead.org>
References: <20230106174028.151384-1-sj@kernel.org>
 <20230106174028.151384-3-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106174028.151384-3-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:40:27PM +0000, SeongJae Park wrote:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index bc5c156ef470..8ae73973a7fc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3211,7 +3211,7 @@ static const char *shmem_get_link(struct dentry *dentry,
>  		folio = filemap_get_folio(inode->i_mapping, 0);
>  		if (!folio)
>  			return ERR_PTR(-ECHILD);
> -		if (PageHWPoison(folio_page(folio, 0)) ||
> +		if (PageHWPoison(folio_headpage(folio)) ||

This is actually incorrect.  We don't want the head page, we want the
page at index 0.  It's a subtle but important difference later on.

> @@ -3222,7 +3222,7 @@ static const char *shmem_get_link(struct dentry *dentry,
>  			return ERR_PTR(error);
>  		if (!folio)
>  			return ERR_PTR(-ECHILD);
> -		if (PageHWPoison(folio_page(folio, 0))) {
> +		if (PageHWPoison(folio_headpage(folio))) {

Same here.

> +++ b/mm/slab.c
> @@ -1373,7 +1373,7 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  	/* Make the flag visible before any changes to folio->mapping */
>  	smp_wmb();
>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
> -	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
> +	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_headpage(folio)))

We should have a folio_is_pfmemalloc().

> @@ -1389,7 +1389,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  
>  	BUG_ON(!folio_test_slab(folio));
>  	__slab_clear_pfmemalloc(slab);
> -	page_mapcount_reset(folio_page(folio, 0));
> +	page_mapcount_reset(folio_headpage(folio));

This one should be &folio->page.

> @@ -1398,7 +1398,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += 1 << order;
>  	unaccount_slab(slab, order, cachep);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(folio_headpage(folio), order);

&folio->page.

> @@ -939,9 +939,9 @@ void free_large_kmalloc(struct folio *folio, void *object)
>  	kasan_kfree_large(object);
>  	kmsan_kfree_large(object);
>  
> -	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> +	mod_lruvec_page_state(folio_headpage(folio), NR_SLAB_UNRECLAIMABLE_B,
>  			      -(PAGE_SIZE << order));

	lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B, ...

> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(folio_headpage(folio), order);

&folio->page.

> +++ b/mm/slub.c
> @@ -1859,7 +1859,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  	__folio_set_slab(folio);
>  	/* Make the flag visible before any changes to folio->mapping */
>  	smp_wmb();
> -	if (page_is_pfmemalloc(folio_page(folio, 0)))
> +	if (page_is_pfmemalloc(folio_headpage(folio)))

folio_is_pfmemalloc()

> @@ -2066,7 +2066,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += pages;
>  	unaccount_slab(slab, order, s);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(folio_headpage(folio), order);

&folio->page.
