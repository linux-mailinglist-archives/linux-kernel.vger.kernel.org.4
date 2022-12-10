Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F5648FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 18:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLJR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 12:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLJR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:29:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355751707B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 09:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB65D60C54
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EE5C433EF;
        Sat, 10 Dec 2022 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670693361;
        bh=wiKXS951R0J+e00NOnz0xf3GpSwcSCJH0lNaVupW9nI=;
        h=Date:From:To:Cc:Subject:From;
        b=kMSpuHF7sqpW85DL5XJkXQKYMtiAuEYhuNgN51FDAJvmcdOL6MssYdhHd6lO1h87I
         1XVMiQWszGqFcDrS9LMJOh6rxSg4vmeXEKg8z7+/dfBQlHkmmzi0utn0gKsh9J3/ga
         fNdXeUlrSx0Bs62FCtIPqphI3/vS+bBW1ISf6lknyqvby+TIlK8sEYWPxysf/tcQFC
         gBLSkAKMBWeSwb4Guui3Bnm2EyohjiiWpBgYsBYHKZNAEQTPPkTzeKFfkj9FaTOOot
         OKLXUZRPEjFZ+AAqk8IQk5Ugx8LkhpZKKlpGh293g2YeHgKOAQOHQPdcQ7D1lAbz/+
         tO8xEtS25vCMA==
Date:   Sun, 11 Dec 2022 01:29:12 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Hou Tao <houtao1@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>
Subject: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
Message-ID: <Y5TB6E77vbpRMhIk@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
        Hou Tao <houtao1@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Once the merge window opens, could you consider this pull request for
6.2-rc1?

In this cycle, large folios are now enabled in the iomap/fscache mode
for uncompressed files first.  In order to do that, we've also cleaned
up better interfaces between erofs and fscache, which are acked by
fscache/netfs folks and included in this pull request.

Other than that, there are random fixes around erofs over fscache and
crafted images by syzbot, minor cleanups and documentation updates.

Note that there could be a trivial conflict between erofs and vfs
tree according to linux-next report [1].

Happy Holidays!
Gao Xiang

[1] https://lore.kernel.org/r/20221205092415.56cc6e19@canb.auug.org.au/

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1

for you to fetch changes up to c505feba4c0d76084e56ec498ce819f02a7043ae:

  erofs: validate the extent length for uncompressed pclusters (2022-12-07 10:56:31 +0800)

----------------------------------------------------------------
Changes since the last update:

 - Enable large folios for iomap/fscache mode;

 - Avoid sysfs warning due to mounting twice with the same fsid and
   domain_id in fscache mode;

 - Refine fscache interface among erofs, fscache, and cachefiles;

 - Use kmap_local_page() only for metabuf;

 - Fixes around crafted images found by syzbot;

 - Minor cleanups and documentation updates.

----------------------------------------------------------------
Chen Zhongjin (1):
      erofs: Fix pcluster memleak when its block address is zero

Gao Xiang (5):
      erofs: update documentation
      erofs: clean up cached I/O strategies
      erofs: use kmap_local_page() only for erofs_bread()
      erofs: fix missing unmap if z_erofs_get_extent_compressedlen() fails
      erofs: validate the extent length for uncompressed pclusters

Hou Tao (1):
      erofs: check the uniqueness of fsid in shared domain in advance

Jingbo Xu (5):
      erofs: enable large folios for iomap mode
      fscache,cachefiles: add prepare_ondemand_read() callback
      erofs: switch to prepare_ondemand_read() in fscache mode
      erofs: support large folios for fscache mode
      erofs: enable large folios for fscache mode

 Documentation/filesystems/erofs.rst |  38 ++--
 fs/cachefiles/io.c                  |  77 ++++---
 fs/erofs/data.c                     |  10 +-
 fs/erofs/fscache.c                  | 408 ++++++++++++++++--------------------
 fs/erofs/inode.c                    |   2 +
 fs/erofs/internal.h                 |  13 +-
 fs/erofs/super.c                    |   2 +-
 fs/erofs/xattr.c                    |   8 +-
 fs/erofs/zdata.c                    |  80 +++----
 fs/erofs/zmap.c                     |  15 +-
 include/linux/netfs.h               |   8 +
 include/trace/events/cachefiles.h   |  27 +--
 12 files changed, 344 insertions(+), 344 deletions(-)
