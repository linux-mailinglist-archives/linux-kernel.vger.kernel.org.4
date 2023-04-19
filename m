Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DC6E85FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjDSXia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSXi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814B83C1F;
        Wed, 19 Apr 2023 16:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C4C363AA2;
        Wed, 19 Apr 2023 23:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56533C433D2;
        Wed, 19 Apr 2023 23:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681947504;
        bh=49c6xstQR0fmW0wZyfHNP2+gyOY0P2s/L9lvvrMl6OQ=;
        h=Date:From:To:Cc:Subject:From;
        b=CmO1u/T6vhfzhVOuUFVKAFl6eUmrJj/0kxo0bUFAwInSxszmn1T4kgaHIYFPBF0FQ
         GD/4reKCNKe1OIAeFgXGHNAzZb5JQkznteZ8hRB2D50ZWp73e2NWP2rhtF1WOJRh30
         8G05z8i6PeIRKHGAl1rTVfKKkvmqmL8WPXyk8Ge4=
Date:   Wed, 19 Apr 2023 16:38:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.3
Message-Id: <20230419163823.f2a0f64f0ef67ddee54c2461@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

please merge this batch of hotfixes for mm/ and for other parts of the
kernel, thanks.



The following changes since commit c45ea315a602d45569b08b93e9ab30f6a63a38aa:

  maple_tree: fix a potential concurrency bug in RCU mode (2023-04-05 18:06:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-04-19-16-36

for you to fetch changes up to ef832747a82dfbc22a3702219cc716f449b24e4a:

  nilfs2: initialize unused bytes in segment summary blocks (2023-04-18 14:22:14 -0700)

----------------------------------------------------------------
22 hotfixes.

19 are cc:stable and the remainder address issues which were introduced
during this merge cycle, or aren't considered suitable for -stable
backporting.

19 are for MM and the remainder are for other subsystems.

----------------------------------------------------------------
Alexander Potapenko (2):
      mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
      mm: kmsan: handle alloc failures in kmsan_ioremap_page_range()

Baokun Li (1):
      writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs

David Hildenbrand (1):
      mm/userfaultfd: fix uffd-wp handling for THP migration entries

Jonathan Toppins (1):
      mailmap: update jtoppins' entry to reference correct email

Liam R. Howlett (5):
      mm/mprotect: fix do_mprotect_pkey() return on error
      mm/mempolicy: fix use-after-free of VMA iterator
      maple_tree: make maple state reusable after mas_empty_area_rev()
      maple_tree: fix mas_empty_area() search
      mm/mmap: regression fix for unmapped_area{_topdown}

Mathieu Desnoyers (1):
      mm: fix memory leak on mm_init error handling

Mel Gorman (1):
      mm: page_alloc: skip regions with hugetlbfs pages when allocating 1G pages

Naoya Horiguchi (1):
      mm/huge_memory.c: warn with pr_warn_ratelimited instead of VM_WARN_ON_ONCE_FOLIO

Ondrej Mosnacek (1):
      kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()

Peng Zhang (1):
      maple_tree: fix a potential memory leak, OOB access, or other unpredictable bug

Peter Xu (2):
      mm/khugepaged: check again on anon uffd-wp during isolation
      Revert "userfaultfd: don't fail on unrecognized features"

Qi Zheng (1):
      mm: swap: fix performance regression on sparsetruncate-tiny

Ryusuke Konishi (1):
      nilfs2: initialize unused bytes in segment summary blocks

SeongJae Park (1):
      tools/Makefile: do missed s/vm/mm/

Steve Chou (1):
      tools/mm/page_owner_sort.c: fix TGID output when cull=tg is used

Tetsuo Handa (1):
      mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock

 .mailmap                   |   2 +
 fs/fs-writeback.c          |  17 +++++---
 fs/nilfs2/segment.c        |  20 +++++++++
 fs/userfaultfd.c           |   6 ++-
 include/linux/kmsan.h      |  39 +++++++++--------
 kernel/fork.c              |   1 +
 kernel/sys.c               |  69 +++++++++++++++++-------------
 lib/maple_tree.c           |  66 ++++++++++++++--------------
 mm/backing-dev.c           |  12 +++++-
 mm/huge_memory.c           |  19 +++++++--
 mm/khugepaged.c            |   4 ++
 mm/kmsan/hooks.c           |  55 ++++++++++++++++++++----
 mm/kmsan/shadow.c          |  27 ++++++++----
 mm/mempolicy.c             | 104 +++++++++++++++++++++------------------------
 mm/mmap.c                  |  48 ++++++++++++++++++---
 mm/mprotect.c              |   2 +-
 mm/page_alloc.c            |  19 +++++++++
 mm/swap.c                  |   2 +-
 mm/vmalloc.c               |  10 +++--
 tools/Makefile             |  14 +++---
 tools/mm/page_owner_sort.c |   2 +-
 21 files changed, 351 insertions(+), 187 deletions(-)

