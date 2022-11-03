Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108A61894A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiKCUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiKCUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:00 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354212035F;
        Thu,  3 Nov 2022 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505898;
        bh=m+9Uyu/8dIKQx29uw36+nk66J6rIL4EwiN+rQ3z02SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVb/UGc8ovwrhb2uKOvg5SMZa60UJJPtHjxz1GhTLyJ6Kq8Bhj8QyScMpH7C7dZek
         4PqILDGfQBA22s45boDaYACw1U/NiKIMzPP378IPXK3sW+KhmnH5phKqwuXQvTJx+E
         2Ae5Sacljn3Ee2qhj04jgemGeiFNFhokatsWTuUFxXLDt0+53iBWfdfRNp6sVGwvwe
         lp11tyhtXvdLwvnnC5aA7/TfmtthoozJDAUKqZB6VPQaYE0W0yh9Ms0jqKfB+7UzCN
         DCY9FPEZGW8WVGEIK1ZbqPe1cg0WInnPHcAUDzBUCSMYw6NmrOdeaqc8JQ0lK6SWMj
         Jwllk2W8OOa/w==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F961sHdzfjV;
        Thu,  3 Nov 2022 16:04:58 -0400 (EDT)
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
Subject: [PATCH v5 09/24] rseq: Extend struct rseq with per memory space vcpu id
Date:   Thu,  3 Nov 2022 16:03:44 -0400
Message-Id: <20221103200359.328736-10-mathieu.desnoyers@efficios.com>
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

If a memory space has fewer threads than cores, or is limited to run on
few cores concurrently through sched affinity or cgroup cpusets, the
virtual cpu ids will be values close to 0, thus allowing efficient use
of user-space memory for per-cpu data structures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/uapi/linux/rseq.h |  9 +++++++++
 kernel/rseq.c             | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 1cb90a435c5c..77a136586ac6 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -139,6 +139,15 @@ struct rseq {
 	 */
 	__u32 node_id;
 
+	/*
+	 * Restartable sequences vm_vcpu_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's virtual CPU ID
+	 * (allocated uniquely within a memory space).
+	 */
+	__u32 vm_vcpu_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index e21ad8929958..604c284a355c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -90,12 +90,15 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
+	u32 vm_vcpu_id = task_mm_vcpu_id(t);
 
+	WARN_ON_ONCE((int) vm_vcpu_id < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
 	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
+	unsafe_put_user(vm_vcpu_id, &rseq->vm_vcpu_id, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -113,7 +116,8 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
+	    vm_vcpu_id = 0;
 
 	/*
 	 * Reset cpu_id_start to its initial state (0).
@@ -132,6 +136,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(node_id, &t->rseq->node_id))
 		return -EFAULT;
+	/*
+	 * Reset vm_vcpu_id to its initial state (0).
+	 */
+	if (put_user(vm_vcpu_id, &t->rseq->vm_vcpu_id))
+		return -EFAULT;
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
-- 
2.25.1

