Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103C75F61D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJFHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJFHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:42:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09D238E475;
        Thu,  6 Oct 2022 00:42:20 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+DThj5jofAmAA--.13239S4;
        Thu, 06 Oct 2022 15:42:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] perf bench syscall: Add close syscall benchmark
Date:   Thu,  6 Oct 2022 15:42:09 +0800
Message-Id: <1665042130-15786-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
References: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxX+DThj5jofAmAA--.13239S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13tw4xuw43Wr13KrWDtwb_yoWrCw1fpF
        srCw18Jr4FgFWYyw17JF1qgry3AwnrXr15Kw1Ykw4DZ3yxX34aqr4xKa4FkF17Xw42kay5
        ur4kZFWjga1rXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8CwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bz9aPUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a simple close syscall benchmark, more syscall
benchmarks can be added in the future.

Here are the test results:

  [loongson@linux perf]$ ./perf bench syscall

          # List of available benchmarks for collection 'syscall':

           basic: Benchmark for basic getppid(2) calls
           close: Benchmark for close(2) calls
             all: Run all syscall benchmarks

  [loongson@linux perf]$ ./perf bench syscall basic
  # Running 'syscall/basic' benchmark:
  # Executed 10000000 getppid() calls
       Total time: 1.956 [sec]

         0.195687 usecs/op
          5110201 ops/sec
  [loongson@linux perf]$ ./perf bench syscall close
  # Running 'syscall/close' benchmark:
  # Executed 10000000 close() calls
       Total time: 6.302 [sec]

         0.630297 usecs/op
          1586553 ops/sec
  [loongson@linux perf]$ ./perf bench syscall all
  # Running syscall/basic benchmark...
  # Executed 10000000 getppid() calls
       Total time: 1.956 [sec]

         0.195686 usecs/op
          5110232 ops/sec

  # Running syscall/close benchmark...
  # Executed 10000000 close() calls
       Total time: 6.302 [sec]

         0.630271 usecs/op
          1586619 ops/sec

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/syscall.c                  | 11 +++++++++++
 tools/perf/builtin-bench.c                  |  1 +
 5 files changed, 19 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 4a480a0..2f24b0eb 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -2,6 +2,9 @@
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 336
 #endif
+#ifndef __NR_close
+# define __NR_close 6
+#endif
 #ifndef __NR_futex
 # define __NR_futex 240
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 860257f..8eb32b2 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -2,6 +2,9 @@
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 298
 #endif
+#ifndef __NR_close
+# define __NR_close 3
+#endif
 #ifndef __NR_futex
 # define __NR_futex 202
 #endif
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6cefb43..916cd47 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -34,6 +34,7 @@ int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
+int bench_syscall_close(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 746fd71..058394b 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 		case __NR_getppid:
 			getppid();
 			break;
+		case __NR_close:
+			close(dup(0));
+			break;
 		default:
 			break;
 		}
@@ -58,6 +61,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	case __NR_getppid:
 		name = "getppid()";
 		break;
+	case __NR_close:
+		name = "close()";
+		break;
 	default:
 		break;
 	}
@@ -100,3 +106,8 @@ int bench_syscall_basic(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_getppid);
 }
+
+int bench_syscall_close(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_close);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334ab89..b63c711 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -52,6 +52,7 @@ static struct bench sched_benchmarks[] = {
 
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
+	{ "close",	"Benchmark for close(2) calls",			bench_syscall_close	},
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
 };
-- 
2.1.0

