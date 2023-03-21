Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2266C2698
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCUAzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCUAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:55:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A483433C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EB2EB811BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC652C433D2;
        Tue, 21 Mar 2023 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360118;
        bh=HUcNT18c9tWGTRdAcwqvm7cb76dFUjKVHSKOqLcCWec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnFw2OppJwko8BYMEZK3PKdPrvCOnvvKLYpEH3UefcdI9eecHelx5CbEJJwgaAFID
         cwwoJbG3Sk/ULp/cxeWAelh3vDwQrAI6j3JklMq1LP+IMs+HG0jp/swLUz0gxaDA0G
         6wk2A8XnHjsDSejq4DcE7Z1oxFCz+P8wdl2kMYbVfhokZpg24jY7fnP6AIv7DbwWKM
         RRU64iVMHU3qTlONXfRoKBBsiYxo3M5zfmTUWstegNG8tKl3S9+gxgTHrSpaqsXKsZ
         ZdlWkA9zkrlyNF+dKpfegUgIcrZuKDqzceJ+8aBf+oOZ4Hp1jj9DE6F+Vcl9MKXIwg
         bAza64I/TyrhQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6595B154039B; Mon, 20 Mar 2023 17:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, rostedt@goodmis.org, jgross@suse.com,
        mingo@kernel.org, peterz@infradead.org, corbet@lwn.net,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH CSDlock 2/4] locking/csd_lock: Remove added data from CSD lock debugging
Date:   Mon, 20 Mar 2023 17:55:14 -0700
Message-Id: <20230321005516.50558-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diagnostics added by this commit were extremely useful in one instance:

a5aabace5fb8 ("locking/csd_lock: Add more data to CSD lock debugging")

However, they have not seen much action since, and there have been some
concerns expressed that the complexity is not worth the benefit.

Therefore, manually revert this commit, but leave a comment telling
people where to find these diagnostics.

