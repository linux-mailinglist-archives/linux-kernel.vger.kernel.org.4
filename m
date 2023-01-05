Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6765E8BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjAEKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjAEKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:18:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2785E3F100
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:18:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-46658ec0cfcso366211157b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sje+Q3Cbd7x7PcBI3Z2uieK92XvyxtS+lMebiV56tRA=;
        b=ftCetkFs5m2DoQqxuM0pBarIuHfPEezEnwk1Xa4Auj220NmFJm68xtzCAEGtmP5Quh
         OqUXxisaH39FHQgV15EbcHAlEVBSVgchngI1PHRxxya3fpTY8ZDm6aQZLBWTfr60aubO
         H0ebkQr76v6h6vN2Y2sVVt8v48ZXJJpu7Sdr0/5jnGKUAdFY/B61GHg9QYInEgDUHg7K
         s/kVUH3Ij5ocUyGPq1ZIjeBrkgWPebmKd9OADoXlXtbRPPRpyCmu6HdBiv68jF0pVHIV
         EywNtYhym5oHMX6VvInY6anbBIrRs0e9mEonPn63aFWF/TvZUNS4C8ZcOpCTICBNAgyk
         V05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sje+Q3Cbd7x7PcBI3Z2uieK92XvyxtS+lMebiV56tRA=;
        b=mwb7GS0/nvdSj27YgGV2nXuQjA6xoPJP0EcvMCjjPFAQB2fILFiIi2jrBH2nh7FDw5
         3+gC3hj3Ao9kkhSc4NpkU+HwU0kAPjgwNfFoMWzfzqYdcYszmz6zXb8yO5fqzHcHu1mM
         LaNxR3ok6AuNFddtw44UPykT9Z9thY86lW9ivva9tnZkLUk3j1SzagDWRrwjfG4WI1/s
         mdDLmgaMInL4fsCloWv5Oj8GyUmHclJGJYhKVOFKunQFaO2MT/RflfVyGPCra/Hjc9vG
         luPT6f0bGqC3pHzv+eyjg1GRar7l0O5C3q0ykoMMM48UvF7b8eAV8C5kbRYvXVywyex1
         Y4+w==
X-Gm-Message-State: AFqh2koGEngL03vA/7C5WPlJZ+O0TYJhBpt9hLFnAxd7emkqMdFZLkzS
        8/7TBuBrefq3/yCboLPLcc/63/R6gSQXbvOZ
X-Google-Smtp-Source: AMrXdXvh2OSOvb3B67iEbEvn4mi3Uat+1THVjEQAa8/Li5NaA403fJQOjk77qE652OLIOWL4VOZMCcGpNuUALU9P
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:a004:0:b0:4af:2061:d89d with SMTP
 id x4-20020a81a004000000b004af2061d89dmr1160420ywg.117.1672913931882; Thu, 05
 Jan 2023 02:18:51 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:17:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-1-jthoughton@google.com>
Subject: [PATCH 00/46] Based on latest mm-unstable (85b44c25cd1e).
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

Support for HGM in this series is for MAP_SHARED VMAs on x86 only. Other
architectures and (some) support for MAP_PRIVATE will come later.

Old versions:
RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/

Changelog (RFC v2 -> v1):
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
Patches 5-15:	Create hugetlb_pte and implement HGM basics (PT walking,
		enabling HGM).
Patches 16-30:	Make existing routines compatible with HGM.
Patches 31-34:	Extend userfaultfd to support high-granularity
CONTINUEs.
Patch   35:	Add HugeTLB HGM support to MADV_COLLAPSE.
Patches 36-39:	Cleanup, add HGM stats, and enable HGM for x86.
Patches 40-46:	Documentation and selftests.

Motivation (mostly unchanged from RFC v1)
=====

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
=====

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
=====

- hugetlb_pte
`hugetlb_pte` is used to keep track of "HugeTLB" PTEs, which are PTEs at
any level and of any size. page_vma_mapped_walk and pagewalk have both
been changed to provide `hugetlb_pte`s to callers so that they can get
size+level information that, before, came from the hstate.

- Mapcount
The mapcount for a high-granularity mapped HugeTLB page is the total
number of page table references to that page. So if we have a 2M page
that is mapped in a single VMA with 512 4K PTEs, the mapcount will be
512.

- Synchronization
Collapsing high-granularity page table mappings has the same
synchronization requirements as huge_pmd_unshare (grab both the HugeTLB
VMA lock for writing and i_mmap_rwsem for writing), so anywhere where it
is safe to do hugetlb_walk(), it is also safe to do a high-granularity
page table walk.

Supporting arm64 & contiguous PTEs
=====

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
=====

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

