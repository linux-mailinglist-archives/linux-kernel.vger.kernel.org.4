Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529436C78B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCXHWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:22:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CD198B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:22:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a5a0b6e3so10678257b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642555;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEYIS2l83zsy/niTXf00xhSaE+cVwhcmbbmGjuA/bhk=;
        b=aXOAVRjHCsIJ292QycPWRl/rqRaYRbmPwekvoYNr09K++UOvxifs1jiEFYz8H1i8pu
         1YyUqFMppMKiYSVFf8TxJqPhuXVbMd/pUSCTrYCc/k1QnQzKZs3rX96G0ZP1JBh3Tblc
         q/e1NuNc4X+dXb7skN5MDcfJUEaKO/335pw77NAsH2bsqbAP4+401zKRm7rc3LIYtnv/
         L/ahnf1MnwwYI4QiHvvviW8Uy6IoXRgCbuZepVwa8gquU/Fhr/SHINFAHmXAXX6DSi7q
         7h407Oxk+J0E6WIYMwqndXYp+Hj760F5KoKGBqoOrdqh2yQ8XAbE0Xzon/YFxLYJYOQG
         GRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642555;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEYIS2l83zsy/niTXf00xhSaE+cVwhcmbbmGjuA/bhk=;
        b=yKd4gb4JFKGFzPepfMfPv0ZvV6bqE3uxV/P2so/NaIGnHNoEhL79K7+HjLHHu5npoO
         IbfP+vyW55DjvDOyKw3o+pkgc5N/wVPz/ERvmtDdaCrda4BCi7/pW5yVbWqvkfhThBFC
         qaNvfajbdm+sN3p1ZWMUeyNcL5/p1NR1tlW1eGKy8A8D45qmFKlNWzhEIs2ATCvnIkvu
         1+oYnmg/Zw/YDYusFhA/e6aykTgZg8t8ErY9MKw/QEYClOEuDmvsGr0r30HZI9E8LYKC
         oTf+I4VoSsl2fmAiOYCVK7vQwZCgdjKLAHXW7RVRZ+qTPtoRsYJGwjGaRZVp6ehaeina
         iz+Q==
X-Gm-Message-State: AAQBX9dpngy30cUMcg7XRZA/s8EwC6L/SpgDIHbI8v/Yc56kCNNHKd5t
        +SRRzQXwyUk4p/bIHimb1UqHX1ZSUre4
X-Google-Smtp-Source: AKy350beRdjWw+bm0JzNfNprJ4XxnE62v3xB7iKZgl5Q1sWju2Wtrp9OcNaYzVWSZbREJgwUOf2oPRL+CtBZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a81:4049:0:b0:541:6aa7:f889 with SMTP id
 m9-20020a814049000000b005416aa7f889mr563321ywn.5.1679642554895; Fri, 24 Mar
 2023 00:22:34 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:09 -0700
Message-Id: <20230324072218.181880-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 0/9] Update Intel events and make nvdimm events dynamic
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
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

Update events from:
https://github.com/intel/perfmon/pull/62

Add new #has_pmem literal to allow memory metrics to be dynamic in how
nvdimm events are enabled. Update CLX, ICX and SPR for this using this
PR:
https://github.com/intel/perfmon/pull/63

v3. Change has_optane to has_pmem as suggested by Kan Liang and Dan Williams.

Ian Rogers (9):
  perf vendor events: Broadwell v27 events
  perf vendor events: Broadwellde v9 events
  perf vendor events: Broadwellx v20 events
  perf vendor events: Haswell v33 events
  perf vendor events: Haswellx v27 events
  perf vendor events: Jaketown v23 events
  perf vendor events: Sandybridge v19 events
  perf metrics: Add has_pmem literal
  perf vendor events: Update metrics to detect pmem at runtime

 .../pmu-events/arch/x86/broadwell/cache.json  | 296 +++++-----
 .../arch/x86/broadwell/floating-point.json    |   7 +
 .../arch/x86/broadwell/frontend.json          |  18 +-
 .../pmu-events/arch/x86/broadwell/memory.json | 248 ++++-----
 .../arch/x86/broadwell/pipeline.json          |  22 +-
 .../arch/x86/broadwell/uncore-other.json      |   2 +-
 .../arch/x86/broadwellde/cache.json           | 105 ++--
 .../arch/x86/broadwellde/floating-point.json  |  45 +-
 .../arch/x86/broadwellde/frontend.json        |  18 +-
 .../arch/x86/broadwellde/memory.json          |  64 ++-
 .../arch/x86/broadwellde/pipeline.json        |  79 +--
 .../arch/x86/broadwellde/uncore-cache.json    |  72 +--
 .../arch/x86/broadwellde/uncore-memory.json   | 256 ++++++++-
 .../arch/x86/broadwellde/uncore-other.json    |  27 +-
 .../arch/x86/broadwellde/uncore-power.json    |  10 +-
 .../pmu-events/arch/x86/broadwellx/cache.json |  16 +-
 .../arch/x86/broadwellx/frontend.json         |  18 +-
 .../arch/x86/broadwellx/pipeline.json         |  20 +-
 .../arch/x86/broadwellx/uncore-cache.json     | 156 ++----
 .../x86/broadwellx/uncore-interconnect.json   |  84 +--
 .../arch/x86/broadwellx/uncore-memory.json    | 522 +++++++++---------
 .../arch/x86/broadwellx/uncore-other.json     |  44 +-
 .../arch/x86/broadwellx/uncore-power.json     |  10 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
 .../pmu-events/arch/x86/haswell/cache.json    |  38 +-
 .../pmu-events/arch/x86/haswell/memory.json   |  38 +-
 .../pmu-events/arch/x86/haswell/pipeline.json |   8 +
 .../pmu-events/arch/x86/haswellx/cache.json   |   2 +-
 .../arch/x86/haswellx/pipeline.json           |   8 +
 .../arch/x86/haswellx/uncore-cache.json       |  16 +-
 .../arch/x86/haswellx/uncore-other.json       |   6 +-
 .../arch/x86/icelakex/icx-metrics.json        |  10 +-
 .../arch/x86/jaketown/pipeline.json           |   8 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  14 +-
 .../arch/x86/sandybridge/pipeline.json        |   8 +
 .../arch/x86/sapphirerapids/spr-metrics.json  |  10 +-
 tools/perf/util/expr.c                        |  19 +
 37 files changed, 1323 insertions(+), 1011 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

