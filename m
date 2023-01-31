Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840FA682F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAaOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAaOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405614229;
        Tue, 31 Jan 2023 06:22:30 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmgUg3DQLqg4fvnfMUqWBH4m/OU8I4dYexk9IZKQyec=;
        b=qIOMTmIYf9c9AiitJnmIkJA5TaLBIE23Gy9Qq5Hc8kdjzM7TxwZ9Yhdl1nJB0tLmuSe59J
        ZsJQcFjjgpVst3REbAQ8XsI3rSAF7cC56eO1jyn6hYLscKY4qYHgeBUlzHaSwH9mke8f55
        0isr5gRhxxr7SwlP0O6As1+m9DKkXCDg4pNVD4lakgivHb+VBHHlAVBsLRFxHNMiqgkaDy
        d+xLvwlK2Yal6sMPozyhGQNEnsfiT+LoDE0fKJrO4aXfIbD6/zv6uy+qiXwfpeInJLKbBd
        dbOTFPCUU19eZRXgnYmKhtLzAKHBeuadkkzUsWMBa9Ik4CYEWUoynpdN0PbUmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmgUg3DQLqg4fvnfMUqWBH4m/OU8I4dYexk9IZKQyec=;
        b=r2hCytEd9n7Q7ejywZk8dVZ6acVWs3fgJTwpMsUq8v7Us3hTtAsM98DN6vj7W5LjASg+sY
        th/o67KJU1ErrhCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: tracing: Warn about !rcu_is_watching()
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126151323.466670589@infradead.org>
References: <20230126151323.466670589@infradead.org>
MIME-Version: 1.0
Message-ID: <167517494816.4906.10276554313364667528.tip-bot2@tip-bot2>
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

Commit-ID:     d099dbfd330686a8c09cd8944bcc77a56f9e7815
Gitweb:        https://git.kernel.org/tip/d099dbfd330686a8c09cd8944bcc77a56f9e7815
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Jan 2023 16:08:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:46 +01:00

cpuidle: tracing: Warn about !rcu_is_watching()

When using noinstr, WARN when tracing hits when RCU is disabled.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126151323.466670589@infradead.org
---
 include/linux/trace_recursion.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index c303f7a..d48cd92 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -135,6 +135,21 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+# define trace_warn_on_no_rcu(ip)					\
+	({								\
+		bool __ret = !rcu_is_watching();			\
+		if (__ret && !trace_recursion_test(TRACE_RECORD_RECURSION_BIT)) { \
+			trace_recursion_set(TRACE_RECORD_RECURSION_BIT); \
+			WARN_ONCE(true, "RCU not on for: %pS\n", (void *)ip); \
+			trace_recursion_clear(TRACE_RECORD_RECURSION_BIT); \
+		}							\
+		__ret;							\
+	})
+#else
+# define trace_warn_on_no_rcu(ip)	false
+#endif
+
 /*
  * Preemption is promised to be disabled when return bit >= 0.
  */
@@ -144,6 +159,9 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	unsigned int val = READ_ONCE(current->trace_recursion);
 	int bit;
 
+	if (trace_warn_on_no_rcu(ip))
+		return -1;
+
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*
