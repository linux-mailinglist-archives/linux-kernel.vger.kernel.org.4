Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8495B707ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjERLHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:07:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CF5AB8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:07:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDF81FB;
        Thu, 18 May 2023 04:08:22 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91E4D3F793;
        Thu, 18 May 2023 04:07:36 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: [PATCH v2 0/5] Encapsulate PTE contents from non-arch code
Date:   Thu, 18 May 2023 12:07:22 +0100
Message-Id: <20230518110727.2106156-1-ryan.roberts@arm.com>
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

This is v2 of a series to improve the encapsulation of pte entries by
disallowing non-arch code from directly dereferencing pte_t pointers. Instead
code must use a new helper, `pte_t ptep_deref(pte_t *ptep)`.

See the v1 cover letter at [1] for rationale and explanation of approach.

As with v1, the series is split up as follows:

patchs 1-2: Fix bugs where code was _setting_ ptes directly, rather than using
            set_pte_at() and friends.
patch 3:    Fix highmem unmapping issue I spotted while doing the work.
patch 4:    Introduce the new ptep_deref() helper with default implementation.
patch 5:    Convert all direct dereferences to use ptep_deref().

Patches are based on v6.4-rc2 and a branch is available at [2].

Changes since v1:
   - patch 5: Fixed sh build bug reported by 0-day CI
   - patch 1: Refactored pfn to use local variable
   - patch 1-2: Minor rewording of commit message: 'verify' -> 'check'
   - patch 1-3: applied Ack/Reviewed-by tags; thanks for those!

[1] https://lore.kernel.org/linux-mm/20230511132113.80196-1-ryan.roberts@arm.com/
[2] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/ptep_deref-lkml_v2

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
 include/linux/hugetlb.h                       |   4 +
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
 mm/memory.c                                   | 105 +++++++++---------
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
 mm/vmalloc.c                                  |  16 ++-
 mm/vmscan.c                                   |  14 ++-
 virt/kvm/kvm_main.c                           |   9 +-
 48 files changed, 310 insertions(+), 237 deletions(-)

--
2.25.1

