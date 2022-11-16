Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9B62CEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiKPXjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiKPXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:18 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD5E5E9F3;
        Wed, 16 Nov 2022 15:39:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n17so399578pgh.9;
        Wed, 16 Nov 2022 15:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B0JQCucRHYT7xdR8VvGZSXNFmNKxBu//apj1OM/otI=;
        b=RM9X4ZhuxQE0eTgHt6Bkzsehc3s28N9CD6mk3dzLOwMBSxOEFpVaMq2T1PaSydFzi4
         uwQaIJR1oAqGr5m+NPxZKn8PdLgSZIUxDTYYEaPkv2AYdzUtnyGZ6bw7o4TSz194c3md
         NNJp0XaOJCghD+5VOA/a1SX/lRT/B1QrLvDNS5bg84DCfjEoMcVokjieODSY6d861ghY
         6eJZJBD6fEs5ne+qj8ul9wzzrYQaC0Iob6Zpuv2Ppr8Nu+PgjsLFh04ncZPCrwa0GNLc
         Z3Hush6NSte7PvwFzenbk0Gr2YlyTIMI6jm1+RH9eL9K82ujF1p5RYJx7BxX2uZkvvGB
         dtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5B0JQCucRHYT7xdR8VvGZSXNFmNKxBu//apj1OM/otI=;
        b=p4y1T8AgjvQD7CrrBA9WLYYMLBVfuYH5bSyddgKl1eLmN8Fxk2TcOClZHpHPMFrEU8
         WEJTCSiXNC56T0JcPZ0fB5RZyyjg0Pgzlivm4I4mxaHjKjsw0m2vHc4bYLtyWiafUD2z
         DNr2+sTMiYAchZgRBzGOUPUv6LsbEQF/4FjcV2m+uXuUl/az0hKaZb9wWCVfOj+KhWCv
         JH6xS4t9zQ9U41ngTfzzceHyUQP8wx2GUIZDM+fD5rrZsmlanI5taYY7L+/BqAy26bDV
         aRC820djhBknfBYG7jNbtmELiiQ3+0AmpmaRyhC1vE2CKkeBucSiuws1Br3yPawzATtY
         JUMw==
X-Gm-Message-State: ANoB5pl9k9+gAKUNR2bm+DYaFx0VbuC4hDdrL86P0C/aNCrgPbmz7qr4
        2y/nfaAlapkd+48g/EIiNrU=
X-Google-Smtp-Source: AA0mqf4rkSX0yP0Q9MUnbXbIcS72kUIGIXcnYqKWa9WtQDB/ko8FE2i3jvZG3GFzLtf3TDTFBR1WOg==
X-Received: by 2002:a63:d611:0:b0:439:3ca9:94a with SMTP id q17-20020a63d611000000b004393ca9094amr22401064pgg.107.1668641948807;
        Wed, 16 Nov 2022 15:39:08 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:08 -0800 (PST)
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
Date:   Wed, 16 Nov 2022 15:38:50 -0800
Message-Id: <20221116233854.1596378-9-namhyung@kernel.org>
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

So that it can get rid of requirement of a compiler.  I've also removed
killall as it'll kill perf process now and run the test workload for 10
sec instead.

Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: James Clark <james.clark@arm.com>
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
2.38.1.584.g0f3c55d4c2-goog

