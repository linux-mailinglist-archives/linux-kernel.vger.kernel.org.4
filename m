Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30826348A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiKVUmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiKVUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:40:29 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8047FC04;
        Tue, 22 Nov 2022 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149596;
        bh=btsOn+kTAHo+7IfW5AlIpOTuvX1JZdT5JIC9e1lK/8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge57bUTBQ1jwA8BF18CyH+AVY87N0Rsid219ntaxLSC8yQAo1QEtayVDWr/mnJuQM
         17UdA2QJztHPBTHzTf5PzBiqWrt14FzgEIPGh2zQkF7XD8xWRdd5OhIyOY/CdEtoRA
         W0trwk9qt1PK7fqOTVtGzQiBV3LoK29e75G/7ifyOQWGoZCcxYJMMozlWDAjNtmKCH
         8qbb0VhhEGW6vHpoC3fp4tK/j9DcO7eJFl49iaUeijKFUrQpMgZSQFe8UQ23rwn5To
         hLq3ZNXGSFb63OrXRFI9Jke6Hb5D/UFahzovWGFyJAzRZp28zJBZ7f4aL3c9mhsvTY
         GTmgmk1y7+80Q==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2h0MqwzXTd;
        Tue, 22 Nov 2022 15:39:56 -0500 (EST)
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
Subject: [PATCH 28/30] selftests/rseq: Implement numa node id vs mm_numa_cid invariant test
Date:   Tue, 22 Nov 2022 15:39:30 -0500
Message-Id: <20221122203932.231377-29-mathieu.desnoyers@efficios.com>
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

On all architectures except Power, the NUMA topology is never
reconfigured after a CPU has been associated with a NUMA node in the
system lifetime.

Even on Power, we can assume that NUMA topology reconfiguration happens
rarely, and therefore we do not expect it to happen while the NUMA test
is running.

This test validates that the mapping between a mm_numa_cid and a numa
node id remains valid for the process lifetime. In other words, it
validates that if any thread within the process running on behalf of a
mm_numa_cid N observes a NUMA node id M, all threads within this process
will always observe the same NUMA node id value when running on behalf
of that same mm_numa_cid.

This characteristic is important for NUMA locality.

This test is skipped on architectures that do not implement
rseq_load_u32_u32.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../testing/selftests/rseq/basic_numa_test.c  | 117 ++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 16496de5f6ce..8a8d163cbb9f 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+basic_numa_test
 basic_percpu_ops_test
 basic_percpu_ops_mm_cid_test
 basic_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 82a52810a649..a00b9dc8eec5 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -12,7 +12,7 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
+TEST_GEN_PROGS = basic_test basic_numa_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
 		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
 
diff --git a/tools/testing/selftests/rseq/basic_numa_test.c b/tools/testing/selftests/rseq/basic_numa_test.c
new file mode 100644
index 000000000000..fce23356fc7e
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_numa_test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Basic rseq NUMA test. Validate that (mm_numa_cid, numa_node_id) pairs
+ * are invariant. The only known scenario where this is untrue is on Power
+ * which can reconfigure the NUMA topology on CPU hotunplug/hotplug sequence.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+#define NR_LOOPS	100000000
+#define NR_THREADS	16
+
+#ifdef RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static
+int cpu_numa_id[CPU_SETSIZE];
+
+static
+void numa_id_init(void)
+{
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		cpu_numa_id[i] = -1;
+}
+
+static
+void *test_thread(void *arg)
+{
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	for (i = 0; i < NR_LOOPS; i++) {
+		uint32_t mm_numa_cid, node;
+		int cached_node_id;
+
+		while (rseq_load_u32_u32(RSEQ_MO_RELAXED, &mm_numa_cid,
+					 &rseq_get_abi()->mm_numa_cid,
+					 &node, &rseq_get_abi()->node_id) != 0) {
+			/* Retry. */
+		}
+		cached_node_id = RSEQ_READ_ONCE(cpu_numa_id[mm_numa_cid]);
+		if (cached_node_id == -1) {
+			RSEQ_WRITE_ONCE(cpu_numa_id[mm_numa_cid], node);
+		} else {
+			if (node != cached_node_id) {
+				fprintf(stderr, "Error: NUMA node id discrepancy: mm_numa_cid %u cached node id %d node id %u.\n",
+					mm_numa_cid, cached_node_id, node);
+				fprintf(stderr, "This is likely a kernel bug, or caused by a concurrent NUMA topology reconfiguration.\n");
+				abort();
+			}
+		}
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+static
+int test_numa(void)
+{
+	pthread_t tid[NR_THREADS];
+	int err, i;
+	void *tret;
+
+	numa_id_init();
+
+	printf("testing rseq (mm_numa_cid, numa_node_id) invariant, single thread\n");
+
+	(void) test_thread(NULL);
+
+	printf("testing rseq (mm_numa_cid, numa_node_id) invariant, multi-threaded\n");
+
+	for (i = 0; i < NR_THREADS; i++) {
+		err = pthread_create(&tid[i], NULL, test_thread, NULL);
+		if (err != 0)
+			abort();
+	}
+
+	for (i = 0; i < NR_THREADS; i++) {
+		err = pthread_join(tid[i], &tret);
+		if (err != 0)
+			abort();
+	}
+
+	return 0;
+}
+#else
+static
+int test_numa(void)
+{
+	fprintf(stderr, "rseq_load_u32_u32 is not implemented on this architecture. Skipping numa test.\n");
+	return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	return test_numa();
+}
-- 
2.25.1

