Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22928714F91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjE2TO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:14:27 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE9DC;
        Mon, 29 May 2023 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685387664;
        bh=4iL71aqYe6mylgQi/BMhO/DWKge19ME73V8LmRUiL0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOryM4YHJrCJcZzUWSpChQleZcvut1kTGIIi7UFdFAE/7CiS+zzdzW052nujghcBL
         JJ2gaH2SB/CNXKa5sT3JBTRvmJrfA2VtAGeuUUCZEyUluxGWwzqu21PkZ5av/oK+zC
         QP9MryjatNN5GN28eOOM/mqsGR9Lz+5hERq2xXUD1G8BQbADOrtGcpWjMcQ4mw2SFJ
         dGSKFqu6RE3gThOyAXZ95I+LaTGDevfV15U5oYHnMi0JVXmVEmlqJqlYx4R9MxtQkW
         gIRMrhO8i6B5JFoya26rQiNKi6YV/2Qevg81Z5lPJKVbgjZidOktCFm3CxvPNUVe9S
         QpbUFNKg8Ts5w==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVQFC4LtVz165R;
        Mon, 29 May 2023 15:14:23 -0400 (EDT)
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
Subject: [RFC PATCH v2 4/4] selftests/rseq: Implement rseq_mutex test program
Date:   Mon, 29 May 2023 15:14:16 -0400
Message-Id: <20230529191416.53955-5-mathieu.desnoyers@efficios.com>
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

Example use of the rseq sched state.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore   |   1 +
 tools/testing/selftests/rseq/Makefile     |   3 +-
 tools/testing/selftests/rseq/rseq_mutex.c | 120 ++++++++++++++++++++++
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq_mutex.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index a8db9f7a7cec..38d5b2fe5905 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -10,3 +10,4 @@ param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
 sched_state_test
+rseq_mutex
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 7c8f4f2be74c..a9d7ceb5b79b 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,7 +14,8 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice sched_state_test
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice sched_state_test \
+		rseq_mutex
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/rseq_mutex.c b/tools/testing/selftests/rseq/rseq_mutex.c
new file mode 100644
index 000000000000..01afd6a0e8bd
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq_mutex.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+#include <poll.h>
+
+#include "rseq.h"
+
+#define RSEQ_MUTEX_MAX_BUSY_LOOP	100
+
+struct rseq_mutex {
+	/*
+	 * When non-NULL, owner points to per-thread rseq_abi_sched_state of
+	 * owner thread.
+	 */
+	struct rseq_abi_sched_state *owner;
+};
+
+static struct rseq_mutex lock = { .owner = NULL };
+
+static int testvar;
+
+static void rseq_lock_slowpath(struct rseq_mutex *lock)
+{
+	int i = 0;
+
+	for (;;) {
+		struct rseq_abi_sched_state *expected = NULL, *self = rseq_get_sched_state(rseq_get_abi());
+
+		if (__atomic_compare_exchange_n(&lock->owner, &expected, self, false,
+						__ATOMIC_ACQUIRE, __ATOMIC_RELAXED))
+			break;
+		//TODO: use rseq critical section to protect dereference of owner thread's
+		//rseq_abi_sched_state, combined with rseq fence at thread reclaim.
+		if ((RSEQ_READ_ONCE(expected->state) & RSEQ_ABI_SCHED_STATE_FLAG_ON_CPU) &&
+		    i < RSEQ_MUTEX_MAX_BUSY_LOOP) {
+			rseq_barrier();			/* busy-wait, e.g. cpu_relax(). */
+			i++;
+		} else {
+			//TODO: Enqueue waiter in a wait-queue, and integrate
+			//with sys_futex rather than waiting for 10ms.
+			(void) poll(NULL, 0, 10);	/* wait 10ms */
+		}
+	}
+}
+
+static void rseq_lock(struct rseq_mutex *lock)
+{
+	struct rseq_abi_sched_state *expected = NULL, *self = rseq_get_sched_state(rseq_get_abi());
+
+	if (__atomic_compare_exchange_n(&lock->owner, &expected, self, false,
+					__ATOMIC_ACQUIRE, __ATOMIC_RELAXED))
+		return;
+	rseq_lock_slowpath(lock);
+}
+
+static void rseq_unlock(struct rseq_mutex *lock)
+{
+	__atomic_store_n(&lock->owner, NULL, __ATOMIC_RELEASE);
+	//TODO: integrate with sys_futex and wakeup oldest waiter.
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
+	for (i = 0; i < 1000; i++) {
+		int var;
+
+		rseq_lock(&lock);
+		var = RSEQ_READ_ONCE(testvar);
+		if (var) {
+			fprintf(stderr, "Unexpected value %d\n", var);
+			abort();
+		}
+		RSEQ_WRITE_ONCE(testvar, 1);
+		if (!(i % 10))
+			(void) poll(NULL, 0, 10);
+		else
+			rseq_barrier();
+		RSEQ_WRITE_ONCE(testvar, 0);
+		rseq_unlock(&lock);
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
+int main(int argc, char **argv)
+{
+	int nr_threads = 5;
+	pthread_t test_thread_id[nr_threads];
+	int i;
+
+	for (i = 0; i < nr_threads; i++) {
+		pthread_create(&test_thread_id[i], NULL, test_thread, NULL);
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		pthread_join(test_thread_id[i], NULL);
+	}
+
+	return 0;
+}
-- 
2.25.1

