Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74717728EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbjFID5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFID5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:57:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05341272A;
        Thu,  8 Jun 2023 20:57:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso1043680b3a.3;
        Thu, 08 Jun 2023 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686283057; x=1688875057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtN6duKs1KJ2B8qXC/7XMIuK5xURdPo4J+o/SZkSGvQ=;
        b=fZUw+EPiQ2R0G+gCm0cxoVriifd4/xuGxLCggMamGX65pqyVDELjNmp9QNow8zbd9h
         F17d/07jWUNUTeAL4FvyO+LLLAOes/5y/KgoGUz4G26xe5Th6KAK/igYwDUoacBUVTR+
         tj78nrdaZlm3J40XfL98beUx43bgkW+lB37jYP9vWLbrZfAmeALLMAm8cFTrWt4zWsBt
         6pc/X3oRIL6TaGohQb3VW6rDqgYx292MjsCP8UojJ1FlICB2F3WDf2ibreLs6Wkjl9Pf
         psJzvNClJGtqagp9XyQ5O8zfvODLaJQiZmfoi+BPSj2foO35PFAhHnqYpWGytthI3MRE
         zUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686283057; x=1688875057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtN6duKs1KJ2B8qXC/7XMIuK5xURdPo4J+o/SZkSGvQ=;
        b=bFpMt0O/761vHCtNZAruriPnCi482iG0y7xiyOsmMh3E1JU39MDBGeI54ViKb3DGex
         VVgJdNjz7RwVh4H7WePTpEE472gzOSvtZczPu+igRQn4zPSry7+fyfJZxzEu03STM/GH
         3VN5LgWYnie6oVd9068l18cJwj+WqHi33W5PTbdNwTm6yavNSRjpbs+jFKYT6e+TyZdD
         GAFJLONXDUOTsu3Mg3LLAP2u/iQB5fXGvLOdmEYKLIUfZui/UrqBtyz14Kb8PAxlSUxE
         Qs7yPQj2UgG34+JNPPawkVHp2SkZGxl+OLAiZKC6T57G2NlAaf7DvDYKIIuvLVcQIfsX
         LFsA==
X-Gm-Message-State: AC+VfDzS5HHvzisnV3LHi10/Kz7YMRZCeEtiusmdGfLRK7U/R278aboy
        WmSMqANapkWdBOVkzonNQGGgJS2qi1Q=
X-Google-Smtp-Source: ACHHUZ4nEPGXAaVggf6Maig2i2ujvbPj3dU09T+io5zlgWlom1iytFf6TkX7K9qYt4uDYDDSU99TQw==
X-Received: by 2002:a05:6a00:1346:b0:647:370c:2c2a with SMTP id k6-20020a056a00134600b00647370c2c2amr120801pfu.6.1686283057050;
        Thu, 08 Jun 2023 20:57:37 -0700 (PDT)
Received: from carrot.. (i220-108-176-104.s42.a014.ap.plala.or.jp. [220.108.176.104])
        by smtp.gmail.com with ESMTPSA id t15-20020aa7938f000000b00659af3079d3sm1832225pfe.16.2023.06.08.20.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:57:36 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix buffer corruption due to concurrent device reads
Date:   Fri,  9 Jun 2023 12:57:32 +0900
Message-Id: <20230609035732.20426-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000030000a05e981f475@google.com>
References: <00000000000030000a05e981f475@google.com>
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

As a result of analysis of a syzbot report, it turned out that in three
cases where nilfs2 allocates block device buffers directly via sb_getblk,
concurrent reads to the device can corrupt the allocated buffers.

Nilfs2 uses sb_getblk for segment summary blocks, that make up a log
header, and the super root block, that is the trailer, and when moving and
writing the second super block after fs resize.

In any of these, since the uptodate flag is not set when storing metadata
to be written in the allocated buffers, the stored metadata will be
overwritten if a device read of the same block occurs concurrently before
the write.  This causes metadata corruption and misbehavior in the log
write itself, causing warnings in nilfs_btree_assign() as reported.

Fix these issues by setting an uptodate flag on the buffer head on the
first or before modifying each buffer obtained with sb_getblk, and
clearing the flag on failure.

When setting the uptodate flag, the lock_buffer/unlock_buffer pair is
used to perform necessary exclusive control, and the buffer is filled to
ensure that uninitialized bytes are not mixed into the data read from
others.  As for buffers for segment summary blocks, they are filled
incrementally, so if the uptodate flag was unset on their allocation, set
the flag and zero fill the buffer once at that point.

Also, regarding the superblock move routine, the starting point of the
memset call to zerofill the block is incorrectly specified, which can
cause a buffer overflow on file systems with block sizes greater than
4KiB.  In addition, if the superblock is moved within a large block, it
is necessary to assume the possibility that the data in the superblock
will be destroyed by zero-filling before copying.  So fix these potential
issues as well.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000030000a05e981f475@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/segbuf.c  |  6 ++++++
 fs/nilfs2/segment.c |  7 +++++++
 fs/nilfs2/super.c   | 23 ++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 1362ccb64ec7..6e59dc19a732 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -101,6 +101,12 @@ int nilfs_segbuf_extend_segsum(struct nilfs_segment_buffer *segbuf)
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index ac949fd7603f..c2553024bd25 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -981,10 +981,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -998,6 +1001,8 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1780,6 +1785,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1791,6 +1797,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 77f1e5778d1c..9ba4933087af 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -372,10 +372,31 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;
-- 
2.34.1

