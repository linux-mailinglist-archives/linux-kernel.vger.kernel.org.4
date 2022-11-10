Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E862493D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiKJST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiKJSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1894E40D;
        Thu, 10 Nov 2022 10:19:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y203so2858406pfb.4;
        Thu, 10 Nov 2022 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FODnLSuSnJC8nWqwuvg7shPnq+VjgBsbYk20eZkpuhA=;
        b=jT8M1/whbkeXDZtiqh3HyRJML6ytB5gkJNQTgcFjlwAqfQqa+qLL+b42Tl8u9Aevt6
         WbH0MQCRL1vDsFcxwh3g/UIAXK1Tk2f9x+9mvvqGQJy0CLdOIF6gFTVRWtRcWN5ip5Md
         e/LF13TYoq/D1nWImPpNTuHUrj9+Rzsbr5uRk+nNjLsUdK2FWspWLdinwCf2IYZP98CV
         ENRfZdX4ZfgGznrv/Vx/uQD552heVX2JaFKcCULUmP7JtfjYs+/Wo53aT9hhTrDVhQJe
         3V2+tmECwiClHpZulzRuw3LG1w4r/d6enqsyDcPr1fWLl5VyhF3IwZUQzxSxMGZJjkmT
         XTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FODnLSuSnJC8nWqwuvg7shPnq+VjgBsbYk20eZkpuhA=;
        b=DYG3uHmuxXG7EuWg0vWdcXr4bk/BsDG6UKZJWqzyu0uz6p4C5PmDcZoI2ZRVlQRTur
         Uq0wFl8v0xFNfHF71z9DWWQhAg5OoKtKDo6YW7A3AH+N8Tsz/6ynFBZXLA3Ae+vmeiyi
         FZxTr3YFIbqBaaOQ4hc4J/2HgerEgwl+1z4amWJnL7/+nTz+0m24HdmHzzmOFJV9DyBW
         IylwsHTVQdXqvJqXFw4WhFpHYJL8dfDX9qEtpAD1Td5BYVOfnfB9AycxsgK0LajJnLy0
         aOKsYL/oQtTCvmovrs1mL9Wzj8TbePobA0vj4Jq3vYVyOZvxz0tL8u/p2FZMK3pNLuOh
         8mvw==
X-Gm-Message-State: ACrzQf2uDJmThqwaz1YRpRiPkN8VjKHGotihkFQFu0ZdTU/xqaT0Efv8
        mnlEBLRXilH70jcFwqdO6eY=
X-Google-Smtp-Source: AMsMyM7Z/W5IaNO1NKHnHgCDr5JV8HTvaqMtd1RUmvim9aCa6QR9KqHP7LbKlfrRJzpT3QFArnC2aA==
X-Received: by 2002:a63:ec42:0:b0:46b:27b0:c245 with SMTP id r2-20020a63ec42000000b0046b27b0c245mr2996232pgj.611.1668104373617;
        Thu, 10 Nov 2022 10:19:33 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:33 -0800 (PST)
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
Subject: [PATCH 08/12] perf test: Replace arm spe fork test workload with sqrtloop
Date:   Thu, 10 Nov 2022 10:19:16 -0800
Message-Id: <20221110181920.84900-9-namhyung@kernel.org>
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

So that it can get rid of requirement of a compiler.  I've also removed
killall as it'll kill perf process now and run the test workload for 10
sec instead.

Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_arm_spe_fork.sh | 44 +--------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
index c920d3583d30..da810e1b2b9e 100755
--- a/tools/perf/tests/shell/test_arm_spe_fork.sh
+++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
@@ -11,14 +11,7 @@ skip_if_no_arm_spe_event() {
 
 skip_if_no_arm_spe_event || exit 2
 
-# skip if there's no compiler
-if ! [ -x "$(command -v cc)" ]; then
-	echo "failed: no compiler, install gcc"
-	exit 2
-fi
-
-TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
-TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+TEST_PROGRAM="perf test -w sqrtloop 10"
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 PERF_RECORD_LOG=$(mktemp /tmp/__perf_test.log.XXXXX)
 
@@ -27,43 +20,10 @@ cleanup_files()
 	echo "Cleaning up files..."
 	rm -f ${PERF_RECORD_LOG}
 	rm -f ${PERF_DATA}
-	rm -f ${TEST_PROGRAM_SOURCE}
-	rm -f ${TEST_PROGRAM}
 }
 
 trap cleanup_files exit term int
 
-# compile test program
-cat << EOF > $TEST_PROGRAM_SOURCE
-#include <math.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/wait.h>
-
-int workload() {
-  while (1)
-    sqrt(rand());
-  return 0;
-}
-
-int main() {
-  switch (fork()) {
-    case 0:
-      return workload();
-    case -1:
-      return 1;
-    default:
-      wait(NULL);
-  }
-  return 0;
-}
-EOF
-
-echo "Compiling test program..."
-CFLAGS="-lm"
-cc $TEST_PROGRAM_SOURCE $CFLAGS -o $TEST_PROGRAM || exit 1
-
 echo "Recording workload..."
 perf record -o ${PERF_DATA} -e arm_spe/period=65536/ -vvv -- $TEST_PROGRAM > ${PERF_RECORD_LOG} 2>&1 &
 PERFPID=$!
@@ -78,8 +38,6 @@ echo Log lines after 1 second = $log1
 
 kill $PERFPID
 wait $PERFPID
-# test program may leave an orphan process running the workload
-killall $(basename $TEST_PROGRAM)
 
 if [ "$log0" = "$log1" ];
 then
-- 
2.38.1.493.g58b659f92b-goog

