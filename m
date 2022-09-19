Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA015BD1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiISQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:06:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4264EF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:06:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w2so101716pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NxcT9yfl2abMJw9DM1eH/T20vzORpzIvlZXJurx26RE=;
        b=maDiqhBNsV6lo52BJPHJwLGbeFXravruIwnLi0mQzVSFG+68m+Id46itDw9QAqD1+8
         6qFH+13UP/oC45Q0fN7+IOeMntZoHjhZLe87aVx8d0n3fUNDZT5zik0Y/N5jp9jEZUD6
         OeMnHlgNLnxVqh8pCCfZBdVV4fJtuHyR6zwEGAtESPrgj9aM6m02oPZWSlxlqk8pCOhA
         X2nh4kVmO8kdR7ov9CWiezdOasRAcRx5k1mXOlSJ5aSZhkdBMbp9oFXDLPUSkvF/kmR6
         6BTRZTk5QzXPI3IIYXoEVil1LKqHB3ECjTayZ43piN1F5sSw8+t0EhBIkAdHlmTjqLOR
         TsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NxcT9yfl2abMJw9DM1eH/T20vzORpzIvlZXJurx26RE=;
        b=G7GHfpUVJUFRNuk79axNMmGSHF/abRf8q9iesFO1nqKm9Jwvn7XRRVQP5GCjZA4P5e
         mUWyiIu3HPykBPG47q5Cc6ofuLhSh18jNg2VPTjVqjCkfXyT31UugKNZ1RefantKxaDe
         cwU7yMeWmsTGlarqz0roH5cCLys5LU/Ok8wWnm7yK+REtCox5MSlX+/CZiGWJ+R3gtuy
         ZofGnI1iwWdX2n/lbqKOcxHmKPASRkzS8CeHnbMmA0mkUvTInfoArY1v6I5wgp03pzwI
         tNK1V5w2ur+sHrtHJsrFt829fnS7bzj5ZNBaqACz/gcX3+TjsZ/HT5NlS0FogPA9HtwC
         2Dew==
X-Gm-Message-State: ACrzQf1OrO7BaCXl82kI4yliPgVvSZ3JRVLCmKlY1uYpA18w7OPnXrLT
        /MM5p19tNlUsx7Z0MGCLBOfflgplv70=
X-Google-Smtp-Source: AMsMyM42kmO3rvMQqqjf9P0ZvKNgtirXERlHkmJwT0j4PZw1RoK4yUTQOYDloWj4IDQ5gKQiNpvM/g==
X-Received: by 2002:a63:5d52:0:b0:439:36bb:c07c with SMTP id o18-20020a635d52000000b0043936bbc07cmr16602300pgm.272.1663603614068;
        Mon, 19 Sep 2022 09:06:54 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:8958:94cc:1777:6efd])
        by smtp.gmail.com with ESMTPSA id 4-20020a631944000000b00419b66846fcsm18667682pgz.91.2022.09.19.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:06:53 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: correct i_size change for atomic writes
Date:   Mon, 19 Sep 2022 09:06:43 -0700
Message-Id: <20220919160644.2219088-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
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
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 16 +++++++++-------
 fs/f2fs/inode.c   |  3 +++
 fs/f2fs/segment.c |  4 +++-
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dee7b67a17a6..539da7f12cfc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -821,6 +821,7 @@ struct f2fs_inode_info {
 	unsigned int i_cluster_size;		/* cluster size */
 
 	unsigned int atomic_write_cnt;
+	loff_t original_i_size;		/* original i_size before atomic write */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5efe0e4a725a..4f9b80c41b1e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1989,6 +1989,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
+	loff_t isize;
 	int ret;
 
 	if (!inode_owner_or_capable(mnt_userns, inode))
@@ -2047,7 +2048,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		goto out;
 	}
-	f2fs_i_size_write(fi->cow_inode, i_size_read(inode));
+
+	isize = i_size_read(inode);
+	fi->original_i_size = isize;
+	f2fs_i_size_write(fi->cow_inode, isize);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	sbi->atomic_files++;
@@ -2087,16 +2091,14 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
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
index cde0a3dc80c3..64d7772b4cd9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -30,6 +30,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
+	if (f2fs_is_atomic_file(inode))
+		return;
+
 	mark_inode_dirty_sync(inode);
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 460048f3c850..143b7ea0fb8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,8 +193,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
-	if (clean)
+	if (clean) {
 		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, fi->original_i_size);
+	}
 	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 	iput(fi->cow_inode);
 	fi->cow_inode = NULL;
-- 
2.37.3.968.ga6b4b080e4-goog

