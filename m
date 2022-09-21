Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAF5E53E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIUTiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIUTiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:38:02 -0400
Received: from barracuda.ebox.ca (barracuda.ebox.ca [96.127.255.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ED59E2D9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:37:59 -0700 (PDT)
X-ASG-Debug-ID: 1663788304-0c856e13fd3500b0001-xx1T2L
Received: from smtp.ebox.ca (smtp.ebox.ca [96.127.255.82]) by barracuda.ebox.ca with ESMTP id aZdMqmgKmcu83HdZ (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Wed, 21 Sep 2022 15:25:04 -0400 (EDT)
X-Barracuda-Envelope-From: mathieu.desnoyers@efficios.com
X-Barracuda-RBL-Trusted-Forwarder: 96.127.255.82
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtp.ebox.ca (Postfix) with ESMTP id CC0C5441D66;
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
Subject: [RFC PATCH v4 03/25] rseq: Extend struct rseq with numa node id
Date:   Wed, 21 Sep 2022 15:24:32 -0400
X-ASG-Orig-Subj: [RFC PATCH v4 03/25] rseq: Extend struct rseq with numa node id
Message-Id: <20220921192454.231662-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
References: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: smtp.ebox.ca[96.127.255.82]
X-Barracuda-Start-Time: 1663788304
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://96.127.255.19:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at ebox.ca
X-Barracuda-Scan-Msg-Size: 4206
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
---
 include/trace/events/rseq.h |  4 +++-
 include/uapi/linux/rseq.h   |  8 ++++++++
 kernel/rseq.c               | 19 +++++++++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index a04a64bc1a00..6bd442697354 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
 
 	TP_STRUCT__entry(
 		__field(s32, cpu_id)
+		__field(s32, node_id)
 	),
 
 	TP_fast_assign(
 		__entry->cpu_id = raw_smp_processor_id();
+		__entry->node_id = cpu_to_node(raw_smp_processor_id());
 	),
 
-	TP_printk("cpu_id=%d", __entry->cpu_id)
+	TP_printk("cpu_id=%d node_id=%d", __entry->cpu_id, __entry->node_id)
 );
 
 TRACE_EVENT(rseq_ip_fixup,
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 05d3c4cdeb40..1cb90a435c5c 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -131,6 +131,14 @@ struct rseq {
 	 */
 	__u32 flags;
 
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
+	 */
+	__u32 node_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 46dc5c2ce2b7..cb7d8a5afc82 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -84,15 +84,17 @@
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
@@ -108,9 +110,9 @@ static int rseq_update_cpu_id(struct task_struct *t)
 	return -EFAULT;
 }
 
-static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -124,6 +126,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	 */
 	if (put_user(cpu_id, &t->rseq->cpu_id))
 		return -EFAULT;
+	/*
+	 * Reset node_id to its initial state (0).
+	 */
+	if (put_user(node_id, &t->rseq->node_id))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -306,7 +313,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_id(t)))
+	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
 	return;
 
@@ -353,7 +360,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 			return -EINVAL;
 		if (current->rseq_sig != sig)
 			return -EPERM;
-		ret = rseq_reset_rseq_cpu_id(current);
+		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
 		current->rseq = NULL;
-- 
2.25.1

