Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87C469F3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjBVMCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBVMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14C38644
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677067272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=++GzkLA+HCfYOivpamIxJEw6V9D0JZbB6YQWY7JbZ1Y=;
        b=cJVhGgCnN2yx233+ESLwZZ8y4yfLHLnPmLG7j/lRqUcHXXxT6p+5R26Mq1x2CWCIGIC+M1
        e7Tx+GWahJjV6+PwHE4/phXwZ4ShQx6Qjy8fnuglNMhLNTEz5ru/K3H9mqECiFcmYj6YNH
        H1noCDL+sCkgFKbKEmI14iSXKz4yqs0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-8gt7zDO-NgqsiFuxxoaQsg-1; Wed, 22 Feb 2023 07:01:09 -0500
X-MC-Unique: 8gt7zDO-NgqsiFuxxoaQsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB74D811E6E;
        Wed, 22 Feb 2023 12:01:08 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C72F62166B26;
        Wed, 22 Feb 2023 12:01:07 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Wed, 22 Feb 2023 13:01:06 +0100
Message-Id: <20230222120106.144326-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes.

These fixes are based on the latest iomap-for-next branch, for which
Darrick has sent a pull request earlier today:

https://lore.kernel.org/linux-fsdevel/167703901677.1909640.1798642413122202835.stg-ugh@magnolia/

Thanks,
Andreas


The following changes since commit 63510d9f2f6e6337960499a3d72d5a457b19c287:

  Merge branch 'iomap-for-next' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git (2023-01-24 12:51:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.2-rc5-fixes

for you to fetch changes up to c1b0c3cfcbad25d2c412863c27638c933f1d911b:

  gfs2: Convert gfs2_page_add_databufs to folios (2023-02-22 12:06:20 +0100)

----------------------------------------------------------------
gfs2 fixes

- Fix a race when disassociating inodes from their glocks after
  iget_failed().

- On filesystems with a block size smaller than the page size, make
  sure that ->writepages() writes out all buffers of journaled inodes.

- Various improvements to the way the delete workqueue is drained to
  speed up unmount and prevent leftover inodes.  At unmount time, evict
  deleted inodes cooperatively across the cluster to avoid unnecessary
  timeouts.

- Various minor cleanups and fixes.

----------------------------------------------------------------
Andreas Gruenbacher (12):
      gfs2: gl_object races fix
      gfs2: Improve gfs2_upgrade_iopen_glock comment
      gfs2: Clean up gfs2_scan_glock_lru
      gfs2: Make glock lru list scanning safer
      gfs2: Get rid of GLF_PENDING_DELETE flag
      gfs2: Move delete workqueue into super block
      gfs2: Split the two kinds of glock "delete" work
      gfs2: Flush delete work before shrinking inode cache
      gfs2: Evict inodes cooperatively
      gfs2: Improve gfs2_make_fs_rw error handling
      gfs2: jdata writepage fix
      gfs2: Convert gfs2_page_add_databufs to folios

Bob Peterson (4):
      gfs2: check gl_object in rgrp glops
      gfs2: Add SDF_DEACTIVATING super block flag
      gfs2: Cease delete work during unmount
      Revert "GFS2: free disk inode which is deleted by remote node -V2"

 fs/gfs2/aops.c       |   9 ++--
 fs/gfs2/aops.h       |   4 +-
 fs/gfs2/bmap.c       |   4 +-
 fs/gfs2/dentry.c     |  18 --------
 fs/gfs2/glock.c      | 128 +++++++++++++++++++++++++--------------------------
 fs/gfs2/glock.h      |   4 +-
 fs/gfs2/glops.c      |  21 ++++-----
 fs/gfs2/incore.h     |  11 ++++-
 fs/gfs2/inode.c      |   8 ++++
 fs/gfs2/ops_fstype.c |  71 +++++++++++++++++++++++++++-
 fs/gfs2/rgrp.c       |   2 +-
 fs/gfs2/super.c      |  49 ++++++++++++++------
 fs/gfs2/sys.c        |   2 +
 13 files changed, 204 insertions(+), 127 deletions(-)

