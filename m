Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F3656ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiL0MQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiL0MOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4266EAE;
        Tue, 27 Dec 2022 04:13:54 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TfBq1x+gmsL+8qg80jLPOcg/ef3xJeXazRbhO7StmM=;
        b=fyut8b7hlECCqetXG4gH18U8HS1PzXnk8zsUB3ApQHBWvS6Q1HOvIpal4ppxt0L751M8R3
        vKaV0nauFevnayLZ3pE4FQ7UMEOFIXyr8Bg3b72lwPt1K6YHK7Rje/euMBiWRm5/OVcGFL
        iv27S3ihbZVXtMSK6f4Ru55ihe+x/LwPLc55frpNAnbo7Ovl8ZKVdm7KHi2vX5kqjylBZk
        PojxURW2tZW+FDYb4sTv9NFgL6QHXi39g2s3eXUdhfxsFJwa14z8mKE6Gl17Nm1t27PqoW
        WtKn9jY/bEjh/QouXrqFMJzd7HU4Co5QxbeS4VTp5I2J7phLv6xqio6yCekaNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TfBq1x+gmsL+8qg80jLPOcg/ef3xJeXazRbhO7StmM=;
        b=CsEYAFFfSvgXgtrNMbZxGmy332oX4TgjxrEz+Z506drVyxPcp/zik9iYLfWJgeL4Mc73yb
        0Q8D8aArYixO0NCQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Extend struct rseq with per-memory-map concurrency ID
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-9-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-9-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323153.4906.14464853919693066880.tip-bot2@tip-bot2>
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

Commit-ID:     f7b01bb0b57f994a44ea6368536b59062b796381
Gitweb:        https://git.kernel.org/tip/f7b01bb0b57f994a44ea6368536b59062b796381
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:10 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:12 +01:00

rseq: Extend struct rseq with per-memory-map concurrency ID

If a memory map has fewer threads than there are cores on the system, or
is limited to run on few cores concurrently through sched affinity or
cgroup cpusets, the concurrency IDs will be values close to 0, thus
allowing efficient use of user-space memory for per-cpu data structures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-9-mathieu.desnoyers@efficios.com
---
 include/uapi/linux/rseq.h |  9 +++++++++
 kernel/rseq.c             | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 1cb90a4..c233aae 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -140,6 +140,15 @@ struct rseq {
 	__u32 node_id;
 
 	/*
+	 * Restartable sequences mm_cid field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's concurrency ID
+	 * (allocated uniquely within a memory map).
+	 */
+	__u32 mm_cid;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 193cfcc..9de6e35 100644
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
@@ -113,7 +116,8 @@ efault:
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
+	    mm_cid = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -133,6 +137,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	if (put_user(node_id, &t->rseq->node_id))
 		return -EFAULT;
 	/*
+	 * Reset mm_cid to its initial state (0).
+	 */
+	if (put_user(mm_cid, &t->rseq->mm_cid))
+		return -EFAULT;
+	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
