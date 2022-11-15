Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD13629B21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiKONuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiKONth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:49:37 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1760264A7;
        Tue, 15 Nov 2022 05:49:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBSGK2h05z4f3kJs;
        Tue, 15 Nov 2022 21:49:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9jnmHNjrPFIAg--.61645S12;
        Tue, 15 Nov 2022 21:49:32 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v3 08/10] block: fix use after free for bd_holder_dir
Date:   Tue, 15 Nov 2022 22:10:52 +0800
Message-Id: <20221115141054.1051801-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9jnmHNjrPFIAg--.61645S12
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1rGFyxAFWxAFy3Ar1DKFg_yoW8KFWUpF
        Z0gFyrKry8GrsrZrsrt347XFWjg3W8W3W8AFW29F4I9rZxArsI9r1xAFy7WF1xKrWIvF4q
        qF1UX3yFvF10kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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
 block/holder.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index dd9327b43ce0..c8e462053f49 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -65,12 +65,24 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk->slave_dir))
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
+	kobject_get(bdev->bd_holder_dir);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
 
+	mutex_lock(&disk->open_mutex);
 	WARN_ON_ONCE(!bdev->bd_holder);
 
 	holder = bd_find_holder_disk(bdev, disk);
 	if (holder) {
+		kobject_put(bdev->bd_holder_dir);
 		holder->refcnt++;
 		goto out_unlock;
 	}
@@ -92,11 +104,6 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		goto out_del_symlink;
 	list_add(&holder->list, &disk->slave_bdevs);
 
-	/*
-	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
-	 * to keep our own here to allow for cleanup past that point.
-	 */
-	kobject_get(bdev->bd_holder_dir);
 	mutex_unlock(&disk->open_mutex);
 	return 0;
 
@@ -106,6 +113,8 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	kfree(holder);
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
+	if (ret)
+		kobject_put(bdev->bd_holder_dir);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bd_link_disk_holder);
-- 
2.31.1

