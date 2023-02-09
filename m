Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88862691034
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBISSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBISSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:18:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2395B1BCB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:18:40 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m2so3787975plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAeDBd0vA/AYl78MX8JjIWV+4nG3ektN8r7tg/If92Q=;
        b=B21kTWqowO/PbsBG4oQYa5k7ppDue6cucLiZ8usX2aWquno63Djj7QNJstQjA4TTn2
         G+r/1tG2TbMxf3ZR8nNUS50P8XAgcBBRoNSmhyvoH/36ToZh/dORWoHtdho1Jopy/4gR
         p2csyen1RkJ/rcM1ZTavqs/7cYTulluZa/CYNoMhNcpYTROzEtfw4wlPY7sBFXBn1v0c
         R+YbEOosq2IXa/aX+ChM6R8x6yCdlV3dnijiqaUg7/x2WHAr49T+3IthXRyU+AFlUndz
         QyPoVW7NsNYtimG9Wqv/HKayYOWR85Yy46OS9cz08x/35csSfZz3GNZ0Jd6qHLhWHL94
         WR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAeDBd0vA/AYl78MX8JjIWV+4nG3ektN8r7tg/If92Q=;
        b=JIQvdKZpV7GlpsBluhaqvVOAEgxPa7ESuOShXTFdOxKC/Jmx5xA3AARHtgbUDxM3Qb
         MyFRjaf3Gllzds9AaBzQU87OHLFvyfF0bx4B85MetjW+euTfdxRFNp6N3NK9oqe9bJy5
         w9Kp41SRyP8QArpumf1OphYotR6yMd5K4fva11ZANn6usBNU0OzunXxZtuOlbP6psAMY
         ji8HEx8m1BMTMHl27ug7e4WEt/Xg0KTMa80n+jbk8ZUn7dA8DPrv5WjdPGhgXFlRWbNH
         OOedMnSJfu1y9l+AHvtHY/eSMr4l0Gzyqi0URdGfjxZvHbEfzxmv6mCjah9SziJ2nJaC
         McnA==
X-Gm-Message-State: AO0yUKXVGb1xCYcx2pQU6aDJ2uAP1MjItB/wUn5/Vfusc75+dhGUCnce
        amPKd4mB2PJwjIbl5yMmSpjXWbIAlP+b8w==
X-Google-Smtp-Source: AK7set+P2npQ1a/JK/swh8ouq/k2DBFIBqe3OM6rVnA3f3barCK3rWfDqW2H8UuaiPe96tf8HC7Q9Q==
X-Received: by 2002:a17:902:c40e:b0:196:8a80:4d91 with SMTP id k14-20020a170902c40e00b001968a804d91mr14339019plk.35.1675966719096;
        Thu, 09 Feb 2023 10:18:39 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:631d:24ac:71d7:d24b])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902a40b00b0019460ac7c6asm1783819plq.283.2023.02.09.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:18:38 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: synchronize atomic write aborts
Date:   Thu,  9 Feb 2023 10:18:19 -0800
Message-Id: <20230209181819.2333522-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

To fix a race condition between atomic write aborts, I use the inode
lock and make COW inode to be re-usable thoroughout the whole
atomic file inode lifetime.

Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c    | 44 +++++++++++++++++++++++++++++---------------
 fs/f2fs/inode.c   | 11 +++++++++--
 fs/f2fs/segment.c |  3 ---
 fs/f2fs/super.c   |  2 --
 4 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 300eae8b5415..6436c52e7913 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1863,7 +1863,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 			atomic_read(&inode->i_writecount) != 1)
 		return 0;
 
+	inode_lock(inode);
 	f2fs_abort_atomic_write(inode, true);
+	inode_unlock(inode);
+
 	return 0;
 }
 
@@ -1878,8 +1881,12 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	 * before dropping file lock, it needs to do in ->flush.
 	 */
 	if (F2FS_I(inode)->atomic_write_task == current &&
-				(current->flags & PF_EXITING))
+				(current->flags & PF_EXITING)) {
+		inode_lock(inode);
 		f2fs_abort_atomic_write(inode, true);
+		inode_unlock(inode);
+	}
+
 	return 0;
 }
 
@@ -2085,19 +2092,28 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		goto out;
 	}
 
-	/* Create a COW inode for atomic write */
-	pinode = f2fs_iget(inode->i_sb, fi->i_pino);
-	if (IS_ERR(pinode)) {
-		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-		ret = PTR_ERR(pinode);
-		goto out;
-	}
+	/* Check if the inode already has a COW inode */
+	if (fi->cow_inode == NULL) {
+		/* Create a COW inode for atomic write */
+		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
+		if (IS_ERR(pinode)) {
+			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			ret = PTR_ERR(pinode);
+			goto out;
+		}
 
-	ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
-	iput(pinode);
-	if (ret) {
-		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-		goto out;
+		ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
+		iput(pinode);
+		if (ret) {
+			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			goto out;
+		}
+
+		set_inode_flag(fi->cow_inode, FI_COW_FILE);
+		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
+	} else {
+		/* Reuse the already created COW inode */
+		f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 	}
 
 	f2fs_write_inode(inode, NULL);
@@ -2105,8 +2121,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	stat_inc_atomic_inode(inode);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
-	set_inode_flag(fi->cow_inode, FI_COW_FILE);
-	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 
 	isize = i_size_read(inode);
 	fi->original_i_size = isize;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 28c9c72dda2a..7bf660d4cad9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -777,11 +777,18 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 void f2fs_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	nid_t xnid = fi->i_xattr_nid;
 	int err = 0;
 
 	f2fs_abort_atomic_write(inode, true);
 
+	if (fi->cow_inode) {
+		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
+		iput(fi->cow_inode);
+		fi->cow_inode = NULL;
+	}
+
 	trace_f2fs_evict_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
 
@@ -866,7 +873,7 @@ void f2fs_evict_inode(struct inode *inode)
 	stat_dec_inline_inode(inode);
 	stat_dec_compr_inode(inode);
 	stat_sub_compr_blocks(inode,
-			atomic_read(&F2FS_I(inode)->i_compr_blocks));
+			atomic_read(&fi->i_compr_blocks));
 
 	if (likely(!f2fs_cp_error(sbi) &&
 				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ead3f35f501d..719329c1808c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,9 +192,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
-	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
-	iput(fi->cow_inode);
-	fi->cow_inode = NULL;
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c11a161ba5be..aa55dc12aff2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1427,8 +1427,6 @@ static int f2fs_drop_inode(struct inode *inode)
 			atomic_inc(&inode->i_count);
 			spin_unlock(&inode->i_lock);
 
-			f2fs_abort_atomic_write(inode, true);
-
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
 
-- 
2.39.1.581.gbfd45094c4-goog

