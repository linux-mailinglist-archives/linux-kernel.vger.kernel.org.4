Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE56060CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJTM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJTM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:59:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5A127937;
        Thu, 20 Oct 2022 05:58:57 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtSGd0RY8zVj1y;
        Thu, 20 Oct 2022 20:54:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:58:50 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 20:58:49 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <hch@lst.de>, <willy@infradead.org>,
        <kch@nvidia.com>, <martin.petersen@oracle.com>,
        <johannes.thumshirn@wdc.com>, <yukuai3@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>
Subject: [PATCH -nect RFC v2 2/2] block: fix uaf for bd_holder_dir
Date:   Thu, 20 Oct 2022 21:20:49 +0800
Message-ID: <20221020132049.3947415-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020132049.3947415-1-yukuai3@huawei.com>
References: <20221020132049.3947415-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lifecycle of bd_holder_dir is problematic:

t1:			t2:

// get bdev of lower disk
blkdev_get_by_dev
			// remove lower disk
			del_gendisk
			 // initial reference is released, and
			 // bd_holder_dir can be freed
			 kobject_put
// uaf is triggered
bd_link_disk_holder

Fix the problem by protecting bd_holder_dir by open_mutex.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c           |  6 +++++-
 block/holder.c          | 19 +++++++++++++------
 block/partitions/core.c |  5 ++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 53f9c8b2690a..b3d04e79e854 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -499,6 +499,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = -ENOMEM;
 		goto out_del_integrity;
 	}
+	disk->part0->holder_dir_ref = 1;
+
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 	if (!disk->slave_dir) {
 		ret = -ENOMEM;
@@ -557,6 +559,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	kobject_put(disk->slave_dir);
 out_put_holder_dir:
 	kobject_put(disk->part0->bd_holder_dir);
+	disk->part0->bd_holder_dir = NULL;
+	disk->part0->holder_dir_ref = 0;
 out_del_integrity:
 	blk_integrity_del(disk);
 out_del_block_link:
@@ -649,7 +653,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_unregister_queue(disk);
 
-	kobject_put(disk->part0->bd_holder_dir);
+	bd_put_holder_dir(disk->part0);
 	kobject_put(disk->slave_dir);
 
 	part_stat_set_all(disk->part0, 0);
diff --git a/block/holder.c b/block/holder.c
index 5283bc804cc1..2e28b472ba1a 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include "blk.h"
 
 struct bd_holder_disk {
 	struct list_head	list;
@@ -85,9 +86,19 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		goto out_unlock;
 	}
 
+	/*
+	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
+	 * to keep our own here to allow for cleanup past that point.
+	 */
+	if (!bd_try_get_holder_dir(bdev)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
 	holder = kzalloc(sizeof(*holder), GFP_KERNEL);
 	if (!holder) {
 		ret = -ENOMEM;
+		bd_put_holder_dir(bdev);
 		goto out_unlock;
 	}
 
@@ -98,16 +109,12 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		ret = __link_disk_holder(bdev, disk);
 		if (ret) {
 			kfree(holder);
+			bd_put_holder_dir(bdev);
 			goto out_unlock;
 		}
 	}
 
 	list_add(&holder->list, &disk->slave_bdevs);
-	/*
-	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
-	 * to keep our own here to allow for cleanup past that point.
-	 */
-	kobject_get(bdev->bd_holder_dir);
 
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
@@ -141,7 +148,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		if (disk->slave_dir)
 			__unlink_disk_holder(bdev, disk);
-		kobject_put(bdev->bd_holder_dir);
+		bd_put_holder_dir(bdev);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b8112f52d388..39a14f7c308e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -279,7 +279,7 @@ static void delete_partition(struct block_device *part)
 	__invalidate_device(part, true);
 
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
-	kobject_put(part->bd_holder_dir);
+	bd_put_holder_dir(part);
 	device_del(&part->bd_device);
 
 	/*
@@ -390,6 +390,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	bdev->bd_holder_dir = kobject_create_and_add("holders", &pdev->kobj);
 	if (!bdev->bd_holder_dir)
 		goto out_del;
+	bdev->holder_dir_ref = 1;
 
 	dev_set_uevent_suppress(pdev, 0);
 	if (flags & ADDPART_FLAG_WHOLEDISK) {
@@ -411,6 +412,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 
 out_del:
 	kobject_put(bdev->bd_holder_dir);
+	bdev->bd_holder_dir = NULL;
+	bdev->holder_dir_ref = 0;
 	device_del(pdev);
 out_put:
 	put_device(pdev);
-- 
2.31.1

