Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22576231C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKIRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKIRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411B164F9;
        Wed,  9 Nov 2022 09:46:43 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g62so17367912pfb.10;
        Wed, 09 Nov 2022 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=audwF3R26hO5/1tDhu1hZ0cjBE15kB3JCoKo0JD+sBo=;
        b=pxrvctklMWfU4Gw5H7393MIwP0VxLN6JqplrrIb1uGKQrtemctjAlR3Xxor574z33L
         ybcyJGD/lI7c9Tx0zKswNiJm9pONqSSd4Luiw85JsK9CRQho004/05D+baCwCmOMNjDd
         ihMYeWMgXYo83+dv3f/CIJvBkpF+rLF0+s8xiBhlmpi9BJVnBywf+0r43LBbvBmqQ1i7
         nDgXXM9SVo4KxeV/aZI/mWdy+jTyaLSTpTjjSg0KrsGzGeqpPWGhJVa1gcJ5ayCZ5Be/
         M2o83nn07RSAm6oWSNu79EAjS7/RzUXQFzP2zfaPLN9s43x6l6FPZPlRnqACmYgvMmmX
         zMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=audwF3R26hO5/1tDhu1hZ0cjBE15kB3JCoKo0JD+sBo=;
        b=kmuylX+vLahydrhn9lmq5IlySG7BlbcWcGKYoe0OQmnxLog5bxD/CclrDyvElM5Fh7
         dgQm2YXN8urjTuEa4S7iwUj8eQ12HGAreLLjN6RX5zySUYfwVSZyg39Kn/2ZhAlWRf5z
         vahkSEl4gI9DhYaLyDWzFTUCaCLjQm3sgXJZoNR69fD6+gVqBkEzh+Ed7jTpHln0M1+t
         Ze7TbeJfeT5uKNyDsMlCa95AxerKUdRsk8B1tH22qm44lB1JfJ08uNNT0TEfGdBzbifs
         jtnLkOK82vraYcn1GSllJgj8P42CdccI/AwBDanXCtLDTD1vVzxC9aOOOtwbMTsttv3i
         zMDQ==
X-Gm-Message-State: ACrzQf008Sxzsw3mHbipF9MtWjsWXJG8Eiv+V8E7EHvVg/nAi3BQLvEM
        ECd/c1SKBsCJ/ICw0oLA5SA=
X-Google-Smtp-Source: AMsMyM4NcogTBT1uuHGwhRJDZMPCS72KvD42DHVMeWyW4QN46ae5pgvMry1bAP0tR1OyAvXighcKaA==
X-Received: by 2002:a63:1748:0:b0:46f:18be:4880 with SMTP id 8-20020a631748000000b0046f18be4880mr52638669pgx.128.1668016002702;
        Wed, 09 Nov 2022 09:46:42 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:42 -0800 (PST)
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
Subject: [PATCH 04/12] perf test: Replace record test workload with thloop
Date:   Wed,  9 Nov 2022 09:46:27 -0800
Message-Id: <20221109174635.859406-5-namhyung@kernel.org>
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
2.38.1.431.g37b22c650d-goog

