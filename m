Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79357353F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjFSKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjFSKtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:49:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23FB198B;
        Mon, 19 Jun 2023 03:49:26 -0700 (PDT)
Date:   Mon, 19 Jun 2023 10:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687171765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wImM+p33UZ20jm9bf7CgfuXOmXaME53jmn4uQACAOXc=;
        b=tlLpx0nhI+ax4T5nIZvbEEPlpLEpCTei40PPJx94XEtVtGcuZMDvLdlkE4S/E284svq0ha
        oYJlW82oHFpxZMFasI3LXhd4LFCvHKIik8flnYyb9shYxnHoxqNLThGP7WACUEUQjnWg3h
        PMCA+iPSMuKAbAARf5Eu0v/UJdsJcRm7c7eNDPKpuX5CXJ35MVQWrPV7O+D7Y2nvLXJX8x
        /y18Gq3S2LWyTRfmYSK1pw8pxi/VF+VQAaC0SNo5m0vCTuzH+Ph30lCMj33+69e0AQJofD
        Th2CaJZWwAZyUHVV1cjEVTFbe5pMxu36/WfyzpgnSMRICwvXR6GpsRrAbk9iKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687171765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wImM+p33UZ20jm9bf7CgfuXOmXaME53jmn4uQACAOXc=;
        b=i6n6D/8rja9F5ZrA8h2BXghOv9vNjG0zt1UtgE7yr6D0AML3jOFy1y6Y2RNKDFoSHMVK4X
        FpAHrwn9mdiSIoAg==
From:   "tip-bot2 for Leonardo Bras" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] trace,smp: Add tracepoints around remotelly called functions
Cc:     Leonardo Bras <leobras@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615065944.188876-5-leobras@redhat.com>
References: <20230615065944.188876-5-leobras@redhat.com>
MIME-Version: 1.0
Message-ID: <168717176494.404.16420010294801824681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     949fa3f11ced2a5c8e3737e73b09676adf4b322b
Gitweb:        https://git.kernel.org/tip/949fa3f11ced2a5c8e3737e73b09676adf4b322b
Author:        Leonardo Bras <leobras@redhat.com>
AuthorDate:    Thu, 15 Jun 2023 03:59:45 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:09 +02:00

trace,smp: Add tracepoints around remotelly called functions

The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sources
of IPIs targeting CPUs running latency-sensitive applications.

For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
sufficient to find them and work on getting rid of them. In some setups
however, not *all* IPIs are to be suppressed, but long-running IPI
callbacks can still be problematic.

Add a pair of tracepoints to mark the start and end of processing a CSD IPI
callback, similar to what exists for softirq, workqueue or timer callbacks.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230615065944.188876-5-leobras@redhat.com
---
 include/trace/events/csd.h | 45 +++++++++++++++++++++++++++++++++++++-
 kernel/smp.c               | 25 +++++++++++++++------
 2 files changed, 64 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/csd.h

diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
new file mode 100644
index 0000000..af1df52
--- /dev/null
+++ b/include/trace/events/csd.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM csd
+
+#if !defined(_TRACE_CSD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CSD_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Tracepoints for a function which is called as an effect of smp_call_function.*
+ */
+DECLARE_EVENT_CLASS(csd_function,
+
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
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
+	TP_printk("func=%ps, csd=%p", __entry->func, __entry->csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_entry,
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_ARGS(func, csd)
+);
+
+DEFINE_EVENT(csd_function, csd_function_exit,
+	TP_PROTO(smp_call_func_t func, struct __call_single_data *csd),
+	TP_ARGS(func, csd)
+);
+
+#endif /* _TRACE_CSD_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/smp.c b/kernel/smp.c
index 71dce74..1fa01a8 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,6 +27,9 @@
 #include <linux/jump_label.h>
 
 #include <trace/events/ipi.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/csd.h>
+#undef CREATE_TRACE_POINTS
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
 	arch_send_call_function_ipi_mask(mask);
 }
 
+static __always_inline void
+csd_do_func(smp_call_func_t func, void *info, struct __call_single_data *csd)
+{
+	trace_csd_function_entry(func, csd);
+	func(info);
+	trace_csd_function_exit(func, csd);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug_enabled);
@@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __call_single_data *csd)
 		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
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
 
 
@@ -816,7 +829,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		func(info);
+		csd_do_func(func, info, NULL);
 		local_irq_restore(flags);
 	}
 
