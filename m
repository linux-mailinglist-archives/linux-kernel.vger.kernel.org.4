Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3840662493F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKJSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiKJSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C584E43F;
        Thu, 10 Nov 2022 10:19:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5547321pjc.0;
        Thu, 10 Nov 2022 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVha7Zh/4iO9cmJI/CriQtLmB6U5f2y65t9ftbB7Kko=;
        b=EfVnLhpi1R0E5sZeqyMN/uIQBCDSKLb686lT6TJ59s1kq5px6aCEgCVQ0xW2ocZ4Kj
         VC1j6FcgDtfqt9vhOCE0vrb1hc7bmRKdnhtO6EI5RhoJkTZ48pcfoPMVunw7WNfO4J5F
         EQypLnoXvySntJhRylbos43z2yFB0bFt/NoIujtgAbx9+s6dEkMQ40E9hAYtoC9rQatl
         NLkzpQECtWStnluM8RQkmJtfVELo7ngFHYQi4BFrbUuVrMEzYO/nE0Yq2RY1qAnfy3rP
         4FGAiz5Zd+wmjJQvBG4WTogY/m5s7h9youdKHl8RGYoNUh/TjGJW5eOVbdxytmi6uh/B
         7VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sVha7Zh/4iO9cmJI/CriQtLmB6U5f2y65t9ftbB7Kko=;
        b=YwJ/md0yfIVcuahyDRZyXWDGfOTanANkKepL7q9UmptcgOB+4WGm0CdJ7a+0DUscor
         8u7Wme8pKce/Y1wcmPw1ss+MHctmB+SaqgRAsQwWZXPULU1mZJmIQ1czf2eIC4Wei5/9
         9v3WXniFRBUXsFNaKEz1CMDTZ7Q4ki6+vzQkif/nQYjVvQM5djDKbNVcRWoC1IbbeDiz
         VlLcu8yz1VmZI31kLixZdwhjzna4UDywe6Pc07MpyKDDUwRy4VpzMQppbrEODvOTWGeL
         AUFB5dzf043EiqRmKN9ingmWqC44Fh9wpq1m28XpNvgH8l+eUDXITvRe0QU/abYXqQxJ
         LGDw==
X-Gm-Message-State: ACrzQf2JDjwU1nYDjPOkhiW0tY3cNoUTQTS3f4Ef+5cB2Vyr2xQKuFyP
        HzwDmreAoP0YQDuPohiEz6U=
X-Google-Smtp-Source: AMsMyM5yyKtzeCG2U369duDVqUboGiIG1yFZu5EzF0g8WcFJ8BZ5IEDqBwJH73nOnWA3BnRLgMmcHA==
X-Received: by 2002:a17:902:e5d1:b0:187:3593:a86f with SMTP id u17-20020a170902e5d100b001873593a86fmr49893281plf.15.1668104376051;
        Thu, 10 Nov 2022 10:19:36 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:35 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 10/12] perf test: Replace brstack test workload
Date:   Thu, 10 Nov 2022 10:19:18 -0800
Message-Id: <20221110181920.84900-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221110181920.84900-1-namhyung@kernel.org>
References: <20221110181920.84900-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that it can get rid of requirement of a compiler.  Also rename the
symbols to match with the perf test workload.

Cc: German Gomez <german.gomez@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_brstack.sh | 66 +++++---------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index ec801cffae6b..a8a182dea25f 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -4,18 +4,12 @@
 # SPDX-License-Identifier: GPL-2.0
 # German Gomez <german.gomez@arm.com>, 2022
 
-# we need a C compiler to build the test programs
-# so bail if none is found
-if ! [ -x "$(command -v cc)" ]; then
-	echo "failed: no compiler, install gcc"
-	exit 2
-fi
-
 # skip the test if the hardware doesn't support branch stack sampling
 # and if the architecture doesn't support filter types: any,save_type,u
 perf record -b -o- -B --branch-filter any,save_type,u true > /dev/null 2>&1 || exit 2
 
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
+TESTPROG="perf test -w brstack"
 
 cleanup() {
 	rm -rf $TMPDIR
@@ -23,57 +17,24 @@ cleanup() {
 
 trap cleanup exit term int
 
-gen_test_program() {
-	# generate test program
-	cat << EOF > $1
-#define BENCH_RUNS 999999
-int cnt;
-void bar(void) {
-}			/* return */
-void foo(void) {
-	bar();		/* call */
-}			/* return */
-void bench(void) {
-  void (*foo_ind)(void) = foo;
-  if ((cnt++) % 3)	/* branch (cond) */
-    foo();		/* call */
-  bar();		/* call */
-  foo_ind();		/* call (ind) */
-}
-int main(void)
-{
-  int cnt = 0;
-  while (1) {
-    if ((cnt++) > BENCH_RUNS)
-      break;
-    bench();		/* call */
-  }			/* branch (uncond) */
-  return 0;
-}
-EOF
-}
-
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
-	gen_test_program "$TEMPDIR/program.c"
-	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
-
-	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
+	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
 	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
 
 	# example of branch entries:
-	# 	foo+0x14/bar+0x40/P/-/-/0/CALL
+	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
 
 	set -x
-	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^foo\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^bench\+[^ ]*/foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^bench\+[^ ]*/bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
-	egrep -m1 "^bar\+[^ ]*/foo\+[^ ]*/RET$"		$TMPDIR/perf.script
-	egrep -m1 "^foo\+[^ ]*/bench\+[^ ]*/RET$"	$TMPDIR/perf.script
-	egrep -m1 "^bench\+[^ ]*/bench\+[^ ]*/COND$"	$TMPDIR/perf.script
-	egrep -m1 "^main\+[^ ]*/main\+[^ ]*/UNCOND$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET$"		$TMPDIR/perf.script
+	egrep -m1 "^brstack_foo\+[^ ]*/brstsack_bench\+[^ ]*/RET$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"		$TMPDIR/perf.script
 	set +x
 
 	# some branch types are still not being tested:
@@ -88,10 +49,7 @@ test_filter() {
 
 	echo "Testing branch stack filtering permutation ($filter,$expect)"
 
-	gen_test_program "$TEMPDIR/program.c"
-	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
-
-	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
+	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
 	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
 
 	# fail if we find any branch type that doesn't match any of the expected ones
-- 
2.38.1.493.g58b659f92b-goog

