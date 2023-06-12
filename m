Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB572C98F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjFLPQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjFLPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:16:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F82498
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:16:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E5FE1FB;
        Mon, 12 Jun 2023 08:16:46 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 628073F5A1;
        Mon, 12 Jun 2023 08:15:56 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: [PATCH v3 0/3] Encapsulate PTE contents from non-arch code
Date:   Mon, 12 Jun 2023 16:15:42 +0100
Message-Id: <20230612151545.3317766-1-ryan.roberts@arm.com>
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

(Including wider audience this time since changes touch a fair few subsystems)

This is the second half of v3 of a series to improve the encapsulation of pte
entries by disallowing non-arch code from directly dereferencing pte_t pointers.
Based on earlier feedback, I split the series in 2; the first part, fixes for
existing bugs, was already posted at [3] and merged into mm-stable. This second
part contains the conversion from direct dereferences to instead use
ptep_get()/ptep_get_lockless().

See the v1 cover letter at [1] for rationale for this work.

Based on feedback at v2, I've removed the new ptep_deref() helper I originally
added, and am now using the existing ptep_get() and ptep_get_lockless() helpers.
Testing on Ampere Altra (arm64) showed no difference in performance when using
ptep_deref() (*pte) vs ptep_get() (READ_ONCE(*pte)).

Patches are based on mm-unstable (49e038b1919e) and a branch is available at [4]
(Let me know if this is the wrong branch to target - I'm still not familiar with
the details of the mm- dev process!). Note that Hugh Dickins's "mm: allow
pte_offset_map[_lock]() to fail" (now in mm-unstable) patch set caused a number
of conflicts which I've resolved. But due to that, you won't be able to apply
these patches on top of Linus's tree. I have an alternate branch on top of
v6.4-rc6 at [5].

Changes since v2 [2]:
   - Removed ptep_deref() helper
   - Converted ptep_deref() callsites to use ptep_get[_lockless]()

Changes since v1 [1]:
   - Fixed sh build bug reported by 0-day CI

[1] https://lore.kernel.org/linux-mm/20230511132113.80196-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230518110727.2106156-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/all/20230602092949.545577-1-ryan.roberts@arm.com/
[4] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/ptep_get-mm-unstable-lkml_v3
[5] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/ptep_get-v6.4-rc6-lkml_v3

Thanks,
Ryan

Ryan Roberts (3):
  mm: ptdump should use ptep_get_lockless()
  mm: Move ptep_get() and pmdp_get() helpers
  mm: ptep_get() conversion

 .../drm/i915/gem/selftests/i915_gem_mman.c    |   8 +-
 drivers/misc/sgi-gru/grufault.c               |   2 +-
 drivers/vfio/vfio_iommu_type1.c               |   7 +-
 drivers/xen/privcmd.c                         |   2 +-
 fs/proc/task_mmu.c                            |  33 +++---
 fs/userfaultfd.c                              |   6 +-
 include/linux/hugetlb.h                       |   4 +
 include/linux/mm_inline.h                     |   2 +-
 include/linux/pgtable.h                       |  34 +++---
 kernel/events/uprobes.c                       |   2 +-
 mm/damon/ops-common.c                         |   2 +-
 mm/damon/paddr.c                              |   2 +-
 mm/damon/vaddr.c                              |  10 +-
 mm/filemap.c                                  |   2 +-
 mm/gup.c                                      |  21 ++--
 mm/highmem.c                                  |  12 ++-
 mm/hmm.c                                      |   2 +-
 mm/huge_memory.c                              |   4 +-
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |   6 +-
 mm/kasan/init.c                               |   9 +-
 mm/kasan/shadow.c                             |  10 +-
 mm/khugepaged.c                               |  22 ++--
 mm/ksm.c                                      |  22 ++--
 mm/madvise.c                                  |   6 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memcontrol.c                               |   4 +-
 mm/memory-failure.c                           |  26 ++---
 mm/memory.c                                   | 100 ++++++++++--------
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |  14 +--
 mm/migrate_device.c                           |  15 +--
 mm/mincore.c                                  |   2 +-
 mm/mlock.c                                    |   6 +-
 mm/mprotect.c                                 |   8 +-
 mm/mremap.c                                   |   2 +-
 mm/page_table_check.c                         |   4 +-
 mm/page_vma_mapped.c                          |  27 +++--
 mm/pgtable-generic.c                          |   2 +-
 mm/ptdump.c                                   |   2 +-
 mm/rmap.c                                     |  34 +++---
 mm/sparse-vmemmap.c                           |   8 +-
 mm/swap_state.c                               |   8 +-
 mm/swapfile.c                                 |  20 ++--
 mm/userfaultfd.c                              |   4 +-
 mm/vmalloc.c                                  |   6 +-
 mm/vmscan.c                                   |  14 +--
 virt/kvm/kvm_main.c                           |  11 +-
 48 files changed, 316 insertions(+), 243 deletions(-)

--
2.25.1

