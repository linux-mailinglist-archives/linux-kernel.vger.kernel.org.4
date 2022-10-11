Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605755FAE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJKIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJKINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:13:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20C68A1D0;
        Tue, 11 Oct 2022 01:13:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmpQH61nJzKGGx;
        Tue, 11 Oct 2022 16:11:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgA3N8msJUVjAYFiAA--.27549S7;
        Tue, 11 Oct 2022 16:13:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 3/5] blk-iocost: prevent configuration update concurrent with io throttling
Date:   Tue, 11 Oct 2022 16:35:45 +0800
Message-Id: <20221011083547.1831389-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3N8msJUVjAYFiAA--.27549S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8XFWfWr47Wry5WFy5twb_yoW5Ww4fpF
        WfWa9xtw40qrs7XFsruF47Xr13W397Kr4xAa97GryfCr17Kr1IqF1vkryj9F48JFZ3Zrs8
        JFZ5XrWqyry8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
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

This won't cause any severe problem currently, however, this doesn't
seems appropriate:

1) 'ioc->params' is read from multiple places without holding
'ioc->lock', unexpected value might be read if writing it concurrently.

2) If configuration is changed while io is throttling, the functionality
might be affected. For example, if module params is updated and cost
becomes smaller, waiting for timer that is caculated under old
configuration is not appropriate.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 6d36a4bd4382..5acc5f13bbd6 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3187,6 +3187,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(disk->queue);
 	}
 
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+
 	spin_lock_irq(&ioc->lock);
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable = ioc->enabled;
@@ -3278,10 +3281,17 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
 	blkdev_put_no_open(bdev);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
+
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
 	ret = -EINVAL;
 err:
 	blkdev_put_no_open(bdev);
@@ -3336,6 +3346,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct request_queue *q;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3346,14 +3357,18 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
+	q = bdev_get_queue(bdev);
+	ioc = q_to_ioc(q);
 	if (!ioc) {
 		ret = blk_iocost_init(bdev->bd_disk);
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+		ioc = q_to_ioc(q);
 	}
 
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
@@ -3402,11 +3417,18 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+
 	blkdev_put_no_open(bdev);
 	return nbytes;
 
 einval:
 	spin_unlock_irq(&ioc->lock);
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+
 	ret = -EINVAL;
 err:
 	blkdev_put_no_open(bdev);
-- 
2.31.1

