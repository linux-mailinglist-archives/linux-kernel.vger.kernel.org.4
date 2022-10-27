Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAD60EF23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiJ0EnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiJ0EnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:43:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CB7156257;
        Wed, 26 Oct 2022 21:43:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d24so260011pls.4;
        Wed, 26 Oct 2022 21:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CCq70oXkrOiZ0hlpxTV/q9jKiiD+wVtMgJ5m746aQw=;
        b=Bk2VwBCDAGpwDYoxWcNk9af9n73eL1AzE9BSZtwllbt6iQ8p+FCHrlVcX6+1SIwlAv
         Qa1IFccARwZpVs+bV/LsCNIxrwHlveo6uIjDw2nbgIdlOuAA/tLwlFi40nI5uFwPVLcq
         rrFG3Mi5nhlaGCampV85QqYQpVoNNqtg56DiyPlG/9QUUBeC1sy3X0QVSdwAeBSjQTRU
         tUEMkmsIdyLMOE5BpeESBB36Lk6dU/VU+4hpfHXt1TkdJD3aCWKw1Hln98M8isg9t8G2
         7RM7HAAMXBCmdZP6ZzprLnCA3K9/+j/tOEDaAfzmIs4dDsv7oCUHdFN1W51eQE1dd17+
         vwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CCq70oXkrOiZ0hlpxTV/q9jKiiD+wVtMgJ5m746aQw=;
        b=1rAkLoyFw5SV3nSgH+yFI8nKBzA0pPFtJzh/spbRQV4CldXBGyix+zrQxTaBhI03hg
         bO2Mmcc5MKv2HGQvPRsBjjCS2rpCSG40K/ZDRcWKl6Y93aIYPHVmRbyPI3sLzqUk/GrH
         efRsJCqsUYFKzBxjpk4mHRDjyHspSGRAt4kmMPBQFneqH0nI1zZlntHOx7qrVxHOjuog
         NS+293wTKcmBfndnCbFagaKj0a3P6X2VW6AZgATPjFrwxoNY0pfR9CnT6F/0GFbkkX83
         xtvWiZqN+23aJF5hbTV/yghmXQhm7d7faYcNgWF4MBDeD4Cgfjc+RuJAc7oUC1u8AhoE
         /Z3Q==
X-Gm-Message-State: ACrzQf2A+5NwmVDM0BZM0rzFZ7/OV6kFM2a+yG63w4DALfTKZGh5b+Eg
        5yQl0DjRCSH1LyIYnCmcG6zfZUmdIZk=
X-Google-Smtp-Source: AMsMyM4zlHe/Nu0oauf0nceejMpICjpPuyuQEnogIYUBc5E9I3srS4ZW1R5q9P4iUO8ikorEtI66Zw==
X-Received: by 2002:a17:902:f78c:b0:185:3d6a:7576 with SMTP id q12-20020a170902f78c00b001853d6a7576mr6496308pln.86.1666845796292;
        Wed, 26 Oct 2022 21:43:16 -0700 (PDT)
Received: from carrot.. (i220-108-44-211.s42.a014.ap.plala.or.jp. [220.108.44.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b00186a2274382sm186929plx.76.2022.10.26.21.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:43:15 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+e91619dd4c11c4960706@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] nilfs2: fix shift-out-of-bounds due to too large exponent of block size
Date:   Thu, 27 Oct 2022 13:43:06 +0900
Message-Id: <20221027044306.42774-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027044306.42774-1-konishi.ryusuke@gmail.com>
References: <20221027044306.42774-1-konishi.ryusuke@gmail.com>
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

If field s_log_block_size of superblock data is corrupted and too
large, init_nilfs() and load_nilfs() still can trigger a
shift-out-of-bounds warning followed by a kernel panic (if
panic_on_warn is set):

 shift exponent 38973 is too large for 32-bit type 'int'
 Call Trace:
  <TASK>
  dump_stack_lvl+0xcd/0x134
  ubsan_epilogue+0xb/0x50
  __ubsan_handle_shift_out_of_bounds.cold.12+0x17b/0x1f5
  init_nilfs.cold.11+0x18/0x1d [nilfs2]
  nilfs_mount+0x9b5/0x12b0 [nilfs2]
  ...

This fixes the issue by adding and using a new helper function for
getting block size with sanity check.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/the_nilfs.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index d588816fdf2f..20ff02b4ef5d 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -193,6 +193,34 @@ static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
 	return ret;
 }
 
+/**
+ * nilfs_get_blocksize - get block size from raw superblock data
+ * @sb: super block instance
+ * @sbp: superblock raw data buffer
+ * @blocksize: place to store block size
+ *
+ * nilfs_get_blocksize() calculates the block size from the block size
+ * exponent information written in @sbp and stores it in @blocksize,
+ * or aborts with an error message if it's too large.
+ *
+ * Return Value: On success, 0 is returned. If the block size is too
+ * large, -EINVAL is returned.
+ */
+static int nilfs_get_blocksize(struct super_block *sb,
+			       struct nilfs_super_block *sbp, int *blocksize)
+{
+	unsigned int shift_bits = le32_to_cpu(sbp->s_log_block_size);
+
+	if (unlikely(shift_bits >
+		     ilog2(NILFS_MAX_BLOCK_SIZE) - BLOCK_SIZE_BITS)) {
+		nilfs_err(sb, "too large filesystem blocksize: 2 ^ %u KiB",
+			  shift_bits);
+		return -EINVAL;
+	}
+	*blocksize = BLOCK_SIZE << shift_bits;
+	return 0;
+}
+
 /**
  * load_nilfs - load and recover the nilfs
  * @nilfs: the_nilfs structure to be released
@@ -246,11 +274,15 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 		nilfs->ns_sbwtime = le64_to_cpu(sbp[0]->s_wtime);
 
 		/* verify consistency between two super blocks */
-		blocksize = BLOCK_SIZE << le32_to_cpu(sbp[0]->s_log_block_size);
+		err = nilfs_get_blocksize(sb, sbp[0], &blocksize);
+		if (err)
+			goto scan_error;
+
 		if (blocksize != nilfs->ns_blocksize) {
 			nilfs_warn(sb,
 				   "blocksize differs between two super blocks (%d != %d)",
 				   blocksize, nilfs->ns_blocksize);
+			err = -EINVAL;
 			goto scan_error;
 		}
 
@@ -609,9 +641,11 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	if (err)
 		goto failed_sbh;
 
-	blocksize = BLOCK_SIZE << le32_to_cpu(sbp->s_log_block_size);
-	if (blocksize < NILFS_MIN_BLOCK_SIZE ||
-	    blocksize > NILFS_MAX_BLOCK_SIZE) {
+	err = nilfs_get_blocksize(sb, sbp, &blocksize);
+	if (err)
+		goto failed_sbh;
+
+	if (blocksize < NILFS_MIN_BLOCK_SIZE) {
 		nilfs_err(sb,
 			  "couldn't mount because of unsupported filesystem blocksize %d",
 			  blocksize);
-- 
2.34.1

