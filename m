Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695586ECF84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDXNsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjDXNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 123F17AA4;
        Mon, 24 Apr 2023 06:48:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA890D75;
        Mon, 24 Apr 2023 06:48:43 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 943673F64C;
        Mon, 24 Apr 2023 06:47:56 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com
Cc:     denik@google.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] perf: cs-etm: Fixes around timestamped and timeless decoding
Date:   Mon, 24 Apr 2023 14:47:40 +0100
Message-Id: <20230424134748.228137-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first commit contains a fix for a recently introduced regression,
but was always a shortcoming in the Coresight code anyway.

The following commits are a tidyup in preparation for the last commit,
which is a fairly major change to the decode logic that's also
indirectly related to the regression so I thought it would be good time
to fix that now.

Applies to perf/core (9be6ab181b7b)

James Clark (7):
  perf: cs-etm: Fix timeless decode mode detection
  perf tools: Add util function for overriding user set config values
  perf: cs-etm: Don't test full_auxtrace because it's always set
  perf: cs-etm: Validate options after applying them
  perf: cs-etm: Allow user to override timestamp and contextid settings
  perf: cs-etm: Use bool type for boolean values
  perf: cs-etm: Add separate decode paths for timeless and per-thread
    modes

 tools/perf/arch/arm/util/cs-etm.c             | 223 +++++++++---------
 tools/perf/arch/arm/util/pmu.c                |   2 +
 tools/perf/arch/arm64/util/arm-spe.c          |  26 +-
 tools/perf/arch/x86/util/intel-pt.c           |  22 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |  24 ++
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   8 +-
 tools/perf/util/cs-etm.c                      | 200 +++++++++++-----
 tools/perf/util/cs-etm.h                      |   6 +-
 tools/perf/util/evsel.c                       |  29 +++
 tools/perf/util/evsel.h                       |   3 +
 10 files changed, 325 insertions(+), 218 deletions(-)

-- 
2.34.1

