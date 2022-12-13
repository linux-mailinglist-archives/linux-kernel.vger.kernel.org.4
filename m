Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04364AEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiLMFDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiLMFDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:03:04 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448491FCFC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:01:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-41469b38117so76237327b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UG0XPHbEDDKxeOTCYIOTYXCBEe1g0xLKC1Sq+sGkSsU=;
        b=gt/pvhO+1xky/9L8WrhCWdi3KKUlXxQx+BakJEVbRQlofP1DJgs/pSkgzOJtZ2exKu
         4tL9rsLqJ8Gc7MRG3wx0cJydW8+IuB1StJRfExVobYswB65Xpe5ZNVtcjybHB91fTsPN
         hMIOlaZJHP5Pas8wQ5gpIt3Viv0Jh1vRR2b0UnEpUg6FtTSg5GNJ7yy0O3QX2EUyZynr
         BDZfUilTNj4QnVnVu1Xl48WjJ8vncPVWWgI/Hep5ka4GpGz3B7SwB8rulCFp+6rr7YeW
         U5kEzMJb8sZE5oDAsTT6lUeiusGEp4r8jyZNis62srb6kEHsqFSColt6ME4VZNmfIEIk
         11bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG0XPHbEDDKxeOTCYIOTYXCBEe1g0xLKC1Sq+sGkSsU=;
        b=VS0N3d6DwzhiuJks4ff6svQY5AmKecUx6BtsLA5DFhLWdNrcqsbWYDFuhageOyIYru
         WuzYGq98zOerdNheHgd8TF4GxKwL0LtvY7RWub10GlVFoM7cs1WdfD5NGg+/JCAIyI0b
         DCxe/4m99BMCdzGWk+otHiGp5UQ3kQzO9ilm8LZjfvuR9vRAdnYe05h50+nH4lGdrRuP
         U3ZM4vCOK9hEBFhYnApowK7qKNADmwubtIGPtshAsMN7OtprDOPpQjq7Iq9mJnmXFTgy
         G0EwuBOC44s3GQhIuVd8bdYUORfE7AH3LaZvzYlS19nzIwAbio0Udy5pnKlgZzHGDQx1
         3kqg==
X-Gm-Message-State: ANoB5pkeDwFci2PQTOiaoQAmeGkUuQeVsDLDO8z08u8HJj1pu1ZSNqTS
        vwObwAMtPv+IWgDCh4UUGUnuOrNJ6Ij1
X-Google-Smtp-Source: AA0mqf4JDHfo++rx3WV8N0YUCP0aMwiXCktYgYa+iuQwho6Bu1I+6Iu0Gp6nwT20vKrfhWCdrZYlt0SqbLWR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6b9f:864c:28da:e99b])
 (user=irogers job=sendgmr) by 2002:a25:26c1:0:b0:70b:fabb:88d6 with SMTP id
 m184-20020a2526c1000000b0070bfabb88d6mr6271807ybm.114.1670907682499; Mon, 12
 Dec 2022 21:01:22 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:00:34 -0800
Message-Id: <20221213050043.1199380-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v1 0/9] jevents/pmu-events improvements
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
(the LHS for "+ c" is "a + b").

Separate out the events and metrics in the pmu-events tables saving
14.8% in the table size while making it that metrics no longer need to
iterate over all events and vice versa. These changes remove evsel's
direct metric support as the pmu_event no longer has a metric to
populate it. This is a minor issue as the code wasn't working
properly, metrics for this are rare and can still be properly ran
using '-M'.

Add an ability to just build certain models into the code. This
functionality is appropriate for operating systems like ChromeOS, that
aim to minimize binary size and know all the target CPU models.

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
 tools/perf/pmu-events/metric.py          |  75 ++++-
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
 26 files changed, 663 insertions(+), 462 deletions(-)

--=20
2.39.0.rc1.256.g54fd8350bd-goog

