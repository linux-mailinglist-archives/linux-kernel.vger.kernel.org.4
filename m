Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9455624939
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiKJSTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiKJST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBAD2CC95;
        Thu, 10 Nov 2022 10:19:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b11so2313350pjp.2;
        Thu, 10 Nov 2022 10:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOrM7DG6LUDq+Ll5YPubMT6jgUHifwK6RUyTLKQOndA=;
        b=qcbkzL4De+QgKx+eLLv3VThu1rH8Us/PnxRz4kLRjFpAfO/AVtWKxZ4sH44j4MnT3M
         wbee2GMxkCV+mC4gXNDPibYtXxB0Fis/q4jg82ERC67k2nZwnntJZEYRvuYnjWgh+Gul
         TLz0j87cg7xD2LrXo2EAF95ahmrfGQBYPJMKOV4P7tnVTh7dwGwo3ZOsOip/35yqV+bc
         kHnFvayI3pTrIEu68xCr+oYEsin8+7E/BZ7Byr70w4WOpao3/WmhZrn5IQm3dN3qCslg
         HoL1qWN1+XDQN3XugIKo8HFolRqsQzZIui+F+SdBSZNr0AdPb+ppl3KY799W5TehZdUw
         gwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOrM7DG6LUDq+Ll5YPubMT6jgUHifwK6RUyTLKQOndA=;
        b=NW0VFMpQwGYfdRCJ1EJkytodXHOEChZg/VADDYnI8Od2WsthbYpe+9kmDm8wZZg+du
         dSQoSeWDms9utqHXZjtGqT7MIxt6r5sD7c2DhS9olqAkmG5tjsO4EpB00L5VdXQrEiTy
         VcopQb8U+d306ymqjVZafxUxEjqnZ3NtHC37VpfKxXwF6MyI30kO1mMQbThibDyHq6sX
         jW9WNt7rWazhSK4+yUWgl8fnOV8fWxXcyzypuZ2ACOtfWtyxmznbnOysk0gFbSchnPqp
         3XzoXROh0BJIYxzBJBodRxyz8Z7r1D/dZeKVyMwI9kte2K1IxFzuUDWfKy/6k72RJ5i9
         8mEw==
X-Gm-Message-State: ACrzQf0IOI/QGy8azuXYJl0Vc5n869IfIo22yjrw/8LTzLWXj5EZXBZA
        zo0jVs7Fo643kE/GCIVbsE0=
X-Google-Smtp-Source: AMsMyM5AdcDAN2xBi69FS4u+fEFs3IQsZRyTwGZg0JWDQDeW8+rqPyoTLcPlg/ud2we/ceFtEIW3CA==
X-Received: by 2002:a17:902:f394:b0:186:ff42:704d with SMTP id f20-20020a170902f39400b00186ff42704dmr1690417ple.153.1668104368402;
        Thu, 10 Nov 2022 10:19:28 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:28 -0800 (PST)
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
Date:   Thu, 10 Nov 2022 10:19:12 -0800
Message-Id: <20221110181920.84900-5-namhyung@kernel.org>
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
2.38.1.493.g58b659f92b-goog

