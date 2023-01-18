Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B6671BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjARMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjARMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA16875AE;
        Wed, 18 Jan 2023 03:37:56 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUmYH39CIc/bwJ8rCz37PnHRzsia3/w363kzPTdQ9oE=;
        b=LipOsDSJDkzgN8XuzaWVAU0zNqZWUap/UitPqhIPrsR0T4KoRfFDKxmqL6HRPQE8ntPxsX
        RMfM/et8DwkjM5k7AemrqqtPB7gYpT4ZoGhKBe7lnl2ZVFgP4Nw3fc8AC5tbke1HywaJQi
        OP0vXvpa5MVAAkNk9aD2dpwp4veLJjdPRDLkDS0g5XYhLQSmYweaF7+eja8H1k2OxqSHCw
        yKLiuCquVCRLTawkKwntskK3D6hShF/Hi/bPTsiKFDP5cSAdQF8vUO6l+OWOjJH7mKjeCs
        Y6Ey2vmSsZrejzKCUppeuFPXSyLjNeO6pj5dCHq+Ilh0PYkDeQ1dQtIFVYRDHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUmYH39CIc/bwJ8rCz37PnHRzsia3/w363kzPTdQ9oE=;
        b=YszBFszI9C6JyTq4u1ebb4bT5GMWx2MfjJGvCnGSV1HD1KMNa1aboSFlqB4C0ZeLYhIX7p
        bN9pKMPRANZbxxDg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Save the dynamic parts of sample data size
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-2-namhyung@kernel.org>
References: <20230118060559.615653-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187322.4906.2403100991800759318.tip-bot2@tip-bot2>
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

Commit-ID:     4cf7a136115e96241f9f1089d2b53c47accf3823
Gitweb:        https://git.kernel.org/tip/4cf7a136115e96241f9f1089d2b53c47accf3823
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:52 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:19 +01:00

perf/core: Save the dynamic parts of sample data size

The perf sample data can be divided into parts.  The event->header_size
and event->id_header_size keep the static part of the sample data which
is determined by the sample_type flags.

But other parts like CALLCHAIN and BRANCH_STACK are changing dynamically
so it needs to see the actual data.  In preparation of handling repeated
calls for perf_prepare_sample(), it can save the dynamic size to the
perf sample data to avoid the duplicate work.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-2-namhyung@kernel.org
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 03949d0..16b9800 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,6 +1103,7 @@ struct perf_sample_data {
 	 */
 	u64				sample_flags;
 	u64				period;
+	u64				dyn_size;
 
 	/*
 	 * Fields commonly set by __perf_event_header__init_id(),
@@ -1158,6 +1159,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
+	data->dyn_size = 0;
 
 	if (addr) {
 		data->addr = addr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d56328e..827082d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7586,7 +7586,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 		size += data->callchain->nr;
 
-		header->size += size * sizeof(u64);
+		data->dyn_size += size * sizeof(u64);
 	}
 
 	if (sample_type & PERF_SAMPLE_RAW) {
@@ -7612,7 +7612,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			data->raw = NULL;
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -7624,7 +7624,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
 		}
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
@@ -7639,7 +7639,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += hweight64(mask) * sizeof(u64);
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
@@ -7664,7 +7664,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += sizeof(u64) + stack_size;
 
 		data->stack_user_size = stack_size;
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
@@ -7693,7 +7693,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += hweight64(mask) * sizeof(u64);
 		}
 
-		header->size += size;
+		data->dyn_size += size;
 	}
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
@@ -7738,8 +7738,11 @@ void perf_prepare_sample(struct perf_event_header *header,
 		size = perf_prepare_sample_aux(event, data, size);
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
-		header->size += size;
+		data->dyn_size += size + sizeof(u64); /* size above */
 	}
+
+	header->size += data->dyn_size;
+
 	/*
 	 * If you're adding more sample types here, you likely need to do
 	 * something about the overflowing header::size, like repurpose the
