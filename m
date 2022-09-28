Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0005EE0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiI1PjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1PjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:39:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC389FAA0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3ECEB81FF7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D03DC433D7;
        Wed, 28 Sep 2022 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664379549;
        bh=LmZFLmKf+TBz/taw6MmN/uDum8XcFIbr43HYrWvm7+k=;
        h=From:To:Cc:Subject:Date:From;
        b=ueKglqYK5O8Kova6B+K910ThMmcAyvOz+gVPpmCtEmEkaobgodLEMX/p7flwwlKJ+
         YDglBB0wAwlpgaaNa7D7hR8TeJ0TIZzjoiOS3QoO0wknb/We1FgV3MP9xPgXk/PWoZ
         w4mRxq/aAQWKxztFtskz1qRaeSuL6iFu3depi5WMjXhfGmHEmlkP7zyDmctIv81lrd
         jS0xdSdpTRrkGflDc7+zjzlqtGGIq6W6W1t1bgnoggWqlgUuxxe/fJQ3qFrGCjEZwO
         37VBPudNq93w0ItrWsb4b7rr8BwiAWHDZwww5w4J3sm07s2pB0jv/wRaFf/PvIDYeq
         ngTA4Nbvd6c9g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: support recording stop_checkpoint reason into super_block
Date:   Wed, 28 Sep 2022 23:38:53 +0800
Message-Id: <20220928153855.4634-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports to record stop_checkpoint error into
f2fs_super_block.s_stop_reason[].

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c    | 10 +++++++---
 fs/f2fs/data.c          |  6 ++++--
 fs/f2fs/f2fs.h          |  4 +++-
 fs/f2fs/file.c          | 11 ++++++-----
 fs/f2fs/gc.c            |  6 ++++--
 fs/f2fs/inode.c         |  3 ++-
 fs/f2fs/segment.c       |  5 +++--
 fs/f2fs/super.c         | 20 ++++++++++++++++++++
 include/linux/f2fs_fs.h | 17 ++++++++++++++++-
 9 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 308b70812cbd..0c82dae082aa 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -26,12 +26,16 @@
 static struct kmem_cache *ino_entry_slab;
 struct kmem_cache *f2fs_inode_entry_slab;
 
-void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
+void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
+						unsigned char reason)
 {
 	f2fs_build_fault_attr(sbi, 0, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
-	if (!end_io)
+	if (!end_io) {
 		f2fs_flush_merged_writes(sbi);
+
+		f2fs_handle_stop(sbi, reason);
+	}
 }
 
 /*
@@ -122,7 +126,7 @@ struct page *f2fs_get_meta_page_retry(struct f2fs_sb_info *sbi, pgoff_t index)
 		if (PTR_ERR(page) == -EIO &&
 				++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_META_PAGE);
 	}
 	return page;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e5be2c1dab9..20c8d835a87b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -333,7 +333,8 @@ static void f2fs_write_end_io(struct bio *bio)
 			mempool_free(page, sbi->write_io_dummy);
 
 			if (unlikely(bio->bi_status))
-				f2fs_stop_checkpoint(sbi, true);
+				f2fs_stop_checkpoint(sbi, true,
+						STOP_CP_REASON_WRITE_FAIL);
 			continue;
 		}
 
@@ -349,7 +350,8 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (unlikely(bio->bi_status)) {
 			mapping_set_error(page->mapping, -EIO);
 			if (type == F2FS_WB_CP_DATA)
-				f2fs_stop_checkpoint(sbi, true);
+				f2fs_stop_checkpoint(sbi, true,
+						STOP_CP_REASON_WRITE_FAIL);
 		}
 
 		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d680a051cba4..30ddd77115e6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3559,6 +3559,7 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
 int f2fs_quota_sync(struct super_block *sb, int type);
 loff_t max_file_blocks(struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
+void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
@@ -3718,7 +3719,8 @@ static inline bool f2fs_need_rand_seg(struct f2fs_sb_info *sbi)
 /*
  * checkpoint.c
  */
-void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
+void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
+							unsigned char reason);
 void f2fs_flush_ckpt_thread(struct f2fs_sb_info *sbi);
 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2f9b387fef54..da45798d7fe5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2153,7 +2153,8 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		if (ret) {
 			if (ret == -EROFS) {
 				ret = 0;
-				f2fs_stop_checkpoint(sbi, false);
+				f2fs_stop_checkpoint(sbi, false,
+						STOP_CP_REASON_SHUTDOWN);
 				set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 				trace_f2fs_shutdown(sbi, in, ret);
 			}
@@ -2166,7 +2167,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		ret = freeze_bdev(sb->s_bdev);
 		if (ret)
 			goto out;
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		thaw_bdev(sb->s_bdev);
 		break;
@@ -2175,16 +2176,16 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		ret = f2fs_sync_fs(sb, 1);
 		if (ret)
 			goto out;
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
 		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NEED_FSCK:
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3a820e5cdaee..6e42dad0ac2d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -74,7 +74,8 @@ static int gc_thread_func(void *data)
 
 		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
 			f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
-			f2fs_stop_checkpoint(sbi, false);
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_FAULT_INJECT);
 		}
 
 		if (!sb_start_write_trylock(sbi->sb)) {
@@ -1712,7 +1713,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
 				 segno, type, GET_SUM_TYPE((&sum->footer)));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_stop_checkpoint(sbi, false);
