Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAF5B7BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIMT6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIMT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:57:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573272EF6;
        Tue, 13 Sep 2022 12:57:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h21so9615167qta.3;
        Tue, 13 Sep 2022 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/QqAVzo4fvEyn6D6UHpopTegAEfKSX+ABogkBcqAx/E=;
        b=nVJi7KBRKxtWgvxaesz2o24wWrg2ZKodAwUFy6lYQfmaIC8UuDCUN5nEpl0riwMAuz
         EppuZ9CncgB2eWcb9NU1S/03hFJme/FpnGEI4HG5F6GSgnH547+zVsiGy5YAaSUAn1LU
         1q+cuMIzxZeGDCcfaOowOs8Rn+rEdHSzKYBBbGPDpwxEHvNLayNaOHu7ruFOZAZrbYpT
         LC7ttQLf1WgmEobP7lQ8CEWDWQ/ucp72KpaGBSIZ6fdFj/LwcJxiKY1GVmfq01XRlYoD
         DHPliW4LirhpKBqjdI6qs3/he8KJ0eYf8Sg/VbiwVn8jFQ9DxWdkveCjfSzDVo07BfVt
         qwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/QqAVzo4fvEyn6D6UHpopTegAEfKSX+ABogkBcqAx/E=;
        b=D/hMM0mts5RRYi7r9RDASo8Lj2XU1/YkC5+UPzZU6IfSBt8mnorlm0fF4ljCYdONHF
         +lm9LlwiHTmmIrZ6d/+P79LAMmJKr/n3luVQwJk5KWu+lJ+rBuMjRDWbqGc1qK6IV/HQ
         qlV4aEpsOsMJpv5/+QCFGnV/7oik6Z3V9mPqc4W22+F6Nqaq/Xn31caMxj/TKhiM6naW
         8d9ANlFmOARyzpgrgZA59cCXmA0R0ZjzNUM2brSnodLyHXc4/NicTzdPJsw+54AnHfYo
         3Jz8DrN0ccnGZNh8d2eYLFxkSU8JZhMdqe5gy489n6auIesNps78jIFXn53ckVlC7UPu
         PH/g==
X-Gm-Message-State: ACgBeo2CcG/zvHdV8nhkDhpTggr5zjT7INmC0QLz7NZLsR5X8IRUKOUW
        qeJQCYnfqcPGVab9JBJowcI=
X-Google-Smtp-Source: AA6agR7Y3l92pxu+HRUPav/nUZyX/iwKCTZTxxxvSWBceRQPR0uBtmlP6bciotha6m8mHURY/t0RNg==
X-Received: by 2002:ac8:5853:0:b0:343:7b95:96ff with SMTP id h19-20020ac85853000000b003437b9596ffmr30514112qth.386.1663099074358;
        Tue, 13 Sep 2022 12:57:54 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:57:53 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 00/21] mm: introduce Designated Movable Blocks
Date:   Tue, 13 Sep 2022 12:54:47 -0700
Message-Id: <20220913195508.3511038-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOTIVATION:
Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
controllers with each mapped in a different address range within
a Uniform Memory Architecture. Some users of these systems have
expressed the desire to locate ZONE_MOVABLE memory on each
memory controller to allow user space intensive processing to
make better use of the additional memory bandwidth.
Unfortunately, the historical monotonic layout of zones would
mean that if the lowest addressed memory controller contains
ZONE_MOVABLE memory then all of the memory available from
memory controllers at higher addresses must also be in the
ZONE_MOVABLE zone. This would force all kernel memory accesses
onto the lowest addressed memory controller and significantly
reduce the amount of memory available for non-movable
allocations.

The main objective of this patch set is therefore to allow a
block of memory to be designated as part of the ZONE_MOVABLE
zone where it will always only be used by the kernel page
allocator to satisfy requests for movable pages. The term
Designated Movable Block is introduced here to represent such a
block. The favored implementation allows modification of the
'movablecore' kernel parameter to allow specification of a base
address and support for multiple blocks. The existing
'movablecore' mechanisms are retained. Other mechanisms based on
device tree are also included in this set.

BACKGROUND:
NUMA architectures support distributing movablecore memory
across each node, but it is undesirable to introduce the
overhead and complexities of NUMA on systems that don't have a
Non-Uniform Memory Architecture.

Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror option")
also depends on zone overlap to support sytems with multiple
mirrored ranges.

Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
embraced overlapped zones for memory hotplug.

This commit set follows their lead to allow the ZONE_MOVABLE
zone to overlap other zones while spanning the pages from the
lowest Designated Movable Block to the end of the node.
Designated Movable Blocks are made absent from overlapping zones
and present within the ZONE_MOVABLE zone.

I initially investigated an implementation using a Designated
Movable migrate type in line with comments[1] made by Mel Gorman
regarding a "sticky" MIGRATE_MOVABLE type to avoid using
ZONE_MOVABLE. However, this approach was riskier since it was
much more instrusive on the allocation paths. Ultimately, the
progress made by the memory hotplug folks to expand the
ZONE_MOVABLE functionality convinced me to follow this approach.

