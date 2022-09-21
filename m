Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950B05BF1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiIUAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIUAb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:31:27 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D426E8BF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:31:26 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id r199-20020acaa8d0000000b0034d86517c12so2328824oie.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+JIzKRX0KewNagwHaVVH4mYdPKt+vEM8H/N+SPJENUQ=;
        b=fNVyn4PQ7mq1A3EsQwiqTooTDXZ+GGgHHKz01T6NMBrIZkahm6maPPmRCdh6VckrRk
         cVUHkBnYnyet+X0AHqjNTq0qlEynG/K2XXhnRsFspiz1TVniPmBd7PMZG/qG7humHER2
         s/W/w3ro/5GxlzJPaAKVGrwe43f8a2SxW8tXZ+XoafZi5uPXz7XRvRweYeDxX5ROO9aJ
         8Jv+DpYribZUX8VpR10w3nI2mym1VuOphOrQFEIY6QKHtzhDFA1MxS79H/WPK94gIYlH
         fQGqajsSboFplgAoQxr5OfWFDKdNqPNM6/ADvVhExtT2wvtysjcqkGpG2SqAQW7FwTlR
         gbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+JIzKRX0KewNagwHaVVH4mYdPKt+vEM8H/N+SPJENUQ=;
        b=16qyPSioYuVePYEIZ6yZvM2m6U6bpZPgchh/hXVJBCbjvqTTZx+XSmwEe4k4si7itK
         Lo9x3Ovb3fas/Tmug3vHGaouJOtEER8OsgfKSmK/567bhWMafxH9FM6MEmei6wCKWjtu
         hvCRcimkIt6ky5vp4y1Q+Vywxx70W7ukqPeBovVNFpn9h7Bvj6196d8qWJULgmfMpCnZ
         w7nCbUSb3+crGKtkUZFi58YFMIZVQffgmg97LKo24BdYB1GuML+311cpKZ+iUIQopVLQ
         43014xX33FnYrQkdqVuwGxRB9hCYkvwvSoLU5e2OB45cpbkjXo+MWe29EKPoW4t97K/u
         cvvg==
X-Gm-Message-State: ACrzQf1IM2T/2mCqltPhxeEsgITYym+CTwrIQDBVu3P74c8ybnurCI4X
        e6abQidrT+Hm3BTZmvJYEN9kmYx7yRM=
X-Google-Smtp-Source: AMsMyM5dHuqKMlozPsLHvHlTx848IHi69ByjD3zY6y51I1+qF4RF7iNG/MiuyyWTtfNQ4e/Scbj8KiE8moA=
X-Received: from avagin.kir.corp.google.com ([2620:15c:29:204:2436:675:9889:e5ed])
 (user=avagin job=sendgmr) by 2002:a05:6870:170b:b0:127:6654:6768 with SMTP id
 h11-20020a056870170b00b0012766546768mr3559656oae.256.1663720285304; Tue, 20
 Sep 2022 17:31:25 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:31:20 -0700
In-Reply-To: <20220921003120.209637-1-avagin@google.com>
Mime-Version: 1.0
References: <20220921003120.209637-1-avagin@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921003120.209637-2-avagin@google.com>
Subject: [PATCH 2/2] selftests/timens: add a test for vfork+exit
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

* check that a child process is in parent's time namespace after vfork.
* check that a child process is in the target namespace after exec.

Output on success:
 1..5
 ok 1 parent before vfork
 ok 2 child before exec
 ok 3 child after exec
 ok 4 wait for child
 ok 5 parent after vfork
 # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/timens/.gitignore   |   1 +
 tools/testing/selftests/timens/Makefile     |   2 +-
 tools/testing/selftests/timens/vfork_exec.c | 132 ++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/vfork_exec.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index fe1eb8271b35..cae8dca0fbff 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -8,3 +8,4 @@ procfs
 timens
 timer
 timerfd
+vfork_exec
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 3a5936cc10ab..f0d51d4d2c87 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex vfork_exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
new file mode 100644
index 000000000000..9fd8a64d25a9
--- /dev/null
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define OFFSET (36000)
+
+static void *tcheck(void *arg)
+{
+	struct timespec *now = arg, tst;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+			pr_fail("thread: unexpected value: %ld (%ld)\n",
+				tst.tv_sec, now->tv_sec);
+			return (void *)1UL;
+		}
+	}
+	return NULL;
+}
+
+static int check_in_thread(struct timespec *now)
+{
+	pthread_t th;
+	void *retval;
+
+	if (pthread_create(&th, NULL, tcheck, now))
+		return pr_perror("thread");
+	if (pthread_join(th, &retval))
+		return pr_perror("pthread_join");
+	return !(retval == NULL);
+}
+
+static int check(char *tst_name, struct timespec *now)
+{
+	struct timespec tst;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now->tv_sec) > 5)
+			return pr_fail("%s: unexpected value: %ld (%ld)\n",
+					tst.tv_sec, now->tv_sec);
+	}
+	if (check_in_thread(now))
+		return 1;
+	ksft_test_result_pass("%s\n", tst_name);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct timespec now;
+	int status;
+	pid_t pid;
+
+	if (argc > 1) {
+		char *endptr;
+
+		ksft_cnt.ksft_pass = 2;
+		now.tv_sec = strtoul(argv[1], &endptr, 0);
+		if (*endptr != 0)
+			return pr_perror("strtoul");
+
+		return check("child after exec", &now);
+	}
+
+	nscheck();
+
+	ksft_set_plan(5);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, OFFSET))
+		return 1;
+
+	if (check("parent before vfork", &now))
+		return 1;
+
+	pid = vfork();
+	if (pid < 0)
+		return pr_perror("fork");
+
+	if (pid == 0) {
+		char now_str[64];
+		char *cargv[] = {"exec", now_str, NULL};
+		char *cenv[] = {NULL};
+
+		// Check that we are still in the source timens.
+		if (check("child before exec", &now))
+			return 1;
+
+		/* Check for proper vvar offsets after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		return pr_perror("execve");
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waitpid");
+
+	if (status)
+		ksft_exit_fail();
+	ksft_inc_pass_cnt();
+	ksft_test_result_pass("wait for child\n");
+
+	// Check that we are still in the source timens.
+	if (check("parent after vfork", &now))
+		return 1;
+
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.37.3.968.ga6b4b080e4-goog

