Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991A66231CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiKIRrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiKIRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D59FCA;
        Wed,  9 Nov 2022 09:46:48 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 78so16811777pgb.13;
        Wed, 09 Nov 2022 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnolDoJWoN1jSsgwiCbHUTF9CcTJ9HQuyPHUeyGhWlM=;
        b=hyFbfy3B8gm/SCbNi6Q5PNjxZM0cM7w11zxRzVEhg6Y5bLHA8iZkrJtxvO7/BSXOuM
         PVGy/A7ZXUjMUnIyiDCQC2SyTJK/HHYEVLLYlpcO3L/T8P6lT4oj6wkZLzRCblpFeEB0
         Jd16IYN8aqQRbD7OAbdRPofZZHckqtJ9tPZyDpVdfIerQdLDseBkS30CgbCY3ijoP0tY
         tKLhOafU167M+f1ZV+owyVU4dEDuh8a6Zc60GaDzFPyKCjUOBgM2M7+fdpW6qPf34mxB
         mddvpK6b3tpHbdczghlZDBeL7/AJIrR89e+QMUp+WxaIs0s1QrK27Q2UjaT5lzYUW7DG
         YxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnolDoJWoN1jSsgwiCbHUTF9CcTJ9HQuyPHUeyGhWlM=;
        b=4Jqzh2tn+aFtaHc9iTeDyd9caM1sqtWbOTDaNIH8vMBLPCSG3keGJ6UnxrYGiptDJd
         s5g2MkqXovUWs5zNM5dEKpNRx1cjvbJdm10A+XGotdK5Xrwfnz5BiGn2R8/BJkywsvUm
         0/plT36BszwyJuLtqqFpfYVuzMc3eidYOUo1GTHTcq8LvhcJdb/S7C4n2INEY2cRVfkD
         k/Xe9P1d2YHMBV6w08dLOLQpPT9A3e2QmOHzN+Z4DGTbb9/hovL81Ye91/MQNMd//d2v
         cZ2zGWcCITBbC4ApU73K3Uz9kJsLZyx5pIM/QF77jrB1jntrhmuh+lUlOtdf83G0+p25
         FROw==
X-Gm-Message-State: ACrzQf2c/c1iWtlETIAwnnW9hcpbk5x4j1pQgOOHqaFM7mNwDV93mwYX
        /u5gKvY1NcjTDspdfdyJuag=
X-Google-Smtp-Source: AMsMyM7SrZoed1mWEtvSA0b1V/M3P+ImxkQXZd5FSJ2/6DPJuJP+AJe6y7pkq6pLwyKQNTcGTAOw0Q==
X-Received: by 2002:a05:6a00:cd4:b0:56c:b47:a743 with SMTP id b20-20020a056a000cd400b0056c0b47a743mr61321304pfv.25.1668016007901;
        Wed, 09 Nov 2022 09:46:47 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:47 -0800 (PST)
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
Subject: [PATCH 08/12] perf test: Replace arm spe fork test workload with sqrtloop
Date:   Wed,  9 Nov 2022 09:46:31 -0800
Message-Id: <20221109174635.859406-9-namhyung@kernel.org>
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

So that it can get rid of requirement of a compiler.  I've also removed
killall as it'll kill perf process now and run the test workload for 10
sec instead.

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
2.38.1.431.g37b22c650d-goog

