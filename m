Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFD72346A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjFFBSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFFBSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:18:46 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF12F9;
        Mon,  5 Jun 2023 18:18:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QZt0J4bSdz4f3l21;
        Tue,  6 Jun 2023 09:18:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbFwiX5kEj8lLA--.60639S4;
        Tue, 06 Jun 2023 09:18:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next] blk-ioc: fix recursive spin_lock/unlock_irq() in ioc_clear_queue()
Date:   Tue,  6 Jun 2023 09:14:38 +0800
Message-Id: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbFwiX5kEj8lLA--.60639S4
X-Coremail-Antispam: 1UD129KBjvJXoWruF1DZryxJFW8ArWfGr45Wrg_yoW8Jr4Dpr
        1IgrZ8tw10vr4xXF4DKw1kZr4xua90gws7Aws3Xr4fA342vrnIgF10krsFqF1FvFsrJFZ0
        vrsrJa95Ar1UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Recursive spin_lock/unlock_irq() is not safe, because spin_unlock_irq()
will enable irq unconditionally:

spin_lock_irq	queue_lock	-> disable irq
spin_lock_irq	ioc->lock
spin_unlock_irq ioc->lock	-> enable irq
/*
 * AA dead lock will be triggered if current context is preempted by irq,
 * and irq try to hold queue_lock again.
 */
spin_unlock_irq queue_lock

Fix this problem by using spin_lock/unlock() directly for 'ioc->lock'.

Fixes: 5a0ac57c48aa ("blk-ioc: protect ioc_destroy_icq() by 'queue_lock'")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-ioc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d5db92e62c43..25dd4db11121 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -179,9 +179,9 @@ void ioc_clear_queue(struct request_queue *q)
 		 * Other context won't hold ioc lock to wait for queue_lock, see
 		 * details in ioc_release_fn().
 		 */
-		spin_lock_irq(&icq->ioc->lock);
+		spin_lock(&icq->ioc->lock);
 		ioc_destroy_icq(icq);
-		spin_unlock_irq(&icq->ioc->lock);
+		spin_unlock(&icq->ioc->lock);
 	}
 	spin_unlock_irq(&q->queue_lock);
 }
-- 
2.39.2

