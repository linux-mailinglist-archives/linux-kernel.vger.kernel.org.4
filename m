Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE175BD1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiISQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiISQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:06:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E10BE3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:06:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so27135212pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=r8zfkAXa2GKKEYYW7+6/PELncFtCutbORvDm0JXbNZg=;
        b=GHCWKl4bARlseA2oq7fLW35pCMM9MaQXNzIvvIIZoKX8SvZA8ioa8O434o+aMN9Tmh
         JPj3+MdwxY26UapozZAPsyuFC0nYaqHl6R0LJDuG8c4Spu6SFCijUWIvsNnscIxpOVTm
         MT39pWxbHx36DGUDccLknTYx+nMq/bSNEZXGaVqMg1byIF+jQ2ivjTpINTKCmr5uinUb
         0J5IOlSZHUe5+M0NHiNNqH75EM8edVbK5HibHRelfqGwk5rbm57x6ASJ9BDZXQDRdLuZ
         EMm17cHAPa2awyWRVawRSC0CZxmCcUVm9TCvc5NOuKiUI2GC3tGm0dtAFmewB0SMMxCk
         T0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=r8zfkAXa2GKKEYYW7+6/PELncFtCutbORvDm0JXbNZg=;
        b=RRhR5Z2FbM2DfYMRZJEzBF15WcaVVVkrsAz9oKbXXkgvUdsKkXBsZ8U4zrmiutBnj8
         An2wrXsjtuPFpWO1oXhH+sXPZgLWdMSaoDNrmeS3MGua0DwWdWvIZb6NwqxLNkvfrhEw
         IbEQ5e8fWHIkuIOqFTcD9gW16LkKq1zm0U3rVYh8Gu9DQOUurr+mxG95pn1nzAWXsMMd
         vIcdLDFpP2R0OEu3SYGNzVmenY3lNltfx8b8+tfqtOGYVsjGC93FTGkXeEjQVH9HEM2R
         J14FJyn1b3sTzNMvyKvIVepHKRvIDzZdf9LQHwQ6IyjDW3oR4gGsHNG4E+Dzx8R6qaz2
         bLqQ==
X-Gm-Message-State: ACrzQf04ff7pnUf3doK43ld7+Q9hFiZvTI3aCwP2rdU0aQ2tVtSHhgFP
        ipulIt9P4SMEI4wseE4vd6H5k63NFWE=
X-Google-Smtp-Source: AMsMyM4kX3o1Gm3DmW8VhCSdr/ZXcH7nbxczW6ZZB54aj1UNhHaQxTJf60gB0Ygg8eYstnMxfPRwVA==
X-Received: by 2002:a63:e118:0:b0:438:7603:8d6e with SMTP id z24-20020a63e118000000b0043876038d6emr16504079pgh.72.1663603617870;
        Mon, 19 Sep 2022 09:06:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:8958:94cc:1777:6efd])
        by smtp.gmail.com with ESMTPSA id 4-20020a631944000000b00419b66846fcsm18667682pgz.91.2022.09.19.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:06:57 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
Date:   Mon, 19 Sep 2022 09:06:44 -0700
Message-Id: <20220919160644.2219088-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220919160644.2219088-1-daeho43@gmail.com>
References: <20220919160644.2219088-1-daeho43@gmail.com>
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

introduce a new ioctl to replace the whole content of a file atomically,
which means it induces truncate and content update at the same time.
We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
F2FS_IOC_ABORT_ATOMIC_WRITE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c            |  3 +++
 fs/f2fs/f2fs.h            |  1 +
 fs/f2fs/file.c            | 12 ++++++++++--
 fs/f2fs/segment.c         | 14 +++++++++++++-
 include/uapi/linux/f2fs.h |  2 ++
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6cd29a575105..eef798b3e941 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3438,6 +3438,9 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	else if (*blk_addr != NULL_ADDR)
 		return 0;
 
+	if (is_inode_flag_set(inode, FI_ATOMIC_TRUNCATED))
+		goto reserve_block;
+
 	/* Look for the block in the original inode */
 	err = __find_data_block(inode, index, &ori_blk_addr);
 	if (err)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 539da7f12cfc..79e7bed009bc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,6 +764,7 @@ enum {
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
+	FI_ATOMIC_TRUNCATED,	/* indicate truncated atomic write */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4f9b80c41b1e..905810c62d47 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1982,7 +1982,7 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 	return put_user(inode->i_generation, (int __user *)arg);
 }
 
-static int f2fs_ioc_start_atomic_write(struct file *filp)
+static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 {
 	struct inode *inode = file_inode(filp);
 	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
@@ -2051,6 +2051,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	isize = i_size_read(inode);
 	fi->original_i_size = isize;
+	if (truncate) {
+		set_inode_flag(inode, FI_ATOMIC_TRUNCATED);
+		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, 0);
+		isize = 0;
+	}
 	f2fs_i_size_write(fi->cow_inode, isize);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
@@ -4080,7 +4086,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GETVERSION:
 		return f2fs_ioc_getversion(filp, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
-		return f2fs_ioc_start_atomic_write(filp);
+		return f2fs_ioc_start_atomic_write(filp, false);
+	case F2FS_IOC_START_ATOMIC_REPLACE:
+		return f2fs_ioc_start_atomic_write(filp, true);
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 		return f2fs_ioc_commit_atomic_write(filp);
 	case F2FS_IOC_ABORT_ATOMIC_WRITE:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 143b7ea0fb8e..18aeec957ec9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -263,14 +263,26 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
 	struct revoke_entry *cur, *tmp;
+	pgoff_t start_index = 0;
+	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_TRUNCATED);
 
 	list_for_each_entry_safe(cur, tmp, head, list) {
-		if (revoke)
+		if (revoke) {
 			__replace_atomic_write_block(inode, cur->index,
 						cur->old_addr, NULL, true);
+		} else if (truncate) {
+			f2fs_truncate_hole(inode, start_index, cur->index);
+			start_index = cur->index + 1;
+		}
+
 		list_del(&cur->list);
 		kmem_cache_free(revoke_entry_slab, cur);
 	}
+
+	if (!revoke && truncate) {
+		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
+		clear_inode_flag(inode, FI_ATOMIC_TRUNCATED);
+	}
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 3121d127d5aa..224d98731f22 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -42,6 +42,8 @@
 						struct f2fs_comp_option)
 #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
 #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
+#define F2FS_IOC_START_TRUNC_ATOMIC_WRITE				\
+					_IO(F2FS_IOCTL_MAGIC, 25)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.37.3.968.ga6b4b080e4-goog

