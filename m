Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3362CEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiKPXjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiKPXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52186A689;
        Wed, 16 Nov 2022 15:39:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s196so428108pgs.3;
        Wed, 16 Nov 2022 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1CvADQIw4wqzAoDn42X+sYR3xHbApFLyuTcEFkNEC0=;
        b=UYmx1u/g2Ycc3G++I+M/G5bolyXat0/Z3PzM0edwmbNJwMulmzMCxcAv8vGIaJbVu1
         lV9AUP79Zzmu7VTUNmdD4oqDDodVbu8J2hU5Lh+DElo16WZt7ymuRB/7W518Nd/7wmaG
         /WHeYlnknOH0fKAEN8os+WnxY7lXh8UH+e5GECRnw/f4+K7GPWJbGcz5vN1n2UeJdx3N
         m9KG8QuF0sqhhoOto6bC48VU1WLimZMm21Bj+ImfrBci/qQsFavqGEjsAzRFNGr0+bTA
         rzIu3ZnmbqG5rzSFlreapE2tZoGRF/z8DnNDispS6CBj2n6TCrLx5YckxdP7ugCfnawP
         7v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1CvADQIw4wqzAoDn42X+sYR3xHbApFLyuTcEFkNEC0=;
        b=N6jSpxIhmvuPifVPWT8DEjH2mjCBwuVzP9XkdT/L0zvXSIQReQ7masc+1tUK74PXD5
         sCGlee/L4HML9k0srJN4oN1MBT8eu8z5uLh/E4NJbYYoK/+fXy1D0jjc601NAAfLCIVg
         S6MSC1Hk1FmtBRwr+H3zgR/LwFr6uCC3nmm2d216aRVXt0zRp8UaHQiw1R3Qtgmhf4/c
         ywXiXGheSANKWFyhlbNhNyDKXIooZRj7zfgrGK2n11n2fPeo/ZVg2VFddBseILT3JoWk
         Idbw85/Ter3w1j0dVgTv4J8bBQfjestFQQDchCzo2fRWNwz+9HNGYOrJYxJiqoDqwhuj
         q8QA==
X-Gm-Message-State: ANoB5pnBgB/9rp9+K4ywa9HaWoWG8WmpnkgTrooq5k4lu3yIwMO1VGLm
        QS3f0ZWlIUTesOm//1f03wA=
X-Google-Smtp-Source: AA0mqf4gdNVZxF7JPPYt5R3LlIQrv8mtAObFKqEbONVmEDfqbi1LH+dd4rq1gnqLcolxUqcRx0oMmQ==
X-Received: by 2002:a63:5242:0:b0:46b:3c3d:f618 with SMTP id s2-20020a635242000000b0046b3c3df618mr22038542pgl.423.1668641951283;
        Wed, 16 Nov 2022 15:39:11 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:10 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 15:38:52 -0800
Message-Id: <20221116233854.1596378-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221116233854.1596378-1-namhyung@kernel.org>
References: <20221116233854.1596378-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Acked-by: German Gomez <german.gomez@arm.com>
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_brstack.sh | 66 +++++---------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index d7ff5c4b4da4..5856639b565b 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -4,13 +4,6 @@
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
 if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true > /dev/null 2>&1 ; then
@@ -19,6 +12,7 @@ if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true > /dev
 fi
 
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
+TESTPROG="perf test -w brstack"
 
 cleanup() {
 	rm -rf $TMPDIR
@@ -26,57 +20,24 @@ cleanup() {
 
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
+	egrep -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"	$TMPDIR/perf.script
+	egrep -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"		$TMPDIR/perf.script
 	set +x
 
 	# some branch types are still not being tested:
@@ -91,10 +52,7 @@ test_filter() {
 
 	echo "Testing branch stack filtering permutation ($filter,$expect)"
 
-	gen_test_program "$TEMPDIR/program.c"
-	cc -fno-inline -g "$TEMPDIR/program.c" -o $TMPDIR/a.out
-
-	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- $TMPDIR/a.out > /dev/null 2>&1
+	perf record -o $TMPDIR/perf.data --branch-filter $filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
 	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
 
 	# fail if we find any branch type that doesn't match any of the expected ones
-- 
2.38.1.584.g0f3c55d4c2-goog

