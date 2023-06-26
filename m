Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8366F73E622
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFZRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjFZROt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:14:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C69E10E7;
        Mon, 26 Jun 2023 10:14:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23F3C2F4;
        Mon, 26 Jun 2023 10:15:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37CCD3F663;
        Mon, 26 Jun 2023 10:14:38 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: [PATCH v1 00/10] variable-order, large folios for anonymous memory
Date:   Mon, 26 Jun 2023 18:14:20 +0100
Message-Id: <20230626171430.3167004-1-ryan.roberts@arm.com>
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

Following on from the previous RFCv2 [1], this series implements variable order,
large folios for anonymous memory. The objective of this is to improve
performance by allocating larger chunks of memory during anonymous page faults:

 - Since SW (the kernel) is dealing with larger chunks of memory than base
   pages, there are efficiency savings to be had; fewer page faults, batched PTE
   and RMAP manipulation, fewer items on lists, etc. In short, we reduce kernel
   overhead. This should benefit all architectures.
 - Since we are now mapping physically contiguous chunks of memory, we can take
   advantage of HW TLB compression techniques. A reduction in TLB pressure
   speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
   TLB entries; "the contiguous bit" (architectural) and HPA (uarch).

This patch set deals with the SW side of things only and based on feedback from
the RFC, aims to be the most minimal initial change, upon which future
incremental changes can be added. For this reason, the new behaviour is hidden
behind a new Kconfig switch, CONFIG_LARGE_ANON_FOLIO, which is disabled by
default. Although the code has been refactored to parameterize the desired order
of the allocation, when the feature is disabled (by forcing the order to be
always 0) my performance tests measure no regression. So I'm hoping this will be
a suitable mechanism to allow incremental submissions to the kernel without
affecting the rest of the world.

The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes() series
[2], which is a hard dependency. I'm not sure of Matthew's exact plans for
getting that series into the kernel, but I'm hoping we can start the review
process on this patch set independently. I have a branch at [3].

I've posted a separate series concerning the HW part (contpte mapping) for arm64
at [4].


Performance
-----------

Below results show 2 benchmarks; kernel compilation and speedometer 2.0 (a
javascript benchmark running in Chromium). Both cases are running on Ampere
Altra with 1 NUMA node enabled, Ubuntu 22.04 and XFS filesystem. Each benchmark
is repeated 15 times over 5 reboots and averaged.

All improvements are relative to baseline-4k. 'anonfolio-basic' is this series.
'anonfolio' is the full patch set similar to the RFC with the additional changes
to the extra 3 fault paths. The rest of the configs are described at [4].

Kernel Compilation (smaller is better):

| kernel          |   real-time |   kern-time |   user-time |
|:----------------|------------:|------------:|------------:|
| baseline-4k     |        0.0% |        0.0% |        0.0% |
| anonfolio-basic |       -5.3% |      -42.9% |       -0.6% |
| anonfolio       |       -5.4% |      -46.0% |       -0.3% |
| contpte         |       -6.8% |      -45.7% |       -2.1% |
| exefolio        |       -8.4% |      -46.4% |       -3.7% |
| baseline-16k    |       -8.7% |      -49.2% |       -3.7% |
| baseline-64k    |      -10.5% |      -66.0% |       -3.5% |

Speedometer 2.0 (bigger is better):

| kernel          |   runs_per_min |
|:----------------|---------------:|
| baseline-4k     |           0.0% |
| anonfolio-basic |           0.7% |
| anonfolio       |           1.2% |
| contpte         |           3.1% |
| exefolio        |           4.2% |
| baseline-16k    |           5.3% |


Changes since RFCv2
-------------------

  - Simplified series to bare minimum (on David Hildenbrand's advice)
      - Removed changes to 3 fault paths:
          - write fault on zero page: wp_page_copy()
          - write fault on non-exclusive CoW page: wp_page_copy()
          - write fault on exclusive CoW page: do_wp_page()/wp_page_reuse()
      - Only 1 fault path change remains:
          - write fault on unallocated address: do_anonymous_page()
      - Removed support patches that are no longer needed
  - Added Kconfig CONFIG_LARGE_ANON_FOLIO and friends
      - Whole feature defaults to off
      - Arch opts-in to allowing feature and provides max allocation order


Future Work
-----------

Once this series is in, there are some more incremental changes I plan to follow
up with:

  - Add the other 3 fault path changes back in
  - Properly support pte-mapped folios for:
      - numa balancing (do_numa_page())
      - fix assumptions about exclusivity for large folios in madvise()
      - compaction (although I think this is already a problem for large folios
        in the file cache so perhaps someone is working on it?)


[1] https://lore.kernel.org/linux-mm/20230414130303.2345383-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230315051444.3229621-1-willy@infradead.org/
[3] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/anonfolio-lkml_v1
[4] https://lore.kernel.org/linux-arm-kernel/20230622144210.2623299-1-ryan.roberts@arm.com/

Thanks,
Ryan


Ryan Roberts (10):
  mm: Expose clear_huge_page() unconditionally
  mm: pass gfp flags and order to vma_alloc_zeroed_movable_folio()
  mm: Introduce try_vma_alloc_movable_folio()
  mm: Implement folio_add_new_anon_rmap_range()
  mm: Implement folio_remove_rmap_range()
  mm: Allow deferred splitting of arbitrary large anon folios
  mm: Batch-zap large anonymous folio PTE mappings
  mm: Kconfig hooks to determine max anon folio allocation order
  arm64: mm: Declare support for large anonymous folios
  mm: Allocate large folios for anonymous memory

 arch/alpha/include/asm/page.h   |   5 +-
 arch/arm64/Kconfig              |  13 ++
 arch/arm64/include/asm/page.h   |   3 +-
 arch/arm64/mm/fault.c           |   7 +-
 arch/ia64/include/asm/page.h    |   5 +-
 arch/m68k/include/asm/page_no.h |   7 +-
 arch/s390/include/asm/page.h    |   5 +-
 arch/x86/include/asm/page.h     |   5 +-
 include/linux/highmem.h         |  23 ++-
 include/linux/mm.h              |   3 +-
 include/linux/rmap.h            |   4 +
 mm/Kconfig                      |  39 ++++
 mm/memory.c                     | 324 ++++++++++++++++++++++++++++++--
 mm/rmap.c                       | 107 ++++++++++-
 14 files changed, 506 insertions(+), 44 deletions(-)

--
2.25.1

