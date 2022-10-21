Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AB606DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJUCcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJUCc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:32:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4810F891
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:32:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f8-20020a17090a664800b00212464cd49fso1470917pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsvLhV+cbznBpgyq6mtNJgNZycGH3T3tCrg6LonEOp4=;
        b=j/PynzD1zbRkpecTxyYqHEf9VOlhdAnPFJOV+1z+gFkB1FSq6HINXXtTMGuFuIo6Ep
         wEQl2D20Ee1cv5aTkporTtwe1KX0xnjVB6MRsj5mecJRoCDoG0OyB663+yD0NRGrxC2n
         Wj61WEZrQUN9h6rOa7UpVVm+goCuZjsCSElc/VBeiDJvdjyNp6cFoc5JaZlCj6rKVBWe
         mrahL6X5dThTNxDZ0uSvimWvEHIM7ToHfEcJ4rD7Wqvc/AVQiiRkyq02KQ87OM7lzVt1
         1LKIjfxxR0cpcrkZS+dcv3HhTYsjuDY5Qf8G60IcL5OnioJ/qJr9awS47USK4Vsqa9Pq
         UrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsvLhV+cbznBpgyq6mtNJgNZycGH3T3tCrg6LonEOp4=;
        b=1VZ9ILD+xhkxvQNJDjbGEFxwAfgZZqfXCdKDWsrEljppsz3M/8qIYZnoOMZQeAyywW
         4NUJbO1hTo78Isw5Mw48g+lwIfULplQGzXHjoOb2dRQV4c/0Eq7UhdTNymGafPtM1+1M
         qfoXVs9GW1RJwRf/FmfCMrsEscuM4Q7vflyCKbUl/uwRdFQwWoh1Ewwkg/AEu80IdvbJ
         PZyKoQ3rmj6aMv2+Da44lH9TyQBSM32M/DxzARno/lk6CntGJiz1yvmpD3v1gn9q/e/G
         rxAtJUqYtqWBQZJIH7xH6e/PoX8FIBm9N084s+KwH3GyElo2QaQm6FtgJudFOtTlvt7o
         CtRA==
X-Gm-Message-State: ACrzQf1/JiDgyfYnuqD8cZnCLxXLhW28ACV8saBdMBKyGFhuLgWaRDeQ
        USW/WUXOjVbJDakUKiAzcoQ=
X-Google-Smtp-Source: AMsMyM7XIQHtE3EZUCPvUCzBIEy8P10eqv0oWue4UomJiecL9ou04VigPmr21N4CME/yWIltLfobfw==
X-Received: by 2002:a17:902:ed93:b0:185:4421:24b with SMTP id e19-20020a170902ed9300b001854421024bmr16735349plj.158.1666319547482;
        Thu, 20 Oct 2022 19:32:27 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id v129-20020a626187000000b00565f4efbc0csm1291080pfb.49.2022.10.20.19.32.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 19:32:25 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: [PATCH] f2fs: separate IPU policy for fdatasync from F2FS_IPU_FSYNC
Date:   Fri, 21 Oct 2022 10:31:36 +0800
Message-Id: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
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

Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
Fix to apply it to all IPU policy.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fs/f2fs/data.c | 8 +++-----
 fs/f2fs/file.c | 4 +++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a71e818cd67b..fec8e15fe820 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
 			is_inode_flag_set(inode, FI_OPU_WRITE))
 		return false;
+	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
+	if (is_inode_flag_set(inode, FI_NEED_IPU))
+		return true;
 	if (policy & (0x1 << F2FS_IPU_FORCE))
 		return true;
 	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
@@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 			!IS_ENCRYPTED(inode))
 		return true;
 
-	/* this is only set during fdatasync */
-	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
-			is_inode_flag_set(inode, FI_NEED_IPU))
-		return true;
-
 	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
 		return true;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82cda1258227..08091550cdf2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto go_write;
 
 	/* if fdatasync is triggered, let's do in-place-update */
-	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
+	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
+			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
 		set_inode_flag(inode, FI_NEED_IPU);
+
 	ret = file_write_and_wait_range(file, start, end);
 	clear_inode_flag(inode, FI_NEED_IPU);
 
-- 
2.36.1

