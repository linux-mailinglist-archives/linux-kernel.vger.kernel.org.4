Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554B270BE90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjEVMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjEVMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:40:59 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CFD137;
        Mon, 22 May 2023 05:40:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QPxQn67Lxz4f3jXM;
        Mon, 22 May 2023 20:22:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbFvXmtk96_lJw--.60238S4;
        Mon, 22 May 2023 20:22:08 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     regressions@leemhuis.info, chengming.zhou@linux.dev, hch@lst.de,
        axboe@kernel.dk, yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH RESEND] blk-wbt: fix that wbt can't be disabled by default
Date:   Mon, 22 May 2023 20:18:54 +0800
Message-Id: <20230522121854.2928880-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbFvXmtk96_lJw--.60238S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1kXr43Xw15Ww48Kw1fXrb_yoW8Cw1rp3
        WrGryIkF92qrWIvF13KF1UJw4fGF4vqr1xCrZakw1Sq3WUCr9avay8KFyFvF1jvFs3Ganx
        Zw13XFZrZFyUX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
wbt_enable_default()") removes the checking of CONFIG_BLK_WBT_MQ by
mistake, which is used to control enable or disable wbt by default.

Fix the problem by adding back the checking. This patch also do a litter
cleanup to make related code more readable.

Fixes: b11d31ae01e6 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/lkml/CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com/t/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-wbt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index e49a48684532..9ec2a2f1eda3 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -730,14 +730,16 @@ void wbt_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
-	bool disable_flag = q->elevator &&
-		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
+	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
+
+	if (q->elevator &&
+	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
+		enable = false;
 
 	/* Throttling already enabled? */
 	rqos = wbt_rq_qos(q);
 	if (rqos) {
-		if (!disable_flag &&
-		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		return;
 	}
@@ -746,7 +748,7 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && !disable_flag)
+	if (queue_is_mq(q) && enable)
 		wbt_init(disk);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
-- 
2.39.2

