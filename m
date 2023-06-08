Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A938728BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjFHXYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjFHXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:24:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0830D6;
        Thu,  8 Jun 2023 16:24:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6549df4321aso1164375b3a.2;
        Thu, 08 Jun 2023 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686266645; x=1688858645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7Oi+GH5jDhIbsSZz3UzpQ6ZcXdqQl0c/NxuRLG3Zcw=;
        b=irxIeUO7Sd4FnxQuFjTG37xSzBx7D8IgOOOQsFiJAHBjXP1HO6u+yDSa51dmefB0+k
         XHcS4pexrVO6+m9HkQPk6Q6fRwQ8kSSWD/LGDdCnkN1K0sxp64aWX23tz3WzLoc3LNnH
         NYyKTcf7zoq6w3/+GA0X5AILWB+41KJL3KL0DX2TdXZb29opIdkUsyOiiJAiCQBxN4lv
         oUrqpXW7/DWbdjbhNXGAceVfdUIedUuuuljZUmM5l4YW+ksmT/E36a6TKY/pO0R6pvVk
         khgr9RR4C+RZaLtoscCG1y/R99ot2xLPnMjPzZgO9KSdzNLPEu21nTIsFswLwgEwKlUE
         rHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266645; x=1688858645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7Oi+GH5jDhIbsSZz3UzpQ6ZcXdqQl0c/NxuRLG3Zcw=;
        b=ETblhsc5OJncjrbK8GZPDC7NHxbDQfif3u6Og583CHxINjCCMCgtlrU4Xso8kynFoC
         BOVqLdaTn4PPDsU8dfdqqhgbwj2rZps9fuJmlUtuaMsrvFrde2T2VGORsmy+ZdfWLoi5
         VtGxl6nt+9S626r2KnmxfdiBDecuG+dNOqs9PTwp4dMSOdg2xnucZ76Utta1DhDktObb
         pPqqwppPfPNPACGgBSWatNHxcdGrdHghOSkvlvXuBLYj/WG53cpLCAomTF3ueVBbNGmF
         3B3I0mvXpHTGqEjeAOZsFfQXMdt121uabcYMbVM2JJVdP4N37SIirhyf54lxpLor1OV8
         qUWQ==
X-Gm-Message-State: AC+VfDwM+KpbIp9TlVfAZgkGmYLivChVFvZVueB2vHrcTcI7QZ5OJ9pI
        6eHTeVL0jOLDAPlQg/1KdIU=
X-Google-Smtp-Source: ACHHUZ4LpecJsdJU4HIoQH1QPQw7XoW2hNQCfBMwLah1Rfx1muXidyhttKX7pnYRYmxhDRR0BDqmLA==
X-Received: by 2002:a05:6a20:7d90:b0:10a:cb95:5aa3 with SMTP id v16-20020a056a207d9000b0010acb955aa3mr9639139pzj.7.1686266645318;
        Thu, 08 Jun 2023 16:24:05 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c14c:6e39:cb7d:ad66])
        by smtp.gmail.com with ESMTPSA id e18-20020a656792000000b0053f1d55676fsm1618203pgr.2.2023.06.08.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:24:04 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/3] perf test: Add test of libpfm4 events
Date:   Thu,  8 Jun 2023 16:24:00 -0700
Message-ID: <20230608232400.3056312-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230608232400.3056312-1-namhyung@kernel.org>
References: <20230608232400.3056312-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

  $ ./perf test -v 102
  102: perf all libpfm4 events test                                    :
  --- start ---
  test child forked, pid 3030994
  Testing ix86arch::UNHALTED_CORE_CYCLES
  Testing ix86arch::INSTRUCTION_RETIRED
  Testing ix86arch::UNHALTED_REFERENCE_CYCLES
  Testing ix86arch::LLC_REFERENCES
  Testing ix86arch::LLC_MISSES
  Testing ix86arch::BRANCH_INSTRUCTIONS_RETIRED
  Testing ix86arch::MISPREDICTED_BRANCH_RETIRED
  Testing perf_raw::r0000
  Testing icl::UNHALTED_CORE_CYCLES
  Testing icl::UNHALTED_REFERENCE_CYCLES
  ...
  test child finished with 0
  ---- end ----
  perf all libpfm4 events test: Ok

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat_all_pfm.sh | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_all_pfm.sh

diff --git a/tools/perf/tests/shell/stat_all_pfm.sh b/tools/perf/tests/shell/stat_all_pfm.sh
new file mode 100755
index 000000000000..4d004f777a6e
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_pfm.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+# perf all libpfm4 events test
+# SPDX-License-Identifier: GPL-2.0
+
+if perf version --build-options | grep HAVE_LIBPFM | grep -q OFF
+then
+  echo "Skipping, no libpfm4 support"
+  exit 2
+fi
+
+err=0
+for p in $(perf list --raw-dump pfm)
+do
+  if echo "$p" | grep -q unc_
+  then
+    echo "Skipping uncore event '$p' that may require additional options."
+    continue
+  fi
+  echo "Testing $p"
+  result=$(perf stat --pfm-events "$p" true 2>&1)
+  x=$?
+  if echo "$result" | grep -q "failed to parse event $p : invalid or missing unit mask"
+  then
+    continue
+  fi
+  if test "$x" -ne "0"
+  then
+    echo "Unexpected exit code '$x'"
+    err=1
+  fi
+  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>"
+  then
+    # We failed to see the event and it is supported. Possibly the workload was
+    # too small so retry with something longer.
+    result=$(perf stat --pfm-events "$p" perf bench internals synthesize 2>&1)
+    x=$?
+    if test "$x" -ne "0"
+    then
+      echo "Unexpected exit code '$x'"
+      err=1
+    fi
+    if ! echo "$result" | grep -q "$p"
+    then
+      echo "Event '$p' not printed in:"
+      echo "$result"
+      err=1
+    fi
+  fi
+done
+
+exit "$err"
-- 
2.41.0.162.gfafddb0af9-goog

