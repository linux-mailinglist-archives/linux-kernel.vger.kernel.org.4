Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048026348A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiKVUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiKVUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:40:22 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9EA7721A;
        Tue, 22 Nov 2022 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149595;
        bh=RT5zTNt+b0dcxGolKxL6wWKrezXmEB7dqcTheMOw884=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujG03NqI1iqdY873NCE8qMSNYp+S7TvN7gPDH9xMjAKgZG0HHocfuyjQFJKyJQczV
         QdRCwTfba90an/tkqpcLObr9pDFP4+kXLzrKqSgXPafh6kKjq0Ib1bBXTt//Zo2+AL
         ai+/d95qVuXlJ9lmksS1AvY3iyPamfvI2zFBpOND5mZX9kkKkPAHycGC2WXrDg4WAK
         DmZdSP1rhyuXAOA9F2v8n8QSYaDscDAdfy7GSTTFt7kT1kD67CT54HmA5eJTBlCnsV
         JDGW8CdEXCzjXxsCASQH5AzAqFV1P2MfGQAp9RZiQw54JWbS/QZJt9UKqgWliUJNvj
         BoN02AJN98SOQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2f5MY3zXJc;
        Tue, 22 Nov 2022 15:39:54 -0500 (EST)
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
Subject: [PATCH 25/30] rseq: Extend struct rseq with per-memory-map NUMA-aware Concurrency ID
Date:   Tue, 22 Nov 2022 15:39:27 -0500
Message-Id: <20221122203932.231377-26-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a per-memory-map NUMA-aware concurrency ID to userspace. Each
concurrency ID stays associated with the same NUMA node except in case
of NUMA topology reconfiguration.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/uapi/linux/rseq.h |  9 +++++++++
 kernel/rseq.c             | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..5779249ed37f 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -148,6 +148,15 @@ struct rseq {
 	 */
 	__u32 mm_cid;
 
+	/*
+	 * Restartable sequences mm_numa_cid field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This field
+	 * should only be read by the thread which registered this data
+	 * structure.  Aligned on 32-bit. Contains the current thread's
+	 * NUMA-aware concurrency ID (allocated uniquely within a memory map).
+	 */
+	__u32 mm_numa_cid;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index cb2512ab3256..58b09de0de47 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -91,14 +91,17 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
+	u32 mm_numa_cid = task_mm_numa_cid(t);
 
 	WARN_ON_ONCE((int) mm_cid < 0);
+	WARN_ON_ONCE((int) mm_numa_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
+	unsafe_put_user(mm_numa_cid, &rseq->mm_numa_cid, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -117,7 +120,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
-	    mm_cid = 0;
+	    mm_cid = 0, mm_numa_cid = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -141,6 +144,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(mm_cid, &t->rseq->mm_cid))
 		return -EFAULT;
+	/*
+	 * Reset mm_numa_cid to its initial state (0).
+	 */
+	if (put_user(mm_numa_cid, &t->rseq->mm_numa_cid))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
-- 
2.25.1

