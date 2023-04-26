Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C086EEEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbjDZHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbjDZHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:06:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2149DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b96ee51ee20so7375513276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492696; x=1685084696;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2HSmx6kEz7AF/sikU4sT7+5OfRWtA69N2zyZbBkbM=;
        b=V1kfrshmykyBp8yMvqUrIcFCsLJN7oX2qRAw/M9JFjIhK7wu20XfksXvAdE+VvKrx6
         LZ/YkK0XAw86N7XPrpWITnpiAKwmVOhILAk2awui/pJZnWiHPN8TdhC8qbY07XK1t1cY
         DvRbN2h9wK3x26IHAiyjE9Ad2qjJGkBVWuGFFdBGEW35zbaFocxZVLw9ckE5I0h6qgub
         08dpRAxkDl4+5B750jbONX2nAT0O5+j8zQbITF+DzEqpNqC5cXts9sH7XD4T0yvT3YV4
         W/hINe5iywkAi+y/BQ9FqlvR4kAPirzwHItTIiKwzFhJj3JlulMKA00F/ShcEcawlmcG
         apQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492696; x=1685084696;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2HSmx6kEz7AF/sikU4sT7+5OfRWtA69N2zyZbBkbM=;
        b=IirdxjsfttKPeIMXy5YTlEG3bPdc0jWtxTwUhNek00OQJj1Mb0DSgXEZGHSg5V993S
         V0CaIODqEC0L5eSFzSyCbmSdBeHwqMauoGH3O8LD+VpjmV9kR/IXleDHP3XetyEzDPE8
         ztuhbbQKUz1BPfkQiCef5esA2YtUJMEHjSoavq341+dBcHUhe64QIwbq7WOqcq34s3/D
         1xGs0cmv6LPoeiA8eZLkgiRAVqKfcg9WeN8qGRvL2IlJtBJV/AtSQvMrzLnK+Pur6Ahi
         T3ymPpjESav1MMYREIXudhIbai0YdqlvwSaagihE7C8gRv3d2BfE/y1SkhEMB2cs9/iF
         SUcw==
X-Gm-Message-State: AAQBX9ctT75fG+xGo75he3aZsMLjeLJvtFn34aMfsHbLiRkwPogGhCML
        Ay0Ax/2/qiBZ7dJZsyKhUR8aoZ20H/i4
X-Google-Smtp-Source: AKy350bKP7hwWX71EwDiVvvd0qzG+7OeriGaM8zlPjac5a5xaarE3dOb0bJfkVwjlW+bb4k/7xxwnPtWM3+e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a05:690c:70c:b0:54e:8b9a:65be with SMTP id
 bs12-20020a05690c070c00b0054e8b9a65bemr9617364ywb.6.1682492696589; Wed, 26
 Apr 2023 00:04:56 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:38 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-29-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 28/40] perf test: Add cputype testing to perf stat
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check a bogus PMU fails and that a known PMU succeeds. Limit to PMUs
known cpu, cpu_atom and armv8_pmuv3_0 ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 2c1d3f704995..fe1283ca39d1 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -91,9 +91,53 @@ test_topdown_weak_groups() {
   echo "Topdown weak groups test [Success]"
 }
 
+test_cputype() {
+  # Test --cputype argument.
+  echo "cputype test"
+
+  # Bogus PMU should fail.
+  if perf stat --cputype="123" -e instructions true > /dev/null 2>&1
+  then
+    echo "cputype test [Bogus PMU didn't fail]"
+    err=1
+    return
+  fi
+
+  # Find a known PMU for cputype.
+  pmu=""
+  for i in cpu cpu_atom armv8_pmuv3_0
+  do
+    if test -d "/sys/devices/$i"
+    then
+      pmu="$i"
+      break
+    fi
+    if perf stat -e "$i/instructions/" true > /dev/null 2>&1
+    then
+      pmu="$i"
+      break
+    fi
+  done
+  if test "x$pmu" = "x"
+  then
+    echo "cputype test [Skipped known PMU not found]"
+    return
+  fi
+
+  # Test running with cputype produces output.
+  if ! perf stat --cputype="$pmu" -e instructions true 2>&1 | grep -E -q "instructions"
+  then
+    echo "cputype test [Failed count missed with given filter]"
+    err=1
+    return
+  fi
+  echo "cputype test [Success]"
+}
+
 test_default_stat
 test_stat_record_report
 test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
+test_cputype
 exit $err
-- 
2.40.1.495.gc816e09b53d-goog

