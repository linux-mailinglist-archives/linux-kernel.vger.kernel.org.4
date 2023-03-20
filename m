Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32926C18FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjCTP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjCTP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:28:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 058BD302B8;
        Mon, 20 Mar 2023 08:21:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53D99FEC;
        Mon, 20 Mar 2023 08:16:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E301C3F71E;
        Mon, 20 Mar 2023 08:15:18 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, Anshuman.Khandual@arm.com
Cc:     German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
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
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] perf event: Add simd_flags field to perf_sample
Date:   Mon, 20 Mar 2023 15:15:05 +0000
Message-Id: <20230320151509.1137462-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320151509.1137462-1-james.clark@arm.com>
References: <20230320151509.1137462-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: German Gomez <german.gomez@arm.com>

Add new field to the struct perf_sample to store flags related to SIMD
ops.

It will be used to store SIMD information from SVE and NEON when
profiling using ARM SPE.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/sample.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 33b08e0ac746..c92ad0f51ecd 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -66,6 +66,18 @@ struct aux_sample {
 	void *data;
 };
 
+struct simd_flags {
+	u64	arch:1,	/* architecture (isa) */
+		pred:2;	/* predication */
+};
+
+/* simd architecture flags */
+#define SIMD_OP_FLAGS_ARCH_SVE		0x01	/* ARM SVE */
+
+/* simd predicate flags */
+#define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
+#define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
+
 struct perf_sample {
 	u64 ip;
 	u32 pid, tid;
@@ -106,6 +118,7 @@ struct perf_sample {
 	struct stack_dump user_stack;
 	struct sample_read read;
 	struct aux_sample aux_sample;
+	struct simd_flags simd_flags;
 };
 
 /*
-- 
2.34.1

