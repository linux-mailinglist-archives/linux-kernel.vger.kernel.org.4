Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD206538B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiLUWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiLUWec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:34:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9049DAC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:34:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n197-20020a25d6ce000000b00702558fba96so71967ybg.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIowfcxIlSOnpo+34eejAu9BpaMvt8oO2tnwfcBHK9E=;
        b=LLSlMCImdpJICzXSFwKufVi6MbgWOiagYpMxF5WRXTuuxx0lk/yLS4q8YnUM83y4Aw
         r5NDXNnYpJ6j74WZp71NW8W3DEp4FV5SmjL7sMiALgBNJ25bacbGZHOsGaPaEMBYfj2m
         B5XU3CzCzwCBO3I75UME9AfZGC4bIMUOX8pHTScoEZx6gUH5Ha5GpGcIfQLrEfBn+Unb
         Az1ZpJn1XfV9d/RQa7HHG4SdDe/rvlRENmu7kVCPt3ZqXz08nCk7ITwa9hJ3Unfc7x3G
         LiCZusvXJE9IpIhAohHFo/UFWiahP8fOhMpCXHwHYLkI4ZPtvbsbSMN+PUdGGYePk0/1
         X6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIowfcxIlSOnpo+34eejAu9BpaMvt8oO2tnwfcBHK9E=;
        b=H+L3a1/VcGyNlNg3Ow7eUIFTIcjKg6IYGXDvRxQ3kjrWxezO3ZXrHU1YvGTUQCBV/V
         0mlUfcWU96KKbWdKI+H+FWKTjMgn06E2s5B1KNlHkKWINoYEXcMHICe+/KE7jSX7mxTa
         PsK24YBe6Xvz4WoLzRF3RA/EyJntgdX22KxcLxFQ2vC74/eqyAPUUd1VuHbZNBHKzMk7
         tdCI2bICjw6P2lpmGV8bNIg/A5k9yCYvgJ2isti47pF2IEIOPEyaG4AT5ES/2Uzy5bEE
         7U/cZ19oeYqjjK4U9ESwb575ubXyU2riCoPKyqqbt1RT0tWCnxMhRw8Ds1BqhX6y1WhW
         3jew==
X-Gm-Message-State: AFqh2kr9eGfIlfZ1pd+o1r8a5df5ZYVDJBRbkMQ9pYlfLheZxQ/xI0D7
        ICrUxKz72TPi5OmUgBRrQxfFCWd/G0O4
X-Google-Smtp-Source: AMrXdXt/1i6tEE0aK9MxTxBRxe31r3mW9upfGIUXK/yHidpIcZPyWJDOwuzvHtzQrbtXnFSQB6TM/EocWP7x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:62bd:f120:1fd8:1d21])
 (user=irogers job=sendgmr) by 2002:a05:6902:505:b0:70f:8944:6a8b with SMTP id
 x5-20020a056902050500b0070f89446a8bmr305071ybs.260.1671662070033; Wed, 21 Dec
 2022 14:34:30 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:34:11 -0800
Message-Id: <20221221223420.2157113-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 0/9] jevents/pmu-events improvements
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

v2. Rebase. Modify the code that skips rewriting a metric with the
    same name with itself, to make the name check case insensitive.

Ian Rogers (9):
  perf jevents metric: Correct Function equality
  perf jevents metric: Add ability to rewrite metrics in terms of others
  perf jevents: Rewrite metrics in the same file with each other
  perf pmu-events: Separate metric out of pmu_event
  perf stat: Remove evsel metric_name/expr
  perf jevents: Combine table prefix and suffix writing
  perf pmu-events: Introduce pmu_metrics_table
  perf jevents: Generate metrics and events as separate tables
  perf jevents: Add model list option

 tools/perf/arch/arm64/util/pmu.c         |  23 +-
 tools/perf/arch/powerpc/util/header.c    |   4 +-
 tools/perf/builtin-list.c                |  20 +-
 tools/perf/builtin-stat.c                |   1 -
 tools/perf/pmu-events/Build              |   3 +-
 tools/perf/pmu-events/empty-pmu-events.c | 111 ++++++-
 tools/perf/pmu-events/jevents.py         | 353 ++++++++++++++++++-----
 tools/perf/pmu-events/metric.py          |  79 ++++-
 tools/perf/pmu-events/metric_test.py     |  10 +
 tools/perf/pmu-events/pmu-events.h       |  26 +-
 tools/perf/tests/expand-cgroup.c         |   4 +-
 tools/perf/tests/parse-metric.c          |   4 +-
 tools/perf/tests/pmu-events.c            |  68 ++---
 tools/perf/util/cgroup.c                 |   1 -
 tools/perf/util/evsel.c                  |   2 -
 tools/perf/util/evsel.h                  |   2 -
 tools/perf/util/metricgroup.c            | 203 +++++++------
 tools/perf/util/metricgroup.h            |   4 +-
 tools/perf/util/parse-events.c           |   2 -
 tools/perf/util/pmu.c                    |  44 +--
 tools/perf/util/pmu.h                    |  10 +-
 tools/perf/util/print-events.c           |  32 +-
 tools/perf/util/print-events.h           |   3 +-
 tools/perf/util/python.c                 |   7 -
 tools/perf/util/stat-shadow.c            | 112 -------
 tools/perf/util/stat.h                   |   1 -
 26 files changed, 666 insertions(+), 463 deletions(-)

--=20
2.39.0.314.g84b9a713c41-goog

