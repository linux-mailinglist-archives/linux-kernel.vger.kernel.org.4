Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317C36FE7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjEJXDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjEJXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143386E87
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683759763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0FIxzJxG5u8dsxaNJf0DBZd0i0u9DMmh8xxDHz0qO54=;
        b=RaQYOzsHpBqyC8GEBrSDgoEPijuepIbjsq9J4jX2PzrHc1IxxsL47KUrLPK+t3+YFffaXk
        wLZ/aK/dvsDEaRjLMFwfXIu0yB44y7zDwrh1ERyzsFSNgLz7XtQblvdqLgNhZVLu3X9auW
        aiYYTkCIfl1m3Yp9HzZLuktm/dFvvZk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-z2yK0aJUOiqOBU-GIedusw-1; Wed, 10 May 2023 19:02:42 -0400
X-MC-Unique: z2yK0aJUOiqOBU-GIedusw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-38c4e0b3466so6834716b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759761; x=1686351761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FIxzJxG5u8dsxaNJf0DBZd0i0u9DMmh8xxDHz0qO54=;
        b=BkQmpqVO3fcgblx1HvtUJC+0S5Lzi5fTUhBHpqvWAhEMDgPTZtZAeVzEd1VzjXV4mS
         33rwGH3gdnn4zz31cOngQMITWnx6LzNYPX8XB/diYBLYOuAoQIqGbyRd3QawpLtv+BYf
         0sObYGzOycaEgDoMTtIOONjBlWzam03dQNsSrjAUvVk5lNMXnbULMGXochJVxc5w56YT
         BGo/zn5KtepS6PMl/ozz7qNBxIepkxJGfOR6nD6tamh9lqeTvB5Aj1drnSLZYOf1O4z2
         EUozBRGj7cgzSAJC5qeiM2yxvJ8kNxAU1Da2H6cias+Q2jwvSOAvycDoaOQ56p4+Hmft
         YbPQ==
X-Gm-Message-State: AC+VfDyXONAIhC4c8zIT8/ePYZlrAjeSg5DigZ0FhC/7oijoI0aUZAV2
        h/8n6gnLUlW/ytge/aMoPF70oqGZTVQ7Vm/mWBOzkynt6ZC0HbdcR/5BtHRuXTPZdCNAzoKigm+
        TWRYbBy4YxyJmURIp7RCg3ff2
X-Received: by 2002:a05:6808:2818:b0:389:4a9e:3341 with SMTP id et24-20020a056808281800b003894a9e3341mr3678998oib.18.1683759761294;
        Wed, 10 May 2023 16:02:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7lVw+z7WpRTJcHq8si/WKSZcECgwG2rNrr+z1sln9YbB+szl/pfHpL7j0SfHjDLS0BJSO9BA==
X-Received: by 2002:a05:6808:2818:b0:389:4a9e:3341 with SMTP id et24-20020a056808281800b003894a9e3341mr3678985oib.18.1683759761009;
        Wed, 10 May 2023 16:02:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:3602:abec:117:3c19:43b8])
        by smtp.gmail.com with ESMTPSA id p5-20020acad805000000b003907dcabf3bsm2806913oig.36.2023.05.10.16.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:02:30 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/1] trace,smp: Add tracepoints around remotelly called functions
Date:   Wed, 10 May 2023 20:01:29 -0300
Message-Id: <20230510230128.150384-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running RT workloads in isolated CPUs, many cases of deadline misses
are caused by remote CPU requests such as smp_call_function*().

For those cases, having the names of those functions running around the
deadline miss moment could help (a lot) finding a target for the next
improvements.

Add tracepoints for acquiring the function name & csd before entry and
after returning from the remote-cpu requested function.

Also, add tracepoints on the remote cpus requesting them.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---

Changes since RFCv2:
- Fixed some spacing issues and trace calls

Changes since RFCv1:
- Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
- Using EVENT_CLASS in order to avoid duplication
- Introduced new helper: csd_do_func()
- Name change from smp_call_function_* to csd_function_*
- Rebased on top of torvalds/master

 include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 41 +++++++++++++---------
 2 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 include/trace/events/smp.h

diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
new file mode 100644
index 000000000000..c304318a0203
--- /dev/null
+++ b/include/trace/events/smp.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM smp
+
+#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SMP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(csd_queue_cpu,
+
+	TP_PROTO(const unsigned int cpu,
+		 unsigned long callsite,
+		 smp_call_func_t func,
+		 call_single_data_t *csd),
+
+	TP_ARGS(cpu, callsite, func, csd),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+		__field(void *, callsite)
+		__field(void *, func)
+		__field(void *, csd)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->callsite = (void *)callsite;
+		__entry->func = func;
+		__entry->csd  = csd;
+	),
+
+	TP_printk("cpu=%u callsite=%pS func=%pS csd=%p",
+		  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
+);
+
+/*
+ * Tracepoints for a function which is called as an effect of smp_call_function.*
+ */
+DECLARE_EVENT_CLASS(csd_function,
+
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
+
+	TP_ARGS(func, csd),
+
+	TP_STRUCT__entry(
+		__field(void *,	func)
+		__field(void *,	csd)
+	),
+
+	TP_fast_assign(
+		__entry->func	= func;
+		__entry->csd	= csd;
+	),
+
+	TP_printk("function %ps, csd = %p", __entry->func, __entry->csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_entry,
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
+	TP_ARGS(func, csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_exit,
+	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
+	TP_ARGS(func, csd)
+);
+
+#endif /* _TRACE_SMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..cada433c5c1f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,6 +27,9 @@
 #include <linux/jump_label.h>
 
 #include <trace/events/ipi.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/smp.h>
+#undef CREATE_TRACE_POINTS
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
 	arch_send_call_function_ipi_mask(mask);
 }
 
+static __always_inline void
+csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
+{
+	trace_csd_function_entry(func, csd);
+	func(info);
+	trace_csd_function_exit(func, csd);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
@@ -329,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
 	 * executes migration_cpu_stop() on the remote CPU).
 	 */
-	if (trace_ipi_send_cpu_enabled()) {
+	if (trace_csd_queue_cpu_enabled()) {
 		call_single_data_t *csd;
 		smp_call_func_t func;
 
@@ -337,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		trace_ipi_send_cpu(cpu, _RET_IP_, func);
+		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
 
 	/*
@@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __call_single_data *csd)
 		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, csd);
 		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
@@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 			}
 
 			csd_lock_record(csd);
-			func(info);
+			csd_do_func(func, info, csd);
 			csd_unlock(csd);
 			csd_lock_record(NULL);
 		} else {
@@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 
 				csd_lock_record(csd);
 				csd_unlock(csd);
-				func(info);
+				csd_do_func(func, info, csd);
 				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
@@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	/*
 	 * Third; only CSD_TYPE_TTWU is left, issue those.
 	 */
-	if (entry)
-		sched_ttwu_pending(entry);
+	if (entry) {
+		csd = llist_entry(entry, typeof(*csd), node.llist);
+		csd_do_func(sched_ttwu_pending, entry, csd);
+	}
 }
 
 
@@ -728,7 +741,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
 	bool wait = scf_flags & SCF_WAIT;
-	int nr_cpus = 0, nr_queued = 0;
+	int nr_cpus = 0;
 	bool run_remote = false;
 	bool run_local = false;
 
@@ -786,21 +799,15 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->node.src = smp_processor_id();
 			csd->node.dst = cpu;
 #endif
+			trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;
 				last_cpu = cpu;
 			}
-			nr_queued++;
 		}
 
-		/*
-		 * Trace each smp_function_call_*() as an IPI, actual IPIs
-		 * will be traced with func==generic_smp_call_function_single_ipi().
-		 */
-		if (nr_queued)
-			trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
-
 		/*
 		 * Choose the most efficient way to send an IPI. Note that the
 		 * number of CPUs might be zero due to concurrent changes to the
@@ -816,7 +823,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
 		local_irq_restore(flags);
 	}
 
-- 
2.40.1

