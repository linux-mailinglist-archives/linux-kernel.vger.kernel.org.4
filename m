Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B386D0489
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjC3MVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjC3MVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:21:30 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16A3868D;
        Thu, 30 Mar 2023 05:21:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PnMwM4mRGz4f3r2G;
        Thu, 30 Mar 2023 20:21:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLC5fiVkFoZ2GQ--.46838S7;
        Thu, 30 Mar 2023 20:21:25 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3 3/3] md: protect md_thread with rcu
Date:   Fri, 31 Mar 2023 04:20:46 +0800
Message-Id: <20230330202046.795213-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330202046.795213-1-yukuai1@huaweicloud.com>
References: <20230330202046.795213-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLC5fiVkFoZ2GQ--.46838S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUZF4UXr1xurWkAw4kCrg_yoW5Cr4rp3
        y3JFy3Ar48Ars8Zw4UG3WUA3WYqw1Iq3WUAry7Gw1fA3WUG3yaqry2kFy0qFn8Aa43AFs8
        Jr15KayrZ3yDtw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPEf5UUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our test reports a uaf for 'mddev->sync_thread':

T1                      T2
md_start_sync
 md_register_thread
 // mddev->sync_thread is set
			raid1d
			 md_check_recovery
			  md_reap_sync_thread
			   md_unregister_thread
			    kfree

 md_wakeup_thread
  wake_up
  ->sync_thread was freed

Root cause is that there is a small windown between register thread and
wake up thread, where the thread can be freed concurrently.

Currently, a global spinlock 'pers_lock' is borrowed to protect
'mddev->thread', this problem can be fixed likewise, however, there might
be similar problem for other md_thread, and I really don't like the idea to
borrow a global lock.

This patch protect md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9e80c5491c9a..161231e01faa 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -70,11 +70,7 @@
 #include "md-bitmap.h"
 #include "md-cluster.h"
 
-/* pers_list is a list of registered personalities protected
- * by pers_lock.
- * pers_lock does extra service to protect accesses to
- * mddev->thread when the mutex cannot be held.
- */
+/* pers_list is a list of registered personalities protected by pers_lock. */
 static LIST_HEAD(pers_list);
 static DEFINE_SPINLOCK(pers_lock);
 
@@ -802,13 +798,8 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
-	/* As we've dropped the mutex we need a spinlock to
-	 * make sure the thread doesn't disappear
-	 */
-	spin_lock(&pers_lock);
 	md_wakeup_thread(&mddev->thread);
 	wake_up(&mddev->sb_wait);
-	spin_unlock(&pers_lock);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
@@ -7921,13 +7912,16 @@ static int md_thread(void *arg)
 
 void md_wakeup_thread(struct md_thread **threadp)
 {
-	struct md_thread *thread = *threadp;
+	struct md_thread *thread;
 
+	rcu_read_lock();
+	thread = rcu_dereference(*threadp);
 	if (thread) {
 		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
 		set_bit(THREAD_WAKEUP, &thread->flags);
 		wake_up(&thread->wqueue);
 	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(md_wakeup_thread);
 
@@ -7955,7 +7949,7 @@ int md_register_thread(struct md_thread **threadp,
 		return err;
 	}
 
-	*threadp = thread;
+	rcu_assign_pointer(*threadp, thread);
 	return 0;
 }
 EXPORT_SYMBOL(md_register_thread);
@@ -7964,18 +7958,12 @@ void md_unregister_thread(struct md_thread **threadp)
 {
 	struct md_thread *thread;
 
-	/*
-	 * Locking ensures that mddev_unlock does not wake_up a
-	 * non-existent thread
-	 */
-	spin_lock(&pers_lock);
 	thread = *threadp;
-	if (!thread) {
-		spin_unlock(&pers_lock);
+	if (!thread)
 		return;
-	}
-	*threadp = NULL;
-	spin_unlock(&pers_lock);
+
+	rcu_assign_pointer(*threadp, NULL);
+	synchronize_rcu();
 
 	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
 	kthread_stop(thread->tsk);
-- 
2.39.2

