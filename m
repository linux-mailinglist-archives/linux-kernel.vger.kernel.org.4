Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28836FCA3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjEIPaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:30:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333644BB;
        Tue,  9 May 2023 08:30:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aad5245632so43259015ad.3;
        Tue, 09 May 2023 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646201; x=1686238201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQP5RmhoA0Bn4VTuliIuZoGARX235KvX0CQ2pSlL4VE=;
        b=Ky+3UC8yvYNW4dMgABGgVl/Fpyy+4QXbHzMp04GgL5wPxGzSMJIpqqXqL7dtyttYfQ
         K72dnBATABy/0hZLK2Nb2NpY0X2sYIWOK30ZUhkXQDWf600l+R6xQWN8THuOpY1UY2Ib
         6cNQZpHhR8bDQThrP6KrG7OeJXbZLnlfOplC2PBpcrBARIHh3ZP7uScdE4m3qPJWVWPX
         4sVpGA7dZa40CHugC3oi5NrKCZdsxCX4loOj+I3DK6NfpCTI/La7nbqjLmdcu1Vk1YW2
         CgfD6eAp4kKIOvgTFDfac9aKYKF/1HegsrsX9GLSl4IeAiIbr/rI6BcnGt18nX7Umg8X
         ITcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646201; x=1686238201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQP5RmhoA0Bn4VTuliIuZoGARX235KvX0CQ2pSlL4VE=;
        b=KQ3dqOcb95C0CfLJUWB6MKwUduCAlWcJT5j8TbiLf7CdAq9PKMVwnyV8tOFOMfq+f4
         DjqcWtaPoeAsJ6TMWRqX0OKMkOJLDrDOJ4b5PFHP/T323fEaXUdtG+KzLmL3htsFRbF4
         lYkb0fzwUXmdrRmkaueBLdWgUhtzWtY46S0vxR7wDqvnIt0O6nu9G4sDbrYQ6vP/pFnG
         E7VGXyCbfxe6USuW9tQEDRzSKz872t/FWnAXoiY/xCPyAlpkp1M9T42S4NtqtIaRTDiB
         MA9tjCZEuQvdK7S9wW4mrHrnd2YV9yE89Inf2mkJ16MuKQTb9k8UI9SHgJeDMMLfZ/+J
         7A1w==
X-Gm-Message-State: AC+VfDxMlyi3P0b8Y9TrAlQUonqdEPJPvl7+nqEtCTpCvMUwVfnOIDKO
        8+isPQunzsxnV1CXYd03eFc=
X-Google-Smtp-Source: ACHHUZ64FRVdmHzlUfgzv+sL5ln9/qqgRV8DXEDi0AC6zAyu+terompFZE3TjrqfWs1/YXXGxoVxTg==
X-Received: by 2002:a17:903:124a:b0:1ac:4d01:dfec with SMTP id u10-20020a170903124a00b001ac4d01dfecmr17714741plh.54.1683646200795;
        Tue, 09 May 2023 08:30:00 -0700 (PDT)
Received: from carrot.. (i220-108-176-245.s42.a014.ap.plala.or.jp. [220.108.176.245])
        by smtp.gmail.com with ESMTPSA id bi7-20020a170902bf0700b001a9b29b6759sm1724423plb.183.2023.05.09.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:29:59 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()
Date:   Wed, 10 May 2023 00:29:56 +0900
Message-Id: <20230509152956.8313-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000099e5ac05fb1c3b85@google.com>
References: <00000000000099e5ac05fb1c3b85@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During unmount process of nilfs2, nothing holds nilfs_root structure after
nilfs2 detaches its writer in nilfs_detach_log_writer().  However, since
nilfs_evict_inode() uses nilfs_root for some cleanup operations, it may
cause use-after-free read if inodes are left in "garbage_list" and
released by nilfs_dispose_list() at the end of nilfs_detach_log_writer().

Fix this issue by modifying nilfs_evict_inode() to only clear inode
without additional metadata changes that use nilfs_root if the file system
is degraded to read-only or the writer is detached.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000099e5ac05fb1c3b85@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 1310d2d5feb3..a8ce522ac747 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -917,6 +917,7 @@ void nilfs_evict_inode(struct inode *inode)
 	struct nilfs_transaction_info ti;
 	struct super_block *sb = inode->i_sb;
 	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct the_nilfs *nilfs;
 	int ret;
 
 	if (inode->i_nlink || !ii->i_root || unlikely(is_bad_inode(inode))) {
@@ -929,6 +930,23 @@ void nilfs_evict_inode(struct inode *inode)
 
 	truncate_inode_pages_final(&inode->i_data);
 
+	nilfs = sb->s_fs_info;
+	if (unlikely(sb_rdonly(sb) || !nilfs->ns_writer)) {
+		/*
+		 * If this inode is about to be disposed after the file system
+		 * has been degraded to read-only due to file system corruption
+		 * or after the writer has been detached, do not make any
+		 * changes that cause writes, just clear it.
+		 * Do this check after read-locking ns_segctor_sem by
+		 * nilfs_transaction_begin() in order to avoid a race with
+		 * the writer detach operation.
+		 */
+		clear_inode(inode);
+		nilfs_clear_inode(inode);
+		nilfs_transaction_abort(sb);
+		return;
+	}
+
 	/* TODO: some of the following operations may fail.  */
 	nilfs_truncate_bmap(ii, 0);
 	nilfs_mark_inode_dirty(inode);
-- 
2.34.1

