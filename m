Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1252E5F8F01
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJIV4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJIV4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175782252F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665352559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CtHS9w/5k0BIRsJYRHFcjnQr1ZdZ1pnSzV1HOXUjrnw=;
        b=gliEnMM2WNLAVeSOYiIag60s1XnmqMHgqjaYmasFX8aebCR3ZHfk2j746bN319TMyWPVz1
        SYGs7VZVwuSnWi6I0tWEpZsnZ1Cl+FBODAlGXLN1C2cNKhYMz1GPFf6WrJ1SUHwt1s7xlV
        27LNnNNjm+LSnakKdsH/vlAgHJjfags=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-eLhd34IPMtCCkXAmG8R1hw-1; Sun, 09 Oct 2022 17:55:56 -0400
X-MC-Unique: eLhd34IPMtCCkXAmG8R1hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D771B29AB3FE;
        Sun,  9 Oct 2022 21:55:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89E2F4014CE7;
        Sun,  9 Oct 2022 21:55:54 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 debugfs improvements
Date:   Sun,  9 Oct 2022 23:55:53 +0200
Message-Id: <20221009215553.380150-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

please consider pulling the following gfs2 changes on top of the pull request
I've sent earlier today.

Commit "gfs2: Add glockfd debugfs file" modifies fs/file.c to export
task_lookup_next_fd_rcu(), and kernel/pid.c to export find_ge_pid().  We use
those two functions to iterate through all processes and their file
descriptors.  I haven't received any pushback to exporting those two functions,
but no affirmation, either.

The merge commit included in this pull request resolves a conflict in
gfs2_inode_lookup(); not sure if you'd rather like to squash this merge and
resolve the conflict directly; in any case, the merge commit shows the desired
end result.

Thank you very much,
Andreas

The following changes since commit 74b1b10e29b1f25e1a081fa82733baea65429d53:

  gfs2: Register fs after creating workqueues (2022-09-20 17:53:54 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-nopid-for-v6.1

for you to fetch changes up to c7d7d2d345697eb3781198e58a22504feb74af63:

  gfs2: Merge branch 'for-next.nopid' into for-next (2022-10-09 22:56:28 +0200)

----------------------------------------------------------------
gfs2 debugfs improvements

- Improve the way how the state of glocks is reported in debugfs
  for glocks which are not held by processes, but rather by other
  resouces like cached inodes or flocks.

----------------------------------------------------------------
Andreas Gruenbacher (6):
      gfs2: Add glockfd debugfs file
      gfs2: Add flocks to glockfd debugfs file
      gfs2: Add GL_NOPID flag for process-independent glock holders
      gfs2: Mark flock glock holders as GL_NOPID
      gfs2: Mark the remaining process-independent glock holders as GL_NOPID
      gfs2: Merge branch 'for-next.nopid' into for-next

 fs/file.c            |   1 +
 fs/gfs2/file.c       |  29 ++++++-
 fs/gfs2/glock.c      | 213 ++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/gfs2/glock.h      |   1 +
 fs/gfs2/inode.c      |   5 +-
 fs/gfs2/ops_fstype.c |  14 ++--
 fs/gfs2/super.c      |   3 +-
 fs/gfs2/util.c       |   6 +-
 kernel/pid.c         |   1 +
 9 files changed, 248 insertions(+), 25 deletions(-)

