Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3736EC43B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDXEEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7D211D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 21:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D09C60BFA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1422C433D2;
        Mon, 24 Apr 2023 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682309083;
        bh=U/3SF7+X/eFkEkXNYW+s4uskx23QWRNZm3A7thW+KFo=;
        h=Date:From:To:Cc:Subject:From;
        b=Jy/Ot8Krn1epjJ6ZyGSPcCVMsydZ7uZo7RTZJsFljEt1DrlfNznSKj0AMKbP0TBQ4
         nOa+t+nfI6XxKP19E84n6wt3VMjqBI3i0POAMbayLY1JmcD0aI5AoO7TP0O7XnhbgP
         c+IX6ifR608t6GgiaxcN0AJi8QdWSZPG3t0YKuCJCWJpH2gkiCg3obfDs7A9SZXsX0
         a9MeAyjJByW45H3hCLtGL0y6Jjhu07Mm00G5W7mc3QOPcjYjtQ8bcf+3KL3jVXdidV
         GL3ek/waKQOBQw0F4FedKTLh/OdhCTrssLjciEfVorIyOX+iF5cpyRihGVTQyOsQFn
         fXnHUj0agBtNQ==
Date:   Mon, 24 Apr 2023 12:04:38 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, Jia Zhu <zhujia.zj@bytedance.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [GIT PULL] erofs updates for 6.4-rc1
Message-ID: <ZEX/1kWqrA8pU/g5@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, Jia Zhu <zhujia.zj@bytedance.com>,
        Christian Brauner <brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 6.4-rc1?

In this cycle, sub-page block support for uncompressed files is
available.  It's mainly used to enable golden 4k-block images on arm64
with 16/64k pages.  In addition, end users could also use this feature
to build a manifest to directly refer to golden tar data.

Besides, long xattr name prefix support is also introduced in this
cycle to avoid too many xattrs with the same prefix (e.g. overlayfs
xattrs).  It's useful for erofs + overlayfs combination (like Composefs
model):  the image size is reduced by ~14% and runtime performance is
also slightly improved.

Others are random fixes and cleanups as usual.  All commits have been
in -next for a while and currently there is only a minor merge conflict
with the vfs-idmapping tree [1].  Christian also mentioned this in the
related pull request.

Thanks,
Gao Xiang

[1] linux-next: manual merge of the erofs tree with the vfs-idmapping tree
    https://lore.kernel.org/r/4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc1

for you to fetch changes up to 745ed7d77834048879bf24088c94e5a6462b613f:

  erofs: cleanup i_format-related stuffs (2023-04-17 01:15:55 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add sub-page block size support for uncompressed files;

 - Support flattened block device for multi-blob images to be attached
   into virtual machines (including cloud servers) and bare metals;

 - Support long xattr name prefixes to optimize images with common
   xattr namespaces (e.g. files with overlayfs xattrs) use cases;

 - Various minor cleanups & fixes.

----------------------------------------------------------------
Gao Xiang (6):
      erofs: tidy up EROFS on-disk naming
      erofs: stop parsing non-compact HEAD index if clusterofs is invalid
      erofs: keep meta inode into erofs_buf
      erofs: get rid of z_erofs_fill_inode()
      erofs: sunset erofs_dbg()
      erofs: cleanup i_format-related stuffs

Jia Zhu (1):
      erofs: support flattened block device for multi-blob images

Jingbo Xu (12):
      erofs: avoid hardcoded blocksize for subpage block support
      erofs: set block size to the on-disk block size
      erofs: move several xattr helpers into xattr.c
      erofs: rename init_inode_xattrs with erofs_ prefix
      erofs: simplify erofs_xattr_generic_get()
      erofs: initialize packed inode after root inode is assigned
      erofs: move packed inode out of the compression part
      erofs: introduce on-disk format for long xattr name prefixes
      erofs: add helpers to load long xattr name prefixes
      erofs: handle long xattr name prefixes properly
      erofs: enable long extended attribute name prefixes
      erofs: fix potential overflow calculating xattr_isize

Yue Hu (1):
      erofs: don't warn ztailpacking feature anymore

 Documentation/filesystems/erofs.rst |   4 +-
 fs/erofs/data.c                     |  81 +++++++------
 fs/erofs/decompressor.c             |   6 +-
 fs/erofs/decompressor_lzma.c        |   4 +-
 fs/erofs/dir.c                      |  25 ++--
 fs/erofs/erofs_fs.h                 | 176 ++++++++++++++--------------
 fs/erofs/fscache.c                  |   5 +-
 fs/erofs/inode.c                    |  36 +++---
 fs/erofs/internal.h                 |  73 +++++-------
 fs/erofs/namei.c                    |  27 +++--
 fs/erofs/super.c                    | 116 ++++++++++--------
 fs/erofs/xattr.c                    | 227 +++++++++++++++++++++++++-----------
 fs/erofs/xattr.h                    |  27 +----
 fs/erofs/zdata.c                    |  25 ++--
 fs/erofs/zmap.c                     | 166 ++++++++++++--------------
 include/trace/events/erofs.h        |   4 +-
 16 files changed, 541 insertions(+), 461 deletions(-)
