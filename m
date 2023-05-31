Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE08171786C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjEaHis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjEaHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:38:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E71A1;
        Wed, 31 May 2023 00:38:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWLj83DzPz4f3lXJ;
        Wed, 31 May 2023 15:38:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBp+XZk_RNsKg--.65307S4;
        Wed, 31 May 2023 15:38:19 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, dlemoal@kernel.org, quic_pragalla@quicinc.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
Date:   Wed, 31 May 2023 15:34:35 +0800
Message-Id: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBp+XZk_RNsKg--.65307S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF18uryfWr4xKF18KF4kZwb_yoW5AFykpr
        yrWanxC348Jr4xWrWDKa17u3ySga1F9rsFyr4fGrZ5ArnFvrsIg3W8AryFqF9YqFZ7XrZ8
        Xr47J395Cr4UCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, icq is tracked by both request_queue(icq->q_node) and
task(icq->ioc_node), and ioc_clear_queue() from elevator exit is not
safe because it can access the list without protection:

ioc_clear_queue			ioc_release_fn
 lock queue_lock
 list_splice
 /* move queue list to a local list */
 unlock queue_lock
 /*
  * lock is released, the local list
  * can be accessed through task exit.
  */

				lock ioc->lock
				while (!hlist_empty)
				 icq = hlist_entry
				 lock queue_lock
				  ioc_destroy_icq
				   delete icq->ioc_node
 while (!list_empty)
  icq = list_entry()		   list_del icq->q_node
  /*
   * This is not protected by any lock,
   * list_entry concurrent with list_del
   * is not safe.
   */

				 unlock queue_lock
				unlock ioc->lock

Fix this problem by protecting list 'icq->q_node' by queue_lock from
ioc_clear_queue().

Reported-and-tested-by: Pradeep Pragallapati <quic_pragalla@quicinc.com>
Link: https://lore.kernel.org/lkml/20230517084434.18932-1-quic_pragalla@quicinc.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-ioc.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 63fc02042408..d5db92e62c43 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -77,6 +77,10 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	struct elevator_type *et = q->elevator->type;
 
 	lockdep_assert_held(&ioc->lock);
+	lockdep_assert_held(&q->queue_lock);
+
+	if (icq->flags & ICQ_DESTROYED)
+		return;
 
 	radix_tree_delete(&ioc->icq_tree, icq->q->id);
 	hlist_del_init(&icq->ioc_node);
@@ -128,12 +132,7 @@ static void ioc_release_fn(struct work_struct *work)
 			spin_lock(&q->queue_lock);
 			spin_lock(&ioc->lock);
 
-			/*
-			 * The icq may have been destroyed when the ioc lock
-			 * was released.
-			 */
-			if (!(icq->flags & ICQ_DESTROYED))
-				ioc_destroy_icq(icq);
+			ioc_destroy_icq(icq);
 
 			spin_unlock(&q->queue_lock);
 			rcu_read_unlock();
@@ -171,23 +170,20 @@ static bool ioc_delay_free(struct io_context *ioc)
  */
 void ioc_clear_queue(struct request_queue *q)
 {
-	LIST_HEAD(icq_list);
-
 	spin_lock_irq(&q->queue_lock);
-	list_splice_init(&q->icq_list, &icq_list);
-	spin_unlock_irq(&q->queue_lock);
-
-	rcu_read_lock();
-	while (!list_empty(&icq_list)) {
+	while (!list_empty(&q->icq_list)) {
 		struct io_cq *icq =
-			list_entry(icq_list.next, struct io_cq, q_node);
+			list_first_entry(&q->icq_list, struct io_cq, q_node);
 
+		/*
+		 * Other context won't hold ioc lock to wait for queue_lock, see
+		 * details in ioc_release_fn().
+		 */
 		spin_lock_irq(&icq->ioc->lock);
-		if (!(icq->flags & ICQ_DESTROYED))
-			ioc_destroy_icq(icq);
+		ioc_destroy_icq(icq);
 		spin_unlock_irq(&icq->ioc->lock);
 	}
-	rcu_read_unlock();
+	spin_unlock_irq(&q->queue_lock);
 }
 #else /* CONFIG_BLK_ICQ */
 static inline void ioc_exit_icqs(struct io_context *ioc)
-- 
2.39.2

