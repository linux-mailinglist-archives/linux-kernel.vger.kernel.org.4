Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63E5603143
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJRRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJRRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:00:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239DBEAE0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:00:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so14405552pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLtaH1AYltb6sVoVsKrg3UUMo7fbz4xDcrohkdzNMMQ=;
        b=FHM4oKzsRWWTak3Lk2SX+kT1E72HcBSfxmQct9wf42qL1p2yVlEej21iSp4w+99xiF
         tqVxXazzZaf9nsyYYolrLbDKrD6uyzgvzs0QeddtBEKGCsajo4R4q3fOLFx3Nu6U5aPH
         i4wiojsSAh+vSP+77e4eomEDkm26s+FrJU5yd7ejeEyQCuvVAW/dguOvej9d2gU/V/Ia
         YctjH9CpWwp/gN/4nnxacAzaSzNL151EZPqAAxK4pKvtKBbGYmekjzU90PikMjHEhIg9
         2NFvh96hs3wx9roaQOi1Qnn05KzvG5Zh5lCc6dx+73qwgqmeI0e/wAGvU268LrjV2E0G
         UbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLtaH1AYltb6sVoVsKrg3UUMo7fbz4xDcrohkdzNMMQ=;
        b=DR3wUHIB5NlAZ7iXagTfgQOxLfKlhSTXBulAlBQmkXEZPJKtFlDXQh4f3dGVn5QQeF
         NbsUxoYeWfeW60Q3X+MdbTGF5ydCqMY/67YOAgcrnyb6w0dslY/i4CDEkTnrFCuMe1yj
         L8ZAkT5lBMdtFcLsrqNyAGZB9zy573ozyxzOnOXhQqr85oEtTHeaUUNDGCoORLkM1rRu
         MMw/dreLFqteE62MMbqhiPsLkP9TI0Ev7mUtRntxnJbFIiJ0PEjf4XtWPMIuIVPOAQEq
         qfVd8F3a/EWnjzDLvYvOSoRsspU72Zzido6ROOPTXNK+aLdIPNpOBL9IJaeWDM5Cwren
         7FdA==
X-Gm-Message-State: ACrzQf0NtNddaNushifZpSPlE/fEkYTSv3+CqEd0HkRNenWkIqn/OtiS
        e+zkX6lUWBj0bFjVOKmI98kR+eJKP8A=
X-Google-Smtp-Source: AMsMyM5XXIfUiJh4qYd/pI/1JWeakOnLsBWIuvXEuZDK8yTUoXjXJhloYv28EKIhSPui5+vX6VLBBw==
X-Received: by 2002:a17:90b:4f4d:b0:20d:a08e:3876 with SMTP id pj13-20020a17090b4f4d00b0020da08e3876mr34584399pjb.0.1666112426711;
        Tue, 18 Oct 2022 10:00:26 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4968:cc70:9889:c198])
        by smtp.gmail.com with ESMTPSA id z10-20020a170902d54a00b00172951ddb12sm8951375plf.42.2022.10.18.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:00:26 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5 1/2] f2fs: correct i_size change for atomic writes
Date:   Tue, 18 Oct 2022 10:00:16 -0700
Message-Id: <20221018170017.672824-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
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

We need to make sure i_size doesn't change until atomic write commit is
successful and restore it when commit is failed.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v5: prevent only i_size update for atomic files when dirtying inode
v4: move i_size update after clearing atomic file flag in
    f2fs_abort_atomic_write()
v3: make sure inode is clean while atomic writing
---
 fs/f2fs/f2fs.h    |  8 ++++++++
 fs/f2fs/file.c    | 18 +++++++++++-------
 fs/f2fs/inode.c   |  5 ++++-
 fs/f2fs/segment.c | 14 ++++++++++----
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e7e750e6b332..68d2a3383c38 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,6 +764,7 @@ enum {
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
+	FI_ATOMIC_COMMIT,	/* indicate atomic commit completed except disk sync */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -822,6 +823,7 @@ struct f2fs_inode_info {
 	unsigned int i_cluster_size;		/* cluster size */
 
 	unsigned int atomic_write_cnt;
+	loff_t original_i_size;		/* original i_size before atomic write */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -3072,6 +3074,8 @@ static inline void f2fs_i_blocks_write(struct inode *inode,
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
+static inline bool f2fs_is_atomic_file(struct inode *inode);
+
 static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
@@ -3081,6 +3085,10 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	i_size_write(inode, i_size);
+
+	if (f2fs_is_atomic_file(inode))
+		return;
+
 	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ec9ee0f6d502..7ce629c95f4a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1991,6 +1991,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
+	loff_t isize;
 	int ret;
 
 	if (!inode_owner_or_capable(mnt_userns, inode))
@@ -2049,7 +2050,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		goto out;
 	}
-	f2fs_i_size_write(fi->cow_inode, i_size_read(inode));
+
+	f2fs_write_inode(inode, NULL);
+
+	isize = i_size_read(inode);
+	fi->original_i_size = isize;
+	f2fs_i_size_write(fi->cow_inode, isize);
 
 	stat_inc_atomic_inode(inode);
 
@@ -2087,16 +2093,14 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	if (f2fs_is_atomic_file(inode)) {
 		ret = f2fs_commit_atomic_write(inode);
-		if (ret)
-			goto unlock_out;
-
-		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret)
-			f2fs_abort_atomic_write(inode, false);
+			ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
+
+		f2fs_abort_atomic_write(inode, ret);
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
-unlock_out:
+
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9f0d3864d9f1..044f132b87bc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -621,9 +621,12 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_size = cpu_to_le64(i_size_read(inode));
 	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
 
+	if (!f2fs_is_atomic_file(inode) ||
+			is_inode_flag_set(inode, FI_ATOMIC_COMMIT))
+		ri->i_size = cpu_to_le64(i_size_read(inode));
+
 	if (et) {
 		read_lock(&et->lock);
 		set_raw_extent(&et->largest, &ri->i_ext);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 289bcb7ca300..264b4e352319 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -192,14 +192,18 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
-	if (clean)
-		truncate_inode_pages_final(inode->i_mapping);
 	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 	iput(fi->cow_inode);
 	fi->cow_inode = NULL;
 	release_atomic_write_cnt(inode);
+	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 	stat_dec_atomic_inode(inode);
+
+	if (clean) {
+		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, fi->original_i_size);
+	}
 }
 
 static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
@@ -335,10 +339,12 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	}
 
 out:
-	if (ret)
+	if (ret) {
 		sbi->revoked_atomic_block += fi->atomic_write_cnt;
-	else
+	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
+		set_inode_flag(inode, FI_ATOMIC_COMMIT);
+	}
 
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
 
-- 
2.38.0.413.g74048e4d9e-goog

