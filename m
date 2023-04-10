Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EB36DC93E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDJQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjDJQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:25:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6061FFB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:25:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c01480e3cso136203227b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681143928;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RcVP8+wNKMP0CI3wP35gWRmxMX+BaZG32dn9a3gYrZQ=;
        b=Zvv8HjASFhPiBTye49dPmiMVH9Hvm0QhNMMQeabfTq+HE9ide4xtEfCXnRphOqS/rY
         FKid5gir6jJMpaJh2LTaIPZoY9buf8vUako7KpKqH8cVXQC1f+qFakA5r6UCnJZvPOQP
         NU/MjKkiLGxuGgM7pCe0c87Zo74/v0OFIFiBvlAFpu5GFsGd6hieEOnEVjmv+kPiim7U
         w1D9RoShQYxHQWxWpgD3HEN67JLaiSOKkMmYWE/ZiGj2gjm6DO7GOjdoSywkI+yQ80xO
         81rPJOGfcmcwcojWDNBieoGQJzSR3MbWDt46rQ7BCk/HrJN/Ehy4AfhPBmWaDzcJxaSi
         YF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143928;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcVP8+wNKMP0CI3wP35gWRmxMX+BaZG32dn9a3gYrZQ=;
        b=inD/W7r48NB6EcVSxOyxJd+uXgMmzql7l2bE3luArAaFrtSerzqcDMQUZsScbi6tob
         dsQoebCcxZ7Q9u1eBENlpQtvfjX6RjeU484NmgIysi+0baJoVXCPQrbEyIWeaf2kuDLh
         tOCUZIjphP9vleaMQsEMIUMlwzJZzg+TG7m32YY58WKMrF771Kpd4xJaFl/XMDfpysXH
         iML3xP1Ar1uBVFMEg9py8NDQpg3aO3Ah7UOrXmU9grg6C5rn+vBl7MtXBAOW3OpRwxZQ
         3yuZZ/mXpaYQUVQB8M22kQG2zBp1t2u3tQS6Yprr/z8IUtGxfT8pGlDaEhaf6mUj4MCr
         ZQ1Q==
X-Gm-Message-State: AAQBX9dEX06ggzQJjarnpI0pRCA7ozVpDCLq1fWpldfhmg/RHY5EusD6
        Z58n8n6eHQDY0GC+HS1e0lgviPIDrH+n
X-Google-Smtp-Source: AKy350YrUffc5HNnBrjR/AifueLJVxPtOYiAldS44HM/yoFhiQXR9vaiO5q0DqFU+ja4kUqZ+Ew19sEYD6rJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a25:cfcf:0:b0:b2f:bdc9:2cdc with SMTP id
 f198-20020a25cfcf000000b00b2fbdc92cdcmr7286529ybg.7.1681143928302; Mon, 10
 Apr 2023 09:25:28 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:25:05 -0700
Message-Id: <20230410162511.3055900-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 0/6] Refactor definitions out of perf.h
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

Move definitions and declarations for greater consistency.

The original motivation was, when fuzzing something like parse-events,
having the main function in perf.c alongside global variables like
input_name means that input_name must be redeclared with the fuzzer
function's main. However, as the fuzzer is using the tools/perf code
as a library this causes backward linking reference that the linker
may warn about.

v2. Remove references from commit messages about linking, as Adrian
    points out we could solve that problem with #ifdefs.

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
2.40.0.577.gac1e443424-goog

