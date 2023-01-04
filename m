Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220B065DD78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjADUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjADUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:14:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4679F11C3A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863253; x=1704399253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ehlpv62JJoPoTAs4sBwCHanyUqPdY5VYO9Qbv8uzt+o=;
  b=n7DKaUYo+UkNAhzuC2lUl9N1nfs0I0VD3buMIcbtnNg3dafxsr+h14lq
   IcV+dnIGnpmZI1LSCWup5vSZ/nnhNvBqCgEx739CTXpj0rWoHMSUaBzYs
   RWRGHg99rpYB4960bRgFTUlJ73JCZm2ENBM5Oak5cfJal5JgdlPyWT5rw
   P/frrIqjfNwdnz805h9ObPBl/2PyMCbBaCydaMmiteFRC09BvFifrhp+s
   WKmSqdkE9I+W+tmvHqs8DUgblCvCCWBqQI9sEF0OLDw1N24yCmboEr5yp
   MpIqofMTt7N7DJi1yFkNrFFxrf/qlLKKTG1Den+iheZ4vCybgEGEpJy68
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322105490"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322105490"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779324019"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="779324019"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 12:14:12 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 8/9] perf report: Support Retire Latency
Date:   Wed,  4 Jan 2023 12:13:48 -0800
Message-Id: <20230104201349.1451191-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104201349.1451191-1-kan.liang@linux.intel.com>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Change since V1
- Rebase on top of 6.2-rc1

 tools/perf/Documentation/perf-report.txt |  2 ++
 tools/perf/arch/x86/util/event.c         | 20 ++++++++++++++++++++
 tools/perf/util/sample.h                 |  5 ++++-
 tools/perf/util/sort.c                   |  2 ++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 4fa509b15948..e3971ddb666c 100644
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
index a3acefe6d0c6..37b3feb53e8d 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -89,6 +89,7 @@ void arch_perf_parse_sample_weight(struct perf_sample *data,
 	else {
 		data->weight = weight.var1_dw;
 		data->ins_lat = weight.var2_w;
+		data->retire_lat = weight.var3_w;
 	}
 }
 
@@ -102,3 +103,22 @@ void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
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
index e188f74698dd..e2cc18cd08cd 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2132,6 +2132,8 @@ static struct sort_dimension common_sort_dimensions[] = {
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

