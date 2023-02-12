Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E476936A6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 10:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBLJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 04:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBLJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 04:03:06 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08112862;
        Sun, 12 Feb 2023 01:03:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PF1hf0CyPz4f3jHr;
        Sun, 12 Feb 2023 17:02:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR9Bq+hjpfqtDA--.47546S7;
        Sun, 12 Feb 2023 17:03:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@infradead.org, jack@suse.cz, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next RFC 3/3] block: fix scan partition for exclusively open device again
Date:   Sun, 12 Feb 2023 17:26:41 +0800
Message-Id: <20230212092641.2394146-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR9Bq+hjpfqtDA--.47546S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZr18uFy7ArWfuF1DAF18Zrb_yoW5Xr17pF
        W5XFW5tryDKr93uFW0vFnrJw4Ykan7tw1xGryIkw1Iv3y3Jrs0kF9Yk395XrW8trWxWrWD
        Zr4UZFy09F1furJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

As explained in commit 36369f46e917 ("block: Do not reread partition table
on exclusively open device"), reread partition on the device that is
exclusively opened by someone else is problematic.

This patch will make sure partition scan will only be proceed if current
thread open the device exclusively, or the device is not opened
exclusively, and in the later case, other scanners and exclusive openers
will be blocked temporarily until partition scan is done.

Fixes: 10c70d95c0f2 ("block: remove the bd_openers checks in blk_drop_partitions")
Cc: <stable@vger.kernel.org>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 27 +++++++++++++++++++++++----
 block/ioctl.c |  2 +-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c0d1220bd798..6ec10ffeb9cc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -359,6 +359,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 {
 	struct block_device *bdev;
+	int ret = 0;
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
 		return -EINVAL;
@@ -367,11 +368,29 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	if (disk->open_partitions)
 		return -EBUSY;
 
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	/*
+	 * If the device is opened exclusively by current thread already, it's
+	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
+	 * synchronize with other exclusivet openers and other partition
+	 * scanners.
+	 */
+	if (!(mode & FMODE_EXCL)) {
+		ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
+		if (ret)
+			return ret;
+	}
+
+	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
+	if (IS_ERR(bdev)) {
+		ret =  PTR_ERR(bdev);
+		goto out;
+	}
 	blkdev_put(bdev, mode);
-	return 0;
+
+out:
+	if (!(mode & FMODE_EXCL))
+		bd_abort_claiming(disk->part0, disk_scan_partitions);
+	return ret;
 }
 
 /**
diff --git a/block/ioctl.c b/block/ioctl.c
index 0eefcdb936a0..3adfdb904dd0 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -529,7 +529,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
 		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
-		return disk_scan_partitions(bdev->bd_disk, mode & ~FMODE_EXCL);
+		return disk_scan_partitions(bdev->bd_disk, mode);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
-- 
2.31.1

