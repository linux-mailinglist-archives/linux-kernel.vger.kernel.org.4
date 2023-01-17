Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658AD66E505
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjAQReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjAQR3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C3F4B192
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673976426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G55sfgJuDMMAYIXInt+J1nhGEOtoZVH7aF/U1ojeI9Q=;
        b=UtpbeYA+hGvIWTAqM1PykGOxMr5z2ffNOZZA55wxaVsc7gImXyiRcwUkJcHgHEAucIYuP0
        UhQEQJy1WBwcMYDmd2bbhXbm4lf7yPnq9gJsGd5F1f7cDN+jWUmFwwWng2TwQpP/HphIbN
        qZl7dNNfq9zsyr9ByhxJMn2B7v7bAi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-TSDXnP_fNaabKQZIIPOFhQ-1; Tue, 17 Jan 2023 12:27:03 -0500
X-MC-Unique: TSDXnP_fNaabKQZIIPOFhQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 661BD1816ECA;
        Tue, 17 Jan 2023 17:26:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 876B9492B00;
        Tue, 17 Jan 2023 17:26:54 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Cc:     Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] rtmutex: ensure we wake up the top waiter
Date:   Tue, 17 Jan 2023 14:26:49 -0300
Message-Id: <20230117172649.52465-1-wander@redhat.com>
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

In task_blocked_on_lock() we save the owner, release the wait_lock and
call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
again, the owner may release the lock and deboost.

rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
phase, waiter may be initially in the top of the queue, but after
dequeued and requeued it may no longer be true.

This scenario ends up waking the wrong task, which will verify it is no
the top waiter and comes back to sleep. Now we have a situation in which
no task is holding the lock but no one acquires it.

We can reproduce the bug in PREEMPT_RT with stress-ng:

while true; do
    stress-ng --sched deadline --sched-period 1000000000 \
    	    --sched-runtime 800000000 --sched-deadline \
    	    1000000000 --mmapfork 23 -t 20
done

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
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
2.39.0

