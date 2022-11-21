Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8D632183
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKUMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiKUMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:01:27 -0500
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BC769D2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:01:24 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 4B5491C05
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:01:23 +0000 (GMT)
Received: (qmail 8046 invoked from network); 21 Nov 2022 12:01:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Nov 2022 12:01:22 -0000
Date:   Mon, 21 Nov 2022 12:01:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-ID: <20221121120121.djgvgm5bsklgfx7c@techsingularity.net>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
 <20221118101714.19590-3-mgorman@techsingularity.net>
 <f9acd363-bf53-c582-78ec-347fd7ec5c37@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f9acd363-bf53-c582-78ec-347fd7ec5c37@suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 03:30:57PM +0100, Vlastimil Babka wrote:
> On 11/18/22 11:17, Mel Gorman wrote:
> > The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> > allocating from the PCP must not re-enter the allocator from IRQ context.
> > In each instance where IRQ-reentrancy is possible, the lock is acquired
> > using pcp_spin_trylock_irqsave() even though IRQs are disabled and
> > re-entrancy is impossible.
> > 
> > Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> > case at the cost of some IRQ allocations taking a slower path. If the PCP
> > lists need to be refilled, the zone lock still needs to disable IRQs but
> > that will only happen on PCP refill and drain. If an IRQ is raised when
> > a PCP allocation is in progress, the trylock will fail and fallback to
> > using the buddy lists directly. Note that this may not be a universal win
> > if an interrupt-intensive workload also allocates heavily from interrupt
> > context and contends heavily on the zone->lock as a result.
> > 
> > [yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
> > [hughd@google.com: Fix list corruption, lock improvements, micro-optimsations]
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Some nits below:
> 

Thanks.

> > @@ -3516,10 +3485,10 @@ void free_unref_page(struct page *page, unsigned int order)
> >   */
> >  void free_unref_page_list(struct list_head *list)
> >  {
> > +	unsigned long __maybe_unused UP_flags;
> >  	struct page *page, *next;
> >  	struct per_cpu_pages *pcp = NULL;
> >  	struct zone *locked_zone = NULL;
> > -	unsigned long flags;
> >  	int batch_count = 0;
> >  	int migratetype;
> >  
> > @@ -3550,11 +3519,26 @@ void free_unref_page_list(struct list_head *list)
> >  
> >  		/* Different zone, different pcp lock. */
> >  		if (zone != locked_zone) {
> > -			if (pcp)
> > -				pcp_spin_unlock_irqrestore(pcp, flags);
> > +			if (pcp) {
> > +				pcp_spin_unlock(pcp);
> > +				pcp_trylock_finish(UP_flags);
> > +			}
> >  
> > +			/*
> > +			 * trylock is necessary as pages may be getting freed
> > +			 * from IRQ or SoftIRQ context after an IO completion.
> > +			 */
> > +			pcp_trylock_prepare(UP_flags);
> > +			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> > +			if (!pcp) {
> 
> Perhaps use unlikely() here?
> 

Sure, I'm less convinced these days that unlikely makes a big difference
with improvements to branch prediction but there is no harm in annotating
it. It's probably time to do a round of PROFILE_ALL_BRANCHES checking.

> > +				pcp_trylock_finish(UP_flags);
> > +				free_one_page(zone, page, page_to_pfn(page),
> > +					      0, migratetype, FPI_NONE);
> 
> Not critical for correctness, but the migratepage here might be stale and we
> should do get_pcppage_migratetype(page);
> 

Yes, the call should move up. Isolated pages should already have been
removed and while it's possible there would still be a race, it's unlikely
and no worse than the existing isolated page checks.

> > +				locked_zone = NULL;
> > +				continue;
> > +			}
> >  			locked_zone = zone;
> > -			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
> > +			batch_count = 0;
> >  		}
> >  
> >  		/*
> > @@ -3569,18 +3553,23 @@ void free_unref_page_list(struct list_head *list)
> >  		free_unref_page_commit(zone, pcp, page, migratetype, 0);
> >  
> >  		/*
> > -		 * Guard against excessive IRQ disabled times when we get
> > -		 * a large list of pages to free.
> > +		 * Guard against excessive lock hold times when freeing
> > +		 * a large list of pages. Lock will be reacquired if
> > +		 * necessary on the next iteration.
> >  		 */
> >  		if (++batch_count == SWAP_CLUSTER_MAX) {
> > -			pcp_spin_unlock_irqrestore(pcp, flags);
> > +			pcp_spin_unlock(pcp);
> > +			pcp_trylock_finish(UP_flags);
> >  			batch_count = 0;
> > -			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
> > +			pcp = NULL;
> > +			locked_zone = NULL;
> 
> AFAICS if this block was just "locked_zone = NULL;" then the existing code
> would do the right thing.
> Or maybe to have simpler code, just do batch_count++ here and
> make the relocking check do
> if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX)
> 

While I think you're right, I think it's a bit subtle, the batch reset would
need to move, rechecked within the "Different zone, different pcp lock."
block and it would be easy to forget exactly why it's structured like
that in the future.  Rather than being a fix, it could be a standalone
patch so it would be obvious in git blame but I don't feel particularly
strongly about it.

For the actual fixes to the patch, how about this? It's boot-tested only
as I find it hard to believe it would make a difference to performance.

--8<--
mm/page_alloc: Leave IRQs enabled for per-cpu page allocations -fix

As noted by Vlastimil Babka, the migratetype might be wrong if a PCP
fails to lock so check the migrate type early. Similarly the !pcp check
is generally unlikely so explicitly tagging it makes sense.

This is a fix for the mm-unstable patch
mm-page_alloc-leave-irqs-enabled-for-per-cpu-page-allocations.patch

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 323fec05c4c6..445066617204 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3516,6 +3516,7 @@ void free_unref_page_list(struct list_head *list)
 		struct zone *zone = page_zone(page);
 
 		list_del(&page->lru);
+		migratetype = get_pcppage_migratetype(page);
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
@@ -3530,7 +3531,7 @@ void free_unref_page_list(struct list_head *list)
 			 */
 			pcp_trylock_prepare(UP_flags);
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
-			if (!pcp) {
+			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, page, page_to_pfn(page),
 					      0, migratetype, FPI_NONE);
@@ -3545,7 +3546,6 @@ void free_unref_page_list(struct list_head *list)
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
 		 */
-		migratetype = get_pcppage_migratetype(page);
 		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
 			migratetype = MIGRATE_MOVABLE;
 

-- 
Mel Gorman
SUSE Labs
