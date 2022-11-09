Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7572B6231C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiKIRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiKIRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FCBE70;
        Wed,  9 Nov 2022 09:46:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2607445pjl.3;
        Wed, 09 Nov 2022 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt+WoBEPSCbce4SU7k7Lvd7WOnbPXIYlVffaFzdNGBU=;
        b=jNWDt47UqufTjvRMGEX6BH/6RYZ0QfrGI7q6r3LGHQStZ91PZT32H/Lsxk1b8qtMgp
         BfWKREETEGMNcMX+FTrnJM8SDogq+UD9OZhVqM/BhQ90+xShOz6T7NSOx3N2+AjHuoha
         SwKCtSz5e6I7nsn/MJxadNzMMRYJ5YO0jCW/Lu2l0H4NU9fXLtFgBmPAg+yfhjI7KV5x
         W7bQNx51aInbL6PBDFc+FZQvhQzX1ZNsC8Kqtai4W4WOWnmni53sSzBPJHbeaLwSaqqN
         Iher7PbaBIgHn3DYXybYjlwh8qGv6kkKrzST9P9uJsCgbcqY5J6n01lXq0gGk06rNnsJ
         YkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xt+WoBEPSCbce4SU7k7Lvd7WOnbPXIYlVffaFzdNGBU=;
        b=Wfbk+Sg9FPuD0IaqAOu8PP2vZXZRRmVseS7a2GlzHSyrNtEg3yKX33utWBZqRtZJrM
         jbxHbgXeaFYihYeF0r6blQMQsbdwDZg8HKaOTvZ7pC5xJBh9iY4Z94bk9qI2SsDEYrL+
         yuV4NLFov5oB/yETtm6dqxIx56Telo14SzN9DQIa/Oal3hJz2cETEdvZbz0Qp3bif1qq
         HOYY5bMa/Hz92ZC9Zh8RGLFDfpMbPypHgvasIEl8LBX/V9Har6CivrvfgC2DpoO+MwcX
         QeGfDE2QHBMk7L+Vw/dl0S8x+H/h6kukvdMgGtmeDaoHHKEL/YlDUN7FUnvvF6Whytyd
         UmXw==
X-Gm-Message-State: ACrzQf07IFn4xIcdjdTIppz6rC8Khq+m6FmXxXBKoel1D4OtE11dmAQw
        pokNNbA1HdgO/ZJp1ZSdWvQ=
X-Google-Smtp-Source: AMsMyM5eKw3MZqfgT7AoSImT71gghgJhYFZP1LIIi1DTWZigWx36CBw7QluWBtOcrS7RSHr8MCX37w==
X-Received: by 2002:a17:90a:4dce:b0:213:9d22:8870 with SMTP id r14-20020a17090a4dce00b002139d228870mr65397473pjl.7.1668016000181;
        Wed, 09 Nov 2022 09:46:40 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:39 -0800 (PST)
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
Subject: [PATCH 02/12] perf test: Replace pipe test workload with noploop
Date:   Wed,  9 Nov 2022 09:46:25 -0800
Message-Id: <20221109174635.859406-3-namhyung@kernel.org>
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
2.38.1.431.g37b22c650d-goog

