Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A346A8556
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCBPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCBPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:36:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA25336693
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:36:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z5so18025133ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677771385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcHOXRPpYU7BjEJ0T+L+P0cPs7xnSChzurMMzz/0KLM=;
        b=YsijaPl5hJSqnOrWX2V5t5iqXNo5hiU1ra9yxk9scI5vj+AtQDEiF/7GwzX/mW2/9h
         2O/meYwWnGZ9gEt6Iukz2sVfNYpL++b8HBhyVDsrZ1qujIOlXWEk7eMM6GGMCe4HKxP4
         8y5YYeopa+fcuYktahi0r59H2y93LpAqWtazbsyzY09Uf24Ce7CYtmcb+BgmGd4fSdTw
         pzfZpzzkaH+jQm9and9CfQtbC4WUZVTlLD6qEJQ/vPbBC5nc13mzYuAgY3/4ZsoiAX4n
         K9hIwglmb25mlkhTk5BuOLd4WNJU8C35MTu8/wPwuhRHrqUM/SkO5/Fh3HPGTB1gbM55
         Pv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677771385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcHOXRPpYU7BjEJ0T+L+P0cPs7xnSChzurMMzz/0KLM=;
        b=NpEOlEYKOBopKIf1qmTnuvrxmrMtfR+ZiZcRF9/ipGCPz578c9YdbTbYdCOv84hf2K
         JC4hTfkim1IpXIqu+n9UtDv/VWXVEB+jzIcc0TrTSPWWmRf/g1SqZtZmyeCv980ooj+g
         d/WzvuU0TKbQdUT+of8+Gkxi2b+ha6aR9iAlyjG36no+M/h3eJ6INT/UAWSkCOhi+GDg
         uDJgADlhRcCITYGNgohWxosJsjiEdzw75+F10mkkY+R+KF9P2vPLOD/zmvXPb8i/SG5J
         LQBh4ZvUw0rv4JVxtHIDvFz5++CrHf6gWjqG2+aW04L9Yy5faFWKNxz8SpuuDBKIdk/+
         2FOw==
X-Gm-Message-State: AO0yUKUNvO0F10o8XGM7tHeNFnJbhiIvw1VtcDIHafqGQSYOeAVkHlMX
        CfWLxaJxrhbUDSF2wpuXwn/R0g==
X-Google-Smtp-Source: AK7set+BtoYHcHvVekSXPN3wrbwma5Hkyt5u8iKsExYBJs41tuxq+msuj6HNAU/q4KQXaWgiTPp7FA==
X-Received: by 2002:a2e:b60b:0:b0:290:6fa7:605a with SMTP id r11-20020a2eb60b000000b002906fa7605amr3304727ljn.45.1677771385220;
        Thu, 02 Mar 2023 07:36:25 -0800 (PST)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id p17-20020a05651238d100b004db2978e330sm2170509lft.258.2023.03.02.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 07:36:24 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     stable@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][for stable 5.{15, 10} 1/4] ext4: refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
Date:   Thu,  2 Mar 2023 15:36:07 +0000
Message-Id: <20230302153610.1204653-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230302153610.1204653-1-tudor.ambarus@linaro.org>
References: <20230302153610.1204653-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit 8ac3939db99f99667b8eb670cf4baf292896e72d ]

ext4_free_blocks() function became too long and confusing, this patch
just pulls out the ext4_mb_clear_bb() function logic from it
which clears the block bitmap and frees it.

No functionality change in this patch

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/22c30fbb26ba409cf8aa5f0c7912970272c459e8.1644992610.git.riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/mballoc.c | 180 ++++++++++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 78 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0c7498a59943..4418d011a654 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5888,7 +5888,8 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 }
 
 /**
- * ext4_free_blocks() -- Free given blocks and update quota
+ * ext4_mb_clear_bb() -- helper function for freeing blocks.
+ *			Used by ext4_free_blocks()
  * @handle:		handle for this transaction
  * @inode:		inode
  * @bh:			optional buffer of the block to be freed
@@ -5896,9 +5897,9 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
  * @count:		number of blocks to be freed
  * @flags:		flags used by ext4_free_blocks
  */
-void ext4_free_blocks(handle_t *handle, struct inode *inode,
-		      struct buffer_head *bh, ext4_fsblk_t block,
-		      unsigned long count, int flags)
+static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
+			       ext4_fsblk_t block, unsigned long count,
+			       int flags)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct super_block *sb = inode->i_sb;
@@ -5915,80 +5916,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 
 	sbi = EXT4_SB(sb);
 
