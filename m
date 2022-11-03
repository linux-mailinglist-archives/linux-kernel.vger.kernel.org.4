Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD9618937
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCUFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKCUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:04:59 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D6C13F5C;
        Thu,  3 Nov 2022 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505896;
        bh=QFKjPrOBRaJ+RE5VcVuzV69Cm1OaO5G8ZsyHghodm3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SevLZvZgmxJF2FTYxR9iKfeJdJrDvFaQWkjDakFeH53s7rGPiAFqjwHPnEtBqPuvv
         eAQDp2GQGvEJKlyzfgKXb1OyYm1ayf9oGgjpUzcqGsH/QPJV879LU4e3IumAKld5I6
         wwauz0TK2JYBz2pJIe1mS6qny8cEpBqdXUl/LNaZYdlqs/sDVZQC+DYXJ9S5MTUflU
         wq3I2ea8LbIoDtWy38e6UNn18fSFBDaJKf3uhXuC6nCqsV/NV5gxtkqn2t8rkCqJlT
         UZohC55K6S27HVfbniBj32qyz3azdo+TcP/csB0LAY96WpsIbOM1o0WpwmA1muhjGs
         mEGY57Ug8ClzA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F945M9tzg71;
        Thu,  3 Nov 2022 16:04:56 -0400 (EDT)
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
Subject: [PATCH v5 05/24] selftests/rseq: Implement rseq numa node id field selftest
Date:   Thu,  3 Nov 2022 16:03:40 -0400
Message-Id: <20221103200359.328736-6-mathieu.desnoyers@efficios.com>
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

Test the NUMA node id extension rseq field. Compare it against the value
returned by the getcpu(2) system call while pinned on a specific core.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/basic_test.c |  4 ++++
 tools/testing/selftests/rseq/rseq-abi.h   |  8 +++++++
 tools/testing/selftests/rseq/rseq.c       | 18 +++++++++++++++
 tools/testing/selftests/rseq/rseq.h       | 28 +++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
index d8efbfb89193..295eea16466f 100644
--- a/tools/testing/selftests/rseq/basic_test.c
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -22,6 +22,8 @@ void test_cpu_pointer(void)
 	CPU_ZERO(&test_affinity);
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		if (CPU_ISSET(i, &affinity)) {
+			int node;
+
 			CPU_SET(i, &test_affinity);
 			sched_setaffinity(0, sizeof(test_affinity),
 					&test_affinity);
@@ -29,6 +31,8 @@ void test_cpu_pointer(void)
 			assert(rseq_current_cpu() == i);
 			assert(rseq_current_cpu_raw() == i);
 			assert(rseq_cpu_start() == i);
+			node = rseq_fallback_current_node();
+			assert(rseq_current_node_id() == node);
 			CPU_CLR(i, &test_affinity);
 		}
 	}
diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index 00ac846d85b0..a1faa9162d52 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -147,6 +147,14 @@ struct rseq_abi {
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
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index c1c691eca904..191fcc94ce9c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -79,6 +79,11 @@ static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
+static int sys_getcpu(unsigned *cpu, unsigned *node)
+{
+	return syscall(__NR_getcpu, cpu, node, NULL);
+}
+
 int rseq_available(void)
 {
 	int rc;
@@ -200,3 +205,16 @@ int32_t rseq_fallback_current_cpu(void)
 	}
 	return cpu;
 }
+
+int32_t rseq_fallback_current_node(void)
+{
+	uint32_t cpu_id, node_id;
+	int ret;
+
+	ret = sys_getcpu(&cpu_id, &node_id);
+	if (ret) {
+		perror("sys_getcpu()");
+		return ret;
+	}
+	return (int32_t) node_id;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 95adc1e1b0db..fd17d0e54a1b 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -20,6 +20,15 @@
 #include "rseq-abi.h"
 #include "compiler.h"
 
+#ifndef rseq_sizeof_field
+#define rseq_sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
+#ifndef rseq_offsetofend
+#define rseq_offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ rseq_sizeof_field(TYPE, MEMBER))
+#endif
+
 /*
  * Empty code injection macros, override when testing.
  * It is important to consider that the ASM injection macros need to be
@@ -128,6 +137,11 @@ int rseq_unregister_current_thread(void);
  */
 int32_t rseq_fallback_current_cpu(void);
 
+/*
+ * Restartable sequence fallback for reading the current node number.
+ */
+int32_t rseq_fallback_current_node(void);
+
 /*
  * Values returned can be either the current CPU number, -1 (rseq is
  * uninitialized), or -2 (rseq initialization has failed).
@@ -163,6 +177,20 @@ static inline uint32_t rseq_current_cpu(void)
 	return cpu;
 }
 
+static inline bool rseq_node_id_available(void)
+{
+	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id);
+}
+
+/*
+ * Current NUMA node number.
+ */
+static inline uint32_t rseq_current_node_id(void)
+{
+	assert(rseq_node_id_available());
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
-- 
2.25.1

