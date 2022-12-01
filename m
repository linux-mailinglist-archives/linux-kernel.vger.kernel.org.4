Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0F63F8AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiLAT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLAT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B56BA602
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924640; x=1701460640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psXZMKbJQ3yGAryg57Kdkp4DtQsybo7dhx1r47nzioo=;
  b=BGYQ8AXSleZJ/QFFUN2Bu5ZbDXrHd9U6Znf4aPnoHJFp9H2AshJ/j5+G
   dbUiEkOflH1H32DZne69qM0ZNIQobgnf/AiyQOjo0AsZ2b8qebDKCoQzn
   swVQwvkYENr0DyxWlqsmq09HZOSIAYnXFKLs4WUeqCM0cL8aHHIOwuXu7
   f6o51/wkg5p3tfy15fqTysC6S7HyMSTc5fb7MQy+IOWsd/I5lATrykiwT
   6EliA7w/+yfHQ/w1D9Xv96sfoOiydObA7TPP9NrNlr0mqIbUJVvpsMHHH
   Bv/pZWhinXCA0aKcrEJtR9bbeVG6IF1RnfrLaEnefv7eB5yolq+g4o1MF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303391902"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303391902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708205170"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708205170"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 11:57:19 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 9/9] perf script: Support Retire Latency
Date:   Thu,  1 Dec 2022 11:57:04 -0800
Message-Id: <20221201195704.2330866-9-kan.liang@linux.intel.com>
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
PERF_SAMPLE_WEIGHT_STRUCT. The Retire Latency reports the number of
elapsed core clocks between the retirement of the instruction
indicated by the Instruction Pointer field of the PEBS record and the
retirement of the prior instruction. That's quite useful to display
the information with perf script.

Add a new field retire_lat for the Retire Latency information.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-script.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7ca238277d83..071ffdff1980 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -127,6 +127,7 @@ enum perf_output_field {
 	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
 	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
+	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 39,
 };
 
 struct perf_script {
@@ -197,6 +198,7 @@ struct output_option {
 	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
 	{.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
 	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
+	{.str = "retire_lat", .field = PERF_OUTPUT_RETIRE_LAT},
 };
 
 enum {
@@ -272,7 +274,7 @@ static struct {
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
 			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
 			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE |
-			      PERF_OUTPUT_INS_LAT,
+			      PERF_OUTPUT_INS_LAT | PERF_OUTPUT_RETIRE_LAT,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -539,6 +541,10 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_INS_LAT))
 		return -EINVAL;
 
+	if (PRINT_FIELD(RETIRE_LAT) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_RETIRE_LAT))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2175,6 +2181,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(INS_LAT))
 		fprintf(fp, "%16" PRIu16, sample->ins_lat);
 
+	if (PRINT_FIELD(RETIRE_LAT))
+		fprintf(fp, "%16" PRIu16, sample->retire_lat);
+
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
@@ -3849,7 +3858,7 @@ int cmd_script(int argc, const char **argv)
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
-		     "code_page_size,ins_lat",
+		     "code_page_size,ins_lat,retire_lat",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.35.1

