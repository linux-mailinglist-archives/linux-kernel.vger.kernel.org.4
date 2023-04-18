Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81DD6E7015
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjDRXyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:54:11 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02247AB2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:54:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3AD043200034;
        Tue, 18 Apr 2023 19:54:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 18 Apr 2023 19:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681862046; x=
        1681948446; bh=x7Yw56H9I8FXClkan42HMI+xw7zB/tWi9eShiHtXA2E=; b=u
        S8ySV+10PxoNA4YwISBLGEnsRbwZ5vXCuv5Nz909L5LnUbIHuZxtdKEQs/CNGSKA
        h5iz1QgaghEcEdPlbm2tdbjkB8pKI5mC29TfYPjxCJD4sSgGdZUiMrJfgG0tQnGV
        C07UKXzGTPpFGD3CzNOLFS5j84USG7XTJB3WNMENY/f2PfMjGjWKRY2HQ1GAC+fy
        BSthNaSXGmAR8Tvf2s08gUNjIs2EAoQThaFbKS61bAIhDl4CMpdaYREGt4OoZGiw
        bAUuGqVQjW2S9PPQfdnkNk0C1Sqmxamgk/Q9CAqZi4fji3hgT+SBeEzo5gADltx4
        DWaZXREVXAXWzDoeCMSgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681862046; x=1681948446; bh=x7Yw56H9I8FXC
        lkan42HMI+xw7zB/tWi9eShiHtXA2E=; b=kAbLzaOShmIHGZtw2FE/3UrXWn4Yk
        D26ADGnzYjNeiu/260IhLyDHO33bkN3R5mQtb0rX/mo3YAhS5cMQzHxP2hdJbsqR
        mgL/1YZi1y6V/T5CDh3YLrLVVATzP2UK/7eAQwwiU8rX5jS+q0wHasYyrNu4481D
        oyC/lsWeGPl5W2cjI8unhZBLQ3+RvHdhH5R1QgR5ej654pvQXAQeElx79QRecPTi
        jAo65i+Xa3xWmZzEX0aRJ8UqIrj9V9DhUoXLoSV/lJJxtkQbDZkSATu1Yzz60kpA
        V5xeaHAF4rg6HeHK3iuMLJ1kXaSqHwAj19z46giV9MfaLick8TNMMfaRw==
X-ME-Sender: <xms:ni0_ZKvZeuEe0h4qmBrgOq5s0ERT9yxcbXE6dYC6ipMxDYf6D7jNZQ>
    <xme:ni0_ZPdreJzhWJYXy-DlBIR_QEX8atpeaMKpqq8tUPu-CTmnLG5zFFwJjHPwQhhpA
    aySr3pmdk4ET9uraSk>
X-ME-Received: <xmr:ni0_ZFw6WoF5Xj98YB8hlFqxdmddVklxjMfjLbE27Ygm_0iIfaTNlK9cqvSH-btHO6KTUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekheegiefhhfduvdejieffudejgeeigfeigfel
    udffueeggeffffeivdeutedvleenucffohhmrghinhepshhusghsthgrnhhtihgrlhhlhi
    drhhhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:ni0_ZFPtjP2JOjDmjPN0rWLgWpJ6usxS_bDrcumv716siDhJrc8sew>
    <xmx:ni0_ZK9iAZH9wZsM354h3v1yDBG7GAXAsZ416gFd_Y5l96HdWYjG_Q>
    <xmx:ni0_ZNXaejiskIMoAESb6Y38iV08n-Pk5klMBJbM5RAxoJ7Snz-xCA>
    <xmx:ni0_ZKz_zaJvEYN5JP_4tj5vuNx-XW7ZgCSbARVmb7fQCJI7ixjLgg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Apr 2023 19:54:05 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 82F6910C351; Wed, 19 Apr 2023 02:54:02 +0300 (+03)
