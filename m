Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC93686635
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBAMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBAMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C72D63
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675255600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZYueli56E8sg+Iz5pPdaaxemhOZQlbX+IPUhwIgWCV8=;
        b=APhDxUrD6Vf9qFDqYDgLp9k/F+XR5aMrjxvHTnxNHID82FB3UQbw9LTjNNPooquIvYAOzB
        uDFJAnQMrKLyB3i7C7fqr9sZX4HKmfkCRK7L7DZxh97vQw45VjHemwHMY72yfRz8IbIf+g
        32uDsPnTperw/RWxdY4a87wSEJpVs+s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-YhFX5pagNa-6xdRDZElm-w-1; Wed, 01 Feb 2023 07:46:37 -0500
X-MC-Unique: YhFX5pagNa-6xdRDZElm-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A4C81C0418C;
        Wed,  1 Feb 2023 12:46:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7334492C3E;
        Wed,  1 Feb 2023 12:46:32 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH v3] kernel/fork: beware of __put_task_struct calling context
Date:   Wed,  1 Feb 2023 09:45:40 -0300
Message-Id: <20230201124541.62104-1-wander@redhat.com>
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

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Hu Chunyu <chuhu@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Cc: Paul McKenney <paulmck@kernel.org>
---
 kernel/fork.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..b2d0d62c9b9d 100644
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
@@ -857,6 +857,26 @@ void __put_task_struct(struct task_struct *tsk)
 	sched_core_free(tsk);
 	free_task(tsk);
 }
+
+static void __delayed_put_task_struct(struct rcu_head *rhp)
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
+		 */
+		call_rcu(&tsk->rcu, __delayed_put_task_struct);
+	else
+		___put_task_struct(tsk);
+}
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
 void __init __weak arch_task_cache_init(void) { }
-- 
2.39.1