James Houghton (46):
  hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
  hugetlb: remove mk_huge_pte; it is unused
  hugetlb: remove redundant pte_mkhuge in migration path
  hugetlb: only adjust address ranges when VMAs want PMD sharing
  hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
  mm: add VM_HUGETLB_HGM VMA flag
  hugetlb: rename __vma_shareable_flags_pmd to
    __vma_has_hugetlb_vma_lock
  hugetlb: add HugeTLB HGM enablement helpers
  mm: add MADV_SPLIT to enable HugeTLB HGM
  hugetlb: make huge_pte_lockptr take an explicit shift argument
  hugetlb: add hugetlb_pte to track HugeTLB page table entries
  hugetlb: add hugetlb_alloc_pmd and hugetlb_alloc_pte
  hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
  hugetlb: add make_huge_pte_with_shift
  hugetlb: make default arch_make_huge_pte understand small mappings
  hugetlbfs: do a full walk to check if vma maps a page
  hugetlb: make unmapping compatible with high-granularity mappings
  hugetlb: add HGM support for hugetlb_change_protection
  hugetlb: add HGM support for follow_hugetlb_page
  hugetlb: add HGM support for hugetlb_follow_page_mask
  hugetlb: use struct hugetlb_pte for walk_hugetlb_range
  mm: rmap: provide pte_order in page_vma_mapped_walk
  mm: rmap: make page_vma_mapped_walk callers use pte_order
  rmap: update hugetlb lock comment for HGM
  hugetlb: update page_vma_mapped to do high-granularity walks
  hugetlb: add HGM support for copy_hugetlb_page_range
  hugetlb: add HGM support for move_hugetlb_page_tables
  hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
  rmap: in try_to_{migrate,unmap}_one, check head page for page flags
  hugetlb: add high-granularity migration support
  hugetlb: sort hstates in hugetlb_init_hstates
  hugetlb: add for_each_hgm_shift
  hugetlb: userfaultfd: add support for high-granularity UFFDIO_CONTINUE
  hugetlb: userfaultfd: when using MADV_SPLIT, round addresses to
    PAGE_SIZE
  hugetlb: add MADV_COLLAPSE for hugetlb
  hugetlb: remove huge_pte_lock and huge_pte_lockptr
  hugetlb: replace make_huge_pte with make_huge_pte_with_shift
  mm: smaps: add stats for HugeTLB mapping size
  hugetlb: x86: enable high-granularity mapping
  docs: hugetlb: update hugetlb and userfaultfd admin-guides with HGM
    info
  docs: proc: include information about HugeTLB HGM
  selftests/vm: add HugeTLB HGM to userfaultfd selftest
  selftests/kvm: add HugeTLB HGM to KVM demand paging selftest
  selftests/vm: add anon and shared hugetlb to migration test
  selftests/vm: add hugetlb HGM test to migration selftest
  selftests/vm: add HGM UFFDIO_CONTINUE and hwpoison tests

 Documentation/admin-guide/mm/hugetlbpage.rst  |    4 +
 Documentation/admin-guide/mm/userfaultfd.rst  |   16 +-
 Documentation/filesystems/proc.rst            |   56 +-
 arch/alpha/include/uapi/asm/mman.h            |    2 +
 arch/mips/include/uapi/asm/mman.h             |    2 +
 arch/parisc/include/uapi/asm/mman.h           |    2 +
 arch/powerpc/mm/pgtable.c                     |    6 +-
 arch/s390/include/asm/hugetlb.h               |    5 -
 arch/s390/mm/gmap.c                           |   20 +-
 arch/x86/Kconfig                              |    1 +
 arch/xtensa/include/uapi/asm/mman.h           |    2 +
 fs/Kconfig                                    |    7 +
 fs/hugetlbfs/inode.c                          |   17 +-
 fs/proc/task_mmu.c                            |  187 ++-
 fs/userfaultfd.c                              |   14 +-
 include/asm-generic/hugetlb.h                 |    5 -
 include/asm-generic/tlb.h                     |    6 +-
 include/linux/huge_mm.h                       |   12 +-
 include/linux/hugetlb.h                       |  212 ++-
 include/linux/mm.h                            |    7 +
 include/linux/pagewalk.h                      |   10 +-
 include/linux/rmap.h                          |    1 +
 include/linux/swapops.h                       |    8 +-
 include/trace/events/mmflags.h                |    7 +
 include/uapi/asm-generic/mman-common.h        |    2 +
 mm/damon/vaddr.c                              |   42 +-
 mm/debug_vm_pgtable.c                         |    2 +-
 mm/hmm.c                                      |   20 +-
 mm/hugetlb.c                                  | 1265 ++++++++++++++---
 mm/khugepaged.c                               |    4 +-
 mm/madvise.c                                  |   44 +-
 mm/memory-failure.c                           |   17 +-
 mm/mempolicy.c                                |   28 +-
 mm/migrate.c                                  |   20 +-
 mm/mincore.c                                  |   17 +-
 mm/mprotect.c                                 |   18 +-
 mm/page_vma_mapped.c                          |   60 +-
 mm/pagewalk.c                                 |   20 +-
 mm/rmap.c                                     |   54 +-
 mm/userfaultfd.c                              |   40 +-
 .../selftests/kvm/demand_paging_test.c        |    2 +-
 .../testing/selftests/kvm/include/test_util.h |    2 +
 .../selftests/kvm/include/userfaultfd_util.h  |    6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |    2 +-
 tools/testing/selftests/kvm/lib/test_util.c   |   14 +
 .../selftests/kvm/lib/userfaultfd_util.c      |   14 +-
 tools/testing/selftests/vm/Makefile           |    1 +
 tools/testing/selftests/vm/hugetlb-hgm.c      |  455 ++++++
 tools/testing/selftests/vm/migration.c        |  229 ++-
 tools/testing/selftests/vm/userfaultfd.c      |   84 +-
 50 files changed, 2560 insertions(+), 511 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugetlb-hgm.c

-- 
2.39.0.314.g84b9a713c41-goog

