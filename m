Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D824B661CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjAIDpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjAIDpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:45:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1DD2DC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8993A60EAD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FC3C433D2;
        Mon,  9 Jan 2023 03:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673235919;
        bh=hKDOr8JIcD75xkm83bOzZlDNnSHJYgKqfFQhYck7fao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnz5Izj6HLtcxq0IIK6AI95gkyGbaKgKRuG+asb279Pl0s1mm1k0R+E41pV8g8Zew
         4jNTdjkDcybVvv8+/nEOzETVYM7RTOFSYd65UoKD8a7On4TvdZSP2JVXI6TviD4OrE
         U7iySzqLi/1nzSJkYhKTYg80ZDPvm7Z42YvVBWht0Wg+lheknO4vMaCbuf91Y5FlX3
         qwp10urnh9YwPbTsLjAYdLObjGSlGqOEl7aNM+4Cx7q3ZIlzMArRNsG6k0DOvAoW1V
         vwN0Q6yXUSW4drJRhnKnkcWpVaVajeZg82U0UAGynd+/QVfuz8PlL0eCX5d4wxyU3M
         /KHS/LAe3//cA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 5/5] f2fs: fix to avoid race condition of atomic write
Date:   Mon,  9 Jan 2023 11:44:53 +0800
Message-Id: <20230109034453.490176-5-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
References: <20230109034453.490176-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A				Kworker
- application crashs
 - do_exit
  - close_files
   - filp_close
    - flush (f2fs_file_flush)
					- writepages
					 - f2fs_write_cache_pages
					  - f2fs_write_single_data_page
					   - f2fs_do_write_data_page
					    - check f2fs_is_atomic_file
     - f2fs_abort_atomic_write
      - check f2fs_is_atomic_file
      - iput(cow_inode)
      - cow_inode = NULL
					    - set_new_dnode(cow_inode)

Fix this issue by covering f2fs_do_write_data_page() with i_atomic_sem.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c940da1c540f..1645b8a1b904 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2637,13 +2637,24 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct dnode_of_data dn;
 	struct node_info ni;
 	bool ipu_force = false;
+	bool atomic_locked = false;
 	int err = 0;
 
 	/* Use COW inode to make dnode_of_data for atomic write */
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode)) {
+		f2fs_down_write(&F2FS_I(inode)->i_atomic_sem);
+		atomic_locked = true;
+
+		if (!f2fs_is_atomic_file(inode)) {
+			/* atomic write is aborted */
+			err = -ENOENT;
+			goto out_err;
+		}
+
 		set_new_dnode(&dn, F2FS_I(inode)->cow_inode, NULL, NULL, 0);
-	else
+	} else {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
+	}
 
 	if (need_inplace_update(fio) &&
 	    f2fs_lookup_read_extent_cache_block(inode, page->index,
@@ -2652,7 +2663,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 						DATA_GENERIC_ENHANCE)) {
 			f2fs_handle_error(fio->sbi,
 						ERROR_INVALID_BLKADDR);
-			return -EFSCORRUPTED;
+			err = -EFSCORRUPTED;
+			goto out_err;
 		}
 
 		ipu_force = true;
@@ -2661,8 +2673,10 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	}
 
 	/* Deadlock due to between page->lock and f2fs_lock_op */
-	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
-		return -EAGAIN;
+	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi)) {
+		err = -EAGAIN;
+		goto out_err;
+	}
 
 	err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
@@ -2710,6 +2724,9 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 			set_inode_flag(inode, FI_UPDATE_WRITE);
 		}
 		trace_f2fs_do_write_data_page(fio->page, IPU);
+
+		if (atomic_locked)
+			f2fs_up_write(&F2FS_I(inode)->i_atomic_sem);
 		return err;
 	}
 
@@ -2747,6 +2764,9 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 out:
 	if (fio->need_lock == LOCK_REQ)
 		f2fs_unlock_op(fio->sbi);
+out_err:
+	if (atomic_locked)
+		f2fs_up_write(&F2FS_I(inode)->i_atomic_sem);
 	return err;
 }
 
-- 
2.25.1

