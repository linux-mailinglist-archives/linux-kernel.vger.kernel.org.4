Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5F714F97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjE2TOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjE2TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:14:27 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90DD9;
        Mon, 29 May 2023 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685387663;
        bh=1NSDvuKZlkj1LDG55Opnc9arEf2CDBA5sWooOa0Auxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+nmIA9jjhGxSVcQWQ1eh0PMnpHNNfD6o9CBD+CE/oKRJutzuFGKqFXTzkuQ3vlHR
         +srFPLRlhguoA+SYIAbp2Y80lBYBP8/sVMMuFZjOO8TomJeAkBd/oHgtqHKET1L/jE
         Oq+sdX9bwUXsbfwjQ1TUad7wjJoJvyq4l5NiCSUFlorVyqzmqn8KCQdYd0PDkQDKke
         rMm2TI/P4A++PEXnsUgm17wwUCo1q7HtISOODP7xtmJOwVXzNjY5xP9XCLnkP13faU
         dvZd1sCtXlMDSGDDskruo6k2GnQ2obToX5tEaMZD6S6g95kTQbdLD9TnsB3M2w4yjk
         7ljd78EzhMOCg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVQFC0n9Jz165Q;
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
Subject: [RFC PATCH v2 3/4] selftests/rseq: Implement sched state test program
Date:   Mon, 29 May 2023 15:14:15 -0400
Message-Id: <20230529191416.53955-4-mathieu.desnoyers@efficios.com>
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

This is a small test program with can be altered to show whether the
target thread is on-cpu or not, dependending on whether it loops on
poll() or does a busy-loop.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |  1 +
 tools/testing/selftests/rseq/Makefile         |  2 +-
 .../testing/selftests/rseq/sched_state_test.c | 72 +++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/sched_state_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 16496de5f6ce..a8db9f7a7cec 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -9,3 +9,4 @@ param_test_compare_twice
 param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
+sched_state_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index b357ba24af06..7c8f4f2be74c 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,7 +14,7 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice sched_state_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/sched_state_test.c b/tools/testing/selftests/rseq/sched_state_test.c
new file mode 100644
index 000000000000..5196b0dd897a
--- /dev/null
+++ b/tools/testing/selftests/rseq/sched_state_test.c
@@ -0,0 +1,72 @@
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
+static struct rseq_abi_sched_state *target_thread_state;
+
+//TODO:
+//Use rseq c.s. and rseq fence to protect access to remote thread's rseq_abi.
+
+static
+void show_sched_state(struct rseq_abi_sched_state *rseq_thread_state)
+{
+	uint32_t state;
+
+	state = rseq_thread_state->state;
+	printf("Target thread: %u, ON_CPU=%d\n",
+	       rseq_thread_state->tid,
+	       !!(state & RSEQ_ABI_SCHED_STATE_FLAG_ON_CPU));
+}
+
+static
+void *test_thread(void *arg)
+{
+	int i;
+
+	for (i = 0; i < 1000; i++) {
+		show_sched_state(target_thread_state);
+		(void) poll(NULL, 0, 100);
+	}
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t test_thread_id;
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto init_thread_error;
+	}
+	target_thread_state = rseq_get_sched_state(rseq_get_abi());
+
+	pthread_create(&test_thread_id, NULL, test_thread, NULL);
+
+	for (i = 0; i < 1000000000; i++)
+		rseq_barrier();
+	//for (i = 0; i < 10000; i++)
+	//	(void) poll(NULL, 0, 75);
+
+	pthread_join(test_thread_id, NULL);
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto init_thread_error;
+	}
+	return 0;
+
+init_thread_error:
+	return -1;
+}
-- 
2.25.1

