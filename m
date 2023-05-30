Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA0715AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjE3JvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjE3JvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:51:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D91F9;
        Tue, 30 May 2023 02:51:10 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxuPENx3VkUoQCAA--.5734S3;
        Tue, 30 May 2023 17:51:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWdIJx3VkkmSAAA--.12317S3;
        Tue, 30 May 2023 17:51:07 +0800 (CST)
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
Cc:     Hans-Peter Nilsson <hp@axis.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 1/5] perf tools: Declare syscalltbl_*[] as const for all archs
Date:   Tue, 30 May 2023 17:51:01 +0800
Message-Id: <1685440265-7021-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685440265-7021-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685440265-7021-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxWdIJx3VkkmSAAA--.12317S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4kurWxJr4UJF17Aw4fKrg_yoWxGr1Dp3
        Z2kw1kJ3Z5Wr1rA34Igw4jqFyrurn7Gr12qryjkrZxArsxJ343trWUXa95tFWfX34xGrWj
        vrW8Xry5GF1IqF7anT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kK
        e7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
        6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IUnLID5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscalltbl_*[] should never be changing, let us declare it as const.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl     |  2 +-
 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl |  2 +-
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl      |  2 +-
 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl   |  2 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl      |  2 +-
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh      |  2 +-
 tools/perf/util/syscalltbl.c                          | 14 +++++++-------
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 22cdf91..4edcdf6 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -34,7 +34,7 @@ create_table_from_c()
 create_table()
 {
 	echo "#include \"$input\""
-	echo "static const char *syscalltbl_arm64[] = {"
+	echo "static const char *const syscalltbl_arm64[] = {"
 	create_table_from_c
 	echo "};"
 }
diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
index c52156f..5fb83bd 100755
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
@@ -50,7 +50,7 @@ create_table_from_c()
 
 create_table()
 {
-	echo "static const char *syscalltbl_loongarch[] = {"
+	echo "static const char *const syscalltbl_loongarch[] = {"
 	create_table_from_c
 	echo "};"
 }
diff --git a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
index fb1f494..c0d93f9 100644
--- a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
@@ -18,7 +18,7 @@ create_table()
 {
 	local max_nr nr abi sc discard
 
-	echo 'static const char *syscalltbl_mips_n64[] = {'
+	echo 'static const char *const syscalltbl_mips_n64[] = {'
 	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
index 6c58060..0eb316f 100755
--- a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
@@ -23,7 +23,7 @@ create_table()
 	max_nr=-1
 	nr=0
 
-	echo "static const char *syscalltbl_powerpc_${wordsize}[] = {"
+	echo "static const char *const syscalltbl_powerpc_${wordsize}[] = {"
 	while read nr abi sc discard; do
 		if [ "$max_nr" -lt "$nr" ]; then
 			printf '\t[%d] = "%s",\n' $nr $sc
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
index 72ecbb6..52eb88a 100755
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
@@ -18,7 +18,7 @@ create_table()
 {
 	local max_nr nr abi sc discard
 
-	echo 'static const char *syscalltbl_s390_64[] = {'
+	echo 'static const char *const syscalltbl_s390_64[] = {'
 	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
index 029a72c..fa526a9 100755
--- a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
@@ -18,7 +18,7 @@ emit() {
     syscall_macro "$nr" "$entry"
 }
 
-echo "static const char *syscalltbl_${arch}[] = {"
+echo "static const char *const syscalltbl_${arch}[] = {"
 
 sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
 grep '^[0-9]' "$in" | sort -n > $sorted_table
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 313ecce..63be7b5 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -17,31 +17,31 @@
 #if defined(__x86_64__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_x86_64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_x86_64;
+static const char *const *syscalltbl_native = syscalltbl_x86_64;
 #elif defined(__s390x__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_s390_64;
+static const char *const *syscalltbl_native = syscalltbl_s390_64;
 #elif defined(__powerpc64__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_powerpc_64;
+static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #elif defined(__powerpc__)
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_powerpc_32;
+static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #elif defined(__aarch64__)
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_arm64;
+static const char *const *syscalltbl_native = syscalltbl_arm64;
 #elif defined(__mips__)
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_mips_n64;
+static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #elif defined(__loongarch__)
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_loongarch;
+static const char *const *syscalltbl_native = syscalltbl_loongarch;
 #endif
 
 struct syscall {
-- 
2.1.0

