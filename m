Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAB64C25A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiLNCn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiLNCnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:43:51 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70220559E;
        Tue, 13 Dec 2022 18:43:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NX06k3Cthz4f3tpj;
        Wed, 14 Dec 2022 10:43:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgAnGqlfOJljIQ9HCA--.54156S4;
        Wed, 14 Dec 2022 10:43:45 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2] block, bfq: fix possible uaf for 'bfqq->bic'
Date:   Wed, 14 Dec 2022 11:04:30 +0800
Message-Id: <20221214030430.3304151-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAnGqlfOJljIQ9HCA--.54156S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rtw4fuF1kGryDGw4fGrg_yoW5trWkpr
        sxtayfZr48JryYgw47Zr10gF18Xws3Wry7Jr1Sqwn3Xry5Zr1qqFyqyF18ZFW0grZ5u39r
        Wr1DGrZ7Xr1IvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our test report a uaf for 'bfqq->bic' in 5.10:

==================================================================
BUG: KASAN: use-after-free in bfq_select_queue+0x378/0xa30

CPU: 6 PID: 2318352 Comm: fsstress Kdump: loaded Not tainted 5.10.0-60.18.0.50.h602.kasan.eulerosv2r11.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
Call Trace:
 bfq_select_queue+0x378/0xa30
 bfq_dispatch_request+0xe8/0x130
 blk_mq_do_dispatch_sched+0x62/0xb0
 __blk_mq_sched_dispatch_requests+0x215/0x2a0
 blk_mq_sched_dispatch_requests+0x8f/0xd0
 __blk_mq_run_hw_queue+0x98/0x180
 __blk_mq_delay_run_hw_queue+0x22b/0x240
 blk_mq_run_hw_queue+0xe3/0x190
 blk_mq_sched_insert_requests+0x107/0x200
 blk_mq_flush_plug_list+0x26e/0x3c0
 blk_finish_plug+0x63/0x90
 __iomap_dio_rw+0x7b5/0x910
 iomap_dio_rw+0x36/0x80
 ext4_dio_read_iter+0x146/0x190 [ext4]
 ext4_file_read_iter+0x1e2/0x230 [ext4]
 new_sync_read+0x29f/0x400
 vfs_read+0x24e/0x2d0
 ksys_read+0xd5/0x1b0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Commit 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
changes that move process to a new cgroup will allocate a new bfqq to
use, however, the old bfqq and new bfqq can point to the same bic:

1) Initial state, two process with io in the same cgroup.

Process 1       Process 2
 (BIC1)          (BIC2)
  |  Λ            |  Λ
  |  |            |  |
  V  |            V  |
  bfqq1           bfqq2

2) bfqq1 is merged to bfqq2.

Process 1       Process 2
 (BIC1)          (BIC2)
  |               |
   \-------------\|
                  V
  bfqq1           bfqq2(coop)

3) Process 1 exit, then issue new io(denoce IOA) from Process 2.

 (BIC2)
  |  Λ
  |  |
  V  |
  bfqq2(coop)

4) Before IOA is completed, move Process 2 to another cgroup and issue io.

Process 2
 (BIC2)
   Λ
   |\--------------\
   |                V
  bfqq2           bfqq3

Now that BIC2 points to bfqq3, while bfqq2 and bfqq3 both point to BIC2.
If all the requests are completed, and Process 2 exit, BIC2 will be
freed while there is no guarantee that bfqq2 will be freed before BIC2.

Fix the problem by clearing bfqq->bic while bfqq is detached from bic.

Fixes: 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - Use a new solution as suggested by Jan.

 block/bfq-iosched.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a72304c728fc..b111a7b8dca6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -386,6 +386,12 @@ static void bfq_put_stable_ref(struct bfq_queue *bfqq);
 
 void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
 {
+	struct bfq_queue *old_bfqq = bic->bfqq[is_sync];
+
+	/* Clear bic pointer if bfqq is detached from this bic */
+	if (old_bfqq && old_bfqq->bic == bic)
+		old_bfqq->bic = NULL;
+
 	/*
 	 * If bfqq != NULL, then a non-stable queue merge between
 	 * bic->bfqq and bfqq is happening here. This causes troubles
@@ -5311,7 +5317,6 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
 		unsigned long flags;
 
 		spin_lock_irqsave(&bfqd->lock, flags);
-		bfqq->bic = NULL;
 		bfq_exit_bfqq(bfqd, bfqq);
 		bic_set_bfqq(bic, NULL, is_sync);
 		spin_unlock_irqrestore(&bfqd->lock, flags);
-- 
2.31.1

