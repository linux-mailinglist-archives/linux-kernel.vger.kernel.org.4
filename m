Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB40607C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJUQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJUQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD8124AACC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a2-20020a5b0002000000b006b48689da76so3741070ybp.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToeQMSprfjKJ7AgFbFKRXXeoC/PlD5SBplDrdgjYWK4=;
        b=FYquMZ0S8xueWhu85y/cL8X2eVXUoOxyjYtYhY/V/rfjxZ7eFNjrBZYrdEkCVnWJqa
         SzQaP3vFbMxY+5d3ucqtqk7IckZRj3wNc/yiDbdBmWoX7gl71HNE5pzWv/1HRWB6+W/X
         mTh8LuMiY2z2wXX7GvgqEkGHN3o/T15NRUTOXpSM9qWRn0EG+mZMXFFPm/9IONubr51H
         5qqajNcw8wkSDrhTQbe6vDQ5J3kHUrC86jsF+r8mFCo5OwMTUzYyJKfQB0nKgr5gE9n5
         el0U1sM8hZJhoaoK7SuYBzTuzmi8JZJO7KwyCndbzzH3K0nV89yXDQsb5rNPv4YUR3qm
         eDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToeQMSprfjKJ7AgFbFKRXXeoC/PlD5SBplDrdgjYWK4=;
        b=ePomtshpNyYR79H/2T2xaBxUOnlPx5LjXyYGi93z+foA4X/GO3RfiPjF6/p7Et/2wX
         Kqw7E6Mq4OlQGu1ipBEL45HYVjL0jyB3uFPzLxV22j4+8UF8XcSXbtlvg/jiJ1MH9gEW
         fvSeVLX33V3v+L4gBxYICLo8oRrib6gG9m2UYebyRxnxXrabdEpMi018Ibl+T+gkI7aS
         RHDVGVJlnvjkWHVcdxCpWGjdydVvsn73F2yux+iIMMTtang9jDGT/ALASQVtudagN9bd
         GDjP/4NdGNDWv1rwY5Ev8yGWNZ9mKGwVftz+BZrHv3V4wc5pKlOjzDMzUk8MTytr/3IS
         K9EQ==
X-Gm-Message-State: ACrzQf3wyPZmZLuOgq8HebGHqo1MUSj0K6G9ioy1xjg4NiHTo+NVvi3d
        8oQZ+ts5e47xjkkwSx27lCyV9sGVEkwRcLS7
X-Google-Smtp-Source: AMsMyM4kHJ3a670yz9k5wiPzJ0fbvPAff21OOvAfyP8H5946e31eYCf67abKW5qy3WZtpskgPI/UcOpq5xC1ktlc
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:1a85:0:b0:35e:37d:12e2 with SMTP id
 a127-20020a811a85000000b0035e037d12e2mr18080128ywa.417.1666370234339; Fri, 21
 Oct 2022 09:37:14 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-1-jthoughton@google.com>
Subject: [RFC PATCH v2 00/47] hugetlb: introduce HugeTLB high-granularity mapping
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

This RFC v2 is a more complete and correct implementation of
the original high-granularity mapping RFC[1]. For HGM background and
motivation, please see the original RFC.

This series has changed quite significantly since its first version, so
I've dropped all the Reviewed-bys that it picked up, and I am not
including a full changelog here. Some notable changes:
  1. mapcount rules have been simplified (now: the number of times a
     hugepage is referenced in page tables, still tracked on the head
     page).
  2. Synchronizing page table collapsing is now done using the VMA lock
     that Mike introduced recently.
  3. PTE splitting is only supported for blank PTEs, and it is done
     without needing to hold the VMA lock for writing. In many places,
     we explicitly check if a PTE has been split from under us.
  4. The userspace API has changed slightly.

This series implements high-granularity mapping basics, enough to
support PAGE_SIZE-aligned UFFDIO_CONTINUE operations and MADV_COLLAPSE
for shared HugeTLB VMAs for x86. The main use case for this is post-copy
for virtual machines, one of the important HGM use cases described in
[1]. MADV_COLLAPSE was originally introduced for THPs[2], but it is
now meaningful for HGM, and so I am co-opting the same API.

