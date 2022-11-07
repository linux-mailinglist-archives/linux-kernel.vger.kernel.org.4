Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78861F1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiKGLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKGLQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:16:54 -0500
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B0BC9C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:16:52 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 0D8A7CAB8F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:16:51 +0000 (GMT)
Received: (qmail 22850 invoked from network); 7 Nov 2022 11:16:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Nov 2022 11:16:50 -0000
Date:   Mon, 7 Nov 2022 11:16:49 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Message-ID: <20221107111649.rzfgqk3ebvicsuyw@techsingularity.net>
References: <20221104142259.5hohev5hzvwanbi2@techsingularity.net>
 <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <97b7ae87-797c-4ebb-d2d3-9415975188@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 08:42:32AM -0800, Hugh Dickins wrote:
> On Fri, 4 Nov 2022, Mel Gorman wrote:
> 
> > Changelog since v1
> >  o Use trylock in free_unref_page_list due to IO completion from softirq
> >    context
> > 
> > The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> > allocating from the PCP must not re-enter the allocator from IRQ context.
> > In each instance where IRQ-reentrancy is possible, the lock is acquired using
> > pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
> > is impossible.
> > 
> > Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> > case at the cost of some IRQ allocations taking a slower path. If the PCP
> > lists need to be refilled, the zone lock still needs to disable IRQs but
> > that will only happen on PCP refill and drain. If an IRQ is raised when
> > a PCP allocation is in progress, the trylock will fail and fallback to
> > using the buddy lists directly. Note that this may not be a universal win
> > if an interrupt-intensive workload also allocates heavily from interrupt
> > context and contends heavily on the zone->lock as a result.
> > 
> > [yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Hi Mel, I think you Cc'ed me for the purpose of giving this patch a
> run, and reporting if it's not good.  That is the case, I'm afraid.
> 

Thanks for testing and yes, you were cc'd in the hope you'd run it through a
stress test of some sort. A lot of the test I run are performance orientated
and relatively few target functional issues.

> I first tried it on a v6.1-rc3, and very soon crashed under load with
> something about PageBuddy in the output.  When I reverted, no problem;
> I thought maybe it's dependent on other commits in akpm's tree.
> 

Can you tell me what sort of load it's under? I would like to add something
similar to the general battery of tests I run all patches affecting the
page allocator through. Even if this is just a crude shell script, it would
be enough for me to work with and incorporate into mmtests. If it's there
and I find mm-unstable has its own problems, bisection can brute force
the problem.

> Later I tried on current mm-unstable: which is living up to the name
> in other ways, but when other issues patched, it soon crashed under
> load, GPF probably for non-canonical address 0xdead0000000000f8
> in compact_zone < compact_zone_order < try_to_compact_pages <
> .... < shmem_alloc_hugefolio < ...
> 

0xdead000* looks like ILLEGAL_POINTER_VALUE which is used as a poison
value so a full list of debugging options you apply for the stress test
would also be useful.

> I do try to exercise compaction as hard as I can, even to the point
> of having a hack in what used to be called shmem_getpage_gfp(),
> reverting to the stronger attempt to get huge pages, before Rik
> weakened the effect of huge=always with vma_thp_gfp_mask() in 5.12:
> so shmem is probably applying stronger flags for compaction than it
> would in your tree - I'm using
> GFP_TRANSHUGE_LIGHT | __GFP_RECLAIM | __GFP_NORETRY there.
> 
> Sorry for not giving you more info, I'm rather hoping that compaction
> is relevant, and will give you a clue (maybe that capture code, which
> surprised us once before??). 

While capture is a possibility, it's a bad fit for this patch because
pages are captured under task context.

> What I'm really trying to do is fix
> the bug in Linus's rmap/TLB series, and its interaction with my
> rmap series, and report back on his series (asking for temporary
> drop), before next-20221107 goes down in flames.
> 
> I'd advocate for dropping this patch of yours too; but if it's giving
> nobody else any trouble, I can easily continue to patch it out.
> 

Given that you tested the patch against v6.1-rc3, it's clear that the
patch on its own causes problems. Having a reproduction case will help
me figure out why.

-- 
Mel Gorman
SUSE Labs
