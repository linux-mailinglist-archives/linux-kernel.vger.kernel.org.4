Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3D671BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjARMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjARMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA687640;
        Wed, 18 Jan 2023 03:37:54 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAfH2mbDwrruX13M/8HQDfaHA8NrXxBb6pWZoIxPJqA=;
        b=B+lZt4CL53ffQMt3/gagAIcoOS1D+mKikPZuN0tPaqZkRnbmru1yo6//V2cyyuZ1KtwYz5
        3P+bp8ZaPahgLl8K0e7cjIfpwv+2E8l1WU+RLNLs0momyqwbyoCX8UbOO3/3f6sXS+5biy
        NtCKQQnJPYL7c2tKEVZwzHlEOr4xH3gisqubNfq5Lrq8osZZXm4Pi4jiHOMfo3DGhUgKZv
        OvQK52AAXP0CFV2G9DUz6MXcY4wodijxMjw1MMvZfzrxa4qLxWP+kJwJKKFtno6F3DCR74
        MEyqb+IoYudH0CeRzxWKsnf2fNUYz3K0jTXNun5S/byh9lBT/KVJIRNHwtjbZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAfH2mbDwrruX13M/8HQDfaHA8NrXxBb6pWZoIxPJqA=;
        b=rboG5UO6RFv3mZ58GZ9kvUbNNcMVJaeEoLd+rnyG/hWMardd0ThTC5MR2sKchdNW10vqN9
        NhvrGVRiM3X3liDQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add perf_sample_save_brstack() helper
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-5-namhyung@kernel.org>
References: <20230118060559.615653-5-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187214.4906.5082914513672443558.tip-bot2@tip-bot2>
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

Commit-ID:     eb55b455ef9c7123bdfa7e8a7f1ebeaa8034eb83
Gitweb:        https://git.kernel.org/tip/eb55b455ef9c7123bdfa7e8a7f1ebeaa8034eb83
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:55 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:20 +01:00

perf/core: Add perf_sample_save_brstack() helper

When we saves the branch stack to the perf sample data, we needs to
update the sample flags and the dynamic size.  To make sure this is
done consistently, add the perf_sample_save_brstack() helper and
convert all call sites.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-5-namhyung@kernel.org
---
 arch/powerpc/perf/core-book3s.c |  3 +-
 arch/x86/events/amd/core.c      |  6 +--
 arch/x86/events/intel/core.c    |  6 +--
 arch/x86/events/intel/ds.c      |  9 +---
 include/linux/perf_event.h      | 66 +++++++++++++++++++-------------
 kernel/events/core.c            | 16 ++------
 6 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index bf318dd..8c1f7de 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2313,8 +2313,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
-			data.br_stack = &cpuhw->bhrb_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack);
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 4386b10..8c45b19 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -928,10 +928,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event)) {
-			data.br_stack = &cpuc->lbr_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-		}
+		if (has_branch_stack(event))
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 29d2d04..14f0a74 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3036,10 +3036,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event)) {
-			data.br_stack = &cpuc->lbr_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-		}
+		if (has_branch_stack(event))
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 158cf84..07c8a2c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1720,10 +1720,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		data->sample_flags |= PERF_SAMPLE_TIME;
 	}
 
-	if (has_branch_stack(event)) {
-		data->br_stack = &cpuc->lbr_stack;
-		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-	}
+	if (has_branch_stack(event))
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1883,8 +1881,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
-			data->br_stack = &cpuc->lbr_stack;
-			data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+			perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 569dfac..7db0e9c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1102,6 +1102,31 @@ extern u64 perf_event_read_value(struct perf_event *event,
 
 extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 
+static inline bool branch_sample_no_flags(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_FLAGS;
+}
+
+static inline bool branch_sample_no_cycles(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_CYCLES;
+}
+
+static inline bool branch_sample_type(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_TYPE_SAVE;
+}
+
+static inline bool branch_sample_hw_index(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
+}
+
+static inline bool branch_sample_priv(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
+}
+
 
 struct perf_sample_data {
 	/*
@@ -1210,6 +1235,21 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_RAW;
 }
 
+static inline void perf_sample_save_brstack(struct perf_sample_data *data,
+					    struct perf_event *event,
+					    struct perf_branch_stack *brs)
+{
+	int size = sizeof(u64); /* nr */
+
+	if (branch_sample_hw_index(event))
+		size += sizeof(u64);
+	size += brs->nr * sizeof(struct perf_branch_entry);
+
+	data->br_stack = brs;
+	data->dyn_size += size;
+	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1827,30 +1867,4 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
-#ifdef CONFIG_PERF_EVENTS
-static inline bool branch_sample_no_flags(const struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_FLAGS;
-}
-
-static inline bool branch_sample_no_cycles(const struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_NO_CYCLES;
-}
-
-static inline bool branch_sample_type(const struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_TYPE_SAVE;
-}
-
-static inline bool branch_sample_hw_index(const struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
-}
-
-static inline bool branch_sample_priv(const struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
-}
-#endif /* CONFIG_PERF_EVENTS */
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 17108a2..bd20705 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7310,7 +7310,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
+		if (data->br_stack) {
 			size_t size;
 
 			size = data->br_stack->nr
@@ -7587,16 +7587,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->sample_flags |= PERF_SAMPLE_RAW;
 	}
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		int size = sizeof(u64); /* nr */
-		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
-			if (branch_sample_hw_index(event))
-				size += sizeof(u64);
-
-			size += data->br_stack->nr
-			      * sizeof(struct perf_branch_entry);
-		}
-		data->dyn_size += size;
+	if (filtered_sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		data->br_stack = NULL;
+		data->dyn_size += sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
