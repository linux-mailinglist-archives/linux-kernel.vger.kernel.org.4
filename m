Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED7624941
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiKJSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiKJSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:20:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D051C0D;
        Thu, 10 Nov 2022 10:19:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l2so2108942pld.13;
        Thu, 10 Nov 2022 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktjc694U1hBp6r3wDR+QD4vHKh9CxqERsaJjaU1PQNI=;
        b=YmcdUFeUMM8Ol0c17/XE4ouho/c+5RomMI22FzqXEkqEaWfryDP69ZpQMJ9Vmcwm8m
         fIQAAXoGRIYJmustO9mq1ls2lqESUdYeWXeS8aHA22WHzyeT14cjAJlKeMPVV2pCGiAf
         cMLPUh7CbNy0q38zpcdkQcj5sFl4KkmptSVWWRvT3jv5l9HaXfs0fHFtYKAqCtE3G8JN
         VPbs9ACAqQZd7AtBTAdZj8jiAsTrKVwlfpqmmspYDoObmQUmejHK6mAxzxuJzT2IzkE5
         WuahiX7p7NIbVx+auIcpqbx+ErxKjxmssN4GdlUnymd1ZHxQ8u8a9DxXCS1IzbX2T91d
         Vp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ktjc694U1hBp6r3wDR+QD4vHKh9CxqERsaJjaU1PQNI=;
        b=xaL3xcJedUK4dwvn9P1p83Xq80vaBH/O+ljpAOtfy1egJtEVWtdSN91OUU4Y8rcYc4
         sDtbWR2laLouheBQQCuOh2LGACHiqSb2TnSneJWknYaocXqStOfJ4IzbgV0M67pLZkl0
         qVGC6V2xAMe7XzTixgfw1WOpVMt3HyhugjaZuONMD/CcKJGpruIw81hktlXVeC4Iygzl
         DRgs2Mu0iSb0oB7veucFHYRs2FL2oGAUroyqf6bvZxWpD2DBit8k1/Ltk73+++j0mFVP
         QxY15dvvyQm7QzFDYUalLHd6vpq7f1UfGbYjsB5NKbVkRCWNYIWIrn6m+ktz1jg07opS
         DBJg==
X-Gm-Message-State: ACrzQf2uDQzL24thq5/ruXQv6EQy08/Ct2M1Vi3mYBINspTxV5aM59oO
        TR9YKSEV3ztJkCA25vyyGGs=
X-Google-Smtp-Source: AMsMyM6PObiHeZ6E9KpuNVr2sGjj6RnxHueFBIBMmJ5LJfA9b2DXQq3FN2MMoyVILtFuOYBpCuGW1w==
X-Received: by 2002:a17:902:be03:b0:178:6f5d:e979 with SMTP id r3-20020a170902be0300b001786f5de979mr64611722pls.163.1668104378705;
        Thu, 10 Nov 2022 10:19:38 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:38 -0800 (PST)
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
Date:   Thu, 10 Nov 2022 10:19:20 -0800
Message-Id: <20221110181920.84900-13-namhyung@kernel.org>
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
2.38.1.493.g58b659f92b-goog

