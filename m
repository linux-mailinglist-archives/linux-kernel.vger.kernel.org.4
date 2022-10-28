Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6249E610A77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJ1Gm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJ1Gl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:41:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333D54C9C;
        Thu, 27 Oct 2022 23:41:54 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b2E5M+sgM0Kbu4YgEFm8ONBFN7/B3Kqd34YndSvKUIg=;
        b=kK7Ia7ntz8ZgxPOf0i+Ixd6Ezik7S02LHSxvCd7FMT0Od0jYxxQC1OOnu57fhwOeSDNF3H
        6JZyIF5tezjeR2mHNGnCrd1/ylmAZir5UNBmYuebLm1PMR/vqn9ewOQ37f+IJTjY7RIXmZ
        /pzJs5TGEtZjrpBsWm4VJ02AO6jy+TVjoWpJKi7LOklHpeV1+C/RZiclBgS+PlXw86or0p
        44gzeNA2bsA4O9/qCOOWM1HC/H7BQ6wOX7RUyfnMz6MjJqj6atRSXoimWOKcIcU4elwJiK
        4fvOpq/IfylbkoR7ucZlL3MzDRlFk1szTBYQa+t4cU2EiV231jWA/UKK/mNJVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b2E5M+sgM0Kbu4YgEFm8ONBFN7/B3Kqd34YndSvKUIg=;
        b=xdg3WG+loDl9lp83xYcq9XE2qiZ3SctVb6IBkqixRqygnDTrE2IWgsE9FyeW9UlwgKzTCc
        8PKUyJNPGIwZmCDw==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Optimize perf_tp_event()
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166693931196.29415.10760252115710736746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     571f97f7d51fa81e6cc0e00f0f6314792ce533a3
Gitweb:        https://git.kernel.org/tip/571f97f7d51fa81e6cc0e00f0f6314792ce533a3
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 10 Oct 2022 12:17:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 20:12:17 +02:00

perf: Optimize perf_tp_event()

Use the event group trees to iterate only perf_tracepoint events.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 134 ++++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 55 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 640f0a5..ec2abc5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9944,6 +9944,44 @@ static struct pmu perf_swevent = {
 
 #ifdef CONFIG_EVENT_TRACING
 
+static void tp_perf_event_destroy(struct perf_event *event)
+{
+	perf_trace_destroy(event);
+}
+
+static int perf_tp_event_init(struct perf_event *event)
+{
+	int err;
+
+	if (event->attr.type != PERF_TYPE_TRACEPOINT)
+		return -ENOENT;
+
+	/*
+	 * no branch sampling for tracepoint events
+	 */
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
+	err = perf_trace_init(event);
+	if (err)
+		return err;
+
+	event->destroy = tp_perf_event_destroy;
+
+	return 0;
+}
+
+static struct pmu perf_tracepoint = {
+	.task_ctx_nr	= perf_sw_context,
+
+	.event_init	= perf_tp_event_init,
+	.add		= perf_trace_add,
+	.del		= perf_trace_del,
+	.start		= perf_swevent_start,
+	.stop		= perf_swevent_stop,
+	.read		= perf_swevent_read,
+};
+
 static int perf_tp_filter_match(struct perf_event *event,
 				struct perf_sample_data *data)
 {
@@ -9993,6 +10031,44 @@ void perf_trace_run_bpf_submit(void *raw_data, int size, int rctx,
 }
 EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
 
+static void __perf_tp_event_target_task(u64 count, void *record,
+					struct pt_regs *regs,
+					struct perf_sample_data *data,
+					struct perf_event *event)
+{
+	struct trace_entry *entry = record;
+
+	if (event->attr.config != entry->type)
+		return;
+	/* Cannot deliver synchronous signal to other task. */
+	if (event->attr.sigtrap)
+		return;
+	if (perf_tp_event_match(event, data, regs))
+		perf_swevent_event(event, count, data, regs);
+}
+
+static void perf_tp_event_target_task(u64 count, void *record,
+				      struct pt_regs *regs,
+				      struct perf_sample_data *data,
+				      struct perf_event_context *ctx)
+{
+	unsigned int cpu = smp_processor_id();
+	struct pmu *pmu = &perf_tracepoint;
+	struct perf_event *event, *sibling;
+
+	perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, pmu) {
+		__perf_tp_event_target_task(count, record, regs, data, event);
+		for_each_sibling_event(sibling, event)
+			__perf_tp_event_target_task(count, record, regs, data, sibling);
+	}
+
+	perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu, pmu) {
+		__perf_tp_event_target_task(count, record, regs, data, event);
+		for_each_sibling_event(sibling, event)
+			__perf_tp_event_target_task(count, record, regs, data, sibling);
+	}
+}
+
 void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		   struct pt_regs *regs, struct hlist_head *head, int rctx,
 		   struct task_struct *task)
@@ -10023,29 +10099,15 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	 */
 	if (task && task != current) {
 		struct perf_event_context *ctx;
-		struct trace_entry *entry = record;
 
 		rcu_read_lock();
 		ctx = rcu_dereference(task->perf_event_ctxp);
 		if (!ctx)
 			goto unlock;
 
-		// XXX iterate groups instead, we should be able to
-		// find the subtree for the perf_tracepoint pmu and CPU.
-
-		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
-			if (event->cpu != smp_processor_id())
-				continue;
-			if (event->attr.type != PERF_TYPE_TRACEPOINT)
-				continue;
-			if (event->attr.config != entry->type)
-				continue;
-			/* Cannot deliver synchronous signal to other task. */
-			if (event->attr.sigtrap)
-				continue;
-			if (perf_tp_event_match(event, &data, regs))
-				perf_swevent_event(event, count, &data, regs);
-		}
+		raw_spin_lock(&ctx->lock);
+		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
 	}
@@ -10054,44 +10116,6 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 
-static void tp_perf_event_destroy(struct perf_event *event)
-{
-	perf_trace_destroy(event);
-}
-
-static int perf_tp_event_init(struct perf_event *event)
-{
-	int err;
-
-	if (event->attr.type != PERF_TYPE_TRACEPOINT)
-		return -ENOENT;
-
-	/*
-	 * no branch sampling for tracepoint events
-	 */
-	if (has_branch_stack(event))
-		return -EOPNOTSUPP;
-
-	err = perf_trace_init(event);
-	if (err)
-		return err;
-
-	event->destroy = tp_perf_event_destroy;
-
-	return 0;
-}
-
-static struct pmu perf_tracepoint = {
-	.task_ctx_nr	= perf_sw_context,
-
-	.event_init	= perf_tp_event_init,
-	.add		= perf_trace_add,
-	.del		= perf_trace_del,
-	.start		= perf_swevent_start,
-	.stop		= perf_swevent_stop,
-	.read		= perf_swevent_read,
-};
-
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
 /*
  * Flags in config, used by dynamic PMU kprobe and uprobe
