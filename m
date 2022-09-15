Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9B5B9FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIOQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIOQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:49:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D129E691
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:48:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso17976691pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GHq7dVGm2OOxGrPIxR4jW0JwHX2wEssn4Ks1aVeah78=;
        b=N080U3jriplkoP0mn+6UNs5gJxyCP2n1wsAfUwiTdaLhfvKefEOQ3Jnp4joBXWoSkV
         PsHBuZ6zxKDriXffRGWMsJkIPwQrlz0X29bfVvN/3YJzF4V41GPn40hK7UxrsvNP/xuI
         14j2sTvlzYkuFYYqjzjdseq8AKlrm90Wt6P8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GHq7dVGm2OOxGrPIxR4jW0JwHX2wEssn4Ks1aVeah78=;
        b=1PMK27tSXMhveRsbCUiQM7oUFwS2E88GHTucUteidubgCwlgZtHxuAIAfVCRaL6HiF
         AcHZOaGPnx8Ql5qrFavQVtIfUk0RTALnAAOQX7NjqLpr9da2uhCtHWITqZIl/HCHj++1
         NW9TbhCeC3CFrTZqSLOYViO83GoJBlY2VahKpKM8koZikscUEXLhlcV9jaEMF9AKCEBl
         9kOZL1c3U8bTksI26YGH/NHsHnT0Dyw2fFsl0t70huwp86qGu6KY4KCPZnAeRHqDXaH+
         dL2mtoCtl9DurLC35Sl5CYw4hIoWaDmCjn269v4oTiZb1lYiCFFC1jHWqgkaF7qPYv3B
         k5kQ==
X-Gm-Message-State: ACrzQf00N888FCcChE/cj4nmgukUbexfqnqRrm6Nwd1AeNMV1C2GZcpf
        vHpxUMNrzKD6wdx7XJUDBiO0oQ==
X-Google-Smtp-Source: AMsMyM5ttUX80mK/xaqN8PnmPtACWbnNz3msqy9Npe8lr7jxLQP3tkGYZybEvxiT7s/KaSaMZVvSZQ==
X-Received: by 2002:a17:902:dac4:b0:178:3037:680a with SMTP id q4-20020a170902dac400b001783037680amr327417plx.37.1663260532933;
        Thu, 15 Sep 2022 09:48:52 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:52 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 6/8] ext4: Add support for FALLOC_FL_PROVISION
Date:   Thu, 15 Sep 2022 09:48:24 -0700
Message-Id: <20220915164826.1396245-7-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Once ext4 is done mapping blocks for an fallocate() request, send
out an FALLOC_FL_PROVISION request to the underlying layer to
ensure that the space is provisioned for the newly allocated extent
or indirect blocks.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/ext4.h         |  2 ++
 fs/ext4/extents.c      | 15 ++++++++++++++-
 fs/ext4/indirect.c     |  9 +++++++++
 include/linux/blkdev.h | 11 +++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9bca5565547b..ec0871e687c1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -675,6 +675,8 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+	/* Provision blocks on underlying storage */
+#define EXT4_GET_BLOCKS_PROVISION		0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..7a096144b7f8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4356,6 +4356,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		}
 	}
 
+	/* Attempt to provision blocks on underlying storage */
+	if (flags & EXT4_GET_BLOCKS_PROVISION) {
+		err = sb_issue_provision(inode->i_sb, pblk, ar.len, GFP_NOFS);
+		if (err)
+			goto out;
+	}
+
 	/*
 	 * Cache the extent and update transaction to commit on fdatasync only
 	 * when it is _not_ an unwritten extent.
@@ -4690,7 +4697,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	/* Return error if mode is not supported */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
-		     FALLOC_FL_INSERT_RANGE))
+		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_PROVISION))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
@@ -4750,6 +4757,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
+	/* Ensure that preallocation provisions the blocks on the underlying
+	 * storage device.
+	 */
+	if (mode & FALLOC_FL_PROVISION)
+		flags |= EXT4_GET_BLOCKS_PROVISION;
+
 	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
 	if (ret)
 		goto out;
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 860fc5119009..860a2560872b 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -640,6 +640,15 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto cleanup;
 
+	/* Attempt to provision blocks on underlying storage */
+	if (flags & EXT4_GET_BLOCKS_PROVISION) {
+		err = sb_issue_provision(inode->i_sb,
+					 le32_to_cpu(chain[depth-1].key),
+					 ar.len, GFP_NOFS);
+		if (err)
+			goto out;
+	}
+
 	map->m_flags |= EXT4_MAP_NEW;
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a58496d3f922..26b41a6c12f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1107,6 +1107,17 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 				    gfp_mask, 0);
 }
 
+static inline int sb_issue_provision(struct super_block *sb, sector_t block,
+		sector_t nr_blocks, gfp_t gfp_mask)
+{
+	return blkdev_issue_provision(sb->s_bdev,
+				      block << (sb->s_blocksize_bits -
+					      SECTOR_SHIFT),
+				      nr_blocks << (sb->s_blocksize_bits -
+						    SECTOR_SHIFT),
+				      gfp_mask);
+}
+
 static inline bool bdev_is_partition(struct block_device *bdev)
 {
 	return bdev->bd_partno;
-- 
2.31.0

