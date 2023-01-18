Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7660F671BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjARMQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjARMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD924875BF;
        Wed, 18 Jan 2023 03:37:53 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XOWWhVeVAOMndfqq8i24CNy11DrE3XLqdZTXMAnqN8=;
        b=WqHZvzjhTdWZsNYNrIKU83e66QbSNwqjgZrHZo75ibugKQrq7y81ZE7kwut/WV2jqfcUtT
        X3aAqnqMbVHBJw2q9PWbhGd66Naqsx5f9JXIuZBc7l363l9jVPk5fq6hhDmTe7eZWPWDVg
        nCAGhcnHVWIKMoV8V9eEpLKfUYaupeMT/IjPVcAx5EdPJBlgVZS14GnYWKKvFzS8ZWUx7X
        FJJds45OnsfSpJ3cJc18lxwKh3IA6qcr7hgq8/jfS7lz/Q1vHj5jvkF7xufFw53VgI2mCU
        1wYO0APOcT9iW7oDThhI0s91h7S3A/gx1bFAY5Z9DHeWsWhF2b7zcHYGMIt2EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XOWWhVeVAOMndfqq8i24CNy11DrE3XLqdZTXMAnqN8=;
        b=0EBcDAg+zhZ2uG2J6kQ38Pa8bkOR6LdNOOK2DrH7pFZowsKrUDK2TB/OFVmX670VAEMc/P
        /PUTtPISt+ayIoCg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Set data->sample_flags in perf_prepare_sample()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-6-namhyung@kernel.org>
References: <20230118060559.615653-6-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187184.4906.18122536452263093575.tip-bot2@tip-bot2>
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

Commit-ID:     bb447c27a4674628ea50341cfa4b31618f2010af
Gitweb:        https://git.kernel.org/tip/bb447c27a4674628ea50341cfa4b31618f2010af
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:56 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:20 +01:00

perf/core: Set data->sample_flags in perf_prepare_sample()

The perf_prepare_sample() function sets the perf_sample_data according
to the attr->sample_type before copying it to the ring buffer.  But BPF
also wants to access the sample data so it needs to prepare the sample
even before the regular path.

That means perf_prepare_sample() can be called more than once.  Set
the data->sample_flags consistently so that it can indicate which fields
are set already and skip them if sets.

Also update the filtered_sample_type to have the dependent flags to
reduce the number of branches.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-6-namhyung@kernel.org
---
 kernel/events/core.c | 85 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bd20705..7135cb9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7046,12 +7046,21 @@ out_put:
 	ring_buffer_put(rb);
 }
 
+/*
+ * A set of common sample data types saved even for non-sample records
+ * when event->attr.sample_id_all is set.
+ */
+#define PERF_SAMPLE_ID_ALL  (PERF_SAMPLE_TID | PERF_SAMPLE_TIME |	\
+			     PERF_SAMPLE_ID | PERF_SAMPLE_STREAM_ID |	\
+			     PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
+
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
 					 struct perf_event *event,
 					 u64 sample_type)
 {
 	data->type = event->attr.sample_type;
+	data->sample_flags |= data->type & PERF_SAMPLE_ID_ALL;
 	header->size += event->id_header_size;
 
 	if (sample_type & PERF_SAMPLE_TID) {
@@ -7554,6 +7563,11 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	return callchain ?: &__empty_callchain;
 }
 
+static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
+{
+	return d * !!(flags & s);
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
@@ -7569,14 +7583,24 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc |= perf_misc_flags(regs);
 
 	/*
-	 * Clear the sample flags that have already been done by the
-	 * PMU driver.
+	 * Add the sample flags that are dependent to others.  And clear the
+	 * sample flags that have already been done by the PMU driver.
 	 */
-	filtered_sample_type = sample_type & ~data->sample_flags;
+	filtered_sample_type = sample_type;
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_CODE_PAGE_SIZE,
+					   PERF_SAMPLE_IP);
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_DATA_PAGE_SIZE |
+					   PERF_SAMPLE_PHYS_ADDR, PERF_SAMPLE_ADDR);
+	filtered_sample_type |= __cond_set(sample_type, PERF_SAMPLE_STACK_USER,
+					   PERF_SAMPLE_REGS_USER);
+	filtered_sample_type &= ~data->sample_flags;
+
 	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
