Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939896FF1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbjEKM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbjEKM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:59:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFC35268B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:59:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFA4113E;
        Thu, 11 May 2023 05:59:52 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F303F5A1;
        Thu, 11 May 2023 05:59:06 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: 
Date:   Thu, 11 May 2023 13:58:43 +0100
Message-Id: <20230511125848.78621-1-ryan.roberts@arm.com>
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

Date: Thu, 11 May 2023 11:38:28 +0100
Subject: [PATCH v1 0/5] Encapsulate PTE contents from non-arch code

Hi All,

This series improves the encapsulation of pte entries by disallowing non-arch
code from directly dereferencing pte_t pointers. Instead code must use a new
helper, `pte_t ptep_deref(pte_t *ptep)`. By default, this helper does a direct
dereference of the pointer, so generated code should be exactly the same. But
it's presence sets us up for arch code being able to override the default to
"virtualize" the ptes without needing to maintain a shadow table.

I intend to take advantage of this for arm64 to enable use of its "contiguous
bit" to coalesce multiple ptes into a single tlb entry, reducing pressure and
improving performance. I have an RFC for the first part of this work at [1]. The
cover letter there also explains the second part, which this series is enabling.

I intend to post an RFC for the contpte changes in due course, but it would be
good to get the ball rolling on this enabler.

There are 2 reasons that I need the encapsulation:

  - Prevent leaking the arch-private PTE_CONT bit to the core code. If the core
    code reads a pte that contains this bit, it could end up calling
    set_pte_at() with the bit set which would confuse the implementation. So we
    can always clear PTE_CONT in ptep_deref() (and ptep_get()) to avoid a leaky
    abstraction.
  - Contiguous ptes have a single access and dirty bit for the contiguous range.
    So we need to "mix-in" those bits when the core is dereferencing a pte that
    lies in the contig range. There is code that dereferences the pte then takes
    different actions based on access/dirty (see e.g. write_protect_page()).

While ptep_get() and ptep_get_lockless() already exist, both of them are
implemented using READ_ONCE() by default. While we could use ptep_get() instead
of the new ptep_deref(), I didn't want to risk performance regression.
Alternatively, all call sites that currently use ptep_get() that need the
lockless behaviour could be upgraded to ptep_get_lockless() and ptep_get() could
be downgraded to a simple dereference. That would be cleanest, but is a much
bigger (and likely error prone) change because all the arch code would need to
be updated for the new definitions of ptep_get().

The series is split up as follows:

patchs 1-2: Fix bugs where code was _setting_ ptes directly, rather than using
            set_pte_at() and friends.
patch 3:    Fix highmem unmapping issue I spotted while doing the work.
patch 4:    Introduce the new ptep_deref() helper with default implementation.
patch 5:    Convert all direct dereferences to use ptep_deref().

[1] https://lore.kernel.org/linux-mm/20230414130303.2345383-1-ryan.roberts@arm.com/

Thanks,
Ryan


Ryan Roberts (5):
  mm: vmalloc must set pte via arch code
  mm: damon must atomically clear young on ptes and pmds
  mm: Fix failure to unmap pte on highmem systems
  mm: Add new ptep_deref() helper to fully encapsulate pte_t
  mm: ptep_deref() conversion

 .../drm/i915/gem/selftests/i915_gem_mman.c    |   8 +-
 drivers/misc/sgi-gru/grufault.c               |   2 +-
 drivers/vfio/vfio_iommu_type1.c               |   7 +-
 drivers/xen/privcmd.c                         |   2 +-
 fs/proc/task_mmu.c                            |  33 +++---
 fs/userfaultfd.c                              |   6 +-
 include/linux/hugetlb.h                       |   2 +-
 include/linux/mm_inline.h                     |   2 +-
 include/linux/pgtable.h                       |  13 ++-
 kernel/events/uprobes.c                       |   2 +-
 mm/damon/ops-common.c                         |  18 ++-
 mm/damon/ops-common.h                         |   4 +-
 mm/damon/paddr.c                              |   6 +-
 mm/damon/vaddr.c                              |  14 ++-
 mm/filemap.c                                  |   2 +-
 mm/gup.c                                      |  21 ++--
 mm/highmem.c                                  |  12 +-
 mm/hmm.c                                      |   2 +-
 mm/huge_memory.c                              |   4 +-
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |   6 +-
 mm/kasan/init.c                               |   9 +-
 mm/kasan/shadow.c                             |  10 +-
 mm/khugepaged.c                               |  24 ++--
 mm/ksm.c                                      |  22 ++--
 mm/madvise.c                                  |   6 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memcontrol.c                               |   4 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   | 103 +++++++++---------
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |  14 ++-
 mm/migrate_device.c                           |  14 ++-
 mm/mincore.c                                  |   2 +-
 mm/mlock.c                                    |   6 +-
 mm/mprotect.c                                 |   8 +-
 mm/mremap.c                                   |   2 +-
 mm/page_table_check.c                         |   4 +-
 mm/page_vma_mapped.c                          |  26 +++--
 mm/pgtable-generic.c                          |   2 +-
 mm/rmap.c                                     |  32 +++---
 mm/sparse-vmemmap.c                           |   8 +-
 mm/swap_state.c                               |   4 +-
 mm/swapfile.c                                 |  16 +--
 mm/userfaultfd.c                              |   4 +-
 mm/vmalloc.c                                  |  11 +-
 mm/vmscan.c                                   |  14 ++-
 virt/kvm/kvm_main.c                           |   9 +-
 48 files changed, 302 insertions(+), 236 deletions(-)

--
2.25.1

