Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C05F324D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJCPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJCPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:05:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950761B9FE;
        Mon,  3 Oct 2022 08:05:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f193so9939905pgc.0;
        Mon, 03 Oct 2022 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ezoaBJIqRF7gg3OoVAkSemBRNoXtolfSSBzIMhoaSGI=;
        b=SZHyb4Rjp36YHYykDDQ3ZcOlnLFNVIk5WEX2UQcpDrbLzDZTOlE+aKtkDmELWkbcYb
         BqGGlm2lr1FNI0XT+ygAmxUjabea4DI4P5MX5zDS9nVrbVFm75vtptTfRldu0yWqJ4r4
         MhvFEjd0KM+WV1m1dDEs8QqZUIzhFoiGuymTKyH0eWDh3Aoy7qD7v7WVZ1FXAy9T8Las
         t8NzxNyc0/icf2kZAkhPQa3Ip49+kme0YAzNlH+/MPW4GQkkf1UZexR1sbT7IK6KzG1L
         Kb+p0M7BQTQuTS7ipBPGQxu9K2sS12jlTRbmqQZ8JwAPcRGljSmOW0yOKDqsNNFFB9NY
         rlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ezoaBJIqRF7gg3OoVAkSemBRNoXtolfSSBzIMhoaSGI=;
        b=BWbp2nFIGZVBpVGaY3d0Nj+rTCsa703yTTskrhvZ+B/Q5hbEPCbiwh54I8X63ENhDr
         Kf25OzenTPYuzk7PnK0LtUv+8raMfzvVoWTnlQlku7v0RsENRiTpe3YXPtG1hjxLXiGJ
         4ryWynpsEtFJlEJlxFQykq9fkiD7eAgHmG2f6vE7Xg+RoLfsiC/knljJQaZs0HPuOaho
         +JVgsv494PMMbS367Wf0W/qOCos1iNRtC5KnDo67UV4yNMmRrnOWOgz9Vx9hyiBF6JR9
         2tASY3yXNElS4B3vBQtwkVy1jOzLpS1tJ0mNeRODr8WjtJa+fJSEly9wNUFxe/Sze36f
         +NFQ==
X-Gm-Message-State: ACrzQf2h67FBubEcEDq0ZuaDactkGXK4Cod/ZUYH/wtzVsZYrD62n/dx
        WYOfNRwm4rIyGVHoPv8U5MJ0qBB+c5k=
X-Google-Smtp-Source: AMsMyM5hDd8rl7H0sg8T64TzHvyh01H8qi0lJfGnrfOWV1SGTdgtNXC9zkyjUkNxpBcHjqDR97peLA==
X-Received: by 2002:a05:6a00:80b:b0:545:c0d2:9729 with SMTP id m11-20020a056a00080b00b00545c0d29729mr22946628pfk.66.1664809524565;
        Mon, 03 Oct 2022 08:05:24 -0700 (PDT)
Received: from carrot.. (i220-109-170-101.s42.a014.ap.plala.or.jp. [220.109.170.101])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0017e64da44c5sm3635947plx.203.2022.10.03.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:05:23 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+b8c672b0e22615c80fe0@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix use-after-free bug of struct nilfs_root
Date:   Tue,  4 Oct 2022 00:05:19 +0900
Message-Id: <20221003150519.39789-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000219dcd05e9f95ed9@google.com>
References: <000000000000219dcd05e9f95ed9@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the beginning of the inode bitmap area is corrupted on disk, an
inode with the same inode number as the root inode can be allocated
and fail soon after.  In this case, the subsequent call to
nilfs_clear_inode() on that bogus root inode will wrongly decrement
the reference counter of struct nilfs_root, and this will erroneously
free struct nilfs_root, causing kernel oopses.

This fixes the problem by changing nilfs_new_inode() to skip reserved
inode numbers while repairing the inode bitmap.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+b8c672b0e22615c80fe0@syzkaller.appspotmail.com
Reported-by: Khalid Masum <khalid.masum.92@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 67f63cfeade5..b074144f6f83 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -328,6 +328,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	struct inode *inode;
 	struct nilfs_inode_info *ii;
 	struct nilfs_root *root;
+	struct buffer_head *bh;
 	int err = -ENOMEM;
 	ino_t ino;
 
@@ -343,11 +344,25 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	ii->i_state = BIT(NILFS_I_NEW);
 	ii->i_root = root;
 
-	err = nilfs_ifile_create_inode(root->ifile, &ino, &ii->i_bh);
+	err = nilfs_ifile_create_inode(root->ifile, &ino, &bh);
 	if (unlikely(err))
 		goto failed_ifile_create_inode;
 	/* reference count of i_bh inherits from nilfs_mdt_read_block() */
 
+	if (unlikely(ino < NILFS_USER_INO)) {
+		nilfs_warn(sb,
+			   "inode bitmap is inconsistent for reserved inodes");
+		do {
+			brelse(bh);
+			err = nilfs_ifile_create_inode(root->ifile, &ino, &bh);
+			if (unlikely(err))
+				goto failed_ifile_create_inode;
+		} while (ino < NILFS_USER_INO);
+
+		nilfs_info(sb, "repaired inode bitmap for reserved inodes");
+	}
+	ii->i_bh = bh;
+
 	atomic64_inc(&root->inodes_count);
 	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_ino = ino;
-- 
2.34.1

