Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561916426AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLEK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiLEK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:28:13 -0500
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D93193D7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:27:29 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id AC8DD208A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:27:27 +0000 (GMT)
Received: (qmail 11155 invoked from network); 5 Dec 2022 10:27:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Dec 2022 10:27:27 -0000
Date:   Mon, 5 Dec 2022 10:27:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Explicitly record high-order atomic
 allocations in alloc_flags
Message-ID: <20221205102721.zitekvbhvylogtnv@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-4-mgorman@techsingularity.net>
 <167021743246.8267.14900064704332224542@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <167021743246.8267.14900064704332224542@noble.neil.brown.name>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:17:12PM +1100, NeilBrown wrote:
> 
> Hi Mel,
>  thanks a lot for doing this!

My pleasure.

>  I tried reviewing it but "HIGHATOMIC" is new to me and I quickly got
>  lost :-(

That's ok, HIGHATOMIC reserves are obscure and internal to the
allocator. It's almost as obscure as granting access to reserves for RT
tasks with the only difference being a lack of data on what sort of RT
tasks needed extra privileges back in the early 2000's but I happened to
remember why highatomic reserves were introduced. It was introduced when
fragmentation avoidance triggered  high-order atomic allocations failures
that "happened to work" by accident before fragmentation avoidance (details
in 0aaa29a56e4f). IIRC, there were a storm of bugs, mostly on small embedded
platforms where devices without an IOMMU relied on high-order atomics
to work so a small reserve was created. I was concerned your patch would
trigger this class of bug again even though it might take a few years to
show up as embedded platforms tend to stay on old kernels for ages.

The main point of this patch is identifying these high-order atomic
allocations without relying on __GFP_ATOMIC but it should not be necessary
to understand how high-order atomic reserves work. They still work the
same way, access is just granted differently.

>  Maybe one day I'll work it out - now that several names are more
>  meaningful, it will likely be easier.
> 
> > @@ -4818,7 +4820,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
> >  }
> >  
> >  static inline unsigned int
> > -gfp_to_alloc_flags(gfp_t gfp_mask)
> > +gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> >  {
> >  	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
> >  
> > @@ -4844,8 +4846,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
> >  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
> >  		 * if it can't schedule.
> >  		 */
> > -		if (!(gfp_mask & __GFP_NOMEMALLOC))
> > +		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
> >  			alloc_flags |= ALLOC_HARDER;
> > +
> > +			if (order > 0)
> > +				alloc_flags |= ALLOC_HIGHATOMIC;
> > +		}
> > +
> >  		/*
> >  		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
> >  		 * comment for __cpuset_node_allowed().

This is the most crucial hunk two hunks of the patch. If the series is
merged and we start seeing high-order atomic allocations failure, the key
will be to look at the gfp_flags and determine if this hunk is enough to
accurately detect high-order atomic allocations. If the GFP flags look ok,
then a tracing debugging patch will be created to dump gfp_flags every
time access is granted to high-atomic reserves to determine if access is
given incorrectly and under what circumstances.

The main concern I had with your original patch was that it was too
easy to grant access to high-atomic reserves for requests that were not
high-order atomics requests which might exhaust the reserves. The rest of
the series tries to improve the naming of the ALLOC flags and what they
mean. The actual changes to your patch are minimal.  I could have started
with your patch and fixed it up but I preferred this ordering to reduce
use of __GFP_ATOMIC and then delete it. It should be bisection safe.

-- 
Mel Gorman
SUSE Labs
