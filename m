Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3378563F8AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLAT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLAT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E64BA608
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924639; x=1701460639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8EH0h7IkhRrGkxUHjtqjdslz6xr6JL2LMam/qGZ9N70=;
  b=Twx/sewlEKDzKrHcsosw3QNs/0HyUIvPb6KJJp4Qb/vrFIB0vr7kuKVw
   HDnXCtp242rRILpw1WlVU1bHwAk+h77hfFP4f+LvuKrA9ZfAFWYntWrI5
   eYljLOOMVoNwcm9xpvCQOribvB2e+T58J3FgJZTK9W6f04QGGJrpiJSV3
   0bvS7rLHecwd8bmuZoS6yhll939JXr5Yo92SyYbUn67MFqQ37bTKebm0e
   sHdmWuwqGox3bn7ZTLa03vCqE1tCjEQdc+Eid0m5TEwxrxr82xH1aDULK
   dQuzl0pGfx007fORz+6oHg8RzZcjtUmpVullrqT5qSeYhWEUH+rHbYEwC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303391896"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303391896"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708205157"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708205157"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 11:57:18 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 8/9] perf report: Support Retire Latency
Date:   Thu,  1 Dec 2022 11:57:03 -0800
Message-Id: <20221201195704.2330866-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201195704.2330866-1-kan.liang@linux.intel.com>
References: <20221201195704.2330866-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
 tools/perf/Documentation/perf-report.txt |  2 ++
 tools/perf/arch/x86/util/event.c         | 20 ++++++++++++++++++++
 tools/perf/util/event.h                  |  5 ++++-
 tools/perf/util/sort.c                   |  2 ++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 4533db2ee56b..711396cd3a52 100644
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
index e670f3547581..5f3a5c95f04f 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -87,6 +87,7 @@ void arch_perf_parse_sample_weight(struct perf_sample *data,
 	else {
 		data->weight = weight.var1_dw;
 		data->ins_lat = weight.var2_w;
+		data->retire_lat = weight.var3_w;
 	}
 }
 
@@ -100,3 +101,22 @@ void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
 		*array |= ((u64)data->ins_lat << 32);
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
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 12eae6917022..ff3f2892b1e3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -173,7 +173,10 @@ struct perf_sample {
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
index 2e7330867e2e..89aee5affe76 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2035,6 +2035,8 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_global_p_stage_cyc),
 	DIM(SORT_ADDR, "addr", sort_addr),
+	DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage_cyc),
+	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 04ff8b61a2a7..a4aff8437b85 100644
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

