Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B04B5F61D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJFHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJFHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:42:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C158E471;
        Thu,  6 Oct 2022 00:42:20 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+DThj5jofAmAA--.13239S5;
        Thu, 06 Oct 2022 15:42:13 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] perf bench syscall: Add execve syscall benchmark
Date:   Thu,  6 Oct 2022 15:42:10 +0800
Message-Id: <1665042130-15786-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
References: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxX+DThj5jofAmAA--.13239S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtr48tF1UGry5JFWfZw4rAFb_yoW7WrWUpF
        s7C3W8Jw4rWFyayw13Jr1qgFy3Awn7Xr15Kr1akw4DZr4xX34jqr42ga4FkF17Wws7Kay3
        uF4kZrW8Wan5XaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8CwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bYFxUUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the execve syscall benchmark, more syscall
benchmarks can be added in the future.

Here are the test results:

  [loongson@linux perf]$ ./perf bench syscall

          # List of available benchmarks for collection 'syscall':

           basic: Benchmark for basic getppid(2) calls
           close: Benchmark for close(2) calls
          execve: Benchmark for execve(2) calls
             all: Run all syscall benchmarks

  [loongson@linux perf]$ ./perf bench syscall execve
  # Running 'syscall/execve' benchmark:
  # Executed 10000 execve() calls
       Total time: 4.827 [sec]

       482.761800 usecs/op
             2071 ops/sec
  [loongson@linux perf]$ ./perf bench syscall all
  # Running syscall/basic benchmark...
  # Executed 10000000 getppid() calls
       Total time: 1.956 [sec]

         0.195692 usecs/op
          5110065 ops/sec

  # Running syscall/close benchmark...
  # Executed 10000000 close() calls
       Total time: 6.306 [sec]

         0.630692 usecs/op
          1585558 ops/sec

  # Running syscall/execve benchmark...
  # Executed 10000 execve() calls
       Total time: 4.842 [sec]

       484.299500 usecs/op
             2064 ops/sec

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/syscall.c                  | 36 +++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c                  |  1 +
 5 files changed, 44 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 2f24b0eb..0c65a2c 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -5,6 +5,9 @@
 #ifndef __NR_close
 # define __NR_close 6
 #endif
+#ifndef __NR_execve
+# define __NR_execve 11
+#endif
 #ifndef __NR_futex
 # define __NR_futex 240
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 8eb32b2..7427910 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -5,6 +5,9 @@
 #ifndef __NR_close
 # define __NR_close 3
 #endif
+#ifndef __NR_execve
+# define __NR_execve 59
+#endif
 #ifndef __NR_futex
 # define __NR_futex 202
 #endif
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 916cd47..6ca3327 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -35,6 +35,7 @@ int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_close(int argc, const char **argv);
+int bench_syscall_execve(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 058394b..c8f8bee 100644
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
 		case __NR_close:
 			close(dup(0));
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
 	case __NR_close:
 		name = "close()";
 		break;
+	case __NR_execve:
+		name = "execve()";
+		break;
 	default:
 		break;
 	}
@@ -111,3 +142,8 @@ int bench_syscall_close(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_close);
 }
+
+int bench_syscall_execve(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_execve);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index b63c711..6f9ff75 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -53,6 +53,7 @@ static struct bench sched_benchmarks[] = {
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
 	{ "close",	"Benchmark for close(2) calls",			bench_syscall_close	},
+	{ "execve",	"Benchmark for execve(2) calls",		bench_syscall_execve	},
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
 };
-- 
2.1.0

