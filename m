Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8385F4817
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJDROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJDROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:14:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F505D0F6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:14:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b15so5356680pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PYCyywZT6ftdRPOM7ZXXbKbjWKsJ8VloyXxLwNUq5G0=;
        b=ghPLYi/JsyDHmKRCK5x6OHyRibakp6F4bYSDW7w5ljt6u1j79hU/9t48HM2ufKeHDH
         unAQ6Xr54uKxL3yYGVcMpr0EX5PY+uH1l2sZRACGbDj1wHPAXFoLxVSq2doRqkRTasdy
         Aa5gR+AslNi7Fw8g6K7WVXj4l+nBOQEptKWNjtEHDXJqEaUbuttHPnPTyLP758dUWxYh
         SGIGIXkvBimZ9+zUFUu2stgSD7cqiyaAqh2AhBBA79kn2iUk0M1eWgIpvbbSxQ9GfAvS
         cipOje372J0xC1AYIA5soIu5aMub/UvGvxPIzrpIhyA4RY53fJVs9AGJDFw3foDIODSJ
         BqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PYCyywZT6ftdRPOM7ZXXbKbjWKsJ8VloyXxLwNUq5G0=;
        b=VcxThGkIveX9Fj8iJoQGRLwVlTzbw3lRkQhE2hn6kenWQdK4T5gdQ+6eeXenIa/bBv
         W8OykL/+nOfE5PpQKzXyihLMjBsz1+jCn3DrsL+tVJwYHXndQTDArPUj+9pW/DFdaNwA
         aD1yh60b//pnDzkyroAzmlGZa3+BMEwniLhqt8Fx+VCh/4Rq9RKDiyTxoSYhYeNTenAj
         U318yC19UxP3b+OYdn77RkW9yX5VFlhmi5Zjzjf4jgKwgSU3z1iN4cCqh6XjlEfZuAL/
         9bfkc0BrOcwLFJU8nq51pl/a61PDgoBeVZEniSv57QPSpIKXhsy5mIJZugN9Pd6nSZuf
         1Eaw==
X-Gm-Message-State: ACrzQf3JQXsiZP9w1KXJjEvnmNQbYizbIfFKFi9ua8O6xIjz1h1XtlzG
        8wrbN479V6hO2YeVayobFZiZxOu6NLU=
X-Google-Smtp-Source: AMsMyM7RD04daD0gBltLyYgFEJhdeWY6S5ZMC5vSK+qCZHjtkD5USX1xtkjiM3Ayq0iJTK+0SX1CHQ==
X-Received: by 2002:a17:903:41cc:b0:176:d89d:63e3 with SMTP id u12-20020a17090341cc00b00176d89d63e3mr28098401ple.31.1664903639539;
        Tue, 04 Oct 2022 10:13:59 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:9291:ff24:9df5:5be7])
        by smtp.gmail.com with ESMTPSA id p63-20020a622942000000b00561c55c56a7sm1683693pfp.94.2022.10.04.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:13:57 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v4 1/2] f2fs: correct i_size change for atomic writes
Date:   Tue,  4 Oct 2022 10:13:50 -0700
Message-Id: <20221004171351.3678194-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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
v4: move i_size update after clearing atomic file flag in
    f2fs_abort_atomic_write()
v3: make sure inode is clean while atomic writing
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 18 +++++++++++-------
 fs/f2fs/inode.c   |  3 +++
 fs/f2fs/segment.c |  7 +++++--
 4 files changed, 20 insertions(+), 9 deletions(-)

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
index 5efe0e4a725a..ce2336d2f688 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1989,6 +1989,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
+	loff_t isize;
 	int ret;
 
 	if (!inode_owner_or_capable(mnt_userns, inode))
@@ -2047,7 +2048,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
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
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	sbi->atomic_files++;
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
index 460048f3c850..abb55cd418c1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,14 +193,17 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
-	if (clean)
-		truncate_inode_pages_final(inode->i_mapping);
 	clear_inode_flag(fi->cow_inode, FI_COW_FILE);
 	iput(fi->cow_inode);
 	fi->cow_inode = NULL;
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 
+	if (clean) {
+		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, fi->original_i_size);
+	}
+
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	sbi->atomic_files--;
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

