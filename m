Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723315FE8A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJNGD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJNGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:03:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27E19E92B;
        Thu, 13 Oct 2022 23:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FC77B8216A;
        Fri, 14 Oct 2022 06:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E751DC433D7;
        Fri, 14 Oct 2022 06:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665727383;
        bh=Sj0ADGiNe3/XsOSpd7wJHdWZ6tdgK0sm1kkalZ7RaSY=;
        h=Date:From:To:Cc:Subject:From;
        b=P9BG0Ck8iDe81L0WJ+YcLn9CxMR9gFyyW+s6iLJGOf4sH0/ypMrFTbr4LfizLM5cd
         mbmVSNSosjIZJIblJoy/A33gzMGbsllwIfhjD4hAFI5fwgHXXkdppbFL6fJnAvFufj
         iEsb9lLIie/w99bBfxxxbBWi+cuzuoV+evmX4efU=
Date:   Thu, 13 Oct 2022 23:03:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Final MM updates for 6.1-rc1
Message-Id: <20221013230302.96f2869cd26026b36e8ecd40@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this smallish batch of features and fixes.

There's a conflict in drivers/gpu/drm/amd/amdkfd/kfd_migrate.c. 
Stephen's resolution is at
https://lkml.kernel.org/r/20221004210029.7412fcfd@canb.auug.org.au

Thanks.


The following changes since commit bbff39cc6cbcb86ccfacb2dcafc79912a9f9df69:

  hugetlb: allocate vma lock for all sharable vmas (2022-10-07 14:28:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-10-13

for you to fetch changes up to ef6e06b2ef87077104d1145a0fd452ff8dbbc4b7:

  highmem: fix kmap_to_page() for kmap_local_page() addresses (2022-10-12 18:51:51 -0700)

----------------------------------------------------------------
- Alistair Popple has a series which addresses a race which causes page
  refcounting errors in ZONE_DEVICE pages.

- Peter Xu fixes some userfaultfd test harness instability.

- Various other patches in MM, mainly fixes.

----------------------------------------------------------------
Alexander Potapenko (1):
      kmsan: unpoison @tlb in arch_tlb_gather_mmu()

Alexey Dobriyan (1):
      mm: more vma cache removal

Alistair Popple (8):
      mm/memory.c: fix race when faulting a device private page
      mm: free device private pages have zero refcount
      mm/memremap.c: take a pgmap reference on page allocation
      mm/migrate_device.c: refactor migrate_vma and migrate_deivce_coherent_page()
      mm/migrate_device.c: add migrate_device_range()
      nouveau/dmem: refactor nouveau_dmem_fault_copy_one()
      nouveau/dmem: evict device private memory during release
      hmm-tests: add test for migrate_device_range()

Andrew Morton (1):
      mm/hugetlb.c: make __hugetlb_vma_unlock_write_put() static

Andrey Konovalov (1):
      kasan: fix array-bounds warnings in tests

Brian Geffon (1):
      zram: always expose rw_page

Carlos Llamas (1):
      mm/mmap: undo ->mmap() when arch_validate_flags() fails

Chuyi Zhou (1):
      mm/compaction: fix set skip in fast_find_migrateblock

Ira Weiny (1):
      highmem: fix kmap_to_page() for kmap_local_page() addresses

Liam Howlett (2):
      mmap: fix copy_vma() failure path
      mm/mmap: preallocate maple nodes for brk vma expansion

Matthew Wilcox (Oracle) (1):
      ext4,f2fs: fix readahead of verity data

Peter Xu (4):
      mm/uffd: fix warning without PTE_MARKER_UFFD_WP compiled in
      mm/hugetlb: fix race condition of uffd missing/minor handling
      mm/hugetlb: use hugetlb_pte_stable in migration race check
      mm/selftest: uffd: explain the write missing fault check

Qi Zheng (2):
      mm: use update_mmu_tlb() on the second thread
      LoongArch: update local TLB if PTE entry exists

Xiaoke Wang (1):
      lib/test_meminit: add checks for the allocation functions

Xin Hao (2):
      mm/damon: move sz_damon_region to damon_sz_region
      mm/damon: use damon_sz_region() in appropriate place

Yafang Shao (1):
      mm/page_alloc: fix incorrect PGFREE and PGALLOC for high-order page

 arch/loongarch/include/asm/pgtable.h     |   3 +
 arch/powerpc/kvm/book3s_hv_uvmem.c       |  21 +--
 drivers/block/zram/zram_drv.c            |  26 +---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  19 +--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  11 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c   | 108 ++++++++++----
 fs/ext4/verity.c                         |   3 +-
 fs/f2fs/verity.c                         |   3 +-
 include/linux/damon.h                    |   6 +
 include/linux/memremap.h                 |   1 +
 include/linux/migrate.h                  |  15 ++
 include/linux/sched.h                    |   2 -
 lib/test_hmm.c                           | 129 +++++++++++++----
 lib/test_hmm_uapi.h                      |   1 +
 lib/test_meminit.c                       |  21 +++
 mm/compaction.c                          |   1 -
 mm/damon/core.c                          |  26 ++--
 mm/damon/vaddr.c                         |   4 +-
 mm/highmem.c                             |  43 ++++--
 mm/hugetlb.c                             |  72 ++++++++--
 mm/kasan/kasan_test.c                    |   9 +-
 mm/memory.c                              |  20 ++-
 mm/memremap.c                            |  30 +++-
 mm/migrate.c                             |  34 +++--
 mm/migrate_device.c                      | 239 ++++++++++++++++++++++---------
 mm/mmap.c                                |  28 ++--
 mm/mmu_gather.c                          |  10 ++
 mm/mprotect.c                            |   2 +
 mm/page_alloc.c                          |  12 +-
 tools/testing/selftests/vm/hmm-tests.c   |  49 +++++++
 tools/testing/selftests/vm/userfaultfd.c |  22 ++-
 32 files changed, 719 insertions(+), 253 deletions(-)

