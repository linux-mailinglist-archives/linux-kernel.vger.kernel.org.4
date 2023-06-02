Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7271F9D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjFBGDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFBGDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB271A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF3B464C59
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A76C433EF;
        Fri,  2 Jun 2023 06:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685685820;
        bh=72VyoFkGUn0mm7PyaN7SmnXVYG5EwT4wxe7Vv6CO8YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0VyiuReFvyJrntTISNbCEtkBYHQi7ugluiWFSaxg3p7MhaG78u1vM0YZXe4bdnHw
         QJVOvuKA4d0/C/hPYgKGg/fk2umqPs1f6T5Cc0Sa18ShESOkq0UqUGgP+bCdP6zoDU
         iGAyRmn0u+/b1TI0EJSAFIZffj6ZCQp+p0/oLCIsZHJTML1qTT/INWGhYQ5SI9sW1u
         2HR6ojuQZdmTgyOaOcyqPycp7mhPzCqrQas305V1SkWbayf0Bb/bVNg36//hxjgvsL
         Smh/vEfzHtJDknxD3lIUy+6LVy5yFyd4UDqcq8dXxXJjLvuw03VLfJma9OEjMR1+bA
         B3timrON3gtTA==
Date:   Thu, 1 Jun 2023 23:03:37 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH -V3 2/5] swap, __read_swap_cache_async(): enlarge
 get/put_swap_device protection range
Message-ID: <ZHmGOa2FdGwJpjgf@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529061355.125791-3-ying.huang@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:13:52PM +0800, Huang Ying wrote:
> This makes the function a little easier to be understood because we
> don't need to consider swapoff.  And this makes it possible to remove
> get/put_swap_device() calling in some functions called by
> __read_swap_cache_async().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/swap_state.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index b76a65ac28b3..a8450b4a110c 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -417,9 +417,13 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  {
>  	struct swap_info_struct *si;
>  	struct folio *folio;
> +	struct page *page;
>  	void *shadow = NULL;
>  
>  	*new_page_allocated = false;
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return NULL;
>  
>  	for (;;) {
>  		int err;
> @@ -428,14 +432,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * called after swap_cache_get_folio() failed, re-calling
>  		 * that would confuse statistics.
>  		 */
> -		si = get_swap_device(entry);
> -		if (!si)
> -			return NULL;
>  		folio = filemap_get_folio(swap_address_space(entry),
>  						swp_offset(entry));
> -		put_swap_device(si);
> -		if (!IS_ERR(folio))
> -			return folio_file_page(folio, swp_offset(entry));
> +		if (!IS_ERR(folio)) {
> +			page = folio_file_page(folio, swp_offset(entry));
> +			goto got_page;
> +		}
>  
>  		/*
>  		 * Just skip read ahead for unused swap slot.
> @@ -446,7 +448,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * else swap_off will be aborted if we return NULL.
>  		 */
>  		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
> -			return NULL;
> +			goto fail_put_swap;
>  
>  		/*
>  		 * Get a new page to read into from swap.  Allocate it now,
> @@ -455,7 +457,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 */
>  		folio = vma_alloc_folio(gfp_mask, 0, vma, addr, false);
>  		if (!folio)
> -			return NULL;
> +                        goto fail_put_swap;
>  
>  		/*
>  		 * Swap entry may have been freed since our caller observed it.
> @@ -466,7 +468,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  
>  		folio_put(folio);
>  		if (err != -EEXIST)
> -			return NULL;
> +			goto fail_put_swap;
>  
>  		/*
>  		 * We might race against __delete_from_swap_cache(), and
> @@ -500,12 +502,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	/* Caller will initiate read into locked folio */
>  	folio_add_lru(folio);
>  	*new_page_allocated = true;
> -	return &folio->page;
> +	page = &folio->page;
> +got_page:
> +	put_swap_device(si);
> +	return page;
>  
>  fail_unlock:
>  	put_swap_folio(folio, entry);
>  	folio_unlock(folio);
>  	folio_put(folio);
> +fail_put_swap:
> +	put_swap_device(si);
>  	return NULL;
>  }
>  
> @@ -514,6 +521,10 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   * and reading the disk if it is not already cached.
>   * A failure return means that either the page allocation failed or that
>   * the swap entry is no longer in use.
> + *
> + * get/put_swap_device() aren't needed to call this function, because
> + * __read_swap_cache_async() call them and swap_readpage() holds the
> + * swap cache folio lock.
>   */
>  struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  				   struct vm_area_struct *vma,
> -- 
> 2.39.2
>

Reviewed-by: Chris Li (Google) <chrisl@kernel.org>

Chris

