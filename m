Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72B4656AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiL0MQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiL0MOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6A2639;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DAL5Q5nrFxihn+kbgAp72qNEoYjdUKlz1xuabz9lMA=;
        b=s2tSbRif1KWaLprm8ZbDNPD/DQPr+1tdZM6ShFz1h2reXcQ8zQRRiWs4jEYbbnblOnPLIC
        uODZwTJ15XKzIl8He62mqVSb2gYF7yoEYkH+B3mZ/X/SU2zzxox2MECQ/maDUt8/0GEEz+
        lkc2JGj+1b21DrrcxdVTxNzOmlgjNTPoZb6irrWLwE21YFPLKym+an+FMMrMBhc8rwB5F4
        yH15rs3aptkHGdXDmuJ9C5/yn2zp3tqh179lO6NoPfZm0+AnOwbAPzpTmZpUeUH96OQjrj
        3Du14o/97HqpUPJ3oFyGvM+FS9ttnTg/9cNErioQuy455iL5E88eeDtQ07OU4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DAL5Q5nrFxihn+kbgAp72qNEoYjdUKlz1xuabz9lMA=;
        b=izSLIbKw3EFdqe2gMFAOKBQzUROnaMMpPuQcKjg5MiykZDAocdM3w/zOfIF0jxy6VUgxaC
        RVWbCABbrszxdBDg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Introduce extensible rseq ABI
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-4-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323246.4906.2743738647026767672.tip-bot2@tip-bot2>
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

Commit-ID:     ee3e3ac05c2631ce1f12d88c9cc9a092f8fe947a
Gitweb:        https://git.kernel.org/tip/ee3e3ac05c2631ce1f12d88c9cc9a092f8fe947a
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:05 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:10 +01:00

rseq: Introduce extensible rseq ABI

Introduce the extensible rseq ABI, where the feature size supported by
the kernel and the required alignment are communicated to user-space
through ELF auxiliary vectors.

This allows user-space to call rseq registration with a rseq_len of
either 32 bytes for the original struct rseq size (which includes
padding), or larger.

If rseq_len is larger than 32 bytes, then it must be large enough to
contain the feature size communicated to user-space through ELF
auxiliary vectors.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-4-mathieu.desnoyers@efficios.com
---
 include/linux/sched.h |  4 ++++
 kernel/ptrace.c       |  2 +-
 kernel/rseq.c         | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f..e0bc020 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1302,6 +1302,7 @@ struct task_struct {
 
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
+	u32 rseq_len;
 	u32 rseq_sig;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
@@ -2352,10 +2353,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
 	if (clone_flags & CLONE_VM) {
 		t->rseq = NULL;
+		t->rseq_len = 0;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
 	} else {
 		t->rseq = current->rseq;
+		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
 	}
@@ -2364,6 +2367,7 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 	t->rseq = NULL;
+	t->rseq_len = 0;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
 }
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 5448219..0786450 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -813,7 +813,7 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 {
 	struct ptrace_rseq_configuration conf = {
 		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
-		.rseq_abi_size = sizeof(*task->rseq),
+		.rseq_abi_size = task->rseq_len,
 		.signature = task->rseq_sig,
 		.flags = 0,
 	};
diff --git a/kernel/rseq.c b/kernel/rseq.c
index d38ab94..7962738 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -18,6 +18,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
+/* The original rseq structure size (including padding) is 32 bytes. */
+#define ORIG_RSEQ_SIZE		32
+
 #define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
@@ -87,10 +90,15 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
 
-	if (!user_write_access_begin(rseq, sizeof(*rseq)))
+	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	/*
+	 * Additional feature fields added after ORIG_RSEQ_SIZE
+	 * need to be conditionally updated only if
+	 * t->rseq_len != ORIG_RSEQ_SIZE.
+	 */
 	user_write_access_end();
 	trace_rseq_update(t);
 	return 0;
@@ -117,6 +125,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	 */
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
+	/*
+	 * Additional feature fields added after ORIG_RSEQ_SIZE
+	 * need to be conditionally reset only if
+	 * t->rseq_len != ORIG_RSEQ_SIZE.
+	 */
 	return 0;
 }
 
@@ -344,7 +357,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
+		if (rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -353,6 +366,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		current->rseq_len = 0;
 		return 0;
 	}
 
@@ -365,7 +379,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -374,15 +388,24 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	}
 
 	/*
-	 * If there was no rseq previously registered,
-	 * ensure the provided rseq is properly aligned and valid.
+	 * If there was no rseq previously registered, ensure the provided rseq
+	 * is properly aligned, as communcated to user-space through the ELF
+	 * auxiliary vector AT_RSEQ_ALIGN. If rseq_len is the original rseq
+	 * size, the required alignment is the original struct rseq alignment.
+	 *
+	 * In order to be valid, rseq_len is either the original rseq size, or
+	 * large enough to contain all supported fields, as communicated to
+	 * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
 	 */
-	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
-	    rseq_len != sizeof(*rseq))
+	if (rseq_len < ORIG_RSEQ_SIZE ||
+	    (rseq_len == ORIG_RSEQ_SIZE && !IS_ALIGNED((unsigned long)rseq, ORIG_RSEQ_SIZE)) ||
+	    (rseq_len != ORIG_RSEQ_SIZE && (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
+					    rseq_len < offsetof(struct rseq, end))))
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 	current->rseq = rseq;
+	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
 	/*
 	 * If rseq was previously inactive, and has just been
