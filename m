Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB486D0880
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjC3OlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjC3OlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:41:13 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D39778
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680187263;
  x=1711723263;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=im1xHFBiQBfuSGAUiVkeWoF5rTdTuQGdGDQOsjFK6VE=;
  b=eHL/G2qJgbMF4pV+ALpl9LSJePbHS3t/9uAJuhngis00yDNFHNaT3IoK
   TZSlRogD+K2A7XoQZ4KQRtBRfLovOlD2ukviKdbtFO825nZzMyRKBRZo5
   Dakn03lYohnxxtTLZJXhfzbyP/bPprIgcjHPRIhd9I/MwBgZUFuzKTauv
   +u06XQDtAkng0hKZJMFwIaKNaTUo+FPSreZcDuAlHtQ0kzGJsPYGJyTQ3
   Tw7L55DxJRRs86MeuBMApoiSdkUAwaM2BTafgdJ1oVq1w/GI2bZCcBU2W
   LU2giTFg9nthHYY5XyDXFLm6MEyf2G+Z4rTt/KyF8AwtQDqZpnJQ5ONLC
   g==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Thu, 30 Mar 2023 16:40:59 +0200
Subject: [PATCH v2] ubifs: Fix memory leak in do_rename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230330-memleak_rename-fix-v2-1-687242e41163@axis.com>
X-B4-Tracking: v=1; b=H4sIAHufJWQC/32NWwqDMBBFtyLz3ZRo+jB+dR9FyqiTGtrEMiNiE
 ffe6AL6c+HcmctZQIg9CVTZAkyTFz/EBMUhg7bH+CTlu8RQ6MJoY7QKFN6ErwdTxEDK+VldnD1
 hCmvOGtKwQSHVMMa236YBZSTeDh+m9L/b7nXi3ss48HeXT/nW/vVMucqVtdfSktWl69wNZy/Hd
 ghQr+v6A9vuNafMAAAA
To:     Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Zhihao Cheng" <chengzhihao1@huawei.com>, <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680187260; l=2535;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=3mcJAPvJidZPoHyhj7PF7QetETALl5dvWMu5ksFMcR4=;
 b=1QH4dNzVxp3TRA84Ml2WSVq5Mz1/T7nZsqLUNPuClYid7nEfOTs18BxvuT/LFjsF89+h+AmQF
 fnKcJ3om58KC1qLuZeskLbuugUYkXgAioDfe151guJ6JeP4s7aV+ZZ+
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If renaming a file in an encrypted directory, function
fscrypt_setup_filename allocates memory for a file name. This name is
never used, and before returning to the caller the memory for it is not
freed.

When running kmemleak on it we see that it is registered as a leak. The
report below is triggered by a simple program 'rename' that renames a
file in an encrypted directory:

  unreferenced object 0xffff888101502840 (size 32):
    comm "rename", pid 9404, jiffies 4302582475 (age 435.735s)
    backtrace:
      __kmem_cache_alloc_node
      __kmalloc
      fscrypt_setup_filename
      do_rename
      ubifs_rename
      vfs_rename
      do_renameat2

To fix this we can remove the call to fscrypt_setup_filename as it's not
needed.

Fixes: 278d9a243635f26 ("ubifs: Rename whiteout atomically")
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
Changes in v2:
- Added Fixes tag
- Added Reviewed-by tag from Zhihao Cheng
- Link to v1: https://lore.kernel.org/r/20230330-memleak_rename-fix-v1-1-99789e908fdf@axis.com
---
 fs/ubifs/dir.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 0f29cf201136..4c2dda1346e7 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -358,7 +358,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	umode_t mode = S_IFCHR | WHITEOUT_MODE;
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	struct fscrypt_name nm;
 
 	/*
 	 * Create an inode('nlink = 1') for whiteout without updating journal,
@@ -369,10 +368,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
 		dentry, mode, dir->i_ino);
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
-	if (err)
-		return ERR_PTR(err);
-
 	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -395,7 +390,6 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	make_bad_inode(inode);
 	iput(inode);
 out_free:
-	fscrypt_free_filename(&nm);
 	ubifs_err(c, "cannot create whiteout file, error %d", err);
 	return ERR_PTR(err);
 }

---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230330-memleak_rename-fix-6f94a6f99350

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

