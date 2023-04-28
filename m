Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA75E6F0FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjD1Alt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD1Alr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:41:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F8210E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso1482888276.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682642505; x=1685234505;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt8UHocOfme6+v43sNp8IDOABRyG4m+oUHCMBiTHbAY=;
        b=j1pjcXeHNZekfQnY9WfUhFNWm4AZPk1FMP3aujwEifqVqCXDUB/6PU1/QtAWZh6UyR
         o1oX2953HqpAvD81qId75eNTX/3bH0Ig61QfDr6ep2qVJ9z04GSkNyyB7mvWEtLg+gSX
         0oQ76RuUQt6snu3KZtxKzn7YgKRnlHGp4UV+mTwPjNl9qIXfF9QjC0JTIIUcx0vKDdjS
         nUwwV6asUa0wScwbnyM/AC0QiUGDP7RJaMDv1x5CK/tyc6GOfOc+27u3Wuzr7hOiV/3i
         G5KnoIIzNUaW97FuCcxg0KQBzDficy+Ws4eidjMgP4h7pbo4ugEg8zFm5kyeS/9Pl3FG
         64yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642505; x=1685234505;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt8UHocOfme6+v43sNp8IDOABRyG4m+oUHCMBiTHbAY=;
        b=ToGQ3NzdX1tSCm9otEemFemrEes5UgLTwnJB2ksZ7d6W9GRN8fWI81ifWShfda9kSK
         Mb9QszW1IN158qD4/KB8LX/PYuywjSO5bRD8eedZYEsrq36yjUyjVoNLwxr6nILjU0Qt
         ovahHlb466tPHNILF1qHPXzskOWYSMsAwFjfRIjMlxTKmcc7/wXamDw7zkeMbRznSxed
         d4ooFPcMRut6GI93FgwTXVDd09LGtzbS3WXxmjYQxojCCm+/U3rLhZO/QF4tsjyanNI9
         7XSwLRSI9EG/G7Y0grXUbpYkJjZqqNXatP01qsuvqKUVow1BBqxZbg5wYZkjpNA0oJus
         fTKw==
X-Gm-Message-State: AC+VfDxYmw891EHdiroS6zIqLWxwQcE0SSp0afP0gIgr2LXgakv595eX
        xyB+v1z+PWeESqiWIM03/Mps6e24e4ZqIQ==
X-Google-Smtp-Source: ACHHUZ7JzvOFQR+ukn2MD6aNHYM4isXYR1FdTo7SOPd/4VRpdGln5aoc98L35o1D/kwBuvKsrTXr7py5mskPsQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:1003:b0:b8f:54f5:89ff with SMTP
 id w3-20020a056902100300b00b8f54f589ffmr2013735ybt.11.1682642505134; Thu, 27
 Apr 2023 17:41:45 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:41:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428004139.2899856-1-jiaqiyan@google.com>
Subject: [RFC PATCH v1 0/7] PAGE_SIZE Unmapping in Memory Failure Recovery for
 HugeTLB Pages
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     mike.kravetz@oracle.com, peterx@redhat.com, naoya.horiguchi@nec.com
Cc:     songmuchun@bytedance.com, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com,
        rientjes@google.com, linmiaohe@huawei.com, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goal
=3D=3D=3D=3D
Currently once a byte in a HugeTLB hugepage becomes HWPOISON, the whole
hugepage will be unmapped from the page table because that is the finest
granularity of the mapping.

High granularity mapping (HGM) [1], the functionality to map memory
addresses at finer granularities (extreme case is PAGE_SIZE), is recently
proposed upstream, and provides the opportunity to handle memory error more
efficiently: instead of unmapping the whole hugepage, only the raw subpage
in the hugepage needs to be thrown away and all the healthy
subpages can still be kept available for users.

Idea
=3D=3D=3D=3D
Today memory failure recovery for HugeTLB pages (hugepage) is different
from raw and THP pages. We are only interested in in-use hugepages, which i=
s
dealt with in these simplified steps:
1. Increment the refcount on the compound head of the hugepage.
2. Insert the raw HWPOISON page to the compound head=E2=80=99s raw_hwp_list
   (_hugetlb_hwpoison) if it is not already in the list.
3. Unmap the entire hugepage from HugeTLB=E2=80=99s page table.
4. Kill the processes that are accessing the poisoned hugepage.

HGM can greatly improve this recovery mechanism. Step #3 (unmapping
entire hugepage) can be replaced by
3.1 Map the entire hugepage at finer granularity, so that the exact
    HWPOISON address is mapped by a PAGE_SIZE PTE, and the rest of the
    address spaces optimally mapped by either smaller P*Ds or PTEs. In
    other words, the original HugeTLB PTE is split into smaller P*Ds
    and PTEs.
3.2 Only unmap the newly mapped PTE that maps the HWPOISON address.

For shared mappings, current HGM patches is already a solid basis for
splitting functionality in step #3.1. This RFC drafts a complete solution
for shared mapping. The splitting-based idea can be applied to private
mappings as well, but additional subtle complexity needs to be dealt with.
We defer the private mapping case as future work.

