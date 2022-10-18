Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30221602B57
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJRMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJRMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:11:08 -0400
Received: from outbound-smtp58.blacknight.com (outbound-smtp58.blacknight.com [46.22.136.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943373AB0C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:11:06 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id B5A96FB297
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:11:04 +0100 (IST)
Received: (qmail 24438 invoked from network); 18 Oct 2022 12:11:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Oct 2022 12:11:04 -0000
Date:   Tue, 18 Oct 2022 13:11:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <20221018121102.t6k2jwb6tpx3hnyr@techsingularity.net>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZvItUOgTgD11etC@dhcp22.suse.cz>
 <163764199967.7248.2528204111227925210@noble.neil.brown.name>
 <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
 <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
 <Yxb4TQ0WDa85uurY@dhcp22.suse.cz>
 <20220907094724.5lanecgcjg75vxv3@techsingularity.net>
 <20221016193827.37c8c2165b22ae4401c269b4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221016193827.37c8c2165b22ae4401c269b4@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 07:38:27PM -0700, Andrew Morton wrote:
> On Wed, 7 Sep 2022 10:47:24 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > On Tue, Sep 06, 2022 at 09:35:41AM +0200, Michal Hocko wrote:
> > > > From: "NeilBrown" <neilb@suse.de>
> > > > Subject: mm: discard __GFP_ATOMIC
> > > > 
> > > > __GFP_ATOMIC serves little purpose.  Its main effect is to set
> > > > ALLOC_HARDER which adds a few little boosts to increase the chance of an
> > > > allocation succeeding, one of which is to lower the water-mark at which it
> > > > will succeed.
> > > > 
> > > > It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> > > > adjusts this watermark.  It is probable that other users of __GFP_HIGH
> > > > should benefit from the other little bonuses that __GFP_ATOMIC gets.
> > > > 
> > > > __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM. 
> > > > There is little point to this.  We already get a might_sleep() warning if
> > > > __GFP_DIRECT_RECLAIM is set.
> > > > 
> > > > __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> > > > probable that testing ALLOC_HARDER is a better fit here.
> > > > 
> > > > __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> > > > sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> > > > 
> > > > This patch:
> > > >  - removes __GFP_ATOMIC
> > > >  - causes __GFP_HIGH to set ALLOC_HARDER unless __GFP_NOMEMALLOC is set
> > > >    (as well as ALLOC_HIGH).
> > > >  - makes other adjustments as suggested by the above.
> > > > 
> > > > The net result is not change to GFP_ATOMIC allocations.  Other
> > > > allocations that use __GFP_HIGH will benefit from a few different extra
> > > > privileges.  This affects:
> > > >   xen, dm, md, ntfs3
> > > >   the vermillion frame buffer
> > > >   hibernation
> > > >   ksm
> > > >   swap
> > > > all of which likely produce more benefit than cost if these selected
> > > > allocation are more likely to succeed quickly.
> > > 
> > > This is a good summary of the current usage and existing issues. It also
> > > shows that the naming is tricky and allows people to make wrong calls
> > > (tegra-smmu.c). I also thing that it is wrong to couple memory reserves
> > > access to the reclaim constrains/expectations of the caller.
> > > 
> > 
> > I think it's worth trying to get rid of __GFP_ATOMIC although this patch
> > needs to be rebased. Without rebasing it, I suspect there is a corner case
> > for reserving high order atomic blocks. A high-order atomic allocation
> > might get confused with a __GFP_HIGH high-order allocation that can sleep.
> > It would not be completely irrational to have such a caller if it was in a
> > path that can tolerate a stall but stalling might have visible consequences.
> > I'm also worried that the patch might allow __GFP_HIGH to ignore cpusets
> > which is probably not intended by direct users like ksm.
> 
> Unclear what you mean by "rebased". 

I was looking at the original patch, not what was in mm-unstable.

> You're saying the patch might have
> issues - doesn't that mean it needs to be "fixed"?
> 

Yes, I think it needs some follow-on work.

> Anyway, I've been maintaining this change for nearly a year - if
> nothing happens soon I guess I'll drop it so it doesn't get in people's
> way.

I think it's easier to highlight my concerns by renaming ALLOC_HARDER
to ALLOC_MIN_RESERVE because that's effectively what it means.  It then
becomes a bit more obvious where the problems might be.

They're all fixable but do people agree that these problems are real or
my imagination?

---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4b44ced87fff..8c7fd034b277 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -743,7 +743,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_HARDER		 0x10 /* try to alloc harder */
+#define ALLOC_MIN_RESERVE	 0x10 /* allow allocations below min watermark */
 #define ALLOC_HIGH		 0x20 /* __GFP_HIGH set */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1a9a844dc197..9ff4cd4c5d11 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3708,8 +3708,16 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		 * due to non-CMA allocation context. HIGHATOMIC area is
 		 * reserved for high-order atomic allocation, so order-0
 		 * request should skip it.
+		 *
+		 * BZZT: __GFP_HIGH sets ALLOC_MIN_RESERVE and while __GFP_HIGH
+		 * 	 is set for GFP_ATOMIC, it does not mean that all
+		 * 	 __GFP_HIGH allocations also do not specify
+		 * 	 _GFP_DIRECT_RECLAIM. While there do not appear to
+		 * 	 be any in-tree users that allocation high-order pages
+		 * 	 using __GFP_HIGH && !__GFP_DIRECT_RECLAIM, it's a
+		 * 	 potential issue.
 		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER)
+		if (order > 0 && alloc_flags & ALLOC_MIN_RESERVE)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
@@ -3943,11 +3951,11 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
+	const bool alloc_harder = (alloc_flags & (ALLOC_MIN_RESERVE|ALLOC_OOM));
 	long unusable_free = (1 << order) - 1;
 
 	/*
-	 * If the caller does not have rights to ALLOC_HARDER then subtract
+	 * If the caller does not have rights to ALLOC_MIN_RESERVE then subtract
 	 * the high-atomic reserves. This will over-estimate the size of the
 	 * atomic reserve but it avoids a search.
 	 */
@@ -3975,17 +3983,21 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 {
 	long min = mark;
 	int o;
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
+	const bool alloc_harder = (alloc_flags & (ALLOC_MIN_RESERVE|ALLOC_OOM));
 
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
+	/*
+	 * BZZT: ALLOC_HIGH is now effectively an alias of ALLOC_MIN_RESERVE
+	 *       so we end up double dipping below.
+	 */
 	if (alloc_flags & ALLOC_HIGH)
 		min -= min / 2;
 
 	if (unlikely(alloc_harder)) {
 		/*
-		 * OOM victims can try even harder than normal ALLOC_HARDER
+		 * OOM victims can try even harder than normal ALLOC_MIN_RESERVE
 		 * users on the grounds that it's definitely going to be in
 		 * the exit path shortly and free memory. Any allocation it
 		 * makes during the free path will be small and short-lived.
@@ -4027,6 +4039,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
+		/* BZZT: ALLOC_MIN_RESERVE does not imply access to highatomic reserves */
 		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
 			return true;
 	}
@@ -4069,12 +4082,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 					free_pages))
 		return true;
 	/*
-	 * Ignore watermark boosting for GFP_HIGH order-0 allocations
+	 * Ignore watermark boosting for __GFP_HIGH order-0 allocations
 	 * when checking the min watermark. The min watermark is the
 	 * point where boosting is ignored so that kswapd is woken up
 	 * when below the low watermark.
 	 */
