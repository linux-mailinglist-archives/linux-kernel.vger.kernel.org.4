Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69C5FA2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJJR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJJR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:27:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6627C74DDB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D397B8105C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAD7C433C1;
        Mon, 10 Oct 2022 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422828;
        bh=/lt8gfU9Y3wxLQTDMNaW8hT50rVcAlBaCz5iuLdDG9c=;
        h=Date:From:To:Cc:Subject:From;
        b=fPChqg/JUvc/VQr1cJLuF6NvniyAWrUrQMKS2Su4eiAT2u84Iqt1ZgVc47EUem+9x
         ocggm5+x16xob6OVX9H7+41KvzIynf2x9KcQxpLF1I8X9pIkpPfHLW0dUpvs5S+ys9
         +5/0WJmqGbAZ8ZlPNJjuaAg4v0XUWIiiSnaQZvjhA3syD2187CBYw+g5NmkXRxj1M1
         3GnQHrZKteoWJoYuwtiMjtH62LeB3ETZ/g0rTgaB7MSUOF29B6O2kEWlzHy8rOBGEp
         fJaGdaB9I58/iRSybpBrOq2y6EeyMjp6zL+KA0wOElBB/fyoAWqvS+6fdvjIh8BELS
         AEhRQdTlgy3Fg==
Date:   Mon, 10 Oct 2022 10:27:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 6.1-rc1
Message-ID: <Y0RV6kXCyXtqYuS4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit dcf8e5633e2e69ad60b730ab5905608b756a032f:

  tracing: Define the is_signed_type() macro once (2022-08-29 13:29:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.1-rc1

for you to fetch changes up to b4dac1203f39821c6119033cdeebcea83cf45786:

  f2fs: change to use atomic_t type form sbi.atomic_files (2022-10-07 12:57:26 -0700)

----------------------------------------------------------------
f2fs-for-6.1-rc1

This round looks fairly small comparing to the previous updates which includes
mostly minor bug fixes. Nevertheless, as we've still interested in improving
the stability, Chao added some debugging methods to diagnoze subtle runtime
inconsistency problem.

Enhancement
 - store all the corruption or failure reasons in superblock
 - detect meta inode, summary info, and block address inconsistency
 - increase the limit for reserve_root for low-end devices
 - add the number of compressed IO in iostat

Bug fix
 - DIO write fix for zoned devices
 - do out-of-place writes for cold files
 - fix some stat updates (FS_CP_DATA_IO, dirty page count)
 - fix race condition on setting FI_NO_EXTENT flag
 - fix data races when freezing super
 - fix wrong continue condition check in GC
 - do not allow ATGC for LFS mode

In addition, there're some code enhancement and clean-ups as usual.

----------------------------------------------------------------
Chao Yu (11):
      f2fs: iostat: support accounting compressed IO
      f2fs: remove gc_urgent_high_limited for cleanup
      f2fs: fix to do sanity check on destination blkaddr during recovery
      f2fs: fix to do sanity check on summary info
      f2fs: fix to account FS_CP_DATA_IO correctly
      f2fs: fix to detect corrupted meta ino
      f2fs: introduce cp_status sysfs entry
      f2fs: support recording stop_checkpoint reason into super_block
      f2fs: support recording errors into superblock
      f2fs: account swapfile inodes
      f2fs: change to use atomic_t type form sbi.atomic_files

Christian Brauner (1):
      f2fs: port to vfs{g,u}id_t and associated helpers

Eric Biggers (1):
      f2fs: use memcpy_{to,from}_page() where possible

Jaegeuk Kim (6):
      f2fs: LFS mode does not support ATGC
      f2fs: fix wrong continue condition in GC
      f2fs: flush pending checkpoints when freezing super
      f2fs: complete checkpoints during remount
      f2fs: increase the limit for reserve_root
      f2fs: allow direct read for zoned device

Shuqi Zhang (1):
      f2fs: fix wrong dirty page count when race between mmap and fallocate.

Weichao Guo (1):
      f2fs: let FI_OPU_WRITE override FADVISE_COLD_BIT

Yonggil Song (1):
      f2fs: fix typo

Zhang Qilong (10):
      f2fs: replace logical value "true" with a int number
      f2fs: simplify code in f2fs_prepare_decomp_mem
      f2fs: return the tmp_ptr directly in __bitmap_ptr
      f2fs: use COMPRESS_MAPPING to get compress cache mapping
      f2fs: add static init_idisk_time function to reduce the code
      f2fs: remove redundant check in f2fs_sanity_check_cluster
      f2fs: fix race condition on setting FI_NO_EXTENT flag
      f2fs: add "c_len" into trace_f2fs_update_extent_tree_range for compressed file
      f2fs: code clean and fix a type error
      f2fs: remove the unnecessary check in f2fs_xattr_fiemap

 Documentation/ABI/testing/sysfs-fs-f2fs | 24 +++++++++
 fs/f2fs/acl.c                           |  2 +-
 fs/f2fs/checkpoint.c                    | 65 +++++++++++++++-------
 fs/f2fs/compress.c                      | 32 +++++------
 fs/f2fs/data.c                          | 53 ++++++++++++------
 fs/f2fs/debug.c                         |  9 +++-
 fs/f2fs/dir.c                           |  1 +
 fs/f2fs/extent_cache.c                  |  9 ++--
 fs/f2fs/f2fs.h                          | 55 +++++++++++++++----
 fs/f2fs/file.c                          | 50 ++++++++++-------
 fs/f2fs/gc.c                            | 40 ++++++++------
 fs/f2fs/inline.c                        | 17 +++---
 fs/f2fs/inode.c                         | 51 ++++++++++++------
 fs/f2fs/iostat.c                        | 74 +++++++++++++++++--------
 fs/f2fs/iostat.h                        |  4 +-
 fs/f2fs/node.c                          |  9 ++--
 fs/f2fs/recovery.c                      | 29 ++++++++--
 fs/f2fs/segment.c                       | 37 ++++++++-----
 fs/f2fs/segment.h                       |  2 +
 fs/f2fs/super.c                         | 96 ++++++++++++++++++++++++++++-----
 fs/f2fs/sysfs.c                         |  9 +++-
 fs/f2fs/verity.c                        | 12 ++---
 fs/f2fs/xattr.c                         |  8 +++
 include/linux/f2fs_fs.h                 | 40 +++++++++++++-
 include/trace/events/f2fs.h             | 37 +++++++++----
 25 files changed, 556 insertions(+), 209 deletions(-)
