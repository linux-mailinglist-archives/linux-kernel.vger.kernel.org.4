Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE16F15E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjD1Kl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjD1Kl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:41:56 -0400
Received: from outbound-smtp36.blacknight.com (outbound-smtp36.blacknight.com [46.22.139.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C3CD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:41:54 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 1E9B923E1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:41:53 +0100 (IST)
Received: (qmail 32649 invoked from network); 28 Apr 2023 10:41:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Apr 2023 10:41:52 -0000
Date:   Fri, 28 Apr 2023 11:41:51 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 10/26] mm: page_alloc: allow compaction capturing
 from larger blocks
Message-ID: <20230428104151.tau2mru65rdsisyg@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-11-hannes@cmpxchg.org>
 <20230421141447.2cw5cfwibb7jxf6n@techsingularity.net>
 <20230425154026.GC17132@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230425154026.GC17132@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 11:40:26AM -0400, Johannes Weiner wrote:
> On Fri, Apr 21, 2023 at 03:14:47PM +0100, Mel Gorman wrote:
> > On Tue, Apr 18, 2023 at 03:12:57PM -0400, Johannes Weiner wrote:
> > > Currently, capturing only works on matching orders and matching
> > > migratetypes. However, if capturing is initially skipped on the
> > > migratetype, it's possible that merging continues up to a full
> > > pageblock, in which case the migratetype is up for grabs again.
> > > 
> > > Allow capturing to grab smaller chunks from claimed pageblocks, and
> > > expand the remainder of the block back onto the freelists.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > No objections other than we're still in the preparation phase and the
> > series needs to be split. Out of curiousity, how often does this actually
> > trigger in practice? I ask because superficially, I would expect capture to
> > happen while pages are being merged and I'm not sure how much this actually
> > helps. If anything the anomaly would be merging !MOVABLE types, capturing
> > one pageblock and leaving the adjacent block eligible for splitting as
> > UNMOVABLE/RECLAIMABLE which is not necessarily desirable.
> 
> Looking at this patch independently, once merging continues to the
> full block, a fallback would be allowed to claim it anyway
> (can_steal_fallback() returns true). I don't quite see a downside
> letting capture apply in this case. The plus is of course avoiding the
> indirection through the freelist which risks an opportunist request of
> a smaller order fragmenting the block and wasting the contiguity work.
> 
> In the context of the full series, this becomes even more
> important. Once watermarks are required to be met in MIGRATE_FREE
> blocks, and reclaim/compaction recycle full blocks, merging up to
> pageblock_order happens all the time - and needs to happen for
> allocations to succeed. This applies to all types of direct reclaim:
> unmovable request freeing reclaimable/movable blocks, reclaimable
> freeing movable blocks, movable freeing reclaimable blocks.
> 
> I see your point about smaller orders now always ending the merge at
> the pageblock, even when there could be additional merging
> opportunities beyond. However, I'm not sure these accidental larger
> merges beyond what's needed to fulfill the request at hand are a
> preferable aspect over reclaimer fairness, and thus ultimately the
> reliability of orders up to the pageblock size.
> 
> I'll try to get some numbers for this patch independently, though.
> This should manifest in p99 allocation latencies and near-OOM
> behavior. Is there anything else you'd want me to look for?
> 

Any major change in the number of the mm_page_alloc_extfrag trace event
triggering. Also put the patch at the end of the preparation series of
possible or even do it as a separate follow-up patch after the bulk of
the series has been handled. While I cannot 100% convince myself either
way, I wonder if variable high-order allocation requests smaller than a
pageblock could cause premature mixing due to capture.

-- 
Mel Gorman
SUSE Labs
