Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470C9628C38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiKNWlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiKNWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:41:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9F1B1C2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:41:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1581A61484
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA41C433D6;
        Mon, 14 Nov 2022 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668465660;
        bh=olfR9Am7e7LihSTC4XZw+WKMvzuScYsqDi3z4isZ8eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLgE6+P0xmjtpw0a01T8mUa1s1gKiHvhkPy5+O/pgiZzvLkkcR3qQAqko/mCnkMUj
         DFWYHYX6FDFy5pK6+B3V6NhGSNEPkvWpPKu6Spg/SakteC7HaC2bslkBuzYmXMBXeR
         GzaUwL9/vgcARqPFGvU++jbC5NUFkgLaxxXVNiHy2pqJpSeacAcpAolFsMSyzKEUXl
         ohYx1m3xA3690+kVnH7myJp6TIgfQ6VEivI1k8vBEiRlV6nShkeGBnXSjSOfK9QfP7
         ZsPUmUQ6kUbtJawwN+nzoen1qOpujpB9CtKG9PllzzJGHRKDf5289ndLPZdy9VbFUx
         V+3BrPELzZj1w==
Date:   Mon, 14 Nov 2022 14:40:58 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] f2fs: move set_file_temperature into
 f2fs_new_inode
Message-ID: <Y3LD+s0SOf3ka5if@google.com>
References: <20221111100830.953733-1-shengyong@oppo.com>
 <20221111100830.953733-2-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111100830.953733-2-shengyong@oppo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the file name has already passed to f2fs_new_inode(), let's
move set_file_temperature() into f2fs_new_inode().

Signed-off-by: Sheng Yong <shengyong@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 62 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 43b721d8e491..88e406bb6780 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -173,6 +173,32 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 	}
 }
 
+/*
+ * Set file's temperature for hot/cold data separation
+ */
+static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
+		const unsigned char *name)
+{
+	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
+	int i, cold_count, hot_count;
+
+	f2fs_down_read(&sbi->sb_lock);
+	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
+	hot_count = sbi->raw_super->hot_ext_count;
+	for (i = 0; i < cold_count + hot_count; i++)
+		if (is_extension_exist(name, extlist[i], true))
+			break;
+	f2fs_up_read(&sbi->sb_lock);
+
+	if (i == cold_count + hot_count)
+		return;
+
+	if (i < cold_count)
+		file_set_cold(inode);
+	else
+		file_set_hot(inode);
+}
+
 static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 						struct inode *dir, umode_t mode,
 						const char *name)
@@ -273,6 +299,9 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
 		set_inode_flag(inode, FI_INLINE_DATA);
 
+	if (name && !test_opt(sbi, DISABLE_EXT_IDENTIFY))
+		set_file_temperature(sbi, inode, name);
+
 	stat_inc_inline_xattr(inode);
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
@@ -301,36 +330,6 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	return ERR_PTR(err);
 }
 
-/*
- * Set file's temperature for hot/cold data separation
- */
-static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
-		const unsigned char *name)
-{
-	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
-	int i, cold_count, hot_count;
-
-	f2fs_down_read(&sbi->sb_lock);
-
-	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
-	hot_count = sbi->raw_super->hot_ext_count;
-
-	for (i = 0; i < cold_count + hot_count; i++) {
-		if (is_extension_exist(name, extlist[i], true))
-			break;
-	}
-
-	f2fs_up_read(&sbi->sb_lock);
-
-	if (i == cold_count + hot_count)
-		return;
-
-	if (i < cold_count)
-		file_set_cold(inode);
-	else
-		file_set_hot(inode);
-}
-
 static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
@@ -352,9 +351,6 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
-		set_file_temperature(sbi, inode, dentry->d_name.name);
-
 	inode->i_op = &f2fs_file_inode_operations;
 	inode->i_fop = &f2fs_file_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
-- 
2.38.1.493.g58b659f92b-goog

