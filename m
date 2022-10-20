Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AB6066F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJTR0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJTR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:26:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594751A1B01;
        Thu, 20 Oct 2022 10:26:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so4149521pjq.4;
        Thu, 20 Oct 2022 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyshK7iYZ8XULGV5AWhAfvvym7/uA21Df+Y+HX9QYb0=;
        b=huTJFdkUecF8TGzQLLF7zQR3m817T7caMcVFk1X1HFFcunW/qxpRIzuNdRgNp9YqqC
         4erIuFOo0N3fk1yBwunPDB7AwfRpS4skpBb3GapttN8tJR4Pj1FP52TRxXE7ZQcBRjAt
         Uyf9bUk2IqMILVqiZnpCslBjYb6WAI896ZicB9uKXSqaeW4lMwda1d1gN8rr87Mnx4LA
         6yv9ET1FPfDyxBHshHme70jUsHjC87DVvGkotDtQdtVN8VpcAp2yB70KmDhgGZl519eA
         IsVEmtdAbDJu0KoVRoX34HDr5CawYlZiv1XxTaNR4IUdui3x9KpmdHnei4corF9VXRoK
         mIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyshK7iYZ8XULGV5AWhAfvvym7/uA21Df+Y+HX9QYb0=;
        b=wRojlP4qyexTcDDt1NQ9T2ErvZ9+DJwbMjqwbE6ARNm+i3SqS3aCjKFdOUzohUedbe
         ZGdx8tsYap1F/FVVk8JX/h2grBBHa/3Im2wO55EMOKE8nhf3azk1+Fc1rYXwBBrsEwKN
         C+w3T30qT/qkwA3wbuaEN5nxe/pLGjoZgsGb2nHk0yJG+miIEWODEUmyBqZpjri9imH+
         sCF1BaXq9qdzLmWMOGgNaRjswYqcbz/ZFUrIkwimmLiPTr/sb+QzHNy/1/O1LjZLMi0Z
         hYJCZ47bz+BOwD/G/ZWM3HNqavdKB07xfXtMyI2GGq85PQUB41icxkCXC1jtVxERnvbi
         iXEw==
X-Gm-Message-State: ACrzQf1VNVWTowO21RRJ/0tS2D+eCmeH4/6COml4RKBIgm6OEMNCvN+W
        kFIMKaewISdZKuCmz+OpN4s=
X-Google-Smtp-Source: AMsMyM4HF8gN3n3GqZnlJ9ZLvjaQwuV1aOqj7FbIz3ADMeJBR/1NPaOMhUVqg8NDy9zyy2uLWVJJYw==
X-Received: by 2002:a17:903:32c1:b0:185:5398:8c66 with SMTP id i1-20020a17090332c100b0018553988c66mr15241533plr.135.1666286807796;
        Thu, 20 Oct 2022 10:26:47 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:47 -0700 (PDT)
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
Subject: [PATCH 1/8] perf test: Do not use instructions:u explicitly
Date:   Thu, 20 Oct 2022 10:26:36 -0700
Message-Id: <20221020172643.3458767-2-namhyung@kernel.org>
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

I think it's to support non-root user tests.  But perf record can handle
the case and fall back to a software event (cpu-clock).  Practically this
would affect when it's run on a VM, but it seems no reason to prevent running
the test in the guest.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 301f95427159..747c33a1ec45 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -21,18 +21,18 @@ trap trap_cleanup exit term int
 
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
+  if ! perf record -o /dev/null --quiet true 2> /dev/null
   then
-    echo "Per-thread record [Skipped instructions:u not supported]"
+    echo "Per-thread record [Skipped event not supported]"
     if [ $err -ne 1 ]
     then
       err=2
     fi
     return
   fi
-  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
+  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
   then
-    echo "Per-thread record of instructions:u [Failed]"
+    echo "Per-thread record [Failed record]"
     err=1
     return
   fi
@@ -49,7 +49,7 @@ test_register_capture() {
   echo "Register capture test"
   if ! perf list | egrep -q 'br_inst_retired.near_call'
   then
-    echo "Register capture test [Skipped missing instruction]"
+    echo "Register capture test [Skipped missing event]"
     if [ $err -ne 1 ]
     then
       err=2
-- 
2.38.0.135.g90850a2211-goog

