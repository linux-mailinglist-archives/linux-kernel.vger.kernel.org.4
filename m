Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109E67B25C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjAYMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjAYMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:09:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AE35BF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF132B81991
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AEBC433EF;
        Wed, 25 Jan 2023 12:09:01 +0000 (UTC)
Date:   Wed, 25 Jan 2023 12:08:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y9Eb2k3COoUXJ0CB@arm.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
 <Y8gpfgEXtialPVLk@arm.com>
 <Y8neaPB2y689WKOf@google.com>
 <Y8/96eIu47UfqsWO@arm.com>
 <Y9BLfUz5GY69zmjn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9BLfUz5GY69zmjn@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:19:57PM -0800, Isaac Manjarres wrote:
> On Tue, Jan 24, 2023 at 03:48:57PM +0000, Catalin Marinas wrote:
> > Thanks for digging this out. This patch shouldn't have ended up upstream
> > (commit 972fa3a7c17c "mm: kmemleak: alloc gray object for reserved
> > region with direct map"). I thought both Calvin Zhang and I agreed that
> > it's not the correct approach (not even sure there was a real problem to
> > fix).
> > 
> > Do you still get the any faults with the above commit reverted? I'd
> > prefer this if it works rather than adding unnecessary
> > kmemleak_alloc/free callbacks that pretty much cancel each-other.
> 
> Yes, I still see the same problem after reverting that commit. The problem
> still persists because there are CMA areas that are allocated through
> memblock_phys_alloc_range(), which invokes kmemleak_alloc_phys(). The
> allocation call stack is along the lines of:
> 
> kmemleak_alloc_phys()
> memblock_alloc_range_nid()
> memblock_phys_alloc_range()
> __reserved_mem_alloc_size()
> fdt_init_reserved_mem()

Ah, that's another place that kmemleak shouldn't care about.

> I also followed up on my suggestion about adding a flags parameter to
> the memblock allocation functions to be able to use
> MEMBLOCK_ALLOC_NOLEAKTRACE in this particular scenario, but that would
> involve changing many call-sites, which doesn't make much sense given
> that there are only 4 call-sites that actually use this flag.

Yeah, the current way of passing MEMBLOCK_ALLOC_NOLEAKTRACE is not
ideal. We did it more like a quick hack. See some past discussion here
(and adding Mike to this thread):

https://lore.kernel.org/all/YYUChdTeXP%2FOQUwS@arm.com/

> Maybe adding a new memblock allocation function that allows this flag to
> be passed as just a flag can be used to avoid creating these kmemleak
> objects for CMA allocations?

That's an option. If there's too much churn to add a flag, an
alternative is to use the bottom bit of 'end' to set the noleaktrace
flag.

Yet another idea is to avoid the kmemleak callback on all the 'phys'
memblock allocations. We can add the callback to the higher level
memblock_alloc() which returns a VA but the lower level 'phys' variants
could simply avoid it. However, I think we still need the
MEMBLOCK_ALLOC_NOLEAKTRACE flag for the kasan shadow allocation. Well,
given that this flag is not widely used, we can add explicit
kmemleak_ignore() calls in those four places.

I think the latter, if it works, would be the least intrusive.

-- 
Catalin
