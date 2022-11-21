Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1D6328EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiKUQDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKUQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:03:31 -0500
Received: from outbound-smtp31.blacknight.com (outbound-smtp31.blacknight.com [81.17.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE9C4E42D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:03:29 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 97E16C0BE7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:03:27 +0000 (GMT)
Received: (qmail 9867 invoked from network); 21 Nov 2022 16:03:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Nov 2022 16:03:27 -0000
Date:   Mon, 21 Nov 2022 16:03:24 +0000
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
Message-ID: <20221121160324.4q7clvqdqohgycqh@techsingularity.net>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
 <20221118101714.19590-3-mgorman@techsingularity.net>
 <f9acd363-bf53-c582-78ec-347fd7ec5c37@suse.cz>
 <20221121120121.djgvgm5bsklgfx7c@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221121120121.djgvgm5bsklgfx7c@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:01:23PM +0000, Mel Gorman wrote:
> On Fri, Nov 18, 2022 at 03:30:57PM +0100, Vlastimil Babka wrote:
> > On 11/18/22 11:17, Mel Gorman wrote:
> > AFAICS if this block was just "locked_zone = NULL;" then the existing code
> > would do the right thing.
> > Or maybe to have simpler code, just do batch_count++ here and
> > make the relocking check do
> > if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX)
> > 
> 
> While I think you're right, I think it's a bit subtle, the batch reset would
> need to move, rechecked within the "Different zone, different pcp lock."
> block and it would be easy to forget exactly why it's structured like
> that in the future.  Rather than being a fix, it could be a standalone
> patch so it would be obvious in git blame but I don't feel particularly
> strongly about it.
> 

Ok, less subtle than I initially thought but still deserving of a separate
patch instead of being a fix. This?

--8<--
mm/page_alloc: Simplify locking during free_unref_page_list

While freeing a large list, the zone lock will be released and reacquired
to avoid long hold times since commit c24ad77d962c ("mm/page_alloc.c: avoid
excessive IRQ disabled times in free_unref_page_list()"). As suggested
by Vlastimil Babka, the lockrelease/reacquire logic can be simplified by
reusing the logic that acquires a different lock when changing zones.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 445066617204..08e32daf0918 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3518,13 +3518,19 @@ void free_unref_page_list(struct list_head *list)
 		list_del(&page->lru);
 		migratetype = get_pcppage_migratetype(page);
 
-		/* Different zone, different pcp lock. */
-		if (zone != locked_zone) {
+		/*
+		 * Either different zone requiring a different pcp lock or
+		 * excessive lock hold times when freeing a large list of
+		 * pages.
+		 */
+		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
 			if (pcp) {
 				pcp_spin_unlock(pcp);
 				pcp_trylock_finish(UP_flags);
 			}
 
+			batch_count = 0;
+
 			/*
 			 * trylock is necessary as pages may be getting freed
 			 * from IRQ or SoftIRQ context after an IO completion.
@@ -3539,7 +3545,6 @@ void free_unref_page_list(struct list_head *list)
 				continue;
 			}
 			locked_zone = zone;
-			batch_count = 0;
 		}
 
 		/*
@@ -3551,19 +3556,7 @@ void free_unref_page_list(struct list_head *list)
 
 		trace_mm_page_free_batched(page);
 		free_unref_page_commit(zone, pcp, page, migratetype, 0);
-
-		/*
-		 * Guard against excessive lock hold times when freeing
-		 * a large list of pages. Lock will be reacquired if
-		 * necessary on the next iteration.
-		 */
-		if (++batch_count == SWAP_CLUSTER_MAX) {
-			pcp_spin_unlock(pcp);
-			pcp_trylock_finish(UP_flags);
-			batch_count = 0;
-			pcp = NULL;
-			locked_zone = NULL;
-		}
+		batch_count++;
 	}
 
 	if (pcp) {
