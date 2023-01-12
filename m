Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B806685D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbjALVsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbjALVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338A33D69
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso25060050pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2i4YuMUlvMifEh3T6Lz7Q3wr3VQ+FCqQlCzw4xiZBo=;
        b=XVZvrxt5WGZOPzCt8LDpJrjmv8glK3D9y2YETiG2e3W2V/XenVy70B5SsLUdUe6CJ8
         6UgFVCsd19ClkBttPp76iWnpqwbRld6K+1rrvX+x9usSAFx1KN7utwRemqy3mMwTmp6i
         5cIWZz8dg9F0eAoq/zcIdGiS3VORcbs8cCb4JomvOU9cgHxbaciaubTAB20K8GMEwTQq
         MJdb8q+EzilmfWBLgqGkIx7KJB29oIvaJikSM88/5xfyS5xqym3zjVixXkS7zTg9eFl7
         o7akxkNjflSS2M4HHWEl0/ZiBHnHkOsFAevM0mBz/DuNeGqPICmdmB474dv8ZGASPWIl
         ryjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2i4YuMUlvMifEh3T6Lz7Q3wr3VQ+FCqQlCzw4xiZBo=;
        b=603cr7NjDr8QFhr9GZGpz1eW5uOp1eXKOUvt4nDfP9UE9oe4oQxoXqvAvaagjU/1ao
         BDV/ndEHHfwyrc/O9AJRPJUIQ4wwxn7CqaJSDF+QalyjYP3uGR+ELhFtjINLKwgk8IQb
         cj92fGXLuOxEpfy1lRYD7LA8kamCepEqgVGg2WSVlQRiULgatORZAfbjnk1Xu1dxfNy2
         oek9dNxAummpY8AWQVAki/v07t5O+WVEYSRi2ZgfGqzDFZ+LHo+nYQpuWahz02AoxECz
         KqFGWqILOk4CQQU1Bmsl1FjLZ20LPCsbs8zCX+/kc4IJdxqWm6Ki0OROYqvuk6GWAKLk
         Umog==
X-Gm-Message-State: AFqh2kpWiViZhhl40fW/fZ3fujjueot+b1XOQ2dERgeCApoOLa7auh2A
        wVECiwG1WzQ0FTuzZG6MXOw=
X-Google-Smtp-Source: AMrXdXtikgEbLuS8PBAUlCH+VVw6Z27M5RL43urXbD+xL9SIzYFLx8fvlzFWjsI5cE+0fsN85JeXnw==
X-Received: by 2002:a05:6a20:aa9f:b0:af:7762:3c29 with SMTP id ck31-20020a056a20aa9f00b000af77623c29mr9348181pzb.10.1673559624771;
        Thu, 12 Jan 2023 13:40:24 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b71e:23d4:aa6a:47c0])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11344605pfl.146.2023.01.12.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:40:24 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH 4/8] perf/core: Add perf_sample_save_brstack() helper
Date:   Thu, 12 Jan 2023 13:40:11 -0800
Message-Id: <20230112214015.1014857-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it saves the branch stack to the perf sample data, it needs to
update the sample flags and the dynamic size.  To make sure this,
add the perf_sample_save_brstack() helper and convert all call sites.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/powerpc/perf/core-book3s.c |  3 +-
 arch/x86/events/amd/core.c      |  6 +--
 arch/x86/events/intel/core.c    |  6 +--
 arch/x86/events/intel/ds.c      |  9 ++---
 include/linux/perf_event.h      | 66 ++++++++++++++++++++-------------
 kernel/events/core.c            | 16 +++-----
 6 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index bf318dd9b709..8c1f7def596e 100644
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
index d6f3703e4119..463f3eb8bbd7 100644
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
index 29d2d0411caf..14f0a746257d 100644
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
index 158cf845fc80..07c8a2cdc3ee 100644
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
index 569dfac5887f..7db0e9cc2682 100644
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
index 133894ae5e30..0218b6ffaf36 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7317,7 +7317,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
+		if (data->br_stack) {
 			size_t size;
 
 			size = data->br_stack->nr
@@ -7594,16 +7594,10 @@ void perf_prepare_sample(struct perf_event_header *header,
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
-- 
2.39.0.314.g84b9a713c41-goog

