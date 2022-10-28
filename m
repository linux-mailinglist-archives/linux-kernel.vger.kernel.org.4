Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35B611C21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1VGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ1VGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF705D892;
        Fri, 28 Oct 2022 14:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FF4262A67;
        Fri, 28 Oct 2022 21:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F02CC433C1;
        Fri, 28 Oct 2022 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666991173;
        bh=6PP+KPOEl7R7Ogg6LhX8yLWmvxarnjy4i69rfPE0HFI=;
        h=Date:From:To:Cc:Subject:From;
        b=DKQqbJNhC6k7qHZ6Voy7DruOaf2tcAunarS0lHMnK93+Sgbn8lM5qgaGV3YwJWSqP
         6BLtId1jH+lOIvYdpwZVqq+r4XwzR6w9gJGrvVSNr43/NjDUq85wOKRNYEASpfbx43
         n3UYNx/Qa4XWRpEIsajf/0VcQKJzgXy7Bp552wLc=
Date:   Fri, 28 Oct 2022 14:06:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1-rc3
Message-Id: <20221028140612.43605c62db2ecc73f1bcf929@linux-foundation.org>
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


Linus, please merge this batch of hotfixes.

The following changes since commit 97061d441110528dc02972818f2f1dad485107f9:

  nouveau: fix migrate_to_ram() for faulting page (2022-10-20 21:27:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-10-28

for you to fetch changes up to dda1c41a07b4a4c3f99b5b28c1e8c485205fe860:

  mm: multi-gen LRU: move lru_gen_add_mm() out of IRQ-off region (2022-10-28 13:37:23 -0700)

----------------------------------------------------------------
23 hotfixes.

Eight fix pre-6.0 bugs and the remainder address issues which were
introduced in the 6.1-rc merge cycle, or address issues which aren't
considered sufficiently serious to warrant a -stable backport.

----------------------------------------------------------------
Alexander Potapenko (5):
      mm: kmsan: export kmsan_copy_page_meta()
      x86/purgatory: disable KMSAN instrumentation
      Kconfig.debug: disable CONFIG_FRAME_WARN for KMSAN by default
      x86: asm: make sure __put_user_size() evaluates pointer once
      x86: fortify: kmsan: fix KMSAN fortify builds

Andrew Morton (2):
      ipc/msg.c: fix percpu_counter use after free
      fs/ext4/super.c: remove unused `deprecated_msg'

Baolin Wang (1):
      mm: migrate: fix return value if all subpages of THPs are migrated successfully

Huang Ying (1):
      memory tier, sysfs: rename attribute "nodes" to "nodelist"

Hugh Dickins (1):
      mm: prep_compound_tail() clear page->private

Ira Weiny (2):
      mm/userfaultfd: replace kmap/kmap_atomic() with kmap_local_page()
      mm/shmem: ensure proper fallback if page faults

Liam Howlett (1):
      mmap: fix remap_file_pages() regression

Lukas Bulwahn (1):
      lib: maple_tree: remove unneeded initialization in mtree_range_walk()

Maria Yu (1):
      mm/page_isolation: fix clang deadcode warning

Palmer Dabbelt (1):
      MAINTAINERS: git://github.com -> https://github.com for nilfs2

Peter Xu (1):
      mm/uffd: fix vma check on userfault for wp

Phillip Lougher (3):
      squashfs: fix read regression introduced in readahead code
      squashfs: fix extending readahead beyond end of file
      squashfs: fix buffer release race condition in readahead code

Rik van Riel (1):
      mm,madvise,hugetlb: fix unexpected data loss with MADV_DONTNEED on hugetlbfs

Sebastian Andrzej Siewior (1):
      mm: multi-gen LRU: move lru_gen_add_mm() out of IRQ-off region

Waiman Long (1):
      mm/kmemleak: prevent soft lockup in kmemleak_scan()'s object iteration loops

 .../ABI/testing/sysfs-kernel-mm-memory-tiers       |  4 +-
 MAINTAINERS                                        |  2 +-
 arch/x86/include/asm/string_64.h                   | 11 ++--
 arch/x86/include/asm/uaccess.h                     | 13 ++---
 arch/x86/purgatory/Makefile                        |  1 +
 fs/exec.c                                          |  2 +-
 fs/ext4/super.c                                    |  4 --
 fs/squashfs/file.c                                 | 23 ++++----
 fs/squashfs/page_actor.c                           |  3 ++
 fs/squashfs/page_actor.h                           |  6 ++-
 include/linux/fortify-string.h                     | 17 +++++-
 include/linux/kmsan_string.h                       | 21 ++++++++
 include/linux/userfaultfd_k.h                      |  6 +--
 ipc/msg.c                                          |  4 +-
 lib/Kconfig.debug                                  |  3 +-
 lib/maple_tree.c                                   |  4 +-
 mm/huge_memory.c                                   |  2 +-
 mm/kmemleak.c                                      | 61 +++++++++++++++-------
 mm/kmsan/instrumentation.c                         |  1 +
 mm/kmsan/shadow.c                                  |  1 +
 mm/madvise.c                                       | 12 ++++-
 mm/memory-tiers.c                                  |  8 +--
 mm/migrate.c                                       |  7 +++
 mm/mmap.c                                          |  3 ++
 mm/page_alloc.c                                    |  1 +
 mm/page_isolation.c                                |  2 +-
 mm/shmem.c                                         | 17 ++++++
 mm/userfaultfd.c                                   | 25 +++++++--
 28 files changed, 196 insertions(+), 68 deletions(-)
 create mode 100644 include/linux/kmsan_string.h

