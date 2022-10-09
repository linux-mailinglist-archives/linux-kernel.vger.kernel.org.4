Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2C5F8ABC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJIKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJIKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F928711
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665312345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sBnuKOP8ea+z2pRs5J0bRVL8ZB6FmqEXDAXcvtpc13U=;
        b=OAOkiSzy3ZfIqQShoirZQv2Tez7Ky7Lx2BsVRwx3AjD9JjJ59+a3ZD6L/7WsCl1t9qgXW9
        GZ4eC/5ZNhH14fW78GtJMpp6MuteOBM/mNKbPicRUiaaBkqi+fBECqBtZP67m/NiyW21Aj
        Dp4DFiV60J0giHTvxt+uKuY8G+Lqt2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-8kRDczUcNO6ufuVmQqjbXg-1; Sun, 09 Oct 2022 06:45:42 -0400
X-MC-Unique: 8kRDczUcNO6ufuVmQqjbXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E812F95D682;
        Sun,  9 Oct 2022 10:45:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96007A9FBE;
        Sun,  9 Oct 2022 10:45:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Sun,  9 Oct 2022 12:45:39 +0200
Message-Id: <20221009104539.368110-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes.

We have a second small set of changes queued up on top of these fixes [*]; second
pull request to follow.

[*] https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next.nopid

Thank you very much,
Andreas

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.0-rc2-fixes

for you to fetch changes up to 74b1b10e29b1f25e1a081fa82733baea65429d53:

  gfs2: Register fs after creating workqueues (2022-09-20 17:53:54 +0200)

----------------------------------------------------------------
gfs2 fixes

- Make sure to initialize the filesystem work queues before registering
  the filesystem; this prevents them from being used uninitialized.

- On filesystem withdraw: prevent a a double iput() and immediately
  reject pending locking requests that can no longer succeed.

- Use TRY lock in gfs2_inode_lookup() to prevent a rare glock hang
  during evict.

- During filesystem mount, explicitly make sure that the sb_bsize and
  sb_bsize_shift super block fields are consistent with each other.
  This prevents messy error messages during fuzz testing.

- Switch from strlcpy to strscpy.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Switch from strlcpy to strscpy

Andrew Price (1):
      gfs2: Check sb_bsize_shift after reading superblock

Bob Peterson (5):
      gfs2: Use TRY lock in gfs2_inode_lookup for UNLINKED inodes
      gfs2: Prevent double iput for journal on error
      gfs2: Dequeue waiters when withdrawn
      gfs2: Clear flags when withdraw prevents xmote
      gfs2: Register fs after creating workqueues

 fs/gfs2/glock.c      | 44 +++++++++++++++++++++++++++++++++++++++-----
 fs/gfs2/glock.h      |  1 +
 fs/gfs2/inode.c      | 10 ++++++++--
 fs/gfs2/main.c       | 24 ++++++++++++------------
 fs/gfs2/ops_fstype.c | 17 +++++++++++------
 fs/gfs2/util.c       |  6 ++++++
 6 files changed, 77 insertions(+), 25 deletions(-)

