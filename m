Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88E85B3AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiIIOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIIOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:36:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE34121681
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:36:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CAB068AA6; Fri,  9 Sep 2022 16:36:22 +0200 (CEST)
Date:   Fri, 9 Sep 2022 16:36:20 +0200
From:   ChristophHellwig <hch@lst.de>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     ChristophHellwig <hch@lst.de>,
        MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to
 blktrans_{open, release} to avoid race condition
Message-ID: <20220909143620.GA9978@lst.de>
References: <20220809075753.21950-1-liwei.song@windriver.com> <20220809080809.GB14727@lst.de> <7f925359-69b0-49b1-cdbb-337912da4f9c@windriver.com> <4910c707-ad97-362f-911a-79e438e6e8ff@windriver.com> <cf66e306-f216-5247-7cff-36ce08eb4512@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf66e306-f216-5247-7cff-36ce08eb4512@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try this patch (it'll need to be split up into a few if it
works):

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 60b222799871e..9eda1dd98a406 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -24,24 +24,16 @@
 
 static LIST_HEAD(blktrans_majors);
 
-static void blktrans_dev_release(struct kref *kref)
+static void blktrans_free_disk(struct gendisk *disk)
 {
-	struct mtd_blktrans_dev *dev =
-		container_of(kref, struct mtd_blktrans_dev, ref);
+	struct mtd_blktrans_dev *dev = disk->private_data;
 
-	put_disk(dev->disk);
 	blk_mq_free_tag_set(dev->tag_set);
 	kfree(dev->tag_set);
 	list_del(&dev->list);
 	kfree(dev);
 }
 
-static void blktrans_dev_put(struct mtd_blktrans_dev *dev)
-{
-	kref_put(&dev->ref, blktrans_dev_release);
-}
-
-
 static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			       struct mtd_blktrans_dev *dev,
 			       struct request *req)
@@ -187,63 +179,58 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	struct mtd_blktrans_dev *dev = bdev->bd_disk->private_data;
 	int ret = 0;
 
-	kref_get(&dev->ref);
+	if (disk_openers(bdev->bd_disk) > 0)
+		return 0;
 
-	mutex_lock(&dev->lock);
-
-	if (dev->open)
-		goto unlock;
+	mutex_lock(&mtd_table_mutex);
+	if (!dev->mtd) {
+		mutex_lock(&mtd_table_mutex);
+		return -EINVAL;
+	}
+	ret = __get_mtd_device(dev->mtd);
+	mutex_unlock(&mtd_table_mutex);
+	if (ret)
+		return ret;
 
+	mutex_lock(&dev->lock);
 	__module_get(dev->tr->owner);
-
-	if (!dev->mtd)
-		goto unlock;
-
 	if (dev->tr->open) {
 		ret = dev->tr->open(dev);
 		if (ret)
 			goto error_put;
 	}
-
-	ret = __get_mtd_device(dev->mtd);
-	if (ret)
-		goto error_release;
 	dev->file_mode = mode;
-
-unlock:
 	dev->open++;
 	mutex_unlock(&dev->lock);
-	return ret;
 
-error_release:
-	if (dev->tr->release)
-		dev->tr->release(dev);
+	return 0;
+
 error_put:
 	module_put(dev->tr->owner);
 	mutex_unlock(&dev->lock);
-	blktrans_dev_put(dev);
+
+	put_mtd_device(dev->mtd);
 	return ret;
 }
 
 static void blktrans_release(struct gendisk *disk, fmode_t mode)
 {
 	struct mtd_blktrans_dev *dev = disk->private_data;
+	struct mtd_info *mtd = NULL;
 
-	mutex_lock(&dev->lock);
-
-	if (--dev->open)
-		goto unlock;
+	if (disk_openers(disk) > 0)
+		return;
 
+	mutex_lock(&dev->lock);
+	dev->open--;
 	module_put(dev->tr->owner);
-
-	if (dev->mtd) {
-		if (dev->tr->release)
-			dev->tr->release(dev);
-		__put_mtd_device(dev->mtd);
-	}
-unlock:
+	mtd = dev->mtd;
+	if (mtd && dev->tr->release)
+		dev->tr->release(dev);
 	mutex_unlock(&dev->lock);
-	blktrans_dev_put(dev);
+
+	if (mtd)
+		put_mtd_device(dev->mtd);
 }
 
 static int blktrans_getgeo(struct block_device *bdev, struct hd_geometry *geo)
@@ -266,6 +253,7 @@ static const struct block_device_operations mtd_block_ops = {
 	.owner		= THIS_MODULE,
 	.open		= blktrans_open,
 	.release	= blktrans_release,
+	.free_disk	= blktrans_free_disk,
 	.getgeo		= blktrans_getgeo,
 };
 
@@ -318,7 +306,6 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
  added:
 
 	mutex_init(&new->lock);
-	kref_init(&new->ref);
 	if (!tr->writesect)
 		new->readonly = 1;
 
@@ -410,6 +397,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 
 int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 {
+	struct mtd_info *old_mtd = NULL;
 	unsigned long flags;
 
 	lockdep_assert_held(&mtd_table_mutex);
@@ -438,13 +426,14 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 	if (old->open) {
 		if (old->tr->release)
 			old->tr->release(old);
-		__put_mtd_device(old->mtd);
+		old_mtd = old->mtd;
 	}
-
 	old->mtd = NULL;
-
 	mutex_unlock(&old->lock);
-	blktrans_dev_put(old);
+	put_disk(old->disk);
+
+	if (old->mtd)
+		put_mtd_device(old_mtd);
 	return 0;
 }
 
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 15cc9b95e32b5..41a81fc9f0462 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -7,7 +7,6 @@
 #define __MTD_TRANS_H__
 
 #include <linux/mutex.h>
-#include <linux/kref.h>
 #include <linux/sysfs.h>
 
 struct hd_geometry;
@@ -26,7 +25,6 @@ struct mtd_blktrans_dev {
 	unsigned long size;
 	int readonly;
 	int open;
-	struct kref ref;
 	struct gendisk *disk;
 	struct attribute_group *disk_attributes;
 	struct request_queue *rq;
