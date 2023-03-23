Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10276C70F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCWTVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCWTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2210AA3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso23475582ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599240;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3Ygo29HYRm3r7ZSnu2K3ZnOjsSgQ+xD3MacSkCFgS8=;
        b=iUAc5tfex5LyNmXTVNc19Y6VwkI/2zG9eofeKpxBN8iEnKFaM8vqW0NZxUIDZ0tHoj
         LLOmK2wjtTYJPHjaPWMCF4GG8JTYPDgXvWX26l4EpWSpgs0QUzkkM2qJJbzvHswgeZrl
         iwwdZDNDf5ZHmsNrZ8nIwdrII6LE6LM84jV65trxNPs/s0stFz+ckmwUf7WY0n850V5k
         Vf5ho+bv6kxf3yAupz/smWefIZSeiERMOrI32Qy6ZcF7gvL/de4iSOugo6shXZLLN28n
         n6aYYqmdB2K5fyHbRuFMkk+O0raJp8x1VDirkFjgz2kAlnlQxXgUmD+hR+ZhSG5lYMtS
         5eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599240;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3Ygo29HYRm3r7ZSnu2K3ZnOjsSgQ+xD3MacSkCFgS8=;
        b=w3CpPV3qKe0g79sqQuqshtBE5rvszm5Bsy4kka176HFEGgu4FsgJz+h1bo3LAkIAca
         rN7k78eDHOPU6aQJBRfP6bE34SBPnAY/XbKnrEc8RCalnP0VqgxhQDlnsH9T9+o1lYEm
         txl5b89lU7WvSL01paMGSNchs+zBxnXC4S7jhgiT+jU09gPFqJef6MQqXhEKV+TT33Zi
         a3o7xpONjSbY4M251wzDmafCsCvcne/TvSw4I3CbKo9fo0E61ryoA5Iak+vX+KrogDBs
         aLxScM0Gdvl+P1Q/oJK2B1Khf7VgNA13gzJurIx35ZNr7qCsVdqgUxoWF873BPQAxQH+
         77hA==
X-Gm-Message-State: AAQBX9dtTA7bHJgkx1dUyIp9kPKCtj3A7H0XiYmvKYHaMG9PHFs3Cu+j
        I/o+U9eVBCd1ZlWda4ECsST2QZk2of+C
X-Google-Smtp-Source: AKy350bQ1eTuQEXiZXBU3mqF5sZzIUe6iOnP0mTgtKF+ZocPhgkpYLBQ4rOziJ51eEKUXPKkoJot9mx6Sw+r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a25:c750:0:b0:b45:e545:7c50 with SMTP id
 w77-20020a25c750000000b00b45e5457c50mr2453134ybe.0.1679599240436; Thu, 23 Mar
 2023 12:20:40 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:19 -0700
Message-Id: <20230323192028.135759-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 0/9] Update Intel events and make optane events dynamic
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

Add new #has_optane literal to allow optane metrics to be dynamic in
how optane events are enabled. Update CLX, ICX and SPR for this using
this PR:
https://github.com/intel/perfmon/pull/63

Ian Rogers (9):
  perf vendor events: Broadwell v27 events
  perf vendor events: Broadwellde v9 events
  perf vendor events: Broadwellx v20 events
  perf vendor events: Haswell v33 events
  perf vendor events: Haswellx v27 events
  perf vendor events: Jaketown v23 events
  perf vendor events: Sandybridge v19 events
  perf metrics: Add has_optane literal
  perf vendor events: Update metrics to detect optane memory at runtime

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