+			f2fs_stop_checkpoint(sbi, false,
+				STOP_CP_REASON_CORRUPTED_SUMMARY);
 			goto skip;
 		}
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f6cb8b78b5d5..7880596b51ee 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -716,7 +716,8 @@ void f2fs_update_inode_page(struct inode *inode)
 			cond_resched();
 			goto retry;
 		} else if (err != -ENOENT) {
-			f2fs_stop_checkpoint(sbi, false);
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_UPDATE_INODE);
 		}
 		return;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e35be4116767..4ed84510f195 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -390,7 +390,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
 	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
 		f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);
 	}
 
 	/* balance_fs_bg is able to be pending */
@@ -708,7 +708,8 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		} while (ret && --count);
 
 		if (ret) {
-			f2fs_stop_checkpoint(sbi, false);
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_FLUSH_FAIL);
 			break;
 		}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b8e5fe244596..2533d309a924 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3846,6 +3846,26 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	return err;
 }
 
+void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
+{
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
+	int err;
+
+	f2fs_bug_on(sbi, reason >= MAX_STOP_REASON);
+
+	f2fs_down_write(&sbi->sb_lock);
+
+	if (raw_super->s_stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
+		raw_super->s_stop_reason[reason]++;
+
+	err = f2fs_commit_super(sbi, false);
+	if (err)
+		f2fs_err(sbi, "f2fs_commit_super fails to record reason:%u err:%d",
+								reason, err);
+
+	f2fs_up_write(&sbi->sb_lock);
+}
+
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d445150c5350..5dd1e52b8997 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -73,6 +73,20 @@ struct f2fs_device {
 	__le32 total_segments;
 } __packed;
 
+/* reason of stop_checkpoint */
+enum stop_cp_reason {
+	STOP_CP_REASON_SHUTDOWN,
+	STOP_CP_REASON_FAULT_INJECT,
+	STOP_CP_REASON_META_PAGE,
+	STOP_CP_REASON_WRITE_FAIL,
+	STOP_CP_REASON_CORRUPTED_SUMMARY,
+	STOP_CP_REASON_UPDATE_INODE,
+	STOP_CP_REASON_FLUSH_FAIL,
+	STOP_CP_REASON_MAX,
+};
+
+#define	MAX_STOP_REASON			32
+
 struct f2fs_super_block {
 	__le32 magic;			/* Magic Number */
 	__le16 major_ver;		/* Major Version */
@@ -116,7 +130,8 @@ struct f2fs_super_block {
 	__u8 hot_ext_count;		/* # of hot file extension */
 	__le16  s_encoding;		/* Filename charset encoding */
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
-	__u8 reserved[306];		/* valid reserved region */
+	__u8 s_stop_reason[MAX_STOP_REASON];	/* stop checkpoint reason */
+	__u8 reserved[274];		/* valid reserved region */
 	__le32 crc;			/* checksum of superblock */
 } __packed;
 
-- 
2.36.1

