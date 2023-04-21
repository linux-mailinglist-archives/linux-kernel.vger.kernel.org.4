Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32F6EAB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDUNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:12:32 -0400
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC0139
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:12:31 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id C3753FACCF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 14:12:29 +0100 (IST)
Received: (qmail 32508 invoked from network); 21 Apr 2023 13:12:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 13:12:29 -0000
Date:   Fri, 21 Apr 2023 14:12:27 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 08/26] mm: page_alloc: claim blocks during compaction
 capturing
Message-ID: <20230421131227.k2afmhb6kejdbhui@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-9-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:55PM -0400, Johannes Weiner wrote:
> When capturing a whole block, update the migratetype accordingly. For
> example, a THP allocation might capture an unmovable block. If the THP
> gets split and partially freed later, the remainder should group up
> with movable allocations.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/internal.h   |  1 +
>  mm/page_alloc.c | 42 ++++++++++++++++++++++++------------------
>  2 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 024affd4e4b5..39f65a463631 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -432,6 +432,7 @@ struct compact_control {
>   */
>  struct capture_control {
>  	struct compact_control *cc;
> +	int migratetype;
>  	struct page *page;
>  };
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4d20513c83be..8e5996f8b4b4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -615,6 +615,17 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
>  				page_to_pfn(page), MIGRATETYPE_MASK);
>  }
>  
> +static void change_pageblock_range(struct page *pageblock_page,
> +					int start_order, int migratetype)
> +{
> +	int nr_pageblocks = 1 << (start_order - pageblock_order);
> +
> +	while (nr_pageblocks--) {
> +		set_pageblock_migratetype(pageblock_page, migratetype);
> +		pageblock_page += pageblock_nr_pages;
> +	}
> +}
> +
>  #ifdef CONFIG_DEBUG_VM
>  static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>  {
> @@ -962,14 +973,19 @@ compaction_capture(struct capture_control *capc, struct page *page,
>  	    is_migrate_isolate(migratetype))
>  		return false;
>  
> -	/*
> -	 * Do not let lower order allocations pollute a movable pageblock.
> -	 * This might let an unmovable request use a reclaimable pageblock
> -	 * and vice-versa but no more than normal fallback logic which can
> -	 * have trouble finding a high-order free page.
> -	 */
> -	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
> +	if (order >= pageblock_order) {
> +		migratetype = capc->migratetype;
> +		change_pageblock_range(page, order, migratetype);
> +	} else if (migratetype == MIGRATE_MOVABLE) {
> +		/*
> +		 * Do not let lower order allocations pollute a
> +		 * movable pageblock.  This might let an unmovable
> +		 * request use a reclaimable pageblock and vice-versa
> +		 * but no more than normal fallback logic which can
> +		 * have trouble finding a high-order free page.
> +		 */
>  		return false;
> +	}
>  

For capturing pageblock order or larger, why not unconditionally make
the block MOVABLE? Even if it's a zero page allocation, it would be nice
to keep the pageblock for movable pages after the split as long as
possible.

-- 
Mel Gorman
SUSE Labs
