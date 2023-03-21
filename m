Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2A6C2AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCUG5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCUG5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:57:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582D3279AE;
        Mon, 20 Mar 2023 23:57:05 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJMQ_VRlk6kYPAA--.11168S3;
        Tue, 21 Mar 2023 14:57:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx8eQ+VRlkSE0IAA--.35439S2;
        Tue, 21 Mar 2023 14:57:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] perf bench syscall: Add fork syscall benchmark
Date:   Tue, 21 Mar 2023 14:57:01 +0800
Message-Id: <1679381821-22736-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cx8eQ+VRlkSE0IAA--.35439S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFW7JFWktrWDAr1DKrW7Arb_yoWrtFW5pF
        s7C3W8Ja1ruFWYvw13tr1qgF9xAwn2qr15K3Zakws8Zr47W343tr4xWFWagF17Ww4kta45
        uF4kZrW8Wa1rXaUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I
        6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8loGPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up patch for the execve bench which is actually
fork + execve, it makes sense to add the fork syscall benchmark
to compare the execve part precisely.

Some archs have no __NR_fork definition which is used only as a
check condition to call test_fork(), let us just define it as -1
to avoid build error.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  4 ++--
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/syscall.c                  | 35 +++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c                  |  1 +
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 2712d5e..b8ddfc4 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_execve
-#define __NR_execve 11
+#ifndef __NR_fork
+#define __NR_fork 2
 #endif
 #ifndef __NR_getppid
 #define __NR_getppid 64
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index a6f7fe8..f70d2cad 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NR_fork
+#define __NR_fork 57
+#endif
 #ifndef __NR_execve
 #define __NR_execve 59
 #endif
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index e438931..edfc257 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -23,6 +23,7 @@ int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_getpgid(int argc, const char **argv);
+int bench_syscall_fork(int argc, const char **argv);
 int bench_syscall_execve(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index fe79f7f..ea4dfc07 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -18,6 +18,10 @@
 #include <unistd.h>
 #include <stdlib.h>
 
+#ifndef __NR_fork
+#define __NR_fork -1
+#endif
+
 #define LOOPS_DEFAULT 10000000
 static	int loops = LOOPS_DEFAULT;
 
@@ -31,6 +35,23 @@ static const char * const bench_syscall_usage[] = {
 	NULL
 };
 
+static void test_fork(void)
+{
+	pid_t pid = fork();
+
+	if (pid < 0) {
+		fprintf(stderr, "fork failed\n");
+		exit(1);
+	} else if (pid == 0) {
+		exit(0);
+	} else {
+		if (waitpid(pid, NULL, 0) < 0) {
+			fprintf(stderr, "waitpid failed\n");
+			exit(1);
+		}
+	}
+}
+
 static void test_execve(void)
 {
 	const char *pathname = "/bin/true";
@@ -71,6 +92,12 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 		case __NR_getpgid:
 			getpgid(0);
 			break;
+		case __NR_fork:
+			test_fork();
+			/* Only loop 10000 times to save time */
+			if (i == 10000)
+				loops = 10000;
+			break;
 		case __NR_execve:
 			test_execve();
 			/* Only loop 10000 times to save time */
@@ -92,6 +119,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	case __NR_getpgid:
 		name = "getpgid()";
 		break;
+	case __NR_fork:
+		name = "fork()";
+		break;
 	case __NR_execve:
 		name = "execve()";
 		break;
@@ -143,6 +173,11 @@ int bench_syscall_getpgid(int argc, const char **argv)
 	return bench_syscall_common(argc, argv, __NR_getpgid);
 }
 
+int bench_syscall_fork(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_fork);
+}
+
 int bench_syscall_execve(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_execve);
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 814e9af..d0fcc3c 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -53,6 +53,7 @@ static struct bench sched_benchmarks[] = {
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
 	{ "getpgid",	"Benchmark for getpgid(2) calls",		bench_syscall_getpgid	},
+	{ "fork",	"Benchmark for fork(2) calls",			bench_syscall_fork	},
 	{ "execve",	"Benchmark for execve(2) calls",		bench_syscall_execve	},
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
-- 
2.1.0

