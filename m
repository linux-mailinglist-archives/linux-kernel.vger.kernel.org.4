Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65159626628
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiKLBMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiKLBMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:12:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F03E083;
        Fri, 11 Nov 2022 17:12:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F208662072;
        Sat, 12 Nov 2022 01:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310E4C433C1;
        Sat, 12 Nov 2022 01:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668215523;
        bh=5P/vkTNNFYnVUsCFF39aI25rT70+cTZdi40D+jKi23M=;
        h=Date:From:To:Cc:Subject:From;
        b=u4vKfhgCvN/w6LJuS2YUYYhBQ6RBcfR1z7zw2L10S0NdfdcnrqC/EkfASjQPYEG4H
         BQzCKZFQ1zoBJjdg9o2HfT3uFLtgqypTUhDyfQEeLgxEVs061qmJIm+JZgIKuybf+L
         oNbRXfnTHb0VZBk1eedIQUHSn2CPQuticaDm4xcM=
Date:   Fri, 11 Nov 2022 17:12:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1-rc5
Message-Id: <20221111171202.b8b7ff671c97cb9782ad8e78@linux-foundation.org>
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

Thanks.

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-11-11

for you to fetch changes up to 436fa4a699bcd1c368bea9199e22b0a1b9cf9e0f:

  docs: kmsan: fix formatting of "Example report" (2022-11-08 15:57:25 -0800)

----------------------------------------------------------------
22 hotfixes.  8 are cc:stable and the remainder address issues which were
introduced post-6.0 or which aren't considered serious enough to justify a
-stable backport.

----------------------------------------------------------------
Alexander Potapenko (6):
      kmsan: core: kmsan_in_runtime() should return true in NMI context
      x86/uaccess: instrument copy_from_user_nmi()
      Kconfig.debug: ensure early check for KMSAN in CONFIG_KMSAN_WARN
      kmsan: make sure PREEMPT_RT is off
      x86/traps: avoid KMSAN bugs originating from handle_bug()
      docs: kmsan: fix formatting of "Example report"

James Houghton (1):
      hugetlbfs: don't delete error page from pagecache

Johannes Weiner (1):
      fs: fix leaked psi pressure state

Li Zetao (1):
      mm/mmap: fix memory leak in mmap_region()

Liam Howlett (5):
      maple_tree: remove pointer to pointer use in mas_alloc_nodes()
      maple_tree: mas_anode_descend() clang-analyzer cleanup
      maple_tree: reorganize testing to restore module testing
      maple_tree: fix depth tracking in maple_state
      maple_tree: don't set a new maximum on the node when not reusing nodes

Naoya Horiguchi (1):
      arch/x86/mm/hugetlbpage.c: pud_huge() returns 0 when using 2-level paging

Pankaj Gupta (1):
      mm/memremap.c: map FS_DAX device memory as decrypted

Peter Xu (2):
      Partly revert "mm/thp: carry over dirty bit when thp splits on pmd"
      mm/shmem: use page_mapping() to detect page cache for uffd continue

Ryusuke Konishi (2):
      nilfs2: fix deadlock in nilfs_count_free_blocks()
      nilfs2: fix use-after-free bug of ns_writer on remount

SeongJae Park (1):
      mm/damon/dbgfs: check if rm_contexts input is for a real context

Vasily Gorbik (1):
      mm: hugetlb_vmemmap: include missing linux/moduleparam.h

 Documentation/dev-tools/kmsan.rst             |     1 +
 arch/x86/kernel/traps.c                       |     7 +
 arch/x86/lib/usercopy.c                       |     3 +
 arch/x86/mm/hugetlbpage.c                     |     4 +
 fs/btrfs/compression.c                        |    14 +-
 fs/erofs/zdata.c                              |    18 +-
 fs/hugetlbfs/inode.c                          |    13 +-
 fs/nilfs2/segment.c                           |    15 +-
 fs/nilfs2/super.c                             |     2 -
 fs/nilfs2/the_nilfs.c                         |     2 -
 include/linux/maple_tree.h                    |     7 +
 lib/Kconfig.debug                             |     6 +-
 lib/Kconfig.kmsan                             |     1 +
 lib/Makefile                                  |     1 +
 lib/maple_tree.c                              |    58 +-
 lib/test_maple_tree.c                         | 37926 +-----------------------
 mm/damon/dbgfs.c                              |     7 +
 mm/huge_memory.c                              |     9 +-
 mm/hugetlb.c                                  |     4 +
 mm/hugetlb_vmemmap.c                          |     1 +
 mm/kmsan/kmsan.h                              |     2 +
 mm/memory-failure.c                           |     5 +-
 mm/memremap.c                                 |     1 +
 mm/mmap.c                                     |     6 +-
 mm/userfaultfd.c                              |     2 +-
 tools/testing/radix-tree/.gitignore           |     1 +
 tools/testing/radix-tree/Makefile             |    19 +-
 tools/testing/radix-tree/generated/autoconf.h |     2 +-
 tools/testing/radix-tree/linux.c              |     4 +
 tools/testing/radix-tree/maple.c              | 35770 ++++++++++++++++++++++
 30 files changed, 37118 insertions(+), 36793 deletions(-)

