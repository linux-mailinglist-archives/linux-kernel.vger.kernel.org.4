Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8261E6688B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbjAMAvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbjAMAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:50:01 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB67621AE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:49:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 78so13955869pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0aOIcA4HY+kMmpBfAWn8xfATZOZpAZzf7hkPss2yBIk=;
        b=cQZ3zGvcLBXrKfRU4C1sQ274E6wzURXM9trpqXGCKP9aC/5tAJT3OLT/w+ZMpC7xgK
         c6JWemKme9xsDnoavf/P9wmEh9ti9BucyQpYLgGJo1ERA0RLgc1FwjMDl9nOb8cY6pNG
         mEUUdqeU9sh95euoy0Nxfwf8Y6TXtdkMNe8SE/Y533fXfEf0sev7dntuHtPkupgsCj5D
         gVGoUe19IqU9WTtYqtBkTOgQ52vNOM+xkECEL5FAp5PCcu3Mf/uycnZG0PI6DYFMWYvM
         2eEB5sH/Y/juf6ZICJfWmFiqpSomof7VrOpjow4gmWsD6ChqNQCx/D8B8pLiBnSP6wBi
         thZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aOIcA4HY+kMmpBfAWn8xfATZOZpAZzf7hkPss2yBIk=;
        b=eC/qOZqPpWkWbIrv9tDSo0KrV02Sc5jxwxA6FTBASumR5Gc+mCHLZYccMX5sINeO+2
         sLCXjsdxD9Z9HICT73HSN92yp5C/xG6gb5Xmxp6h8HGZRo4HmATxhHQXx5nxgjxDV67j
         s7gHIXR0kBCeuil08xzD19Hlqs5LUCVWx6MTFOev4UC3HZFv2gff0tmz4UH9Tv7o4Jlz
         VhJVISMN7qwLK2JOOCNoe+++lIBD3RhhCNS55KD44s6Fz2XJYcRCMHMSqAFAkB4SB1Xo
         sw8+4A28PdjbJ4VGX0390wRhTuO9ctC30PBKu102uZR4kM5O02In8YSXpOKK9N7BjMAo
         p2Gg==
X-Gm-Message-State: AFqh2koC+oW+E5cd7hH9kpiObSzmhK+8R7x0RjTCufZ2TL+hv4tcED2+
        o5NLp1/ZdU3KviNP8UlxZgoIeMW3ixs=
X-Google-Smtp-Source: AMrXdXvftwIOfFLuEPxagP/h1Q09IFACq7vTK8JKfxXE/i0Dwgmh3Ao+q+inJRXHJrFFcJbdngmpUA==
X-Received: by 2002:a05:6a00:130d:b0:580:fb8e:3044 with SMTP id j13-20020a056a00130d00b00580fb8e3044mr76639150pfu.22.1673570991526;
        Thu, 12 Jan 2023 16:49:51 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:9cd1:e03e:3432:197d])
        by smtp.gmail.com with ESMTPSA id r21-20020aa79635000000b00580c0219f16sm12467614pfg.169.2023.01.12.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:49:50 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: synchronize atomic write aborts
Date:   Thu, 12 Jan 2023 16:49:33 -0800
Message-Id: <20230113004933.2082072-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
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
 fs/f2fs/file.c    | 43 ++++++++++++++++++++++++++++---------------
 fs/f2fs/inode.c   | 11 +++++++++--
 fs/f2fs/segment.c |  3 ---
 fs/f2fs/super.c   |  2 --
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ecbc8c135b49..ff072a9ed258 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1866,7 +1866,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 			atomic_read(&inode->i_writecount) != 1)
 		return 0;
 
+	inode_lock(inode);
 	f2fs_abort_atomic_write(inode, true);
+	inode_unlock(inode);
+
 	return 0;
 }
 
@@ -1880,8 +1883,11 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	 * until all the writers close its file. Since this should be done
 	 * before dropping file lock, it needs to do in ->flush.
 	 */
-	if (F2FS_I(inode)->atomic_write_task == current)
+	if (F2FS_I(inode)->atomic_write_task == current) {
+		inode_lock(inode);
 		f2fs_abort_atomic_write(inode, true);
+		inode_unlock(inode);
+	}
 	return 0;
 }
 
@@ -2087,19 +2093,28 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
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
@@ -2107,8 +2122,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	stat_inc_atomic_inode(inode);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
-	set_inode_flag(fi->cow_inode, FI_COW_FILE);
-	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 
 	isize = i_size_read(inode);
 	fi->original_i_size = isize;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ff6cf66ed46b..4921f7209e28 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -766,11 +766,18 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
 
@@ -857,7 +864,7 @@ void f2fs_evict_inode(struct inode *inode)
 	stat_dec_inline_inode(inode);
 	stat_dec_compr_inode(inode);
 	stat_sub_compr_blocks(inode,
-			atomic_read(&F2FS_I(inode)->i_compr_blocks));
+			atomic_read(&fi->i_compr_blocks));
 
 	if (likely(!f2fs_cp_error(sbi) &&
 				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ae3c4e5474ef..536d7c674b04 100644
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
index 1f812b9ce985..10463f084d30 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1430,8 +1430,6 @@ static int f2fs_drop_inode(struct inode *inode)
 			atomic_inc(&inode->i_count);
 			spin_unlock(&inode->i_lock);
 
-			f2fs_abort_atomic_write(inode, true);
-
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
 
-- 
2.39.0.246.g2a6d74b583-goog

