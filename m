Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43862257E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKIIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiKIIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:30:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CA9122B19;
        Wed,  9 Nov 2022 00:29:20 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx37fYZGtjh4EFAA--.12874S3;
        Wed, 09 Nov 2022 16:29:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuPTZGtjJnIPAA--.42697S6;
        Wed, 09 Nov 2022 16:29:11 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v4 4/4] perf bench syscall: Add execve syscall benchmark
Date:   Wed,  9 Nov 2022 16:29:07 +0800
Message-Id: <1667982547-22331-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
References: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxtuPTZGtjJnIPAA--.42697S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAF13JryxJF1UCw1rAF4ktFb_yoWrCFy3pF
        s7Ca18Jws5WFWYvr13tr1DKFy3Awn7Zry5Kw17C3yDZr42g343tr42gFy3GF17XwsrK343
        uFs7Zry8Wa1rXaUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the execve syscall benchmark, more syscall
benchmarks can be added in the future.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/syscall.c                  | 36 +++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c                  |  1 +
 5 files changed, 44 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 2bcf47f..d20b43c 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NR_execve
+#define __NR_execve 11
+#endif
 #ifndef __NR_getppid
 #define __NR_getppid 64
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 5472203..80d4d90 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NR_execve
+#define __NR_execve 59
+#endif
 #ifndef __NR_getppid
 #define __NR_getppid 110
 #endif
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 7ccc021..9d6f692 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -35,6 +35,7 @@ int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_getpgrp(int argc, const char **argv);
+int bench_syscall_execve(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 2b89884..c71334c 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -14,6 +14,7 @@
 #include <sys/time.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <unistd.h>
 #include <stdlib.h>
 
@@ -30,6 +31,27 @@ static const char * const bench_syscall_usage[] = {
 	NULL
 };
 
+static void test_execve(void)
+{
+	const char *pathname = "/bin/true";
+	char *const argv[] = { (char *)pathname, NULL };
+	pid_t pid = fork();
+
+	if (pid < 0) {
+		fprintf(stderr, "fork failed\n");
+		exit(1);
+	} else if (pid == 0) {
+		execve(pathname, argv, NULL);
+		fprintf(stderr, "execve /bin/true failed\n");
+		exit(1);
+	} else {
+		if (waitpid(pid, NULL, 0) < 0) {
+			fprintf(stderr, "waitpid failed\n");
+			exit(1);
+		}
+	}
+}
+
 static int bench_syscall_common(int argc, const char **argv, int syscall)
 {
 	struct timeval start, stop, diff;
@@ -49,6 +71,12 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 		case __NR_getpgrp:
 			getpgrp();
 			break;
+		case __NR_execve:
+			test_execve();
+			/* Only loop 10000 times to save time */
+			if (i == 10000)
+				loops = 10000;
+			break;
 		default:
 			break;
 		}
@@ -64,6 +92,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	case __NR_getpgrp:
 		name = "getpgrp()";
 		break;
+	case __NR_execve:
+		name = "execve()";
+		break;
 	default:
 		break;
 	}
@@ -111,3 +142,8 @@ int bench_syscall_getpgrp(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_getpgrp);
 }
+
+int bench_syscall_execve(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_execve);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 20ca4ac..ace7a2a 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -53,6 +53,7 @@ static struct bench sched_benchmarks[] = {
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
 	{ "getpgrp",	"Benchmark for getpgrp(2) calls",		bench_syscall_getpgrp	},
+	{ "execve",	"Benchmark for execve(2) calls",		bench_syscall_execve    },
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
 };
-- 
2.1.0

