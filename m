Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0829C71F9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjFBGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjFBGHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FADE41
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E3863704
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93339C433EF;
        Fri,  2 Jun 2023 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685686029;
        bh=Fd98bz6la1JS45Pi/qYDuRzDrW1OhKruM3EXxfTsvdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a18P7VRW/PpZVNN4e16GTVFjjOokoDV3waQyZ0/nV2Z2jejoH1tKFhuTwhUhSo2E2
         r9HgsWxri8waD/oXndTvbpOA7paBS7UJABoLfBRU/ZgZQTaSE4J7KU8shbJ3yvUXxf
         6M6/U3aBeqyb3FnOR+09YIYxFiei8kiX7QWdz0Ty+8pO68AvQQEAD+7+i3zCHCi94B
         XrHaZ6G0Je9x2491nEfLOytr/RLbAJkQwrJg06BZ3n+EW2zffXZOre1LHnoFeNIsAF
         VLxP+JtxFS79oUGzLM9SZ+ld0U1vi1J8aBWdDFOTqiPJ2gI3oBDlwLo33KhEJmaQsn
         fbwrl88azE+Uw==
Date:   Thu, 1 Jun 2023 23:07:06 -0700
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
Subject: Re: [PATCH -V3 3/5] swap: remove __swp_swapcount()
Message-ID: <ZHmHCqV8qaCEymI1@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529061355.125791-4-ying.huang@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:13:53PM +0800, Huang Ying wrote:
> __swp_swapcount() just encloses the calling to swap_swapcount() with
> get/put_swap_device().  It is called in __read_swap_cache_async()
> only, which encloses the calling with get/put_swap_device() already.
> So, __read_swap_cache_async() can call swap_swapcount() directly.
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
>  include/linux/swap.h |  4 ++--
>  mm/swap_state.c      |  2 +-
>  mm/swapfile.c        | 20 +-------------------
>  3 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3c69cb653cb9..f6bd51aa05ea 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -512,7 +512,7 @@ int find_first_swap(dev_t *device);
>  extern unsigned int count_swap_pages(int, int);
>  extern sector_t swapdev_block(int, pgoff_t);
>  extern int __swap_count(swp_entry_t entry);
> -extern int __swp_swapcount(swp_entry_t entry);
> +extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
>  extern int swp_swapcount(swp_entry_t entry);
>  extern struct swap_info_struct *page_swap_info(struct page *);
>  extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> @@ -590,7 +590,7 @@ static inline int __swap_count(swp_entry_t entry)
>  	return 0;
>  }
>  
> -static inline int __swp_swapcount(swp_entry_t entry)
> +static inline int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>  {
>  	return 0;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a8450b4a110c..ef32353c18a6 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -447,7 +447,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * as SWAP_HAS_CACHE.  That's done in later part of code or
>  		 * else swap_off will be aborted if we return NULL.
>  		 */
> -		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
> +		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
>  			goto fail_put_swap;
>  
>  		/*
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8419cba9c192..e9cce775fb25 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1443,7 +1443,7 @@ int __swap_count(swp_entry_t entry)
>   * This does not give an exact answer when swap count is continued,
>   * but does include the high COUNT_CONTINUED flag to allow for that.
>   */
> -static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
> +int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>  {
>  	pgoff_t offset = swp_offset(entry);
>  	struct swap_cluster_info *ci;
> @@ -1455,24 +1455,6 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>  	return count;
>  }
>  
> -/*
> - * How many references to @entry are currently swapped out?
> - * This does not give an exact answer when swap count is continued,
> - * but does include the high COUNT_CONTINUED flag to allow for that.
> - */
> -int __swp_swapcount(swp_entry_t entry)
> -{
> -	int count = 0;
> -	struct swap_info_struct *si;
> -
> -	si = get_swap_device(entry);
> -	if (si) {
> -		count = swap_swapcount(si, entry);
> -		put_swap_device(si);
> -	}
> -	return count;
> -}
> -
>  /*
>   * How many references to @entry are currently swapped out?
>   * This considers COUNT_CONTINUED so it returns exact answer.
> -- 
> 2.39.2
>

Reviewed-by: Chris Li (Google) <chrisl@kernel.org>

Chris
 
