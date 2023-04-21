Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B666EB05E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjDURPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjDURPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:15:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C018F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtvmO0xGmo7IvM4Hiwzxf0iWjctxbr+KbWVfxmqqbpw=; b=XW4oII0OralIKyM9phqGrPcDcA
        8wYmtVd4VW+lvJPATf7K1MSjFcz09leqd4DPDTvsL47GEbXQ5wl6AWrRrfw98Tv4ltULf88th5JoQ
        7UnEkakK8cfuMk+E1pTHmDEPMLdS88PbXjJTDdnUB/mzPORk0ZpSVvDyktDC1opIOM+DQKSpmMO7c
        crni9qfeNnVe/iCP10Y4khF4ylh61qgKv5ELwJTy4D6g7glkRhAkrQniQCy7+3Y+SkCEMTWf5Mvil
        yDKZPgphuZbPOECyzvZE8W1pD7xwc3273QUKog9Xe0RMzBBxUSE3qCo3EcvyHJrdmocV3iMsFgdMA
        MI+8Cw6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppuLJ-00FRSI-EX; Fri, 21 Apr 2023 17:14:41 +0000
Date:   Fri, 21 Apr 2023 18:14:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
Message-ID: <ZELEgRG5DwmcMB/T@casper.infradead.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <ZD9qATZcdyW/UGgI@casper.infradead.org>
 <20230421161156.5jnipnfs4svwwzee@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421161156.5jnipnfs4svwwzee@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:11:56PM +0100, Mel Gorman wrote:
> It was considered once upon a time and comes up every so often as variants
> of a "sticky" pageblock pageblock bit that prevents mixing. The risks was
> ending up in a context where memory within a suitable pageblock cannot
> be freed and all of the available MOVABLE pageblocks have at least one
> pinned page that cannot migrate from the allocating context. It can also
> potentially hit a case where the majority of memory is UNMOVABLE pageblocks,
> each of which has a single pagetable page that cannot be freed without an
> OOM kill. Variants of issues like this would manifestas an OOM kill with
> plenty of memory free bug or excessive CPu usage on reclaim or compaction.
> 
> It doesn't kill the idea of the series at all but it puts a lot of emphasis
> in splitting the series by low-risk and high-risk. Maybe to the extent where
> the absolute protection against mixing can be broken in OOM situations,
> kernel command line or sysctl.

Has a variant been previously considered where MOVABLE allocations are
allowed to come from UNMOVABLE blocks?  After all, MOVABLE allocations
are generally, well, movable.  So an UNMOVABLE allocation could try to
migrate pages from a MIXED pageblock in order to turn the MIXED pageblock
back into an UNMOVABLE pageblock.

This might work better in practice because GFP_NOFS allocations tend
to also be MOVABLE, so allowing them to take up some of the UNMOVABLE
space temporarily feels like a get-out-of-OOM card.

(I've resisted talking about plans to make page table pages movable
because I don't think that's your point; that's just an example of a
currently-unmovable allocation, right?)

I mention this in part because on my laptop, ZONE_DMA is almost unused:

Node 0, zone      DMA      0      0      0      0      0      0      0      0      1      2      2
Node 0, zone    DMA32   1685   1345   1152    554    424    212    104     40      2      0      0
Node 0, zone   Normal   6959   3530   1893   1862    629    483    107     10      0      0      0

That's 2 order-10 (=8MB), 2 order-9 (=4MB) and 1 order8 (=1MB) for a
total of 13MB of memory.  That's insignificant to a 16GB laptop, but on
smaller machines, it might be worth allowing MOVABLE allocations to come
from ZONE_DMA on the grounds that they can be easily freed if anybody
ever allocated from ZONE_DMA.
