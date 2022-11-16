Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6089262CEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiKPXkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiKPXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582E6AEDE;
        Wed, 16 Nov 2022 15:39:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h14so105517pjv.4;
        Wed, 16 Nov 2022 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+MBjHLXrFB++GMwQ9Qm9dxDqVPjyqYA8sAvvb3VHA8=;
        b=KO5GR2cRgLhvf8OFPJYQf72Kn7B46DuZgskYrT1iCiFw/RVDAkik+Px1eM3W040SeT
         0OfNnY+zr1G/FyTiOSN01zXMupTNaKoPplxN4tgDx1xaA3U9rI1pPSaa/+sFH10UOinu
         bsIjh7005H0PgciKL7SId0FARe/GYKuhLB+l8rJ3Llys8WwVk610mxKoFCHzQXEwqk8B
         xJwSliW7wOR8DpsylRCRDJtHSCkVD6tBtgDLX5cHLTta/UDAXhNTMgOmXx8l+u29fqLL
         CsQmmis9KgUrMiqC8joDavEzRljKyUkoMnFD8W6J8GmxSAIyuAR9A63m43RskhPoXZ8N
         3zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+MBjHLXrFB++GMwQ9Qm9dxDqVPjyqYA8sAvvb3VHA8=;
        b=jIaavhVKVL1GPVLhBUI8x8vPVOblAjYSEAh2JV3NU44mmgY1kKBiXXZVt1IuJx3BFS
         +UTNNsTw2uDWzv41apQjjf1eiAB5x9xTLUc0dlTIkWXq2PaR7/cnoF06S2eU72GqJN23
         gRo6DcBpAvxU2yY+K65jO1M0a5acNA8XdrOFC9TlMihl8cajWZ2OetPchOPwBxvvIXSe
         Rq0FYvKgqB1JJWay73Wfa6/o9d4hEw7lXdx8WiQafiFCgiXei7Bqvx1+b77A61zhSbXD
         NbgsxXBBa2d/dTS8CQA7wbfSgw1bIAzopTsq/J0XGNgiVmxgR8DBjlXL0jWHbXStbZ37
         4Hlg==
X-Gm-Message-State: ANoB5pkB4mL8BRmbpwkqye3VM6Xctx2Kb35BCxwS6E0sU/iPYBCyQwqY
        czBAEX0l7uxb75iVvVzHm5Q=
X-Google-Smtp-Source: AA0mqf7CdIlZA5rGskaYKWMRpNCkWk0iFgQEXkA/pjeoi0PBKOmZ+dW4lpWAN9n0AM3KCkZUDz4mbg==
X-Received: by 2002:a17:902:f383:b0:188:4f86:e4d5 with SMTP id f3-20020a170902f38300b001884f86e4d5mr247842ple.16.1668641953822;
        Wed, 16 Nov 2022 15:39:13 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:13 -0800 (PST)
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
Subject: [PATCH 12/12] perf test: Replace data symbol test workload with datasym
Date:   Wed, 16 Nov 2022 15:38:54 -0800
Message-Id: <20221116233854.1596378-13-namhyung@kernel.org>
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

  $ sudo ./perf test -v 109
  109: Test data symbol                                                :
  --- start ---
  test child forked, pid 844526
  Recording workload...
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.354 MB /tmp/__perf_test.perf.data.GFeZO (4847 samples) ]
  Cleaning up files...
  test child finished with 0
  ---- end ----
  Test data symbol: Ok

Cc: Leo Yan <leo.yan@linaro.org>
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_data_symbol.sh | 29 +---------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index cd6eb54d235d..d871e6c743ef 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -11,13 +11,7 @@ skip_if_no_mem_event() {
 
 skip_if_no_mem_event || exit 2
 
-# skip if there's no compiler
-if ! [ -x "$(command -v cc)" ]; then
-	echo "skip: no compiler, install gcc"
-	exit 2
-fi
-
-TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+TEST_PROGRAM="perf test -w datasym"
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 
 check_result() {
@@ -45,31 +39,10 @@ cleanup_files()
 {
 	echo "Cleaning up files..."
 	rm -f ${PERF_DATA}
-	rm -f ${TEST_PROGRAM}
 }
 
 trap cleanup_files exit term int
 
-# compile test program
-echo "Compiling test program..."
-cat << EOF | cc -o ${TEST_PROGRAM} -x c -
-typedef struct _buf {
-	char data1;
-	char reserved[55];
-	char data2;
-} buf __attribute__((aligned(64)));
-
-static buf buf1;
-
-int main(void) {
-	for (;;) {
-		buf1.data1++;
-		buf1.data2 += buf1.data1;
-	}
-	return 0;
-}
-EOF
-
 echo "Recording workload..."
 
 # perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
-- 
2.38.1.584.g0f3c55d4c2-goog

