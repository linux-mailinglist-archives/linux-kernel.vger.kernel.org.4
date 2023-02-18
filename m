Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07769B6B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBRA2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBRA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:47 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944D59732
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:44 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id y10-20020a9f324a000000b00657d8cfac32so805914uad.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mWeuLuNn4uyC0x6eZ6wlvm2QVk1yxpkiKp2+WFEPbUY=;
        b=V3JK4+P5D4Qwq+Cd8+LnP4X808+qWrQ2UIjvUIgLq9RTmqo27E5kdoz84WCA2+OIaQ
         nwBp+DC+qRh3tvyimigIyBUOPfeM1eVm9uTeFNPGhtG51SDBaAlOLWrU09sypMF/TPFG
         ZbEeK43D1ANEWQDBZr70y8d/NT+5xOBGacDn8BnGYnafkKkSEvRUvUuz3YwNPQhPuYkF
         JAvZYgXdSJthWThMc985jfNbl9YoVj5V6TCRYpcNbV51ApzH7+HCd953eALIg/7QmNzA
         94YSQru1UvYtUAzfeFGoVaycys+DvokZQ8KvX4+4O1Lm1as/wNgb/3EbHIdqB1P+3CHq
         DD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWeuLuNn4uyC0x6eZ6wlvm2QVk1yxpkiKp2+WFEPbUY=;
        b=Z6F/46pRxwCNmX12EYtKuSunOMJ3uiEcOsIsw002E/uUSQeIm5jNWH5PDQINVwkmzK
         lkk3UuWiGJAhHIt3Roow44UO5Ww6htfQ1atG8UJxgdQKhJEQCnbBZHciQHvLXr9vdgLl
         XDZXgGgMTiVm1/S5Un1m79dbf1h1E/7xkXbKjDBbGZygRqkBBjJNrg0iZB2NHwFhyJtI
         C+VcL8mJYYLULivzsWzrpwi0EccBcwtC1Oh5/+3OXsV/dhbcVaf+mGsWtK3Kx/hCNqH6
         5Xja1n5TS00wDamHk+fC6YHTumKL1TSRF9zni/vk6u5k+pV5BpUcwgPCVxxzNhK5Ts+1
         lHQw==
X-Gm-Message-State: AO0yUKURv8NHS87NFp4lu24jICXwslS8f0pGhyKuCJpog+o+EMbQCehl
        FNvNXRvB5zDhEfSQTc47NeF2PnSZ1USqf2Nw
X-Google-Smtp-Source: AK7set9rBoLXQVFin5khRVpuQJJvoRMICCVv99Ww1d88YMJESU8I2NCVScn/h2NF+Yub/Esf2uFtnVk2fNtQ6H+E
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:ad86:0:b0:409:9240:daa1 with SMTP
 id w128-20020a1fad86000000b004099240daa1mr112496vke.30.1676680123527; Fri, 17
 Feb 2023 16:28:43 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-1-jthoughton@google.com>
Subject: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity mapping
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the concept of HugeTLB high-granularity mapping
(HGM). This series teaches HugeTLB how to map HugeTLB pages at
high-granularity, similar to how THPs can be PTE-mapped.

Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
architectures and (some) support for MAP_PRIVATE will come later.

This series is based on latest mm-unstable (ccd6a73daba9).

Notable changes with this series
================================

 - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
   mapcounting for non-anon hugetlb.
 - The mapcounting scheme uses subpages' mapcounts for high-granularity
   mappings, but it does not use subpages_mapcount(). This scheme
   prevents the HugeTLB VMEMMAP optimization from being used, so it
   will be improved in a later series.
 - page_add_file_rmap and page_remove_rmap are updated so they can be
   used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
 - MADV_SPLIT has been added to enable the userspace API changes that
   HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
   changes in the future). MADV_SPLIT does NOT force all the mappings to
   be PAGE_SIZE.
 - MADV_COLLAPSE is expanded to include HugeTLB mappings.

Old versions:
v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/

Changelog:
v1 -> v2 (thanks Peter for all your suggestions!):
- Changed mapcount to be more THP-like, and make HGM incompatible with
  HVO.
- HGM is now disabled by default to leave HVO enabled by default.
- Added refcount overflow check.
- Removed cond_resched() in hugetlb_collapse().
- Take mmap_lock for writing in hugetlb_collapse().
- Fixed high-granularity UFFDIO_CONTINUE on a UFFDIO_WRITEPROTECTed page (+tests)
- Fixed vaddr math in follow_hugetlb_page.
- Fixed Kconfig to limit HGM to x86_64.
- Fixed some compile errors.
RFC v2 -> v1:
- Userspace API to enable HGM changed from
  UFFD_FEATURE_MINOR_HUGETLBFS_HGM to MADV_SPLIT.
