Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E676EE78E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjDYSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDYSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79FFC173
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5001B6299D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945E9C433D2;
        Tue, 25 Apr 2023 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682447770;
        bh=ai2eDZjdIlPTRpRxYqniC77LrA1HSD9tpG1QN3G8gqM=;
        h=Date:From:To:Cc:Subject:From;
        b=j4xE6o/nI2Mfq6F/NdSzxq/dl6Y23ATp1ZY7dQtg97i5EvsNQb7nj8tsk9QCLZlXj
         iepyd9QP6jDPa18XgKlMSiSrF8Ty+k74baIKaK/Z4s/D2b5kczG+UA/NHiXKlFVGZS
         kVBe0kNKmakJpRuPmVpagyRf+FcoPZE8jPd0x+PkT5nCMrtZTMwnfCJ3qEsY+xhW0U
         fcDfOL2Vus59sVjDi7+b52cIygpjxsRxdvHUGKvochF/D9jsjWqSifra8W7QzMZ54s
         rZODztOP7DLDxdRdvm0E+MfrbcuCkWFqGQCG6bIJn9QklI6VVuJvBSe5ZsKZGKNv6I
         2sAbs801+uiZA==
Date:   Tue, 25 Apr 2023 11:36:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs update for 6.4
Message-ID: <ZEgdmJWhJX9NJ0fG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit ffe78bbd512166e0ef1cc4858010b128c510ed7d:

  Merge tag 'xtensa-20230327' of https://github.com/jcmvbkbc/linux-xtensa (2023-03-29 10:24:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.4-rc1

for you to fetch changes up to 8375be2b6414577487486a92995bdc97a7934033:

  f2fs: remove unnessary comment in __may_age_extent_tree (2023-04-24 11:03:10 -0700)

----------------------------------------------------------------
f2fs update for 6.4-rc1

In this round, we've mainly modified to support non-power-of-two zone size,
which is not required for f2fs by design. In order to avoid arch dependency,
we refactored the messy rb_entry structure shared across different extent_cache.
In addition to the improvement, we've also fixed several subtle bugs and
error cases.

Enhancement:
- support non-power-of-two zone size for zoned device
- remove sharing the rb_entry structure in extent cache
- refactor f2fs_gc to call checkpoint in urgent condition
- support iopoll

Bug fix:
- fix potential corruption when moving a directory
- fix to avoid use-after-free for cached IPU bio
- fix the folio private usage
- avoid kernel warnings or panics in the cp_error case
- fix to recover quota data correctly
- fix some bugs in atomic operations
- fix system crash due to lack of free space in LFS
- fix null pointer panic in tracepoint in __replace_atomic_write_block
- fix iostat lock protection
- fix scheduling while atomic in decompression path
- preserve direct write semantics when buffering is forced
- fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()

----------------------------------------------------------------
Chao Yu (10):
      f2fs: use f2fs_hw_is_readonly() instead of bdev_read_only()
      f2fs: remove unneeded in-memory i_crtime copy
      f2fs: fix to avoid use-after-free for cached IPU bio
      f2fs: fix to drop all dirty pages during umount() if cp_error is set
      f2fs: fix to keep consistent i_gc_rwsem lock order
      f2fs: fix to check readonly condition correctly
      f2fs: fix to recover quota data correctly
      f2fs: fix to check return value of f2fs_do_truncate_blocks()
      f2fs: fix to check return value of inc_valid_block_count()
      f2fs: remove folio_detach_private() in .invalidate_folio and .release_folio

Daeho Jeong (3):
      f2fs: fix passing relative address when discard zones
      f2fs: use cow inode data when updating atomic write
      f2fs: allocate node blocks for atomic write block replacement

Hans Holmberg (1):
      f2fs: preserve direct write semantics when buffering is forced

Jaegeuk Kim (10):
      f2fs: factor out victim_entry usage from general rb_tree use
      f2fs: factor out discard_cmd usage from general rb_tree use
      f2fs: remove entire rb_entry sharing
      f2fs: apply zone capacity to all zone type
      f2fs: fix scheduling while atomic in decompression path
      f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
      f2fs: fix potential corruption when moving a directory
      f2fs: refactor f2fs_gc to call checkpoint in urgent condition
      f2fs: relax sanity check if checkpoint is corrupted
      f2fs: remove power-of-two limitation of zoned device

Li Zetao (1):
      f2fs: make f2fs_sync_inode_meta() static

Qi Han (1):
      f2fs: remove unnessary comment in __may_age_extent_tree

Qilin Tan (1):
      f2fs: fix iostat lock protection

Wang Han (1):
      docs: f2fs: Correct instruction to disable checkpoint

Weizhao Ouyang (1):
      f2fs: use common implementation of file type

Wu Bo (2):
      f2fs: support iopoll method
      f2fs: allocate trace path buffer from names_cache

Yangtao Li (16):
      f2fs: export compress_percent and compress_watermark entries
      f2fs: convert to use bitmap API
      f2fs: handle dqget error in f2fs_transfer_project_quota()
      f2fs: convert to MAX_SBI_FLAG instead of 32 in stat_show()
      f2fs: fix to handle filemap_fdatawrite() error in f2fs_ioc_decompress_file/f2fs_ioc_compress_file
      f2fs: remove else in f2fs_write_cache_pages()
      f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
      f2fs: convert is_extension_exist() to return bool type
      f2fs: add compression feature check for all compress mount opt
      f2fs: remove struct victim_selection default_v_ops
      f2fs: set default compress option only when sb_has_compression
      f2fs: convert to use sysfs_emit
      f2fs: merge lz4hc_compress_pages() to lz4_compress_pages()
      f2fs: remove batched_trim_sections node description
      f2fs: remove bulk remove_proc_entry() and unnecessary kobject_del()
      f2fs: add has_enough_free_secs()

Yohan Joung (2):
      f2fs: fix align check for npo2
      f2fs: add radix_tree_preload_end in error case

Yonggil Song (3):
      f2fs: fix uninitialized skipped_gc_rwsem
      f2fs: Fix discard bug on zoned block devices with 2MiB zone size
      f2fs: Fix system crash due to lack of free space in LFS

 Documentation/ABI/testing/sysfs-fs-f2fs |  23 +-
 Documentation/filesystems/f2fs.rst      |   2 +-
 fs/f2fs/checkpoint.c                    |  52 ++---
 fs/f2fs/compress.c                      |  47 ++--
 fs/f2fs/data.c                          |  71 +++---
 fs/f2fs/debug.c                         |  37 +--
 fs/f2fs/dir.c                           |  47 +---
 fs/f2fs/extent_cache.c                  | 264 +++++++--------------
 fs/f2fs/f2fs.h                          | 252 ++++++++++-----------
 fs/f2fs/file.c                          |  76 +++++--
 fs/f2fs/gc.c                            | 205 ++++++++++-------
 fs/f2fs/gc.h                            |  16 +-
 fs/f2fs/inline.c                        |   2 +-
 fs/f2fs/inode.c                         |   5 +-
 fs/f2fs/namei.c                         |  28 ++-
 fs/f2fs/node.h                          |  20 +-
 fs/f2fs/recovery.c                      |  17 +-
 fs/f2fs/segment.c                       | 390 +++++++++++++++++---------------
 fs/f2fs/segment.h                       |  57 +++--
 fs/f2fs/super.c                         | 111 +++++++--
 fs/f2fs/sysfs.c                         |  50 ++--
 include/linux/f2fs_fs.h                 |  24 +-
 22 files changed, 899 insertions(+), 897 deletions(-)
