Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E665D1FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbjADMCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjADMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:02:47 -0500
Received: from outbound-smtp06.blacknight.com (outbound-smtp06.blacknight.com [81.17.249.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798781ADAC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:02:46 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 24315C2B0C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:02:45 +0000 (GMT)
Received: (qmail 21443 invoked from network); 4 Jan 2023 12:02:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Jan 2023 12:02:44 -0000
Date:   Wed, 4 Jan 2023 12:02:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm/page_alloc: Explicitly define what alloc flags
 deplete min reserves
Message-ID: <20230104120243.5qopsnscdmuxqyap@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-5-mgorman@techsingularity.net>
 <fbe2d13c-147d-7ce5-91e7-27fcf3d2e5d9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <fbe2d13c-147d-7ce5-91e7-27fcf3d2e5d9@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 06:55:00PM +0100, Vlastimil Babka wrote:
> On 11/29/22 16:16, Mel Gorman wrote:
> > As there are more ALLOC_ flags that affect reserves, define what flags
> > affect reserves and clarify the effect of each flag.
> 
> Seems to me this does more than a clarification, but also some functional
> tweaks, so it could be helpful if those were spelled out in the changelog.
> 

I will to take out the problematic parts that need clarification. There
are two, one I'll drop and the other will be split. More details below.

> > @@ -3976,25 +3975,36 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
> >  {
> >  	long min = mark;
> >  	int o;
> > -	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
> >  
> >  	/* free_pages may go negative - that's OK */
> >  	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
> >  
> > -	if (alloc_flags & ALLOC_MIN_RESERVE)
> > -		min -= min / 2;
> > +	if (alloc_flags & ALLOC_RESERVES) {
> 
> Do we want to keep this unlikely() as alloc_harder did before?
> 

Added back in.

> > +		/*
> > +		 * __GFP_HIGH allows access to 50% of the min reserve as well
> > +		 * as OOM.
> > +		 */
> > +		if (alloc_flags & ALLOC_MIN_RESERVE)
> > +			min -= min / 2;
> >  
> > -	if (unlikely(alloc_harder)) {
> >  		/*
> > -		 * OOM victims can try even harder than normal ALLOC_HARDER
> > +		 * Non-blocking allocations can access some of the reserve
> > +		 * with more access if also __GFP_HIGH. The reasoning is that
> > +		 * a non-blocking caller may incur a more severe penalty
> > +		 * if it cannot get memory quickly, particularly if it's
> > +		 * also __GFP_HIGH.
> > +		 */
> > +		if (alloc_flags & (ALLOC_HARDER|ALLOC_HIGHATOMIC))
> > +			min -= min / 4;
> 
> For example this seems to change the allowed dip to reserves for
> ALLOC_HIGHATOMIC.
> 

You're right and this could cause problems. If high-order atomic allocation
failures start appearing again, this change would help but it should be
a standalone patch in response to a bug. I'll drop it for now.

> > +
> > +		/*
> > +		 * OOM victims can try even harder than the normal reserve
> >  		 * users on the grounds that it's definitely going to be in
> >  		 * the exit path shortly and free memory. Any allocation it
> >  		 * makes during the free path will be small and short-lived.
> >  		 */
> >  		if (alloc_flags & ALLOC_OOM)
> >  			min -= min / 2;
> > -		else
> > -			min -= min / 4;
> >  	}
> 
> (noted that this patch doesn't seem to change the concern I raised in
> previous patch)
> 

This might be addressed now with the chjanges to the patch that caused
you concerns about OOM handling.

> >  	/*
> > @@ -5293,7 +5303,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  		 * could deplete whole memory reserves which would just make
> >  		 * the situation worse
> >  		 */
> > -		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
> > +		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
> 
> And this AFAICS seems to give __GFP_NOFAIL 3/4 of min reserves instead of
> 1/4, which seems like a significant change (but hopefully ok) so worth
> noting at least.
> 

It deserves a standalone patch. Below is the diff I intend to apply to
this patch and the standalone patch.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 58e01a31492e..6f41b84a97ac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3984,7 +3984,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
-	if (alloc_flags & ALLOC_RESERVES) {
+	if (unlikely(alloc_flags & ALLOC_RESERVES)) {
 		/*
 		 * __GFP_HIGH allows access to 50% of the min reserve as well
 		 * as OOM.
@@ -3999,7 +3999,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		 * if it cannot get memory quickly, particularly if it's
 		 * also __GFP_HIGH.
 		 */
-		if (alloc_flags & (ALLOC_HARDER|ALLOC_HIGHATOMIC))
+		if (alloc_flags & ALLOC_HARDER)
 			min -= min / 4;
 
 		/*
@@ -5308,7 +5308,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * could deplete whole memory reserves which would just make
 		 * the situation worse
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
 		if (page)
 			goto got_pg;
 
The patch to allow __GFP_NOFAIL deeper access is this

--8<--
mm/page_alloc.c: Allow __GFP_NOFAIL requests deeper access to reserves

Currently __GFP_NOFAIL allocations without any other flags can access 25%
of the reserves but these requests imply that the system cannot make forward
progress until the allocation succeeds. Allow __GFP_NOFAIL access to 75%
of the min reserve.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f41b84a97ac..d2df78f5baa2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5308,7 +5308,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * could deplete whole memory reserves which would just make
 		 * the situation worse
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
 		if (page)
 			goto got_pg;
 
