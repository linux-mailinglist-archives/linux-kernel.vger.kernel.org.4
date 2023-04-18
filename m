Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1F6E6CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjDRTNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjDRTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD31027A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id ey8so6188878qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845199; x=1684437199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Usz/xiP5MFOErrmpHxnXXyokW+dKSsFZ1ptTutbQBYM=;
        b=UQQjLJfaX+fK+rNEKZYpcoalaa6BcpaQd7XSk3yVlJdzQifudU8wYVhJkr0KHSlqlm
         CVjF5R9efwS+3nEeB6Ni1BRUU38tFAfRDDGjti0Db9BsdVFTEw9LSmzxIXJwmVT5vXo8
         3rakK0SrDhwz4JG4eSgIIFzeO2zFOZPaK5yH8dHEocRlaSTdJ1bGQAMFmpvx2P/dYtc5
         834O3TgSjYznyoUB4Srq8S5wea54YW+87JBlQN99BEzhWl5PkERe7elg4INu0wjUtFxq
         98dIaPsqAkKearKbMYjwF0aufNPtXSmgB7vxKX8PKaYDChvYY2etjYVhnL0obkcOT9U9
         oINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845199; x=1684437199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usz/xiP5MFOErrmpHxnXXyokW+dKSsFZ1ptTutbQBYM=;
        b=h3BVQO6nBRZewzDutdAAl/1lTmc+w8iy9tDiO7DpmVhM7kPxscYoRBCuNGD99kQoQ0
         zfCK1I5EM4kYPKNcRH0e91OfvYQP6+LnlGDw3TWrM5os/IpgW9f03kjmxbf8TcF3gieW
         hjHdjBi/r8RTs2/l/QzvqUi4DCbKM05eGOHXA0EDgIA0JODOIIQ/a6lysTRRPiiN7NRf
         H3n7qkVcg6iPKImA4ErWEKF4h1w76A2vTQUr0jVn+DtC1Y4sl9yxyJpG3Yz61pftX6qy
         qbbIBFXMdA44+5fZZd20NdgRscYrD7I4Lm9Ycc6cctovauoFKu6jF5ZqWVzycmRRDUdk
         s32w==
X-Gm-Message-State: AAQBX9cTgUp9nEGWvbV7j1vqygMYVmAwZZ7/dHpFH8yCCg0oyEPlvnQq
        /BUDj+ZXUcq9DgEuRk9CS/kKQA==
X-Google-Smtp-Source: AKy350al78vIGl48VYrYZs/mqDBW8sq33eDashDNBKoHcuMKerGI97ng7Uqfr9+WcXCnumT8D/cw5g==
X-Received: by 2002:ac8:4e46:0:b0:3e8:38fc:e8cf with SMTP id e6-20020ac84e46000000b003e838fce8cfmr1620141qtw.22.1681845199276;
        Tue, 18 Apr 2023 12:13:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id a24-20020a05620a067800b0074d930f4076sm2281678qkh.135.2023.04.18.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 00/26] mm: reliable huge page allocator
Date:   Tue, 18 Apr 2023 15:12:47 -0400
Message-Id: <20230418191313.268131-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As memory capacity continues to grow, 4k TLB coverage has not been
able to keep up. On Meta's 64G webservers, close to 20% of execution
cycles are observed to be handling TLB misses when using 4k pages
only. Huge pages are shifting from being a nice-to-have optimization
for HPC workloads to becoming a necessity for common applications.

However, while trying to deploy THP more universally, we observe a
fragmentation problem in the page allocator that often prevents larger
requests from being met quickly, or met at all, at runtime. Since we
have to provision hardware capacity for worst case performance,
unreliable huge page coverage isn't of much help.

Drilling into the allocator, we find that existing defrag efforts,
such as mobility grouping and watermark boosting, help, but are
insufficient by themselves. We still observe a high number of blocks
being routinely shared by allocations of different migratetypes. This
in turn results in inefficient or ineffective reclaim/compaction runs.

In a broad sample of Meta servers, we find that unmovable allocations
make up less than 7% of total memory on average, yet occupy 34% of the
2M blocks in the system. We also found that this effect isn't
correlated with high uptimes, and that servers can get heavily
fragmented within the first hour of running a workload.

