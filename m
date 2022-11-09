Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A676231CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiKIRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiKIRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:47:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4726562;
        Wed,  9 Nov 2022 09:46:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2532197pjs.4;
        Wed, 09 Nov 2022 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiF3YnCQsrF/gvWg4IJtalMbBErjLNwZf+63Zgv2mbg=;
        b=hatPA4XtREHlwkvzVLI1nc18tp1XpKw8QO75TiIhdxakEb7zyL+K9819A20gtZd9Iz
         iDOEzWXNwExj2Ok1R2tYpZCP516eHXzdIRpBJeIyao/q5PvPFA24rT0CXywDscN5zReG
         bBFkRKyERzXOQ8AOnSIRkESnQjD1iHvV7zsvbW6Fr32vjxVta/8r//p8O5rq3tJ/wrwK
         y0k4M/Zq6a+fBTysACsAAhiYerzTF7hMvbn3uzeFx3XODCf6UPnt8TV/PflZouKJT6oN
         FdythhovjLJe836zD7bgZNpY+kbUnSQFK+9RfZ1PE8Ky70T+UadFOrw8e0QZkOgJUfI3
         BtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiF3YnCQsrF/gvWg4IJtalMbBErjLNwZf+63Zgv2mbg=;
        b=YJjNtRM18DeJS0XMU9CSn1NkzKCEn8PL2zUASK75fLUj/kbjglo5BP+Srz2UdaLGO1
         wMbWzGbARPn5n//2z2yr4U4OcRaPF1/gI7gAVKKUJpW5jPNzTk5g7yAa8tKTDyY39HfF
         N6YdoQepP2yBFG1bHzTKUwxV4+7yyxx0BrmRU+o1KH51kGnu36fLSSbErNJi/bSUkIf/
         019lW837OIcXb8QMOStZQP3Xcd9hw4mHhZ5VFnoeZxLl4eBqk7/CHuJ60uhEmqgjATpI
         8vvPNzSBGMk5QV6XPJI+SPI0R1563zEpm46UP6+2q3iyUD/ZvZGxRHgxqWkioIjAmT8J
         iaHw==
X-Gm-Message-State: ACrzQf3ff/NfI/wojz4TflpJQa7ZLs/uepISN+7flZBWbuge1GnJK/de
        g9a5bP6Ey51LBgauELl7DWQ=
X-Google-Smtp-Source: AMsMyM7vhuPkpcMYEZ3I53QqkQFf2afZjATrO7UAJPHR9aKBuBVthqp/ZOahDUpg+f/PhwjQivArQA==
X-Received: by 2002:a17:90a:df91:b0:213:8a69:c504 with SMTP id p17-20020a17090adf9100b002138a69c504mr69026009pjv.82.1668016010394;
        Wed, 09 Nov 2022 09:46:50 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:50 -0800 (PST)
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
        James Clark <james.clark@arm.com>
Subject: [PATCH 10/12] perf test: Replace brstack test workload
Date:   Wed,  9 Nov 2022 09:46:33 -0800
Message-Id: <20221109174635.859406-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109174635.859406-1-namhyung@kernel.org>
References: <20221109174635.859406-1-namhyung@kernel.org>
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
2.38.1.431.g37b22c650d-goog

