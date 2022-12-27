Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16857656AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiL0MQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiL0MOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F253F41;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tcy8KIO8gQc9Kc01ifmjA4/hjm9ajuh+8clk09xwYCU=;
        b=P35BcO47ib9k3WiOWGbnVxNGO1OLZt/t3+QbTsylmwEp8FQPPUVjJ3Yi6JD5LM8rSKyCkJ
        79ffDf2g6SKYie+LWtSTo+GMLaNMohVtwPl9jc3FbRrQj5oyJ0A78iQWqidmohJW3XbMk6
        lzK/RKBhqflnRBrWdJ9Stn0JbCGiKrsQ9atQKkkdrzaVEr+yQU1izdbN/B1ASe0LcQjLwI
        LzC6ZHPg8A1FpR/pddGw1eJB4jDgc1EgBjMfD8HOLSFFc+J68n/28HQ2DnxRd7h5Z6s+Lf
        miQ3sSANWw0IG8ygL/YfMlPhPpdnfa0jYxyYULyRCX3pj/OxeT41IwTliN8XxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tcy8KIO8gQc9Kc01ifmjA4/hjm9ajuh+8clk09xwYCU=;
        b=SyBSHE3N8Sg70B+IPJewN06/9kwkfL/6Rh/9xTLWt48qcOozT6eicnakrZ93YrKQrZCzu0
        pEZ/bEXQxY7tNBBg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Extend struct rseq with numa node id
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-5-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-5-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323227.4906.16721070982383036641.tip-bot2@tip-bot2>
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

Commit-ID:     cbae6bac29a8c5cf2f1cb5c6bce35af00cec164b
Gitweb:        https://git.kernel.org/tip/cbae6bac29a8c5cf2f1cb5c6bce35af00cec164b
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:06 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:10 +01:00

rseq: Extend struct rseq with numa node id

Adding the NUMA node id to struct rseq is a straightforward thing to do,
and a good way to figure out if anything in the user-space ecosystem
prevents extending struct rseq.

This NUMA node id field allows memory allocators such as tcmalloc to
take advantage of fast access to the current NUMA node id to perform
NUMA-aware memory allocation.

It can also be useful for implementing fast-paths for NUMA-aware
user-space mutexes.

It also allows implementing getcpu(2) purely in user-space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-5-mathieu.desnoyers@efficios.com
---
 include/trace/events/rseq.h |  4 +++-
 include/uapi/linux/rseq.h   |  8 ++++++++
 kernel/rseq.c               | 19 +++++++++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index a04a64b..dde7a35 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
 
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
+		__field(s32, node_id)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
+		__entry->node_id = cpu_to_node(__entry->cpu_id);
 	),
 
-	TP_printk("cpu_id=%d", __entry->cpu_id)
+	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 05d3c4c..1cb90a4 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -132,6 +132,14 @@ struct rseq {
 	__u32 flags;
 
 	/*
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
+	 */
+	__u32 node_id;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 7962738..193cfcc 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -85,15 +85,17 @@
  *   F1. <failure>
  */
 
-static int rseq_update_cpu_id(struct task_struct *t)
+static int rseq_update_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id = raw_smp_processor_id();
 	struct rseq __user *rseq = t->rseq;
+	u32 cpu_id = raw_smp_processor_id();
+	u32 node_id = cpu_to_node(cpu_id);
 
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
+	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -109,9 +111,9 @@ efault:
 	return -EFAULT;
 }
 
-static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -126,6 +128,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
 	/*
+	 * Reset node_id to its initial state (0).
+	 */
+	if (put_user(node_id, &t->rseq->node_id))
+		return -EFAULT;
+	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
@@ -314,7 +321,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_id(t)))
+	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
 
@@ -361,7 +368,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
-		ret = rseq_reset_rseq_cpu_id(current);
+		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
 		current->rseq = NULL;
