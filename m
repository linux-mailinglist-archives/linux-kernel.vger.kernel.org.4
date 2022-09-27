Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6B5EC8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiI0QCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiI0QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBD3B71B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1120BB81C5C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCFEC433D6;
        Tue, 27 Sep 2022 16:01:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2o-00G2wK-12;
        Tue, 27 Sep 2022 12:02:50 -0400
Message-ID: <20220927160249.931823392@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, stable@vger.kerne.org,
        Waiman Long <longman@redhat.com>
Subject: [for-next][PATCH 16/20] tracing: Disable interrupt or preemption before acquiring
 arch_spinlock_t
References: <20220927160216.349640304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

It was found that some tracing functions in kernel/trace/trace.c acquire
an arch_spinlock_t with preemption and irqs enabled. An example is the
tracing_saved_cmdlines_size_read() function which intermittently causes
a "BUG: using smp_processor_id() in preemptible" warning when the LTP
read_all_proc test is run.

That can be problematic in case preemption happens after acquiring the
lock. Add the necessary preemption or interrupt disabling code in the
appropriate places before acquiring an arch_spinlock_t.

The convention here is to disable preemption for trace_cmdline_lock and
interupt for max_lock.

Link: https://lkml.kernel.org/r/20220922145622.1744826-1-longman@redhat.com

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: stable@vger.kerne.org
Fixes: a35873a0993b ("tracing: Add conditional snapshot")
Fixes: 939c7a4f04fc ("tracing: Introduce saved_cmdlines_size file")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..aed7ea6e6045 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1193,12 +1193,14 @@ void *tracing_cond_snapshot_data(struct trace_array *tr)
 {
 	void *cond_data = NULL;
 
+	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
 
 	if (tr->cond_snapshot)
 		cond_data = tr->cond_snapshot->cond_data;
 
 	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
 
 	return cond_data;
 }
@@ -1334,9 +1336,11 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 		goto fail_unlock;
 	}
 
+	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
 	tr->cond_snapshot = cond_snapshot;
 	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
 
 	mutex_unlock(&trace_types_lock);
 
@@ -1363,6 +1367,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 {
 	int ret = 0;
 
+	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
 
 	if (!tr->cond_snapshot)
@@ -1373,6 +1378,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 	}
 
 	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
 
 	return ret;
 }
@@ -2200,6 +2206,11 @@ static size_t tgid_map_max;
 
 #define SAVED_CMDLINES_DEFAULT 128
 #define NO_CMDLINE_MAP UINT_MAX
+/*
+ * Preemption must be disabled before acquiring trace_cmdline_lock.
+ * The various trace_arrays' max_lock must be acquired in a context
+ * where interrupt is disabled.
+ */
 static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 struct saved_cmdlines_buffer {
 	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
@@ -2412,7 +2423,11 @@ static int trace_save_cmdline(struct task_struct *tsk)
 	 * the lock, but we also don't want to spin
 	 * nor do we want to disable interrupts,
 	 * so if we miss here, then better luck next time.
+	 *
+	 * This is called within the scheduler and wake up, so interrupts
+	 * had better been disabled and run queue lock been held.
 	 */
+	lockdep_assert_preemption_disabled();
 	if (!arch_spin_trylock(&trace_cmdline_lock))
 		return 0;
 
@@ -5890,9 +5905,11 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	char buf[64];
 	int r;
 
+	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 	r = scnprintf(buf, sizeof(buf), "%u\n", savedcmd->cmdline_num);
 	arch_spin_unlock(&trace_cmdline_lock);
+	preempt_enable();
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
@@ -5917,10 +5934,12 @@ static int tracing_resize_saved_cmdlines(unsigned int val)
 		return -ENOMEM;
 	}
 
+	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 	savedcmd_temp = savedcmd;
 	savedcmd = s;
 	arch_spin_unlock(&trace_cmdline_lock);
+	preempt_enable();
 	free_saved_cmdlines_buffer(savedcmd_temp);
 
 	return 0;
@@ -6373,10 +6392,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 	if (t->use_max_tr) {
+		local_irq_disable();
 		arch_spin_lock(&tr->max_lock);
 		if (tr->cond_snapshot)
 			ret = -EBUSY;
 		arch_spin_unlock(&tr->max_lock);
+		local_irq_enable();
 		if (ret)
 			goto out;
 	}
@@ -7436,10 +7457,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		goto out;
 	}
 
+	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
 	if (tr->cond_snapshot)
 		ret = -EBUSY;
 	arch_spin_unlock(&tr->max_lock);
+	local_irq_enable();
 	if (ret)
 		goto out;
 
-- 
2.35.1
