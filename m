Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7614E62CEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiKPXje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiKPXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25DB65E4B;
        Wed, 16 Nov 2022 15:39:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3821034pjc.3;
        Wed, 16 Nov 2022 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl5CORbtyeq6bL62pR/J7Hye71rdg9cfUGIiUjVmACc=;
        b=lMoX6oWy3zqd7jliSssWvwdjFagbZKGt2pkPll3nIBB5To/tHcukd+z0XU7bbJvNh4
         d+yfNHSU+LGHsQPFxKJRZBSe2NHNTAsHxNUPaOXTsu5yyRNKmoKYVGTgst2ybLU9bFHe
         TBU4O51yENG3q9dFooPwbmp8xf3LUTxOqfa6uu8CTHJKwXRQJsObHnU/ihmoqaowF8NP
         3iMG2tXU4igHwrSS8S+h2coWlXBQF2NGl69NAaW4s3WlmRd1gakCKzeB/UGvWl05FpYY
         UYkj/jdIaeqIx0HJPhuK5r+VVqrG3O8K0Pujg1r6mN8unIx2uvFz1xH2MDZkwcjJ85o/
         IU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kl5CORbtyeq6bL62pR/J7Hye71rdg9cfUGIiUjVmACc=;
        b=LSt48tO29jTFJZYfjqUHkQ+30qbKrlNq1kDQ92+ZGm0l6nhONFn1umQkpUwcES5yCF
         3dCGzT6N6skaBZg+Y3NA1g134qL8yVTSDnNgWG0jhs3mx0F6izqGM4zdYb8Q4eIYY6fT
         d/5Wr9bQo51b/XnEBJaJYVTHQC0d41yttybuaZD6XkpwrUZcTlzVf9Xo+rku+NWSybs1
         bPfOvAsy5OZUEOWRR5SK7ClZraNWP0Y9Pj75obu81MEdTg7D9kliJraU8YR3HLVy15Yv
         wL3Rsj9TpgfqwS6ac2wN50xtYjj2aSKD8CJmbiAWA4d9s9MZeSEnWaTCxINrXAYNFwtt
         1aJQ==
X-Gm-Message-State: ANoB5pmfxQoHvQS2qrW8OWlk6JLSCFk/wFgp2ea6ag1C8aKUvUYcW1sl
        l0E3dIRqnWPi7LMLb7oz7W4=
X-Google-Smtp-Source: AA0mqf7tKvgf9qg1ML0mEiAtf6QPnXgYdTg6RcD64QHKhPR670BpP+MGoBnWzI059quAH8OoUWkxtQ==
X-Received: by 2002:a17:90a:6c25:b0:213:d1bc:9b74 with SMTP id x34-20020a17090a6c2500b00213d1bc9b74mr5798466pjj.229.1668641946124;
        Wed, 16 Nov 2022 15:39:06 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:05 -0800 (PST)
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
Subject: [PATCH 06/12] perf test: Replace arm callgraph fp test workload with leafloop
Date:   Wed, 16 Nov 2022 15:38:48 -0800
Message-Id: <20221116233854.1596378-7-namhyung@kernel.org>
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

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/tests/shell/test_arm_callgraph_fp.sh | 34 ++-----------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index ec108d45d3c6..e61d8deaa0c4 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -4,44 +4,16 @@
 
 lscpu | grep -q "aarch64" || exit 2
 
-if ! [ -x "$(command -v cc)" ]; then
-	echo "failed: no compiler, install gcc"
-	exit 2
-fi
-
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
-TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
-TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
+TEST_PROGRAM="perf test -w leafloop"
 
 cleanup_files()
 {
 	rm -f $PERF_DATA
-	rm -f $TEST_PROGRAM_SOURCE
-	rm -f $TEST_PROGRAM
 }
 
 trap cleanup_files exit term int
 
-cat << EOF > $TEST_PROGRAM_SOURCE
-int a = 0;
-void leaf(void) {
-  for (;;)
-    a += a;
-}
-void parent(void) {
-  leaf();
-}
-int main(void) {
-  parent();
-  return 0;
-}
-EOF
-
-echo " + Compiling test program ($TEST_PROGRAM)..."
-
-CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
-cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
-
 # Add a 1 second delay to skip samples that are not in the leaf() function
 perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
 PID=$!
@@ -58,11 +30,11 @@ wait $PID
 # program
 # 	728 leaf
 # 	753 parent
-# 	76c main
+# 	76c leafloop
 # ...
 
 perf script -i $PERF_DATA -F comm,ip,sym | head -n4
 perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
 	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
 						       sym[1] != "parent" ||
-						       sym[2] != "main") exit 1 }'
+						       sym[2] != "leafloop") exit 1 }'
-- 
2.38.1.584.g0f3c55d4c2-goog

