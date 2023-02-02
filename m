Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6668E687D58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBBMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBBMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:31:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71976EF9D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675341035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lbSxgoHK7pyxZwrTNSUszxwXu92yO51pkZ2+yihgB4M=;
        b=VCaJXnU763zMjl5zzVPq+Z9WsTC8lXYbb6t6GZhm1h8isj/bfr60fql80Snwko/gvVDo5C
        SMOIQipG6jHLXmWnVdSYiNVzVeHaojbkmnNpdlr99PHnfPYAqSEZh1no8dZZ8BasJ93doW
        ERfhSVXH+Ul6tdtErTcJKRY81bk5XN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-yGTSZhjkPaqv5uqv0PMn5w-1; Thu, 02 Feb 2023 07:30:29 -0500
X-MC-Unique: yGTSZhjkPaqv5uqv0PMn5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1782685A5B1;
        Thu,  2 Feb 2023 12:30:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08E44492C3E;
        Thu,  2 Feb 2023 12:30:26 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] rtmutex: ensure we always wake up the top waiter
Date:   Thu,  2 Feb 2023 09:30:20 -0300
Message-Id: <20230202123020.14844-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let L1 and L2 be two spinlocks.

Let T1 be a task holding L1 and blocked on L2. T1, currently, is the top
waiter of L2.

Let T2 be the task holding L2.

Let T3 be a task trying to acquire L1.

The following events will lead to a state in which the wait queue of L2
isn't empty, but nobody holds the lock.

T1                T2                                  T3
==                ==                                  ==

                                                      spin_lock(L1)
                                                      | raw_spin_lock(L1->wait_lock)
                                                      | rtlock_slowlock_locked(L1)
                                                      | | task_blocks_on_rt_mutex(L1, T3)
                                                      | | | orig_waiter->lock = L1
                                                      | | | orig_waiter->task = T3
                                                      | | | raw_spin_unlock(L1->wait_lock)
                                                      | | | rt_mutex_adjust_prio_chain(T1, L1, L2, orig_waiter, T3)
                  spin_unlock(L2)                     | | | |
                  | rt_mutex_slowunlock(L2)           | | | |
                  | | raw_spin_lock(L2->wait_lock)    | | | |
                  | | wakeup(T1)                      | | | |
                  | | raw_spin_unlock(L2->wait_lock)  | | | |
                                                      | | | | waiter = T1->pi_blocked_on
                                                      | | | | waiter == rt_mutex_top_waiter(L2)
                                                      | | | | waiter->task == T1
                                                      | | | | raw_spin_lock(L2->wait_lock)
                                                      | | | | dequeue(L2, waiter)
                                                      | | | | update_prio(waiter, T1)
                                                      | | | | enqueue(L2, waiter)
                                                      | | | | waiter != rt_mutex_top_waiter(L2)
                                                      | | | | L2->owner == NULL
                                                      | | | | wakeup(T1)
                                                      | | | | raw_spin_unlock(L2->wait_lock)
T1 wakes up
T1 != top_waiter(L2)
schedule_rtlock()

If the deadline of T1 is updated before the call to update_prio(), and
the new deadline is greater than the deadline of the second top waiter,
then after the requeue, T1 is no longer the top waiter, and we wake up
the wrong task.

We can reproduce the bug in PREEMPT_RT with stress-ng:

while true; do
    stress-ng --sched deadline --sched-period 1000000000 \
    	    --sched-runtime 800000000 --sched-deadline \
    	    1000000000 --mmapfork 23 -t 20
done

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 010cf4e6d0b8..728f434de2bb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -901,8 +901,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * then we need to wake the new top waiter up to try
 		 * to get the lock.
 		 */
-		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
-			wake_up_state(waiter->task, waiter->wake_state);
+		top_waiter = rt_mutex_top_waiter(lock);
+		if (prerequeue_top_waiter != top_waiter)
+			wake_up_state(top_waiter->task, top_waiter->wake_state);
 		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
-- 
2.39.1

