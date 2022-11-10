Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2762493B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiKJSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKJSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F14C25F;
        Thu, 10 Nov 2022 10:19:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so2180477pli.0;
        Thu, 10 Nov 2022 10:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W1IE2xF3dtxcNrj5t79DBInf6fMe+hYp9ym1CIb+t0=;
        b=YhqlzF1L0IAbbvz6hY9m89EYo+kFy9yEK0/JcmBQzgk1D3UCS7dwZom64Ufaikv4MZ
         0ZZ361jjEKVhtwdtTrTQWQ8KTc6UWGJrfoJ4aZnt0SxD5yHPondQPsfd2y5XLW9jvXW1
         v2RRg3YAkEIOHks4wLk8rqJjFfwoZWYXHxiYf5J5DaHpoI7f/PkfcpoL8sAkbg1jhIPI
         wihJMKrx2ZLsy9fqqfclcsPVU9fEeQAUK5rIbCvYM4isymCMkgwOgJyuMhIyDH7xCJ1j
         7kHUxFRIiEXCRQJWHWrJDuBbzlP+xp3XJYDfCyvE9N6CNegEaYOtZLrfpOum252nv8Od
         N8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8W1IE2xF3dtxcNrj5t79DBInf6fMe+hYp9ym1CIb+t0=;
        b=eqF6FaaLrM6VaRHawIFcZyJ320cFdNuQQ1Q268K/XcIvi4gsYLMKW3CTheSV6coN1p
         OmiYOv27BNHMzEa5czNIZuzwtMsf+dFaq8L90cHtsz3OUxFX0oeGOS2rbpU/7icW1MqF
         C7Sm+mLZSlgUCrVpaS9JotFUCXO1v4IPTWxCEYZfJLDkBfVKaLrKyllvPbayI56XiKnM
         seApYCm2IfWlaBLZ1oPmOrVKb1Dmx4y45kZA3jXvpzwX+m23C+2473IRkvwj2BwFqt0b
         +exPyFPJ9OhSqYcZvDaY70ez0LAGVjj5UkGBUlvo2fAOTT/WIH+ytEQtFu8OyKrztO34
         UIgw==
X-Gm-Message-State: ACrzQf0mi3qPRu4EMz+KO2eaJwOpQhH/NJQxVE4ZR8JOoNzgifWHfME8
        Rg51fFyQjkC6rWPr3gyH6Ok=
X-Google-Smtp-Source: AMsMyM7pxfvA0clrJcFC9vmK9FLyruLSBYjT14RJp002pNmP6cA5AoafU32vB7FxzL6t9/hdUdaxpw==
X-Received: by 2002:a17:902:744b:b0:187:12cc:d6f1 with SMTP id e11-20020a170902744b00b0018712ccd6f1mr1630691plt.63.1668104370928;
        Thu, 10 Nov 2022 10:19:30 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:30 -0800 (PST)
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
Date:   Thu, 10 Nov 2022 10:19:14 -0800
Message-Id: <20221110181920.84900-7-namhyung@kernel.org>
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

Reviewed-by: Leo Yan <leo.yan@linaro.org>
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
2.38.1.493.g58b659f92b-goog

