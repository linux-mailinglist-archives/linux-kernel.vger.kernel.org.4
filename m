Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198FC613E29
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJaTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJaTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:24:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6F12A91
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:24:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i3so11498093pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhiMhg63rIh6GuOq1veFLUIx15LHFqS7BPNdeDxmDo0=;
        b=mK0/ehHT4mnQ3Nce8InbFGbqAhEvpKCqA4O5AxRm494Y1sSIBsp1Sa9bU/tYxcF0IJ
         4NEOMw1hJm9aYcj4tiO9VDIm6k9rKCKb3mNeeM7H0j7K9ZqO/lUAliidZEpt8zLr6vSU
         qU2+22HmPmyEJPY+Z/4+S8euddoKKhWUF56TdNbHhCR1bQg+p4fwC4ojEN/U1oaNrdwW
         zgLTmSpI+RS2uVVfPEjAbleBnvb98sObWkKsKyy+DTpvpL7P9b5O8tV62lFwbtyQscTq
         7dwppVXZdwextuHnEVkohopEDDSWOUUMYBW++G8iw+UfYfH4cg4j9dboZ6gdbw9P3Q+u
         mb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhiMhg63rIh6GuOq1veFLUIx15LHFqS7BPNdeDxmDo0=;
        b=bvrejIXFe2rB7kqCA03I+/sabHq5FiB2ZEmbNzftLNLS1X3ryCKeDBdWl+WlsTyMtG
         Be9m+Emfu5sSouZh785qnApltM/EYRfVbtQz+keMYRz4T9RtIWVc+DQBKpWlbvLpL+Wg
         oTSrHftloQ/NNB/NN0hnCqUr9uhumi9XfxmFzyCdC6EerNUFF5nfYMR5xjBKN2tNAHxT
         1cz8cYcjXWH3AfT4YBVyaNLtpWhNHx7RGZX5WYhmVs/m8DZQRFmwsnz5tbq85XmmqHg8
         glcBgoIdV7b7FnBYbnunMGe2U4gR6vSxmaAUFM1rSBQPGg1jX7PR5YwlGlwyZP2czEQs
         3jRg==
X-Gm-Message-State: ACrzQf0ZmdCPB41En0i3R+sLu7Z7U0cu/Pgo/gUXeuvYiuu//3WyFtxN
        ZouW7xrVtIQXSxruFm0es7xDrMrf5ng=
X-Google-Smtp-Source: AMsMyM5QvcTA+CYkYDPuNftclkdTNzjm/dGgQXJ+csUotuEAg57KdO252M9edVlmQ4nXW5Isuv+qlg==
X-Received: by 2002:a62:fb0f:0:b0:56d:78af:993 with SMTP id x15-20020a62fb0f000000b0056d78af0993mr6680165pfm.7.1667244263028;
        Mon, 31 Oct 2022 12:24:23 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:769d:1a73:1fb:944e])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7988b000000b0056babe4fb8asm4950466pfl.49.2022.10.31.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:24:22 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v6 1/2] f2fs: correct i_size change for atomic writes
Date:   Mon, 31 Oct 2022 12:24:15 -0700
Message-Id: <20221031192416.32917-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
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
v6: change FI_ATOMIC_COMMIT to FI_ATOMIC_COMMITTED
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
index e7e750e6b332..e29f9adf60ca 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,6 +764,7 @@ enum {
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
+	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
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
index 9f0d3864d9f1..577f109b4e1d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -621,9 +621,12 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_size = cpu_to_le64(i_size_read(inode));
 	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
 
+	if (!f2fs_is_atomic_file(inode) ||
+			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
+		ri->i_size = cpu_to_le64(i_size_read(inode));
+
 	if (et) {
 		read_lock(&et->lock);
 		set_raw_extent(&et->largest, &ri->i_ext);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 289bcb7ca300..9cbf88092c78 100644
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
+	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
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
+		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
+	}
 
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
 
-- 
2.38.1.273.g43a17bfeac-goog

