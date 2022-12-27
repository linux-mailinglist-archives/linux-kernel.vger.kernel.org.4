Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1F656ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiL0MPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiL0MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E28E37;
        Tue, 27 Dec 2022 04:13:52 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWt1J1Rkb6/iwscbvYQf3NuhLqu0swi3tquUpGaka4M=;
        b=ZdHGKYBjTOduPnaUAMpWIhCoJJr7Bl8BpdVIQaf4cOFdu7C/1jDU/QtN2CP9dxgzfBUsZ7
        7/sIuVi3cuT54xGqELmuobhtUDl9K/BPtjCZKIpoVLzrSVEqXlNyFGuQV5fWR+56Ve3xU8
        S4uacpWVky3OFG7xHCcQiNHzYWofUxNiQz0Uil2ir6mjfloyO/DtCIhd0XET8U2o7aLNaN
        bg/4dNdy2GBf62XzZ+MNw5vwzx/rqp9Mdz/kOLRj9VIuI4SEK70R4DtbS0XvkVapmX5X6r
        BEP0kqz2JYv+hI5MQJbbVvigtMyGzmxUVcCZRlt0fbDhD8h5OBuDyjChtWu4Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWt1J1Rkb6/iwscbvYQf3NuhLqu0swi3tquUpGaka4M=;
        b=MlkZmaQ0Y3c1+UPULCfZKT8pRVQKuT9QxtRoy7gEm1DgDE+kiOoIxZA26ley52mfr10cN2
        CE/3glvKyLmLbMCA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Implement basic percpu ops mm_cid test
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-19-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-19-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214322952.4906.6310871589163576060.tip-bot2@tip-bot2>
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

Commit-ID:     cead72062756294dff01314b57b68e3e925ef321
Gitweb:        https://git.kernel.org/tip/cead72062756294dff01314b57b68e3e925ef321
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:20 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:15 +01:00

selftests/rseq: Implement basic percpu ops mm_cid test

Adapt to the rseq.h API changes introduced by commits
"selftests/rseq: <arch>: Template memory ordering and percpu access mode".

Build a new basic_percpu_ops_mm_cid_test to test the new "mm_cid" rseq
field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-19-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/.gitignore              |  1 +-
 tools/testing/selftests/rseq/Makefile                |  5 +-
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 46 +++++++++--
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 5910888..7e99554 100644
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
index 215e106..2e5e3ea 100644
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
index 517756a..8875429 100644
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
