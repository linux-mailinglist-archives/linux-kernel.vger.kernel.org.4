Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3820E5B3267
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiIIIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiIIIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9212D183;
        Fri,  9 Sep 2022 01:52:50 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=065r4MhIxz/sd8UoQWaUsckT8IQ9RQduR6TtsDljM9E=;
        b=Ty8ycG2uZvOtBeUKzsIWFk0ADGKfxsblphCeGp+msAeX17WVKXWNUvyItnfU5TDe4l7MB+
        ajRIUZdKkbxZ2IXwYpLmKqQSZC2oiU5zbN1n8nmewYqxWJgrtpCZFi56MkriUkD9uiy03K
        ofZL/VhGRYfMqSL2M2OJ6amjrfdne7+YsdMMsP8H5X5E8LAAdcMHjR5ISuYSj5zFcAWzpX
        AJrNZn+7p0DaEKs3QsYMNNptmzdKprXtOpqbwAFA3chMKG7eXIshgQ9043zC4jY4QoKqOF
        pwyK70oEVvR9mUNaxj7YCuvSvhhLlknzDsP3l2ZBEciX94c5a9f4Na0ftON9Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=065r4MhIxz/sd8UoQWaUsckT8IQ9RQduR6TtsDljM9E=;
        b=zJgWMd5ApgN2n5FWrJekJtjnEV4UXT6NciuzpWfAWsOiEwUklghym1LpAYc1IZJkONHfeq
        pnkPRFld2c83hLCw==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Consolidate branch sample filter helpers
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220906084414.396220-1-anshuman.khandual@arm.com>
References: <20220906084414.396220-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166271356806.401.340422939895391322.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     03b02db93be407103c385814033633364674a6f6
Gitweb:        https://git.kernel.org/tip/03b02db93be407103c385814033633364674a6f6
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Tue, 06 Sep 2022 14:14:14 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:00 +02:00

perf: Consolidate branch sample filter helpers

Besides the branch type filtering requests, 'event.attr.branch_sample_type'
also contains various flags indicating which additional information should
be captured, along with the base branch record. These flags help configure
the underlying hardware, and capture the branch records appropriately when
required e.g after PMU interrupt. But first, this moves an existing helper
perf_sample_save_hw_index() into the header before adding some more helpers
for other branch sample filter flags.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220906084414.396220-1-anshuman.khandual@arm.com
---
 include/linux/perf_event.h | 26 ++++++++++++++++++++++++++
 kernel/events/core.c       |  9 ++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 581880d..a627528 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1685,4 +1685,30 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+#ifdef CONFIG_PERF_EVENTS
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
+#endif /* CONFIG_PERF_EVENTS */
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 15d27b1..00389d5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6966,11 +6966,6 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
-static inline bool perf_sample_save_hw_index(struct perf_event *event)
-{
-	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
-}
-
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -7059,7 +7054,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			     * sizeof(struct perf_branch_entry);
 
 			perf_output_put(handle, data->br_stack->nr);
-			if (perf_sample_save_hw_index(event))
+			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
 		} else {
@@ -7359,7 +7354,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
 		if (data->sample_flags & PERF_SAMPLE_BRANCH_STACK) {
-			if (perf_sample_save_hw_index(event))
+			if (branch_sample_hw_index(event))
 				size += sizeof(u64);
 
 			size += data->br_stack->nr
