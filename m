Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28AC661CD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjAIDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjAIDpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:45:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194DA45B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1E34B80CA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F702C433F2;
        Mon,  9 Jan 2023 03:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673235917;
        bh=p3rbTOR1QFjXLaPSnR9uaBLuFIGzPk439CwPaP0U//8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usr0EL8S2TWfVQj+6ygM2g8ntOS+6+nOYBoOMFpmSClbP1nd1kNQp7S0NZOFyUCNs
         k2HR7uMtEeEmp/KhHGsdYqzmficO41WyG+xvUemkT6xd84HnuKBzV/4Xfi2dJT0z4i
         dMa7uGrneuB8tYADOtTa07DJDdXbNYBoDFtdTdL0CBA2yvp5YnleqCg3GSwv2DmxyQ
         QkkSp9uRuKu7VHPhSnMJtuQx5DD8x37MVu9xe2Hndbhn6e+gIVTpFzufWGr3LOuvGC
         Qr1b7CW/u8GPRXJRMSIgx2+ptZfrdPBBj4WN0rLjQuXO3O1tdu/ZqfSJVkY7yVvQnS
         e1Av9wykN6wnw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        syzbot+9b7be0f1263ed2dbfbba@syzkaller.appspotmail.com
Subject: [PATCH 4/5] f2fs: fix to avoid race condition of f2fs_abort_atomic_write()
Date:   Mon,  9 Jan 2023 11:44:52 +0800
Message-Id: <20230109034453.490176-4-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
References: <20230109034453.490176-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports a kernel panic as below:

kernel BUG at fs/inode.c:1763!
RIP: 0010:iput+0x68/0x80 fs/inode.c:1763
Call Trace:
 f2fs_abort_atomic_write+0xea/0x4f0 fs/f2fs/segment.c:196
 f2fs_ioc_commit_atomic_write+0x19f/0x260 fs/f2fs/file.c:2157
 __f2fs_ioctl+0x26f0/0xaaf0 fs/f2fs/file.c:4154
 f2fs_ioctl+0x18e/0x220 fs/f2fs/file.c:4242
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The root cause is there may be race case in between f2fs_abort_atomic_write()
called from f2fs_file_flush() and f2fs_ioc_commit_atomic_write().

Thread A				Thread B
- close
 - close_fd
  - filp_close
   - f2fs_file_flush
					- f2fs_ioctl
					 - f2fs_ioc_commit_atomic_write
					  - f2fs_abort_atomic_write
					   - iput(cow_inode)
					    - f2fs_evict_inode
					     - clear_inode
					      - inode->i_state = I_FREEING | I_CLEAR;
    - f2fs_abort_atomic_write
     - iput(cow_inode)
      - BUG_ON(inode->i_state & I_CLEAR)
					   - cow_inode = NULL
     - cow_inode = NULL

So let's cover f2fs_abort_atomic_write() with f2fs_inode_info.i_atomic_sem
lock to avoid this race condition.

Reported-by: syzbot+9b7be0f1263ed2dbfbba@syzkaller.appspotmail.com
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 6 +++++-
 fs/f2fs/super.c   | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 70ed01aca6f6..fa41c0dad308 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -854,6 +854,7 @@ struct f2fs_inode_info {
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
 					/* cached extent_tree entry */
 	struct inode *cow_inode;	/* copy-on-write inode for atomic write */
+	struct f2fs_rwsem i_atomic_sem;	/* protect atomic write context */
 
 	/* avoid racing between foreground op and gc */
 	struct f2fs_rwsem i_gc_rwsem[2];
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5f7e42b355eb..245d7adef6c6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -189,8 +189,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
+	f2fs_down_write(&fi->i_atomic_sem);
+
 	if (!f2fs_is_atomic_file(inode))
-		return;
+		goto out_unlock;
 
 	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 	iput(fi->cow_inode);
@@ -208,6 +210,8 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
+out_unlock:
+	f2fs_up_write(&fi->i_atomic_sem);
 }
 
 static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0e8b3e27fa14..3edc8630eb4b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1411,6 +1411,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
 	init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
 	init_f2fs_rwsem(&fi->i_xattr_sem);
+	init_f2fs_rwsem(&fi->i_atomic_sem);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
2.25.1

