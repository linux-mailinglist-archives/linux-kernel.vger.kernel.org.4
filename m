Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5564A479
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLLPzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiLLPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:55:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7476364FA;
        Mon, 12 Dec 2022 07:55:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B75FF15BF;
        Mon, 12 Dec 2022 07:56:26 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B20343F71E;
        Mon, 12 Dec 2022 07:55:43 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Al.Grant@arm.com, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH 2/5] perf: cs-etm: Remove unused stub methods
Date:   Mon, 12 Dec 2022 15:55:10 +0000
Message-Id: <20221212155513.2259623-3-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212155513.2259623-1-james.clark@arm.com>
References: <20221212155513.2259623-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't used outside of cs-etm so don't need stubs. Leave
cs_etm__process_auxtrace_info() which is used externally, and add an
error message so that it's obvious to users why it causes errors.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.h | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 90c83f932d9a..401f74be98d6 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -7,6 +7,7 @@
 #ifndef INCLUDE__UTIL_PERF_CS_ETM_H__
 #define INCLUDE__UTIL_PERF_CS_ETM_H__
 
+#include "debug.h"
 #include "util/event.h"
 #include <linux/bits.h>
 
@@ -218,40 +219,9 @@ static inline int
 cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
 			      struct perf_session *session __maybe_unused)
 {
+	pr_err("\nCS ETM Trace: OpenCSD is not linked in, please recompile with CORESIGHT=1\n");
 	return -1;
 }
-
-static inline int cs_etm__get_cpu(u8 trace_chan_id __maybe_unused,
-				  int *cpu __maybe_unused)
-{
-	return -1;
-}
-
-static inline int cs_etm__etmq_set_tid(
-				struct cs_etm_queue *etmq __maybe_unused,
-				pid_t tid __maybe_unused,
-				u8 trace_chan_id __maybe_unused)
-{
-	return -1;
-}
-
-static inline bool cs_etm__etmq_is_timeless(
-				struct cs_etm_queue *etmq __maybe_unused)
-{
-	/* What else to return? */
-	return true;
-}
-
-static inline void cs_etm__etmq_set_traceid_queue_timestamp(
-				struct cs_etm_queue *etmq __maybe_unused,
-				u8 trace_chan_id __maybe_unused) {}
-
-static inline struct cs_etm_packet_queue *cs_etm__etmq_get_packet_queue(
-				struct cs_etm_queue *etmq __maybe_unused,
-				u8 trace_chan_id __maybe_unused)
-{
-	return NULL;
-}
 #endif
 
 #endif
-- 
2.25.1

