Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246362CED8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiKPXjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiKPXjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F852735;
        Wed, 16 Nov 2022 15:39:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g10so552550plo.11;
        Wed, 16 Nov 2022 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e32OqBWuzlRvRYqEyrLxtjOglgwrHLuTqyHep2+BwGY=;
        b=FWxyJJVilgcjlTlzSRL0hSHGUP5IZ9FYJ6TUCpzf13Zyj2bOgzWZwmlH+rJPZt2oKH
         KL5Xm9n5PUqDpOMoybYP+wTYNzB82M/q7+iq0Wxv+9jOlbUnr4X4W6fKvb5qMmHD1lq2
         FmFbYB8AP7/7cmVM++vQK+aKGdzvEz0hTS7mfgCFgAH1RtdJRsFHXghj0SqrTaNkmseG
         sKwo9m/EFCVw8pcZInRctMBsBxSAbAFMsrDc3x87+rw7QyLVyE+oZUi3dlDSsAIZlk6F
         15sp5c0KdRKbC+i52eSS52vIqp2FW5WAwvSKQmsHUaQ2KkV6TclSWRAu4Hu6H0VdE8Jd
         RNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e32OqBWuzlRvRYqEyrLxtjOglgwrHLuTqyHep2+BwGY=;
        b=Y4fmlmE4/HKkyfl6RY57LhIs7W9D08bDm5dmrBBX1XUWS3TTKEfp86FN8Je1wW2z6Z
         dTEt30O2Ciatcn11jd7LNY4MMaw+WUne/DrqaQ7gPXGwqVzZydPISo0+u07mD8FPrGEH
         A3hPIGyK/Awcf/bI1D8VRY0bToHClQZvjoxCGtHCHKvtOjZmXSLe3aDJZ3rjTk5hSJ9A
         bTevu5chR2MzXEg4cXjnV8w9TeASVIJhWWp+IbO3rwg4RGEqDo22k46M9YvOybxLYwGM
         dYd0WyEVxdFcFzTQhmIrk4l1RqFR84r+CP3UK/xfN94mjLoHtQLKwZqnvK04jQb0cUB2
         4VHQ==
X-Gm-Message-State: ANoB5pn2bIBZ1PptvcZmLfOyQgg616sMdNIKNT6YqvcjEl8xSOEl8Dfg
        QNTfLyrO9Rm1F5DFdvkTWbU=
X-Google-Smtp-Source: AA0mqf7i7/HFrtWZZajsinEO1mlkkvuOY7vlkdTnG7S/7SCE76gFw6RyK4Lm8/j2MwfWpX5ys/XLmQ==
X-Received: by 2002:a17:902:bb8b:b0:188:d4bf:dbfe with SMTP id m11-20020a170902bb8b00b00188d4bfdbfemr210164pls.31.1668641940900;
        Wed, 16 Nov 2022 15:39:00 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:00 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 15:38:44 -0800
Message-Id: <20221116233854.1596378-3-namhyung@kernel.org>
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

Tested-by: James Clark <james.clark@arm.com>
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
2.38.1.584.g0f3c55d4c2-goog

