Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE70602C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJRMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiJRMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:52:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D12C4C2E;
        Tue, 18 Oct 2022 05:52:44 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsDGg6t8pzJn3X;
        Tue, 18 Oct 2022 20:50:03 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 20:52:30 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:52:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <hch@lst.de>, <axboe@kernel.dk>, <gregkh@linuxfoundation.org>,
        <willy@infradead.org>, <martin.petersen@oracle.com>,
        <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 2/2] block: protect slave_dir/bd_holder_dir by open_mutex
Date:   Tue, 18 Oct 2022 21:14:32 +0800
Message-ID: <20221018131432.434167-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221018131432.434167-1-yukuai3@huawei.com>
References: <20221018131432.434167-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lifecycle of slave_dir/bd_holder_dir is problematic currently:

t1:			t2:

// get bdev of lower disk
blkdev_get_by_dev
			// remove lower disk
			del_gendisk
			 // initial reference is released, and
			 // slave_dir/bd_holder_dir can be freed
			 kobject_put
// uaf is triggered
bd_link_disk_holder

Fix the problem by protecting them by open_mutex.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c           |  8 ++++++--
 block/holder.c          | 13 ++++++++++++-
 block/partitions/core.c |  5 ++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423d..d9ad889d011a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -622,8 +622,12 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_unregister_queue(disk);
 
-	kobject_put(disk->part0->bd_holder_dir);
-	kobject_put(disk->slave_dir);
+	mutex_lock(&disk->open_mutex);
+	if (kobject_put(disk->part0->bd_holder_dir))
+		disk->part0->bd_holder_dir = NULL;
+	if (kobject_put(disk->slave_dir))
+		disk->slave_dir = NULL;
+	mutex_unlock(&disk->open_mutex);
 
 	part_stat_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
diff --git a/block/holder.c b/block/holder.c
index 5283bc804cc1..fdfbe82e31e3 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -75,6 +75,13 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	struct bd_holder_disk *holder;
 	int ret = 0;
 
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	/* Failed if bd_holder_dir is freed by del_gendisk() */
+	if (!bdev->bd_holder_dir) {
+		mutex_unlock(&bdev->bd_disk->open_mutex);
+		return -ENODEV;
+	}
+
 	mutex_lock(&disk->open_mutex);
 
 	WARN_ON_ONCE(!bdev->bd_holder);
@@ -111,6 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bd_link_disk_holder);
@@ -136,16 +144,19 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 {
 	struct bd_holder_disk *holder;
 
+	mutex_lock(&bdev->bd_disk->open_mutex);
 	mutex_lock(&disk->open_mutex);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		if (disk->slave_dir)
 			__unlink_disk_holder(bdev, disk);
-		kobject_put(bdev->bd_holder_dir);
+		if (kobject_put(bdev->bd_holder_dir))
+			bdev->bd_holder_dir = NULL;
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
 	mutex_unlock(&disk->open_mutex);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b8112f52d388..eef7b8615419 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -279,7 +279,10 @@ static void delete_partition(struct block_device *part)
 	__invalidate_device(part, true);
 
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
-	kobject_put(part->bd_holder_dir);
+	mutex_lock(&part->bd_disk->open_mutex);
+	if (kobject_put(part->bd_holder_dir))
+		part->bd_holder_dir = NULL;
+	mutex_unlock(&part->bd_disk->open_mutex);
 	device_del(&part->bd_device);
 
 	/*
-- 
2.31.1

