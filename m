Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555566CB33D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC1BlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjC1BlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:41:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEC71FEF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so105503487b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967670;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aw1R5c6S7HXa58dwvgrpM64BjFXPZraFszzosCRiAqw=;
        b=c05M4jtyYHK6yLk4RsHmclGkBpHXTJCTSOHQgnFd/jLlrLXJn70Wc/z+eJRyffNCrA
         N3n/GOv9bI55P1E6QOhMYeMU+gDpRE4SIcTr9eakvsMbxc/82Tykd/zCNm8ajSQpaPPF
         E/13JdTBIR5GbPrxb1anVJJ9l331Vt9cRVb659lMyRuL6r2WT520cqszKKq4WHwF/+dj
         7NcbBhmjQ3K7wVQhsAr5z77xSJAmuBXLG9XpMclkLJEsJADLPnZc22uGBbdL2mFbFSvd
         QL5L/TY3riSrbtW7LfJATj2tZPPsJrcGhBb8VX6/LF6hFAvEB7g607c36KgSfgGWkXL/
         t4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967670;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aw1R5c6S7HXa58dwvgrpM64BjFXPZraFszzosCRiAqw=;
        b=7RYyOkAQGTfXN1U4CjSeff/Ggd/NNgUsP3vVk6UXHiwXJglk/f6WTp9E5AbnpbYwkf
         N/J0ioHJ4P+swFUhKE9bRCG9uAgDfio6l8WO0u/zNHjiUXcWi4/0wVb46MCBAQARg2Gr
         sHJvJCPQri9VfL6xaFVrXX27KlozYCnT59chvqCLkiUShcr+U+RJz5aIcupcZl9lXD5o
         7rytcvuDxGnNvKBGMq/v2IbU6bIoeSYl6wOmdJLUFmaeVvVaMrVgaRjAm1+e3V1zXQXN
         uROcNfejgjNoDgE1ugCpMLotbu+THQfIXTkYCY7jNZft6YTJzK6cX4PbEjC12mwg1Z/D
         mOTQ==
X-Gm-Message-State: AAQBX9dIrzOTCjWvC+fIVurzkVykB1HsP765elj9bCsjCiMqPXh2ns1+
        x2Fh9VU3ecjdYoYSHZHJFqmZBPgYfN1k
X-Google-Smtp-Source: AKy350Y0rOMqLtLagX9tq489iwyEP1VygEZbAsrGvCbDh8RQuFmfhf69wdPkH5xAnbrrYsIJRNwXl8RajUcD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr8845196ybt.0.1679967670518; Mon, 27 Mar
 2023 18:41:10 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:52 -0700
Message-Id: <20230328014058.870413-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 0/6] Simplify linking against tools/perf code
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fuzzing something like parse-events, having the main function in
perf.c alongside global variables like input_name means that
input_name must be redeclared with the fuzzer function's
main. However, as the fuzzer is using the tools/perf code as a library
this causes backward linking reference that the linker may warn
about. Reorganize perf.c and perf.h to avoid potential backward
references, or so that the declaration/definition locations are more
consistent.

Ian Rogers (6):
  perf ui: Move window resize signal functions
  perf usage: Move usage strings
  perf header: Move perf_version_string declaration
  perf version: Use regular verbose flag
  perf util: Move input_name to util
  perf util: Move perf_guest/host declarations

 tools/perf/builtin-annotate.c     |  2 +-
 tools/perf/builtin-buildid-list.c |  2 +-
 tools/perf/builtin-c2c.c          |  2 +-
 tools/perf/builtin-data.c         |  2 +-
 tools/perf/builtin-diff.c         |  2 +-
 tools/perf/builtin-evlist.c       |  2 +-
 tools/perf/builtin-help.c         |  1 +
 tools/perf/builtin-kmem.c         |  2 +-
 tools/perf/builtin-kvm.c          |  1 +
 tools/perf/builtin-kwork.c        |  2 +-
 tools/perf/builtin-mem.c          |  2 +-
 tools/perf/builtin-sched.c        |  2 +-
 tools/perf/builtin-stat.c         |  2 +-
 tools/perf/builtin-timechart.c    |  2 +-
 tools/perf/builtin-version.c      |  7 +++----
 tools/perf/builtin.h              |  3 ---
 tools/perf/perf.c                 | 27 +--------------------------
 tools/perf/perf.h                 |  9 ---------
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/ui/hist.c              |  2 +-
 tools/perf/ui/setup.c             | 19 +++++++++++++++++++
 tools/perf/ui/tui/setup.c         |  1 -
 tools/perf/ui/ui.h                |  3 +++
 tools/perf/util/cs-etm.c          |  1 +
 tools/perf/util/event.c           |  2 +-
 tools/perf/util/evlist.c          |  1 +
 tools/perf/util/header.h          |  2 ++
 tools/perf/util/parse-events.c    |  2 +-
 tools/perf/util/session.c         |  2 +-
 tools/perf/util/top.c             |  2 +-
 tools/perf/util/usage.c           |  6 ++++++
 tools/perf/util/util.c            |  2 ++
 tools/perf/util/util.h            |  8 ++++++++
 33 files changed, 66 insertions(+), 61 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

