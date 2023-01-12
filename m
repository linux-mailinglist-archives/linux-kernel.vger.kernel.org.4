Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC60C666E41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjALJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjALJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:29:44 -0500
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com [46.22.139.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B050E75
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:24:56 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 1277A1FDB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:24:55 +0000 (GMT)
Received: (qmail 22350 invoked from network); 12 Jan 2023 09:24:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2023 09:24:54 -0000
Date:   Thu, 12 Jan 2023 09:24:52 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Message-ID: <20230112092452.rtvo6tkp4rpmxm7v@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-7-mgorman@techsingularity.net>
 <Y77cikPSHepZ/GQj@dhcp22.suse.cz>
 <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
 <Y7/AmgN1Wz73lyVz@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y7/AmgN1Wz73lyVz@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:11:06AM +0100, Michal Hocko wrote:
> On Wed 11-01-23 17:05:52, Mel Gorman wrote:
> > On Wed, Jan 11, 2023 at 04:58:02PM +0100, Michal Hocko wrote:
> > > On Mon 09-01-23 15:16:30, Mel Gorman wrote:
> > > > Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> > > > vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> > > > other non-blocking allocation requests equal access to reserve.  Rename
> > > > ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> > > > means.
> > > 
> > > GFP_NOWAIT can be also used for opportunistic allocations which can and
> > > should fail quickly if the memory is tight and more elaborate path
> > > should be taken (e.g. try higher order allocation first but fall back to
> > > smaller request if the memory is fragmented). Do we really want to give
> > > those access to memory reserves as well?
> > 
> > Good question. Without __GFP_ATOMIC, GFP_NOWAIT only differs from GFP_ATOMIC
> > by __GFP_HIGH but that is not enough to distinguish between a caller that
> > cannot sleep versus one that is speculatively attempting an allocation but
> > has other options. That changelog is misleading, it's not equal access
> > as GFP_NOWAIT ends up with 25% of the reserves which is less than what
> > GFP_ATOMIC gets.
> > 
> > Because it becomes impossible to distinguish between non-blocking and
> > atomic without __GFP_ATOMIC, there is some justification for allowing
> > access to reserves for GFP_NOWAIT. bio for example attempts an allocation
> > (clears __GFP_DIRECT_RECLAIM) before falling back to mempool but delays
> > in IO can also lead to further allocation pressure. mmu gather failing
> > GFP_WAIT slows the rate memory can be freed. NFS failing GFP_NOWAIT will
> > have to retry IOs multiple times. The examples were picked at random but
> > the point is that there are cases where failing GFP_NOWAIT can degrade
> > the system, particularly delay the cleaning of pages before reclaim.
> 
> Fair points.
> 
> > A lot of the truly speculative users appear to use GFP_NOWAIT | __GFP_NOWARN
> > so one compromise would be to avoid using reserves if __GFP_NOWARN is
> > also specified.
> > 
> > Something like this as a separate patch?
> 
> I cannot say I would be happy about adding more side effects to
> __GFP_NOWARN. You are right that it should be used for those optimistic
> allocation requests but historically all many of these subtle side effects
> have kicked back at some point.

True.

> Wouldn't it make sense to explicitly
> mark those places which really benefit from reserves instead?

That would be __GFP_HIGH and would require context from every caller on
whether they need reserves or not and to determine what the consequences
are if there is a stall. Is there immediate local fallout or wider fallout
such as a variable delay before pages can be cleaned?

> This is
> more work but it should pay off long term. Your examples above would use
> GFP_ATOMIC instead of GFP_NOWAIT.
> 

Yes, although it would confuse the meaning of GFP_ATOMIC as a result.
It's described as "%GFP_ATOMIC users can not sleep and need the allocation to
succeed" and something like the bio callsite does not *need* the allocation
to succeed. It can fallback to the mempool and performance simply degrades
temporarily. No doubt there are a few abuses of GFP_ATOMIC just to get
non-blocking behaviour already.

> The semantic would be easier to explain as well. GFP_ATOMIC - non
> sleeping allocations which are important so they have access to memory
> reserves. GFP_NOWAIT - non sleeping allocations.
> 

People's definition of "important" will vary wildly. The following would
avoid reserve access for GFP_NOWAIT for now. It would need to be folded
into this patch and a new changelog

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7244ab522028..aa20165224cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3989,18 +3989,19 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		 * __GFP_HIGH allows access to 50% of the min reserve as well
 		 * as OOM.
 		 */
-		if (alloc_flags & ALLOC_MIN_RESERVE)
+		if (alloc_flags & ALLOC_MIN_RESERVE) {
 			min -= min / 2;
 
-		/*
-		 * Non-blocking allocations can access some of the reserve
-		 * with more access if also __GFP_HIGH. The reasoning is that
-		 * a non-blocking caller may incur a more severe penalty
-		 * if it cannot get memory quickly, particularly if it's
-		 * also __GFP_HIGH.
-		 */
-		if (alloc_flags & ALLOC_NON_BLOCK)
-			min -= min / 4;
+			/*
+			 * Non-blocking allocations (e.g. GFP_ATOMIC) can
+			 * access more reserves than just __GFP_HIGH. Other
+			 * non-blocking allocations requests such as GFP_NOWAIT
+			 * or (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) do not get
+			 * access to the min reserve.
+			 */
+			if (alloc_flags & ALLOC_NON_BLOCK)
+				min -= min / 4;
+		}
 
 		/*
 		 * OOM victims can try even harder than the normal reserve





-- 
Mel Gorman
SUSE Labs
