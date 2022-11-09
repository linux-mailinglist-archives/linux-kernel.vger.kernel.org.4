Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3C62257D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKIIaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiKIIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:30:19 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 426AD22B10;
        Wed,  9 Nov 2022 00:29:19 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxTtvXZGtjgYEFAA--.17858S3;
        Wed, 09 Nov 2022 16:29:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuPTZGtjJnIPAA--.42697S5;
        Wed, 09 Nov 2022 16:29:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v4 3/4] perf bench syscall: Add getpgrp syscall benchmark
Date:   Wed,  9 Nov 2022 16:29:06 +0800
Message-Id: <1667982547-22331-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
References: <1667982547-22331-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxtuPTZGtjJnIPAA--.42697S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAF17Zr13ZFWUZF4rury8Zrb_yoW5uw43pF
        97Cw48Aw4rWFWYvw1Iqr10gry7AwnrZryrK3Wak3yDZrW2q343tr47KFy3WF17Zw47ta45
        uFs7ZrW8X3WrJaUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a simple getpgrp syscall benchmark, more syscall
benchmarks can be added in the future.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/syscall.c                  | 11 +++++++++++
 tools/perf/builtin-bench.c                  |  1 +
 5 files changed, 19 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 4d8873a..2bcf47f 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -2,6 +2,9 @@
 #ifndef __NR_getppid
 #define __NR_getppid 64
 #endif
+#ifndef __NR_getpgrp
+#define __NR_getpgrp 65
+#endif
 #ifndef __NR_gettid
 #define __NR_gettid 224
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index e29038a..5472203 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -2,6 +2,9 @@
 #ifndef __NR_getppid
 #define __NR_getppid 110
 #endif
+#ifndef __NR_getpgrp
+#define __NR_getpgrp 111
+#endif
 #ifndef __NR_gettid
 #define __NR_gettid 186
 #endif
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6cefb43..7ccc021 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -34,6 +34,7 @@ int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
+int bench_syscall_getpgrp(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 746fd71..2b89884 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 		case __NR_getppid:
 			getppid();
 			break;
+		case __NR_getpgrp:
+			getpgrp();
+			break;
 		default:
 			break;
 		}
@@ -58,6 +61,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
 	case __NR_getppid:
 		name = "getppid()";
 		break;
+	case __NR_getpgrp:
+		name = "getpgrp()";
+		break;
 	default:
 		break;
 	}
@@ -100,3 +106,8 @@ int bench_syscall_basic(int argc, const char **argv)
 {
 	return bench_syscall_common(argc, argv, __NR_getppid);
 }
+
+int bench_syscall_getpgrp(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_getpgrp);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334ab89..20ca4ac 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -52,6 +52,7 @@ static struct bench sched_benchmarks[] = {
 
 static struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
+	{ "getpgrp",	"Benchmark for getpgrp(2) calls",		bench_syscall_getpgrp	},
 	{ "all",	"Run all syscall benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			},
 };
-- 
2.1.0

