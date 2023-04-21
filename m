Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41976EAED4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjDUQMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDUQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:12:30 -0400
Received: from outbound-smtp47.blacknight.com (outbound-smtp47.blacknight.com [46.22.136.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E215602
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:12:01 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 75CEEFACFB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:11:59 +0100 (IST)
Received: (qmail 6945 invoked from network); 21 Apr 2023 16:11:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 16:11:59 -0000
Date:   Fri, 21 Apr 2023 17:11:56 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
Message-ID: <20230421161156.5jnipnfs4svwwzee@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <ZD9qATZcdyW/UGgI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZD9qATZcdyW/UGgI@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 05:11:45AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 18, 2023 at 03:12:47PM -0400, Johannes Weiner wrote:
> > This series proposes to make THP allocations reliable by enforcing
> > pageblock hygiene, and aligning the allocator, reclaim and compaction
> > on the pageblock as the base unit for managing free memory. All orders
> > up to and including the pageblock are made first-class requests that
> > (outside of OOM situations) are expected to succeed without
> > exceptional investment by the allocating thread.
> > 
> > A neutral pageblock type is introduced, MIGRATE_FREE. The first
> > allocation to be placed into such a block claims it exclusively for
> > the allocation's migratetype. Fallbacks from a different type are no
> > longer allowed, and the block is "kept open" for more allocations of
> > the same type to ensure tight grouping. A pageblock becomes neutral
> > again only once all its pages have been freed.
> 
> YES!  This is exactly what I've been thinking is the right solution
> for some time.  Thank you for doing it.
> 

It was considered once upon a time and comes up every so often as variants
of a "sticky" pageblock pageblock bit that prevents mixing. The risks was
ending up in a context where memory within a suitable pageblock cannot
be freed and all of the available MOVABLE pageblocks have at least one
pinned page that cannot migrate from the allocating context. It can also
potentially hit a case where the majority of memory is UNMOVABLE pageblocks,
each of which has a single pagetable page that cannot be freed without an
OOM kill. Variants of issues like this would manifestas an OOM kill with
plenty of memory free bug or excessive CPu usage on reclaim or compaction.

It doesn't kill the idea of the series at all but it puts a lot of emphasis
in splitting the series by low-risk and high-risk. Maybe to the extent where
the absolute protection against mixing can be broken in OOM situations,
kernel command line or sysctl.

-- 
Mel Gorman
SUSE Labs