Date:   Wed, 19 Apr 2023 02:54:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
Message-ID: <20230418235402.lq7mxrrre2kl6vsf@box.shutemov.name>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:47PM -0400, Johannes Weiner wrote:
> As memory capacity continues to grow, 4k TLB coverage has not been
> able to keep up. On Meta's 64G webservers, close to 20% of execution
> cycles are observed to be handling TLB misses when using 4k pages
> only. Huge pages are shifting from being a nice-to-have optimization
> for HPC workloads to becoming a necessity for common applications.
> 
> However, while trying to deploy THP more universally, we observe a
> fragmentation problem in the page allocator that often prevents larger
> requests from being met quickly, or met at all, at runtime. Since we
> have to provision hardware capacity for worst case performance,
> unreliable huge page coverage isn't of much help.
> 
> Drilling into the allocator, we find that existing defrag efforts,
> such as mobility grouping and watermark boosting, help, but are
> insufficient by themselves. We still observe a high number of blocks
> being routinely shared by allocations of different migratetypes. This
> in turn results in inefficient or ineffective reclaim/compaction runs.
> 
> In a broad sample of Meta servers, we find that unmovable allocations
> make up less than 7% of total memory on average, yet occupy 34% of the
> 2M blocks in the system. We also found that this effect isn't
> correlated with high uptimes, and that servers can get heavily
> fragmented within the first hour of running a workload.
> 
> The following experiment shows that only 20min of build load under
> moderate memory pressure already results in a significant number of
> typemixed blocks (block analysis run after system is back to idle):
> 
> vanilla:
> unmovable 50
> movable 701
> reclaimable 149
> unmovable blocks with slab/lru pages: 13 ({'slab': 17, 'lru': 19} pages)
> movable blocks with non-LRU pages: 77 ({'slab': 4257, 'kmem': 77, 'other': 2} pages)
> reclaimable blocks with non-slab pages: 16 ({'lru': 37, 'kmem': 311, 'other': 26} pages)
> 
> patched:
> unmovable 65
> movable 457
> reclaimable 159
> free 219
> unmovable blocks with slab/lru pages: 22 ({'slab': 0, 'lru': 38} pages)
> movable blocks with non-LRU pages: 0 ({'slab': 0, 'kmem': 0, 'other': 0} pages)
> reclaimable blocks with non-slab pages: 3 ({'lru': 36, 'kmem': 0, 'other': 23} pages)
> 
> [ The remaining "mixed blocks" in the patched kernel are false
>   positives: LRU pages without migrate callbacks (empty_aops), and
>   i915 shmem that is pinned until reclaimed through shrinkers. ]
> 
> Root causes
> 
> One of the behaviors that sabotage the page allocator's mobility
> grouping is the fact that requests of one migratetype are allowed to
> fall back into blocks of another type before reclaim and compaction
> occur. This is a design decision to prioritize memory utilization over
> block fragmentation - especially considering the history of lumpy
> reclaim and its tendency to overreclaim. However, with compaction
> available, these two goals are no longer in conflict: the scratch
> space of free pages for compaction to work is only twice the size of
> the allocation request; in most cases, only small amounts of
> proactive, coordinated reclaim and compaction is required to prevent a
> fallback which may fragment a pageblock indefinitely.
> 
> Another problem lies in how the page allocator drives reclaim and
> compaction when it does invoke it. While the page allocator targets
> migratetype grouping at the pageblock level, it calls reclaim and
> compaction with the order of the allocation request. As most requests
> are smaller than a pageblock, this results in partial block freeing
> and subsequent fallbacks and type mixing.
> 
> Note that in combination, these two design decisions have a
> self-reinforcing effect on fragmentation: 1. Partially used unmovable
> blocks are filled up with fallback movable pages. 2. A subsequent
> unmovable allocation, instead of grouping up, will then need to enter
> reclaim, which most likely results in a partially freed movable block
> that it falls back into. Over time, unmovable allocations are sparsely
> scattered throughout the address space and poison many pageblocks.
> 
> Note that block fragmentation is driven by lower-order requests. It is
> not reliably mitigated by the mere presence of higher-order requests.
> 
> Proposal
> 
> This series proposes to make THP allocations reliable by enforcing
> pageblock hygiene, and aligning the allocator, reclaim and compaction
> on the pageblock as the base unit for managing free memory. All orders
> up to and including the pageblock are made first-class requests that
> (outside of OOM situations) are expected to succeed without
> exceptional investment by the allocating thread.
> 
> A neutral pageblock type is introduced, MIGRATE_FREE. The first
> allocation to be placed into such a block claims it exclusively for
> the allocation's migratetype. Fallbacks from a different type are no
> longer allowed, and the block is "kept open" for more allocations of
> the same type to ensure tight grouping. A pageblock becomes neutral
> again only once all its pages have been freed.

Sounds like this will cause earlier OOM, no?

I guess with 2M pageblock on 64G server it shouldn't matter much. But how
about smaller machines?

> Reclaim and compaction are changed from partial block reclaim to
> producing whole neutral page blocks.

How does it affect allocation latencies? I see direct compact stall grew
substantially. Hm?

