Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26D624937
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKJSTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiKJST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4682CC95;
        Thu, 10 Nov 2022 10:19:26 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h193so2473618pgc.10;
        Thu, 10 Nov 2022 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN13JFxKxPVkjxGylWKLVZxnCq3MwU+nxhwlTyhC5nY=;
        b=khCPq+Mv+AjXuYqj91VjQny7Dq5csxPkl99CArR98EpyWD7RvrWQkXyf0s3HDQCKUX
         JoBj4+KS1nTUfTvbvX4M7Ng4EGp15tQyixks6HVn+oX0ErleSgQ/7NLBZwggy1R0LtuS
         ZlbpYYH6oHHhP9horJO71o4RZYyWVJ7PbSh6E/b3ggoDmIDA2RPtx3jTs4lzKB9tEoYV
         RUsOCOXuuBfF7eOzcHU0Gt0CJfuH+SRd1elD1HrbWkcog5ZvFc8iFsUaW0JxamLwFA+Z
         dejxZEVVcQM5j/LONREilfMWxgsCudqmC7CtcuBSh2Q0bzv4ReYbRyMSM/AKYCvZVzny
         V3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xN13JFxKxPVkjxGylWKLVZxnCq3MwU+nxhwlTyhC5nY=;
        b=1Ekbto5Llx5fOVZWrIld/LgyXVe6zICXDs96GQ0q2OFtIqhG/1W8+P2svtA9YjiAEQ
         hSN/yMNVVNdtg9ptbm2hf4hzEKy1xPeTt8eiqB2aZj3ikswamr9tCm7DaOE3kc/y40f5
         C1qQqKno+IPeokbVcwMlrOyh2ctOGdpT1IlCqgRhBX1LWtk16Z32RnTg4SpK6K/j4LM3
         uQcwIetV1pAZr94bCkuU/hXI91CuClSGdGgKpnlIETeGrxuRo4nMkCqSGmgwuzpo+omX
         eD2tqT45yeL5RQkHYsBfaRskCGhTlX4HzYluEWQBphS8C+0FACJppl3zper4BnENNgyT
         KTHg==
X-Gm-Message-State: ACrzQf3ySnt81aX/Cv6tR63Th4rJ+nz5n7Bma6/QuwGCO+mQbJp2vnV3
        aWO2q/ve0R7pmlQOaT38Jh3brBCsIF0=
X-Google-Smtp-Source: AMsMyM7/rlsIzf/+FR4EE6M0PsPZoI52rY4eIcNxLzuV4fCIwJ/ksDg2BkVYGYbpO500UjtqEI8Xng==
X-Received: by 2002:a63:174b:0:b0:46f:b6df:3107 with SMTP id 11-20020a63174b000000b0046fb6df3107mr3030917pgx.454.1668104365859;
        Thu, 10 Nov 2022 10:19:25 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:25 -0800 (PST)
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
Subject: [PATCH 02/12] perf test: Replace pipe test workload with noploop
Date:   Thu, 10 Nov 2022 10:19:10 -0800
Message-Id: <20221110181920.84900-3-namhyung@kernel.org>
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

So that it can get rid of requirement of a compiler.
Also define and use more local symbols to ease future changes.

  $ sudo ./perf test -v pipe
   87: perf pipe recording and injection test                          :
  --- start ---
  test child forked, pid 748003
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
      748014   748014       -1 |perf
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
      99.83%  perf     perf                  [.] noploop
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
      99.85%  perf     perf                  [.] noploop
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.160 MB /tmp/perf.data.2XYPdw (4007 samples) ]
      99.83%  perf     perf                  [.] noploop
  test child finished with 0
  ---- end ----
  perf pipe recording and injection test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/pipe_test.sh | 55 ++++++-----------------------
 1 file changed, 10 insertions(+), 45 deletions(-)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index 1b32b4f28391..8dd115dd35a7 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -2,68 +2,33 @@
 # perf pipe recording and injection test
 # SPDX-License-Identifier: GPL-2.0
 
-# skip if there's no compiler
-if ! [ -x "$(command -v cc)" ]; then
-	echo "failed: no compiler, install gcc"
-	exit 2
-fi
-
-file=$(mktemp /tmp/test.file.XXXXXX)
 data=$(mktemp /tmp/perf.data.XXXXXX)
+prog="perf test -w noploop"
+task="perf"
+sym="noploop"
 
-cat <<EOF | cc -o ${file} -x c -
-#include <signal.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-volatile int done;
-
-void sigalrm(int sig) {
-	done = 1;
-}
-
-__attribute__((noinline)) void noploop(void) {
-	while (!done)
-		continue;
-}
-
-int main(int argc, char *argv[]) {
-	int sec = 1;
-
-	if (argc > 1)
-		sec = atoi(argv[1]);
-
-	signal(SIGALRM, sigalrm);
-	alarm(sec);
-
-	noploop();
-	return 0;
-}
-EOF
-
-
-if ! perf record -e task-clock:u -o - ${file} | perf report -i - --task | grep test.file; then
+if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep ${task}; then
 	echo "cannot find the test file in the perf report"
 	exit 1
 fi
 
-if ! perf record -e task-clock:u -o - ${file} | perf inject -b | perf report -i - | grep noploop; then
+if ! perf record -e task-clock:u -o - ${prog} | perf inject -b | perf report -i - | grep ${sym}; then
 	echo "cannot find noploop function in pipe #1"
 	exit 1
 fi
 
-perf record -e task-clock:u -o - ${file} | perf inject -b -o ${data}
-if ! perf report -i ${data} | grep noploop; then
+perf record -e task-clock:u -o - ${prog} | perf inject -b -o ${data}
+if ! perf report -i ${data} | grep ${sym}; then
 	echo "cannot find noploop function in pipe #2"
 	exit 1
 fi
 
-perf record -e task-clock:u -o ${data} ${file}
-if ! perf inject -b -i ${data} | perf report -i - | grep noploop; then
+perf record -e task-clock:u -o ${data} ${prog}
+if ! perf inject -b -i ${data} | perf report -i - | grep ${sym}; then
 	echo "cannot find noploop function in pipe #3"
 	exit 1
 fi
 
 
-rm -f ${file} ${data} ${data}.old
+rm -f ${data} ${data}.old
 exit 0
-- 
2.38.1.493.g58b659f92b-goog

