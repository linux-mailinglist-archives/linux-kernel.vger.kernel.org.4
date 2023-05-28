Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5371387C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjE1Hr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjE1HrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3467C9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E1536171E
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87560C4339E;
        Sun, 28 May 2023 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685260042;
        bh=XJQ6lc7wdZU6+cv/rJ8sgqn00/BLJI7QVVP3DDSUxdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZb4me+ijOPGpu93KOF+bbjqG0ueMbvoiWT/BLJ48ZweazhNNh10Kds4Bmfy1+1Ii
         6oQFi2eBfZ5U184vwHBLgmokAf1WXYmy9DY+svlSVWGAvb/iCjoHtvOG2yqAqYtv+T
         v0L6jPONsRP3hDL9Ou343jh5+zUk+sZf7CU8LWNNgc0ERHGQEBePSqNmn6+KSijP82
         g0TdkxOCQKBeQ0c4ZhcmAeLzZ8F5LoJI85lZvDjqWsJCLDwTNKPkb7tWCb8X60tgeY
         xZ9KltNYFNPRm9JMJkqtkbNuMNA3KBdJET4WHWnCqGqzDJbw0nhonU2VHryHYrtzop
         2iuiU7bJ3ztDA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid dead loop in f2fs_issue_checkpoint()
Date:   Sun, 28 May 2023 15:47:13 +0800
Message-Id: <20230528074713.1682062-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528074713.1682062-1-chao@kernel.org>
References: <20230528074713.1682062-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic/082 reports a bug as below:

__schedule+0x332/0xf60
schedule+0x6f/0xf0
schedule_timeout+0x23b/0x2a0
wait_for_completion+0x8f/0x140
f2fs_issue_checkpoint+0xfe/0x1b0
f2fs_sync_fs+0x9d/0xb0
sync_filesystem+0x87/0xb0
dquot_load_quota_sb+0x41b/0x460
dquot_load_quota_inode+0xa5/0x130
dquot_quota_on+0x4b/0x60
f2fs_quota_on+0xe3/0x1b0
do_quotactl+0x483/0x700
__x64_sys_quotactl+0x15c/0x310
do_syscall_64+0x3f/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

The root casue is race case as below:

Thread A			Kworker			IRQ
- write()
: write data to quota.user file

				- writepages
				 - f2fs_submit_page_write
				  - __is_cp_guaranteed return false
				  - inc_page_count(F2FS_WB_DATA)
				 - submit_bio
- quotactl(Q_QUOTAON)
 - f2fs_quota_on
  - dquot_quota_on
   - dquot_load_quota_inode
    - vfs_setup_quota_inode
    : inode->i_flags |= S_NOQUOTA
							- f2fs_write_end_io
							 - __is_cp_guaranteed return true
							 - dec_page_count(F2FS_WB_CP_DATA)
    - dquot_load_quota_sb
     - f2fs_sync_fs
      - f2fs_issue_checkpoint
       - do_checkpoint
        - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA)
        : loop due to F2FS_WB_CP_DATA count is negative

Calling filemap_fdatawrite() and filemap_fdatawait() to keep all data
clean before quota file setup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d1bce753f0d2..0bfa98d053bd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2927,15 +2927,26 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 		return -EBUSY;
 	}
 
+	if (path->dentry->d_sb != sb)
+		return -EXDEV;
+
 	err = f2fs_quota_sync(sb, type);
 	if (err)
 		return err;
 
-	err = dquot_quota_on(sb, type, format_id, path);
+	inode = d_inode(path->dentry);
+
+	err = filemap_fdatawrite(inode->i_mapping);
 	if (err)
 		return err;
 
-	inode = d_inode(path->dentry);
+	err = filemap_fdatawait(inode->i_mapping);
+		if (err)
+			return err;
+
+	err = dquot_quota_on(sb, type, format_id, path);
+	if (err)
+		return err;
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
-- 
2.40.1