- Picked up Acked-bys and Reviewed-bys. Thanks Mike, Peter, and Mina!
- Rebased onto latest mm-unstable, notably picking up Peter's
  HugeTLB walk synchronization fix [1].
- Changed MADV_COLLAPSE to take i_mmap_rwsem for writing to make its
  synchronization the same as huge_pmd_unshare, so anywhere where
  hugetlb_pte_walk() is safe, HGM walks are also safe.
- hugetlb_hgm_walk API has changed -- should reduce complexity where
  callers wish to do HGM walks.
- Always round addresses properly before populating hugetlb_ptes (always
  pick up first PTE in a contiguous bunch).
- Added a VMA flag for HGM: VM_HUGETLB_HGM; the hugetlb_shared_vma_data
  struct has been removed.
- Make hugetlb_pte.ptl always hold the PTL to use.
- Added a requirement that overlapping contiguous and non-contiguous
  PTEs must use the same PTL.
- Some things have been slightly renamed for clarity, and I've added
  lots of comments that I said I would.
- Added a test for fork() + uffd-wp to cover
  copy_hugetlb_page_range().

Patch breakdown:
Patches 1-4:	Cleanup.
Patch   5:	rmap preliminary changes.
Patches 6-9:	Add HGM config option, VM flag, MADV_SPLIT.
Patches 10-15:	Create hugetlb_pte and implement HGM basics.
Patches 16-30:	Make existing routines compatible with HGM.
Patches 31-34:	Extend userfaultfd to support high-granularity
CONTINUEs.
Patch   35:	Add HugeTLB HGM support to MADV_COLLAPSE.
Patch   36:	Add refcount overflow check.
Patches 37-40:	Cleanup, add HGM stats, and enable HGM for x86_64.
Patches 41-47:	Documentation and selftests.

Motivation
==========

Being able to map HugeTLB pages at PAGE_SIZE has important use cases in
post-copy live migration and memory poisoning.

- Live Migration (userfaultfd)
For post-copy live migration, using userfaultfd, currently we have to
install an entire hugepage before we can allow a guest to access that
page. This is because, right now, either the WHOLE hugepage is mapped or
NONE of it is. So either the guest can access the WHOLE hugepage or NONE
of it. This makes post-copy live migration for 1G HugeTLB-backed VMs
completely infeasible.

With high-granularity mapping, we can map PAGE_SIZE pieces of a
hugepage, thereby allowing the guest to access only PAGE_SIZE chunks,
and getting page faults on the rest (and triggering another
demand-fetch). This gives userspace the flexibility to install PAGE_SIZE
chunks of memory into a hugepage, making migration of 1G-backed VMs
perfectly feasible, and it vastly reduces the vCPU stall time during
post-copy for 2M-backed VMs.

At Google, for a 48 vCPU VM in post-copy, we can expect these approximate
per-page median fetch latencies:
     4K: <100us
     2M: >10ms
Being able to unpause a vCPU 100x quicker is helpful for guest stability,
and being able to use 1G pages at all can significant improve
steady-state guest performance.

After fully copying a hugepage over the network, we will want to
collapse the mapping down to what it would normally be (e.g., one PUD
for a 1G page). Rather than having the kernel do this automatically,
we leave it up to userspace to tell us to collapse a range (via
MADV_COLLAPSE).

- Memory Failure
When a memory error is found within a HugeTLB page, it would be ideal
if we could unmap only the PAGE_SIZE section that contained the error.
This is what THPs are able to do. Using high-granularity mapping, we
could do this, but this isn't tackled in this patch series.

Userspace API
=============

This series introduces the first application of high-granularity
mapping: high-granularity userfaultfd post-copy for HugeTLB.

The userspace API for this consists of:
- MADV_SPLIT: to enable the following userfaultfd API changes.
  1. read(uffd): addresses are rounded to PAGE_SIZE instead of the
     hugepage size.
  2. UFFDIO_CONTINUE for HugeTLB VMAs is now allowed in
     PAGE_SIZE-aligned chunks.
- MADV_COLLAPSE is now available for MAP_SHARED HugeTLB VMAs. It is used
  to collapse the page table mappings, but it does not undo the API
  changes that MADV_SPLIT provides.