[ paulmck: Apply Juergen Gross feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 .../admin-guide/kernel-parameters.txt         |   4 -
 kernel/smp.c                                  | 233 +-----------------
 2 files changed, 12 insertions(+), 225 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ce70777f5999..b15198a85acb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -896,10 +896,6 @@
 			to resolve the hang situation.  The default value of
 			this option depends on the CSD_LOCK_WAIT_DEBUG_DEFAULT
 			Kconfig option.
-			0: disable csdlock debugging
-			1: enable basic csdlock debugging (minor impact)
-			ext: enable extended csdlock debugging (more impact,
-			     but more data)
 
 	dasd=		[HW,NET]
 			See header of drivers/s390/block/dasd_devmap.c.
diff --git a/kernel/smp.c b/kernel/smp.c
index e2d558f5cef8..038d666f327b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,59 +31,8 @@
 
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
-#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-union cfd_seq_cnt {
-	u64		val;
-	struct {
-		u64	src:16;
-		u64	dst:16;
-#define CFD_SEQ_NOCPU	0xffff
-		u64	type:4;
-#define CFD_SEQ_QUEUE	0
-#define CFD_SEQ_IPI	1
-#define CFD_SEQ_NOIPI	2
-#define CFD_SEQ_PING	3
-#define CFD_SEQ_PINGED	4
-#define CFD_SEQ_HANDLE	5
-#define CFD_SEQ_DEQUEUE	6
-#define CFD_SEQ_IDLE	7
-#define CFD_SEQ_GOTIPI	8
-#define CFD_SEQ_HDLEND	9
-		u64	cnt:28;
-	}		u;
-};
-
-static char *seq_type[] = {
-	[CFD_SEQ_QUEUE]		= "queue",
-	[CFD_SEQ_IPI]		= "ipi",
-	[CFD_SEQ_NOIPI]		= "noipi",
-	[CFD_SEQ_PING]		= "ping",
-	[CFD_SEQ_PINGED]	= "pinged",
-	[CFD_SEQ_HANDLE]	= "handle",
-	[CFD_SEQ_DEQUEUE]	= "dequeue (src CPU 0 == empty)",
-	[CFD_SEQ_IDLE]		= "idle",
-	[CFD_SEQ_GOTIPI]	= "gotipi",
-	[CFD_SEQ_HDLEND]	= "hdlend (src CPU 0 == early)",
-};
-
-struct cfd_seq_local {
-	u64	ping;
-	u64	pinged;
-	u64	handle;
-	u64	dequeue;
-	u64	idle;
-	u64	gotipi;
-	u64	hdlend;
-};
-#endif
-
 struct cfd_percpu {
 	call_single_data_t	csd;
-#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-	u64	seq_queue;
-	u64	seq_ipi;
-	u64	seq_noipi;
-#endif
 };
 
 struct call_function_data {
@@ -159,18 +108,21 @@ void __init call_function_init(void)
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
-static DEFINE_STATIC_KEY_FALSE(csdlock_debug_extended);
 
+/*
+ * Parse the csdlock_debug= kernel boot parameter.
+ *
+ * If you need to restore the old "ext" value that once provided
+ * additional debugging information, reapply the following commits:
+ *
+ * de7b09ef658d ("locking/csd_lock: Prepare more CSD lock debugging")
+ * a5aabace5fb8 ("locking/csd_lock: Add more data to CSD lock debugging")
+ */
 static int __init csdlock_debug(char *str)
 {
 	unsigned int val = 0;
 
-	if (str && !strcmp(str, "ext")) {
-		val = 1;
-		static_branch_enable(&csdlock_debug_extended);
-	} else
-		get_option(&str, &val);
-
+	get_option(&str, &val);
 	if (val)
 		static_branch_enable(&csdlock_debug_enabled);
 
@@ -181,36 +133,11 @@ __setup("csdlock_debug=", csdlock_debug);
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
-static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
 
 static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
 module_param(csd_lock_timeout, ulong, 0444);
 
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
-static u64 cfd_seq;
-
-#define CFD_SEQ(s, d, t, c)	\
-	(union cfd_seq_cnt){ .u.src = s, .u.dst = d, .u.type = t, .u.cnt = c }
-
-static u64 cfd_seq_inc(unsigned int src, unsigned int dst, unsigned int type)
-{
-	union cfd_seq_cnt new, old;
-
-	new = CFD_SEQ(src, dst, type, 0);
-
-	do {
-		old.val = READ_ONCE(cfd_seq);
-		new.u.cnt = old.u.cnt + 1;
-	} while (cmpxchg(&cfd_seq, old.val, new.val) != old.val);
-
-	return old.val;
-}
-
-#define cfd_seq_store(var, src, dst, type)				\
-	do {								\
-		if (static_branch_unlikely(&csdlock_debug_extended))	\
-			var = cfd_seq_inc(src, dst, type);		\
-	} while (0)
 
 /* Record current CSD work for current CPU, NULL to erase. */
 static void __csd_lock_record(struct __call_single_data *csd)
@@ -244,80 +171,6 @@ static int csd_lock_wait_getcpu(struct __call_single_data *csd)
 	return -1;
 }
 
-static void cfd_seq_data_add(u64 val, unsigned int src, unsigned int dst,
-			     unsigned int type, union cfd_seq_cnt *data,
-			     unsigned int *n_data, unsigned int now)
-{
-	union cfd_seq_cnt new[2];
-	unsigned int i, j, k;
-
-	new[0].val = val;
-	new[1] = CFD_SEQ(src, dst, type, new[0].u.cnt + 1);
-
-	for (i = 0; i < 2; i++) {
-		if (new[i].u.cnt <= now)
-			new[i].u.cnt |= 0x80000000U;
-		for (j = 0; j < *n_data; j++) {
-			if (new[i].u.cnt == data[j].u.cnt) {
-				/* Direct read value trumps generated one. */
-				if (i == 0)
-					data[j].val = new[i].val;
-				break;
-			}
-			if (new[i].u.cnt < data[j].u.cnt) {
-				for (k = *n_data; k > j; k--)
-					data[k].val = data[k - 1].val;
-				data[j].val = new[i].val;
-				(*n_data)++;
-				break;
-			}
-		}
-		if (j == *n_data) {
-			data[j].val = new[i].val;
-			(*n_data)++;
-		}
-	}
-}
-
-static const char *csd_lock_get_type(unsigned int type)
-{
-	return (type >= ARRAY_SIZE(seq_type)) ? "?" : seq_type[type];
-}
-
-static void csd_lock_print_extended(struct __call_single_data *csd, int cpu)
-{
-	struct cfd_seq_local *seq = &per_cpu(cfd_seq_local, cpu);
-	unsigned int srccpu = csd->node.src;
-	struct call_function_data *cfd = per_cpu_ptr(&cfd_data, srccpu);
-	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
-	unsigned int now;
-	union cfd_seq_cnt data[2 * ARRAY_SIZE(seq_type)];
-	unsigned int n_data = 0, i;
-
-	data[0].val = READ_ONCE(cfd_seq);
-	now = data[0].u.cnt;
-
-	cfd_seq_data_add(pcpu->seq_queue,			srccpu, cpu,	       CFD_SEQ_QUEUE,  data, &n_data, now);
-	cfd_seq_data_add(pcpu->seq_ipi,				srccpu, cpu,	       CFD_SEQ_IPI,    data, &n_data, now);
-	cfd_seq_data_add(pcpu->seq_noipi,			srccpu, cpu,	       CFD_SEQ_NOIPI,  data, &n_data, now);
-
-	cfd_seq_data_add(per_cpu(cfd_seq_local.ping, srccpu),	srccpu, CFD_SEQ_NOCPU, CFD_SEQ_PING,   data, &n_data, now);
-	cfd_seq_data_add(per_cpu(cfd_seq_local.pinged, srccpu), srccpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED, data, &n_data, now);
-
-	cfd_seq_data_add(seq->idle,    CFD_SEQ_NOCPU, cpu, CFD_SEQ_IDLE,    data, &n_data, now);
-	cfd_seq_data_add(seq->gotipi,  CFD_SEQ_NOCPU, cpu, CFD_SEQ_GOTIPI,  data, &n_data, now);
-	cfd_seq_data_add(seq->handle,  CFD_SEQ_NOCPU, cpu, CFD_SEQ_HANDLE,  data, &n_data, now);
-	cfd_seq_data_add(seq->dequeue, CFD_SEQ_NOCPU, cpu, CFD_SEQ_DEQUEUE, data, &n_data, now);
-	cfd_seq_data_add(seq->hdlend,  CFD_SEQ_NOCPU, cpu, CFD_SEQ_HDLEND,  data, &n_data, now);
-
-	for (i = 0; i < n_data; i++) {
-		pr_alert("\tcsd: cnt(%07x): %04x->%04x %s\n",
-			 data[i].u.cnt & ~0x80000000U, data[i].u.src,
-			 data[i].u.dst, csd_lock_get_type(data[i].u.type));
-	}
-	pr_alert("\tcsd: cnt now: %07x\n", now);
-}
-
 /*
  * Complain if too much time spent waiting.  Note that only
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
@@ -368,8 +221,6 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
 	}
 	if (cpu >= 0) {
-		if (static_branch_unlikely(&csdlock_debug_extended))
-			csd_lock_print_extended(csd, cpu);
 		dump_cpu_task(cpu);
 		if (!cpu_cur_csd) {
 			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
@@ -412,27 +263,7 @@ static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
-
-static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
-{
-	unsigned int this_cpu = smp_processor_id();
-	struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
-	struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
-	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
-
-	cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
-	if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
-		cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
-		cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
-		send_call_function_single_ipi(cpu);
-		cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
-	} else {
-		cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
-	}
-}
 #else
-#define cfd_seq_store(var, src, dst, type)
-
 static void csd_lock_record(struct __call_single_data *csd)
 {
 }
@@ -470,19 +301,6 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
-#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-	if (static_branch_unlikely(&csdlock_debug_extended)) {
-		unsigned int type;
-
-		type = CSD_TYPE(container_of(node, call_single_data_t,
-					     node.llist));
-		if (type == CSD_TYPE_SYNC || type == CSD_TYPE_ASYNC) {
-			__smp_call_single_queue_debug(cpu, node);
-			return;
-		}
-	}
-#endif
-
 	/*
 	 * The list addition should be visible before sending the IPI
 	 * handler locks the list to pull the entry off it because of
@@ -541,8 +359,6 @@ static int generic_exec_single(int cpu, struct __call_single_data *csd)
  */
 void generic_smp_call_function_single_interrupt(void)
 {
-	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->gotipi, CFD_SEQ_NOCPU,
-		      smp_processor_id(), CFD_SEQ_GOTIPI);
 	__flush_smp_call_function_queue(true);
 }
 
