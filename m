Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7E618956
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKCUGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiKCUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:16 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D0C205DE;
        Thu,  3 Nov 2022 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505904;
        bh=0QD71HnTfi102kMj/iQwyJg3EXoJA+jNlf4ovqOd4kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETGY9r1/7djqED9kRWdvb2A7Hn7p0T80/dljzT/sjkFH/rpqdtRzFK9OMRAmRbQtj
         BZcbtD6h2TSfkcGemwd/iHAmvwPYXosrvUUvHQ2NFto1BKPm/zMPomPP/ysZ4xm+jJ
         SudXbwa4IaAoTJNYDHWGPM3qZnuxoudRmsf9Lp+2CQNMixO1TITjJogn3bI9jDoTQY
         lI9nrtpDsriaY5dg21SYn1BzlnrNPb+Ytx8JK+aj10FB8jc8TFwcFhf8QNXVcxQ4Xy
         HUvXNcrEyofptJorvifkYnDuvj5+Q0Fm97oabgIZ2OHSxqr8iUnnGQXj/4UeuNnNPr
         NJJ32YXJoh9sg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F9C5KfTzfB5;
        Thu,  3 Nov 2022 16:05:03 -0400 (EDT)
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
Subject: [PATCH v5 22/24] selftests/rseq: Implement numa node id vs vm_vcpu_id invariant test
Date:   Thu,  3 Nov 2022 16:03:57 -0400
Message-Id: <20221103200359.328736-23-mathieu.desnoyers@efficios.com>
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

On all architectures except Power, the NUMA topology is never
reconfigured after a CPU has been associated with a NUMA node in the
system lifetime.

Even on Power, we can assume that NUMA topology reconfiguration happens
rarely, and therefore we do not expect it to happen while the NUMA test
is running.

This test validates that the mapping between a vm_vcpu_id and a numa
node id remains valid for the process lifetime. In other words, it
validates that if any thread within the process running on behalf of a
vm_vcpu_id N observes a NUMA node id M, all threads within this process
will always observe the same NUMA node id value when running on behalf
of that same vm_vcpu_id.

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
index db5c1a124c6c..9231abed69cc 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+basic_numa_test
 basic_percpu_ops_test
 basic_percpu_ops_vm_vcpu_id_test
 basic_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 3eec8e166385..4bf5b7202254 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -12,7 +12,7 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_vm_vcpu_id_test param_test \
+TEST_GEN_PROGS = basic_test basic_numa_test basic_percpu_ops_test basic_percpu_ops_vm_vcpu_id_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_vm_vcpu_id \
 		param_test_vm_vcpu_id_benchmark param_test_vm_vcpu_id_compare_twice
 
diff --git a/tools/testing/selftests/rseq/basic_numa_test.c b/tools/testing/selftests/rseq/basic_numa_test.c
new file mode 100644
index 000000000000..45cb714b135c
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_numa_test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Basic rseq NUMA test. Validate that (vm_vcpu_id, numa_node_id) pairs are
+ * invariant. The only known scenario where this is untrue is on Power which
+ * can reconfigure the NUMA topology on CPU hotunplug/hotplug sequence.
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
+		uint32_t vm_vcpu_id, node;
+		int cached_node_id;
+
+		while (rseq_load_u32_u32(RSEQ_MO_RELAXED, &vm_vcpu_id, &rseq_get_abi()->vm_vcpu_id,
+					 &node, &rseq_get_abi()->node_id) != 0) {
+			/* Retry. */
+		}
+		cached_node_id = RSEQ_READ_ONCE(cpu_numa_id[vm_vcpu_id]);
+		if (cached_node_id == -1) {
+			RSEQ_WRITE_ONCE(cpu_numa_id[vm_vcpu_id], node);
+		} else {
+			if (node != cached_node_id) {
+				fprintf(stderr, "Error: NUMA node id discrepancy: vm_vcpu_id %u cached node id %d node id %u.\n",
+					vm_vcpu_id, cached_node_id, node);
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
+        pthread_t tid[NR_THREADS];
+        int err, i;
+        void *tret;
+
+	numa_id_init();
+
+	printf("testing rseq (vm_vcpu_id, numa_node_id) invariant, single thread\n");
+
+	(void) test_thread(NULL);
+
+	printf("testing rseq (vm_vcpu_id, numa_node_id) invariant, multi-threaded\n");
+
+        for (i = 0; i < NR_THREADS; i++) {
+                err = pthread_create(&tid[i], NULL, test_thread, NULL);
+                if (err != 0)
+                        abort();
+        }
+
+        for (i = 0; i < NR_THREADS; i++) {
+                err = pthread_join(tid[i], &tret);
+                if (err != 0)
+                        abort();
+        }
+
+	return 0;
+}
+#else
+static
+int test_numa(void)
+{
+	fprintf(stderr, "rseq_load_u32_u32 is not implemented on this architecture. "
+			"Skipping numa test.\n");
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

