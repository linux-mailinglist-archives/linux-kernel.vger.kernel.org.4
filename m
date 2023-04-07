Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EC6DB723
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDGX0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDGX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907FCC03;
        Fri,  7 Apr 2023 16:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6353E65296;
        Fri,  7 Apr 2023 23:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B74C433D2;
        Fri,  7 Apr 2023 23:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680909966;
        bh=dxn2vRSMifVPSaf3gd7lvky94H+Q3N4xYyyrkuKKcLM=;
        h=Date:From:To:Cc:Subject:From;
        b=PJ/I30k44nvfA5NBDQKlNIQiNxjPlI7WegcpxXQQJOx9HMsDaMU3h8zApzlBiE8pz
         RFq6CM8lefomd1TMwQUOXwEhYU/NRlfLfkuYjtGuuuZPrspdXPsqe/6uelVHuCH86I
         EZnsvj8a4Us4jYBJktUXq2+UF7XPaY7Nux5lSL7I=
Date:   Fri, 7 Apr 2023 16:26:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.3-rc6
Message-Id: <20230407162606.d7dd8c829b53a01f7c9f16d6@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge another batch of hotfixes, thanks.


The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-st=
able-2023-04-07-16-23

for you to fetch changes up to c45ea315a602d45569b08b93e9ab30f6a63a38aa:

  maple_tree: fix a potential concurrency bug in RCU mode (2023-04-05 18:06=
:25 -0700)

----------------------------------------------------------------
28 hotfixes.

23 are cc:stable and the other 5 address issues which were introduced
during this merge cycle.

20 are for MM and the remainder are for other subsystems.

----------------------------------------------------------------
Alistair Popple (1):
      mm: take a page reference when removing device exclusive entries

Florian Fainelli (1):
      mailmap: add an entry for Leonard Crestez

Leonard G=F6hrs (1):
      .mailmap: add entry for Leonard G=F6hrs

Liam Howlett (4):
      maple_tree: be more cautious about dead nodes
      maple_tree: detect dead nodes in mas_start()
      maple_tree: fix freeing of nodes in rcu mode
      maple_tree: remove extra smp_wmb() from mas_dead_leaves()

Liam R. Howlett (4):
      maple_tree: fix write memory barrier of nodes once dead for RCU mode
      maple_tree: add smp_rmb() to dead node detection
      maple_tree: add RCU lock checking to rcu callback functions
      mm: enable maple tree RCU mode by default

Muchun Song (2):
      mm: kfence: fix PG_slab and memcg_data clearing
      mm: kfence: fix handling discontiguous page

Peng Zhang (2):
      maple_tree: fix get wrong data_end in mtree_lookup_walk()
      maple_tree: fix a potential concurrency bug in RCU mode

Peter Xu (1):
      mm/hugetlb: fix uffd wr-protection for CoW optimization path

Rongwei Wang (1):
      mm/swap: fix swap_info_struct race between swapoff and get_swap_pages=
()

Ryusuke Konishi (2):
      nilfs2: fix potential UAF of struct nilfs_sc_info in nilfs_segctor_th=
read()
      nilfs2: fix sysfs interface lifetime

Sergey Senozhatsky (2):
      zsmalloc: document new fullness grouping
      zsmalloc: document freeable stats

Shiyang Ruan (3):
      fsdax: unshare: zero destination if srcmap is HOLE or UNWRITTEN
      fsdax: dedupe should compare the min of two iters' length
      fsdax: force clear dirty mark if CoW

Tetsuo Handa (1):
      nilfs2: initialize "struct nilfs_binfo_dat"->bi_pad field

Tiezhu Yang (1):
      lib/Kconfig.debug: correct help info of LOCKDEP_STACK_TRACE_HASH_BITS

Yafang Shao (1):
      mm: vmalloc: avoid warn_alloc noise caused by fatal signal

ye xingchen (1):
      Kconfig.debug: fix SCHED_DEBUG dependency

 .mailmap                         |   2 +
 Documentation/mm/zsmalloc.rst    | 135 ++++++++++--------
 fs/dax.c                         |  52 ++++++-
 fs/nilfs2/btree.c                |   1 +
 fs/nilfs2/direct.c               |   1 +
 fs/nilfs2/segment.c              |   3 +-
 fs/nilfs2/super.c                |   2 +
 fs/nilfs2/the_nilfs.c            |  12 +-
 include/linux/mm_types.h         |   3 +-
 kernel/fork.c                    |   3 +
 lib/Kconfig.debug                |   4 +-
 lib/maple_tree.c                 | 287 ++++++++++++++++++++++++++---------=
----
 mm/hugetlb.c                     |  14 +-
 mm/kfence/core.c                 |  32 ++---
 mm/memory.c                      |  16 ++-
 mm/mmap.c                        |   3 +-
 mm/swapfile.c                    |   3 +-
 mm/vmalloc.c                     |   8 +-
 tools/testing/radix-tree/maple.c |  16 +++
 19 files changed, 402 insertions(+), 195 deletions(-)

