Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3965F61D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJFHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiJFHmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:42:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09E128E9BB;
        Thu,  6 Oct 2022 00:42:20 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+DThj5jofAmAA--.13239S3;
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
Subject: [PATCH v3 1/3] perf bench syscall: Introduce bench_syscall_common()
Date:   Thu,  6 Oct 2022 15:42:08 +0800
Message-Id: <1665042130-15786-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
References: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxX+DThj5jofAmAA--.13239S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWruF18GryUKrW7Gw1fCrg_yoW5Wr4UpF
        9rAw48Ja1ruayavw1fXF10grW5Jr93Cr45Kry293s5ZFWxt343Jr47KF9IvF17W3yxKa45
        WF48ZryUWa1UXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8CwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jrmiiUUUUU=
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
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/bench/syscall.c                  | 29 +++++++++++++++++++++++++----
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 60a89db..4a480a0 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -5,6 +5,9 @@
 #ifndef __NR_futex
 # define __NR_futex 240
 #endif
+#ifndef __NR_getppid
+# define __NR_getppid 64
+#endif
 #ifndef __NR_gettid
 # define __NR_gettid 224
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index cb52a3a..860257f 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -5,6 +5,9 @@
 #ifndef __NR_futex
 # define __NR_futex 202
 #endif
+#ifndef __NR_getppid
+# define __NR_getppid 110
+#endif
 #ifndef __NR_gettid
 # define __NR_gettid 186
 #endif
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 9b75101..746fd71 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -30,25 +30,41 @@ static const char * const bench_syscall_usage[] = {
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
@@ -79,3 +95,8 @@ int bench_syscall_basic(int argc, const char **argv)
 
 	return 0;
 }
+
+int bench_syscall_basic(int argc, const char **argv)
+{
+	return bench_syscall_common(argc, argv, __NR_getppid);
+}
-- 
2.1.0

