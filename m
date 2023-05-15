Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798B77032D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbjEOQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbjEOQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7895
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684167794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AMz4Fjl9TXL4AY+rOIFjwie698//LuwIHGQ1jFdVWWg=;
        b=F+8pxQ2ut38kxt4T4oMiAw7B46K7WFAZQjzpmoOCpvwE3jbU8lIa8E4CMoU4QlSJJjKdpy
        ZzHwWCH9V/X3aUuY8dN8Z8EDczy0/LLXThuihxC0QiImJ43I0ka3PN/Tmas1YxnXJ0cO3V
        oWhFpcxmv0FvXBcWj62M0BsQRXg4yuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-PULbhRKzNqyFhIgwo2iE2g-1; Mon, 15 May 2023 12:23:09 -0400
X-MC-Unique: PULbhRKzNqyFhIgwo2iE2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89FB85A5A3;
        Mon, 15 May 2023 16:23:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80CE140C2063;
        Mon, 15 May 2023 16:22:52 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v8] kernel/fork: beware of __put_task_struct calling context
Date:   Mon, 15 May 2023 13:22:47 -0300
Message-Id: <20230515162249.709839-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
locks. Therefore, it can't be called from an non-preemptible context.

One practical example is splat inside inactive_task_timer(), which is
called in a interrupt context:

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

Instead of calling __put_task_struct() directly, we defer it using
call_rcu(). A more natural approach would use a workqueue, but since
in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
the code would become more complex because we would need to put the
work_struct instance in the task_struct and initialize it when we
allocate a new task_struct.

Changelog
=========

v1:
* Initial implementation fixing the splat.

v2:
* Isolate the logic in its own function.
* Fix two more cases caught in review.

v3:
* Change __put_task_struct() to handle the issue internally.

v4:
* Explain why call_rcu() is safe to call from interrupt context.

v5:
* Explain why __put_task_struct() doesn't conflict with
  put_task_sruct_rcu_user.

v6:
* As per Sebastian's review, revert back the implementation of v2
  with a distinct function.
* Add a check in put_task_struct() to warning when called from a
  non-sleepable context.
* Address more call sites.

v7:
* Fix typos.
* Add an explanation why the new function doesn't conflict with
  delayed_free_task().

v8:
* Bring back v5.
* Fix coding style.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Hu Chunyu <chuhu@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/sched/task.h | 31 ++++++++++++++++++++++++++++++-
 kernel/fork.c              | 12 ++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..d39223bca0e0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -118,7 +118,36 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
 	return t;
 }
 
-extern void __put_task_struct(struct task_struct *t);
+extern void ___put_task_struct(struct task_struct *t);
+extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
+
+static inline void __put_task_struct(struct task_struct *tsk)
+{
+	/*
+	 * under PREEMPT_RT, we can't call put_task_struct
+	 * in atomic context because it will indirectly
+	 * acquire sleeping locks.
+	 *
+	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * to be called in process context.
+	 *
+	 * __put_task_struct() is called when
+	 * refcount_dec_and_test(&t->usage) succeeds.
+	 *
+	 * This means that it can't "conflict" with
+	 * put_task_struct_rcu_user() which abuses ->rcu the same
+	 * way; rcu_users has a reference so task->usage can't be
+	 * zero after rcu_users 1 -> 0 transition.
+	 *
+	 * delayed_free_task() also uses ->rcu, but it is only called
+	 * when it fails to fork a process. Therefore, there is no
+	 * way it can conflict with put_task_struct().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
+		call_rcu(&tsk->rcu, __put_task_struct_rcu_cb);
+	else
+		___put_task_struct(tsk);
+}
 
 static inline void put_task_struct(struct task_struct *t)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..1ac043135489 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -969,7 +969,7 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
-void __put_task_struct(struct task_struct *tsk)
+void ___put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
 	WARN_ON(refcount_read(&tsk->usage));
@@ -986,7 +986,15 @@ void __put_task_struct(struct task_struct *tsk)
 	sched_core_free(tsk);
 	free_task(tsk);
 }
-EXPORT_SYMBOL_GPL(__put_task_struct);
+EXPORT_SYMBOL_GPL(___put_task_struct);
+
+void __put_task_struct_rcu_cb(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	___put_task_struct(task);
+}
+EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);
 
 void __init __weak arch_task_cache_init(void) { }
 
-- 
2.40.1

