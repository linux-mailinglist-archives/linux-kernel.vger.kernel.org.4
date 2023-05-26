Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B222711D91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEZCNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZCNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:13:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3F135;
        Thu, 25 May 2023 19:13:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so329377b3a.1;
        Thu, 25 May 2023 19:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685067217; x=1687659217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSOPIG+RVxNo5vuZ8u1mK3wQtN0fLH9sHRFk/xhggWM=;
        b=fWeyP/8nk9xU/iNM5QXfW7bydffNvcJsXC8JYMMKylO6va0zhO/DV8A9umLRlFKojx
         2k3zjZsFNoKCV7q7n7iQ1ebl8rnbr84jaEhJR4dnOvdBt/ohZyiCfwf3OuqyDyA1d0Se
         dBaIeofXNexP2+vnK1kI6iXZhBpeChTfcemI7Olc01psaRbP7yFGhhI6t3o2CJHAFOJo
         5/g4jVO12rpPfKlA3F/vQUMn2v1idL50K1gi/Ew/mDIXZXtbBEUou1787rxHODaJClNF
         jjQFH7vllLxmWEMSXRqKzXSs+QnRJprMOMz4GwxqpFdf0nUEd9QDWEK5pZVwK8YVrqOL
         ykKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685067217; x=1687659217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSOPIG+RVxNo5vuZ8u1mK3wQtN0fLH9sHRFk/xhggWM=;
        b=VI6qC9vTsXd54I4fAy70ovlPlUmYNFEi49uz16cwga4EKSMMXui/MvtxGNanMSzbe1
         JlkAGPdrQnN1ouJTpSHac7O7tCjoPvmM/WdGaUpE9OtoCeVNefzwj9yY9UW1sHsaem0g
         VjXLTPppHuMKyLklMsXvbBYBQdjIFgxfE+mXcfZK4WDxJav402ze59SMrYKa4OVGYnea
         UEeAu+V0e7n3ZAST2QT+Rt52esrkj8Pmf42c9XJr4Q12vYzyFOzQqPcMQACDE4pvYQY6
         HGPDQz1Ov54sUxuOgo7ACtbYcRLgy2EY5iphcVVGVNGzlwIj+veYyZE7hAWaYe0WyQyq
         l3zQ==
X-Gm-Message-State: AC+VfDyBsducReub7nTLpCThbhDbKah7Tyzvl+kh2UD3/WSGijKOevyi
        IsckkjjErtYzgf+FSG3/7KM=
X-Google-Smtp-Source: ACHHUZ7MXGfaWQfVHJ/bCrsXckzCKDWz/PXc0fmyH9C5/ZlxGG3jQ5g5BRSXfFj9L8rOTxVWwgJQ7A==
X-Received: by 2002:a05:6a00:21d3:b0:63b:5496:7afa with SMTP id t19-20020a056a0021d300b0063b54967afamr1209354pfj.11.1685067217318;
        Thu, 25 May 2023 19:13:37 -0700 (PDT)
Received: from carrot.. (i220-108-176-104.s42.a014.ap.plala.or.jp. [220.108.176.104])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b0064ccfb73cb8sm1740620pff.46.2023.05.25.19.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 19:13:36 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: reject devices with insufficient block count
Date:   Fri, 26 May 2023 11:13:32 +0900
Message-Id: <20230526021332.3431-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sanity check for nilfs2 geometry information lacks checks for
the number of segments stored in superblocks, so even for device images
that have been destructively truncated or have an unusually high number
of segments, the mount operation may succeed.

This causes out-of-bounds block I/O on file system block reads or log
writes to the segments, the latter in particular causing
"a_ops->writepages" to repeatedly fail, resulting in sync_inodes_sb()
to hang.

Fix this issue by checking the number of segments stored in the
superblock and avoiding mounting devices that can cause out-of-bounds
accesses.  To eliminate the possibility of overflow when calculating the
number of blocks required for the device from the number of segments,
this also adds a helper function to calculate the upper bound on the
number of segments and inserts a check using it.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=7d50f1e54a12ba3aeae2
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/the_nilfs.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 2894152a6b25..0f0667957c81 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -405,6 +405,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -414,6 +426,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -457,7 +471,34 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_err(nilfs->ns_sb,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = sb_bdev_nr_blocks(nilfs->ns_sb);
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_err(nilfs->ns_sb,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
-- 
2.34.1

