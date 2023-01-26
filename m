Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B324467D9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjAZXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjAZXhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:37:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2182914D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:36:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c8e781bc0aso37706777b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6injwhONnAcvsjLw2H0Tcbd9Xyh1Q4Op8zz5A06SIQ=;
        b=f09RSyrVetVchZ4QvPtUU6E08ocu9SFUegDFEAstX9+V1i49NyWNseSfswL06DiqYZ
         4z+XHvvdlFgZXKP6diE/RuhG7ju0eHcohPjoxQ7HA3BtMEq02rQ9A8VFVGsccwln9lQ0
         XdjRQjWoG2naSS+788wJdCLRQpGjE5TZ7VhOnbuordNc1HYmGhqQEQfzShMVYGIPu3un
         Yt/oWBoUb9YN4HrxyRTYPzDVrFNM5cmYj7WlmxWadjIXtryWScL5TD04yYSIRnvpay6u
         tP/PRb5Bbz/ENJmw8FO3fAq8mb6bNZ48DlM23zzJRhDgts5WflJnsoeCYREA7K9ySLdD
         3FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6injwhONnAcvsjLw2H0Tcbd9Xyh1Q4Op8zz5A06SIQ=;
        b=YaSwd8rLT+NmM2rsO66fhszEiwh2U4bwGQcbR0i922VBFxK9K8+A/LwHe03tVe/Fuf
         RBx/poIaUAaryLJwFWqcsQNf3ppkef/8Rj59KCywnucLYrzdeofnL+v069CldOzqff0W
         y1WRPKee0OzcyOOTyrwg95pnfRbI1Mf/EteWuLScUoUGHpGryRHGpjm53ARlGuDKOMsm
         BIa2pHyC7JFQlsZZkHaCekXTjD2vX80E3Ngp34JvN5hp3i08MKYCvL6UL7Arj56tp4nI
         dTql9Mq0kP6bKA39x6knOwLKF+UfRt0U/Iobeec1dFKkfllyUuhnEg+VM1vvHIZJFvP9
         ECtw==
X-Gm-Message-State: AO0yUKXdWQG8c583eE9kdG/iZgG3umJhPpv/50KqvjpRCWqpSUtT7GFO
        mPBs+c8tdPsB133/VkOTDp/+iJK0ayxf
X-Google-Smtp-Source: AK7set/7oU0hODtcLNoxFKHHWkJc1FB7dyIz8Mcqfd+Seeri4BbkpvznWB5X1iDILXh3Df6AIdMiKDR+/V+K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a81:5204:0:b0:507:86ae:c733 with SMTP id
 g4-20020a815204000000b0050786aec733mr972921ywb.358.1674776218043; Thu, 26 Jan
 2023 15:36:58 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:30 -0800
Message-Id: <20230126233645.200509-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 00/15] jevents/pmu-events improvements
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optimization to jevents using the metric code, rewrite metrics
in terms of each other in order to minimize size and improve
readability. For example, on Power8
other_stall_cpi is rewritten from:
"PM_CMPLU_STALL / PM_RUN_INST_CMPL - PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST_C=
MPL - PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_VSU / PM_RUN_I=
NST_CMPL - PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NTCG_FLUS=
H / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL"
to:
"stall_cpi - bru_cru_stall_cpi - fxu_stall_cpi - vsu_stall_cpi - lsu_stall_=
cpi - ntcg_flush_cpi - no_ntf_stall_cpi"
Which more closely matches the definition on Power9.

A limitation of the substitutions are that they depend on strict
equality and the shape of the tree. This means that for "a + b + c"
then a substitution of "a + b" will succeed while "b + c" will fail
(the LHS for "+ c" is "a + b" not just "b").

Separate out the events and metrics in the pmu-events tables saving
14.8% in the table size while making it that metrics no longer need to
iterate over all events and vice versa. These changes remove evsel's
direct metric support as the pmu_event no longer has a metric to
populate it. This is a minor issue as the code wasn't working
properly, metrics for this are rare and can still be properly ran
using '-M'.

