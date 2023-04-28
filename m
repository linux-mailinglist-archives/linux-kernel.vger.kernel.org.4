Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8E6F1572
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjD1K3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjD1K3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:29:43 -0400
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037E1BFE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:29:41 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id A48CEC0E9F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:29:39 +0100 (IST)
Received: (qmail 29727 invoked from network); 28 Apr 2023 10:29:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Apr 2023 10:29:38 -0000
Date:   Fri, 28 Apr 2023 11:29:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 05/26] mm: page_alloc: per-migratetype pcplist for
 THPs
Message-ID: <20230428102936.7qsaskyjkpiyapgq@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-6-hannes@cmpxchg.org>
 <20230421124744.skrxvziwg3bx7rgt@techsingularity.net>
 <20230421150648.GB320347@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230421150648.GB320347@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:06:48AM -0400, Johannes Weiner wrote:
> On Fri, Apr 21, 2023 at 01:47:44PM +0100, Mel Gorman wrote:
> > On Tue, Apr 18, 2023 at 03:12:52PM -0400, Johannes Weiner wrote:
> > > Right now, there is only one pcplist for THP allocations. However,
> > > while most THPs are movable, the huge zero page is not. This means a
> > > movable THP allocation can grab an unmovable block from the pcplist,
> > > and a subsequent THP split, partial free, and reallocation of the
> > > remainder will mix movable and unmovable pages in the block.
> > > 
> > > While this isn't a huge source of block pollution in practice, it
> > > happens often enough to trigger debug warnings fairly quickly under
> > > load. In the interest of tightening up pageblock hygiene, make the THP
> > > pcplists fully migratetype-aware, just like the lower order ones.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Split out :P
> > 
> > Take special care of this one because, while I didn't check this, I
> > suspect it'll push the PCP structure size into the next cache line and
> > increase overhead.
> >
> > The changelog makes it unclear why exactly this happens or why the
> > patch fixes it.
> 
> Before this, I'd see warnings from the last patch in the series about
> received migratetype not matching requested mt.
> 
> The way it happens is that the zero page gets freed and the unmovable
> block put on the pcplist. A regular THP allocation is subsequently
> served from an unmovable block.
> 
> Mental note, I think this can happen the other way around too: a
> regular THP on the pcp being served to a MIGRATE_UNMOVABLE zero
> THP. It's not supposed to, but it looks like there is a bug in the
> code that's meant to prevent that from happening in rmqueue():
> 
> 	if (likely(pcp_allowed_order(order))) {
> 		/*
> 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
> 		 * we need to skip it when CMA area isn't allowed.
> 		 */
> 		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> 				migratetype != MIGRATE_MOVABLE) {
> 			page = rmqueue_pcplist(preferred_zone, zone, order,
> 					migratetype, alloc_flags);
> 			if (likely(page))
> 				goto out;
> 		}
> 	}
> 
> Surely that last condition should be migratetype == MIGRATE_MOVABLE?
> 

It should be. It would have been missed for ages because it would need a
test case based on a machine configuration that requires CMA for functional
correctness and is using THP which is an unlikely combination.

> > The huge zero page strips GFP_MOVABLE (so unmovable)
> > but at allocation time, it doesn't really matter what the movable type
> > is because it's a full pageblock. It doesn't appear to be a hazard until
> > the split happens. Assuming that's the case, it should be ok to always
> > set the pageblock movable for THP allocations regardless of GFP flags at
> > allocation time or else set the pageblock MOVABLE at THP split (always
> > MOVABLE at allocation time makes more sense).
> 
> The regular allocator compaction skips over compound pages anyway, so
> the migratetype should indeed not matter there.
> 
> The bigger issue is CMA. alloc_contig_range() will try to move THPs to
> free a larger range. We have to be careful not to place an unmovable
> zero THP into a CMA region. That means we can not play games with MT -
> we really do have to physically keep unmovable and movable THPs apart.
> 

Fair point.

> Another option would be not to use pcp for the zero THP. It's cached
> anyway in the caller. But it would add branches to the THP alloc and
> free fast paths (pcp_allowed_order() also checking migratetype).

And this is probably the most straight-forward option. The intent behind
caching some THPs on PCP was faulting large mappings of normal THPs and
reducing the contention on the zone lock a little. The zero THP is somewhat
special because it should not be allocated at high frequency.

-- 
Mel Gorman
SUSE Labs
