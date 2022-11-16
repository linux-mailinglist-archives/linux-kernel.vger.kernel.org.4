Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1002162CEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiKPXjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiKPXjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1049ABE2B;
        Wed, 16 Nov 2022 15:39:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y4so20308plb.2;
        Wed, 16 Nov 2022 15:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJxyXYhhzgIeHuBQXESNxNIqNBrSSrRkKX/giDhK4aM=;
        b=MgBzJ1j4wC/4bFO/NNOLeJxd6XLPRONHzpzcq1e3R96YYREGdqSs2UHBzfaT2WcgXb
         li9yoRi35ieBRHA2BGciShpI2i9bpI1BMBCqGnoHOCCzc4ELU++/RGkmpJLnHWZprDCR
         IE3fLZ5o45ViZHbPI12vuu7al158vkwOB1o0Rb7treKPpstCsngU59tZmZuOa0i7zud0
         qsKAzg4tJGhZgG+aGAi0NJl+cydzW94jSqRMutCuGWkwopkI5zKGWECdNRVTRbJiVDTL
         8ZfmS04rNwKRbmi/Ej7AtjivQDxs3Zy9vy38hIYRFtBRwRcf7tm8WAcPte+Ism6NKGaR
         27Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJxyXYhhzgIeHuBQXESNxNIqNBrSSrRkKX/giDhK4aM=;
        b=DFTC4f/C1REcZAiU1pMCQpaPWHAVwBIN0cp+Y+MS3/XV7R7uE33VXBXIbtq0CiRzlt
         eSDyAkbY4ugBS6Kdg0GO2IgjEnOrN/p+3KbxRp9QPkejOhz39Murxi2i7DfORJnAWhTz
         yFcog0ooDZGxnL3bI3XkZ1ZUKNnT+rOaW193P0JUVUenRz+q8c0gh5w9bElD+1UXAWhL
         nRBzv1cxirVyleKlfOrQwkGxyGf/moK5iPw5jGh4qpYpRCNU5Jb3JmFmXlbj17u+6rXu
         EopZWdCFq6vVxKzsMQ6R39lQh0w1CaxW894Gx5pZW7d5lh3vlvtu0b9cFw5mFwIVH1Xn
         BS2A==
X-Gm-Message-State: ANoB5pntgKBTSas2r0j9BhUbuoVt4uVuQm/eGzujnx+O1+fD5U50xtSm
        E+yx4mU9w8Ea+njR9X0sFzU=
X-Google-Smtp-Source: AA0mqf4cujUOzOtuOJyYBy4/9VVtUnw0yhECctCK69sIHW613CRqgkcblvedMvM4FGfZLG55N6Gjdg==
X-Received: by 2002:a17:90a:8d13:b0:213:c15:6f08 with SMTP id c19-20020a17090a8d1300b002130c156f08mr45947pjo.134.1668641943497;
        Wed, 16 Nov 2022 15:39:03 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:03 -0800 (PST)
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
Subject: [PATCH 04/12] perf test: Replace record test workload with thloop
Date:   Wed, 16 Nov 2022 15:38:46 -0800
Message-Id: <20221116233854.1596378-5-namhyung@kernel.org>
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

So that it can get rid of requirements for a compiler.

  $ sudo ./perf test -v 92
   92: perf record tests                                               :
  --- start ---
  test child forked, pid 740204
  Basic --per-thread mode test
  Basic --per-thread mode test [Success]
  Register capture test
  Register capture test [Success]
  Basic --system-wide mode test
  Basic --system-wide mode test [Success]
  Basic target workload test
  Basic target workload test [Success]
  test child finished with 0
  ---- end ----
  perf record tests: Ok

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 59 ++------------------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index e93b3a8871fe..4dff89e3a3fd 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -9,17 +9,13 @@ shelldir=$(dirname "$0")
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
-testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
+testprog="perf test -w thloop"
 testsym="test_loop"
 
 cleanup() {
   rm -rf "${perfdata}"
   rm -rf "${perfdata}".old
 
-  if [ "${testprog}" != "true" ]; then
-    rm -f "${testprog}"
-  fi
-
   trap - EXIT TERM INT
 }
 
@@ -29,53 +25,6 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
-build_test_program() {
-  if ! [ -x "$(command -v cc)" ]; then
-    # No CC found. Fall back to 'true'
-    testprog=true
-    testsym=true
-    return
-  fi
-
-  echo "Build a test program"
-  cat <<EOF | cc -o ${testprog} -xc - -pthread
-#include <stdio.h>
-#include <stdlib.h>
-#include <pthread.h>
-
-void test_loop(void) {
-  volatile int count = 1000000;
-
-  while (count--)
-    continue;
-}
-
-void *thfunc(void *arg) {
-  int forever = *(int *)arg;
-
-  do {
-    test_loop();
-  } while (forever);
-
-  return NULL;
-}
-
-int main(int argc, char *argv[]) {
-  pthread_t th;
-  int forever = 0;
-
-  if (argc > 1)
-    forever = atoi(argv[1]);
-
-  pthread_create(&th, NULL, thfunc, &forever);
-  test_loop();
-  pthread_join(th, NULL);
-
-  return 0;
-}
-EOF
-}
-
 test_per_thread() {
   echo "Basic --per-thread mode test"
   if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
@@ -96,8 +45,8 @@ test_per_thread() {
     return
   fi
 
-  # run the test program in background (forever)
-  ${testprog} 1 &
+  # run the test program in background (for 30 seconds)
+  ${testprog} 30 &
   TESTPID=$!
 
   rm -f "${perfdata}"
@@ -205,8 +154,6 @@ test_workload() {
   echo "Basic target workload test [Success]"
 }
 
-build_test_program
-
 test_per_thread
 test_register_capture
 test_system_wide
-- 
2.38.1.584.g0f3c55d4c2-goog

