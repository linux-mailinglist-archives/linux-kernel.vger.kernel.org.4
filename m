Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39E5B9CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIOOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIOOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:16:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AB95A3FB;
        Thu, 15 Sep 2022 07:16:40 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:16:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccBMjjEeCKeUdwVrOFsmFb8BeKecH/ZVqdBTIwVLElM=;
        b=RJpovITKExtVTmuAHptPBNR9PtznBpCM6Suuk5yWYGc5WB/PnCQEfARwivICTanaLsJ9B8
        spiyLa0X9TeqClHZz+oV+YqmBO6PHDywQ3jlJpmO566D4VtzLGmvdPTmcWPgl86jB449KL
        4EOOmuTc59qfy4JeivVfI4B9CctZj0/GJBEH22hURxsXl/uWgxMVRnzxiTwUXU5FjNjMOl
        Fk8MzsmAiU32oNeEoDT4QwSLZSlfZGTaAIuZI2oVx/ssjvYhSExOQlS/oRD+DPI3bp948U
        iwDk2XT56HWv97n7FEwVNzJfaaSovB8S4cvEI3gHIsKTHXPss1TatApchuMQaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccBMjjEeCKeUdwVrOFsmFb8BeKecH/ZVqdBTIwVLElM=;
        b=CkbA7pmMzY+xzbHVpcP05CCYUfVjtWjytJDbKfrAw0q04VqagaEUxQ06dT0oNcyIa30btE
        Rqo1OHcWfD0tT4Aw==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Always use perf callchains if exist
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220908214104.3851807-2-namhyung@kernel.org>
References: <20220908214104.3851807-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166325139832.401.13098591458028743653.tip-bot2@tip-bot2>
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

Commit-ID:     16817ad7e8b31728b44ff9f17d8d894ed8a450d0
Gitweb:        https://git.kernel.org/tip/16817ad7e8b31728b44ff9f17d8d894ed8a450d0
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 08 Sep 2022 14:41:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Sep 2022 15:03:22 +02:00

perf/bpf: Always use perf callchains if exist

If the perf_event has PERF_SAMPLE_CALLCHAIN, BPF can use it for stack trace.
The problematic cases like PEBS and IBS already handled in the PMU driver and
they filled the callchain info in the sample data.  For others, we can call
perf_callchain() before the BPF handler.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220908214104.3851807-2-namhyung@kernel.org
---
 kernel/bpf/stackmap.c |  4 ++--
 kernel/events/core.c  | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 1adbe67..aecea74 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -338,7 +338,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	int ret;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
-	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
 		return bpf_get_stackid((unsigned long)(ctx->regs),
 				       (unsigned long) map, flags, 0, 0);
 
@@ -506,7 +506,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	int err = -EINVAL;
 	__u64 nr_kernel;
 
-	if (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
 		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags);
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c98ecf3..7da5515 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10000,8 +10000,16 @@ static void bpf_overflow_handler(struct perf_event *event,
 		goto out;
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
-	if (prog)
+	if (prog) {
+		if (prog->call_get_stack &&
+		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
+			data->callchain = perf_callchain(event, regs);
+			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+		}
+
 		ret = bpf_prog_run(prog, &ctx);
+	}
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
@@ -10027,7 +10035,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	if (event->attr.precise_ip &&
 	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY) ||
+	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
 	     event->attr.exclude_callchain_kernel ||
 	     event->attr.exclude_callchain_user)) {
 		/*
