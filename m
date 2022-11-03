Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35826617448
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiKCCeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKCCeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:34:04 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756013E17;
        Wed,  2 Nov 2022 19:34:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N2nnw4J2Yzl6CY;
        Thu,  3 Nov 2022 10:31:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgCXcXqWKGNjpCjdBA--.38653S6;
        Thu, 03 Nov 2022 10:34:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 2/2] block: fix use after free for bd_holder_dir
Date:   Thu,  3 Nov 2022 10:55:41 +0800
Message-Id: <20221103025541.1875809-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103025541.1875809-1-yukuai1@huaweicloud.com>
References: <20221103025541.1875809-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXcXqWKGNjpCjdBA--.38653S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1rGFyxAFWxAFy3Ar1DKFg_yoW8KFW5pa
        9IgFyrtry8GFsrZrsrt347XrWjg3W8W3W8CFya9F4IvrsxJr4vvr17AFy7WF1xKrWIvFs0
        qF1UX3yFvF1vkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, the caller of bd_link_disk_holer() get 'bdev' by
blkdev_get_by_dev(), which will look up 'bdev' by inode number 'dev'.
Howerver, it's possible that del_gendisk() can be called currently, and
'bd_holder_dir' can be freed before bd_link_disk_holer() access it, thus
use after free is triggered.

t1:				t2:
bdev = blkdev_get_by_dev
				del_gendisk
				 kobject_put(bd_holder_dir)
				  kobject_free()
bd_link_disk_holder

Fix the problem by checking disk is still live and grabbing a reference
to 'bd_holder_dir' first in bd_link_disk_holder().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/holder.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index 5fc68238ce3a..1c6c5b132a92 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -78,19 +78,32 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (bdev->bd_disk == disk)
 		return -EINVAL;
 
-	mutex_lock(&disk->open_mutex);
+	/*
+	 * del_gendisk drops the initial reference to bd_holder_dir, so we
+	 * need to keep our own here to allow for cleanup past that point.
+	 */
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!disk_live(bdev->bd_disk)) {
+		mutex_unlock(&bdev->bd_disk->open_mutex);
+		return -ENODEV;
+	}
 
-	WARN_ON_ONCE(!bdev->bd_holder);
+	kobject_get(bdev->bd_holder_dir);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
 
+	mutex_lock(&disk->open_mutex);
+	WARN_ON_ONCE(!bdev->bd_holder);
 	holder = bd_find_holder_disk(bdev, disk);
 	if (holder) {
 		holder->refcnt++;
+		kobject_put(bdev->bd_holder_dir);
 		goto out_unlock;
 	}
 
 	holder = kzalloc(sizeof(*holder), GFP_KERNEL);
 	if (!holder) {
 		ret = -ENOMEM;
+		kobject_put(bdev->bd_holder_dir);
 		goto out_unlock;
 	}
 
@@ -101,16 +114,12 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		ret = __link_disk_holder(bdev, disk);
 		if (ret) {
 			kfree(holder);
+			kobject_put(bdev->bd_holder_dir);
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
-- 
2.31.1

