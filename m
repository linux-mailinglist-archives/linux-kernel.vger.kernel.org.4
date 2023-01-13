Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892CC66973C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjAMMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjAMMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5BC544EE;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8W9VgYMwyJ7o4FzoZE/YYmq/7I6X546PhnibH4LBLo=;
        b=m0HCAdQCEguf39lX/MGQfnfRWoMNK0ICTOKHQZAQUnH2VqP8LlvrSqPWLjQ1w2k/I31LRR
        9dkvUHO5BJa8VggIjfHZUGz1EyfThQ0FgntW2ucggDYQDqpQMVycMG198b5aI/m0a8R7vu
        /XAkGYdgMbKUSP0sqLTSPhSm97AGExYV/3CsAmjHplDlyKIJFHdTVSnmTDUGYHhsF7fmNK
        XuevKCupsE4yAtiGeXcqHJxObIN/w6evK0WqWd5ZNnpb6RCIOSX5PXktppvElLUIaGy24J
        7tizgovXswWSUhb9QwLnlalVcp8zyrw3EjbbCz01XzZlp1K8AQJKX7TnJeTH4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8W9VgYMwyJ7o4FzoZE/YYmq/7I6X546PhnibH4LBLo=;
        b=aKpAhI/T5TfpUch7Vq4NlaPGb7hVn/5PuqEs6HkX4puiYiiQMIMcLA7PzgSsm8NBWdSFuA
        An4nlLZp+Ht9FGBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] tracing: WARN on rcuidle
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.416110581@infradead.org>
References: <20230112195541.416110581@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306830.4906.9126654515923168078.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     408b961146be4c1a776ce285c3c289afab15298a
Gitweb:        https://git.kernel.org/tip/408b961146be4c1a776ce285c3c289afab15298a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:48 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

tracing: WARN on rcuidle

ARCH_WANTS_NO_INSTR (a superset of CONFIG_GENERIC_ENTRY) disallows any
and all tracing when RCU isn't enabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.416110581@infradead.org
---
 include/linux/tracepoint.h | 15 +++++++++++++--
 kernel/trace/trace.c       |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 4b33b95..552f80b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -178,6 +178,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
+ * ARCH_WANTS_NO_INSTR archs are expected to have sanitized entry and idle
+ * code that disallow any/all tracing/instrumentation when RCU isn't watching.
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define RCUIDLE_COND(rcuidle)	(rcuidle)
+#else
+/* srcu can't be used from NMI */
+#define RCUIDLE_COND(rcuidle)	(rcuidle && in_nmi())
+#endif
+
+/*
  * it_func[0] is never NULL because there is at least one element in the array
  * when the array itself is non NULL.
  */
@@ -188,8 +199,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (!(cond))						\
 			return;						\
 									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
+		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
+			return;						\
 									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a555a86..54ec159 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3128,6 +3128,9 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 		return;
 	}
 
+	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_GENERIC_ENTRY)))
+		return;
+
 	/*
 	 * When an NMI triggers, RCU is enabled via ct_nmi_enter(),
 	 * but if the above rcu_is_watching() failed, then the NMI
