Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E9671BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjARMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjARMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160628758D;
        Wed, 18 Jan 2023 03:37:56 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSBQjmprxmJ6gF/KpECzetkVPXzHi5/dVlzORSsydVQ=;
        b=3CvckGJdhl6RnuApVXP8sqokLN4fzWlAoG9aNQ8tVvQ3DnFFVwlTcYa1UpGG3fjWBSSpcX
        RiT7RHVJvELON7fld0qQwRUvBcjeo+cHglsy/oAvGizdkqbL26UTpLb39VLzFu0VQ+RwYn
        5WASbQIRPc32Gf9n4dkB7DpJnsiMGmELn0sVTlMNiFfnhDUw2jYGZpK4dRFlVKEjtBsJCv
        kmX5GunDaPMNQGjuZq1MrtOiCa5CYGzLqT4hBjeUquuFN19bqs1sXXcZzMce3BPGuGoQi3
        vhIDuAJs7hpj5DUW0WLEkjqPpgp+SgMjh8J2ERl8nMdapUcqruKex2aPzoloHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSBQjmprxmJ6gF/KpECzetkVPXzHi5/dVlzORSsydVQ=;
        b=Dy5B2l4TxiXc4rW6FLqCk5NEee96oWfaoaxEZG/hVIPvDg4oYDzhEWJ5eJgPjaegyFZRLj
        sbHnmakDgCuxd8CA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add perf_sample_save_raw_data() helper
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-4-namhyung@kernel.org>
References: <20230118060559.615653-4-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187259.4906.2207097655267396863.tip-bot2@tip-bot2>
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

Commit-ID:     0a9081cf0a11770f6b0affd377db8caa3ec4c793
Gitweb:        https://git.kernel.org/tip/0a9081cf0a11770f6b0affd377db8caa3ec4c793
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:54 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:19 +01:00

perf/core: Add perf_sample_save_raw_data() helper

When we save the raw_data to the perf sample data, we need to update
the sample flags and the dynamic size.  To make sure this is done
consistently, add the perf_sample_save_raw_data() helper and convert
all call sites.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-4-namhyung@kernel.org
---
 arch/s390/kernel/perf_cpum_cf.c    |  4 +---
 arch/s390/kernel/perf_pai_crypto.c |  4 +---
 arch/s390/kernel/perf_pai_ext.c    |  4 +---
 arch/x86/events/amd/ibs.c          |  3 +--
 include/linux/perf_event.h         | 33 ++++++++++++++++++++++++-----
 kernel/events/core.c               | 31 ++++-----------------------
 kernel/trace/bpf_trace.c           |  6 +----
 7 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index f043a7f..aa38649 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -662,9 +662,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = cpuhw->usedss;
 		raw.frag.data = cpuhw->stop;
-		raw.size = raw.frag.size;
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 985e243..a7b339c 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -362,9 +362,7 @@ static int paicrypt_push_sample(void)
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		raw.size = raw.frag.size;
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 1138f57..5555972 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -451,9 +451,7 @@ static int paiext_push_sample(void)
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		raw.size = raw.frag.size;
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 417c80b..6458295 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1110,8 +1110,7 @@ fail:
 				.data = ibs_data.data,
 			},
 		};
-		data.raw = &raw;
-		data.sample_flags |= PERF_SAMPLE_RAW;
+		perf_sample_save_raw_data(&data, &raw);
 	}
 
 	if (perf_ibs == &perf_ibs_op)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a941960..569dfac 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -95,6 +95,11 @@ struct perf_raw_record {
 	u32				size;
 };
 
+static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
+{
+	return frag->pad < sizeof(u64);
+}
+
 /*
  * branch stack layout:
  *  nr: number of taken branches stored in entries[]
@@ -1182,6 +1187,29 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
 }
 
+static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
+					     struct perf_raw_record *raw)
+{
+	struct perf_raw_frag *frag = &raw->frag;
+	u32 sum = 0;
+	int size;
+
+	do {
+		sum += frag->size;
+		if (perf_raw_frag_last(frag))
+			break;
+		frag = frag->next;
+	} while (1);
+
+	size = round_up(sum + sizeof(u32), sizeof(u64));
+	raw->size = size - sizeof(u32);
+	frag->pad = raw->size - sum;
+
+	data->raw = raw;
+	data->dyn_size += size;
+	data->sample_flags |= PERF_SAMPLE_RAW;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1690,11 +1718,6 @@ extern void perf_restore_debug_store(void);
 static inline void perf_restore_debug_store(void)			{ }
 #endif
 
-static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
-{
-	return frag->pad < sizeof(u64);
-}
-
 #define perf_output_put(handle, x) perf_output_copy((handle), &(x), sizeof(x))
 
 struct perf_pmu_events_attr {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 12b7d51..17108a2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7581,30 +7581,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
 
-	if (sample_type & PERF_SAMPLE_RAW) {
-		struct perf_raw_record *raw = data->raw;
-		int size;
-
-		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
-			struct perf_raw_frag *frag = &raw->frag;
-			u32 sum = 0;
-
-			do {
-				sum += frag->size;
-				if (perf_raw_frag_last(frag))
-					break;
-				frag = frag->next;
-			} while (1);
-
-			size = round_up(sum + sizeof(u32), sizeof(u64));
-			raw->size = size - sizeof(u32);
-			frag->pad = raw->size - sum;
-		} else {
-			size = sizeof(u64);
-			data->raw = NULL;
-		}
-
-		data->dyn_size += size;
+	if (filtered_sample_type & PERF_SAMPLE_RAW) {
+		data->raw = NULL;
+		data->dyn_size += sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -10120,8 +10100,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	};
 
 	perf_sample_data_init(&data, 0, 0);
-	data.raw = &raw;
-	data.sample_flags |= PERF_SAMPLE_RAW;
+	perf_sample_save_raw_data(&data, &raw);
 
 	perf_trace_buf_update(record, event_type);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0..ad37608 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -687,8 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	sd->raw = &raw;
-	sd->sample_flags |= PERF_SAMPLE_RAW;
+	perf_sample_save_raw_data(sd, &raw);
 
 	err = __bpf_perf_event_output(regs, map, flags, sd);
 
@@ -746,8 +745,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	sd->raw = &raw;
-	sd->sample_flags |= PERF_SAMPLE_RAW;
+	perf_sample_save_raw_data(sd, &raw);
 
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
