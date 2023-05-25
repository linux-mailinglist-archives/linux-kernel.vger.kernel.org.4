Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B114C710756
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjEYIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbjEYI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:29:50 -0400
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D961A7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:29:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id E0B481C3635
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:29:33 +0100 (IST)
Received: (qmail 13895 invoked from network); 25 May 2023 08:29:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2023 08:29:33 -0000
Date:   Thu, 25 May 2023 09:29:28 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: compaction: avoid GFP_NOFS ABBA deadlock
Message-ID: <20230525082928.ovuz77znv763jx3e@techsingularity.net>
References: <20230519111359.40475-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230519111359.40475-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 01:13:59PM +0200, Johannes Weiner wrote:
> During stress testing with higher-order allocations, a deadlock
> scenario was observed in compaction: One GFP_NOFS allocation was
> sleeping on mm/compaction.c::too_many_isolated(), while all CPUs in
> the system were busy with compactors spinning on buffer locks held by
> the sleeping GFP_NOFS allocation.
> 
> Reclaim is susceptible to this same deadlock; we fixed it by granting
> GFP_NOFS allocations additional LRU isolation headroom, to ensure it
> makes forward progress while holding fs locks that other reclaimers
> might acquire. Do the same here.
> 
> This code has been like this since compaction was initially merged,
> and I only managed to trigger this with out-of-tree patches that
> dramatically increase the contexts that do GFP_NOFS compaction. While
> the issue is real, it seems theoretical in nature given existing
> allocation sites. Worth fixing now, but no Fixes tag or stable CC.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

> ---
>  mm/compaction.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> v2:
> - clarify too_many_isolated() comment (Mel)
> - split isolation deadlock from no-contiguous-anon lockups as that's
>   a different scenario and deserves its own patch
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c8bcdea15f5f..c9a4b6dffcf2 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -745,8 +745,9 @@ isolate_freepages_range(struct compact_control *cc,
>  }
>  
>  /* Similar to reclaim, but different enough that they don't share logic */
> -static bool too_many_isolated(pg_data_t *pgdat)
> +static bool too_many_isolated(struct compact_control *cc)
>  {
> +	pg_data_t *pgdat = cc->zone->zone_pgdat;
>  	bool too_many;
>  
>  	unsigned long active, inactive, isolated;
> @@ -758,6 +759,17 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
>  			node_page_state(pgdat, NR_ISOLATED_ANON);
>  
> +	/*
> +	 * Allow GFP_NOFS to isolate past the limit set for regular
> +	 * compaction runs. This prevents an ABBA deadlock when other
> +	 * compactors have already isolated to the limit, but are
> +	 * blocked on filesystem locks held by the GFP_NOFS thread.
> +	 */
> +	if (cc->gfp_mask & __GFP_FS) {
> +		inactive >>= 3;
> +		active >>= 3;
> +	}
> +
>  	too_many = isolated > (inactive + active) / 2;
>  	if (!too_many)
>  		wake_throttle_isolated(pgdat);
> @@ -806,7 +818,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	 * list by either parallel reclaimers or compaction. If there are,
>  	 * delay for some time until fewer pages are isolated
>  	 */
> -	while (unlikely(too_many_isolated(pgdat))) {
> +	while (unlikely(too_many_isolated(cc))) {
>  		/* stop isolation if there are still pages not migrated */
>  		if (cc->nr_migratepages)
>  			return -EAGAIN;
> -- 
> 2.40.0
> 

-- 
Mel Gorman
SUSE Labs
