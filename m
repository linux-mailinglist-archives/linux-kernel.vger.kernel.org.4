Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FE5EF0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiI2IxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiI2IxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:53:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFFAC138F21;
        Thu, 29 Sep 2022 01:53:02 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+DjXDVjbLIjAA--.3247S3;
        Thu, 29 Sep 2022 16:52:53 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] perf bench syscall: Introduce bench_syscall_common()
Date:   Thu, 29 Sep 2022 16:52:49 +0800
Message-Id: <1664441571-31349-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664441571-31349-1-git-send-email-yangtiezhu@loongson.cn>
References: <1664441571-31349-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxT+DjXDVjbLIjAA--.3247S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWfuF4fKrWfXw47Xr15twb_yoW8Zry5pF
        srCw4rtr4rCa1Sva1fXr4v9ryrJr97JF1YkrnF9ws8Aw47X345tw42ga4FvF17urWxKFW5
        Wan5ZryrWF45ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r43MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0FtC5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, there is only a basic syscall benchmark via getppid,
this is not enough. Introduce bench_syscall_common() so that we can add
more syscalls to benchmark. This is preparation for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/bench/syscall.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 9b75101..51840e9 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -16,6 +16,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <asm/unistd.h>
 
 #define LOOPS_DEFAULT 10000000
 static	int loops = LOOPS_DEFAULT;
@@ -30,25 +31,41 @@ static const char * const bench_syscall_usage[] = {
 	NULL
 };
 
-int bench_syscall_basic(int argc, const char **argv)
+static int bench_syscall_common(int argc, const char **argv, int syscall)
 {
 	struct timeval start, stop, diff;
 	unsigned long long result_usec = 0;
+	const char *name = NULL;
 	int i;
 
 	argc = parse_options(argc, argv, options, bench_syscall_usage, 0);
 
 	gettimeofday(&start, NULL);
 
-	for (i = 0; i < loops; i++)
-		getppid();
+	for (i = 0; i < loops; i++) {
+		switch (syscall) {
+		case __NR_getppid:
+			getppid();
+			break;
+		default:
+			break;
+		}
+	}
 
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	switch (syscall) {
+	case __NR_getppid:
+		name = "getppid()";
+		break;
+	default:
+		break;
+	}
+
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# Executed %'d getppid() calls\n", loops);
+		printf("# Executed %'d %s calls\n", loops, name);
 
 		result_usec = diff.tv_sec * 1000000;
 		result_usec += diff.tv_usec;
@@ -79,3 +96,8 @@ int bench_syscall_basic(int argc, const char **argv)
 
 	return 0;
 }
+
+int bench_syscall_basic(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_getppid);
+}
-- 
2.1.0

