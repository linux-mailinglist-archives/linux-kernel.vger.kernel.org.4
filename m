Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0768877C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjBBTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBBTW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:22:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BBC6CC81
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675365746; x=1706901746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gRLGqnN3dpJh//qUZZcTgNIxIr+Rtxi8TeIn3MqJXDM=;
  b=K2vg7bjOnCO7BjPz0Vz1ZZaJcXd6Mcwm91zGgPKoJ1FgWLAsTwBbJIKS
   aMaeox55DY2E7ZLg1bqf6LHFo+GmMzKAqL3+NBS5BZHbzi+Hg5KxQVkbp
   zeBarABbjJxhiJxn6I8tDVKvYkLQVjdGikeM/Ik7RsnlxirPEsQ59Z24A
   t4fdOhFEi88oeKv13Y7PXKp7SIVjTqTaYXUzT4cQ33wPUjv6wjoGAVlPr
   +q1/6yIymt9zEEGnfEOfY2buJxbAgJF232E4joMHVAwsJMPuXMxl8UkwB
   UtC7KlWxXpR0XK9wytWnjodFaz451Tss/EyXEPSaeE0iO88Srr4hEi0b6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="312194484"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="312194484"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 11:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="697793066"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="697793066"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2023 11:22:09 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/3] perf report: Support Retire Latency
Date:   Thu,  2 Feb 2023 11:22:07 -0800
Message-Id: <20230202192209.1795329-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Retire Latency field is added in the var3_w of the
PERF_SAMPLE_WEIGHT_STRUCT. The Retire Latency reports pipeline stall
of this instruction compared to the previous instruction in cycles.
That's quite useful to display the information with perf mem report.

The p_stage_cyc for Power is also from the var3_w. Union the p_stage_cyc
and retire_lat to share the code.

Implement X86 specific codes to display the X86 specific header.

Add a new sort key retire_lat for the Retire Latency.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The kernel patches have been merged. The V3 only includes the perf tool
patches. The V2 can be found at
https://lore.kernel.org/lkml/20230104201349.1451191-1-kan.liang@linux.intel.com/

No change from V2.

 tools/perf/Documentation/perf-report.txt |  2 ++
 tools/perf/arch/x86/util/event.c         | 21 +++++++++++++++++++++
 tools/perf/util/sample.h                 |  5 ++++-
 tools/perf/util/sort.c                   |  2 ++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 9b0c0dbf9a77..c242e8da6b1a 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -115,6 +115,8 @@ OPTIONS
 	- p_stage_cyc: On powerpc, this presents the number of cycles spent in a
 	  pipeline stage. And currently supported only on powerpc.
 	- addr: (Full) virtual address of the sampled instruction
+	- retire_lat: On X86, this reports pipeline stall of this instruction compared
+	  to the previous instruction in cycles. And currently supported only on X86
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index a3acefe6d0c6..e4288d09f3a0 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -89,6 +89,7 @@ void arch_perf_parse_sample_weight(struct perf_sample *data,
 	else {
 		data->weight = weight.var1_dw;
 		data->ins_lat = weight.var2_w;
+		data->retire_lat = weight.var3_w;
 	}
 }
 
@@ -100,5 +101,25 @@ void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
 	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		*array &= 0xffffffff;
 		*array |= ((u64)data->ins_lat << 32);
+		*array |= ((u64)data->retire_lat << 48);
 	}
 }
+
+const char *arch_perf_header_entry(const char *se_header)
+{
+	if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
+		return "Local Retire Latency";
+	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
+		return "Retire Latency";
+
+	return se_header;
+}
+
+int arch_support_sort_key(const char *sort_key)
+{
+	if (!strcmp(sort_key, "p_stage_cyc"))
+		return 1;
+	if (!strcmp(sort_key, "local_p_stage_cyc"))
+		return 1;
+	return 0;
+}
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 60ec79d4eea4..33b08e0ac746 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -92,7 +92,10 @@ struct perf_sample {
 	u8  cpumode;
 	u16 misc;
 	u16 ins_lat;
-	u16 p_stage_cyc;
+	union {
+		u16 p_stage_cyc;
+		u16 retire_lat;
+	};
 	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
 	char insn[MAX_INSN];
 	void *raw_data;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d7d0f997873a..4a648231fe72 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2133,6 +2133,8 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_global_p_stage_cyc),
 	DIM(SORT_ADDR, "addr", sort_addr),
+	DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage_cyc),
+	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 921715e6aec4..9a91d0df2833 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -237,6 +237,8 @@ enum sort_type {
 	SORT_LOCAL_PIPELINE_STAGE_CYC,
 	SORT_GLOBAL_PIPELINE_STAGE_CYC,
 	SORT_ADDR,
+	SORT_LOCAL_RETIRE_LAT,
+	SORT_GLOBAL_RETIRE_LAT,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.35.1