> The watermark logic is adjusted
> to apply to neutral blocks, ensuring that background and direct
> reclaim always maintain a readily-available reserve of them.
> 
> The defragmentation effort changes from reactive to proactive. In
> turn, this makes defragmentation actually more efficient: compaction
> only has to scan movable blocks and can skip other blocks entirely;
> since movable blocks aren't poisoned by unmovable pages, the chances
> of successful compaction in each block are greatly improved as well.
> 
> Defragmentation becomes an ongoing responsibility of all allocations,
> rather than being the burden of only higher-order asks. This prevents
> sub-block allocations - which cause block fragmentation in the first
> place - from starving the increasingly important larger requests.
> 
> There is a slight increase in worst-case memory overhead by requiring
> the watermarks to be met against neutral blocks even when there might
> be free pages in typed blocks. However, the high watermarks are less
> than 1% of the zone, so the increase is relatively small.
> 
> These changes only apply to CONFIG_COMPACTION kernels. Without
> compaction, fallbacks and partial block reclaim remain the best
> trade-off between memory utilization and fragmentation.
> 
> Initial Test Results
> 
> The following is purely an allocation reliability test. Achieving full
> THP benefits in practice is tied to other pending changes, such as the
> THP shrinker to avoid memory pressure from excessive internal
> fragmentation, and tweaks to the kernel's THP allocation strategy.
> 
> The test is a kernel build under moderate-to-high memory pressure,
> with a concurrent process trying to repeatedly fault THPs (madvise):
> 
>                                               HUGEALLOC-VANILLA       HUGEALLOC-PATCHED
> Real time                                   265.04 (    +0.00%)     268.12 (    +1.16%)
> User time                                  1131.05 (    +0.00%)    1131.13 (    +0.01%)
> System time                                 474.66 (    +0.00%)     478.97 (    +0.91%)
> THP fault alloc                           17913.24 (    +0.00%)   19647.50 (    +9.68%)
> THP fault fallback                         1947.12 (    +0.00%)     223.40 (   -88.48%)
> THP fault fail rate %                         9.80 (    +0.00%)       1.12 (   -80.34%)
> Direct compact stall                        282.44 (    +0.00%)     543.90 (   +92.25%)
> Direct compact fail                         262.44 (    +0.00%)     239.90 (    -8.56%)
> Direct compact success                       20.00 (    +0.00%)     304.00 ( +1352.38%)
> Direct compact success rate %                 7.15 (    +0.00%)      57.10 (  +612.90%)
> Compact daemon scanned migrate            21643.80 (    +0.00%)  387479.80 ( +1690.18%)
> Compact daemon scanned free              188462.36 (    +0.00%) 2842824.10 ( +1408.42%)
> Compact direct scanned migrate          1601294.84 (    +0.00%)  275670.70 (   -82.78%)
> Compact direct scanned free             4476155.60 (    +0.00%) 2438835.00 (   -45.51%)
> Compact migrate scanned daemon %              1.32 (    +0.00%)      59.18 ( +2499.00%)
> Compact free scanned daemon %                 3.95 (    +0.00%)      54.31 ( +1018.20%)
> Alloc stall                                2425.00 (    +0.00%)     992.00 (   -59.07%)
> Pages kswapd scanned                     586756.68 (    +0.00%)  975390.20 (   +66.23%)
> Pages kswapd reclaimed                   385468.20 (    +0.00%)  437767.50 (   +13.57%)
> Pages direct scanned                     335199.56 (    +0.00%)  501824.20 (   +49.71%)
> Pages direct reclaimed                   127953.72 (    +0.00%)  151880.70 (   +18.70%)
> Pages scanned kswapd %                       64.43 (    +0.00%)      66.39 (    +2.99%)
> Swap out                                  14083.88 (    +0.00%)   45034.60 (  +219.74%)
> Swap in                                    3395.08 (    +0.00%)    7767.50 (  +128.75%)
> File refaults                             93546.68 (    +0.00%)  129648.30 (   +38.59%)
> 
> The THP fault success rate is drastically improved. A bigger share of
> the work is done by the background threads, as they now proactively
> maintain MIGRATE_FREE block reserves. The increase in memory pressure
> is shown by the uptick in swap activity.
> 
> Status
> 
> Initial test results look promising, but production testing has been
> lagging behind the effort to generalize this code for upstream, and
> putting all the pieces together to make THP work. I'll follow up as I
> gather more data.
> 
> Sending this out now as an RFC to get input on the overall direction.
> 
> The patches are based on v6.2.
> 
>  Documentation/admin-guide/sysctl/vm.rst |  21 -
>  block/bdev.c                            |   2 +-
>  include/linux/compaction.h              | 100 +---
>  include/linux/gfp.h                     |   2 -
>  include/linux/mm.h                      |   1 -
>  include/linux/mmzone.h                  |  30 +-
>  include/linux/page-isolation.h          |  28 +-
>  include/linux/pageblock-flags.h         |   4 +-
>  include/linux/vmstat.h                  |   8 -
>  include/trace/events/mmflags.h          |   4 +-
>  kernel/sysctl.c                         |   8 -
>  mm/compaction.c                         | 242 +++-----
>  mm/internal.h                           |  14 +-
>  mm/memory_hotplug.c                     |   4 +-
>  mm/page_alloc.c                         | 930 +++++++++++++-----------------
>  mm/page_isolation.c                     |  42 +-
>  mm/vmscan.c                             | 251 ++------
>  mm/vmstat.c                             |   6 +-
>  18 files changed, 629 insertions(+), 1068 deletions(-)
> 
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