The following experiment shows that only 20min of build load under
moderate memory pressure already results in a significant number of
typemixed blocks (block analysis run after system is back to idle):

vanilla:
unmovable 50
movable 701
reclaimable 149
unmovable blocks with slab/lru pages: 13 ({'slab': 17, 'lru': 19} pages)
movable blocks with non-LRU pages: 77 ({'slab': 4257, 'kmem': 77, 'other': 2} pages)
reclaimable blocks with non-slab pages: 16 ({'lru': 37, 'kmem': 311, 'other': 26} pages)

patched:
unmovable 65
movable 457
reclaimable 159
free 219
unmovable blocks with slab/lru pages: 22 ({'slab': 0, 'lru': 38} pages)
movable blocks with non-LRU pages: 0 ({'slab': 0, 'kmem': 0, 'other': 0} pages)
reclaimable blocks with non-slab pages: 3 ({'lru': 36, 'kmem': 0, 'other': 23} pages)

[ The remaining "mixed blocks" in the patched kernel are false
  positives: LRU pages without migrate callbacks (empty_aops), and
  i915 shmem that is pinned until reclaimed through shrinkers. ]

Root causes

One of the behaviors that sabotage the page allocator's mobility
grouping is the fact that requests of one migratetype are allowed to
fall back into blocks of another type before reclaim and compaction
occur. This is a design decision to prioritize memory utilization over
block fragmentation - especially considering the history of lumpy
reclaim and its tendency to overreclaim. However, with compaction
available, these two goals are no longer in conflict: the scratch
space of free pages for compaction to work is only twice the size of
the allocation request; in most cases, only small amounts of
proactive, coordinated reclaim and compaction is required to prevent a
fallback which may fragment a pageblock indefinitely.

Another problem lies in how the page allocator drives reclaim and
compaction when it does invoke it. While the page allocator targets
migratetype grouping at the pageblock level, it calls reclaim and
compaction with the order of the allocation request. As most requests
are smaller than a pageblock, this results in partial block freeing
and subsequent fallbacks and type mixing.

Note that in combination, these two design decisions have a
self-reinforcing effect on fragmentation: 1. Partially used unmovable
blocks are filled up with fallback movable pages. 2. A subsequent
unmovable allocation, instead of grouping up, will then need to enter
reclaim, which most likely results in a partially freed movable block
that it falls back into. Over time, unmovable allocations are sparsely
scattered throughout the address space and poison many pageblocks.

Note that block fragmentation is driven by lower-order requests. It is
not reliably mitigated by the mere presence of higher-order requests.

Proposal

This series proposes to make THP allocations reliable by enforcing
pageblock hygiene, and aligning the allocator, reclaim and compaction
on the pageblock as the base unit for managing free memory. All orders
up to and including the pageblock are made first-class requests that
(outside of OOM situations) are expected to succeed without
exceptional investment by the allocating thread.

A neutral pageblock type is introduced, MIGRATE_FREE. The first
allocation to be placed into such a block claims it exclusively for
the allocation's migratetype. Fallbacks from a different type are no
longer allowed, and the block is "kept open" for more allocations of
the same type to ensure tight grouping. A pageblock becomes neutral
again only once all its pages have been freed.

Reclaim and compaction are changed from partial block reclaim to
producing whole neutral page blocks. The watermark logic is adjusted
to apply to neutral blocks, ensuring that background and direct
reclaim always maintain a readily-available reserve of them.

The defragmentation effort changes from reactive to proactive. In
turn, this makes defragmentation actually more efficient: compaction
only has to scan movable blocks and can skip other blocks entirely;
since movable blocks aren't poisoned by unmovable pages, the chances
of successful compaction in each block are greatly improved as well.

Defragmentation becomes an ongoing responsibility of all allocations,
rather than being the burden of only higher-order asks. This prevents
sub-block allocations - which cause block fragmentation in the first
place - from starving the increasingly important larger requests.

There is a slight increase in worst-case memory overhead by requiring
the watermarks to be met against neutral blocks even when there might
be free pages in typed blocks. However, the high watermarks are less
than 1% of the zone, so the increase is relatively small.

These changes only apply to CONFIG_COMPACTION kernels. Without
compaction, fallbacks and partial block reclaim remain the best
trade-off between memory utilization and fragmentation.

Initial Test Results

