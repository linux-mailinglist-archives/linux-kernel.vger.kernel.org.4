Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D253C68739E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjBBDFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjBBDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:04:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18F4F9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:04:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w70-20020a25df49000000b00803e799d7b1so507644ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKLf+0DEpMILqySSAP1sw/8VMjgM3KlxQ+ceqnrNMA=;
        b=OjSDkF66rYI0/30G2OZKAzATIab+sipSIvxmX/4VcQzuNEknRB+a+b++Vob7ZQSIlQ
         FyWDvtR7f3YzL3qKW1LWRWqX9AO7RKYugwsN0KPd9fa2TE5HuPP1zGZ7XPXXQm/8bwaX
         v2t4Y15BwDYY7wG4QyadN4IjhIVGL/0bCfCyfZkrT+s69Hk+2HfE4LpG/kjcTqiMqsyp
         5W6y1HxuDbSpHEc8WWwh8eTGZTGAzHW0iKknI3rXNnJglvDeUvq2+Qq1ay5D1tUG6S56
         O64OMi3K3Fr/6lyrAJSS0rJ2818UWy1hoKyujwUyfDMbTWVzZ93kERKvVuyzziU7258n
         3vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKLf+0DEpMILqySSAP1sw/8VMjgM3KlxQ+ceqnrNMA=;
        b=uHRfh+Em/+ld1KuhjRff2/Of5CBvBECYxsG5AtYZMDnCcA2ezufn70WRqKYuHg7cc+
         DanNMFyZGpHb4IIprn6j9ze3ufg3mopf7wXJhxkkwTMVakWztpvWGurAWDIrabN6Lg6y
         soOZba6WHPRRrRGFkhxfrrYd6ztreLCxL9YvxWt8k3XB2rdJETTLcjkfageX3U0vMmSI
         ac7tKOclFPNMUK3XeR5DEx6fzReUi7x5XMOZr/ytTrJmiUia8HIFwBppJBGA3UrA/NjT
         aX1+YgxG1lk2geLkl/1vBmsYFdBljiEZwZwgSiAdnIsIO7HC3iWlN7nCHV1gPZ3Qy1tO
         1X1w==
X-Gm-Message-State: AO0yUKXHsmwX6wiaJK38rrLk+OJ6rf9bchIN2msMUAkFTvHFBqnp3J47
        p8wukoVC4CZLEqDKo7o8x7lHVzKINVU=
X-Google-Smtp-Source: AK7set8QSkSq5imXo2faQJhYwtbx40hwJABliwT3ELoDpmni0J0/xHck9MrzjRQ77H5BBuWO+Gt8C5DNZ2I=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:eee0:dc42:a911:8b59])
 (user=avagin job=sendgmr) by 2002:a81:1e13:0:b0:521:e0df:90e1 with SMTP id
 e19-20020a811e13000000b00521e0df90e1mr0ywe.3.1675307087727; Wed, 01 Feb 2023
 19:04:47 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:04:29 -0800
In-Reply-To: <20230202030429.3304875-1-avagin@google.com>
Mime-Version: 1.0
References: <20230202030429.3304875-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202030429.3304875-7-avagin@google.com>
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
index 60a89dba01b6..c0c74befc8df 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -14,3 +14,6 @@
 #ifndef __NR_setns
 # define __NR_setns 346
 #endif
+#ifdef __NR_seccomp
+#define __NR_seccomp 354
+#endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index cb52a3a8b8fc..b695246da684 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -14,3 +14,6 @@
 #ifndef __NR_setns
 #define __NR_setns 308
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
index a5d49b3b6a09..40657b0959a9 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -21,6 +21,7 @@ extern struct timeval bench__start, bench__end, bench__runtime;
 int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
+int bench_sched_seccomp_notify(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
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
index 334ab897aae3..71044575c571 100644
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
2.39.1.456.gfc5497dd1b-goog

