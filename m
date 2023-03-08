Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516676AFFBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCHHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCHHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:35 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF9DA72AB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:23 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c3-20020a170902724300b0019d1ffec36dso8964686pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGMLdMm5qBcc4olci9fMTmM3WsrESinWs9N+BXJl1jg=;
        b=eFnDR5mgN514m3UH4vGPG8H/G2XQBLtJr7TNKaPz0nsq7dq76gfvLoTW7/l4eG+xYr
         YUQ1k3uwseN1igCqXa9gcvETdz0XyZpT3I+OQuNMaDbvJlCbYYV5lgkcQBwGonABEF8j
         pgYLWtwBIsNJfPsTyka0p8zl8wPxIcExK8RIKT977hgU9yOuPhPC40JRiMlYPTWzCGqW
         6XQoHCjwSaRJHbEjWZ+BIxSK+UWIVQlKogIDm4yddmh3nEuE1CxXkUrKtNce2oHKYCA5
         fzkkKx2mo2/d3Cj0zdYivbxeCQPpYqsDawTxkcsG8Bh0HETbo5KlQ27bWcRTpcLQi9lp
         xu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGMLdMm5qBcc4olci9fMTmM3WsrESinWs9N+BXJl1jg=;
        b=6bnIoNcJI7iwwEArnjIP6dy64OI4dYTuNjBGQfvyjlSt1/V4VA8O3pI1r07k9bDoS+
         YiWO20NCuJsUO6Q3RbOuSBnE07aQ/GWLx1UaoTnz08/MpWA0ctLbC+PuxBgh6o6EJ6lv
         4oLBX1HJ6OYRaZwSd94SNQ7muorPfKfWpy8E+yUCp4xbKEljFv3RjzUQY0H44jfs2n68
         qj9CSB2L3qK3yTmBwktt2t4HfCcDV1uYJOGgfGotGeqBrZvNJyAoHfRnkfF2end+K6VD
         f0Mr3w3KhtschQDJ/2jW3xyHaiJG2qEgK4zpPRyCFYyFRZZ8VfNMWNSLRNTrSr2OYIVI
         vJ/Q==
X-Gm-Message-State: AO0yUKU+PCXO8VDB997H60w2Dy9Y2nolAoEThRMWiae/JREcHmfAbxfy
        +zv2c/eEKrJpBegMputa8ICQcliAZVA=
X-Google-Smtp-Source: AK7set8ruj/89TGB01UGqmLIMQktUAo34UCOgYtMeyvgGSvOvoKTHIUgkmK7x3uiz9IunReEVbwB+mgNqPc=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a63:fd41:0:b0:503:a7:c934 with SMTP id
 m1-20020a63fd41000000b0050300a7c934mr7076545pgj.2.1678260742857; Tue, 07 Mar
 2023 23:32:22 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:32:01 -0800
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-7-avagin@google.com>
Subject: [PATCH 6/6] perf/benchmark: add a new benchmark for seccom_unotify
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Andrei Vagin <avagin@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The benchmark is similar to the pipe benchmark. It creates two processes,
one is calling syscalls, and another process is handling them via seccomp
user notifications. It measures the time required to run a specified number
of interations.

 $ ./perf bench sched  seccomp-notify --sync-mode --loop 1000000
 # Running 'sched/seccomp-notify' benchmark:
 # Executed 1000000 system calls

     Total time: 2.769 [sec]

       2.769629 usecs/op
         361059 ops/sec

 $ ./perf bench sched  seccomp-notify
 # Running 'sched/seccomp-notify' benchmark:
 # Executed 1000000 system calls

     Total time: 8.571 [sec]

       8.571119 usecs/op
         116670 ops/sec

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |   3 +
 tools/arch/x86/include/uapi/asm/unistd_64.h |   3 +
 tools/perf/bench/Build                      |   1 +
 tools/perf/bench/bench.h                    |   1 +
 tools/perf/bench/sched-seccomp-notify.c     | 168 ++++++++++++++++++++
 tools/perf/builtin-bench.c                  |   1 +
 6 files changed, 177 insertions(+)
 create mode 100644 tools/perf/bench/sched-seccomp-notify.c

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 2712d5e03e2e..5fb3589c14bf 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -23,3 +23,6 @@
 #ifndef __NR_setns
 #define __NR_setns 346
 #endif
+#ifdef __NR_seccomp
+#define __NR_seccomp 354
+#endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index a6f7fe84d4df..e0549617f9d7 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -23,3 +23,6 @@
 #ifndef __NR_getcpu
 #define __NR_getcpu 309
 #endif
+#ifndef __NR_seccomp
+#define __NR_seccomp 317
+#endif
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 6b6155a8ad09..e3ec2c1b0682 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -1,5 +1,6 @@
 perf-y += sched-messaging.o
 perf-y += sched-pipe.o
