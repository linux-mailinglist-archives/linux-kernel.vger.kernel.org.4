Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A809679616
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjAXLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjAXLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:04:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6AFB2E0CC;
        Tue, 24 Jan 2023 03:03:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CF41FB;
        Tue, 24 Jan 2023 03:04:40 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14DA53F64C;
        Tue, 24 Jan 2023 03:03:55 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] perf: cs-etm: Improve missing sink warning message
Date:   Tue, 24 Jan 2023 11:02:20 +0000
Message-Id: <20230124110220.460551-1-james.clark@arm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the sink error message more similar to the event error message that
reminds about missing kernel support. The available sinks are also
determined by the hardware so mention that too.

Also, usually it's not necessary to specify the sink, so add that as a
hint.

Now the error for a made up sink looks like this:

  $ perf record -e cs_etm/@abc/
  Couldn't find sink "abc" on event cs_etm/@abc/.
  Missing kernel or device support?

  Hint: An appropriate sink will be picked automatically if one isn't is specified.

For any error other than ENOENT, the same message as before is
displayed.

Signed-off-by: James Clark <james.clark@arm.com>
---
V1 -> V2: Keep old error message unless it's ENOENT

 tools/perf/arch/arm/util/cs-etm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 481e170cd3f1..7f71c8a237ff 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -283,9 +283,15 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 
 		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
 		if (ret != 1) {
-			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
-			       sink, evsel__name(evsel), errno,
-			       str_error_r(errno, msg, sizeof(msg)));
+			if (errno == ENOENT)
+				pr_err("Couldn't find sink \"%s\" on event %s\n"
+				       "Missing kernel or device support?\n\n"
+				       "Hint: An appropriate sink will be picked automatically if one isn't specified.\n",
+				       sink, evsel__name(evsel));
+			else
+				pr_err("Failed to set sink \"%s\" on event %s with %d (%s)\n",
+				       sink, evsel__name(evsel), errno,
+				       str_error_r(errno, msg, sizeof(msg)));
 			return ret;
 		}
 

base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
-- 
2.39.1

