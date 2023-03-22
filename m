Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8E6C415F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCVEAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCVEA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:26 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96925474E7;
        Tue, 21 Mar 2023 21:00:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhF9t5Y8lz4f3mLm;
        Wed, 22 Mar 2023 12:00:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBSfRpkU+ZjFQ--.28641S4;
        Wed, 22 Mar 2023 12:00:20 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     ming.lei@redhat.com, jack@suse.cz, hch@infradead.org,
        axboe@kernel.dk, yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition failed
Date:   Wed, 22 Mar 2023 11:59:26 +0800
Message-Id: <20230322035926.1791317-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBSfRpkU+ZjFQ--.28641S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur48Kw47JF1UWr1Dtw17Awb_yoW8uF4xpF
        nxJa15KryDWr1fCa4jv3WxXa15Ja9rZryfJrW3G34IvwnxXanIyF92k3yDWF10qr93JrWD
        ur15W34ruF1furDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
set, and partition scan will be proceed again when blkdev_get_by_dev()
is called. However, this will cause a problem that re-assemble partitioned
raid device will creat partition for underlying disk.

Test procedure:

mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
sgdisk -n 0:0:+100MiB /dev/md0
blockdev --rereadpt /dev/sda
blockdev --rereadpt /dev/sdb
mdadm -S /dev/md0
mdadm -A /dev/md0 /dev/sda /dev/sdb

Test result: underlying disk partition and raid partition can be
observed at the same time

Note that this can still happen in come corner cases that
GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
device.

Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 08bb1a9ec22c..a72e27d6779d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -368,7 +368,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	if (disk->open_partitions)
 		return -EBUSY;
 
-	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	/*
 	 * If the device is opened exclusively by current thread already, it's
 	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
@@ -381,12 +380,19 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 			return ret;
 	}
 
+	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
 	if (IS_ERR(bdev))
 		ret =  PTR_ERR(bdev);
 	else
 		blkdev_put(bdev, mode & ~FMODE_EXCL);
 
+	/*
+	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
+	 * and this will cause that re-assemble partitioned raid device will
+	 * creat partition for underlying disk.
+	 */
+	clear_bit(GD_NEED_PART_SCAN, &disk->state);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(disk->part0, disk_scan_partitions);
 	return ret;
-- 
2.31.1