-	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
+	if (filtered_sample_type & PERF_SAMPLE_IP) {
 		data->ip = perf_instruction_pointer(regs);
+		data->sample_flags |= PERF_SAMPLE_IP;
+	}
 
 	if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 		perf_sample_save_callchain(data, event, regs);
@@ -7593,10 +7617,15 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
+	if (filtered_sample_type & PERF_SAMPLE_REGS_USER)
 		perf_sample_regs_user(&data->regs_user, regs);
 
-	if (sample_type & PERF_SAMPLE_REGS_USER) {
+	/*
+	 * It cannot use the filtered_sample_type here as REGS_USER can be set
+	 * by STACK_USER (using __cond_set() above) and we don't want to update
+	 * the dyn_size if it's not requested by users.
+	 */
+	if ((sample_type & ~data->sample_flags) & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
@@ -7606,9 +7635,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		}
 
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
-	if (sample_type & PERF_SAMPLE_STACK_USER) {
+	if (filtered_sample_type & PERF_SAMPLE_STACK_USER) {
 		/*
 		 * Either we need PERF_SAMPLE_STACK_USER bit to be always
 		 * processed as the last one or have additional check added
@@ -7631,23 +7661,30 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		data->stack_user_size = stack_size;
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_STACK_USER;
 	}
 
-	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		data->weight.full = 0;
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 
-	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC)
+	if (filtered_sample_type & PERF_SAMPLE_DATA_SRC) {
 		data->data_src.val = PERF_MEM_NA;
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
 
-	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION)
+	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION) {
 		data->txn = 0;
+		data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+	}
 
-	if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		if (filtered_sample_type & PERF_SAMPLE_ADDR)
-			data->addr = 0;
+	if (filtered_sample_type & PERF_SAMPLE_ADDR) {
+		data->addr = 0;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
 	}
 
-	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+	if (filtered_sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
@@ -7660,19 +7697,22 @@ void perf_prepare_sample(struct perf_event_header *header,
 		}
 
 		data->dyn_size += size;
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
 
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
-	    filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
+	if (filtered_sample_type & PERF_SAMPLE_PHYS_ADDR) {
 		data->phys_addr = perf_virt_to_phys(data->addr);
+		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
+	}
 
 #ifdef CONFIG_CGROUP_PERF
-	if (sample_type & PERF_SAMPLE_CGROUP) {
+	if (filtered_sample_type & PERF_SAMPLE_CGROUP) {
 		struct cgroup *cgrp;
 
 		/* protected by RCU */
 		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
 		data->cgroup = cgroup_id(cgrp);
+		data->sample_flags |= PERF_SAMPLE_CGROUP;
 	}
 #endif
 
@@ -7681,13 +7721,17 @@ void perf_prepare_sample(struct perf_event_header *header,
 	 * require PERF_SAMPLE_ADDR, kernel implicitly retrieve the data->addr,
 	 * but the value will not dump to the userspace.
 	 */
-	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+	if (filtered_sample_type & PERF_SAMPLE_DATA_PAGE_SIZE) {
 		data->data_page_size = perf_get_page_size(data->addr);
+		data->sample_flags |= PERF_SAMPLE_DATA_PAGE_SIZE;
+	}
 
-	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+	if (filtered_sample_type & PERF_SAMPLE_CODE_PAGE_SIZE) {
 		data->code_page_size = perf_get_page_size(data->ip);
+		data->sample_flags |= PERF_SAMPLE_CODE_PAGE_SIZE;
+	}
 
-	if (sample_type & PERF_SAMPLE_AUX) {
+	if (filtered_sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
 		header->size += sizeof(u64); /* size */
@@ -7705,6 +7749,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		data->dyn_size += size + sizeof(u64); /* size above */
+		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
 
 	header->size += data->dyn_size;
