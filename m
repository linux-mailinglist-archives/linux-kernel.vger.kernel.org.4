Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DB5EE963
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiI1Wdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiI1Wdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:33:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450AFF8FB7;
        Wed, 28 Sep 2022 15:33:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k12so8788499qkj.8;
        Wed, 28 Sep 2022 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OipyPPJT0Rp6dbUT2IznpicXr4z8zsUI864uuh5VE5c=;
        b=ZlwJGPrnZnL4/H1HJZ4haFRfPHh+HPZ4bbbKwSxk7NIbta9ydOmarwzNlfyab9fr/s
         6KoBAqf1QDo4A/9wUSWvOyLwGFvyue4pZvE2RDLc6gLMwE6V5DXDQHz8jmUdt40gR0UD
         vMYcYogkIvYyDzILXfZ0vzfLJj3II/bvj/EIElCzh5L6vCMzQ1yG+ZeVHAkD6Iiq5Lwz
         KVCOQu6afE9iZtHudNqtuBqxLXwtEttv5M1oGqVdN6gEAzNcK5R8HKxQET5ihMaYWxSO
         C+bVBU4O5lBrXOABGDA9cmFqPCl1+CTmpMwvleOeQMX2bkQrwFYYePLQknXts9S1XxLe
         lgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OipyPPJT0Rp6dbUT2IznpicXr4z8zsUI864uuh5VE5c=;
        b=FCTshdns7hXEz7I+arJESmTfy/ZXtezdKb7QFqPe9unWc2an52gS9J9yGIXb257yoG
         YpPPKjf0NoL1OgXvNxpdU8NpcsdMlgyYruyGhygSjOpew251qqDf+J1jA5XQC1yJV/us
         FdncdkiRCguDx5bvaTHLXhrKbGIcNQKLx9gmKGZn0dtAI5pM1pjPZJAapy2ZfL8o+2BA
         jRN+XbNHVIED+EhaMltE3hfOao+Kjl5JtMCiso9pe2CpKOchrquHCe3x6Vo2KzzPpzTM
         CjShwfQltrV8APRayJcwNZzucW96Yi/cwGGtseOdHzofCqH/uZzbA2OulUa/GIq039NI
         zLPw==
X-Gm-Message-State: ACrzQf301ge0LDvODxQV1Jl72/h9nWqZI5CflQ5nRxcqLRJFwWcBk69V
        SxBFms08oZH+CzTGgKkroeA=
X-Google-Smtp-Source: AMsMyM5ZFEsGBrXLgEqVigWokvCwJLbam+3Ws5Dlf+FFlfZt1R3Lnj1m/5W+5F7o7BbHBTFiaapr9g==
X-Received: by 2002:a05:620a:13cd:b0:6cb:e443:e97a with SMTP id g13-20020a05620a13cd00b006cbe443e97amr218754qkl.449.1664404424301;
        Wed, 28 Sep 2022 15:33:44 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j188-20020a37b9c5000000b006bb83c2be40sm3963481qkf.59.2022.09.28.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:33:43 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 0/9] mm: introduce Designated Movable Blocks
Date:   Wed, 28 Sep 2022 15:32:52 -0700
Message-Id: <20220928223301.375229-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
'movablecore' mechanisms are retained.

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

OTHER OPPORTUNITIES:
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

The Devicetree Specification includes support for specifying
reserved memory regions with a 'reusable' property to allow
sharing of the reserved memory between device drivers and the
OS. This is in line with the paradigm introduced by CMA, but is
currently only used by 'shared-dma-pool' compatible reserved
memory regions. Linux could choose to use Designated Movable
Blocks as the default mechanism for other 'reusable' reserved
memory. Device drivers that own 'reusable' reserved memory could
use the dmb_intersects() function introduced here to determine
whether memory requires reclamation from the OS before use and
could use the alloc/free_contig_range() functions to perform the
reclamation and release of memory needed by the device. The CMA
allocator API could be another candidate for device driver
reclamation, but it is not currently exposed for use by device
drivers in modules.

There have been attempts to modify the behavior of the kernel
page allocators use of CMA regions (e.g. [1] & [2]). This
implementation of Designated Movable Blocks creates an
opportunity to allow the CMA allocator to operate on
ZONE_MOVABLE memory that the kernel page allocator can use more
agressively, without affecting users of the existing CMA
implementation. This would have benefit when memory reuse is
more valuable than the cost of increased latency of CMA
allocations (e.g. hugetlb_cma).

These other opportunities are dependent on the Designated
Movable Block concept introduced here, so I will hold off
submitting any such follow-on proposals until there is movement
on this commit set.

NOTES:
The MEMBLOCK_MOVABLE and MEMBLOCK_HOTPLUG flags have a lot in
common and could potentially be consolidated, but I chose to
avoid that here to reduce controversy.

The CMA and DMB alignment constraints are currently the same so
the logic could be simplified, but this implementation keeps
them distinct to facilitate independent evolution of the
implementations if necessary.

Changes in v2:
  - first three commits upstreamed separately [3], [4], and [5].
  - commits 04-06 submitted separately [6].
  - Corrected errors "Reported-by: kernel test robot <lkp@intel.com>"
  - Deferred commits after 15 to simplify review of the base
    functionality.
  - minor reorganization of commit 13.

v1: https://lore.kernel.org/linux-mm/20220913195508.3511038-1-opendmb@gmail.com/

[1] https://lore.kernel.org/lkml/20160428103927.GM2858@techsingularity.net/
[2] https://lore.kernel.org/lkml/1401260672-28339-1-git-send-email-iamjoonsoo.kim@lge.com
[3] https://lore.kernel.org/linux-mm/20220914023913.1855924-1-zi.yan@sent.com
[4] https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com
[5] https://lore.kernel.org/linux-mm/20220914190917.3517663-1-opendmb@gmail.com
[6] https://lore.kernel.org/linux-mm/20220921223639.1152392-1-opendmb@gmail.com/

Doug Berger (9):
  lib/show_mem.c: display MovableOnly
  mm/vmstat: show start_pfn when zone spans pages
  mm/page_alloc: calculate node_spanned_pages from pfns
  mm/page_alloc.c: allow oversized movablecore
  mm/page_alloc: introduce init_reserved_pageblock()
  memblock: introduce MEMBLOCK_MOVABLE flag
  mm/dmb: Introduce Designated Movable Blocks
  mm/page_alloc: make alloc_contig_pages DMB aware
  mm/page_alloc: allow base for movablecore

 .../admin-guide/kernel-parameters.txt         |  14 +-
 include/linux/dmb.h                           |  29 ++++
 include/linux/gfp.h                           |   5 +-
 include/linux/memblock.h                      |   8 +
 lib/show_mem.c                                |   2 +-
 mm/Kconfig                                    |  12 ++
 mm/Makefile                                   |   1 +
 mm/cma.c                                      |  15 +-
 mm/dmb.c                                      |  91 ++++++++++
 mm/memblock.c                                 |  30 +++-
 mm/page_alloc.c                               | 155 ++++++++++++++----
 mm/vmstat.c                                   |   5 +
 12 files changed, 321 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/dmb.h
 create mode 100644 mm/dmb.c

-- 
2.25.1