- Userspace API

There are two main ways userspace interacts with high-granularity
mappings:
  1. Create them with UFFDIO_CONTINUE in an apporiately configured
     userfaultfd VMA.
  2. Collapse high-granularity mappings with MADV_COLLAPSE.

The userfaultfd bits of the userspace API have changed slightly since
RFC v1. To configure a userfaultfd VMA to enable HGM, userspace must
provide UFFD_FEATURE_MINOR_HUGETLBFS_HGM and UFFD_FEATURE_EXACT_ADDRESS
in its call to UFFDIO_API.

- A Note About KVM

Normally KVM (as well as any other non-HugeTLB code that assumes that
HugeTLB pages will always be mapped with huge PTEs) would need to be
enlightened to do the correct thing with high-granularity-mapped HugeTLB
pages. It turns out that the x86 TDP MMU already handles HGM mappings
correctly, but other architectures' KVM MMUs, like arm64's, will need to
be updated before HGM can be enabled for those architectures.

- How complete is this series?

I have tested this series with the self-tests that I have modified and
added, and I have run real, large end-to-end migration tests. This
series should be mostly stable, though I haven't tested DAMON and other
pieces that were slightly changed by this series.

There is a bug in the current x86 TDP MMU that prevents MADV_COLLAPSE
from having an effect. That is, the second-stage mappings will remain
small. This will be fixed with [3], so unless you have [3] merged in
your tree, you will see that MADV_COLLAPSE does not impact on virtual
machine performance.

- Future Work

The main areas of future work are:
  1) Support more architectures (arm64 support is mostly complete, but
     supporting it is not trivial, and to keep this RFC as short as
     possible, I will send the arm64 support series separately).
  2) Improve performance. Right now we take two per-hpage locks in the
     hotpath for userfaultfd-based post-copy live migration, the page
     lock and the fault mutex. To improve post-copy performance as much
     as possible, we likely need to improve this locking strategy.
  3) Support PAGE_SIZE poisoning of HugeTLB pages. To provide userspace
     with consistent poison behavior whether using MAP_PRIVATE or
     MAP_SHARED, more work is needed to implement basic HGM support for
     MAP_PRIVATE mappings.

- Patches

Patches 1-4:	Cleanup.
Patches 5-6:	Extend the HugeTLB shared VMA lock struct.
Patches 7-14:	Create hugetlb_pte and implement HGM basics (PT walking,
		enabling HGM).
Patches 15-30:	Make existing routines compatible with HGM.
Patches 31-35:	Extend userfaultfd to support high-granularity CONTINUEs.
Patch   36:	Add HugeTLB HGM support to MADV_COLLAPSE.
Patches 37-40:	Cleanup, add HGM stats, and enable HGM for x86.
Patches 41-47:	Documentation and selftests.

This series is based on mm-everything-2022-10-20-00-43.

Finally, I will be on vacation next week (until Nov 2, unfortunate
timing). I will try to respond before Nov 2; I wanted to get this series
up ASAP.

[1] https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
[2] commit 7d8faaf155454 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
[3] https://lore.kernel.org/kvm/20220830235537.4004585-1-seanjc@google.com/