OPPORTUNITIES:
There have been many attempts to modify the behavior of the
kernel page allocators use of CMA regions. This implementation
of Designated Movable Blocks creates an opportunity to repurpose
the CMA allocator to operate on ZONE_MOVABLE memory that the
kernel page allocator can use more agressively, without
affecting the existing CMA implementation. It is hoped that the
"shared-dmb-pool" approach included here will be useful in cases
where memory sharing is more important than allocation latency.

CMA introduced a paradigm where multiple allocators could
operate on the same region of memory, and that paradigm can be
extended to Designated Movable Blocks as well. I was interested
in using kernel resource management as a mechanism for exposing
Designated Movable Block resources (e.g. /proc/iomem) that would
be used by the kernel page allocator like any other ZONE_MOVABLE
memory, but could be claimed by an alternative allocator (e.g.
CMA). Unfortunately, this becomes complicated because the kernel
resource implementation varies materially across different
architectures and I do not require this capability so I have
deferred that.

The MEMBLOCK_MOVABLE and MEMBLOCK_HOTPLUG have a lot in common
and could potentially be consolidated, but I chose to avoid that
here to reduce controversy.

The CMA and DMB alignment constraints are currently the same so
the logic could be simplified, but this implementation keeps
them distinct to facilitate independent evolution of the
implementations if necessary.

COMMITS: 
Commits 1-3 represent bug fixes that could have been submitted
separately and should be submitted to linux-stable. They are
included here because of later commit dependencies to facilitate
review of the entire patch set.

Commits 4-6 are enhancements of hugepage migration to support
contiguous allocations (i.e. alloc_contig_range). These are
potentially of value if a non-gigantic hugepage can be
allocated through fallback from MIGRATE_CMA pageblocks or for
the allocation of gigantic pages. Their real value is to support
CMA from Designated Movable Blocks.

Commits 7-15 make up the preferred embodiment of the concept of
Designated Movable Block support.

The remaining commits (i.e. 16-21) are examples of additional
opportunites to use DMBs with other kernel services to achieve
more aggressive sharing of DMB reservations with the kernel
page allocator. It is hoped that they are of value to others,
but they can be reviewed and evaluated separately from the other
commits in this set if there is controversy and/or opportunites
for improvement.

[1] https://lore.kernel.org/lkml/20160428103927.GM2858@techsingularity.net/

Doug Berger (21):
  mm/page_isolation: protect cma from isolate_single_pageblock
  mm/hugetlb: correct max_huge_pages accounting on demote
  mm/hugetlb: correct demote page offset logic
  mm/hugetlb: refactor alloc_and_dissolve_huge_page
  mm/hugetlb: allow migrated hugepage to dissolve when freed
  mm/hugetlb: add hugepage isolation support
  lib/show_mem.c: display MovableOnly
  mm/vmstat: show start_pfn when zone spans pages
  mm/page_alloc: calculate node_spanned_pages from pfns
  mm/page_alloc.c: allow oversized movablecore
  mm/page_alloc: introduce init_reserved_pageblock()
  memblock: introduce MEMBLOCK_MOVABLE flag
  mm/dmb: Introduce Designated Movable Blocks
  mm/page_alloc: make alloc_contig_pages DMB aware
  mm/page_alloc: allow base for movablecore
  dt-bindings: reserved-memory: introduce designated-movable-block
  mm/dmb: introduce rmem designated-movable-block
  mm/cma: support CMA in Designated Movable Blocks
  dt-bindings: reserved-memory: shared-dma-pool: support DMB
  mm/cma: introduce rmem shared-dmb-pool
  mm/hugetlb: introduce hugetlb_dmb

 .../admin-guide/kernel-parameters.txt         |  17 +-
 .../designated-movable-block.yaml             |  51 ++++
 .../reserved-memory/shared-dma-pool.yaml      |   8 +
 drivers/of/of_reserved_mem.c                  |  20 +-
 include/linux/cma.h                           |  13 +-
 include/linux/dmb.h                           |  28 +++
 include/linux/gfp.h                           |   5 +-
 include/linux/hugetlb.h                       |   5 +
 include/linux/memblock.h                      |   8 +
 kernel/dma/contiguous.c                       |  33 ++-
 lib/show_mem.c                                |   2 +-
 mm/Kconfig                                    |  12 +
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |  58 +++--
 mm/dmb.c                                      | 156 ++++++++++++
 mm/hugetlb.c                                  | 194 +++++++++++----
 mm/memblock.c                                 |  30 ++-
 mm/migrate.c                                  |   1 +
 mm/page_alloc.c                               | 225 +++++++++++++-----
 mm/page_isolation.c                           |  75 +++---
 mm/vmstat.c                                   |   5 +
 21 files changed, 765 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
 create mode 100644 include/linux/dmb.h
 create mode 100644 mm/dmb.c

-- 
2.25.1

