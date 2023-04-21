Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD826EAA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjDUM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjDUM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:27:59 -0400
Received: from outbound-smtp58.blacknight.com (outbound-smtp58.blacknight.com [46.22.136.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED3B755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:27:50 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 339D9FACC8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:27:49 +0100 (IST)
Received: (qmail 31734 invoked from network); 21 Apr 2023 12:27:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 12:27:48 -0000
Date:   Fri, 21 Apr 2023 13:27:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 02/26] mm: compaction: avoid GFP_NOFS deadlocks
Message-ID: <20230421122743.d7xfvzyhiunbphh3@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-3-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:49PM -0400, Johannes Weiner wrote:
> During stress testing, two deadlock scenarios were observed:
> 
> 1. One GFP_NOFS allocation was sleeping on too_many_isolated(), and
>    all CPUs were busy with compactors that appeared to be spinning on
>    buffer locks.
> 
>    Give GFP_NOFS compactors additional isolation headroom, the same
>    way we do during reclaim, to eliminate this deadlock scenario.
> 
> 2. In a more pernicious scenario, the GFP_NOFS allocation was
>    busy-spinning in compaction, but seemingly never making
>    progress. Upon closer inspection, memory was dominated by file
>    pages, which the fs compactor isn't allowed to touch. The remaining
>    anon pages didn't have the contiguity to satisfy the request.
> 
>    Allow GFP_NOFS allocations to bypass watermarks when compaction
>    failed at the highest priority.
> 
> While these deadlocks were encountered only in tests with the
> subsequent patches (which put a lot more demand on compaction), in
> theory these problems already exist in the code today. Fix them now.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Definitely needs to be split out.


> ---
>  mm/compaction.c | 15 +++++++++++++--
>  mm/page_alloc.c | 10 +++++++++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 8238e83385a7..84db84e8fd3a 100644
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
> @@ -758,6 +759,16 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
>  			node_page_state(pgdat, NR_ISOLATED_ANON);
>  
> +	/*
> +	 * GFP_NOFS callers are allowed to isolate more pages, so they
> +	 * won't get blocked by normal direct-reclaimers, forming a
> +	 * circular deadlock. GFP_NOIO won't get here.
> +	 */
> +	if (cc->gfp_mask & __GFP_FS) {
> +		inactive >>= 3;
> +		active >>= 3;
> +	}
> +

This comment needs to explain why GFP_NOFS gets special treatment
explaning that a GFP_NOFS context may not be able to migrate pages and
why.

As a follow-up, if GFP_NOFS cannot deal with the majority of the
migration contexts then it should bail out of compaction entirely. The
changelog doesn't say why but maybe SYNC_LIGHT is the issue?

-- 
Mel Gorman
SUSE Labs
