Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE7714F93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjE2TOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:14:27 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD471D2;
        Mon, 29 May 2023 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685387663;
        bh=E7Q4JmbMKWpqkjo72GLBkCxs4FPIIvyJtEspj5idB/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iA6sYhg7uvaIe/pCwyzk1Z6fglq2EMj8blDu8+QNsIltbH5xaQX/PGLCvJztR9ZbW
         3HOWzbbek+f7mpT0kHnTz1jpLJSxd6TY3uMCaFNhJ1pLOPahcBAuk+nOo/+JrcdRhW
         Ic9FqDxpWxoZrdnpTmeJq+Sgkf1w8kwF+4hgKg/jyizLs34BqBCvDt9/3hapA/GmhU
         L6FspGdPOmUDPEauUIV5OK/A+5H5r3vT3xGfLLeop603Y2o0gPIWR+rtKR7TJC65r8
         FIu6g/GOEpmf5c15Nz56T3ebqj1llXL6QdOsCG32aMGEHZK0yyR4rT5bK9sVr9fxvE
         YxEC05Z+gihjQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVQFB4ZFyz165P;
        Mon, 29 May 2023 15:14:22 -0400 (EDT)
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
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 2/4] selftests/rseq: Add sched_state rseq field and getter
Date:   Mon, 29 May 2023 15:14:14 -0400
Message-Id: <20230529191416.53955-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend struct rseq in the rseq selftests to include the sched_state
field. Implement a getter function for this field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h | 42 +++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.c     | 13 ++++++++
 tools/testing/selftests/rseq/rseq.h     |  5 +++
 3 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index fb4ec8a75dd4..1092d6750386 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -37,6 +37,13 @@ enum rseq_abi_cs_flags {
 		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_abi_sched_state_flags {
+	/*
+	 * Task is currently running on a CPU if bit is set.
+	 */
+	RSEQ_ABI_SCHED_STATE_FLAG_ON_CPU		= (1U << 0),
+};
+
 /*
  * struct rseq_abi_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -53,6 +60,32 @@ struct rseq_abi_cs {
 	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
+/*
+ * rseq_abi_sched_state should be aligned on the cache line size.
+ */
+struct rseq_abi_sched_state {
+	/*
+	 * Version of this structure. Populated by the kernel, read by
+	 * user-space.
+	 */
+	__u32 version;
+	/*
+	 * The state is updated by the kernel. Read by user-space with
+	 * single-copy atomicity semantics. This field can be read by any
+	 * userspace thread. Aligned on 32-bit, and ideally on cache line size.
+	 * Contains a bitmask of enum rseq_abi_sched_state_flags. This field is
+	 * provided as a hint by the scheduler, and requires that the page
+	 * holding this state is faulted-in for the state update to be
+	 * performed by the scheduler.
+	 */
+	__u32 state;
+	/*
+	 * Thread ID associated with the thread registering this structure.
+	 * Initialized by user-space before registration.
+	 */
+	__u32 tid;
+};
+
 /*
  * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line.
@@ -164,6 +197,15 @@ struct rseq_abi {
 	 */
 	__u32 mm_cid;
 
+	__u32 padding1;
+
+	/*
+	 * Restartable sequences sched_state_ptr field. Initialized by
+	 * userspace to the address at which the struct rseq_abi_sched_state is
+	 * located. Read by the kernel on rseq registration.
+	 */
+	__u64 sched_state_ptr;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4e4aa006004c..76925b116054 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -62,17 +62,28 @@ static int rseq_reg_success;	/* At least one rseq registration has succeded. */
 /* Allocate a large area for the TLS. */
 #define RSEQ_THREAD_AREA_ALLOC_SIZE	1024
 
+/* Approximation of cacheline size. */
+#define CACHELINE_SIZE			128
+
 /* Original struct rseq feature size is 20 bytes. */
 #define ORIG_RSEQ_FEATURE_SIZE		20
 
 /* Original struct rseq allocation size is 32 bytes. */
 #define ORIG_RSEQ_ALLOC_SIZE		32
 
+static
+__thread struct rseq_abi_sched_state __rseq_abi_sched_state __attribute__((tls_model("initial-exec"), aligned(CACHELINE_SIZE)));
+
 static
 __thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"), aligned(RSEQ_THREAD_AREA_ALLOC_SIZE))) = {
 	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
+static pid_t rseq_gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
 static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
 		    int flags, uint32_t sig)
 {
@@ -109,6 +120,8 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
+	__rseq_abi_sched_state.tid = rseq_gettid();
+	__rseq_abi.sched_state_ptr = (uint64_t)(unsigned long)&__rseq_abi_sched_state;
 	rc = sys_rseq(&__rseq_abi, rseq_size, 0, RSEQ_SIG);
 	if (rc) {
 		if (RSEQ_READ_ONCE(rseq_reg_success)) {
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index d7364ea4d201..4c14ef3f581f 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -236,6 +236,11 @@ static inline void rseq_prepare_unload(void)
 	rseq_clear_rseq_cs();
 }
 
+static inline struct rseq_abi_sched_state *rseq_get_sched_state(struct rseq_abi *rseq)
+{
+	return (struct rseq_abi_sched_state *)(unsigned long)rseq->sched_state_ptr;
+}
+
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
 		       intptr_t *v, intptr_t expect,
-- 
2.25.1

