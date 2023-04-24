Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23AC6ECF91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjDXNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjDXNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EE4F93E5;
        Mon, 24 Apr 2023 06:48:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016F3D75;
        Mon, 24 Apr 2023 06:49:17 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FD2C3F64C;
        Mon, 24 Apr 2023 06:48:28 -0700 (PDT)
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
Subject: [PATCH 6/7] perf: cs-etm: Use bool type for boolean values
Date:   Mon, 24 Apr 2023 14:47:46 +0100
Message-Id: <20230424134748.228137-7-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424134748.228137-1-james.clark@arm.com>
References: <20230424134748.228137-1-james.clark@arm.com>
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

Using u8 for boolean values makes the code a bit more difficult to read
so be more explicit by using bool.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 8 ++++----
 tools/perf/util/cs-etm.c                        | 8 ++++----
 tools/perf/util/cs-etm.h                        | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 92a855fbe5b8..21d403f55d96 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -60,10 +60,10 @@ struct cs_etm_decoder_params {
 	int operation;
 	void (*packet_printer)(const char *msg);
 	cs_etm_mem_cb_type mem_acc_cb;
-	u8 formatted;
-	u8 fsyncs;
-	u8 hsyncs;
-	u8 frame_aligned;
+	bool formatted;
+	bool fsyncs;
+	bool hsyncs;
+	bool frame_aligned;
 	void *data;
 };
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 50593289d53c..e048949bf655 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -50,10 +50,10 @@ struct cs_etm_auxtrace {
 	struct thread *unknown_thread;
 	struct perf_tsc_conversion tc;
 
-	u8 timeless_decoding;
-	u8 snapshot_mode;
-	u8 data_queued;
-	u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
+	bool timeless_decoding;
+	bool snapshot_mode;
+	bool data_queued;
+	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
 
 	int num_cpu;
 	u64 latest_kernel_timestamp;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 16333d35bed4..70cac0375b34 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -179,8 +179,8 @@ struct cs_etm_packet {
 	u32 last_instr_subtype;
 	u32 flags;
 	u32 exception_number;
-	u8 last_instr_cond;
-	u8 last_instr_taken_branch;
+	bool last_instr_cond;
+	bool last_instr_taken_branch;
 	u8 last_instr_size;
 	u8 trace_chan_id;
 	int cpu;
-- 
2.34.1

