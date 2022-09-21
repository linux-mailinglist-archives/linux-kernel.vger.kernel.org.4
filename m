Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F15E53E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIUTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIUTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:38:03 -0400
Received: from barracuda.ebox.ca (barracuda.ebox.ca [96.127.255.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F19E2F3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:38:02 -0700 (PDT)
X-ASG-Debug-ID: 1663788303-0c856e13ff3500f0001-xx1T2L
Received: from smtp.ebox.ca (smtp.ebox.ca [96.127.255.82]) by barracuda.ebox.ca with ESMTP id dWGOOsuXIiGKUJdF (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Wed, 21 Sep 2022 15:25:03 -0400 (EDT)
X-Barracuda-Envelope-From: mathieu.desnoyers@efficios.com
X-Barracuda-RBL-Trusted-Forwarder: 96.127.255.82
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtp.ebox.ca (Postfix) with ESMTP id 8EBC3441D65;
        Wed, 21 Sep 2022 15:25:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Barracuda-RBL-IP: 192.222.180.24
X-Barracuda-Effective-Source-IP: 192-222-180-24.qc.cable.ebox.net[192.222.180.24]
X-Barracuda-Apparent-Source-IP: 192.222.180.24
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v4 02/25] rseq: Introduce extensible rseq ABI
Date:   Wed, 21 Sep 2022 15:24:31 -0400
X-ASG-Orig-Subj: [RFC PATCH v4 02/25] rseq: Introduce extensible rseq ABI
Message-Id: <20220921192454.231662-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
References: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: smtp.ebox.ca[96.127.255.82]
X-Barracuda-Start-Time: 1663788303
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://96.127.255.19:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ebox.ca
X-Barracuda-Scan-Msg-Size: 5596
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.100943
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
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
 include/linux/sched.h |  4 ++++
 kernel/ptrace.c       |  2 +-
 kernel/rseq.c         | 33 +++++++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..6a80ce113d0e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1291,6 +1291,7 @@ struct task_struct {
 
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
+	u32 rseq_len;
 	u32 rseq_sig;
 	/*
 	 * RmW on rseq_event_mask must be performed atomically
@@ -2324,10 +2325,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
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
@@ -2336,6 +2339,7 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 static inline void rseq_execve(struct task_struct *t)
 {
 	t->rseq = NULL;
+	t->rseq_len = 0;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
 }
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 1893d909e45c..90de1ea51088 100644
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
index 97ac20b4f738..46dc5c2ce2b7 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -18,6 +18,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
+/* The original rseq structure size (including padding) is 32 bytes. */
+#define ORIG_RSEQ_SIZE		32
+
 #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
 				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
 
@@ -86,10 +89,15 @@ static int rseq_update_cpu_id(struct task_struct *t)
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
@@ -116,6 +124,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
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
 
@@ -336,7 +349,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
+		if (rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -345,6 +358,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return ret;
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		current->rseq_len = 0;
 		return 0;
 	}
 
@@ -357,7 +371,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		 * the provided address differs from the prior
 		 * one.
 		 */
-		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
+		if (current->rseq != rseq || rseq_len != current->rseq_len)
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
@@ -366,15 +380,22 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	}
 
 	/*
-	 * If there was no rseq previously registered,
-	 * ensure the provided rseq is properly aligned and valid.
+	 * If there was no rseq previously registered, ensure the provided rseq
+	 * is properly aligned, as communcated to user-space through the ELF
+	 * auxiliary vector AT_RSEQ_ALIGN.
+	 *
+	 * In order to be valid, rseq_len is either the original rseq size, or
+	 * large enough to contain all supported fields, as communicated to
+	 * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
 	 */
 	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
-	    rseq_len != sizeof(*rseq))
+	    rseq_len < ORIG_RSEQ_SIZE ||
+	    (rseq_len != ORIG_RSEQ_SIZE && rseq_len < offsetof(struct rseq, end)))
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

