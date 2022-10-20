Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD56066F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJTR06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJTR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:26:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B402A971;
        Thu, 20 Oct 2022 10:26:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so182302pjf.5;
        Thu, 20 Oct 2022 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSDt8hP5nyvEWrVukBA1Cz84sJh8J6UC7io/poKcOEs=;
        b=N0RW9lwt1ROLUFDlxho2ayGf0ooWdY2RDq636CZ8ocTQGvJLQPBJ5CqTubBqIfbyu7
         PXf+mdlvr8RfVjXEirfd0j43SP5HORrnG20uILv3KjSo4sMhv9MZ5IhUDPfLvfACIep2
         s8PptwM6hTbl14Q8eyOudBn/zfvJ1BuxfTyMsKNamtrRQ+6HyPCsNRjs4NtPe+JqmsJH
         2aKulOj3uETNV2WYNz4VntKAkzWluXfRmqHnEkcoUKdYRZdFA1jhn5+ZnHGKLI6m70h1
         g9XY1pvwe8Ra0bQ9ZXn3O2oTwkSfLBxVWaXrof/x+eahfw1058mxXwMe8bWuJtaZeAei
         XpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSDt8hP5nyvEWrVukBA1Cz84sJh8J6UC7io/poKcOEs=;
        b=eISdkpxJKB/Usy3u6PEYvm2NnZBZXSuvIHqoqcoU6TzkoPEmN7kdrVqqc8vQyyVQN2
         sQB1uJmoSXk80bWp1dtlvvGc0UAQWsQwr9cy62ML0Fww7Io4W+L47htWZDG1ffoi0OvO
         mQXvazPVvW6QNbthjBD5Lt/hKBEfyVl+4w3uiC0pVdBssoBb+Bm2HGE58mjXnTYXCFba
         YgVaWPR+s66zAUSsEf9c9TrjHDcWTGpL0Tyxft0A+BETlumGWfo2dDvWAxITJs/T8TRs
         xXhBzqKNenHzfEAroLtQ+nSPG/54Blczt6Wv0dIZHNFQaabwaX7ZmNh/L7r61pQe1vtL
         H5Xg==
X-Gm-Message-State: ACrzQf2bjayvp89slIDFERhWLFwjZyNSfCXNTGTyJu87YAzXyxoEMrRz
        zUVa165aFJqZKpTzj3s5VELFG8FfmQo=
X-Google-Smtp-Source: AMsMyM5o5LvTscI4opw10g7FrHdi5ysWG3kfq49oKHRv9Q1CSnQQEPHg9cgluvd+edhgylc7zGejtw==
X-Received: by 2002:a17:90b:4d90:b0:20d:7f17:5983 with SMTP id oj16-20020a17090b4d9000b0020d7f175983mr53643954pjb.197.1666286808881;
        Thu, 20 Oct 2022 10:26:48 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:48 -0700 (PDT)
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
Subject: [PATCH 2/8] perf test: Fix shellcheck issues in the record test
Date:   Thu, 20 Oct 2022 10:26:37 -0700
Message-Id: <20221020172643.3458767-3-namhyung@kernel.org>
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

Basically there are 3 issues:

 1. quote shell expansion
 2. do not use egrep
 3. use upper case letters for signal names

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 747c33a1ec45..464071462809 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -8,16 +8,16 @@ err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 
 cleanup() {
-  rm -f ${perfdata}
-  rm -f ${perfdata}.old
-  trap - exit term int
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+  trap - EXIT TERM INT
 }
 
 trap_cleanup() {
   cleanup
   exit 1
 }
-trap trap_cleanup exit term int
+trap trap_cleanup EXIT TERM INT
 
 test_per_thread() {
   echo "Basic --per-thread mode test"
@@ -30,13 +30,13 @@ test_per_thread() {
     fi
     return
   fi
-  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
+  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
   then
     echo "Per-thread record [Failed record]"
     err=1
     return
   fi
-  if ! perf report -i ${perfdata} -q | egrep -q true
+  if ! perf report -i "${perfdata}" -q | grep -q true
   then
     echo "Per-thread record [Failed missing output]"
     err=1
@@ -47,7 +47,7 @@ test_per_thread() {
 
 test_register_capture() {
   echo "Register capture test"
-  if ! perf list | egrep -q 'br_inst_retired.near_call'
+  if ! perf list | grep -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing event]"
     if [ $err -ne 1 ]
@@ -56,7 +56,7 @@ test_register_capture() {
     fi
     return
   fi
-  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
+  if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
   then
     echo "Register capture test [Skipped missing registers]"
     return
@@ -64,7 +64,7 @@ test_register_capture() {
   if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
     -c 1000 --per-thread true 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
-    | egrep -q "DI:"
+    | grep -q "DI:"
   then
     echo "Register capture test [Failed missing output]"
     err=1
-- 
2.38.0.135.g90850a2211-goog

