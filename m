Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5206FEC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbjEKHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjEKHAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:00:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38277AA1;
        Wed, 10 May 2023 23:59:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QH2n84qzqz4f3vdV;
        Thu, 11 May 2023 14:59:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLA7klxkxW3WJA--.19279S4;
        Thu, 11 May 2023 14:59:09 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] block: fix blktrace debugfs entries leak
Date:   Thu, 11 May 2023 14:56:33 +0800
Message-Id: <20230511065633.710045-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLA7klxkxW3WJA--.19279S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fWFyxGF1fury7Cr1rJFb_yoW8Cr4xpa
        9Iqr4Ykr1jvr4qqa4UCw17XayxKayrCFyrGFZakrySqF13GryavFZ2va9FqrWrGrsa9rZ0
        qr15KrZ7XrW8X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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

Commit 99d055b4fd4b ("block: remove per-disk debugfs files in
blk_unregister_queue") moves blk_trace_shutdown() from
blk_release_queue() to blk_unregister_queue(), this is safe if blktrace
is created through sysfs, however, there are some regression in corner
cases:

1) for scsi, passthrough io can still be issued after del_gendisk, and
   blktrace debugfs entries will be removed immediately after
   del_gendisk(), therefor passthrough io can't be tracked and blktrace
   will complain:

   failed read of /sys/kernel/debug/block/sdb/trace0: 5/Input/output error

2) blktrace can still be enabled after del_gendisk() through ioctl if the
   disk is opened before del_gendisk(), and if blktrace is not shutdown
   through ioctl before closing the disk, debugfs entries will be
   leaked.

It seems 1) is not important, while 2) needs to be fixed apparently.

Fix this problem by shutdown blktrace in blk_free_queue(),
disk_release() is not used because scsi sg support blktrace without
gendisk, and this is safe because queue is not freed yet, and
blk_trace_shutdown() is reentrant.

Fixes: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 00c74330fa92..a0c949533a5d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -263,6 +263,10 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 
 static void blk_free_queue(struct request_queue *q)
 {
+	mutex_lock(&q->debugfs_mutex);
+	blk_trace_shutdown(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 	blk_free_queue_stats(q->stats);
 	if (queue_is_mq(q))
 		blk_mq_release(q);
-- 
2.39.2

