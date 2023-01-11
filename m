Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77763666167
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjAKRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbjAKRHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:07:32 -0500
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C515645D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:05:56 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id DF5751C3E2E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:05:54 +0000 (GMT)
Received: (qmail 6090 invoked from network); 11 Jan 2023 17:05:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Jan 2023 17:05:54 -0000
Date:   Wed, 11 Jan 2023 17:05:52 +0000
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
Message-ID: <20230111170552.5b7z5hetc2lcdwmb@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-7-mgorman@techsingularity.net>
 <Y77cikPSHepZ/GQj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y77cikPSHepZ/GQj@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:58:02PM +0100, Michal Hocko wrote:
> On Mon 09-01-23 15:16:30, Mel Gorman wrote:
> > Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> > vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> > other non-blocking allocation requests equal access to reserve.  Rename
> > ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> > means.
> 
> GFP_NOWAIT can be also used for opportunistic allocations which can and
> should fail quickly if the memory is tight and more elaborate path
> should be taken (e.g. try higher order allocation first but fall back to
> smaller request if the memory is fragmented). Do we really want to give
> those access to memory reserves as well?

Good question. Without __GFP_ATOMIC, GFP_NOWAIT only differs from GFP_ATOMIC
by __GFP_HIGH but that is not enough to distinguish between a caller that
cannot sleep versus one that is speculatively attempting an allocation but
has other options. That changelog is misleading, it's not equal access
as GFP_NOWAIT ends up with 25% of the reserves which is less than what
GFP_ATOMIC gets.

Because it becomes impossible to distinguish between non-blocking and
atomic without __GFP_ATOMIC, there is some justification for allowing
access to reserves for GFP_NOWAIT. bio for example attempts an allocation
(clears __GFP_DIRECT_RECLAIM) before falling back to mempool but delays
in IO can also lead to further allocation pressure. mmu gather failing
GFP_WAIT slows the rate memory can be freed. NFS failing GFP_NOWAIT will
have to retry IOs multiple times. The examples were picked at random but
the point is that there are cases where failing GFP_NOWAIT can degrade
the system, particularly delay the cleaning of pages before reclaim.

A lot of the truly speculative users appear to use GFP_NOWAIT | __GFP_NOWARN
so one compromise would be to avoid using reserves if __GFP_NOWARN is
also specified.

Something like this as a separate patch?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7244ab522028..0a7a0ac1b46d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4860,9 +4860,11 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
-		 * if it can't schedule.
+		 * if it can't schedule. Similarly, a caller specifying
+		 * __GFP_NOWARN is likely a speculative allocation with a
+		 * graceful recovery path.
 		 */
-		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
+		if (!(gfp_mask & (__GFP_NOMEMALLOC|__GFP_NOWARN))) {
 			alloc_flags |= ALLOC_NON_BLOCK;
 
 			if (order > 0)
