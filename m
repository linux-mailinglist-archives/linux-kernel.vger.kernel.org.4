Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137C8671BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjARMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjARMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED0875A8;
        Wed, 18 Jan 2023 03:37:56 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPBP3IkqibzLwh4B2vJOl6x2ccpku6SEEl/K0byLfGY=;
        b=S6ZLwr6+nDHOOsY6mJPDv9gCeOmB7437zfBTOkdFoXa6VNT7N3X71HwVULw6nJZZagVxPG
        MZND+gesdpM3Gqs27lbafQblViyBZlRNj8np+ULYYkyyWM5EVnAn4JZajkVoiI/i6IQ9pj
        +ciyhprnYFy7OPaf8z8S+d2Sfyas9K6cXW42/yHzL8dknVHYPsKYgH6wwYr3Dmj95ps4Ie
        PFYfVQsv4I1PEjVntCHoErc9Erb9M9LQq+qPKGg4PWQT+H9FEE1RJRE1cYSe0qDzgGeKid
        KIjlqD/jcoIi0u/YBcziOpEMowgw4jz6eaiHpfDBUkt9TBKRLtNHonWV1Bj3uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPBP3IkqibzLwh4B2vJOl6x2ccpku6SEEl/K0byLfGY=;
        b=8MnkqmzW0K1hX9ep39IQEcI2HvWpeuwgYHcgQUT7OIXNbiWBjIGVX1jdwHz9nEDqEDJy+A
        tkaghHhxwARn6hDg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add perf_sample_save_callchain() helper
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <song@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-3-namhyung@kernel.org>
References: <20230118060559.615653-3-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187292.4906.5500189847738583234.tip-bot2@tip-bot2>
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

Commit-ID:     31046500c1864b8ab25d1b9846ad10aa3f7b1821
Gitweb:        https://git.kernel.org/tip/31046500c1864b8ab25d1b9846ad10aa3f7b1821
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:53 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:19 +01:00

perf/core: Add perf_sample_save_callchain() helper

When we save the callchain to the perf sample data, we need to update
the sample flags and the dynamic size.  To ensure this is done consistently,
add the perf_sample_save_callchain() helper and convert all call sites.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-3-namhyung@kernel.org
---
 arch/x86/events/amd/ibs.c  |  6 ++----
 arch/x86/events/intel/ds.c | 12 ++++--------
 include/linux/perf_event.h | 16 +++++++++++++++-
 kernel/events/core.c       | 12 ++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index da3f5eb..417c80b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1122,10 +1122,8 @@ fail:
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data.callchain = perf_callchain(event, iregs);
-		data.sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6ec326b..158cf84 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1617,10 +1617,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data->callchain = perf_callchain(event, iregs);
-		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1795,10 +1793,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		data->callchain = perf_callchain(event, iregs);
-		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-	}
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 16b9800..a941960 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1095,6 +1095,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
+extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
+
 
 struct perf_sample_data {
 	/*
@@ -1167,6 +1169,19 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	}
 }
 
+static inline void perf_sample_save_callchain(struct perf_sample_data *data,
+					      struct perf_event *event,
+					      struct pt_regs *regs)
+{
+	int size = 1;
+
+	data->callchain = perf_callchain(event, regs);
+	size += data->callchain->nr;
+
+	data->dyn_size += size * sizeof(u64);
+	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1408,7 +1423,6 @@ extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
-extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 827082d..12b7d51 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7578,16 +7578,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
-	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
-		int size = 1;
-
-		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
-			data->callchain = perf_callchain(event, regs);
-
-		size += data->callchain->nr;
-
-		data->dyn_size += size * sizeof(u64);
-	}
+	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, regs);
 
 	if (sample_type & PERF_SAMPLE_RAW) {
 		struct perf_raw_record *raw = data->raw;