HugeTLB changes
===============

- hugetlb_pte
`hugetlb_pte` is used to keep track of "HugeTLB" PTEs, which are PTEs at
any level and of any size. page_vma_mapped_walk and pagewalk have both
been changed to provide `hugetlb_pte`s to callers so that they can get
size+level information that, before, came from the hstate.

- Mapcount
Previously, file-backed HugeTLB pages had their mapcount incremented by
page_dup_file_rmap. This is replaced with page_add_file_rmap, which is
wrapped by hugetlb_add_file_rmap to implement new mapcount behavior.

HugeTLB pages mapped at hugepage-granularity still have their
compound_mapcount incremented by 1, but when a page is mapped at
high granularity, we increase the subpages' mapcounts for all the
subpages that get mapped. For example, for a 1G page, if a 2M piece of
it is mapped with a PMD, the mapcount for all the 4K pages within the 2M
piece have their mapcount's incremented.

This behavior means that HGM is incompatible with the HugeTLB Vmemmap
Optimization (HVO). HGM is disabled by default, and if it gets enabled,
HVO will be disabled. Also, collapsing to the hugepage size requires us
to decrement the subpage mapcounts for all of the subpages we had
mapped. For a 1G page, this can get really slow. This thread[3] has some
discussion.

- Synchronization
Collapsing high-granularity HugeTLB mappings requires taking the
mmap_lock for writing.

Supporting arm64 & contiguous PTEs
==================================

As implemented, HGM does not yet fully support contiguous PTEs. To do
this, the HugeTLB API that architectures implement will need to change.
For example, set_huge_pte_at merely takes a `pte_t *`; there is no
information about the "size" of that PTE (like, if we need to overwrite
multiple contiguous PTEs).

To handle this, in a follow-up series, set_huge_pte_at and many other
similar functions will be replaced with variants that take
`hugetlb_pte`s. See [2] for how this may be implemented, plus a full HGM
implementation for arm64.

Supporting architectures beyond arm64
=====================================

Each architecture must audit their HugeTLB implementations to make sure
that they support HGM. For example, architectures that implement
arch_make_huge_pte need to ensure that a `shift` of `PAGE_SHIFT` is
acceptable.

Architectures must also audit code that might depend on HugeTLB always
having large mappings (i.e., check huge_page_size(), huge_page_shift(),
vma_kernel_pagesize(), and vma_mmu_pagesize() callers). For example, the
arm64 KVM MMU implementation thinks that all hugepages are mapped at
huge_page_size(), and thus builds the second-stage page table
accordingly. In an HGM world, this isn't true; it is corrected in [2].

[1]: https://lore.kernel.org/linux-mm/20221216155100.2043537-1-peterx@redhat.com/
[2]: https://github.com/48ca/linux/tree/hgmv1-dec19-2
[3]: https://lore.kernel.org/linux-mm/CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com/

