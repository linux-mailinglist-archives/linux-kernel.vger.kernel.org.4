Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7D61A322
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKDVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiKDVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:18:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE7A4E42E;
        Fri,  4 Nov 2022 14:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07959B82FBA;
        Fri,  4 Nov 2022 21:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931A6C433C1;
        Fri,  4 Nov 2022 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667596679;
        bh=8I4+rnkgR6yJdWQaRKdJfcBC47VAoHni2OhZ59TNW6Y=;
        h=Date:From:To:Cc:Subject:From;
        b=AMPwC8CpgWx+PpO7gTQqHxIWe+IGuWSh4lpjOJtz+i30lKo6jKA5MrSbq4Dxp8IAn
         NJS8CDd/Jzb5bnOAN6gqL5sdjCKXc+Ha+GqSPmCoEKo0AkoU4IttYyy0lil/LE14du
         kP3o8DBkOGipc/yqS5mlU/CmlyeF8J71OOlTLXNl4t2yPhy6gXbXZClbu9/DeqnOvY
         CHcPpm80kbrwabbfjiE6k/SASQaO50YBZ6ymxIkEoVPuOKLuHC8bM8XfMl/KF8puJe
         sa1ndj86mnvpIR/zTogNK7ZiDM2hY+FVENc0moDIG5ioHXLRvhhJSDzwxLk3Tw5HE7
         ZS/1yoM76TbKw==
Date:   Fri, 4 Nov 2022 14:17:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        allison.henderson@oracle.com, colin.i.king@gmail.com,
        guoxuenan@huawei.com, lizetao1@huawei.com, zengheng4@huawei.com
Subject: [GIT PULL] xfs: fixes for 6.1-rc4
Message-ID: <Y2WBh0NveQU+Wo25@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this rather large branch with fixes for xfs for 6.1-rc4.
Dave and I had thought that this would be a very quiet cycle, but we
thought wrong.

At first there were the usual trickle of minor bugfixes, but then Zorro
pulled -rc1 and noticed complaints about the stronger memcpy checks
w.r.t. flex arrays.  Analyzing how to fix that revealed a bunch of
validation gaps in validating ondisk log items during recovery, and then
a customer hit an infinite loop in the refcounting code on a corrupt
filesystem.

So.  This largeish batch of fixes addresses all those problems, I hope.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.1-fixes-4

for you to fetch changes up to 4eb559dd15671cca355a61a4164e8f19e3952637:

  Merge tag 'refcount-cow-domain-6.1_2022-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.1-fixesA (2022-11-01 09:52:13 -0700)

----------------------------------------------------------------
Bug fixes for 6.1-rc4:

- Fix a UAF bug during log recovery.
- Fix memory leaks when mount fails.
- Detect corrupt bestfree information in a directory block.
- Fix incorrect return value type for the dax page fault handlers.
- Fix fortify complaints about memcpy of xfs log item objects.
- Strengthen inadequate validation of recovered log items.
- Fix incorrectly declared flex array in EFI log item structs.
- Log corrupt log items for debugging purposes.
- Fix infinite loop problems in the refcount code if the refcount btree
  node block keys are corrupt.
- Fix infinite loop problems in the refcount code if the refcount btree
  records suffer MSB bitflips.
- Add more sanity checking to continued defer ops to prevent overflows
  from one AG to the next or off EOFS.

----------------------------------------------------------------
Allison Henderson (1):
      xfs: increase rename inode reservation

Colin Ian King (1):
      xfs: remove redundant pointer lip

Darrick J. Wong (25):
      xfs: avoid a UAF when log intent item recovery fails
      xfs: fix incorrect return type for fsdax fault handlers
      xfs: fix validation in attr log item recovery
      xfs: fix memcpy fortify errors in BUI log format copying
      xfs: fix memcpy fortify errors in CUI log format copying
      xfs: fix memcpy fortify errors in RUI log format copying
      xfs: make sure aglen never goes negative in xfs_refcount_adjust_extents
      xfs: fix memcpy fortify errors in EFI log format copying
      xfs: create a predicate to verify per-AG extents
      xfs: refactor all the EFI/EFD log item sizeof logic
      xfs: check deferred refcount op continuation parameters
      xfs: actually abort log recovery on corrupt intent-done log items
      xfs: move _irec structs to xfs_types.h
      xfs: dump corrupt recovered log intent items to dmesg consistently
      xfs: refactor refcount record usage in xchk_refcountbt_rec
      xfs: track cow/shared record domains explicitly in xfs_refcount_irec
      xfs: report refcount domain in tracepoints
      xfs: refactor domain and refcount checking
      xfs: remove XFS_FIND_RCEXT_SHARED and _COW
      xfs: check record domain when accessing refcount records
      xfs: fix agblocks check in the cow leftover recovery function
      xfs: fix uninitialized list head in struct xfs_refcount_recovery
      xfs: rename XFS_REFC_COW_START to _COWFLAG
      Merge tag 'fix-log-recovery-misuse-6.1_2022-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.1-fixes
      Merge tag 'refcount-cow-domain-6.1_2022-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.1-fixesA

Guo Xuenan (1):
      xfs: fix exception caused by unexpected illegal bestcount in leaf dir

Li Zetao (1):
      xfs: Fix unreferenced object reported by kmemleak in xfs_sysfs_init()

Zeng Heng (1):
      xfs: fix memory leak in xfs_errortag_init

 fs/xfs/libxfs/xfs_ag.h             |  15 ++
 fs/xfs/libxfs/xfs_alloc.c          |   6 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c      |   9 +-
 fs/xfs/libxfs/xfs_format.h         |  22 +--
 fs/xfs/libxfs/xfs_log_format.h     |  60 +++++++-
 fs/xfs/libxfs/xfs_refcount.c       | 286 ++++++++++++++++++++++++++-----------
 fs/xfs/libxfs/xfs_refcount.h       |  40 +++++-
 fs/xfs/libxfs/xfs_refcount_btree.c |  15 +-
 fs/xfs/libxfs/xfs_rmap.c           |   9 +-
 fs/xfs/libxfs/xfs_trans_resv.c     |   4 +-
 fs/xfs/libxfs/xfs_types.h          |  30 ++++
 fs/xfs/scrub/alloc.c               |   4 +-
 fs/xfs/scrub/ialloc.c              |   5 +-
 fs/xfs/scrub/refcount.c            |  72 ++++------
 fs/xfs/xfs_attr_item.c             |  67 +++++----
 fs/xfs/xfs_bmap_item.c             |  54 +++----
 fs/xfs/xfs_error.c                 |   9 +-
 fs/xfs/xfs_extfree_item.c          |  94 ++++++------
 fs/xfs/xfs_extfree_item.h          |  16 +++
 fs/xfs/xfs_file.c                  |   7 +-
 fs/xfs/xfs_inode.c                 |   2 +-
 fs/xfs/xfs_log_recover.c           |  10 +-
 fs/xfs/xfs_ondisk.h                |  23 ++-
 fs/xfs/xfs_refcount_item.c         |  57 ++++----
 fs/xfs/xfs_rmap_item.c             |  70 ++++-----
 fs/xfs/xfs_super.c                 |  12 +-
 fs/xfs/xfs_sysfs.h                 |   7 +-
 fs/xfs/xfs_trace.h                 |  48 +++++--
 fs/xfs/xfs_trans_ail.c             |   3 +-
 29 files changed, 670 insertions(+), 386 deletions(-)
