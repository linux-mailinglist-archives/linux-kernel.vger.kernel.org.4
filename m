Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E650B73D0A6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjFYLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57A11A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 04:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3822060BA9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 11:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C0AC433C0;
        Sun, 25 Jun 2023 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687694067;
        bh=Ch2PkuYne+BSGDeUtDNlSfgVPijfci/1QU9ugIlHiwo=;
        h=From:To:Cc:Subject:Date:From;
        b=q/v3pa3mroDWQGJkh02iAz3tPzW5pMe9WmniobjxiBl05R5WtG5Zq2gXQyEwLGLL+
         hCqkTxHbQGaXgK+9Maie/MdYZc8xXNst9q7e0hu4rQPOYax1zurkF6mEL/dH4H/eio
         MvSO/5xnjcVKN4UyaJjVijNkqM9BFUQbVnOrau15GjO4x6rfqjzNC710dFD30BtFso
         ABwBQxZ+ouhScvvirtdTriMlOPXEXZiT9Qd2PjWC/2KuaCM0Mqh0ezfghs4NASqFVv
         2m6eud7tzJbAKpslrccERQKa6BxYY1ZjtWvtzpGDhYRoTVdYFkvzM3eIau2DSp+C/O
         DDTAgL8aurnQQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to avoid mmap vs set_compress_option case
Date:   Sun, 25 Jun 2023 19:54:20 +0800
Message-Id: <20230625115420.3138459-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compression option in inode should not be changed after they have
been used, however, it may happen in below race case:

Thread A				Thread B
- f2fs_ioc_set_compress_option
 - check f2fs_is_mmap_file()
 - check get_dirty_pages()
 - check F2FS_HAS_BLOCKS()
					- f2fs_file_mmap
					 - set_inode_flag(FI_MMAP_FILE)
					- fault
					 - do_page_mkwrite
					  - f2fs_vm_page_mkwrite
					  - f2fs_get_block_locked
					 - fault_dirty_shared_page
					  - set_page_dirty
 - update i_compress_algorithm
 - update i_log_cluster_size
 - update i_cluster_size

Avoid such race condition by covering f2fs_file_mmap() w/ i_sem lock,
meanwhile add mmap file check condition in f2fs_may_compress() as well.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix potential deadlock.
 fs/f2fs/f2fs.h |  3 ++-
 fs/f2fs/file.c | 23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68759922d081..7b9af2d51656 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4483,7 +4483,8 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode))
+		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode) ||
+		f2fs_is_mmap_file(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4d22d2c5ab4b..9d760c26adb0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -528,7 +528,11 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
+
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
 	set_inode_flag(inode, FI_MMAP_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	return 0;
 }
 
@@ -1926,12 +1930,19 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			int err = f2fs_convert_inline_inode(inode);
 			if (err)
 				return err;
-			if (!f2fs_may_compress(inode))
-				return -EINVAL;
-			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
+
+			f2fs_down_write(&F2FS_I(inode)->i_sem);
+			if (!f2fs_may_compress(inode) ||
+					(S_ISREG(inode->i_mode) &&
+					F2FS_HAS_BLOCKS(inode))) {
+				f2fs_up_write(&F2FS_I(inode)->i_sem);
 				return -EINVAL;
-			if (set_compress_context(inode))
-				return -EOPNOTSUPP;
+			}
+			err = set_compress_context(inode);
+			f2fs_up_write(&F2FS_I(inode)->i_sem);
+
+			if (err)
+				return err;
 		}
 	}
 
@@ -3970,6 +3981,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
@@ -3989,6 +4001,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		f2fs_warn(sbi, "compression algorithm is successfully set, "
 			"but current kernel doesn't support this algorithm.");
 out:
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	inode_unlock(inode);
 	file_end_write(filp);
 
-- 
2.40.1

