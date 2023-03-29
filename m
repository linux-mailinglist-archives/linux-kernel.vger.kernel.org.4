Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86BD6CD676
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjC2Jbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2Jbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:31:46 -0400
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FFE19A4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:31:44 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 7337A1F5D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:31:42 +0100 (IST)
Received: (qmail 27444 invoked from network); 29 Mar 2023 09:31:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Mar 2023 09:31:42 -0000
Date:   Wed, 29 Mar 2023 10:31:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexander Halbuer <halbuer@sra.uni-hannover.de>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
Message-ID: <20230329093140.xds6mc3bax5xzaft@techsingularity.net>
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:25:49PM +0100, Alexander Halbuer wrote:
> The `rmqueue_bulk` function batches the allocation of multiple elements to
> refill the per-CPU buffers into a single hold of the zone lock. Each
> element is allocated and checked using the `check_pcp_refill` function.
> The check touches every related struct page which is especially expensive
> for higher order allocations (huge pages). This patch reduces the time
> holding the lock by moving the check out of the critical section similar
> to the `rmqueue_buddy` function which allocates a single element.
> Measurements of parallel allocation-heavy workloads show a reduction of
> the average huge page allocation latency of 50 percent for two cores and
> nearly 90 percent for 24 cores.
> 
> Signed-off-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Minor comments only.

> ---
>  mm/page_alloc.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..4b80438b1f59 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3119,6 +3119,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  {
>  	unsigned long flags;
>  	int i, allocated = 0;
> +	struct list_head *prev_tail = list->prev;
> +	struct page *pos, *n;
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  	for (i = 0; i < count; ++i) {
> @@ -3127,9 +3129,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		if (unlikely(page == NULL))
>  			break;
>  
> -		if (unlikely(check_pcp_refill(page, order)))
> -			continue;
> -
>  		/*
>  		 * Split buddy pages returned by expand() are received here in
>  		 * physical page order. The page is added to the tail of
> @@ -3141,7 +3140,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 * pages are ordered properly.
>  		 */
>  		list_add_tail(&page->pcp_list, list);
> -		allocated++;
>  		if (is_migrate_cma(get_pcppage_migratetype(page)))
>  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
>  					      -(1 << order));

As a side-effect, the NR_FREE_CMA_PAGES accounting does not drift when bad
pages are found. It's rarely an issue and when it is an issue, corruption
due to a use-after-free has occurred and the system is already potentially
screwed. It's not enough to justify a patch split or -stable backport
and probably existed forever. I don't remember the last time these checks
actually caught corruption of struct pages although years ago I was told
it often found problems.

> @@ -3155,6 +3153,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	 */
>  	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
>  	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	/*
> +	 * Pages are appended to the pcp list without checking to reduce the
> +	 * time holding the zone lock. Checking the appended pages happens right
> +	 * after the critical section while still holding the pcp lock.
> +	 */
> +	pos = list_first_entry(prev_tail, struct page, pcp_list);
> +	list_for_each_entry_safe_from(pos, n, list, pcp_list) {
> +		if (unlikely(check_pcp_refill(pos, order))) {
> +			list_del(&pos->pcp_list);
> +			continue;
> +		}
> +
> +		allocated++;
> +	}
> +

Minor nit and not important for this patch but the list is traversed
even if check_pcp_refill does nothing but return false. The associated
helpers like check_pcp_refill under CONFIG_DEBUG_VM would need a helper
to determine if the list traversal is necessary. Maybe the compiler can
figure it out but I doubt it due to static branches.

Secondly, this does not kill the patch but the performance benefit is likely
artificial or limited in most cases. It specifically affects the case where
a buddy allocation such as THP or HugeTLBFS is happening in parallel with
allocations that are refilling the PCP lists. The most likely time that
this would happen is during early init of a memory-intensive parallelised
application. While the init phase *can* be critical when the primary
metric is "Time before a application is warmed up", it's not common.
Even if the patch is taking care of a corner case, it's still justified.

-- 
Mel Gorman
SUSE Labs
