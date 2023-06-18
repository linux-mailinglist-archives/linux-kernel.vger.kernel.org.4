Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2567173450D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFRG0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRG0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:26:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51AE4F;
        Sat, 17 Jun 2023 23:26:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkNGB0RqQz4f3jJ1;
        Sun, 18 Jun 2023 14:26:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA30JOdo45kQGLeLw--.26295S4;
        Sun, 18 Jun 2023 14:26:39 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     aligrudi@gmail.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] raid10: avoid spin_lock from fastpath from raid10_unplug()
Date:   Sun, 18 Jun 2023 22:25:20 +0800
Message-Id: <20230618142520.14662-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JOdo45kQGLeLw--.26295S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWxZryrZFy5tFyfWFyrtFb_yoW8Cr4fp3
        yYgFWYgrWUZryjvw4DGa1UZ3WYga1vgrW2kr95Cwn8XF1YgFWaqF45trWDWrWUZrs3CFy5
        AayakrZ8Gr4jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0p
        RQo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit 0c0be98bbe67 ("md/raid10: prevent unnecessary calls to wake_up()
in fast path") missed one place, for example, while testing with:

fio -direct=1 -rw=write/randwrite -iodepth=1 ...

Then plug and unplug will be called for each io, then wake_up() from
raid10_unplug() will cause lock contention as well.

Avoid this contention by using wake_up_barrier() instead of wake_up(),
where spin_lock is not held while waitqueue is empty.

By the way, in this scenario, each blk_plug_cb() will be allocated and
freed for each io, this seems need to be optimized as well.

Reported-and-tested-by: Ali Gholami Rudi <aligrudi@gmail.com>
Link: https://lore.kernel.org/all/20231606122233@laper.mirepesht/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
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

