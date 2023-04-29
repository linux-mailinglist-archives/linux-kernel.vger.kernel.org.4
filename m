Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115436F2336
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbjD2Flg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347398AbjD2Fl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:41:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46144C10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a776a5eb2so1227726276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746796; x=1685338796;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2HSmx6kEz7AF/sikU4sT7+5OfRWtA69N2zyZbBkbM=;
        b=Be74dFkeae+6OHSEu/03XKrBVxNymfcbSYVyb/ZX2hSWfFcIJgwBDrpgO8cfOCw7Yp
         PJazyE006HUDoCTOUkOUgs7bhFI+Yl8tFfEBPYT3VG5wfFgH+lymAEWwboqfszWdrlev
         I7PV0mvHD/prllgC5Pkg3TTFFuk8ee9ftAkMrmJds//Lu6qio0XrpaImKWd71wKG5RBE
         FvDJwnLRo/qfz3DnxE18Ir2ts/W6eDPL1EVxtUecyZl6KN0Fae+W8bVTs6nr8jciuHKM
         mQmHfypx17SxfmMnnH7q2LbtEgZtUzUO8V+hrdvRT26fD/JSg90+aBlYDR9ixqdo7Iye
         5/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746796; x=1685338796;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2HSmx6kEz7AF/sikU4sT7+5OfRWtA69N2zyZbBkbM=;
        b=FDN1gvtl3eNk+D2yKUmWPqSk+cFc1IQPunwBSspdxIxDFGJZxnu0tPmc4ehQ89jqx9
         xh029KmhFU2mbBj+bwNJpT8fcsbL24cI/MGb07GqIkSJhSlqKSiO/+pDWe8wVwMDzUfc
         LSbJdp2WPSrZ4HfxSslvSvEq54ipdyJgLwGF9e+TbSUOB5so5ArD8byw7dLVyMSVVd32
         2tudlAUvo3NHze/9Uwqj2NPJY8zBBsV5uLWOjnI0t5Fpp+vhEqDPOyWxYWDWahSFfsVi
         ntBqpIUaniDsLaYAFV2xDzYI5NH7xoo9qRBp+NO1daM5y2Ex433Lp4ofUm/en7121qOt
         I/Yw==
X-Gm-Message-State: AC+VfDxUhcWJNcC31yr5n3QxDDAv/6d7GYrHPLGbf3NyO+flbY1sOzVO
        SPSYl+iX/TCs+omZreHxt4Of1zfGTK79
X-Google-Smtp-Source: ACHHUZ4Qbw0OscBCzDg+Rk7VlgVWh8m1azLqoOPmHD51gFcezB7KW6l4onfnh5/8nCjmtydjCEfavgBGD8o6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a25:40c3:0:b0:b9d:8e86:9672 with SMTP id
 n186-20020a2540c3000000b00b9d8e869672mr469870yba.10.1682746795989; Fri, 28
 Apr 2023 22:39:55 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:53 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-34-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 33/46] perf test: Add cputype testing to perf stat
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

