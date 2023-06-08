Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCDB727D60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjFHLAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjFHK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:59:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A018BE57;
        Thu,  8 Jun 2023 03:59:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89150AB6;
        Thu,  8 Jun 2023 04:00:35 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DFB03F71E;
        Thu,  8 Jun 2023 03:59:47 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] perf cs-etm: Track exception level
Date:   Thu,  8 Jun 2023 11:59:24 +0100
Message-Id: <20230608105930.1389276-1-james.clark@arm.com>
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

Changes since v1:

  * Always assume host kernel when the trace was captured at EL1 (nVHE)
  * Fix EL validation to work with ETMv3
  * Add a commit to make PID format accessible from struct
    cs_etm_auxtrace

======

Some fixes to support an issue reported by Denis Nikitin where decoding
trace that contains different EL1 and EL2 kernels can crash or go into
an infinite loop because the wrong kernel maps are used for the decode.

This still doesn't support distinguishing guest and host userspace,
we'd still have to fix the timestamps and do a bit more work to
correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
possible outcome of cs_etm__cpu_mode(). As far as I know this could
never have been returned anyway because machine__is_host(machine) was
always true due to session.machines.host being hard coded. And I'm not
sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
and PERF_RECORD_MISC_HYPERVISOR in this scenario.

The first commit is a tidy up, second fixes a bug that I found when
comparing the exception level and thread of branch records, the third
is the main fix, and the last commit is some extra error checking. 

Applies to acme/perf-tools (48b1320a67)

James Clark (5):
  perf cs-etm: Only track threads instead of PID and TIDs
  perf cs-etm: Use previous thread for branch sample source IP
  perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
  perf cs-etm: Track exception level
  perf cs-etm: Add exception level consistency check

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  33 +--
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   4 +-
 tools/perf/util/cs-etm.c                      | 273 ++++++++++--------
 tools/perf/util/cs-etm.h                      |  13 +-
 4 files changed, 175 insertions(+), 148 deletions(-)

-- 
2.34.1