Add an ability to just build certain models into the jevents generated
pmu-metrics.c code. This functionality is appropriate for operating
systems like ChromeOS, that aim to minimize binary size and know all
the target CPU models.

v5. s/list/List/ in a type annotation to fix Python 3.6 as reported by
    John Garry <john.g.garry@oracle.com>. Fix a bug in metric_test.py
    where a bad character was imported. To avoid similar regressions,
    run metric_test.py before generating pmu-events.c.
v4. Better support the implementor/model style --model argument for
    jevents.py. Add #slots test fix. On some patches add reviewed-by
    John Garry <john.g.garry@oracle.com> and Kajol
    Jain<kjain@linux.ibm.com>.
v3. Rebase an incorporate review comments from John Garry
    <john.g.garry@oracle.com>, in particular breaking apart patch 4
    into 3 patches. The no jevents breakage and then later fix is
    avoided in this series too.
v2. Rebase. Modify the code that skips rewriting a metric with the
    same name with itself, to make the name check case insensitive.

Ian Rogers (15):
  perf jevents metric: Correct Function equality
  perf jevents metric: Add ability to rewrite metrics in terms of others
  perf jevents: Rewrite metrics in the same file with each other
  perf pmu-events: Add separate metric from pmu_event
  perf pmu-events: Separate the metrics from events for no jevents
  perf pmu-events: Remove now unused event and metric variables
  perf stat: Remove evsel metric_name/expr
  perf jevents: Combine table prefix and suffix writing
  perf pmu-events: Introduce pmu_metrics_table
  perf jevents: Generate metrics and events as separate tables
  perf jevents: Add model list option
  perf pmu-events: Fix testing with JEVENTS_ARCH=3Dall
  perf jevents: Correct bad character encoding
  tools build: Add test echo-cmd
  perf jevents: Run metric_test.py at compile-time

 tools/build/Makefile.build               |   1 +
 tools/perf/arch/arm64/util/pmu.c         |  11 +-
 tools/perf/arch/powerpc/util/header.c    |   4 +-
 tools/perf/builtin-list.c                |  20 +-
 tools/perf/builtin-stat.c                |   1 -
 tools/perf/pmu-events/Build              |  16 +-
 tools/perf/pmu-events/empty-pmu-events.c | 108 ++++++-
 tools/perf/pmu-events/jevents.py         | 357 +++++++++++++++++++----
 tools/perf/pmu-events/metric.py          |  79 ++++-
 tools/perf/pmu-events/metric_test.py     |  15 +-
 tools/perf/pmu-events/pmu-events.h       |  26 +-
 tools/perf/tests/expand-cgroup.c         |   4 +-
 tools/perf/tests/parse-metric.c          |   4 +-
 tools/perf/tests/pmu-events.c            |  69 ++---
 tools/perf/util/cgroup.c                 |   1 -
 tools/perf/util/evsel.c                  |   2 -
 tools/perf/util/evsel.h                  |   2 -
 tools/perf/util/expr.h                   |   1 +
 tools/perf/util/expr.l                   |   8 +-
 tools/perf/util/metricgroup.c            | 207 +++++++------
 tools/perf/util/metricgroup.h            |   4 +-
 tools/perf/util/parse-events.c           |   2 -
 tools/perf/util/pmu.c                    |  44 +--
 tools/perf/util/pmu.h                    |  10 +-
 tools/perf/util/print-events.c           |  32 +-
 tools/perf/util/print-events.h           |   3 +-
 tools/perf/util/python.c                 |   7 -
 tools/perf/util/stat-shadow.c            | 112 -------
 tools/perf/util/stat.h                   |   1 -
 29 files changed, 681 insertions(+), 470 deletions(-)
 mode change 100644 =3D> 100755 tools/perf/pmu-events/metric_test.py

--=20
2.39.1.456.gfc5497dd1b-goog

