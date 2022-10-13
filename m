Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C685FDF07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJMRc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJMRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:32:20 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A342AFA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:32:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t4-20020a635344000000b0045fe7baa222so1317838pgl.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8u+hgvJpV2RLc9pF5WRMAByTAsRBKjLPupAxkHW1mwo=;
        b=D6beqXRqD3CIlyKCMmoRmnzqDJXUkSJtHxyHzvZzMiBvIXvelwBHmQ+ty2AvhQ1UhF
         0Y5omFVC4kb2Lv3UezFWTb6L+UrQpBLL8PKuxO/5GDAfNL/uM4fTlJ9EUwkbHQsrWFBt
         cAUaPAW1yZ3X9Wtn0MlM2floDdPI0AB9LQoOWZip98GrpxXE+fFq0B1lVx9uatvTSxiH
         YuQ+ANaIjXuKpVTmYUFRi+VSscWWtAT+eiVH8Q0Yuwd5pVO9r/cU4T1Vdm8egmtSQGq5
         iH7YxGU7iCAXZfIQfHxx7l3+u+zauH60zzJ8/fysSbz5HL8xtDb0kRahN6NF1EbtRx/n
         tpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8u+hgvJpV2RLc9pF5WRMAByTAsRBKjLPupAxkHW1mwo=;
        b=g5NmBATLvl0ijzYOo+vFVbU/+3Luy8DindPnc5Vm7qFBAaBpZX4nYzUcL8NWvkZjEj
         05S7GChevQC9nY4Ltf+pUbey0IM82pR26pNADkkMzvAyNjI/TsBViePyjQ9ipMuEl7jC
         s71VCQipq0QNvKtlhzkbnv2zNGrhRPIUYoiz8yUZ7K2UliR8u4hVz5FQui5GoYN0V+Y2
         OwZ2Klav834drs4j1B661ObTFwq9G5EHuY8NiGtyBzMyNMcNWc0PBC4h8udsH49rGtWZ
         Pxu6mBjGrB7UiTwdpwR4Uo3tbe6PfDYkaicPSsSK0VYqPFZJfx86/XQmeAEKhAWxV6wB
         YegA==
X-Gm-Message-State: ACrzQf0kj6P3vgtbFnE6+nw5xi0l4hUt/N4yOQPJt9XUrzgCjx2iS1ol
        XnxJ/9r6gfzCez5Rwu1Su7hN/35QyuQ=
X-Google-Smtp-Source: AMsMyM6qAj9GSZOgj0//ZsiqvXbT00vOfUd/0pEO89PaadebqMrYrq/yDY5ecqYJo31wYGQCgw/T6nBihRw=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b57b:3671:bf6b:826d])
 (user=avagin job=sendgmr) by 2002:a05:6a00:a21:b0:562:99d6:c30a with SMTP id
 p33-20020a056a000a2100b0056299d6c30amr849551pfh.35.1665682336743; Thu, 13 Oct
 2022 10:32:16 -0700 (PDT)
Date:   Thu, 13 Oct 2022 10:31:54 -0700
In-Reply-To: <20220921003120.209637-2-avagin@google.com>
Mime-Version: 1.0
References: <20220921003120.209637-2-avagin@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013173154.291597-1-avagin@google.com>
Subject: [PATCH 2/2 v2] selftests/timens: add a test for vfork+exit
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
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
 1..4
 ok 1 parent before vfork
 ok 2 child after exec
 ok 3 wait for child
 ok 4 parent after vfork
 # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---

v2: - don't create threads from a vfork-ed process.
    - use _exit to exit from a vfork-ed process.

 tools/testing/selftests/timens/.gitignore   |   1 +
 tools/testing/selftests/timens/Makefile     |   2 +-
 tools/testing/selftests/timens/vfork_exec.c | 139 ++++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletion(-)
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
index 000000000000..fe3d0e15aa7e
--- /dev/null
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -0,0 +1,139 @@
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
+struct thread_args {
+	char *tst_name;
+	struct timespec *now;
+};
+
+static void *tcheck(void *_args)
+{
+	struct thread_args *args = _args;
+	struct timespec *now = args->now, tst;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
+				args->tst_name, tst.tv_sec, now->tv_sec);
+			return (void *)1UL;
+		}
+	}
+	return NULL;
+}
+
+static int check_in_thread(char *tst_name, struct timespec *now)
+{
+	struct thread_args args = {
+		.tst_name = tst_name,
+		.now = now,
+	};
+	pthread_t th;
+	void *retval;
+
+	if (pthread_create(&th, NULL, tcheck, &args))
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
+					tst_name, tst.tv_sec, now->tv_sec);
+	}
+	if (check_in_thread(tst_name, now))
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
+		ksft_cnt.ksft_pass = 1;
+		now.tv_sec = strtoul(argv[1], &endptr, 0);
+		if (*endptr != 0)
+			return pr_perror("strtoul");
+
+		return check("child after exec", &now);
+	}
+
+	nscheck();
+
+	ksft_set_plan(4);
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
+		/* Check for proper vvar offsets after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		pr_perror("execve");
+		_exit(1);
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
+	/* Check that we are still in the source timens. */
+	if (check("parent after vfork", &now))
+		return 1;
+
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.38.0.413.g74048e4d9e-goog

