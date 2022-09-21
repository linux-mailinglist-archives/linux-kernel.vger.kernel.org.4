Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F55BFEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIUNXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIUNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17293535
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663766600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8doRy3Tl9duFaqpT4x4KIGruvUlzYzIUxZbJ5Ad4nHc=;
        b=QoKTnbCfkdPaqn63B67ugMXS8goJAhCLvvjVXKDP8fKM/wpTnU+Rje1tskAPPoMAAYiDPM
        a3AzOQKzfqct3+K+F4Q0gxz+IhaA+Ib/VjU8a2mm6y/YWL62oySPaBplD7q18NPb0wg94U
        /DIYfKhzdq9KqBAnvRqrDeSkYR0YwjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-nOCfVYZRN2SReAZKKgUxyQ-1; Wed, 21 Sep 2022 09:23:16 -0400
X-MC-Unique: nOCfVYZRN2SReAZKKgUxyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D265487B2A4;
        Wed, 21 Sep 2022 13:23:15 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AD3839D7C;
        Wed, 21 Sep 2022 13:23:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] tracing: Use proper do_arch_spin_lock() API
Date:   Wed, 21 Sep 2022 09:21:52 -0400
Message-Id: <20220921132152.1622616-3-longman@redhat.com>
In-Reply-To: <20220921132152.1622616-1-longman@redhat.com>
References: <20220921132152.1622616-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that some tracing functions acquire a arch_spinlock_t with
preemption and irqs enabled.  That can be problematic in case preemption
happens after acquiring the lock. Use the proper do_arch_spin_lock()
API with preemption disabled to make sure that this won't happen unless
it is obvious that either preemption or irqs has been disabled .

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/trace/trace.c | 52 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..cbb8520842ad 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1193,12 +1193,12 @@ void *tracing_cond_snapshot_data(struct trace_array *tr)
 {
 	void *cond_data = NULL;
 
-	arch_spin_lock(&tr->max_lock);
+	do_arch_spin_lock(&tr->max_lock);
 
 	if (tr->cond_snapshot)
 		cond_data = tr->cond_snapshot->cond_data;
 
-	arch_spin_unlock(&tr->max_lock);
+	do_arch_spin_unlock(&tr->max_lock);
 
 	return cond_data;
 }
@@ -1334,9 +1334,9 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 		goto fail_unlock;
 	}
 
-	arch_spin_lock(&tr->max_lock);
+	do_arch_spin_lock(&tr->max_lock);
 	tr->cond_snapshot = cond_snapshot;
-	arch_spin_unlock(&tr->max_lock);
+	do_arch_spin_unlock(&tr->max_lock);
 
 	mutex_unlock(&trace_types_lock);
 
@@ -1363,7 +1363,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 {
 	int ret = 0;
 
-	arch_spin_lock(&tr->max_lock);
+	do_arch_spin_lock(&tr->max_lock);
 
 	if (!tr->cond_snapshot)
 		ret = -EINVAL;
@@ -1372,7 +1372,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 		tr->cond_snapshot = NULL;
 	}
 
-	arch_spin_unlock(&tr->max_lock);
+	do_arch_spin_unlock(&tr->max_lock);
 
 	return ret;
 }
@@ -1819,7 +1819,7 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 		return;
 	}
 
-	arch_spin_lock(&tr->max_lock);
+	do_arch_spin_lock(&tr->max_lock);
 
 	/* Inherit the recordable setting from array_buffer */
 	if (ring_buffer_record_is_set_on(tr->array_buffer.buffer))
@@ -1836,7 +1836,7 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	__update_max_tr(tr, tsk, cpu);
 
  out_unlock:
-	arch_spin_unlock(&tr->max_lock);
+	do_arch_spin_unlock(&tr->max_lock);
 }
 
 /**
@@ -1862,7 +1862,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 		return;
 	}
 
-	arch_spin_lock(&tr->max_lock);
+	do_arch_spin_lock(&tr->max_lock);
 
 	ret = ring_buffer_swap_cpu(tr->max_buffer.buffer, tr->array_buffer.buffer, cpu);
 
@@ -1880,7 +1880,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);
 
 	__update_max_tr(tr, tsk, cpu);
-	arch_spin_unlock(&tr->max_lock);
+	do_arch_spin_unlock(&tr->max_lock);
 }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
@@ -2413,7 +2413,7 @@ static int trace_save_cmdline(struct task_struct *tsk)
 	 * nor do we want to disable interrupts,
 	 * so if we miss here, then better luck next time.
 	 */
