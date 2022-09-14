Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDE5B7E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiINBij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiINBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:38:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4434F6D547;
        Tue, 13 Sep 2022 18:38:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MS2xN4mw0zlCl1;
        Wed, 14 Sep 2022 09:36:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXOGMCFj24dCAw--.23886S5;
        Wed, 14 Sep 2022 09:38:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 1/4] md/raid10: cleanup wait_barrier()
Date:   Wed, 14 Sep 2022 09:49:11 +0800
Message-Id: <20220914014914.398712-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914014914.398712-1-yukuai1@huaweicloud.com>
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXOGMCFj24dCAw--.23886S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykJF4fKF4xCFWktFWUurg_yoW5Gw4Upw
        43GrW3JrWUAF9xJ398JF48CFyFq393XFWUGFyS93ykJF4jyrZ3Wr93G348KryDCrZ5XFyF
        qFWSyrZxKw4UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
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

Currently the nasty condition is wait_barrier() is hard to read. This
patch factor out the condition into a function.

There are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 56 ++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 64d6e4cd8a3a..56458a53043d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -957,44 +957,52 @@ static void lower_barrier(struct r10conf *conf)
 	wake_up(&conf->wait_barrier);
 }
 
+static bool stop_waiting_barrier(struct r10conf *conf)
+{
+	/* barrier is dropped */
+	if (!conf->barrier)
+		return true;
+
+	/*
+	 * If there are already pending requests (preventing the barrier from
+	 * rising completely), and the pre-process bio queue isn't empty, then
+	 * don't wait, as we need to empty that queue to get the nr_pending
+	 * count down.
+	 */
+	if (atomic_read(&conf->nr_pending)) {
+		struct bio_list *bio_list = current->bio_list;
+
+		if (bio_list && (!bio_list_empty(&bio_list[0]) ||
+				 !bio_list_empty(&bio_list[1])))
+			return true;
+	}
+
+	/* move on if recovery thread is blocked by us */
+	if (conf->mddev->thread->tsk == current &&
+	    test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
+	    conf->nr_queued > 0)
+		return true;
+
+	return false;
+}
+
 static bool wait_barrier(struct r10conf *conf, bool nowait)
 {
 	bool ret = true;
 
 	spin_lock_irq(&conf->resync_lock);
 	if (conf->barrier) {
-		struct bio_list *bio_list = current->bio_list;
-		conf->nr_waiting++;
-		/* Wait for the barrier to drop.
-		 * However if there are already pending
-		 * requests (preventing the barrier from
-		 * rising completely), and the
-		 * pre-process bio queue isn't empty,
-		 * then don't wait, as we need to empty
-		 * that queue to get the nr_pending
-		 * count down.
-		 */
 		/* Return false when nowait flag is set */
 		if (nowait) {
 			ret = false;
 		} else {
+			conf->nr_waiting++;
 			raid10_log(conf->mddev, "wait barrier");
 			wait_event_lock_irq(conf->wait_barrier,
-					    !conf->barrier ||
-					    (atomic_read(&conf->nr_pending) &&
-					     bio_list &&
-					     (!bio_list_empty(&bio_list[0]) ||
-					      !bio_list_empty(&bio_list[1]))) ||
-					     /* move on if recovery thread is
-					      * blocked by us
-					      */
-					     (conf->mddev->thread->tsk == current &&
-					      test_bit(MD_RECOVERY_RUNNING,
-						       &conf->mddev->recovery) &&
-					      conf->nr_queued > 0),
+					    stop_waiting_barrier(conf),
 					    conf->resync_lock);
+			conf->nr_waiting--;
 		}
-		conf->nr_waiting--;
 		if (!conf->nr_waiting)
 			wake_up(&conf->wait_barrier);
 	}
-- 
2.31.1

