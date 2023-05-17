Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E1706CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjEQP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjEQP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:21 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1192A261;
        Wed, 17 May 2023 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684337225;
        bh=hT9e3gv7K/FNrNBkQsoKYl28jg6kolO72kzwOKl/7ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjGsLJnTOSUJZOGX0pqCxp8UmKu2QdKVAklVv8sMFxW1hxxk++1JTMec8yzzJ6hGh
         zIIW4DzYCAbghenGdcrjT75Hcxqkqajd/mYKc66SW3Fhv2WJOOmtc+xebg2gfvgVj6
         kA2uFSkq0/jqGRBAPYr8ZATbBYMUd0wrT6ze56z8pu9GZsL+O1sxiar99KFWT5OpvM
         dpEUejnQcO86WBJpOrezhhfLL/0CZRanKTuyAP3pIu+mtBmpEmDs1EdDuWlUUWAPXY
         B4GXxIzf2lu1/2I+roCswqmNGsSGDjTC42eeehii0YE/RAGjlE5GnJe3REOoujQZzZ
         pWYQq+ne1phFA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLxmS504rz12wc;
        Wed, 17 May 2023 11:27:04 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/4] selftests/rseq: Implement sched state test program
Date:   Wed, 17 May 2023 11:26:53 -0400
Message-Id: <20230517152654.7193-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
 .../testing/selftests/rseq/sched_state_test.c | 71 +++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
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
index 000000000000..47aeee6d980f
--- /dev/null
+++ b/tools/testing/selftests/rseq/sched_state_test.c
@@ -0,0 +1,71 @@
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
+static struct rseq_abi *target_thread;
+
+//TODO:
+//Use rseq c.s. and rseq fence to protect access to remote thread's rseq_abi.
+
+static
+void show_sched_state(struct rseq_abi *rseq_thread)
+{
+	uint32_t state;
+
+	state = rseq_thread->sched_state;
+	printf("Target thread: ON_CPU=%d\n", !!(state & RSEQ_SCHED_STATE_ON_CPU));
+}
+
+
+static
+void *test_thread(void *arg)
+{
+	int i;
+
+	for (i = 0; i < 1000; i++) {
+		show_sched_state(target_thread);
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
+	target_thread = rseq_get_abi();
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

