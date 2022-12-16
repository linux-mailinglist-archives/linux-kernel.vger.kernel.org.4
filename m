Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184864EE2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiLPPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiLPPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880362E95
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65421B81DB4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F8C433D2;
        Fri, 16 Dec 2022 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671205811;
        bh=xZloe09AW17HVtjG+PDx0+BDGoNg91KCvWJB7A5php0=;
        h=From:To:Cc:Subject:Date:From;
        b=WvmalPl1UE2rei7ENXwYAxg7Q6rJ4dC4d+Xj3y6Sc/j6a/8J5daQlQNSjd5X8pAaa
         iKbj6oef4Knm+xJPDyWAvB8aGf0lD7LISQIKNxZCXcividtmVvzM4eoAF7VcWcqv9m
         Vu/Evr0j7/3K36nbWRcwio0XL9NdCtDZFzYTqdKDjS4L9kj2QNyAjQVWVA/gIS1SAu
         ho6/dKnm1XxiKsci2/K6xYnkqB5rUfrTbS3+7Aq3XpqLJRqfWKjPVSWwbQSVG5q7br
         l0S8v84MlpLboLAxe0VfgJAdQAudojXmVJIdwoxx3wpKqAtX5MxPGSN8y1qVn6sbbu
         e8pKMwfbfbFAA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        syzbot+4793f6096d174c90b4f7@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to avoid potential deadlock
Date:   Fri, 16 Dec 2022 23:50:00 +0800
Message-Id: <20221216155000.3204-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
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

There is a potential deadlock reported by syzbot as below:

F2FS-fs (loop2): invalid crc value
F2FS-fs (loop2): Found nat_bits in checkpoint
F2FS-fs (loop2): Mounted with checkpoint version = 48b305e4
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
------------------------------------------------------
syz-executor.2/32123 is trying to acquire lock:
ffff0000c0e1a608 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5644

but task is already holding lock:
ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2334 [inline]
ffff0001317c6088 (&sbi->sb_lock){++++}-{3:3}, at: __f2fs_ioctl+0x1370/0x3318 fs/f2fs/file.c:4151

which lock already depends on the new lock.

Chain exists of:
  &mm->mmap_lock --> &nm_i->nat_tree_lock --> &sbi->sb_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->sb_lock);
                               lock(&nm_i->nat_tree_lock);
                               lock(&sbi->sb_lock);
  lock(&mm->mmap_lock);

Let's try to avoid above deadlock condition by moving __might_fault()
out of sbi->sb_lock coverage.

Fixes: 95fa90c9e5a7 ("f2fs: support recording errors into superblock")
Link: https://lore.kernel.org/linux-f2fs-devel/000000000000cd5fe305ef617fe2@google.com/T/#u
Reported-by: syzbot+4793f6096d174c90b4f7@syzkaller.appspotmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cad4bdd6f097..4bc98dbe8292 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2336,6 +2336,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	u8 encrypt_pw_salt[16];
 	int err;
 
 	if (!f2fs_sb_has_encrypt(sbi))
@@ -2360,12 +2361,14 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 		goto out_err;
 	}
 got_it:
-	if (copy_to_user((__u8 __user *)arg, sbi->raw_super->encrypt_pw_salt,
-									16))
-		err = -EFAULT;
+	memcpy(encrypt_pw_salt, sbi->raw_super->encrypt_pw_salt, 16);
 out_err:
 	f2fs_up_write(&sbi->sb_lock);
 	mnt_drop_write_file(filp);
+
+	if (!err && copy_to_user((__u8 __user *)arg, encrypt_pw_salt, 16))
+		err = -EFAULT;
+
 	return err;
 }
 
-- 
2.36.1

