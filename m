Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DC737967
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjFUC7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUC7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:59:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98889170A;
        Tue, 20 Jun 2023 19:59:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qm7W554TTz4f3tY4;
        Wed, 21 Jun 2023 10:58:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbBvZ5Jk68yyMA--.20696S4;
        Wed, 21 Jun 2023 10:58:57 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     pmenzel@molgen.mpg.de, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2] raid10: avoid spin_lock from fastpath from raid10_unplug()
Date:   Wed, 21 Jun 2023 18:57:28 +0800
Message-Id: <20230621105728.1268542-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbBvZ5Jk68yyMA--.20696S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWrWF1xAw1Dur45JFWkWFg_yoW8tw1fp3
        y5KFWFvFWUAryjq3yDWa17Za4Yga1vq3yI9rZ8C3s8ZF15WFWYqw4YyFW8WrWUZrs3Ca43
        ZF45KrW8Gr4jvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        TRNgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit 0c0be98bbe67 ("md/raid10: prevent unnecessary calls to wake_up()
in fast path") missed one place, for example, with:

	fio -direct=1 -rw=write/randwrite -iodepth=1 ...

Plug and unplug are called for each io, then wake_up() from raid10_unplug()
will cause lock contention as well.

Avoid this contention by using wake_up_barrier() instead of wake_up(),
where spin_lock is not held if waitqueue is empty.

Fio test script:

[global] 
name=random reads and writes
ioengine=libaio 
direct=1
readwrite=randrw 
rwmixread=70 
iodepth=64 
buffered=0 
filename=/dev/md0
size=1G
runtime=30 
time_based 
randrepeat=0 
norandommap 
refill_buffers 
ramp_time=10
bs=4k
numjobs=400
group_reporting=1
[job1]

Test result with ramdisk raid10(By Ali):

	Before this patch	With this patch
READ	IOPS=2033k		IOPS=3642k
WRITE	IOPS=871k		IOPS=1561K

By the way, in this scenario, blk_plug_cb() will be allocated and freed
for each io, this seems need to be optimized as well.

Reported-and-tested-by: Ali Gholami Rudi <aligrudi@gmail.com>
Closes: https://lore.kernel.org/all/20231606122233@laper.mirepesht/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - update commit message;

 drivers/md/raid10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d0de8c9fb3cf..fbaaa5e05edc 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1118,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		spin_lock_irq(&conf->device_lock);
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 		md_wakeup_thread(mddev->thread);
 		kfree(plug);
 		return;
@@ -1127,7 +1127,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
 	raid1_prepare_flush_writes(mddev->bitmap);
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
-- 
2.39.2

