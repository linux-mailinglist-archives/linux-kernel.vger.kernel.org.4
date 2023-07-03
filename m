Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99804745DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGCNxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGCNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:53:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1137810C0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:53:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD382F4;
        Mon,  3 Jul 2023 06:54:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F41E43F73F;
        Mon,  3 Jul 2023 06:53:40 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Date:   Mon,  3 Jul 2023 14:53:25 +0100
Message-Id: <20230703135330.1865927-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v2 of a series to implement variable order, large folios for anonymous
memory. The objective of this is to improve performance by allocating larger
chunks of memory during anonymous page faults. See [1] for background.

I've significantly reworked and simplified the patch set based on comments from
Yu Zhao (thanks for all your feedback!). I've also renamed the feature to
VARIABLE_THP, on Yu's advice.

The last patch is for arm64 to explicitly override the default
arch_wants_pte_order() and is intended as an example. If this series is accepted
I suggest taking the first 4 patches through the mm tree and the arm64 change
could be handled through the arm64 tree separately. Neither has any build
dependency on the other.

The one area where I haven't followed Yu's advice is in the determination of the
size of folio to use. It was suggested that I have a single preferred large
order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, or there
being existing overlapping populated PTEs, etc) then fallback immediately to
order-0. It turned out that this approach caused a performance regression in the
Speedometer benchmark. With my v1 patch, there were significant quantities of
memory which could not be placed in the 64K bucket and were instead being
allocated for the 32K and 16K buckets. With the proposed simplification, that
memory ended up using the 4K bucket, so page faults increased by 2.75x compared
to the v1 patch (although due to the 64K bucket, this number is still a bit
lower than the baseline). So instead, I continue to calculate a folio order that
is somewhere between the preferred order and 0. (See below for more details).

The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes() series
[2], which is a hard dependency. I have a branch at [3].


Changes since v1 [1]
--------------------

  - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
  - replaced with arch-independent alloc_anon_folio()
      - follows THP allocation approach
  - no longer retry with intermediate orders if allocation fails
      - fallback directly to order-0
  - remove folio_add_new_anon_rmap_range() patch
      - instead add its new functionality to folio_add_new_anon_rmap()
  - remove batch-zap pte mappings optimization patch
      - remove enabler folio_remove_rmap_range() patch too
      - These offer real perf improvement so will submit separately
  - simplify Kconfig
      - single FLEXIBLE_THP option, which is independent of arch
      - depends on TRANSPARENT_HUGEPAGE
      - when enabled default to max anon folio size of 64K unless arch
        explicitly overrides
  - simplify changes to do_anonymous_page():
      - no more retry loop


Performance
-----------

Below results show 3 benchmarks; kernel compilation with 8 jobs, kernel
compilation with 80 jobs, and speedometer 2.0 (a javascript benchmark running in
Chromium). All cases are running on Ampere Altra with 1 NUMA node enabled,
Ubuntu 22.04 and XFS filesystem. Each benchmark is repeated 15 times over 5
reboots and averaged.

'anonfolio-lkml-v1' is the v1 patchset at [1]. 'anonfolio-lkml-v2' is this v2
patchset. 'anonfolio-lkml-v2-simple-order' is anonfolio-lkml-v2 but with the
order selection simplification that Yu Zhao suggested - I'm trying to justify
here why I did not follow the advice.


Kernel compilation with 8 jobs:

| kernel                         |   real-time |   kern-time |   user-time |
|:-------------------------------|------------:|------------:|------------:|
| baseline-4k                    |        0.0% |        0.0% |        0.0% |
| anonfolio-lkml-v1              |       -5.3% |      -42.9% |       -0.6% |
| anonfolio-lkml-v2-simple-order |       -4.4% |      -36.5% |       -0.4% |
| anonfolio-lkml-v2              |       -4.8% |      -38.6% |       -0.6% |

We can see that the simple-order approach is responsible for a regression of
0.4%.


Kernel compilation with 80 jobs:

| kernel                         |   real-time |   kern-time |   user-time |
|:-------------------------------|------------:|------------:|------------:|
| baseline-4k                    |        0.0% |        0.0% |        0.0% |
| anonfolio-lkml-v1              |       -4.6% |      -45.7% |        1.4% |
| anonfolio-lkml-v2-simple-order |       -4.7% |      -40.2% |       -0.1% |
| anonfolio-lkml-v2              |       -5.0% |      -42.6% |       -0.3% |

simple-order costs 0.3 % here. v2 is actually performing higher than v1 due to
fixing the v1 regression on user-time.


Speedometer 2.0:

| kernel                         |   runs_per_min |
|:-------------------------------|---------------:|
| baseline-4k                    |           0.0% |
| anonfolio-lkml-v1              |           0.7% |
| anonfolio-lkml-v2-simple-order |          -0.9% |
| anonfolio-lkml-v2              |           0.5% |

simple-order regresses performance by 0.9% vs the baseline, for a total negative
swing of 1.6% vs v1. This is fixed by keeping the more complex order selection
mechanism from v1.


The remaining (kernel time) performance gap between v1 and v2 for the above
benchmarks is due to the removal of the "batch zap" patch in v2. Adding that
back in gives us the performance back. I intend to submit that as a separate
series once this series is accepted.


[1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230315051444.3229621-1-willy@infradead.org/
[3] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/anonfolio-lkml_v2

Thanks,
Ryan


Ryan Roberts (5):
  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
  mm: Allow deferred splitting of arbitrary large anon folios
  mm: Default implementation of arch_wants_pte_order()
  mm: FLEXIBLE_THP for improved performance
  arm64: mm: Override arch_wants_pte_order()

 arch/arm64/Kconfig               |  12 +++
 arch/arm64/include/asm/pgtable.h |   4 +
 arch/arm64/mm/mmu.c              |   8 ++
 include/linux/pgtable.h          |  13 +++
 mm/Kconfig                       |  10 ++
 mm/memory.c                      | 168 ++++++++++++++++++++++++++++---
 mm/rmap.c                        |  28 ++++--
 7 files changed, 222 insertions(+), 21 deletions(-)

--
2.25.1