@@ -570,13 +386,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	lockdep_assert_irqs_disabled();
 
 	head = this_cpu_ptr(&call_single_queue);
-	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->handle, CFD_SEQ_NOCPU,
-		      smp_processor_id(), CFD_SEQ_HANDLE);
 	entry = llist_del_all(head);
-	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->dequeue,
-		      /* Special meaning of source cpu: 0 == queue empty */
-		      entry ? CFD_SEQ_NOCPU : 0,
-		      smp_processor_id(), CFD_SEQ_DEQUEUE);
 	entry = llist_reverse_order(entry);
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
@@ -635,12 +445,8 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 		}
 	}
 
-	if (!entry) {
-		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->hdlend,
-			      0, smp_processor_id(),
-			      CFD_SEQ_HDLEND);
+	if (!entry)
 		return;
-	}
 
 	/*
 	 * Second; run all !SYNC callbacks.
@@ -678,9 +484,6 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	 */
 	if (entry)
 		sched_ttwu_pending(entry);
-
-	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->hdlend, CFD_SEQ_NOCPU,
-		      smp_processor_id(), CFD_SEQ_HDLEND);
 }
 
 
@@ -704,8 +507,6 @@ void flush_smp_call_function_queue(void)
 	if (llist_empty(this_cpu_ptr(&call_single_queue)))
 		return;
 
-	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
-		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
 	/* Get the already pending soft interrupts for RT enabled kernels */
 	was_pending = local_softirq_pending();
@@ -929,8 +730,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 		cpumask_clear(cfd->cpumask_ipi);
 		for_each_cpu(cpu, cfd->cpumask) {
-			struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
-			call_single_data_t *csd = &pcpu->csd;
+			call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
 
 			if (cond_func && !cond_func(cpu, info))
 				continue;
@@ -944,20 +744,13 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->node.src = smp_processor_id();
 			csd->node.dst = cpu;
 #endif
-			cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;
 				last_cpu = cpu;
-
-				cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
-			} else {
-				cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
 			}
 		}
 
-		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->ping, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PING);
-
 		/*
 		 * Choose the most efficient way to send an IPI. Note that the
 		 * number of CPUs might be zero due to concurrent changes to the
@@ -967,8 +760,6 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
 			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
-
-		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
 
 	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
-- 
2.40.0.rc2

