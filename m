Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4D4648487
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLIPDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLIPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:02:55 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 07:02:53 PST
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DDA102F;
        Fri,  9 Dec 2022 07:02:49 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 72FEA42444;
        Fri,  9 Dec 2022 09:24:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1670595888;
        bh=TD/FgIasuoNuF91aKPnwLJTwwUrJaYgffRUMWb4unVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BrUBIhBc/e/YUMWP22dWOQq45mxeqbXKNhQoCGtXlnPhZbYDV3NYb59Si0T/UCRVD
         3fE0Emi6eWlxsUmPnowkkZ3Y+sSucou9mKWiXVRYazyDuObE2QKvm5XKsNlcbTbK8O
         TII1Vczi/N6guqNGIBNXt5aOIxry7ufHj6KeIaCNGVcF5eb9azQt7uuBEIWB4Rspq7
         mjSDa+5qQVOw1oehD+MZLTWlFrWENAhQOoE6BsBxXxTFjqqMztpTFJ0Ap1XK6kWXH6
         RYQLULfbT0ZJZl/e5t6UYfKNVAlrptop4Ykm246uLQnMKbRrrPCCxfBVFG2TI47hwU
         w9yXJlneV5a0w==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 9 Dec 2022 15:23:55 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <corbet@lwn.net>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v2 02/21] block, blkfilter: Block Device Filtering Mechanism
Date:   Fri, 9 Dec 2022 15:23:12 +0100
Message-ID: <20221209142331.26395-3-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031556627C62
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to attach block device filters to the block devices. Kernel
modules can use this functionality to extend the capabilities of the
block layer.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/bdev.c              | 70 ++++++++++++++++++++++++++++++++++++++
 block/blk-core.c          | 19 +++++++++--
 include/linux/blk_types.h |  2 ++
 include/linux/blkdev.h    | 71 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index d699ecdb3260..b820178824b2 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -427,6 +427,7 @@ static void init_once(void *data)
 
 static void bdev_evict_inode(struct inode *inode)
 {
+	bdev_filter_detach(I_BDEV(inode));
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
@@ -502,6 +503,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
+	bdev->bd_filter = NULL;
 	return bdev;
 }
 
@@ -1092,3 +1094,71 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 	blkdev_put_no_open(bdev);
 }
+
+/**
+ * bdev_filter_attach - Attach the filter to the original block device.
+ * @bdev:
+ *	Block device.
+ * @flt:
+ *	Filter that needs to be attached to the block device.
+ *
+ * Before adding a filter, it is necessary to initialize &struct bdev_filter
+ * using a bdev_filter_init() function.
+ *
+ * The bdev_filter_detach() function allows to detach the filter from the block
+ * device.
+ *
+ * Return: 0 if succeeded, or -EALREADY if the filter already exists.
+ */
+int bdev_filter_attach(struct block_device *bdev,
+				     struct bdev_filter *flt)
+{
+	int ret = 0;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+	blk_mq_quiesce_queue(bdev->bd_queue);
+
+	if (bdev->bd_filter)
+		ret = -EALREADY;
+	else
+		bdev->bd_filter = flt;
+
+	blk_mq_unquiesce_queue(bdev->bd_queue);
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+
+	return ret;
+}
+EXPORT_SYMBOL(bdev_filter_attach);
+
+/**
+ * bdev_filter_detach - Detach the filter from the block device.
+ * @bdev:
+ *	Block device.
+ *
+ * The filter should be added using the bdev_filter_attach() function.
+ *
+ * Return: 0 if succeeded, or -ENOENT if the filter was not found.
+ */
+int bdev_filter_detach(struct block_device *bdev)
+{
+	int ret = 0;
+	struct bdev_filter *flt = NULL;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+	blk_mq_quiesce_queue(bdev->bd_queue);
+
+	flt = bdev->bd_filter;
+	if (flt)
+		bdev->bd_filter = NULL;
+	else
+		ret = -ENOENT;
+
+	blk_mq_unquiesce_queue(bdev->bd_queue);
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+
+	if (flt)
+		bdev_filter_put(flt);
+
+	return ret;
+}
+EXPORT_SYMBOL(bdev_filter_detach);
diff --git a/block/blk-core.c b/block/blk-core.c
index 5487912befe8..284b295a7b23 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -678,9 +678,24 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 * to collect a list of requests submited by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
-	if (current->bio_list)
+	if (current->bio_list) {
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
+		return;
+	}
+
+	if (bio->bi_bdev->bd_filter && !bio_flagged(bio, BIO_FILTERED)) {
+		bool pass;
+
+		pass = bio->bi_bdev->bd_filter->fops->submit_bio_cb(bio);
+		bio_set_flag(bio, BIO_FILTERED);
+		if (!pass) {
+			bio->bi_status = BLK_STS_OK;
+			bio_endio(bio);
+			return;
+		}
+	}
+
+	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e0b098089ef2..3b58c69cbf9d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -68,6 +68,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	struct bdev_filter	*bd_filter;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
@@ -333,6 +334,7 @@ enum {
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
+	BIO_FILTERED,		/* bio has already been filtered */
 	BIO_FLAG_LAST
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 891f8cbcd043..dc2da4c7ab39 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1549,4 +1549,75 @@ struct io_comp_batch {
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
+/**
+ * struct bdev_filter_operations - Callback functions for the filter.
+ *
+ * @submit_bio_cb:
+ *	A callback function for I/O unit handling.
+ * @release_cb:
+ *	A callback function to disable the filter when removing a block
+ *	device from the system.
+ */
+struct bdev_filter_operations {
+	bool (*submit_bio_cb)(struct bio *bio);
+	void (*release_cb)(struct kref *kref);
+};
+
+/**
+ * struct bdev_filter - Block device filter.
+ *
+ * @kref:
+ *	Kernel reference counter.
+ * @fops:
+ *	The pointer to &struct bdev_filter_operations with callback
+ *	functions for the filter.
+ */
+struct bdev_filter {
+	struct kref kref;
+	const struct bdev_filter_operations *fops;
+};
+
+/**
+ * bdev_filter_init - Initialization of the filter structure.
+ * @flt:
+ *	Pointer to the &struct bdev_filter to be initialized.
+ * @fops:
+ *	The callback functions for the filter.
+ */
+static inline void bdev_filter_init(struct bdev_filter *flt,
+		const struct bdev_filter_operations *fops)
+{
+	kref_init(&flt->kref);
+	flt->fops = fops;
+};
+
+/**
+ * bdev_filter_get - Increment reference counter.
+ * @flt:
+ *	Pointer to the &struct bdev_filter.
+ *
+ * Allows to ensure that the filter will not be released as long as there are
+ * references to it.
+ */
+static inline void bdev_filter_get(struct bdev_filter *flt)
+{
+	kref_get(&flt->kref);
+}
+
+/**
+ * bdev_filter_put - Decrement reference counter.
+ * @flt:
+ *	Pointer to the &struct bdev_filter.
+ *
+ * Decrement the reference counter, and if 0, release filter.
+ */
+static inline void bdev_filter_put(struct bdev_filter *flt)
+{
+	kref_put(&flt->kref, flt->fops->release_cb);
+};
+
+int bdev_filter_attach(struct block_device *bdev, struct bdev_filter *flt);
+int bdev_filter_detach(struct block_device *bdev);
+
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.20.1

