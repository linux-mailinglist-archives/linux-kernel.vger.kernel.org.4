Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360CE656AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiL0MP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiL0MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B4E42;
        Tue, 27 Dec 2022 04:13:52 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+nBPb6SimZTZHD563PkvdmH1gpnTBj464JqdfXoTnI=;
        b=duME7T1j+xSh60vWIKxpG38GhJZEE9DFnrEsmwQVlQJLPGfYRhuJJT2KDKOF4A0EqA2IL/
        XexO/KNvcsDGVxofgW04YxiV06uOZz2vIHLhWM+EnYpzrHQSEi3IDhOH2+CCT9Sza4dasY
        qKvJIg/lNutQm2C0iO2qcmx9mUhWC84+Qe8WNvaXrxpkwXnGd/6GnttCJFnhtepb+FnAg9
        OpWguZ/GBvcjUZ6u7BhxwF50HiwVxGjO+R6Z9Tihu40cbtVseqWPELfqAeAJpA6SpqVkrM
        TjeOzKB+nbYtIec7nsTPjTD+8EvAY55wIlck60zVgYuIhdQSWSfQhhsq9MKWrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+nBPb6SimZTZHD563PkvdmH1gpnTBj464JqdfXoTnI=;
        b=mcw0AddAtxVd7GVzTPqbAhnEgZ8IyDFiwHxpu0BXvG3+5aNR2S1DiNi3bB+bZ90Cy1UiQD
        bIGq11CAwcPuknBQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Implement parametrized mm_cid test
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-20-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-20-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214322940.4906.1599966301749015205.tip-bot2@tip-bot2>
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

Commit-ID:     ee31fff091fa9c185d10844f9caf38784afe4745
Gitweb:        https://git.kernel.org/tip/ee31fff091fa9c185d10844f9caf38784afe4745
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:21 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:15 +01:00

selftests/rseq: Implement parametrized mm_cid test

Adapt to the rseq.h API changes introduced by commits
"selftests/rseq: <arch>: Template memory ordering and percpu access mode".

Build a new param_test_mm_cid, param_test_mm_cid_benchmark, and
param_test_mm_cid_compare_twice executables to test the new "mm_cid"
rseq field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-20-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/.gitignore        |   3 +-
 tools/testing/selftests/rseq/Makefile          |  15 +-
 tools/testing/selftests/rseq/param_test.c      | 148 ++++++++++------
 tools/testing/selftests/rseq/run_param_test.sh |   5 +-
 4 files changed, 122 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 7e99554..16496de 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -6,3 +6,6 @@ basic_rseq_op_test
 param_test
 param_test_benchmark
 param_test_compare_twice
+param_test_mm_cid
+param_test_mm_cid_benchmark
+param_test_mm_cid_compare_twice
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 2e5e3ea..82a5281 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -13,7 +13,8 @@ LDLIBS += -lpthread -ldl
 OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
-		param_test_benchmark param_test_compare_twice
+		param_test_benchmark param_test_compare_twice param_test_mm_cid \
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
@@ -39,3 +40,15 @@ $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 $(OUTPUT)/param_test_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_mm_cid: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_mm_cid_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_mm_cid_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 9869369..cadb9d8 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -16,6 +16,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <stddef.h>
+#include <stdbool.h>
 
 static inline pid_t rseq_gettid(void)
 {
@@ -36,7 +37,7 @@ static int opt_modulo, verbose;
 
 static int opt_yield, opt_signal, opt_sleep,
 		opt_disable_rseq, opt_threads = 200,
-		opt_disable_mod = 0, opt_test = 's', opt_mb = 0;
+		opt_disable_mod = 0, opt_test = 's';
 
 static long long opt_reps = 5000;
 
@@ -264,6 +265,63 @@ unsigned int yield_mod_cnt, nr_abort;
 
 #include "rseq.h"
 
+static enum rseq_mo opt_mo = RSEQ_MO_RELAXED;
+
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+#define TEST_MEMBARRIER
+
+static int sys_membarrier(int cmd, int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+#endif
+
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
+# ifdef TEST_MEMBARRIER
+/*
+ * Membarrier does not currently support targeting a mm_cid, so
+ * issue the barrier on all cpus.
+ */
+static
+int rseq_membarrier_expedited(int cpu)
+{
+	return sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			      0, 0);
+}
+# endif /* TEST_MEMBARRIER */
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
+# ifdef TEST_MEMBARRIER
+static
+int rseq_membarrier_expedited(int cpu)
+{
+	return sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			      MEMBARRIER_CMD_FLAG_CPU, cpu);
+}
+# endif /* TEST_MEMBARRIER */
+#endif
+
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
@@ -351,8 +409,9 @@ static int rseq_this_cpu_lock(struct percpu_lock *lock)
 	for (;;) {
 		int ret;
 
-		cpu = rseq_cpu_start();
-		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
+		cpu = get_current_cpu_id();
+		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					 &lock->c[cpu].v,
 					 0, 1, cpu);
 		if (rseq_likely(!ret))
 			break;
