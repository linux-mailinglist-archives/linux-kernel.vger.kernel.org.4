Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392A64A47B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiLLP4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiLLPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:55:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52ED812AE6;
        Mon, 12 Dec 2022 07:55:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963411FB;
        Mon, 12 Dec 2022 07:56:33 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 949133F71E;
        Mon, 12 Dec 2022 07:55:50 -0800 (PST)
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
Subject: [PATCH 4/5] perf: cs-etm: Cleanup cs_etm__process_auxtrace_info()
Date:   Mon, 12 Dec 2022 15:55:12 +0000
Message-Id: <20221212155513.2259623-5-james.clark@arm.com>
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

hdr is a copy of 3 values of ptr and doesn't need to be long lived. So
just use ptr instead which means the malloc and the extra error path can
be removed to simplify things.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index bf8fbcec2d69..ab30591a6c6a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2888,7 +2888,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	int num_cpu, trcidr_idx;
 	int err = 0;
 	int i, j;
-	u64 *ptr, *hdr = NULL;
+	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 	u64 hdr_version;
 
@@ -2914,15 +2914,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return -EINVAL;
 	}
 
-	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_MAX);
-	if (!hdr)
-		return -ENOMEM;
-
-	/* Extract header information - see cs-etm.h for format */
-	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
-		hdr[i] = ptr[i];
-	num_cpu = hdr[CS_PMU_TYPE_CPUS] & 0xffffffff;
-	pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
+	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
+	pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) &
 				    0xffffffff);
 
 	if (dump_trace)
@@ -2934,10 +2927,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	 * in anything other than a sequential array is worth doing.
 	 */
 	traceid_list = intlist__new(NULL);
-	if (!traceid_list) {
-		err = -ENOMEM;
-		goto err_free_hdr;
-	}
+	if (!traceid_list)
+		return -ENOMEM;
 
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
 	if (!metadata) {
@@ -2945,6 +2936,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		goto err_free_traceid_list;
 	}
 
+	/* Start parsing after the common part of the header */
+	i = CS_HEADER_VERSION_MAX;
+
 	/*
 	 * The metadata is stored in the auxtrace_info section and encodes
 	 * the configuration of the ARM embedded trace macrocell which is
@@ -3043,7 +3037,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 	etm->num_cpu = num_cpu;
 	etm->pmu_type = pmu_type;
-	etm->snapshot_mode = (hdr[CS_ETM_SNAPSHOT] != 0);
+	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
 	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
@@ -3110,7 +3104,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	zfree(&metadata);
 err_free_traceid_list:
 	intlist__delete(traceid_list);
-err_free_hdr:
-	zfree(&hdr);
 	return err;
 }
-- 
2.25.1

