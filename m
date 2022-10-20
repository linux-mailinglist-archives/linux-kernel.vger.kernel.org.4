Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2378A606700
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJTR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJTR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:27:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0051C4ED7;
        Thu, 20 Oct 2022 10:26:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b5so144769pgb.6;
        Thu, 20 Oct 2022 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6Z6RkNEbmfwHHP7f+jrXNR4HQTQXY+7XH5KVa3sTHw=;
        b=TdE6JdKCuD5lMOIrusLTVhFxkdEoXK78uY18+UWcYmD/XXdwZiTurzJucoD8xt6on8
         ALYWqn6VexTkr4HtfJ3TBe8OSxfyFmgkUWZr6FiD0LDScoMeMUXoDNKOsZ1ZZJFvFZqd
         yXCdbJ45pLBU3uC7qEmUYCz/5+ghkrtWo74dliJ9k4NYXRTc93XOMNR63/jy9DrQMaCx
         Y39YMm9Y/U+ZIRmjoeLQrn13iQEFzzWKumwPShygqhJghQsWVe9BeBkGWzMsDyOtDDma
         rMLOtPmf9M8GwJ96NsL4/x7eELb4aXGiDJ/EBr7n+SPcvnBTy2YFNENfTgEopqdnXzUJ
         7EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6Z6RkNEbmfwHHP7f+jrXNR4HQTQXY+7XH5KVa3sTHw=;
        b=fyLLbSWaYT3wMOM6ZKigZsNyht5Nct+zUWn1564wfUqQx95+xTpgLZFX/5IGllb6gN
         mH6RDJOjJfvPx37yqXpoUGGV1lkKEyxb8IqkJa+BbUdsJMmUcFD5p9+weL5Crah4PQr+
         qG+LBpYoDtcR8SLULGYnqcRMgbWWy7AtZPmBAnpLl3us8l6d5USQBI+2aks5Ntjf6QdV
         UjWpWNon0tjBrkqaGFYPsF6skUbwsnrn7ab42vgYfk7Wyqnl0PzfNw2O2yBCfPgNn24t
         280IgQMaFs4uF/8eVC+UEs0GN628CxQ2zsUMUzqwfFq+ppbi3rt0YRQ3Vw5HLAlI56CL
         MUMA==
X-Gm-Message-State: ACrzQf2vPiGn0iWn4FsaAR/vjVPjTIPoCRiXM+GPPCsYaFTkcQuhGfTO
        iItjuFXN3EawQ21YV5sEGqs=
X-Google-Smtp-Source: AMsMyM5k7+OIuh6T71CZ8bUyJoIiko21r7jEhqcX5Nm/GdfSb/EgqHo6yZFZeP+TQ1KygNw5FncH1Q==
X-Received: by 2002:a62:1553:0:b0:565:a402:8b28 with SMTP id 80-20020a621553000000b00565a4028b28mr14813218pfv.36.1666286815298;
        Thu, 20 Oct 2022 10:26:55 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 8/8] perf test: Do not set TEST_SKIP for record subtests
Date:   Thu, 20 Oct 2022 10:26:43 -0700
Message-Id: <20221020172643.3458767-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221020172643.3458767-1-namhyung@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It now has 4 sub tests and one of them should run at least.
But once TEST_SKIP (= 2) return value is set, it won't be overwritten
unless there's a failure.  I think we should return success when one
or more tested are skipped but the remaining subtests are passed.

So update the test code not to set the err variable when it skips
the test.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 01aa9531b369..e93b3a8871fe 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -81,10 +81,6 @@ test_per_thread() {
   if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
   then
     echo "Per-thread record [Skipped event not supported]"
-    if [ $err -ne 1 ]
-    then
-      err=2
-    fi
     return
   fi
   if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
@@ -131,10 +127,6 @@ test_register_capture() {
   if ! perf list | grep -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing event]"
-    if [ $err -ne 1 ]
-    then
-      err=2
-    fi
     return
   fi
   if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
@@ -159,10 +151,6 @@ test_system_wide() {
   if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
   then
     echo "System-wide record [Skipped not supported]"
-    if [ $err -ne 1 ]
-    then
-      err=2
-    fi
     return
   fi
   if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
-- 
2.38.0.135.g90850a2211-goog

