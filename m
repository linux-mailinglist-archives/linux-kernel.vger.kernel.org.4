Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9144C7188D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEaRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEaRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:52:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DEF125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:52:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d24136685so21163b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685555556; x=1688147556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfMuDdWL1b4kSqYmj4dPZPS2+HxbmlkGgksoSf7cEdM=;
        b=GCbj2dgtrPxM81YowcETNQ7Tw7u17jOm8NgY0XIvDAhknW7UNNBsch0YtMcFekc361
         6/Wad6Tz8fsQQg1eYGqg+85i9VG6EoFd6QO9uosS61SXofS450nU07/j9MSQ2VmiY2rn
         wad7XwqFrzdKhFr0cxIPBYy2E4V+2OaCfGyxCT1DSVfC3AkjQrqBZY1ueOxk16GDKHTR
         epPOhOIRe/Wua1Wzbeb4V1LkFHQT7UseSwek0eF6bjM2QuoopWANatm8LMmqsnlGCRdo
         DOmoMPQwsefZBwyj1nD7ejisJfYydRbcVQ3AitRWyz4lihhFvRGrbiQcvveSjJtkItu9
         8Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685555556; x=1688147556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfMuDdWL1b4kSqYmj4dPZPS2+HxbmlkGgksoSf7cEdM=;
        b=DjwlCCHUg0gPMfqN1MjutLC04H0Cczx3w64BOqZk9Vf81r+C7JtyCtuIL2+NI2gJn3
         Tw9v56EnIYkTS6eQJfjruC70MpqSuK2DBUm4mLxmNkit0rdDmFRPciwAim+gvvv2ApL/
         wMIKWDEC1QSKpKS4kEfE5PG+aHt3K95CiO/pPIbDv0h6RZKs03rYmTCoTHOAoMCxng9E
         pJbr4ltVLRT+etAgce7OzUfqtvk3Yfq2ydvc7MYAGtyKwsBgwDqYl84BwqFuEBgMv7g7
         qGcb3BNx+9eLRt4zS3DYMBG8qgdklcxMf9p+UvawW6qlhfN0Umy4uPDZYJ9iazkaWUh0
         FSbg==
X-Gm-Message-State: AC+VfDxuuUrsgOGiBdjZ8UlHZW3XE7FJOz7+FKITyXQuDCmVw2/4LVfd
        walK8V6YwYED1MKU9kIvVMwE8N1VirI=
X-Google-Smtp-Source: ACHHUZ6Bxgyls2p2BGxa2nv5b66W/y3d+qKs1L7ZFG+mA6gitDf/KIJHgmM/Krzh/mokc5fmG+G+Ng==
X-Received: by 2002:a05:6a00:2393:b0:64d:2a87:2596 with SMTP id f19-20020a056a00239300b0064d2a872596mr9221088pfc.10.1685555555629;
        Wed, 31 May 2023 10:52:35 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:3d32:dc28:3a98:9cdf])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0063f1a1e3003sm3587517pfb.166.2023.05.31.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 10:52:35 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: remove power-of-two limitation of zoned device
Date:   Wed, 31 May 2023 10:52:13 -0700
Message-ID: <20230531175214.3561692-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Remove power-of-two limitation for zoned device, since zoned devices
don't have it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 4c74888..851a62b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -56,19 +56,17 @@ static int get_zone_idx_from_dev(struct f2fs_sb_info *sbi,
 {
 	block_t seg_start_blkaddr = START_BLOCK(sbi, segno);
 
-	return (seg_start_blkaddr - c.devices[dev_idx].start_blkaddr) >>
-			log_base_2(sbi->segs_per_sec * sbi->blocks_per_seg);
+	return (seg_start_blkaddr - c.devices[dev_idx].start_blkaddr) /
+			(sbi->segs_per_sec * sbi->blocks_per_seg);
 }
 
 bool is_usable_seg(struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	unsigned int secno = segno / sbi->segs_per_sec;
 	block_t seg_start = START_BLOCK(sbi, segno);
-	block_t blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;
 	unsigned int dev_idx = get_device_idx(sbi, segno);
 	unsigned int zone_idx = get_zone_idx_from_dev(sbi, segno, dev_idx);
-	unsigned int sec_off = SM_I(sbi)->main_blkaddr >>
-						log_base_2(blocks_per_sec);
+	unsigned int sec_start_blkaddr = START_BLOCK(sbi,
+			GET_SEG_FROM_SEC(sbi, segno / sbi->segs_per_sec));
 
 	if (zone_idx < c.devices[dev_idx].nr_rnd_zones)
 		return true;
@@ -76,7 +74,7 @@ bool is_usable_seg(struct f2fs_sb_info *sbi, unsigned int segno)
 	if (c.devices[dev_idx].zoned_model != F2FS_ZONED_HM)
 		return true;
 
-	return seg_start < ((sec_off + secno) * blocks_per_sec) +
+	return seg_start < sec_start_blkaddr +
 				c.devices[dev_idx].zone_cap_blocks[zone_idx];
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