The following is purely an allocation reliability test. Achieving full
THP benefits in practice is tied to other pending changes, such as the
THP shrinker to avoid memory pressure from excessive internal
fragmentation, and tweaks to the kernel's THP allocation strategy.

The test is a kernel build under moderate-to-high memory pressure,
with a concurrent process trying to repeatedly fault THPs (madvise):

                                              HUGEALLOC-VANILLA       HUGEALLOC-PATCHED
Real time                                   265.04 (    +0.00%)     268.12 (    +1.16%)
User time                                  1131.05 (    +0.00%)    1131.13 (    +0.01%)
System time                                 474.66 (    +0.00%)     478.97 (    +0.91%)
THP fault alloc                           17913.24 (    +0.00%)   19647.50 (    +9.68%)
THP fault fallback                         1947.12 (    +0.00%)     223.40 (   -88.48%)
THP fault fail rate %                         9.80 (    +0.00%)       1.12 (   -80.34%)
Direct compact stall                        282.44 (    +0.00%)     543.90 (   +92.25%)
Direct compact fail                         262.44 (    +0.00%)     239.90 (    -8.56%)
Direct compact success                       20.00 (    +0.00%)     304.00 ( +1352.38%)
Direct compact success rate %                 7.15 (    +0.00%)      57.10 (  +612.90%)
Compact daemon scanned migrate            21643.80 (    +0.00%)  387479.80 ( +1690.18%)
Compact daemon scanned free              188462.36 (    +0.00%) 2842824.10 ( +1408.42%)
Compact direct scanned migrate          1601294.84 (    +0.00%)  275670.70 (   -82.78%)
Compact direct scanned free             4476155.60 (    +0.00%) 2438835.00 (   -45.51%)
Compact migrate scanned daemon %              1.32 (    +0.00%)      59.18 ( +2499.00%)
Compact free scanned daemon %                 3.95 (    +0.00%)      54.31 ( +1018.20%)
Alloc stall                                2425.00 (    +0.00%)     992.00 (   -59.07%)
Pages kswapd scanned                     586756.68 (    +0.00%)  975390.20 (   +66.23%)
Pages kswapd reclaimed                   385468.20 (    +0.00%)  437767.50 (   +13.57%)
Pages direct scanned                     335199.56 (    +0.00%)  501824.20 (   +49.71%)
Pages direct reclaimed                   127953.72 (    +0.00%)  151880.70 (   +18.70%)
Pages scanned kswapd %                       64.43 (    +0.00%)      66.39 (    +2.99%)
Swap out                                  14083.88 (    +0.00%)   45034.60 (  +219.74%)
Swap in                                    3395.08 (    +0.00%)    7767.50 (  +128.75%)
File refaults                             93546.68 (    +0.00%)  129648.30 (   +38.59%)

The THP fault success rate is drastically improved. A bigger share of
the work is done by the background threads, as they now proactively
maintain MIGRATE_FREE block reserves. The increase in memory pressure
is shown by the uptick in swap activity.

Status

Initial test results look promising, but production testing has been
lagging behind the effort to generalize this code for upstream, and
putting all the pieces together to make THP work. I'll follow up as I
gather more data.

Sending this out now as an RFC to get input on the overall direction.

The patches are based on v6.2.

 Documentation/admin-guide/sysctl/vm.rst |  21 -
 block/bdev.c                            |   2 +-
 include/linux/compaction.h              | 100 +---
 include/linux/gfp.h                     |   2 -
 include/linux/mm.h                      |   1 -
 include/linux/mmzone.h                  |  30 +-
 include/linux/page-isolation.h          |  28 +-
 include/linux/pageblock-flags.h         |   4 +-
 include/linux/vmstat.h                  |   8 -
 include/trace/events/mmflags.h          |   4 +-
 kernel/sysctl.c                         |   8 -
 mm/compaction.c                         | 242 +++-----
 mm/internal.h                           |  14 +-
 mm/memory_hotplug.c                     |   4 +-
 mm/page_alloc.c                         | 930 +++++++++++++-----------------
 mm/page_isolation.c                     |  42 +-
 mm/vmscan.c                             | 251 ++------
 mm/vmstat.c                             |   6 +-
 18 files changed, 629 insertions(+), 1068 deletions(-)