James Houghton (47):
  hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
  hugetlb: remove mk_huge_pte; it is unused
  hugetlb: remove redundant pte_mkhuge in migration path
  hugetlb: only adjust address ranges when VMAs want PMD sharing
  hugetlb: make hugetlb_vma_lock_alloc return its failure reason
  hugetlb: extend vma lock for shared vmas
  hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
  hugetlb: add HGM enablement functions
  hugetlb: make huge_pte_lockptr take an explicit shift argument.
  hugetlb: add hugetlb_pte to track HugeTLB page table entries
  hugetlb: add hugetlb_pmd_alloc and hugetlb_pte_alloc
  hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
  hugetlb: add make_huge_pte_with_shift
  hugetlb: make default arch_make_huge_pte understand small mappings
  hugetlbfs: for unmapping, treat HGM-mapped pages as potentially mapped
  hugetlb: make unmapping compatible with high-granularity mappings
  hugetlb: make hugetlb_change_protection compatible with HGM
  hugetlb: enlighten follow_hugetlb_page to support HGM
  hugetlb: make hugetlb_follow_page_mask HGM-enabled
  hugetlb: use struct hugetlb_pte for walk_hugetlb_range
  mm: rmap: provide pte_order in page_vma_mapped_walk
  mm: rmap: make page_vma_mapped_walk callers use pte_order
  rmap: update hugetlb lock comment for HGM
  hugetlb: update page_vma_mapped to do high-granularity walks
  hugetlb: add HGM support for copy_hugetlb_page_range
  hugetlb: make move_hugetlb_page_tables compatible with HGM
  hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
  rmap: in try_to_{migrate,unmap}_one, check head page for page flags
  hugetlb: add high-granularity migration support
  hugetlb: add high-granularity check for hwpoison in fault path
  hugetlb: sort hstates in hugetlb_init_hstates
  hugetlb: add for_each_hgm_shift
  userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
  hugetlb: userfaultfd: add support for high-granularity UFFDIO_CONTINUE
  userfaultfd: require UFFD_FEATURE_EXACT_ADDRESS when using HugeTLB HGM
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
 arch/powerpc/mm/pgtable.c                     |    3 +-
 arch/s390/include/asm/hugetlb.h               |    5 -
 arch/s390/mm/gmap.c                           |   20 +-
 arch/x86/Kconfig                              |    1 +
 fs/Kconfig                                    |    7 +
 fs/hugetlbfs/inode.c                          |   27 +-
 fs/proc/task_mmu.c                            |  184 ++-
 fs/userfaultfd.c                              |   56 +-
 include/asm-generic/hugetlb.h                 |    5 -
 include/asm-generic/tlb.h                     |    6 +-
 include/linux/huge_mm.h                       |   12 +-
 include/linux/hugetlb.h                       |  173 ++-
 include/linux/pagewalk.h                      |   11 +-
 include/linux/rmap.h                          |    5 +
 include/linux/swapops.h                       |    8 +-
 include/linux/userfaultfd_k.h                 |    7 +
 include/uapi/linux/userfaultfd.h              |    2 +
 mm/damon/vaddr.c                              |   57 +-
 mm/debug_vm_pgtable.c                         |    2 +-
 mm/hmm.c                                      |   21 +-
 mm/hugetlb.c                                  | 1209 ++++++++++++++---
 mm/khugepaged.c                               |    4 +-
 mm/madvise.c                                  |   24 +-
 mm/memory-failure.c                           |   17 +-
 mm/mempolicy.c                                |   28 +-
 mm/migrate.c                                  |   20 +-
 mm/mincore.c                                  |   17 +-
 mm/mprotect.c                                 |   18 +-
 mm/page_vma_mapped.c                          |   60 +-
 mm/pagewalk.c                                 |   32 +-
 mm/rmap.c                                     |  102 +-
 mm/userfaultfd.c                              |   46 +-
 .../selftests/kvm/demand_paging_test.c        |   20 +-
 .../testing/selftests/kvm/include/test_util.h |    2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |    2 +-
 tools/testing/selftests/kvm/lib/test_util.c   |   14 +
 tools/testing/selftests/vm/Makefile           |    1 +
 tools/testing/selftests/vm/hugetlb-hgm.c      |  326 +++++
 tools/testing/selftests/vm/migration.c        |  222 ++-
 tools/testing/selftests/vm/userfaultfd.c      |   90 +-
 43 files changed, 2449 insertions(+), 493 deletions(-)
 create mode 100644 tools/testing/selftests/vm/hugetlb-hgm.c

-- 
2.38.0.135.g90850a2211-goog

