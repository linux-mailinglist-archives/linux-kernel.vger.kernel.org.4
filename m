Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEBA662C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjAIRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjAIRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF43C395;
        Mon,  9 Jan 2023 09:02:09 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrIT0bcZEpIZlEQZhnVeJ6y1E5lYagf56z8SvCIxtKw=;
        b=jMMCxxEcvbutmHemO9EgARA1uUlaFPNXpulj4e+UL2euF8tsVd7lDjlBGFZn5rBMKw5SMP
        7rRi8aRJvxZsLwYDqrgcJKs+iFhH4xw2FAAQZtbUj096OverTyjMEFfL4HXeAnKY91D0XU
        XZstH0CN0aAimJ7xjdXbOH0fs6fdenAf/bxfNNw0L0oWVHba6k5kzsvlNvt4arJEcMKis3
        4WOJuG9fDDuoHrr6anXDM4mmEG04+GCc+mH5GXZhngcatLUBSd+hFuDhbY9ld418Ws8T+q
        eL0w6eLLcXK5pprXePig37IHJuBCPRegLJKYA+J/K5wTKNbcaqUxmBpGZCURog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrIT0bcZEpIZlEQZhnVeJ6y1E5lYagf56z8SvCIxtKw=;
        b=VXQ6bMW4dfIPcGu54l2/0F7At8Z1LEqYUVFyf3/ZRIMRv1o7MNlfUIiSRuxH7FTewqbnQZ
        v7Ndn8dOJSXu9eCQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Set data->sample_flags in perf_prepare_sample()
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221229204101.1099430-2-namhyung@kernel.org>
References: <20221229204101.1099430-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167328372752.4906.8363431706095954334.tip-bot2@tip-bot2>
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

Commit-ID:     965547f0a2f3cd0786d4faee2db008bb281d4922
Gitweb:        https://git.kernel.org/tip/965547f0a2f3cd0786d4faee2db008bb281d4922
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 29 Dec 2022 12:41:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:09 +01:00

perf/core: Set data->sample_flags in perf_prepare_sample()

The perf_prepare_sample() sets the perf_sample_data according to the
attr->sample_type before copying it to the ring buffer.  But BPF also
wants to access the sample data so it needs to prepare the sample even
before the regular path.

That means the perf_prepare_sample() can be called more than once.  Set
the data->sample_flags consistently so that it can indicate which fields
are set already and skip them if sets.

Mostly it's just a matter of checking filtered_sample_type which is a
bitmask for unset bits in the attr->sample_type.  But some of sample
data is implied by others even if it's not in the attr->sample_type
(like PERF_SAMPLE_ADDR for PERF_SAMPLE_PHYS_ADDR).  So they need to
check data->sample_flags separately.

Also some of them like callchain, user regs/stack and aux data require
more calculations.  Protect them using the data->sample_flags to avoid
the duplicate work.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221229204101.1099430-2-namhyung@kernel.org
---
 kernel/events/core.c | 86 +++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc370..70bff8a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7582,14 +7582,21 @@ void perf_prepare_sample(struct perf_event_header *header,
 	filtered_sample_type = sample_type & ~data->sample_flags;
 	__perf_event_header__init_id(header, data, event, filtered_sample_type);
 
-	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
-		data->ip = perf_instruction_pointer(regs);
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE)) {
+		/* attr.sample_type may not have PERF_SAMPLE_IP */
+		if (!(data->sample_flags & PERF_SAMPLE_IP)) {
+			data->ip = perf_instruction_pointer(regs);
+			data->sample_flags |= PERF_SAMPLE_IP;
+		}
+	}
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
+		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
 			data->callchain = perf_callchain(event, regs);
+			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+		}
 
 		size += data->callchain->nr;
 
@@ -7634,8 +7641,13 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
-		perf_sample_regs_user(&data->regs_user, regs);
+	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER)) {
+		/* attr.sample_type may not have PERF_SAMPLE_REGS_USER */
+		if (!(data->sample_flags & PERF_SAMPLE_REGS_USER)) {
+			perf_sample_regs_user(&data->regs_user, regs);
+			data->sample_flags |= PERF_SAMPLE_REGS_USER;
+		}
+	}
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
@@ -7656,11 +7668,18 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * in case new sample type is added, because we could eat
 		 * up the rest of the sample size.
 		 */
-		u16 stack_size = event->attr.sample_stack_user;
 		u16 size = sizeof(u64);
+		u16 stack_size;
+
+		if (filtered_sample_type & PERF_SAMPLE_STACK_USER) {
+			stack_size = event->attr.sample_stack_user;
+			stack_size = perf_sample_ustack_size(stack_size, header->size,
+							     data->regs_user.regs);
 
-		stack_size = perf_sample_ustack_size(stack_size, header->size,
-						     data->regs_user.regs);
+			data->stack_user_size = stack_size;
+			data->sample_flags |= PERF_SAMPLE_STACK_USER;
+		}
+		stack_size = data->stack_user_size;
 
 		/*
 		 * If there is something to dump, add space for the dump
@@ -7670,29 +7689,40 @@ void perf_prepare_sample(struct perf_event_header *header,
 		if (stack_size)
 			size += sizeof(u64) + stack_size;
 
-		data->stack_user_size = stack_size;
 		header->size += size;
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
 
 	if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		if (filtered_sample_type & PERF_SAMPLE_ADDR)
+		/* attr.sample_type may not have PERF_SAMPLE_ADDR */
+		if (!(data->sample_flags & PERF_SAMPLE_ADDR)) {
 			data->addr = 0;
+			data->sample_flags |= PERF_SAMPLE_ADDR;
+		}
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		if (filtered_sample_type & PERF_SAMPLE_REGS_INTR) {
+			perf_sample_regs_intr(&data->regs_intr, regs);
+			data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+		}
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
@@ -7703,17 +7733,19 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
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
 
@@ -7722,11 +7754,15 @@ void perf_prepare_sample(struct perf_event_header *header,
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
 
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
@@ -7739,10 +7775,14 @@ void perf_prepare_sample(struct perf_event_header *header,
 		 * Make sure this doesn't happen by using up to U16_MAX bytes
 		 * per sample in total (rounded down to 8 byte boundary).
 		 */
-		size = min_t(size_t, U16_MAX - header->size,
-			     event->attr.aux_sample_size);
-		size = rounddown(size, 8);
-		size = perf_prepare_sample_aux(event, data, size);
+		if (filtered_sample_type & PERF_SAMPLE_AUX) {
+			size = min_t(size_t, U16_MAX - header->size,
+				     event->attr.aux_sample_size);
+			size = rounddown(size, 8);
+			perf_prepare_sample_aux(event, data, size);
+			data->sample_flags |= PERF_SAMPLE_AUX;
+		}
+		size = data->aux_size;
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		header->size += size;
