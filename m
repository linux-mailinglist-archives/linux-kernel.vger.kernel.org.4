Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23C0671BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjARMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjARMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69E875BB;
        Wed, 18 Jan 2023 03:37:53 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVrowPVlkqAmIujgyVf+EEgLijVC+lYFOBUR5Zwa8wE=;
        b=LaAR433FVGITqKJYmekkmjNcvfI1S71MLXcc0nSYe0NW8cqHld8YGIkiG607o00+p6eEL8
        FbBFc3mUqwy98e5YmUZUbKzYh73QBLr+TpGlRd+8mfWYWUOtbobnvxcFfSKXiKiUtxMk9+
        OZ0cGKIUp1KxZEZQmqnN/TaSAeVZo7VTUpNmO51eC998Pn9oLsiQfNs8QJUYXXpDjX5uAU
        CioCQZw4+cd7rBlmAK0CF+9qJSEK2m56UKmXzjs2prnqgrggqPRXROAO4LfjzJ1ZvtgS7+
        bscJC5coz/JPO+lefgf3HPUH1UIjiE52/DTt0vGuHCChX2Z9ciqdQUJqeMVskw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVrowPVlkqAmIujgyVf+EEgLijVC+lYFOBUR5Zwa8wE=;
        b=SaVgS1kwa/S5KKkZJ9k8sNxMjkq1dfcRrEV4CQ8I7l2B2pITrGVv1lmEzF25Es3BfIDe4/
        zZZPwhKSh8XAbVCA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Call perf_prepare_sample() before running BPF
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118060559.615653-9-namhyung@kernel.org>
References: <20230118060559.615653-9-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167404187070.4906.11315546110666794035.tip-bot2@tip-bot2>
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

Commit-ID:     0eed28220598cd990d094b7b9f8c832c425080c0
Gitweb:        https://git.kernel.org/tip/0eed28220598cd990d094b7b9f8c832c425080c0
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 17 Jan 2023 22:05:59 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 11:57:21 +01:00

perf/core: Call perf_prepare_sample() before running BPF

As BPF can access sample data, it needs to populate the data.  Also
remove the logic to get the callchain specifically as it's covered by
the perf_prepare_sample() now.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230118060559.615653-9-namhyung@kernel.org
---
 kernel/events/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4aa73ed..380476a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10356,13 +10356,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_lock();
 	prog = READ_ONCE(event->prog);
 	if (prog) {
-		if (prog->call_get_stack &&
-		    (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
-		    !(data->sample_flags & PERF_SAMPLE_CALLCHAIN)) {
-			data->callchain = perf_callchain(event, regs);
-			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
-		}
-
+		perf_prepare_sample(data, event, regs);
 		ret = bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
