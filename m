Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550C68BD7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBFNGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjBFNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1E5244
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675688728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=09AkApwLvB9yC9Uk4K9ttZ2n5UCGkgVxYQHo2Kbt4uc=;
        b=LXDna3Elz0+Uo1K+4Y+VYbTdzMUq3VaM15ly/pCTaCtIbmH5t85AaNM1evDZ6elKbVxnTd
        lXs9yazdUy8WnTB0xALXssCK2sM4WyK2DG2mlVcP+RU8XZyCYgUyFF5mLZ2q7PCDebACQA
        goCqdICr0KF8nMtaiRO/vr18wvkc9y4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-DIuJCX7QP9-bAP2jERT6fQ-1; Mon, 06 Feb 2023 08:05:09 -0500
X-MC-Unique: DIuJCX7QP9-bAP2jERT6fQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0117C85A5A3;
        Mon,  6 Feb 2023 13:05:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98F592026D38;
        Mon,  6 Feb 2023 13:05:05 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH v4] kernel/fork: beware of __put_task_struct calling context
Date:   Mon,  6 Feb 2023 10:04:47 -0300
Message-Id: <20230206130449.41360-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Hu Chunyu <chuhu@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Cc: Paul McKenney <paulmck@kernel.org>
---
 kernel/fork.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..532dd2ceb6a3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -840,7 +840,7 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
-void __put_task_struct(struct task_struct *tsk)
+static void ___put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
 	WARN_ON(refcount_read(&tsk->usage));
@@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk)
 	sched_core_free(tsk);
 	free_task(tsk);
 }
+
+static void delayed_put_task_struct_rcu(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	___put_task_struct(task);
+}
+
+void __put_task_struct(struct task_struct *tsk)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
+		/*
+		 * under PREEMPT_RT, we can't call put_task_struct
+		 * in atomic context because it will indirectly
+		 * acquire sleeping locks.
+		 *
+		 * call_rcu() will schedule delayed_put_task_struct_rcu()
+		 * to be called in process context.
+		 */
+		call_rcu(&tsk->rcu, delayed_put_task_struct_rcu);
+	else
+		___put_task_struct(tsk);
+}
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
 void __init __weak arch_task_cache_init(void) { }
-- 
2.39.1

