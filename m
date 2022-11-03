Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618861892D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiKCUFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKCUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:04:58 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F322034F;
        Thu,  3 Nov 2022 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505895;
        bh=ay4/Rf8ACqyHamy6OVpRQ1uU4XWlbJihVMLu/JPLDYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFfdTSqTL0CXFep4seNFt5uqS7tuLbMjymhPawZQYH+5vjIieClLIDQhrdQ1/9mEb
         l100HePItu8uMJN0rWPT3aENyhM+lY1Iq3mGnGqdSxCnRC/1UH8PFcf3pcq3mtnVYR
         onpVYx75rHX5+MOA9fpgULLKxZFeDa3jNWpbFJv1aKRKmSFzVkcvISP7tL+V8fDSzZ
         q/HyKrv8SLjzCRMF2YqMac47tcA1n3P/j914WxX2LCIHMJgv6I+5TEikpQupwh3vJb
         jEmz6xmY7XF+dH1JAhdifBR8NQMv5j1CHAJRdiNt+EJWQo7dsKwgJoyMgDzvTzrxq/
         8vWwbLc1RPYZw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F934pkszg4j;
        Thu,  3 Nov 2022 16:04:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v5 02/24] rseq: Introduce extensible rseq ABI
Date:   Thu,  3 Nov 2022 16:03:37 -0400
Message-Id: <20221103200359.328736-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes since v4:
- Accept original rseq alignment for original rseq size.
---
 include/linux/sched.h |  4 ++++
 kernel/ptrace.c       |  2 +-
 kernel/rseq.c         | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 23de7fe86cc4..2a9e14e3e668 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1305,6 +1305,7 @@ struct task_struct {
 
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
+	u32 rseq_len;
 	u32 rseq_sig;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
@@ -2355,10 +2356,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
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
@@ -2367,6 +2370,7 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 	t->rseq = NULL;
+	t->rseq_len = 0;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
 }
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..0786450074c1 100644
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
index bda8175f8f99..c1058b3f10ac 100644
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
 
@@ -329,7 +342,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
+		if (rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -338,6 +351,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		current->rseq_len = 0;
 		return 0;
 	}
 
@@ -350,7 +364,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -359,15 +373,24 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
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
-- 
2.25.1

