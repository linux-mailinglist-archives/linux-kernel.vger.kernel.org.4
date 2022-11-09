Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A06231C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKIRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiKIRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:46 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D5659F;
        Wed,  9 Nov 2022 09:46:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i3so17363174pfc.11;
        Wed, 09 Nov 2022 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wE8Me379mSupxG/Q4MDBJ3KdIEi26s+14+TmqgM5rk=;
        b=C+ttYSOxJxIEIEFyyJ5ogzydLA0DxS6DU3gqCqezxULR/kleYyHQlDuIrosSrqMJ4s
         dLvZOA+QPOdNUaNXXXWgiCVhb2WVxrGOPgss2tN6gdmcFD9GmjZ31r2Axkh0+icg5ryS
         A921XnKjvSB2uNdkAq3qy0Lp4ZeLFF5aX7UUHfn6L03UiBF6cGTqMCr8/4JgR1GNfjKj
         fsXOUZs/LzgMyr4irSpjayQvgsHLCd82kHjSE2ubCxOL4cTfFfeLgz301EuP0IJCQ1uD
         TYgbAIQVdDnF+jDjXobh1Ks9XiYABK0zWM1LBfw0O4wz9TxZh1+DaWd5nwHOanTVvq93
         Kl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wE8Me379mSupxG/Q4MDBJ3KdIEi26s+14+TmqgM5rk=;
        b=jydHdMxCkHfl5DMbYT9ObWK22m0vj1vh2Q4DwwvBNUCrTVbwWXKUy49oH29G+gIa0A
         0nPVgYxjfaxI8Q7o08XiSK5rlcY0AkBGKPL5Hl5UnM3C+/Z04XbGcZ0nqzKsBf8Ot4hC
         BcRo7AvKXZwdeCa0ZMj52NVSS9cG90qJZrn+wsLkkUzSK5ImKvdQAPp8eMNExU2NJc+f
         Kz3XgkuLWnzEYK1fADATZvsP0MbAUofwrN/67zPcFwwMG1zL9jssrHCCTNZUtfrHM5pl
         KT6FyCJyKR5meRsvNJku5924RAidpMbJR9GuM8KBX/W7PPOC//t4jBLR1w+RrNn7lAbF
         IC1A==
X-Gm-Message-State: ACrzQf1LWDk8kktepI99WmEziUy0cwYtnfpiqvNnfHBeeO1MkyhziS7r
        P5DJnLInutEej2LhDhfDE4U=
X-Google-Smtp-Source: AMsMyM7HyQWIGi/d2zKtyFv6WyijfsqMOdT+F9yMVIjqhjWuprUS59giR2ovW/1AkcrqBe55GwYsDw==
X-Received: by 2002:a63:90c9:0:b0:46e:dd5a:d921 with SMTP id a192-20020a6390c9000000b0046edd5ad921mr52329416pge.282.1668016005320;
        Wed, 09 Nov 2022 09:46:45 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:44 -0800 (PST)
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
Subject: [PATCH 06/12] perf test: Replace arm callgraph fp test workload with leafloop
Date:   Wed,  9 Nov 2022 09:46:29 -0800
Message-Id: <20221109174635.859406-7-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/tests/shell/test_arm_callgraph_fp.sh | 30 +------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index ec108d45d3c6..9d6d1b2d99c5 100755
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
-- 
2.38.1.431.g37b22c650d-goog

