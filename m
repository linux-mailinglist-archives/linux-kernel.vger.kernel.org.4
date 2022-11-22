Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034A63487B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiKVUkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiKVUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:52 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C26B226;
        Tue, 22 Nov 2022 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149587;
        bh=JDPm4e63VjlqNVUfq2Us1ERrgPE08F0+xxt5hQ6MHmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GU4jsJA1aW/Pku/92SEKE2NunFRMrGbfJIsO1D+dT/p3eHVbnidUAjLOsCUjJf+Ua
         sReJwdr90pruQ+ZVbM3UmAFRuHvyF2dbFUOzq6reE8cxfVbf52gXmOJl7GNuALu7qe
         LoMdECMQjtr7zVqAmACXB9gv+zhcZRmqobb7m2oDNmWBZvzBKystmdxRQS6L3QwJ8c
         O8hc5cPsDaoxJ6dKwgT6AyBUWq6GGGzZ4J19CFnloUCCI+PVRz39GOm5Rwnd+5USyb
         klEzc9w75PI1I/3O7PmHubIXr6o/xdzl7COEHj6EcCCd436ya+PERm1ALHfug/5KhB
         ZAoGHiEDw8e2g==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2W2rswzXZd;
        Tue, 22 Nov 2022 15:39:47 -0500 (EST)
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
Subject: [PATCH 08/30] rseq: Extend struct rseq with per-memory-map concurrency ID
Date:   Tue, 22 Nov 2022 15:39:10 -0500
Message-Id: <20221122203932.231377-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
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

If a memory map has fewer threads than there are cores on the system, or
is limited to run on few cores concurrently through sched affinity or
cgroup cpusets, the concurrency IDs will be values close to 0, thus
allowing efficient use of user-space memory for per-cpu data structures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/uapi/linux/rseq.h |  9 +++++++++
 kernel/rseq.c             | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 1cb90a435c5c..c233aae5eac9 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -139,6 +139,15 @@ struct rseq {
 	 */
 	__u32 node_id;
 
+	/*
+	 * Restartable sequences mm_cid field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's concurrency ID
+	 * (allocated uniquely within a memory map).
+	 */
+	__u32 mm_cid;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index e21ad8929958..cb2512ab3256 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -90,12 +90,15 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
+	u32 mm_cid = task_mm_cid(t);
 
+	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
+	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -113,7 +116,8 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
+	    mm_cid = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -132,6 +136,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(node_id, &t->rseq->node_id))
 		return -EFAULT;
+	/*
+	 * Reset mm_cid to its initial state (0).
+	 */
+	if (put_user(mm_cid, &t->rseq->mm_cid))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
-- 
2.25.1

