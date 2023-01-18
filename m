Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60758671BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjARMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjARMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22C875BA;
        Wed, 18 Jan 2023 03:37:53 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8NwMB8ra9RDjzMVh9Fu1txLTnGhsB4sAeEmgKAcxQE=;
        b=0mCuKXXi8f6yhCAL516X5mrFAXPnJj2/koxhhkbB2FfcyrymvEHXT/H9gTp5IWBnLA/hLj
        IJW9BmggACoGRYvMIU1VXmB/1YSJn0EldttJGAYD32vcztbhBzsNeFhrkkYvSh3rvjSv2d
        uTby3a9WGjD/3NgZQ6We/aXdwPVsxhWaEpiZ6VI3HckgoDzgPs/76EENePYx4Xk7BoDN0T
        qrjc7tb94s9oZmP2x8bl+61toLePdS0PtqSTFzCGc8P2BPn2jytJB+9xqVaKwHC61KmmJO
        I07GOGfzkJYzeGtA8ePcreEIfOXjC5NuWxokuV2lUz/HEKzYex6J8O5DEHWCSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8NwMB8ra9RDjzMVh9Fu1txLTnGhsB4sAeEmgKAcxQE=;
        b=xuCYE+t8xv0S8ZqB2tzYgqkZLPNFn+kBz7s1Kk+0441scLMHqwOVuOdq3uUJuV4K1yvB2u
        aR1veiGIyoe/8wCQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Introduce perf_prepare_header()
Cc:     Peter Zijlstr <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <song@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-8-namhyung@kernel.org>
References: <20230118060559.615653-8-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187105.4906.10676532531375998244.tip-bot2@tip-bot2>
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

Commit-ID:     f6e707156e1d5d150f288823987bee1ba0104c4c
Gitweb:        https://git.kernel.org/tip/f6e707156e1d5d150f288823987bee1ba0104c4c
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:58 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:20 +01:00

perf/core: Introduce perf_prepare_header()

Factor out perf_prepare_header() so that it can call
perf_prepare_sample() without a header if not needed.

Also it checks the filtered_sample_type to avoid duplicate
work when perf_prepare_sample() is called twice (or more).

Suggested-by: Peter Zijlstr <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-8-namhyung@kernel.org
---
 arch/s390/kernel/perf_cpum_sf.c |  3 ++-
 arch/x86/events/intel/ds.c      |  3 ++-
 include/linux/perf_event.h      | 16 ++++++++++++-
 kernel/events/core.c            | 38 ++++++++++++++++++++------------
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index ce886a0..ead6eea 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -672,7 +672,8 @@ static void cpumsf_output_event_pid(struct perf_event *event,
 	/* Protect callchain buffers, tasks */
 	rcu_read_lock();
 
-	perf_prepare_sample(&header, data, event, regs);
+	perf_prepare_sample(data, event, regs);
+	perf_prepare_header(&header, data, event, regs);
 	if (perf_output_begin(&handle, data, event, header.size))
 		goto out;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 07c8a2c..183efa9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -807,7 +807,8 @@ int intel_pmu_drain_bts_buffer(void)
 	 * the sample.
 	 */
 	rcu_read_lock();
-	perf_prepare_sample(&header, &data, event, &regs);
+	perf_prepare_sample(&data, event, &regs);
+	perf_prepare_header(&header, &data, event, &regs);
 
 	if (perf_output_begin(&handle, &data, event,
 			      header.size * (top - base - skip)))
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7db0e9c..d5628a7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1250,6 +1250,17 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline u32 perf_sample_data_size(struct perf_sample_data *data,
+					struct perf_event *event)
+{
+	u32 size = sizeof(struct perf_event_header);
+
+	size += event->header_size + event->id_header_size;
+	size += data->dyn_size;
+
+	return size;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
@@ -1271,7 +1282,10 @@ extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
 			       struct perf_event *event);
-extern void perf_prepare_sample(struct perf_event_header *header,
+extern void perf_prepare_sample(struct perf_sample_data *data,
+				struct perf_event *event,
+				struct pt_regs *regs);
+extern void perf_prepare_header(struct perf_event_header *header,
 				struct perf_sample_data *data,
 				struct perf_event *event,
 				struct pt_regs *regs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 47bfd99..4aa73ed 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7568,20 +7568,13 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
 	return d * !!(flags & s);
 }
 
-void perf_prepare_sample(struct perf_event_header *header,
-			 struct perf_sample_data *data,
+void perf_prepare_sample(struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
 	u64 sample_type = event->attr.sample_type;
 	u64 filtered_sample_type;
 
-	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size + event->id_header_size;
-
-	header->misc = 0;
-	header->misc |= perf_misc_flags(regs);
-
 	/*
 	 * Add the sample flags that are dependent to others.  And clear the
 	 * sample flags that have already been done by the PMU driver.
@@ -7595,6 +7588,12 @@ void perf_prepare_sample(struct perf_event_header *header,
 					   PERF_SAMPLE_REGS_USER);
 	filtered_sample_type &= ~data->sample_flags;
 
+	if (filtered_sample_type == 0) {
+		/* Make sure it has the correct data->type for output */
+		data->type = event->attr.sample_type;
+		return;
+	}
+
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
@@ -7646,9 +7645,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * up the rest of the sample size.
 		 */
 		u16 stack_size = event->attr.sample_stack_user;
+		u16 header_size = perf_sample_data_size(data, event);
 		u16 size = sizeof(u64);
 
-		stack_size = perf_sample_ustack_size(stack_size, header->size,
+		stack_size = perf_sample_ustack_size(stack_size, header_size,
 						     data->regs_user.regs);
 
 		/*
@@ -7733,8 +7733,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
+		u16 header_size = perf_sample_data_size(data, event);
 
-		header->size += sizeof(u64); /* size */
+		header_size += sizeof(u64); /* size */
 
 		/*
 		 * Given the 16bit nature of header::size, an AUX sample can
@@ -7742,17 +7743,25 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * Make sure this doesn't happen by using up to U16_MAX bytes
 		 * per sample in total (rounded down to 8 byte boundary).
 		 */
-		size = min_t(size_t, U16_MAX - header->size,
+		size = min_t(size_t, U16_MAX - header_size,
 			     event->attr.aux_sample_size);
 		size = rounddown(size, 8);
 		size = perf_prepare_sample_aux(event, data, size);
 
-		WARN_ON_ONCE(size + header->size > U16_MAX);
+		WARN_ON_ONCE(size + header_size > U16_MAX);
 		data->dyn_size += size + sizeof(u64); /* size above */
 		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
+}
 
-	header->size += data->dyn_size;
+void perf_prepare_header(struct perf_event_header *header,
+			 struct perf_sample_data *data,
+			 struct perf_event *event,
+			 struct pt_regs *regs)
+{
+	header->type = PERF_RECORD_SAMPLE;
+	header->size = perf_sample_data_size(data, event);
+	header->misc = perf_misc_flags(regs);
 
 	/*
 	 * If you're adding more sample types here, you likely need to do
@@ -7781,7 +7790,8 @@ __perf_event_output(struct perf_event *event,
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
-	perf_prepare_sample(&header, data, event, regs);
+	perf_prepare_sample(data, event, regs);
+	perf_prepare_header(&header, data, event, regs);
 
 	err = output_begin(&handle, data, event, header.size);
 	if (err)
