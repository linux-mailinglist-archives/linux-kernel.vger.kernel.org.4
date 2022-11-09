Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8A6231CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiKIRrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiKIRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:47:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD4A189;
        Wed,  9 Nov 2022 09:46:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2549441pjk.2;
        Wed, 09 Nov 2022 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0zLgQdSAIqAU+WOoh8QcTGRCE1+p+yashdyC8yN0/4=;
        b=KsEREoges0F7NLoKhExkw1DyTx3/yMVl0I967wXWVWd6CkOCd93c6pXeHKi8sPAX7H
         d3sEFja87m883x4BOw2BPyYmKbZJi9gU2FxzcmSN9AVyTbLNfqR+2l3/AHR2ZHO5k/No
         ifeTe6Ve4vTbdSJfT5a/Pj/mRcC3GwfUiSKbPoDQ+9y/BBylqJg5xeuq8XDBgyuOqM60
         QlycBxlTtLCKtVu9RZ96bwY/4ZTaAuCvc9hLpWE4r4XT8KRspJtxydjxvMqlngIZyz0g
         C+w0MtUOwR3ewWYJGR/2dd3B9n9X6qmelVMJb8894/BxhogW31k+czZXjvSgqVdb6kF7
         cQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0zLgQdSAIqAU+WOoh8QcTGRCE1+p+yashdyC8yN0/4=;
        b=HY93gGMMSpqTuzLo7U2NxMngzKtAyJTLsdUkegCIvaAP846x5neypQ1gX4OVSNWPnA
         JHeMKMLeVzIbphyxS8q8G5OXaXa0BP7QYYBsC4GCJh2e3w7K3oarlrBs04S3bN0mkuMM
         aW0ElOg/waSVsEps7addmceudKNzo2zNzAjcI/o6EUs0fFmcpRed9cZEF7HVeX+I/Tfu
         tBfYzT4skjhnEHdS7MyCtjxN5OiXHOjOE/hgK9sEP5+2xh6Rfo2964T7IvgWYcfJsFzM
         SxMGGLCsT+hhe5Qkia9cFTfeoDwyoBONcZPgTVWoHwl3vFyLPTuft6JG2sHzjIox8Uc3
         6TwQ==
X-Gm-Message-State: ACrzQf0wP1NHaaItIzwRzaBEWAlwGM9ncGFjFZPDmYindUy+5UIqbJGG
        imd48g7uAZX+r8M+bGOtOTY=
X-Google-Smtp-Source: AMsMyM5cfDmsKklEm7jwgKoBTdqSIAAFVo9O1YJZuIUQ798AnkHoy29sCF1ZlFPkyiJT7x+wITIz5A==
X-Received: by 2002:a17:90a:ba05:b0:213:b1c2:ff88 with SMTP id s5-20020a17090aba0500b00213b1c2ff88mr62367294pjr.240.1668016013193;
        Wed, 09 Nov 2022 09:46:53 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:52 -0800 (PST)
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
Subject: [PATCH 12/12] perf test: Replace data symbol test workload with datasym
Date:   Wed,  9 Nov 2022 09:46:35 -0800
Message-Id: <20221109174635.859406-13-namhyung@kernel.org>
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
2.38.1.431.g37b22c650d-goog