@@ -469,8 +528,9 @@ void *test_percpu_inc_thread(void *arg)
 		do {
 			int cpu;
 
-			cpu = rseq_cpu_start();
-			ret = rseq_addv(&data->c[cpu].count, 1, cpu);
+			cpu = get_current_cpu_id();
+			ret = rseq_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+					&data->c[cpu].count, 1, cpu);
 		} while (rseq_unlikely(ret));
 #ifndef BENCHMARK
 		if (i != 0 && !(i % (reps / 10)))
@@ -539,13 +599,14 @@ void this_cpu_list_push(struct percpu_list *list,
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
@@ -571,13 +632,14 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 		long offset;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		targetptr = (intptr_t *)&list->c[cpu].head;
 		expectnot = (intptr_t)NULL;
 		offset = offsetof(struct percpu_list_node, next);
 		load = (intptr_t *)&head;
-		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
-						   offset, load, cpu);
+		ret = rseq_cmpnev_storeoffp_load(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+						 targetptr, expectnot,
+						 offset, load, cpu);
 		if (rseq_likely(!ret)) {
 			node = head;
 			break;
@@ -715,7 +777,7 @@ bool this_cpu_buffer_push(struct percpu_buffer *buffer,
 		intptr_t offset;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == buffer->c[cpu].buflen)
 			break;
@@ -723,14 +785,9 @@ bool this_cpu_buffer_push(struct percpu_buffer *buffer,
 		targetptr_spec = (intptr_t *)&buffer->c[cpu].array[offset];
 		newval_final = offset + 1;
 		targetptr_final = &buffer->c[cpu].offset;
-		if (opt_mb)
-			ret = rseq_cmpeqv_trystorev_storev_release(
-				targetptr_final, offset, targetptr_spec,
-				newval_spec, newval_final, cpu);
-		else
-			ret = rseq_cmpeqv_trystorev_storev(targetptr_final,
-				offset, targetptr_spec, newval_spec,
-				newval_final, cpu);
+		ret = rseq_cmpeqv_trystorev_storev(opt_mo, RSEQ_PERCPU,
+			targetptr_final, offset, targetptr_spec,
+			newval_spec, newval_final, cpu);
 		if (rseq_likely(!ret)) {
 			result = true;
 			break;
@@ -753,7 +810,7 @@ struct percpu_buffer_node *this_cpu_buffer_pop(struct percpu_buffer *buffer,
 		intptr_t offset;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load offset with single-copy atomicity. */
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == 0) {
@@ -763,7 +820,8 @@ struct percpu_buffer_node *this_cpu_buffer_pop(struct percpu_buffer *buffer,
 		head = RSEQ_READ_ONCE(buffer->c[cpu].array[offset - 1]);
 		newval = offset - 1;
 		targetptr = (intptr_t *)&buffer->c[cpu].offset;
-		ret = rseq_cmpeqv_cmpeqv_storev(targetptr, offset,
+		ret = rseq_cmpeqv_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+			targetptr, offset,
 			(intptr_t *)&buffer->c[cpu].array[offset - 1],
 			(intptr_t)head, newval, cpu);
 		if (rseq_likely(!ret))
@@ -920,7 +978,7 @@ bool this_cpu_memcpy_buffer_push(struct percpu_memcpy_buffer *buffer,
 		size_t copylen;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load offset with single-copy atomicity. */
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == buffer->c[cpu].buflen)
@@ -931,15 +989,11 @@ bool this_cpu_memcpy_buffer_push(struct percpu_memcpy_buffer *buffer,
 		copylen = sizeof(item);
 		newval_final = offset + 1;
 		targetptr_final = &buffer->c[cpu].offset;
-		if (opt_mb)
-			ret = rseq_cmpeqv_trymemcpy_storev_release(
-				targetptr_final, offset,
-				destptr, srcptr, copylen,
-				newval_final, cpu);
-		else
-			ret = rseq_cmpeqv_trymemcpy_storev(targetptr_final,
-				offset, destptr, srcptr, copylen,
-				newval_final, cpu);
+		ret = rseq_cmpeqv_trymemcpy_storev(
+			opt_mo, RSEQ_PERCPU,
+			targetptr_final, offset,
+			destptr, srcptr, copylen,
+			newval_final, cpu);
 		if (rseq_likely(!ret)) {
 			result = true;
 			break;
@@ -964,7 +1018,7 @@ bool this_cpu_memcpy_buffer_pop(struct percpu_memcpy_buffer *buffer,
 		size_t copylen;
 		int ret;
 
-		cpu = rseq_cpu_start();
+		cpu = get_current_cpu_id();
 		/* Load offset with single-copy atomicity. */
 		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
 		if (offset == 0)
@@ -975,8 +1029,8 @@ bool this_cpu_memcpy_buffer_pop(struct percpu_memcpy_buffer *buffer,
 		copylen = sizeof(*item);
 		newval_final = offset - 1;
 		targetptr_final = &buffer->c[cpu].offset;
-		ret = rseq_cmpeqv_trymemcpy_storev(targetptr_final,
-			offset, destptr, srcptr, copylen,
+		ret = rseq_cmpeqv_trymemcpy_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+			targetptr_final, offset, destptr, srcptr, copylen,
 			newval_final, cpu);
 		if (rseq_likely(!ret)) {
 			result = true;
@@ -1151,7 +1205,7 @@ static int set_signal_handler(void)
 }
 
 /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
-#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+#ifdef TEST_MEMBARRIER
 struct test_membarrier_thread_args {
 	int stop;
 	intptr_t percpu_list_ptr;
@@ -1178,9 +1232,10 @@ void *test_membarrier_worker_thread(void *arg)
 		int ret;
 
 		do {
-			int cpu = rseq_cpu_start();
+			int cpu = get_current_cpu_id();
 
-			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
+			ret = rseq_offset_deref_addv(RSEQ_MO_RELAXED, RSEQ_PERCPU,
+				&args->percpu_list_ptr,
 				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
 		} while (rseq_unlikely(ret));
 	}
@@ -1217,11 +1272,6 @@ void test_membarrier_free_percpu_list(struct percpu_list *list)
 		free(list->c[i].head);
 }
 
-static int sys_membarrier(int cmd, int flags, int cpu_id)
-{
-	return syscall(__NR_membarrier, cmd, flags, cpu_id);
-}
-
 /*
  * The manager thread swaps per-cpu lists that worker threads see,
  * and validates that there are no unexpected modifications.
@@ -1260,8 +1310,7 @@ void *test_membarrier_manager_thread(void *arg)
 
 		/* Make list_b "active". */
 		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
-		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
-					MEMBARRIER_CMD_FLAG_CPU, cpu_a) &&
+		if (rseq_membarrier_expedited(cpu_a) &&
 				errno != ENXIO /* missing CPU */) {
 			perror("sys_membarrier");
 			abort();
@@ -1284,8 +1333,7 @@ void *test_membarrier_manager_thread(void *arg)
 
 		/* Make list_a "active". */
 		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
-		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
-					MEMBARRIER_CMD_FLAG_CPU, cpu_b) &&
+		if (rseq_membarrier_expedited(cpu_b) &&
 				errno != ENXIO /* missing CPU*/) {
 			perror("sys_membarrier");
 			abort();
@@ -1356,7 +1404,7 @@ void test_membarrier(void)
 		abort();
 	}
 }
-#else /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV */
+#else /* TEST_MEMBARRIER */
 void test_membarrier(void)
 {
 	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this architecture. "
@@ -1513,7 +1561,7 @@ int main(int argc, char **argv)
 			verbose = 1;
 			break;
 		case 'M':
-			opt_mb = 1;
+			opt_mo = RSEQ_MO_RELEASE;
 			break;
 		default:
 			show_usage(argc, argv);
@@ -1533,6 +1581,10 @@ int main(int argc, char **argv)
 
 	if (!opt_disable_rseq && rseq_register_current_thread())
 		goto error;
+	if (!opt_disable_rseq && !rseq_validate_cpu_id()) {
+		fprintf(stderr, "Error: cpu id getter unavailable\n");
+		goto error;
+	}
 	switch (opt_test) {
 	case 's':
 		printf_verbose("spinlock\n");
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index f51bc83..8d31426 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -42,6 +42,11 @@ function do_tests()
 		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
 		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+
+		echo "Running mm_cid test ${TEST_NAME[$i]}"
+		./param_test_mm_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+		echo "Running mm_cid compare-twice test ${TEST_NAME[$i]}"
+		./param_test_mm_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
