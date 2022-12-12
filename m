Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114D64A47A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiLLP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiLLPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:55:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0006465B5;
        Mon, 12 Dec 2022 07:55:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5CE15DB;
        Mon, 12 Dec 2022 07:56:30 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BCE03F71E;
        Mon, 12 Dec 2022 07:55:47 -0800 (PST)
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
Subject: [PATCH 3/5] perf: cs-etm: Tidy up auxtrace info header printing
Date:   Mon, 12 Dec 2022 15:55:11 +0000
Message-Id: <20221212155513.2259623-4-james.clark@arm.com>
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

cs_etm__print_auxtrace_info() is called twice in case there is an error
somewhere in cs_etm__process_auxtrace_info(), but all the info is
already available at the beginning so just print it there instead.

Also use u64 and the already cast ptr variable to make it more
consistent with the rest of the etm code.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aeb1e30888db..bf8fbcec2d69 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2541,14 +2541,14 @@ static const char * const cs_etmv4_priv_fmts[] = {
 };
 
 static const char * const param_unk_fmt =
-	"	Unknown parameter [%d]	       %llx\n";
+	"	Unknown parameter [%d]	       %"PRIx64"\n";
 static const char * const magic_unk_fmt =
-	"	Magic number Unknown	       %llx\n";
+	"	Magic number Unknown	       %"PRIx64"\n";
 
-static int cs_etm__print_cpu_metadata_v0(__u64 *val, int *offset)
+static int cs_etm__print_cpu_metadata_v0(u64 *val, int *offset)
 {
 	int i = *offset, j, nr_params = 0, fmt_offset;
-	__u64 magic;
+	u64 magic;
 
 	/* check magic value */
 	magic = val[i + CS_ETM_MAGIC];
@@ -2580,10 +2580,10 @@ static int cs_etm__print_cpu_metadata_v0(__u64 *val, int *offset)
 	return 0;
 }
 
-static int cs_etm__print_cpu_metadata_v1(__u64 *val, int *offset)
+static int cs_etm__print_cpu_metadata_v1(u64 *val, int *offset)
 {
 	int i = *offset, j, total_params = 0;
-	__u64 magic;
+	u64 magic;
 
 	magic = val[i + CS_ETM_MAGIC];
 	/* total params to print is NR_PARAMS + common block size for v1 */
@@ -2619,7 +2619,7 @@ static int cs_etm__print_cpu_metadata_v1(__u64 *val, int *offset)
 	return 0;
 }
 
-static void cs_etm__print_auxtrace_info(__u64 *val, int num)
+static void cs_etm__print_auxtrace_info(u64 *val, int num)
 {
 	int i, cpu = 0, version, err;
 
@@ -2925,6 +2925,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
 				    0xffffffff);
 
+	if (dump_trace)
+		cs_etm__print_auxtrace_info(ptr, num_cpu);
+
 	/*
 	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
 	 * has to be made for each packet that gets decoded, optimizing access
@@ -3074,10 +3077,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
-	if (dump_trace) {
-		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
-	}
-
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
@@ -3113,12 +3112,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	intlist__delete(traceid_list);
 err_free_hdr:
 	zfree(&hdr);
-	/*
-	 * At this point, as a minimum we have valid header. Dump the rest of
-	 * the info section - the print routines will error out on structural
-	 * issues.
-	 */
-	if (dump_trace)
-		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
 	return err;
 }
-- 
2.25.1

