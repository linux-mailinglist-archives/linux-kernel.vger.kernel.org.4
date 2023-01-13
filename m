Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1206666982A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbjAMNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbjAMNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:13:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639087F3E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:02:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DE6325513;
        Fri, 13 Jan 2023 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673614923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yM+O9RaRDIJzXpy9G7D7o0f000JhWAb4w/MPXQEEUNY=;
        b=kA/fJKiethYO6T6us3a5KSmzDSY/071HM3lyrz1jEhcZK1GqUPQvlZPXOtxV/odLJ64bP5
        eb/JyGhLmLjvh1dStGJLx/UUndkDwu7diu1l3gnqZmd5G8QMzJzbdrK3lQwrpJmnsNzlTV
        9ceeaKnD8VBYAezhInnVPBX9DDsg9aI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C29813913;
        Fri, 13 Jan 2023 13:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mvlkEEtWwWNdaAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 13 Jan 2023 13:02:03 +0000
Date:   Fri, 13 Jan 2023 14:02:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Explicitly record high-order atomic
 allocations in alloc_flags
Message-ID: <Y8FWSWZ8dHVooCvN@dhcp22.suse.cz>
References: <20230113111217.14134-1-mgorman@techsingularity.net>
 <20230113111217.14134-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113111217.14134-4-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-01-23 11:12:14, Mel Gorman wrote:
> A high-order ALLOC_HARDER allocation is assumed to be atomic. While that
> is accurate, it changes later in the series. In preparation, explicitly
> record high-order atomic allocations in gfp_to_alloc_flags().
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/internal.h   |  1 +
>  mm/page_alloc.c | 29 +++++++++++++++++++++++------
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 403e4386626d..178484d9fd94 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -746,6 +746,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #else
>  #define ALLOC_NOFRAGMENT	  0x0
>  #endif
> +#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>  
>  enum ttu_flags;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0040b4e00913..0ef4f3236a5a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3706,10 +3706,20 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  		 * reserved for high-order atomic allocation, so order-0
>  		 * request should skip it.
>  		 */
> -		if (order > 0 && alloc_flags & ALLOC_HARDER)
> +		if (alloc_flags & ALLOC_HIGHATOMIC)
>  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  		if (!page) {
>  			page = __rmqueue(zone, order, migratetype, alloc_flags);
> +
> +			/*
> +			 * If the allocation fails, allow OOM handling access
> +			 * to HIGHATOMIC reserves as failing now is worse than
> +			 * failing a high-order atomic allocation in the
> +			 * future.
> +			 */
> +			if (!page && (alloc_flags & ALLOC_OOM))
> +				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> +
>  			if (!page) {
>  				spin_unlock_irqrestore(&zone->lock, flags);
>  				return NULL;
> @@ -4023,8 +4033,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  			return true;
>  		}
>  #endif
> -		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
> +		if ((alloc_flags & (ALLOC_HIGHATOMIC|ALLOC_OOM)) &&
> +		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
>  			return true;
> +		}
>  	}
>  	return false;
>  }
> @@ -4286,7 +4298,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			 * If this is a high-order atomic allocation then check
>  			 * if the pageblock should be reserved for the future
>  			 */
> -			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
> +			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
>  				reserve_highatomic_pageblock(page, zone, order);
>  
>  			return page;
> @@ -4813,7 +4825,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
>  }
>  
>  static inline unsigned int
> -gfp_to_alloc_flags(gfp_t gfp_mask)
> +gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  {
>  	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
>  
> @@ -4839,8 +4851,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
>  		 * if it can't schedule.
>  		 */
> -		if (!(gfp_mask & __GFP_NOMEMALLOC))
> +		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>  			alloc_flags |= ALLOC_HARDER;
> +
> +			if (order > 0)
> +				alloc_flags |= ALLOC_HIGHATOMIC;
> +		}
> +
>  		/*
>  		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
>  		 * comment for __cpuset_node_allowed().
> @@ -5048,7 +5065,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * kswapd needs to be woken up, and to avoid the cost of setting up
>  	 * alloc_flags precisely. So we do that now.
>  	 */
> -	alloc_flags = gfp_to_alloc_flags(gfp_mask);
> +	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
>  
>  	/*
>  	 * We need to recalculate the starting point for the zonelist iterator
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