James Houghton (46):
  hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
  hugetlb: remove mk_huge_pte; it is unused
  hugetlb: remove redundant pte_mkhuge in migration path
  hugetlb: only adjust address ranges when VMAs want PMD sharing
  rmap: hugetlb: switch from page_dup_file_rmap to page_add_file_rmap
  hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
  mm: add VM_HUGETLB_HGM VMA flag
  hugetlb: add HugeTLB HGM enablement helpers
  mm: add MADV_SPLIT to enable HugeTLB HGM
  hugetlb: make huge_pte_lockptr take an explicit shift argument
  hugetlb: add hugetlb_pte to track HugeTLB page table entries
  hugetlb: add hugetlb_alloc_pmd and hugetlb_alloc_pte
  hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
  hugetlb: split PTE markers when doing HGM walks
  hugetlb: add make_huge_pte_with_shift
  hugetlb: make default arch_make_huge_pte understand small mappings
  hugetlbfs: do a full walk to check if vma maps a page
  hugetlb: add HGM support to __unmap_hugepage_range
  hugetlb: add HGM support to hugetlb_change_protection
  hugetlb: add HGM support to follow_hugetlb_page
  hugetlb: add HGM support to hugetlb_follow_page_mask
  hugetlb: add HGM support to copy_hugetlb_page_range
  hugetlb: add HGM support to move_hugetlb_page_tables
  hugetlb: add HGM support to hugetlb_fault and hugetlb_no_page
  hugetlb: use struct hugetlb_pte for walk_hugetlb_range
  mm: rmap: provide pte_order in page_vma_mapped_walk
  mm: rmap: update try_to_{migrate,unmap} to handle mapcount for HGM
  mm: rmap: in try_to_{migrate,unmap}, check head page for hugetlb page
    flags
  hugetlb: update page_vma_mapped to do high-granularity walks
  hugetlb: add high-granularity migration support
  hugetlb: sort hstates in hugetlb_init_hstates
  hugetlb: add for_each_hgm_shift
  hugetlb: userfaultfd: add support for high-granularity UFFDIO_CONTINUE
  hugetlb: add MADV_COLLAPSE for hugetlb
  hugetlb: add check to prevent refcount overflow via HGM
  hugetlb: remove huge_pte_lock and huge_pte_lockptr
  hugetlb: replace make_huge_pte with make_huge_pte_with_shift
  mm: smaps: add stats for HugeTLB mapping size
  hugetlb: x86: enable high-granularity mapping for x86_64
  docs: hugetlb: update hugetlb and userfaultfd admin-guides with HGM
    info
  docs: proc: include information about HugeTLB HGM
  selftests/mm: add HugeTLB HGM to userfaultfd selftest
  KVM: selftests: add HugeTLB HGM to KVM demand paging selftest
  selftests/mm: add anon and shared hugetlb to migration test
  selftests/mm: add hugetlb HGM test to migration selftest
  selftests/mm: add HGM UFFDIO_CONTINUE and hwpoison tests

 Documentation/admin-guide/mm/hugetlbpage.rst  |    4 +
 Documentation/admin-guide/mm/userfaultfd.rst  |    8 +-
 Documentation/filesystems/proc.rst            |   56 +-
 arch/alpha/include/uapi/asm/mman.h            |    2 +
 arch/mips/include/uapi/asm/mman.h             |    2 +
 arch/parisc/include/uapi/asm/mman.h           |    2 +
 arch/powerpc/mm/pgtable.c                     |    6 +-
 arch/s390/include/asm/hugetlb.h               |    5 -
 arch/s390/mm/gmap.c                           |   12 +-
 arch/x86/Kconfig                              |    1 +
 arch/xtensa/include/uapi/asm/mman.h           |    2 +
 fs/Kconfig                                    |   13 +
 fs/hugetlbfs/inode.c                          |   17 +-
 fs/proc/task_mmu.c                            |  190 ++-
 fs/userfaultfd.c                              |   14 +-
 include/asm-generic/hugetlb.h                 |    5 -
 include/asm-generic/tlb.h                     |    6 +-
 include/linux/huge_mm.h                       |   12 +-
 include/linux/hugetlb.h                       |  170 +-
 include/linux/mm.h                            |    7 +
 include/linux/pagewalk.h                      |   10 +-
 include/linux/rmap.h                          |    1 +
 include/linux/swapops.h                       |    8 +-
 include/trace/events/mmflags.h                |    7 +
 include/uapi/asm-generic/mman-common.h        |    2 +
 mm/damon/vaddr.c                              |   41 +-
 mm/debug_vm_pgtable.c                         |    2 +-
 mm/hmm.c                                      |   20 +-
 mm/hugetlb.c                                  | 1390 ++++++++++++++---
 mm/khugepaged.c                               |    4 +-
 mm/madvise.c                                  |   56 +-
 mm/memory-failure.c                           |   17 +-
 mm/mempolicy.c                                |   28 +-
 mm/migrate.c                                  |   21 +-
 mm/mincore.c                                  |   17 +-
 mm/mprotect.c                                 |   18 +-
 mm/page_vma_mapped.c                          |   60 +-
 mm/pagewalk.c                                 |   20 +-
 mm/rmap.c                                     |   85 +-
 mm/userfaultfd.c                              |   40 +-
 .../selftests/kvm/demand_paging_test.c        |    2 +-
 .../testing/selftests/kvm/include/test_util.h |    2 +
 .../selftests/kvm/include/userfaultfd_util.h  |    6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |    2 +-
 tools/testing/selftests/kvm/lib/test_util.c   |   14 +
 .../selftests/kvm/lib/userfaultfd_util.c      |   14 +-
 tools/testing/selftests/mm/Makefile           |    1 +
 tools/testing/selftests/mm/hugetlb-hgm.c      |  608 +++++++
 tools/testing/selftests/mm/migration.c        |  229 ++-
 tools/testing/selftests/mm/userfaultfd.c      |   84 +-
 50 files changed, 2841 insertions(+), 502 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-hgm.c

-- 
2.39.2.637.g21b0678d19-goog

