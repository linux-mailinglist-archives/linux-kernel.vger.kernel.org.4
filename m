Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3172473E44E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjFZQLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjFZQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:11:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A235E58;
        Mon, 26 Jun 2023 09:11:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6774A13D5;
        Mon, 26 Jun 2023 09:11:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF9653F663;
        Mon, 26 Jun 2023 09:11:08 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] perf cs-etm: Handle per-thread mode on EL1 host kernel case
Date:   Mon, 26 Jun 2023 17:10:57 +0100
Message-Id: <20230626161059.324046-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626161059.324046-1-james.clark@arm.com>
References: <20230626161059.324046-1-james.clark@arm.com>
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

In per-thread mode there are no context packets so no way to determine
which type of context packets exist. But because it's only possible to
trace host processes in per-thread mode without context packets then
assume host in this case.

This fixes the per-thread test case failures when running on nVHE:

  98: Check Arm CoreSight trace data recording and synthesized samples:
  --- start ---
  ...
  Recording trace with '-e cs_etm/timestamp=0/ --per-thread'
  Looking at perf.data file for dumping branch samples:
  CoreSight basic testing with '-e cs_etm/timestamp=0/ --per-thread': FAIL
  Recording trace with '-e cs_etm/timestamp=1/ --per-thread'
  Looking at perf.data file for dumping branch samples:
  CoreSight basic testing with '-e cs_etm/timestamp=1/ --per-thread': FAIL
  ...

Fixes: 8d3031d39fe8 ("perf cs-etm: Track exception level")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1419b40dfbe8..85821cc5650e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -900,10 +900,17 @@ static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
 
 	/*
 	 * For any virtualisation based on nVHE (e.g. pKVM), or host kernels
-	 * running at EL1 assume everything is the host.
+	 * running at EL1, or no context IDs (per-thread mode) assume everything
+	 * is the host.
 	 */
-	if (pid_fmt == CS_ETM_PIDFMT_CTXTID)
+	switch (pid_fmt) {
+	case CS_ETM_PIDFMT_CTXTID:
+	case CS_ETM_PIDFMT_NONE:
 		return &etmq->etm->session->machines.host;
+	case CS_ETM_PIDFMT_CTXTID2:
+	default:
+		break;
+	}
 
 	/*
 	 * Not perfect, but otherwise assume anything in EL1 is the default
-- 
2.34.1

