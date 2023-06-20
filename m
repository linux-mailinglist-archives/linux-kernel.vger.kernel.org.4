Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF9B73752D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFTTid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFTTib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77644E7D;
        Tue, 20 Jun 2023 12:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AA9960F85;
        Tue, 20 Jun 2023 19:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C18C433C8;
        Tue, 20 Jun 2023 19:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687289909;
        bh=MMluyfwA1vD8Mi/bjHxE0Sq0bwvjuec9WKzPP/4G8B8=;
        h=Date:From:To:Cc:Subject:From;
        b=v4aSTvcVr+uM2h/Zrc+wiaTGrFuUhBhUccPLCwcRpN7Hyz2EOr2ZmTXLs6ctoaKT6
         E3bAyNxz0zFZCg+UunfyxW7IyEAqTyW3q9Oc4sby5ThdH96Kdx7mp0LZMl5sNLxR8T
         XW7IluujfnJ79oMMggVYZLt7Z5Ip/SInCGtOUAYQ=
Date:   Tue, 20 Jun 2023 12:38:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes against 6.4-rc7
Message-Id: <20230620123828.813b1140d9c13af900e8edb3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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


Linus, please merge this batch of hotfixes, thanks.



The following changes since commit 0bdf0efa180a9cb1361cbded4e2260a49306ac89:

  zswap: do not shrink if cgroup may not zswap (2023-06-12 11:31:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-06-20-12-31

for you to fetch changes up to 0518dbe97fe629fea255318841cf3ef1b4532d66:

  selftests/mm: fix cross compilation with LLVM (2023-06-19 13:19:35 -0700)

----------------------------------------------------------------
19 hotfixes.  8 of these are cc:stable.

This includes a wholesale reversion of the post-6.4 series "make slab shrink
lockless".  After input from Dave Chinner it has been decided that we
should go a different way.  Thread starts at
https://lkml.kernel.org/r/ZH6K0McWBeCjaf16@dread.disaster.area.

----------------------------------------------------------------
Ben Dooks (1):
      mailmap: add entries for Ben Dooks

David Stevens (1):
      mm/khugepaged: fix iteration in collapse_file

Florian Fainelli (1):
      scripts/gdb: fix SB_* constants parsing

Liam R. Howlett (1):
      mm/mprotect: fix do_mprotect_pkey() limit check

Lorenzo Stoakes (1):
      mm/vmalloc: do not output a spurious warning when huge vmalloc() fails

Mark Brown (1):
      selftests/mm: fix cross compilation with LLVM

Mike Kravetz (1):
      udmabuf: revert 'Add support for mapping hugepages (v4)'

Prathu Baronia (1):
      scripts: fix the gfp flags header path in gfp-translate

Qi Zheng (7):
      Revert "mm: shrinkers: convert shrinker_rwsem to mutex"
      Revert "mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()"
      Revert "mm: vmscan: hold write lock to reparent shrinker nr_deferred"
      Revert "mm: shrinkers: make count and scan in shrinker debugfs lockless"
      Revert "mm: vmscan: add shrinker_srcu_generation"
      Revert "mm: vmscan: make memcg slab shrink lockless"
      Revert "mm: vmscan: make global slab shrink lockless"

Rafael Aquini (1):
      writeback: fix dereferencing NULL mapping->host on writeback_page_template

Roberto Sassu (1):
      memfd: check for non-NULL file_seals in memfd_create() syscall

Ryusuke Konishi (2):
      nilfs2: fix buffer corruption due to concurrent device reads
      nilfs2: prevent general protection fault in nilfs_clear_dirty_page()

 .mailmap                            |   2 +
 drivers/dma-buf/udmabuf.c           |  47 ++------------
 drivers/md/dm-cache-metadata.c      |   2 +-
 drivers/md/dm-thin-metadata.c       |   2 +-
 fs/nilfs2/page.c                    |  10 ++-
 fs/nilfs2/segbuf.c                  |   6 ++
 fs/nilfs2/segment.c                 |   7 ++
 fs/nilfs2/super.c                   |  23 ++++++-
 fs/super.c                          |   2 +-
 include/trace/events/writeback.h    |   2 +-
 mm/khugepaged.c                     |   1 -
 mm/memfd.c                          |   9 ++-
 mm/mprotect.c                       |   2 +-
 mm/shrinker_debug.c                 |  39 ++++++-----
 mm/vmalloc.c                        |  17 +++--
 mm/vmscan.c                         | 125 ++++++++++++++++--------------------
 scripts/gdb/linux/constants.py.in   |  12 ++--
 scripts/gfp-translate               |   6 +-
 tools/testing/selftests/mm/Makefile |  13 ++--
 19 files changed, 172 insertions(+), 155 deletions(-)

