Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5A6F4D18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEBWp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjEBWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:45:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92BE1FFB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:44:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso9047878276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067375; x=1685659375;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2HSmx6kEz7AF/sikU4sT7+5OfRWtA69N2zyZbBkbM=;
        b=b4ljozXGX0AGJpe8wzIsr+iwUusd1XtgfvWYQSPq+erkm5D4Em6RBqk9GA04hrEJ9R
         mxdIyAN9H2huOAksfR9s+QEEDi4h3Tdz6w9IW4I+3xRng4V4yth2X6C5GLc6JAEi8fQ6
         sMmFi8L99/tGgsPl1uZC+AidH8jKjSQzYfQiTReYzH4d3JgnxAJfVtzCGYO4atXao1lb
         y0kN5/t6Gu+D4JKBIwUd9p+haXRXOf9LAzukTEkRQ7cRjZ8tUy1ZQWmyylcK4JXQ8Bdk
         gZMZtXw00CdRgDfNvk9UzbmjWbK5TpnV3hhZHPdVghdIvpfUTE5gEW89LSyBHFQ9uAzD
         2AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067375; x=1685659375;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2HSmx6kEz7AF/sikU4sT7+5OfRWtA69N2zyZbBkbM=;
        b=Z9nPaFZnQSDAV8t1WuA9u3hNTEZuIa7CApBh2Mw8qxH2jwDsvtJqfSr1xZ1iFIrShd
         VfsqGPfMDAWO+YcVrfMaPOFUfUYEtSl0Y2goDG1ygX1jKb1JeWwvdzwiKi2e38GqhyNr
         rT8Q/5GQo1vPpTi68G8KPRm8z4WZ5BBjjtlXv6dciFEpfdVX2F8/PLAHxZDz/AsSiPA9
         wmxmc7RduFVWxavlVIZWlg7PQWpupU4HFU4DwhJMJdSBncSf+CzGyD7HMB84eOvROPtH
         WmRGtoW3yx+sE80tfuS9RJklwU5z/fD85jUoeS2o3+er6wrhalM/SQtwMUr54dHIR/2j
         0ZvA==
X-Gm-Message-State: AC+VfDyurzwPfdXFRXQByEnhKm1lRO1ilfHUsIETXXanZuuEqsWBTyvi
        TktRkUuyEkaszlRb/RT1fgmME/9U7dCI
X-Google-Smtp-Source: ACHHUZ5M9/CQ9k1r5X88Vqj7nyogkOweBJ6MjlyJszgJ4oyYuvz+nM/zMhTKFX0AUFD22vbQmtQoejLWC6Mu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:b9d:d5dc:5971 with SMTP
 id v1-20020a056902108100b00b9dd5dc5971mr6040545ybu.2.1683067375581; Tue, 02
 May 2023 15:42:55 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:38 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-32-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 31/44] perf test: Add cputype testing to perf stat
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