+perf-y += sched-seccomp-notify.o
 perf-y += syscall.o
 perf-y += mem-functions.o
 perf-y += futex-hash.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index e43893151a3e..9d28510fcf9d 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -21,6 +21,7 @@ extern struct timeval bench__start, bench__end, bench__runtime;
 int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
+int bench_sched_seccomp_notify(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_getpgid(int argc, const char **argv);
 int bench_syscall_execve(int argc, const char **argv);
diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
new file mode 100644
index 000000000000..443f4b43702d
--- /dev/null
+++ b/tools/perf/bench/sched-seccomp-notify.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <subcmd/parse-options.h>
+#include "bench.h"
+
+#include <uapi/linux/filter.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <linux/unistd.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <linux/time64.h>
+#include <linux/seccomp.h>
+#include <sys/prctl.h>
+
+#include <unistd.h>
+#include <limits.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <string.h>
+#include <errno.h>
+#include <assert.h>
+
+#define LOOPS_DEFAULT 1000000UL
+static uint64_t loops = LOOPS_DEFAULT;
+static bool sync_mode;
+
+static const struct option options[] = {
+	OPT_U64('l', "loop",	&loops,		"Specify number of loops"),
+	OPT_BOOLEAN('s', "sync-mode", &sync_mode,
+		    "Enable the synchronious mode for seccomp notifications"),
+	OPT_END()
+};
+
+static const char * const bench_seccomp_usage[] = {
+	"perf bench sched secccomp-notify <options>",
+	NULL
+};
+
+static int seccomp(unsigned int op, unsigned int flags, void *args)
+{
+	return syscall(__NR_seccomp, op, flags, args);
+}
+
+static int user_notif_syscall(int nr, unsigned int flags)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, nr, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	return seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
+}
+
+#define USER_NOTIF_MAGIC INT_MAX
+static void user_notification_sync_loop(int listener)
+{
+	struct seccomp_notif_resp resp;
+	struct seccomp_notif req;
+	uint64_t nr;
+
+	for (nr = 0; nr < loops; nr++) {
+		memset(&req, 0, sizeof(req));
+		assert(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req) == 0);
+
+		assert(req.data.nr == __NR_gettid);
+
+		resp.id = req.id;
+		resp.error = 0;
+		resp.val = USER_NOTIF_MAGIC;
+		resp.flags = 0;
+		assert(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp) == 0);
+	}
+}
+
+#ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
+#endif
+int bench_sched_seccomp_notify(int argc, const char **argv)
+{
+	struct timeval start, stop, diff;
+	unsigned long long result_usec = 0;
+	int status, listener;
+	pid_t pid;
+	long ret;
+
+	argc = parse_options(argc, argv, options, bench_seccomp_usage, 0);
+
+	gettimeofday(&start, NULL);
+
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	listener = user_notif_syscall(__NR_gettid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	assert(listener >= 0);
+
+	pid = fork();
+	assert(pid >= 0);
+	if (pid == 0) {
+		assert(prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0) == 0);
+		while (1) {
+			ret = syscall(__NR_gettid);
+			if (ret == USER_NOTIF_MAGIC)
+				continue;
+			break;
+		}
+		_exit(1);
+	}
+
+	if (sync_mode) {
+		assert(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
+			     SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0) == 0);
+	}
+	user_notification_sync_loop(listener);
+
+	kill(pid, SIGKILL);
+	assert(waitpid(pid, &status, 0) == pid);
+	assert(WIFSIGNALED(status));
+	assert(WTERMSIG(status) == SIGKILL);
+
+	gettimeofday(&stop, NULL);
+	timersub(&stop, &start, &diff);
+
+	switch (bench_format) {
+	case BENCH_FORMAT_DEFAULT:
+		printf("# Executed %lu system calls\n\n",
+			loops);
+
+		result_usec = diff.tv_sec * USEC_PER_SEC;
+		result_usec += diff.tv_usec;
+
+		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
+		       (unsigned long) diff.tv_sec,
+		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
+
+		printf(" %14lf usecs/op\n",
+		       (double)result_usec / (double)loops);
+		printf(" %14d ops/sec\n",
+		       (int)((double)loops /
+			     ((double)result_usec / (double)USEC_PER_SEC)));
+		break;
+
+	case BENCH_FORMAT_SIMPLE:
+		printf("%lu.%03lu\n",
+		       (unsigned long) diff.tv_sec,
+		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
+		break;
+
+	default:
+		/* reaching here is something disaster */
+		fprintf(stderr, "Unknown format:%d\n", bench_format);
+		exit(1);
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 814e9afc86f6..db57813fe4e5 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -46,6 +46,7 @@ static struct bench numa_benchmarks[] = {
 static struct bench sched_benchmarks[] = {
 	{ "messaging",	"Benchmark for scheduling and IPC",		bench_sched_messaging	},
 	{ "pipe",	"Benchmark for pipe() between two processes",	bench_sched_pipe	},
+	{ "seccomp-notify",	"Benchmark for seccomp user notify",	bench_sched_seccomp_notify},
 	{ "all",	"Run all scheduler benchmarks",		NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

