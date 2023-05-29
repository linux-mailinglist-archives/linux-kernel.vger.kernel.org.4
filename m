Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DE714200
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjE2CXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjE2CXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:23:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6EFCA9;
        Sun, 28 May 2023 19:23:28 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxiPGXDHRkVRkCAA--.5076S3;
        Mon, 29 May 2023 10:23:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxRrWSDHRkNzh+AA--.9081S4;
        Mon, 29 May 2023 10:23:18 +0800 (CST)
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
Subject: [PATCH v2 2/3] perf arm64: Handle __NR3264_ prefixed syscall number
Date:   Mon, 29 May 2023 10:23:13 +0800
Message-Id: <1685326994-11987-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685326994-11987-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685326994-11987-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxRrWSDHRkNzh+AA--.9081S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7trWxur1Dtw1xtw4ktF15CFg_yoW8JFW8pw
        s3C34UtayrGFy0kw1xur4jqFWrCF4kJ3W5KryjyrW3Crn8Jw15tr1YqasYkFW7Xw1xK3y5
        Zr10qFy5XF18Xw7anT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnLID5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 9854e7ad35fe ("perf arm64: Simplify mksyscalltbl"),
in the generated syscall table file syscalls.c, there exist some
__NR3264_ prefixed syscall numbers such as [__NR3264_ftruncate],
it looks like not so good, just do some small filter operations
to handle __NR3264_ prefixed syscall number as a digital number.

Without this patch:

  [__NR3264_ftruncate] = "ftruncate",

With this patch:

  [46] = "ftruncate",

Suggested-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index e530587..1628731 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -40,6 +40,7 @@ create_table()
 }
 
 $gcc -E -dM -x c -I $incpath/include/uapi $input \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -n	       \
+	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
+		sub("^#define __NR(3264)?_", "");
+		print | "sort -k2 -n"}' \
 	|create_table
-- 
2.1.0

