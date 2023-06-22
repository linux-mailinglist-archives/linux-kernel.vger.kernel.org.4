Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169073A356
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFVOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjFVOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:42:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B2E3170C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:42:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA1BCC14;
        Thu, 22 Jun 2023 07:43:11 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 335663F663;
        Thu, 22 Jun 2023 07:42:25 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 00/14] Transparent Contiguous PTEs for User Mappings
Date:   Thu, 22 Jun 2023 15:41:55 +0100
Message-Id: <20230622144210.2623299-1-ryan.roberts@arm.com>
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

This is a series to opportunistically and transparently use contpte mappings
(set the contiguous bit in ptes) for user memory when those mappings meet the
requirements. It is part of a wider effort to improve performance of the 4K
kernel with the aim of approaching the performance of the 16K kernel, but
without breaking compatibility and without the associated increase in memory. It
also benefits the 16K and 64K kernels by enabling 2M THP, since this is the
contpte size for those kernels.

Of course this is only one half of the change. We require the mapped physical
memory to be the correct size and alignment for this to actually be useful (i.e.
64K for 4K pages, or 2M for 16K/64K pages). Fortunately folios are solving this
problem for us. Filesystems that support it (XFS, AFS, EROFS, tmpfs) will
allocate large folios up to the PMD size today, and more filesystems are coming.
And the other half of my work, to enable the use of large folios for anonymous
memory, aims to make contpte sized folios prevalent for anonymous memory too.


Dependencies
------------

While there is a complicated set of hard and soft dependencies that this patch
set depends on, I wanted to split it out as best I could and kick off proper
review independently.

The series applies on top of these other patch sets, with a tree at:
https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/contpte-lkml_v1

v6.4-rc6
  - base

set_ptes()
  - hard dependency
  - Patch set from Matthew Wilcox to set multiple ptes with a single API call
  - Allows arch backend to more optimally apply contpte mappings
  - https://lore.kernel.org/linux-mm/20230315051444.3229621-1-willy@infradead.org/

ptep_get() pte encapsulation
  - hard dependency
  - Enabler series from me to ensure none of the core code ever directly
    dereferences a pte_t that lies within a live page table.
  - Enables gathering access/dirty bits from across the whole contpte range
  - in mm-stable and linux-next at time of writing
  - https://lore.kernel.org/linux-mm/d38dc237-6093-d4c5-993e-e8ffdd6cb6fa@arm.com/

Report on physically contiguous memory in smaps
  - soft dependency
  - Enables visibility on how much memory is physically contiguous and how much
    is contpte-mapped - useful for debug
  - https://lore.kernel.org/linux-mm/20230613160950.3554675-1-ryan.roberts@arm.com/

Additionally there are a couple of other dependencies:

anonfolio
  - soft dependency
  - ensures more anonymous memory is allocated in contpte-sized folios, so
    needed to realize the performance improvements (this is the "other half"
    mentioned above).
  - RFC: https://lore.kernel.org/linux-mm/20230414130303.2345383-1-ryan.roberts@arm.com/
  - Intending to post v1 shortly.

exefolio
  - soft dependency
  - Tweak readahead to ensure executable memory are in 64K-sized folios, so
    needed to see reduction in iTLB pressure.
  - Don't intend to post this until we are further down the track with contpte
    and anonfolio.

Arm ARM Clarification
  - hard dependency
  - Current wording disallows the fork() optimization in the final patch.
  - Arm (ATG) have proposed tightening the wording to permit it.
  - In conversation with partners to check this wouldn't cause problems for any
    existing HW deployments

All of the _hard_ dependencies need to be resolved before this can be considered
for merging.


Performance
-----------

Below results show 2 benchmarks; kernel compilation and speedometer 2.0 (a
javascript benchmark running in Chromium). Both cases are running on Ampere
Altra with 1 NUMA node enabled, Ubuntu 22.04 and XFS filesystem. Each benchmark
is repeated 15 times over 5 reboots and averaged.

All improvements are relative to baseline-4k. anonfolio and exefolio are as
described above. contpte is this series. (Note that exefolio only gives an
improvement because contpte is already in place).

Kernel Compilation (smaller is better):

| kernel       |   real-time |   kern-time |   user-time |
|:-------------|------------:|------------:|------------:|
| baseline-4k  |        0.0% |        0.0% |        0.0% |
| anonfolio    |       -5.4% |      -46.0% |       -0.3% |
| contpte      |       -6.8% |      -45.7% |       -2.1% |
| exefolio     |       -8.4% |      -46.4% |       -3.7% |
| baseline-16k |       -8.7% |      -49.2% |       -3.7% |
| baseline-64k |      -10.5% |      -66.0% |       -3.5% |

Speedometer 2.0 (bigger is better):

| kernel       |   runs_per_min |
|:-------------|---------------:|
| baseline-4k  |           0.0% |
| anonfolio    |           1.2% |
| contpte      |           3.1% |
| exefolio     |           4.2% |
| baseline-16k |           5.3% |

I've also run Speedometer 2.0 on Pixel 6 with an Ubuntu SW stack and see similar
gains.

I've also verified that running the contpte changes without anonfolio and
exefolio does not cause any regression vs baseline-4k.


Opens
-----

The only potential issue that I see right now is that due to there only being 1
access/dirty bit per contpte range, if a single page in the range is
accessed/dirtied then all the adjacent pages are reported as accessed/dirtied
too. Access/dirty is managed by the kernel per _folio_, so this information gets
collapsed down anyway, and nothing changes there. However, the per _page_
access/dirty information is reported through pagemap to user space. I'm not sure
if this would/should be considered a break? Thoughts?

Thanks,
Ryan


Ryan Roberts (14):
  arm64/mm: set_pte(): New layer to manage contig bit
  arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
  arm64/mm: pte_clear(): New layer to manage contig bit
  arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
  arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
  arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
  arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
  arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
  arm64/mm: ptep_get(): New layer to manage contig bit
  arm64/mm: Split __flush_tlb_range() to elide trailing DSB
  arm64/mm: Wire up PTE_CONT for user mappings
  arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
  mm: Batch-copy PTE ranges during fork()
  arm64/mm: Implement ptep_set_wrprotects() to optimize fork()

 arch/arm64/include/asm/pgtable.h  | 305 +++++++++++++++++---
 arch/arm64/include/asm/tlbflush.h |  11 +-
 arch/arm64/kernel/efi.c           |   4 +-
 arch/arm64/kernel/mte.c           |   2 +-
 arch/arm64/kvm/guest.c            |   2 +-
 arch/arm64/mm/Makefile            |   3 +-
 arch/arm64/mm/contpte.c           | 443 ++++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c             |  12 +-
 arch/arm64/mm/fixmap.c            |   4 +-
 arch/arm64/mm/hugetlbpage.c       |  40 +--
 arch/arm64/mm/kasan_init.c        |   6 +-
 arch/arm64/mm/mmu.c               |  16 +-
 arch/arm64/mm/pageattr.c          |   6 +-
 arch/arm64/mm/trans_pgd.c         |   6 +-
 include/linux/pgtable.h           |  13 +
 mm/memory.c                       | 149 +++++++---
 16 files changed, 896 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/mm/contpte.c

--
2.25.1

