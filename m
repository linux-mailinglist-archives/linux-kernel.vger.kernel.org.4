Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05017147E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjE2K1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjE2K1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F47C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156DC62340
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBF9C433D2;
        Mon, 29 May 2023 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356033;
        bh=2J0FBu1GLBGRIwQwggebk9BRVoGLrhgLuRFIuckJHHI=;
        h=From:To:Cc:Subject:Date:From;
        b=ZzFpUyN1Y0Elgj3/GK6QytCMNyzm0lSghJfxOy4B+QZ/2pqiGQ83xBbFFnHlXHiYA
         SMT8UDDbDer7ud8vybF0cqIpRgm2pXLgreUXkf0pH5Y9RlgQmUUmskM2cS82BuD/2w
         HOaUpc9Q7V0vhnlXtXpgNrxcs6moh/qGjifY6oWcerz6hcdnRwliMhH9r7DR0Hn9UW
         uOJ3rSuWyfktLvl1l9solrbXJBjU0brN3YP3nWKWZAvmWMTBC8d821h/aanUNUDpX8
         J+woCbqvJ7iYeXfpg+B9JrlpktwQGGJIKPTq2r8jDzPxo1AhdszwXdFsno+IAj4AWz
         d/aXcc1S5PzGA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid mmap vs set_compress_option case
Date:   Mon, 29 May 2023 18:27:05 +0800
Message-Id: <20230529102705.2546993-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Avoid such race condition by covering f2fs_file_mmap() w/ inode lock.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b097ab2f5e4..685ded62fc28 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -519,17 +519,25 @@ static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
+	int ret = 0;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
-	if (!f2fs_is_compress_backend_ready(inode))
-		return -EOPNOTSUPP;
+	inode_lock(inode);
+
+	if (!f2fs_is_compress_backend_ready(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
 
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
 	set_inode_flag(inode, FI_MMAP_FILE);
-	return 0;
+
+out_unlock:
+	inode_unlock(inode);
+	return ret;
 }
 
 static int f2fs_file_open(struct inode *inode, struct file *filp)
-- 
2.40.1

