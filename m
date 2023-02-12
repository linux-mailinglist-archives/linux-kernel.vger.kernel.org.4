Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161A6936A2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBLJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBLJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 04:03:06 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049A312863;
        Sun, 12 Feb 2023 01:03:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PF1hd398cz4f3l6n;
        Sun, 12 Feb 2023 17:02:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR9Bq+hjpfqtDA--.47546S6;
        Sun, 12 Feb 2023 17:02:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@infradead.org, jack@suse.cz, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next RFC 2/3] block: factor out the setting of GD_NEED_PART_SCAN
Date:   Sun, 12 Feb 2023 17:26:40 +0800
Message-Id: <20230212092641.2394146-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR9Bq+hjpfqtDA--.47546S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw18CrWUKry7Cw45CFyDWrg_yoW8AFyfpr
        WDXFZ0yFWjgr13uFWjv3Z7W3yjkanFyrWIyrW7Gw10v3sxZrsIyF9ak3yDAr10yrZ3GrZ8
        Wr45XFyFqFy8CFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

In order to prevent scan partition for a device that is opened
exclusively by someone else, new conditions will be added to
disk_scan_partitions() in the next patch. Hence if device is opened
exclusively between bdev_add() and disk_scan_partitions(), the first
partition scan will fail unexpected. This patch factor out the setting
of GD_NEED_PART_SCAN to prevent the problem.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 2 +-
 block/ioctl.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 075d8da284f5..c0d1220bd798 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -367,7 +367,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	if (disk->open_partitions)
 		return -EBUSY;
 
-	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
@@ -493,6 +492,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		if (ret)
 			goto out_unregister_bdi;
 
+		set_bit(GD_NEED_PART_SCAN, &disk->state);
 		bdev_add(disk->part0, ddev->devt);
 		if (get_capacity(disk))
 			disk_scan_partitions(disk, FMODE_READ);
diff --git a/block/ioctl.c b/block/ioctl.c
index 6dd49d877584..0eefcdb936a0 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -528,6 +528,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
+		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
-- 
2.31.1