-	if (unlikely(!order && (alloc_flags & ALLOC_HARDER) && z->watermark_boost
+	if (unlikely(!order && (alloc_flags & ALLOC_MIN_RESERVE) && z->watermark_boost
 		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
 		mark = z->_watermark[WMARK_MIN];
 		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
@@ -4289,8 +4302,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			/*
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
+			 *
+			 * BZZT: __GFP_HIGH does not imply high-order atomic
 			 */
-			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
+			if (unlikely(order && (alloc_flags & ALLOC_MIN_RESERVE)))
 				reserve_highatomic_pageblock(page, zone, order);
 
 			return page;
@@ -4834,6 +4849,10 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
 	 * set both ALLOC_HARDER (unless __GFP_NOMEMALLOC) and ALLOC_HIGH.
+	 *
+	 * BZZT: Minor conflation issue. __GFP_HIGH == ALLOC_HIGH but they are
+	 * 	 now very similar to each other. Probably should remove
+	 * 	 ALLOC_HIGH and modify __GFP_HIGH == ALLOC_MIN_RESERVE
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
@@ -4844,14 +4863,24 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 		 * if it can't schedule.
 		 */
 		if (!(gfp_mask & __GFP_NOMEMALLOC))
-			alloc_flags |= ALLOC_HARDER;
+			alloc_flags |= ALLOC_MIN_RESERVE;
 		/*
 		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
 		 * comment for __cpuset_node_allowed().
+		 *
+		 * BZZT: Not necessarily "atomic", should have checked
+		 * 	 __GFP_DIRECT_RECLAIM? This is a matter of
+		 * 	 definition as __GFP_HIGH is documented as being
+		 * 	 necessary for the system to make progress.
+		 * 	 Either enforce cpusets or update __GFP_HIGH
+		 * 	 documentation stating that CPUSETS may be
+		 * 	 broken. Based on the current __GFP_HIGH
+		 * 	 direct users, documenting that cpusets can
+		 * 	 be broken appears to be the safest option.
 		 */
 		alloc_flags &= ~ALLOC_CPUSET;
 	} else if (unlikely(rt_task(current)) && in_task())
-		alloc_flags |= ALLOC_HARDER;
+		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
@@ -5277,7 +5306,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * could deplete whole memory reserves which would just make
 		 * the situation worse
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);
 		if (page)
 			goto got_pg;
 
