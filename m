Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E127D5BD98C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiITBlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiITBl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:41:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3A54C86
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:40:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so9241499pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=z/jZBVKHrf7HtYZLUnYAd+Pe60b/PHa+auZtuaqhfT8=;
        b=YfVBV3dzuD1D5wySYoRuLCSCFHAgvMu/0oUEoW8E5EGy1bi9bK/3Wo4IDRHrseDcDv
         W/BnA7LUSPjgN8CJQbNwANEPbw2Mmj8vPBXDDiYFm/y2fVdO1NjWULHz9+uLG7bSgK0W
         dE6UodGr9fxTNpSLBdsU+2gOHlLEH+yAW3ClkccRisO23vA0LoMFo3LbFc6lrN/zI8iF
         CRlFfRLPN/OGFDMO8qkoI1mqysNjROyiMxTAwFRkgCtAHHO5vl7Di03zcoLVmQKzUuhX
         ccya3Wf/L/Kf3h4H62q03Dtc37vCntslevOgjDV5k68MnZ0/WuhMMv4uZfPP9yjzB/ep
         Or0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=z/jZBVKHrf7HtYZLUnYAd+Pe60b/PHa+auZtuaqhfT8=;
        b=rp305qgioMWGDrjxVQ0rt8mDzpmbxpeFLeQsG6j+vBwWJ71iatLK8p4G72HKiL7ExU
         GiN0j0mGFfh/IxLPF4lNnbPXwkUBkU9w9WYMF1ABH4tJpwkJWTTw5K2rZV5wxaZ02vYb
         hm6OrSr80BoxHGVVtvuACzPjT7unKVwa+Y2dQrmE0w8ZZ4tWudBIKLpyPuiT2Y846nSG
         +0sXXmpBMv79PLPnQ1xWVI9UA9+OHf7698FBlD186M+AAoXd9Tuve0oLwKsZKjjBJrG+
         5etPtRVCJY4uaSw+W+9zUIj7X+nZTt8Pndob743BSlciH7uaQ3nM+6jT65/gHCgB6t+o
         MKXw==
X-Gm-Message-State: ACrzQf0QeJBnbo8KLkihYgA1iVHd66LAGL95gVFTO5ZEOVopA4hdgcGb
        AyfoNcsZKLbVp2hAiVks5JvBp61sMyk=
X-Google-Smtp-Source: AMsMyM6puk5qGOPpKHFJRYzBm3Kjz6m8fNSBs5uZYPPpy5nnA9/uOibSQbmN3KwPCAK1kEtTHF+hew==
X-Received: by 2002:a17:902:ab01:b0:178:fee:c607 with SMTP id ik1-20020a170902ab0100b001780feec607mr2497889plb.20.1663638041017;
        Mon, 19 Sep 2022 18:40:41 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:720f:7de4:678:7fcb])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b00177e5d83d3esm62184plg.88.2022.09.19.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:40:40 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
Date:   Mon, 19 Sep 2022 18:40:36 -0700
Message-Id: <20220920014036.2295853-1-daeho43@gmail.com>
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

introduce a new ioctl to replace the whole content of a file atomically,
which means it induces truncate and content update at the same time.
We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
F2FS_IOC_ABORT_ATOMIC_WRITE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: add undefined ioctl number reported by <lkp@intel.com>
---
 fs/f2fs/data.c            |  3 +++
 fs/f2fs/f2fs.h            |  1 +
 fs/f2fs/file.c            | 12 ++++++++++--
 fs/f2fs/segment.c         | 14 +++++++++++++-
 include/uapi/linux/f2fs.h |  1 +
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6cd29a575105..d3d32db3a25d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3438,6 +3438,9 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	else if (*blk_addr != NULL_ADDR)
 		return 0;
 
+	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
+		goto reserve_block;
+
 	/* Look for the block in the original inode */
 	err = __find_data_block(inode, index, &ori_blk_addr);
 	if (err)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 539da7f12cfc..2c49da12d6d8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,6 +764,7 @@ enum {
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
+	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4f9b80c41b1e..4abd9d2a55b3 100644
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
+		set_inode_flag(inode, FI_ATOMIC_REPLACE);
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
index 143b7ea0fb8e..c524538a9013 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -263,14 +263,26 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
 	struct revoke_entry *cur, *tmp;
+	pgoff_t start_index = 0;
+	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
 
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
+		clear_inode_flag(inode, FI_ATOMIC_REPLACE);
+	}
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 3121d127d5aa..955d440be104 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -42,6 +42,7 @@
 						struct f2fs_comp_option)
 #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
 #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
+#define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.37.3.968.ga6b4b080e4-goog