Splitting HugeTLB PTEs (Step #3.1)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
The general process of splitting a present leaf HugeTLB PTE is
1. Get and clear the original HugeTLB PTE old_pte.
2. Initialize curr with the start address range corresponding to old_pte.
3. Find the optimal level we should map curr at.
4. Perform HGM walk on curr with the optimal level found in step 3,
   potentially allocating a new PTE at the optimal level.
5. Populate the newly allocated PTE with bits from old_pte, including
   dirty, write, and UFFD_WP.
6. Update curr +=3D the newly created PTE size, repeat step 3 until the
   entire VMA is covered.

The functionality of splitting hugepage mapping is not meaningful for
mostly none PTEs. We handle none or userfaultfd write protect (UFFD_WP)
marker HugeTLB PTEs at the time of page faulting. Migration and HWPOISON
PTEs are better left not touched.

Memory Failure Recovery and Unmapping (Step #3.2)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
A few changes are made in memory_failure and rmap to only unmap raw
HWPOISON pages:
1. as long as HGM is turned on in CONFIG, memory_failure attempts to enable
   HGM on the VMA containing the poisoned hugepage
2. memory_failure attempts to split the HugeTLB PTE so that poisoned
   address is mapped by a PAGE_SIZE PTE, for all the VMAs containing the
   poisoned hugepage.
3. get_huge_page_for_hwpoison only returns -EHWPOISON if the raw page is
   already in the compound head=E2=80=99s raw_hwp_list. This makes unmappin=
g work
   correctly when multiple raw pages in the same hugepage become HWPOISON.
4. rmap utilizes compound head=E2=80=99s raw_hwp_list to 1) avoid unmapping=
 raw
   pages not in the list, and 2) keep track if the raw pages in the list
   are already unmapped.
5. page refcount check in me_huge_page is skipped.

Between mmap() and Page Fault
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Memory error can occur between the time when userspace maps a hugepage and
the time when userspace faults in the mapped hugepage. General idea is to
not create any raw-page-size page table entry for HWPOISON memory,
and render memory in healthy raw pages still available to userspace (via
normal fault handling). At the time of hugetlb_no_page:
- If the entire hugepage doesn=E2=80=99t contain any HWPOISON page, the nor=
mal
  page fault handler continues.
- If the memory address being faulted is within a HWPOISON raw page,
  hugetlb_no_page returns VM_FAULT_HWPOISON_LARGE (so that page fault
  handler sends a BUS_MCEERR_AR SIGBUS to the faulting process).
- If the memory address being faulted is within a healthy raw page,
  hugetlb_no_page utilize HGM to create a new HugeTLB PTE so that its
  hugetlb_pte_size cannot be larger and at the same time it doesn=E2=80=99t=
 map any
  HWPOISON address. Then the normal page fault handler continues.

Failure Handling
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- If the kernel still fails to allocate a new raw_hwp_page after a retry,
  memory_failure returns MF_IGNORED with MF_MSG_UNKNOWN.
- For each VMA that maps the HWPOISON hugepage
  - If the VMA is not eligible for HGM, the old behavior is taken: unmap
    the entire hugepage from that VMA.
  - If memory_failure fails to enable HGM on the VMA, or if memory_failure
    fails to split any VMA that mapped the HWPOISON page, the recovery
    returns MF_IGNORED with MF_MSG_UNMAP_FAILED.
- For a particular VMA, if splitting HugeTLB PTE fails, the original PTE
  will be restored to the page table.

Code Changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The code patches in this RFC is based on HGM patchset V2 [1], composed
of two parts. The first part implements the idea laid out in the cover
letter; the second part tests two major scenarios: HWPOISON on already
faulted pages and HWPOISON between mapped and faulted.

Future Changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
There is a pending improvement to hugetlbfs_read_iter. If a hugepage is
found from page cache and it contains HWPOISON subpages, today kernel
returns -EIO immediately. With the new splitting-then-unmap
behavior, kernel can return userspace every byte until up to the first
raw HWPOISON byte. If userspace wants the read to start within a raw
HWPOISON page, kernel will have to return -EIO. This improvement and its
selftest will be done in the future patch series.

[1] https://lore.kernel.org/all/20230218002819.1486479-1-jthoughton@google.=
com/

Jiaqi Yan (7):
  hugetlb: add HugeTLB splitting functionality
  hugetlb: create PTE level mapping when possible
  mm: publish raw_hwp_page in mm.h
  mm/memory_failure: unmap raw HWPoison PTEs when possible
  hugetlb: only VM_FAULT_HWPOISON_LARGE raw page
  selftest/mm: test PAGESIZE unmapping HWPOISON pages
  selftest/mm: test PAGESIZE unmapping UFFD WP marker HWPOISON pages

 include/linux/hugetlb.h                  |  14 +
 include/linux/mm.h                       |  36 ++
 mm/hugetlb.c                             | 405 ++++++++++++++++++++++-
 mm/memory-failure.c                      | 206 ++++++++++--
 mm/rmap.c                                |  38 ++-
 tools/testing/selftests/mm/hugetlb-hgm.c | 364 ++++++++++++++++++--
 6 files changed, 1004 insertions(+), 59 deletions(-)

--=20
2.40.1.495.gc816e09b53d-goog

