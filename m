Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C76066FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJTR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJTR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:27:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBDB1BC169;
        Thu, 20 Oct 2022 10:26:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so4183428pji.1;
        Thu, 20 Oct 2022 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76OWpPG6taxwukfGOQIVyyPduKaLqtTpv/FwNGCoWTE=;
        b=Z6KCfwmiq9NtR6cwQNiCy/gQEIkNFbsC+MCSiH37yTkxXMGoqFN/ePPmZ48zdSmu0u
         HTxCPD3vtu71oueq4lkzFCHYjyTSb+9VX468KWxtkQMfRaeiKJMI8ORNBHNYtX+A/gpP
         dqMRomWBp0wu4v5Xos4rA7B+D2g5/OFdqNlWiPvYVeCHQFAly6j14dGpY9HiL2fMmdzu
         OA8Ui70Q861xHEXcSV493t9E2NiGY4GTb/G0DFqpq8ToSD5IBj6IUWKFZkcE21NbvZnJ
         dolOi1OhsS7MIcjqv9+reld3g2SwX2GKJmfwAOI0FXLrbIAYYztHihyDjjDVoLZ+QUWt
         k/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76OWpPG6taxwukfGOQIVyyPduKaLqtTpv/FwNGCoWTE=;
        b=6jRSezQRG753iOHsNiu92mv3FKvmjIzM4rhg1JjrSg+VUyTEH0f5+cYigxdeMtHlBu
         zIEoFag3Fu+81Cybw0yfQkHNjFXSKkYm2JGamxxCRYsbiMZKFW2NOqA/A1YkA1rW01IE
         aYcGTzG1QdCLhHsn27PGH7i8IjceOO4RSTAoVLK3M7wm/yp3cN3N8brJNnahMng7dMtp
         AwC5JQZvtCDgoWIYyKqNpKgJFQ22imIVX4wqXzyWtXcQNnQCwFyxgYWCGA2lxeLEVRVt
         2Ubwl8qylgp1O9M/q/egbOmlJxDhr59nVkRLhjRJHoPvqnReKrPcFKFjI6SCnAHY11nA
         Xjnw==
X-Gm-Message-State: ACrzQf2hNMaGZpxqNQzmiO94Y6SZEVKjiapY+GZ9Cr8iMbVYclfxYTgr
        b6Dd+lG7T4IVSRcNQusVhUo=
X-Google-Smtp-Source: AMsMyM7Tz+aW8dzQRisKt/13ax596tk5X6ULh2Gx7AhvMxaKGsrzYLuV4HYZ9fP+USgLMBtNZj5DHg==
X-Received: by 2002:a17:90b:33cc:b0:20a:7f32:9632 with SMTP id lk12-20020a17090b33cc00b0020a7f329632mr17637703pjb.149.1666286814349;
        Thu, 20 Oct 2022 10:26:54 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:54 -0700 (PDT)
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
Subject: [PATCH 7/8] perf test: Test record with --threads option
Date:   Thu, 20 Oct 2022 10:26:42 -0700
Message-Id: <20221020172643.3458767-8-namhyung@kernel.org>
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

The --threads option changed the perf record behavior significantly, so
it'd be nice if we test it separately.  Add --threads options with
different argument in each test supported and check the result.

Also update the cleanup routine because threads recording produces data
in a directory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index c59d1459c960..01aa9531b369 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -13,8 +13,8 @@ testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
 testsym="test_loop"
 
 cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${perfdata}".old
+  rm -rf "${perfdata}"
+  rm -rf "${perfdata}".old
 
   if [ "${testprog}" != "true" ]; then
     rm -f "${testprog}"
@@ -171,6 +171,19 @@ test_system_wide() {
     err=1
     return
   fi
+  if ! perf record -aB --synth=no -e cpu-clock,cs --threads=cpu \
+    -o "${perfdata}" ${testprog} 2> /dev/null
+  then
+    echo "System-wide record [Failed record --threads option]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "System-wide record [Failed --threads missing output]"
+    err=1
+    return
+  fi
   echo "Basic --system-wide mode test [Success]"
 }
 
@@ -188,6 +201,19 @@ test_workload() {
     err=1
     return
   fi
+  if ! perf record -e cpu-clock,cs --threads=package \
+    -o "${perfdata}" ${testprog} 2> /dev/null
+  then
+    echo "Workload record [Failed record --threads option]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Workload record [Failed --threads missing output]"
+    err=1
+    return
+  fi
   echo "Basic target workload test [Success]"
 }
 
-- 
2.38.0.135.g90850a2211-goog

