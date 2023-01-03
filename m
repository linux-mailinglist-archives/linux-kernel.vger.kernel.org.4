Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED165C3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjACQWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjACQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:21:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18F1C12D2B;
        Tue,  3 Jan 2023 08:21:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EC1D1516;
        Tue,  3 Jan 2023 08:22:01 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC4F43F71A;
        Tue,  3 Jan 2023 08:21:16 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel timestamps
Date:   Tue,  3 Jan 2023 16:20:34 +0000
Message-Id: <20230103162042.423694-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

  * Remove const to non-const change and copy strings where needed
    instead.
  * Use sizeof() instead of PATH_MAX
  * Append "will not be set accurately." to new error message
  * Remove unneeded stat() call
  * Rebase on perf/core
  
==========================

Changes since v1:

  * Add 3 refactor commits for sysfs reading around pmu.c as suggested
    by Arnaldo here [1]
  * The dependency on [2] has now reached mainline so is no longer
    blocking
  * Rebase on perf/core
  
[1]: https://lore.kernel.org/all/YnqVqq5QW%2Fb14oPZ@kernel.org/
[2]: https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@arm.com/

German Gomez (4):
  perf pmu: Add function to check if a pmu file exists
  perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
  perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
  perf cs_etm: Set the time field in the synthetic samples

James Clark (3):
  perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
  perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
  perf: Remove remaining duplication of bus/event_source/devices/...

 tools/perf/arch/arm/util/auxtrace.c |   5 +-
 tools/perf/arch/arm/util/cs-etm.c   |  91 ++++++++++++--
 tools/perf/arch/x86/util/pmu.c      |  12 +-
 tools/perf/util/cputopo.c           |   9 +-
 tools/perf/util/cs-etm-base.c       |  34 ++++--
 tools/perf/util/cs-etm.c            |  86 ++++++++++++--
 tools/perf/util/cs-etm.h            |  13 +-
 tools/perf/util/pmu-hybrid.c        |  27 +----
 tools/perf/util/pmu.c               | 177 +++++++++++-----------------
 tools/perf/util/pmu.h               |  10 +-
 10 files changed, 284 insertions(+), 180 deletions(-)


base-commit: 09e6f9f98370be9a9f8978139e0eb1be87d1125f
-- 
2.25.1

