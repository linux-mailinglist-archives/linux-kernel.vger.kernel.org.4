Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2D6A855C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCBPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCBPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:36:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83D360BD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:36:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t11so22676924lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677771386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gdId53Dyw2GpHctsUcNS/lVxL2AmQmaS15K9tykDPs=;
        b=XdT166J/QndycjCUH2wF0qEwJV08gQQLP6JJWmMTO4zVyiH5rpasQ3Jca64N0jvjHk
         pDgmjZlP7ENS7xmC9K1oZAqv3VfM2jTYnqAzrxyZwhkjRMYQQewb7RDg5McUuaCuc3bz
         0qEJYj3lm6TRk175jeCh1Z3RLpMra5CzzeifUV+nwUY9kx1msmd6JvvixTJ8WRwzp6xt
         xYIFK8Gae04geIxspLhYPvf9E9JBc7age6/LoIEqnBrXgxs535q+dbmwRyTzkTk/f9/T
         OKdAjIkfLto5U8fOxziqXvfh6PTYamJpyUGEcgSbUZ1YgoYgJMAYlEmTxwH2T60thAq1
         l4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677771386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gdId53Dyw2GpHctsUcNS/lVxL2AmQmaS15K9tykDPs=;
        b=L3hlTP08kuNlItkVe/xkP6ZJVXaLYcP1Hn4yxMATkFCJB0ecEr/CRRzvT4nKd43gep
         M9+OBtkneLTSnuf41nsNQm9q4LvDIrLkQLWBw0Fk2b29/ThPlbC3ba1J68z7ya0Ps6+/
         NyRawUkOqXyMGylQt/4uPLDnqKfRXemZHmKc9aOOYzEqQsyuGo4U7TT/MiqTYjF6XF1C
         iuo0lt1RTnldgKuEhrTm9icU/1wVKfwHx6uCA+PRK6r1b5/jX0oP56fHUyxpKV6KjGKl
         pGUbexpSqxdo+FvU3EzGVuSVhwqlwLZPrk3Vtt5PvYRig9BDNpRmdsmz/JFDvSKwErfz
         VT5A==
X-Gm-Message-State: AO0yUKUcOcPb9vKsDxC9A/k6uf1hyU/4Kk48WchHLACME+noO3bvUu2r
        zu2koBK1Biud0rcQGdC0y27CVg==
X-Google-Smtp-Source: AK7set+4+8xAxb5SSt2w7KuJV3dOH53ByauHa3PtpPAtU+bO92ZOVYVojb/fOUxtOglsU/VZFd/tFg==
X-Received: by 2002:ac2:4213:0:b0:4dd:ad4b:efd with SMTP id y19-20020ac24213000000b004ddad4b0efdmr2844820lfh.52.1677771386183;
        Thu, 02 Mar 2023 07:36:26 -0800 (PST)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id p17-20020a05651238d100b004db2978e330sm2170509lft.258.2023.03.02.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 07:36:25 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     stable@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][for stable 5.{15, 10} 2/4] ext4: add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
Date:   Thu,  2 Mar 2023 15:36:08 +0000
Message-Id: <20230302153610.1204653-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230302153610.1204653-1-tudor.ambarus@linaro.org>
References: <20230302153610.1204653-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit 6bc6c2bdf1baca6522b8d9ba976257d722423085 ]

This API will be needed at places where we don't have an inode
for e.g. while freeing blocks in ext4_group_add_blocks()

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/dd34a236543ad5ae7123eeebe0cb69e6bdd44f34.1644992610.git.riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/block_validity.c | 26 +++++++++++++++++---------
 fs/ext4/ext4.h           |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 4666b55b736e..5504f72bbbbe 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -292,15 +292,10 @@ void ext4_release_system_zone(struct super_block *sb)
 		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
 }
 
-/*
- * Returns 1 if the passed-in block region (start_blk,
- * start_blk+count) is valid; 0 if some part of the block region
- * overlaps with some other filesystem metadata blocks.
- */
-int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
-			  unsigned int count)
+int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
+				ext4_fsblk_t start_blk, unsigned int count)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_system_blocks *system_blks;
 	struct ext4_system_zone *entry;
 	struct rb_node *n;
@@ -329,7 +324,9 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 		else if (start_blk >= (entry->start_blk + entry->count))
 			n = n->rb_right;
 		else {
-			ret = (entry->ino == inode->i_ino);
+			ret = 0;
+			if (inode)
+				ret = (entry->ino == inode->i_ino);
 			break;
 		}
 	}
@@ -338,6 +335,17 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 	return ret;
 }
 
+/*
+ * Returns 1 if the passed-in block region (start_blk,
+ * start_blk+count) is valid; 0 if some part of the block region
+ * overlaps with some other filesystem metadata blocks.
+ */
+int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
+			  unsigned int count)
+{
+	return ext4_sb_block_valid(inode->i_sb, inode, start_blk, count);
+}
+
 int ext4_check_blockref(const char *function, unsigned int line,
 			struct inode *inode, __le32 *p, unsigned int max)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bc209f303327..80f0942fa165 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3698,6 +3698,9 @@ extern int ext4_inode_block_valid(struct inode *inode,
 				  unsigned int count);
 extern int ext4_check_blockref(const char *, unsigned int,
 			       struct inode *, __le32 *, unsigned int);
+extern int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
+				ext4_fsblk_t start_blk, unsigned int count);
+
 
 /* extents.c */
 struct ext4_ext_path;
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

