Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAA5F3A61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJDALC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJDAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:10:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2010EB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:10:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 70so11317025pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=16INUo0jrPPKZ9/RSm6pqWnMygsgztFX9XK3QEK3JRI=;
        b=WfCsLjBbRrGkzH9yp8MyYT0A1FJSvw1JeetXXhKLV9cvZ4iyeynjabjzL58+YK8JGj
         Lr9Bo2q4qgT5JG7CF2B4BzrGO5euGv+mqcZuseNP7XitXDdKfYkuKUwMFXCOh/3rsAB4
         84adNy5VPDOeR8ydG/ekz5/DuljbHyEmelne/lXwswpbu24QljG7Y6hdjzoiMZiPp2Gh
         +eDSvfsfjVgKtnW3V7cBq2EQxsLpSZYYeyQ0TpnzaAXylTjyB1MgSmvoM05MJTxMaB/N
         ChRzN/BZqiIsr/OvEjcUO7yMUKzAxwEiuUMqP4F/nmOd+mGQSqwrJ9oaTvc5BWhZzSe9
         DQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=16INUo0jrPPKZ9/RSm6pqWnMygsgztFX9XK3QEK3JRI=;
        b=xV+87ql4OoqUiXQ56yOXLbYt0nyVhGJwhTGWlkqGKjCHqmtQoflpha51pbNqjBkYLt
         MKcy/AqJCdYbnrqA5+RXEbgDvl/6tzpnFHKwn1PTdtO5neMho1XBdLUEjh4I38D3yy4t
         LZ+DJLlgRSY/9LimklsDW/p2WXv/tZmWKAIKdN0X8DU43sIqzXb/tDIqmhigkjFpcOe8
         EYufMHmAAA5+LzjhEfwhFbtotxyIHpfEwa/FzDRJCollmGmWCz6ek3CBzGNS+2hmr8iV
         snqZ7/mVeTYIUBiKso3ekW8tPVez7En0VxU8aQXzPa/Vo2yXlkpYoS4SuCnmNpc5csSv
         jTMw==
X-Gm-Message-State: ACrzQf04HYcP/BZPWdKBJHOkXPDgfyqw69/2Ud+3CjUwsdXXEVfl7HD5
        t+efCz9DsTe17HCkyI2ZvWXk4NMBGNc=
X-Google-Smtp-Source: AMsMyM7P3e+GmxpqrOcvlMQLS2AzrQVlwWBaMYBCNv7Z4v2khW0uJZTDZCc0akeawdINZMDUUWLR6w==
X-Received: by 2002:a17:903:2412:b0:178:796d:c694 with SMTP id e18-20020a170903241200b00178796dc694mr24590851plo.42.1664842257453;
        Mon, 03 Oct 2022 17:10:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:3d16:3dd7:b030:41a5])
        by smtp.gmail.com with ESMTPSA id i3-20020a626d03000000b0052dfe83e19csm8266974pfc.16.2022.10.03.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:10:57 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3 1/2] f2fs: correct i_size change for atomic writes
Date:   Mon,  3 Oct 2022 17:10:49 -0700
Message-Id: <20221004001050.3269377-1-daeho43@gmail.com>
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
v3: make sure inode is clean while atomic writing
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 18 +++++++++++-------
 fs/f2fs/inode.c   |  3 +++
 fs/f2fs/segment.c |  4 +++-
 4 files changed, 18 insertions(+), 8 deletions(-)

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
2.38.0.rc1.362.ged0d419d3c-goog