-	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
-		ext4_free_blocks_simple(inode, block, count);
-		return;
-	}
-
-	might_sleep();
-	if (bh) {
-		if (block)
-			BUG_ON(block != bh->b_blocknr);
-		else
-			block = bh->b_blocknr;
-	}
-
-	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
-	    !ext4_inode_block_valid(inode, block, count)) {
-		ext4_error(sb, "Freeing blocks not in datazone - "
-			   "block = %llu, count = %lu", block, count);
-		goto error_return;
-	}
-
-	ext4_debug("freeing block %llu\n", block);
-	trace_ext4_free_blocks(inode, block, count, flags);
-
-	if (bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
-		BUG_ON(count > 1);
-
-		ext4_forget(handle, flags & EXT4_FREE_BLOCKS_METADATA,
-			    inode, bh, block);
-	}
-
-	/*
-	 * If the extent to be freed does not begin on a cluster
-	 * boundary, we need to deal with partial clusters at the
-	 * beginning and end of the extent.  Normally we will free
-	 * blocks at the beginning or the end unless we are explicitly
-	 * requested to avoid doing so.
-	 */
-	overflow = EXT4_PBLK_COFF(sbi, block);
-	if (overflow) {
-		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
-			overflow = sbi->s_cluster_ratio - overflow;
-			block += overflow;
-			if (count > overflow)
-				count -= overflow;
-			else
-				return;
-		} else {
-			block -= overflow;
-			count += overflow;
-		}
-	}
-	overflow = EXT4_LBLK_COFF(sbi, count);
-	if (overflow) {
-		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
-			if (count > overflow)
-				count -= overflow;
-			else
-				return;
-		} else
-			count += sbi->s_cluster_ratio - overflow;
-	}
-
-	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
-		int i;
-		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
-
-		for (i = 0; i < count; i++) {
-			cond_resched();
-			if (is_metadata)
-				bh = sb_find_get_block(inode->i_sb, block + i);
-			ext4_forget(handle, is_metadata, inode, bh, block + i);
-		}
-	}
-
 do_more:
 	overflow = 0;
 	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
@@ -6156,6 +6083,103 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	return;
 }
 
+/**
+ * ext4_free_blocks() -- Free given blocks and update quota
+ * @handle:		handle for this transaction
+ * @inode:		inode
+ * @bh:			optional buffer of the block to be freed
+ * @block:		starting physical block to be freed
+ * @count:		number of blocks to be freed
+ * @flags:		flags used by ext4_free_blocks
+ */
+void ext4_free_blocks(handle_t *handle, struct inode *inode,
+		      struct buffer_head *bh, ext4_fsblk_t block,
+		      unsigned long count, int flags)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int overflow;
+	struct ext4_sb_info *sbi;
+
+	sbi = EXT4_SB(sb);
+
+	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+		ext4_free_blocks_simple(inode, block, count);
+		return;
+	}
+
+	might_sleep();
+	if (bh) {
+		if (block)
+			BUG_ON(block != bh->b_blocknr);
+		else
+			block = bh->b_blocknr;
+	}
+
+	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
+	    !ext4_inode_block_valid(inode, block, count)) {
+		ext4_error(sb, "Freeing blocks not in datazone - "
+			   "block = %llu, count = %lu", block, count);
+		return;
+	}
+
+	ext4_debug("freeing block %llu\n", block);
+	trace_ext4_free_blocks(inode, block, count, flags);
+
+	if (bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
+		BUG_ON(count > 1);
+
+		ext4_forget(handle, flags & EXT4_FREE_BLOCKS_METADATA,
+			    inode, bh, block);
+	}
+
+	/*
+	 * If the extent to be freed does not begin on a cluster
+	 * boundary, we need to deal with partial clusters at the
+	 * beginning and end of the extent.  Normally we will free
+	 * blocks at the beginning or the end unless we are explicitly
+	 * requested to avoid doing so.
+	 */
+	overflow = EXT4_PBLK_COFF(sbi, block);
+	if (overflow) {
+		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
+			overflow = sbi->s_cluster_ratio - overflow;
+			block += overflow;
+			if (count > overflow)
+				count -= overflow;
+			else
+				return;
+		} else {
+			block -= overflow;
+			count += overflow;
+		}
+	}
+	overflow = EXT4_LBLK_COFF(sbi, count);
+	if (overflow) {
+		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
+			if (count > overflow)
+				count -= overflow;
+			else
+				return;
+		} else
+			count += sbi->s_cluster_ratio - overflow;
+	}
+
+	if (!bh && (flags & EXT4_FREE_BLOCKS_FORGET)) {
+		int i;
+		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
+
+		for (i = 0; i < count; i++) {
+			cond_resched();
+			if (is_metadata)
+				bh = sb_find_get_block(inode->i_sb, block + i);
+			ext4_forget(handle, is_metadata, inode, bh, block + i);
+		}
+	}
+
+	ext4_mb_clear_bb(handle, inode, block, count, flags);
+	return;
+}
+
 /**
  * ext4_group_add_blocks() -- Add given blocks to an existing group
  * @handle:			handle to this transaction
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

