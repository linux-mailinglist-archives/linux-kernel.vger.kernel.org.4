Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6997774D79D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGJNbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGJNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:31:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06B72F3;
        Mon, 10 Jul 2023 06:31:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97FF2B;
        Mon, 10 Jul 2023 06:31:57 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.30.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC4C43F67D;
        Mon, 10 Jul 2023 06:31:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, john.g.garry@oracle.com
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH 1/4] perf: cs-etm: Don't duplicate FIELD_GET()
Date:   Mon, 10 Jul 2023 14:30:52 +0100
Message-Id: <20230710133058.1483610-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/bitfield.h can be included as long as linux/kernel.h is included
first, so change the order of the includes and drop the duplicate macro.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1419b40dfbe8..9729d006550d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -6,10 +6,11 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/coresight-pmu.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
@@ -281,17 +282,6 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 	return 0;
 }
 
-/*
- * FIELD_GET (linux/bitfield.h) not available outside kernel code,
- * and the header contains too many dependencies to just copy over,
- * so roll our own based on the original
- */
-#define __bf_shf(x) (__builtin_ffsll(x) - 1)
-#define FIELD_GET(_mask, _reg)						\
-	({								\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
-	})
-
 /*
  * Get a metadata for a specific cpu from an array.
  *
-- 
2.34.1

