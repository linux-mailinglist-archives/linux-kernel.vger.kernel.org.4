Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF47B65DBFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjADSSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjADSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883F186F4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672856232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7eWASEchnGHOlz8RYd1duNxZ3+6gs7X9NPG+qDh7uMQ=;
        b=Av1hYKM9okQAP7+tjbkT6YZsEAH92r5RXdZJpLAZxTMRGTLDzlnEcfEB7QDZo/NSLnYPnS
        86YTw9ikp/vZvcjWbKZDTUehD9kyinB170ZUHZbvbiR52n++M0R55p3GFw1zRJ3t2I6duT
        5b0v0UDG+mv/antfAckBwetL+xWAQ40=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-qN5_tDt-P7Gyp0csf8iaxg-1; Wed, 04 Jan 2023 13:17:08 -0500
X-MC-Unique: qN5_tDt-P7Gyp0csf8iaxg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AB91299E752;
        Wed,  4 Jan 2023 18:17:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B59492B06;
        Wed,  4 Jan 2023 18:17:04 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/deadline: fix inactive_task_timer splat with CONFIG_PREEMPT_RT
Date:   Wed,  4 Jan 2023 15:17:01 -0300
Message-Id: <20230104181701.43224-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inactive_task_timer() executes in interrupt (atomic) context. It calls
put_task_struct(), which indirectly acquires sleeping locks under
PREEMPT_RT.

Below is an example of a splat that happened in a test environment:

 CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
 Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
 Call Trace:
 dump_stack_lvl+0x57/0x7d
 mark_lock_irq.cold+0x33/0xba
 ? stack_trace_save+0x4b/0x70
 ? save_trace+0x55/0x150
 mark_lock+0x1e7/0x400
 mark_usage+0x11d/0x140
 __lock_acquire+0x30d/0x930
 lock_acquire.part.0+0x9c/0x210
 ? refill_obj_stock+0x3d/0x3a0
 ? rcu_read_lock_sched_held+0x3f/0x70
 ? trace_lock_acquire+0x38/0x140
 ? lock_acquire+0x30/0x80
 ? refill_obj_stock+0x3d/0x3a0
 rt_spin_lock+0x27/0xe0
 ? refill_obj_stock+0x3d/0x3a0
 refill_obj_stock+0x3d/0x3a0
 ? inactive_task_timer+0x1ad/0x340
 kmem_cache_free+0x357/0x560
 inactive_task_timer+0x1ad/0x340
 ? switched_from_dl+0x2d0/0x2d0
 __run_hrtimer+0x8a/0x1a0
 __hrtimer_run_queues+0x91/0x130
 hrtimer_interrupt+0x10f/0x220
 __sysvec_apic_timer_interrupt+0x7b/0xd0
 sysvec_apic_timer_interrupt+0x4f/0xd0
 ? asm_sysvec_apic_timer_interrupt+0xa/0x20
 asm_sysvec_apic_timer_interrupt+0x12/0x20
 RIP: 0033:0x7fff196bf6f5

Instead of calling put_task_struct() directly, we defer it using
call_rcu(). A more natural approach would use a workqueue, but since
in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
the code would become more complex because we would need to put the
work_struct instance in the task_struct and initialize it when we
allocate a new task_struct.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/build_policy.c |  1 +
 kernel/sched/deadline.c     | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index d9dc9ab3773f..f159304ee792 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/rcupdate.h>
 
 #include <uapi/linux/sched/types.h>
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ae8f41e3372..ab9301d4cc24 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1405,6 +1405,13 @@ static void update_curr_dl(struct rq *rq)
 	}
 }
 
+static void delayed_put_task_struct(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	__put_task_struct(task);
+}
+
 static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 {
 	struct sched_dl_entity *dl_se = container_of(timer,
@@ -1442,7 +1449,22 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	dl_se->dl_non_contending = 0;
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * Decrement the refcount explicitly to avoid unnecessarily
+		 * calling call_rcu.
+		 */
+		if (refcount_dec_and_test(&p->usage))
+			/*
+			 * under PREEMPT_RT, we can't call put_task_struct
+			 * in atomic context because it will indirectly
+			 * acquire sleeping locks.
+			 */
+			call_rcu(&p->rcu, delayed_put_task_struct);
+	} else {
+		put_task_struct(p);
+	}
 
 	return HRTIMER_NORESTART;
 }
-- 
2.39.0

