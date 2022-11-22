Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13276348A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiKVUmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiKVUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:59 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61D59864;
        Tue, 22 Nov 2022 12:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149592;
        bh=uyaPcQDGJPqUuABnZ11NRqypYvIld9DDg3FX40xHmJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkQQcpuX9yxZlXVsnMhpgdoneeNCcXbZ45WoPj1kFVzzRSCysG0IC4MM736KHCx84
         tbugSMJlAF/ZEfbQMtZw/jvQh4S5MAakMgU/Dm+7D8O4okwkIDXCBwCJwdqJT/w4+k
         L0M3GRtILAxWxerA/g/yi6ftLm0CGlAT1d2bpbXJQs4dcw0oeMDK6Wr++K7/TqtRAx
         evfsCFw/o9k0vSg3Zq0yduqH3LAJAeYlHfZWVO4go3fy52KnEvFkghPuJEm2DZ4UkQ
         89cl1UUEqcMe/Zmi226GDvfm9pUw6CsEbKrsJP8n+t725ZxfTcjT2xOkUuY87/x0O4
         rBCpcgMV/br4w==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2c0RhzzXDY;
        Tue, 22 Nov 2022 15:39:52 -0500 (EST)
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
Subject: [PATCH 18/30] selftests/rseq: Implement basic percpu ops mm_cid test
Date:   Tue, 22 Nov 2022 15:39:20 -0500
Message-Id: <20221122203932.231377-19-mathieu.desnoyers@efficios.com>
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

Adapt to the rseq.h API changes introduced by commits
"selftests/rseq: <arch>: Template memory ordering and percpu access mode".

Build a new basic_percpu_ops_mm_cid_test to test the new "mm_cid" rseq
field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |  1 +
 tools/testing/selftests/rseq/Makefile         |  5 +-
 .../selftests/rseq/basic_percpu_ops_test.c    | 46 ++++++++++++++++---
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 5910888ebfe1..7e99554748cb 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 basic_percpu_ops_test
+basic_percpu_ops_mm_cid_test
 basic_test
 basic_rseq_op_test
 param_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 215e1067f037..2e5e3eac2ca0 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -12,7 +12,7 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test param_test \
+TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
@@ -29,6 +29,9 @@ $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
 $(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
 
+$(OUTPUT)/basic_percpu_ops_mm_cid_test: basic_percpu_ops_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID_ID $< $(LDLIBS) -lrseq -o $@
+
 $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 517756afc2a4..887542961968 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -12,6 +12,32 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
+#ifdef BUILDOPT_RSEQ_PERCPU_MM_CID
+# define RSEQ_PERCPU	RSEQ_PERCPU_MM_CID
+static
+int get_current_cpu_id(void)
+{
+	return rseq_current_mm_cid();
+}
+static
+bool rseq_validate_cpu_id(void)
+{
+	return rseq_mm_cid_available();
+}
+#else
+# define RSEQ_PERCPU	RSEQ_PERCPU_CPU_ID
+static
+int get_current_cpu_id(void)
+{
+	return rseq_cpu_start();
+}
+static
+bool rseq_validate_cpu_id(void)
+{
+	return rseq_current_cpu_raw() >= 0;
+}
+#endif
+
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
@@ -51,9 +77,9 @@ int rseq_this_cpu_lock(struct percpu_lock *lock)
 	for (;;) {
 		int ret;
 
-		cpu = rseq_cpu_start();
-		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
-					 0, 1, cpu);
+		cpu = get_current_cpu_id();
+		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					 &lock->c[cpu].v, 0, 1, cpu);
 		if (rseq_likely(!ret))
 			break;
 		/* Retry if comparison fails or rseq aborts. */
@@ -141,13 +167,14 @@ void this_cpu_list_push(struct percpu_list *list,
 		intptr_t *targetptr, newval, expect;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load list->c[cpu].head with single-copy atomicity. */
 		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
 		newval = (intptr_t)node;
 		targetptr = (intptr_t *)&list->c[cpu].head;
 		node->next = (struct percpu_list_node *)expect;
-		ret = rseq_cmpeqv_storev(targetptr, expect, newval, cpu);
+		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					 targetptr, expect, newval, cpu);
 		if (rseq_likely(!ret))
 			break;
 		/* Retry if comparison fails or rseq aborts. */
@@ -170,12 +197,13 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 		long offset;
 		int ret, cpu;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		targetptr = (intptr_t *)&list->c[cpu].head;
 		expectnot = (intptr_t)NULL;
 		offset = offsetof(struct percpu_list_node, next);
 		load = (intptr_t *)&head;
-		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
+		ret = rseq_cmpnev_storeoffp_load(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+						 targetptr, expectnot,
 						 offset, load, cpu);
 		if (rseq_likely(!ret)) {
 			if (_cpu)
@@ -295,6 +323,10 @@ int main(int argc, char **argv)
 			errno, strerror(errno));
 		goto error;
 	}
+	if (!rseq_validate_cpu_id()) {
+		fprintf(stderr, "Error: cpu id getter unavailable\n");
+		goto error;
+	}
 	printf("spinlock\n");
 	test_percpu_spinlock();
 	printf("percpu_list\n");
-- 
2.25.1