-	if (!arch_spin_trylock(&trace_cmdline_lock))
+	if (!do_arch_spin_trylock(&trace_cmdline_lock))
 		return 0;
 
 	idx = savedcmd->map_pid_to_cmdline[tpid];
@@ -2427,7 +2427,7 @@ static int trace_save_cmdline(struct task_struct *tsk)
 	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
 	set_cmdline(idx, tsk->comm);
 
-	arch_spin_unlock(&trace_cmdline_lock);
+	do_arch_spin_unlock(&trace_cmdline_lock);
 
 	return 1;
 }
@@ -2461,13 +2461,11 @@ static void __trace_find_cmdline(int pid, char comm[])
 
 void trace_find_cmdline(int pid, char comm[])
 {
-	preempt_disable();
-	arch_spin_lock(&trace_cmdline_lock);
+	do_arch_spin_lock(&trace_cmdline_lock);
 
 	__trace_find_cmdline(pid, comm);
 
-	arch_spin_unlock(&trace_cmdline_lock);
-	preempt_enable();
+	do_arch_spin_unlock(&trace_cmdline_lock);
 }
 
 static int *trace_find_tgid_ptr(int pid)
@@ -5829,8 +5827,7 @@ static void *saved_cmdlines_start(struct seq_file *m, loff_t *pos)
 	void *v;
 	loff_t l = 0;
 
-	preempt_disable();
-	arch_spin_lock(&trace_cmdline_lock);
+	do_arch_spin_lock(&trace_cmdline_lock);
 
 	v = &savedcmd->map_cmdline_to_pid[0];
 	while (l <= *pos) {
@@ -5844,8 +5841,7 @@ static void *saved_cmdlines_start(struct seq_file *m, loff_t *pos)
 
 static void saved_cmdlines_stop(struct seq_file *m, void *v)
 {
-	arch_spin_unlock(&trace_cmdline_lock);
-	preempt_enable();
+	do_arch_spin_unlock(&trace_cmdline_lock);
 }
 
 static int saved_cmdlines_show(struct seq_file *m, void *v)
@@ -5890,9 +5886,9 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	char buf[64];
 	int r;
 
-	arch_spin_lock(&trace_cmdline_lock);
+	do_arch_spin_lock(&trace_cmdline_lock);
 	r = scnprintf(buf, sizeof(buf), "%u\n", savedcmd->cmdline_num);
-	arch_spin_unlock(&trace_cmdline_lock);
+	do_arch_spin_unlock(&trace_cmdline_lock);
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
@@ -5917,10 +5913,10 @@ static int tracing_resize_saved_cmdlines(unsigned int val)
 		return -ENOMEM;
 	}
 
-	arch_spin_lock(&trace_cmdline_lock);
+	do_arch_spin_lock(&trace_cmdline_lock);
 	savedcmd_temp = savedcmd;
 	savedcmd = s;
-	arch_spin_unlock(&trace_cmdline_lock);
+	do_arch_spin_unlock(&trace_cmdline_lock);
 	free_saved_cmdlines_buffer(savedcmd_temp);
 
 	return 0;
@@ -6373,10 +6369,10 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 	if (t->use_max_tr) {
-		arch_spin_lock(&tr->max_lock);
+		do_arch_spin_lock(&tr->max_lock);
 		if (tr->cond_snapshot)
 			ret = -EBUSY;
-		arch_spin_unlock(&tr->max_lock);
+		do_arch_spin_unlock(&tr->max_lock);
 		if (ret)
 			goto out;
 	}
@@ -7436,10 +7432,10 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		goto out;
 	}
 
-	arch_spin_lock(&tr->max_lock);
+	do_arch_spin_lock(&tr->max_lock);
 	if (tr->cond_snapshot)
 		ret = -EBUSY;
-	arch_spin_unlock(&tr->max_lock);
+	do_arch_spin_unlock(&tr->max_lock);
 	if (ret)
 		goto out;
 
-- 
2.31.1

