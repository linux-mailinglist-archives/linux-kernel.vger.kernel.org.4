Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFF629B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiKONuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiKONth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:49:37 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68CB25E9D;
        Tue, 15 Nov 2022 05:49:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBSGK5khYz4f3vf7;
        Tue, 15 Nov 2022 21:49:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9jnmHNjrPFIAg--.61645S13;
        Tue, 15 Nov 2022 21:49:32 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v3 09/10] block: store the holder kobject in bd_holder_disk
Date:   Tue, 15 Nov 2022 22:10:53 +0800
Message-Id: <20221115141054.1051801-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9jnmHNjrPFIAg--.61645S13
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW3JryrJF17AF43CFW3Jrb_yoW8ZF1fpF
        Z8Xa48JrW8Ga1UWw4qqw4UGFy29rWUJ3WxGFyIkrWS9rW3Jr4kCF13Jr1UXFWrKrWxKrsI
        qF17X3yFyF4vkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
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

We hold a reference to the holder kobject for each bd_holder_disk,
so to make the code a bit more robust, use a reference to it instead
of the block_device.  As long as no one clears ->bd_holder_dir in
before freeing the disk, this isn't strictly required, but it does
make the code more clear and more robust.

Orignally-From: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/holder.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index c8e462053f49..3332142bb867 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -4,7 +4,7 @@
 
 struct bd_holder_disk {
 	struct list_head	list;
-	struct block_device	*bdev;
+	struct kobject		*holder_dir;
 	int			refcnt;
 };
 
@@ -14,7 +14,7 @@ static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 	struct bd_holder_disk *holder;
 
 	list_for_each_entry(holder, &disk->slave_bdevs, list)
-		if (holder->bdev == bdev)
+		if (holder->holder_dir == bdev->bd_holder_dir)
 			return holder;
 	return NULL;
 }
@@ -94,8 +94,9 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	}
 
 	INIT_LIST_HEAD(&holder->list);
-	holder->bdev = bdev;
 	holder->refcnt = 1;
+	holder->holder_dir = bdev->bd_holder_dir;
+
 	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
 	if (ret)
 		goto out_free_holder;
@@ -140,8 +141,8 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
-		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_holder_dir);
+		del_symlink(holder->holder_dir, &disk_to_dev(disk)->kobj);
+		kobject_put(holder->holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-- 
2.31.1

