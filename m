Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E71611883
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ1Q7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJ1Q6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:58:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618F91C4ED3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14D2CB82BA0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C77C433D6;
        Fri, 28 Oct 2022 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976308;
        bh=NB0C0XzePklNj5LqvcpaBIGZcLpM/zxQPQkwfYE8xes=;
        h=From:To:Cc:Subject:Date:From;
        b=AkIgq6yW2OlEt6AJS7pE04e2O5YRC47NvexFUTDp0DIrugH9DjiNky5t6paHsWK+b
         P1zeRA25HRW5Eb/rJ04l4DFcVgiTTv/3/FQWGqwqBfpCl9UhJfFiZpI02UOOqc3zHN
         Uj4IHScoG28OvoC0va1fHxA/9mQeSPj+vPkN7XxFJryHVn984NHX7rIkpnBVHNgkWf
         v+N3NyYgUbJi7uVmhHSAJB7wzKLVexE4IBiUirgdXMLZLdlF3gwjUYLEAFkpCIVcGH
         GdrLDZ5X2OKj2dfXyAIQOFgaY8ncfouX6/ZmCFwcepQN/c0DCWCj/UPNug+GHayo7r
         3O4tCklE68JGg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: use sysfs_emit instead of sprintf
Date:   Fri, 28 Oct 2022 09:58:27 -0700
Message-Id: <20221028165827.11558-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use sysfs_emit.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 66c88220d319..aaf93bb6c64d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -95,28 +95,28 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 static ssize_t dirty_segments_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)(dirty_segments(sbi)));
 }
 
 static ssize_t free_segments_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)(free_segments(sbi)));
 }
 
 static ssize_t ovp_segments_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)(overprovision_segments(sbi)));
 }
 
 static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)(sbi->kbytes_written +
 			((f2fs_get_sectors_written(sbi) -
 				sbi->sectors_written_start) >> 1)));
@@ -125,13 +125,13 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 static ssize_t sb_status_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%lx\n", sbi->s_flag);
+	return sysfs_emit(buf, "%lx\n", sbi->s_flag);
 }
 
 static ssize_t cp_status_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
+	return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
 }
 
 static ssize_t pending_discard_show(struct f2fs_attr *a,
@@ -139,7 +139,7 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
 {
 	if (!SM_I(sbi)->dcc_info)
 		return -EINVAL;
-	return sprintf(buf, "%llu\n", (unsigned long long)atomic_read(
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
 				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
 }
 
@@ -205,7 +205,7 @@ static ssize_t features_show(struct f2fs_attr *a,
 static ssize_t current_reserved_blocks_show(struct f2fs_attr *a,
 					struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%u\n", sbi->current_reserved_blocks);
+	return sysfs_emit(buf, "%u\n", sbi->current_reserved_blocks);
 }
 
 static ssize_t unusable_show(struct f2fs_attr *a,
@@ -217,7 +217,7 @@ static ssize_t unusable_show(struct f2fs_attr *a,
 		unusable = sbi->unusable_block_count;
 	else
 		unusable = f2fs_get_unusable_blocks(sbi);
-	return sprintf(buf, "%llu\n", (unsigned long long)unusable);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)unusable);
 }
 
 static ssize_t encoding_show(struct f2fs_attr *a,
@@ -232,13 +232,13 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 			(sb->s_encoding->version >> 8) & 0xff,
 			sb->s_encoding->version & 0xff);
 #endif
-	return sprintf(buf, "(none)");
+	return sysfs_emit(buf, "(none)");
 }
 
 static ssize_t mounted_time_sec_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "%llu", SIT_I(sbi)->mounted_time);
+	return sysfs_emit(buf, "%llu", SIT_I(sbi)->mounted_time);
 }
 
 #ifdef CONFIG_F2FS_STAT_FS
@@ -247,7 +247,7 @@ static ssize_t moved_blocks_foreground_show(struct f2fs_attr *a,
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 		(unsigned long long)(si->tot_blks -
 			(si->bg_data_blks + si->bg_node_blks)));
 }
@@ -257,7 +257,7 @@ static ssize_t moved_blocks_background_show(struct f2fs_attr *a,
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
 
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 		(unsigned long long)(si->bg_data_blks + si->bg_node_blks));
 }
 
@@ -268,7 +268,7 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *a,
 
 	si->dirty_count = dirty_segments(sbi);
 	f2fs_update_sit_info(sbi);
-	return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vblocks));
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)(si->avg_vblocks));
 }
 #endif
 
@@ -363,7 +363,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 
 	ui = (unsigned int *)(ptr + a->offset);
 
-	return sprintf(buf, "%u\n", *ui);
+	return sysfs_emit(buf, "%u\n", *ui);
 }
 
 static ssize_t __sbi_store(struct f2fs_attr *a,
@@ -728,7 +728,7 @@ static void f2fs_sb_release(struct kobject *kobj)
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	return sprintf(buf, "supported\n");
+	return sysfs_emit(buf, "supported\n");
 }
 
 #define F2FS_FEATURE_RO_ATTR(_name)				\
@@ -741,8 +741,8 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
 	if (F2FS_HAS_FEATURE(sbi, a->id))
-		return sprintf(buf, "supported\n");
-	return sprintf(buf, "unsupported\n");
+		return sysfs_emit(buf, "supported\n");
+	return sysfs_emit(buf, "unsupported\n");
 }
 
 #define F2FS_SB_FEATURE_RO_ATTR(_name, _feat)			\
-- 
2.38.1.273.g43a17bfeac-goog

