Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065AA7141FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjE2CXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2CXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:23:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E96A0;
        Sun, 28 May 2023 19:23:28 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxBvGYDHRkYhkCAA--.5012S3;
        Mon, 29 May 2023 10:23:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxRrWSDHRkNzh+AA--.9081S5;
        Mon, 29 May 2023 10:23:19 +0800 (CST)
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
Subject: [PATCH v2 3/3] perf LoongArch: Simplify mksyscalltbl
Date:   Mon, 29 May 2023 10:23:14 +0800
Message-Id: <1685326994-11987-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685326994-11987-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685326994-11987-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxRrWSDHRkNzh+AA--.9081S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zry5GF45JrWUKry5XFyUAwb_yoW8uF1fpF
        sak3srta1rZr1xCwnF9r42qF1rCws7Jr1YqFyvkrWSvw43C34Fyr10qas3JFy7G3yxtrWF
        vryIqryUKF48XaDanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bhxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
        0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
        I7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnbAw7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to print the numerical entries of the syscall table,
there is no need to call the host compiler to build and then
run a program, this can be done directly by the shell script.

This is similar with commit 9854e7ad35fe ("perf arm64: Simplify
mksyscalltbl"). For now, the mksyscalltbl file of LoongArch is
almost same with arm64.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 .../arch/loongarch/entry/syscalls/mksyscalltbl     | 36 ++++++----------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
index c52156f..8df7b0b 100755
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
@@ -18,44 +18,28 @@ if ! test -r $input; then
 	exit 1
 fi
 
-create_table_from_c()
+create_sc_table()
 {
 	local sc nr last_sc
 
-	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
-
-	{
-
-	cat <<-_EoHEADER
-		#include <stdio.h>
-		#include "$input"
-		int main(int argc, char *argv[])
-		{
-	_EoHEADER
-
 	while read sc nr; do
-		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", $nr);"
-		last_sc=$nr
+		printf "%s\n" "	[$nr] = \"$sc\","
+		last_sc=$sc
 	done
 
-	printf "%s\n" "	printf(\"#define SYSCALLTBL_LOONGARCH_MAX_ID %d\\n\", $last_sc);"
-	printf "}\n"
-
-	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
-
-	$create_table_exe
-
-	rm -f $create_table_exe
+	printf "%s\n" "#define SYSCALLTBL_LOONGARCH_MAX_ID __NR_$last_sc"
 }
 
 create_table()
 {
+	echo "#include \"$input\""
 	echo "static const char *syscalltbl_loongarch[] = {"
-	create_table_from_c
+	create_sc_table
 	echo "};"
 }
 
-$gcc -E -dM -x c  -I $incpath/include/uapi $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -n \
+$gcc -E -dM -x c -I $incpath/include/uapi $input \
+	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
+		sub("^#define __NR(3264)?_", "");
+		print | "sort -k2 -n"}' \
 	|create_table
-- 
2.1.0

