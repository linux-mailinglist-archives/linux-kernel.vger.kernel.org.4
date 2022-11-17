Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED8662CFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiKQApy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiKQAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:45:27 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F906CA3B;
        Wed, 16 Nov 2022 16:44:54 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ovT1K-0002WL-6H; Thu, 17 Nov 2022 01:44:46 +0100
Date:   Thu, 17 Nov 2022 00:44:40 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] blkdev: add function to add named read-only
 partitions
Message-ID: <2015e6097f7166915d829740ff33aab506948a0a.1668644705.git.daniel@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668644705.git.daniel@makrotopia.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function bdev_add_partition_ro() which can be used by drivers to
register named read-only partitions on a disk device.
Unlike the existing bdev_add_partition() function, there is also no
check for overlapping partitions.
This new function is going to be used by the uImage.FIT parser.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 355646b0707d..060a6585a387 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -469,6 +469,40 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	return ret;
 }
 
+int bdev_add_partition_ro(struct gendisk *disk, int partno, sector_t start,
+			  sector_t length, const char *volname)
+{
+	struct block_device *part;
+	struct partition_meta_info *info;
+	int ret;
+
+	mutex_lock(&disk->open_mutex);
+	if (!disk_live(disk)) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	part = add_partition(disk, partno, start, length,
+			     ADDPART_FLAG_READONLY, NULL);
+	ret = PTR_ERR_OR_ZERO(part);
+	if (ret)
+		goto out;
+
+	if (volname) {
+		info = kzalloc(sizeof(struct partition_meta_info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		strscpy(info->volname, volname, sizeof(info->volname));
+		part->bd_meta_info = info;
+	}
+out:
+	mutex_unlock(&disk->open_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bdev_add_partition_ro);
+
 int bdev_del_partition(struct gendisk *disk, int partno)
 {
 	struct block_device *part = NULL;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b45cdcdccc6d..6e468a2fc4ec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1504,6 +1504,8 @@ int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
+int bdev_add_partition_ro(struct gendisk *disk, int partno, sector_t start,
+			  sector_t length, const char *volname);
 #else
 static inline dev_t devt_from_partuuid(const char *uuid_str, int *root_wait)
 {
@@ -1537,6 +1539,11 @@ static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 static inline void printk_all_partitions(void)
 {
 }
+static inline int bdev_add_partition_ro(struct gendisk *disk, int partno, sector_t start,
+			  sector_t length, const char *volname)
+{
+	return 0;
+}
 #endif /* CONFIG_BLOCK */
 
 int fsync_bdev(struct block_device *bdev);
-- 
2.38.1

