Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526B72A8A0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjFJDGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFJDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:06:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7935B8;
        Fri,  9 Jun 2023 20:06:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdNBJ3Hsxz4f3kKc;
        Sat, 10 Jun 2023 11:06:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbGX6INk2BFmLQ--.41501S4;
        Sat, 10 Jun 2023 11:06:01 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, bvanassche@acm.org, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, hare@suse.de,
        vincent.fu@samsung.com, akinobu.mita@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
Date:   Sat, 10 Jun 2023 11:01:43 +0800
Message-Id: <20230610030143.2604480-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbGX6INk2BFmLQ--.41501S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1xWFWrtF4UuF45Kr13XFb_yoW5Wr4rpF
        Wqga1jkry8J3WUXa1q9r4DKF1rAF4qvFyxGryxG3sagF1qvryvy3WkAF15Xr48t397CrWa
        v3ZrZrWft3WUXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Writing 'power' and 'submit_queues' concurrently will trigger kernel
panic:

Test script:

modprobe null_blk nr_devices=0
mkdir -p /sys/kernel/config/nullb/nullb0
while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
while true; do echo 1 > power; echo 0 > power; done

Test result:

BUG: kernel NULL pointer dereference, address: 0000000000000148
Oops: 0000 [#1] PREEMPT SMP
RIP: 0010:__lock_acquire+0x41d/0x28f0
Call Trace:
 <TASK>
 lock_acquire+0x121/0x450
 down_write+0x5f/0x1d0
 simple_recursive_removal+0x12f/0x5c0
 blk_mq_debugfs_unregister_hctxs+0x7c/0x100
 blk_mq_update_nr_hw_queues+0x4a3/0x720
 nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
 nullb_device_submit_queues_store+0x79/0xf0 [null_blk]
 configfs_write_iter+0x119/0x1e0
 vfs_write+0x326/0x730
 ksys_write+0x74/0x150

This is because del_gendisk() can concurrent with
blk_mq_update_nr_hw_queues():

nullb_device_power_store	nullb_apply_submit_queues
 null_del_dev
 del_gendisk
				 nullb_update_nr_hw_queues
				  if (!dev->nullb)
				  // still set while gendisk is deleted
				   return 0
				  blk_mq_update_nr_hw_queues
 dev->nullb = NULL

Fix this problem by synchronize nullb_device_power_store() and
nullb_update_nr_hw_queues() with a mutex.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/null_blk/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b3fedafe301e..21c668998d95 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1810,6 +1810,7 @@ static void null_del_dev(struct nullb *nullb)
 		return;
 
 	dev = nullb->dev;
+	dev->nullb = NULL;
 
 	ida_simple_remove(&nullb_indexes, nullb->index);
 
@@ -1831,7 +1832,6 @@ static void null_del_dev(struct nullb *nullb)
 	if (null_cache_active(nullb))
 		null_free_device_storage(nullb->dev, true);
 	kfree(nullb);
-	dev->nullb = NULL;
 }
 
 static void null_config_discard(struct nullb *nullb)
@@ -2087,7 +2087,6 @@ static int null_add_dev(struct nullb_device *dev)
 		goto out;
 	}
 	nullb->dev = dev;
-	dev->nullb = nullb;
 
 	spin_lock_init(&nullb->lock);
 
@@ -2179,6 +2178,7 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_ida_free;
 
+	dev->nullb = nullb;
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
@@ -2200,7 +2200,6 @@ static int null_add_dev(struct nullb_device *dev)
 	cleanup_queues(nullb);
 out_free_nullb:
 	kfree(nullb);
-	dev->nullb = NULL;
 out:
 	return rv;
 }
-- 
2.39.2

