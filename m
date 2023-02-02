Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39B668877D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjBBTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjBBTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:22:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFBE6CCAA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675365747; x=1706901747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v295qWvEx3Nv9XHY8DcBdTrp9kA8mC30r+JvmTkGgi4=;
  b=AJVY6HJLj21CIHLt7iILdqF/KKar0fBbvd+t3Z0Nfsw7Cxo3sEZlKwko
   P9dcoHI+w95XKMCDhbj4P3LfTkwP3CeGFn+Zok22zHy0+C2P/jM2XOsKI
   6DFLlkSj7gX+NIVF+6ZM3NdUpXvosgtMhdiSOmv/Qwzprjlze+d5s2uD/
   QjSDOYMrDWlp/2t3QYq5+rKnQMyhc7EC3gksNLwjeGYP+RheENebwmJ7E
   C8AizMsoP3YhBeWzZh97v3Bu9WacoDaOXVaOGPMB2DDg+cqExxTah5Ddu
   SxLjuKPIrIQviQQ5yQYahrTFh69aHl0AKo1c/rb1rY3bcjKo1N83PyPEF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="312194496"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="312194496"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 11:22:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="697793086"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="697793086"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2023 11:22:11 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/3] perf script: Support Retire Latency
Date:   Thu,  2 Feb 2023 11:22:08 -0800
Message-Id: <20230202192209.1795329-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230202192209.1795329-1-kan.liang@linux.intel.com>
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
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
PERF_SAMPLE_WEIGHT_STRUCT. The Retire Latency reports the number of
elapsed core clocks between the retirement of the instruction
indicated by the Instruction Pointer field of the PEBS record and the
retirement of the prior instruction. That's quite useful to display
the information with perf script.

Add a new field retire_lat for the Retire Latency information.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Change from V2
- Rebase on top of tmp.perf/core
- Update perf-script.txt

 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index a2ebadc9d948..777a0d8ba7d1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -134,7 +134,7 @@ OPTIONS
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
-        machine_pid, vcpu, cgroup.
+        machine_pid, vcpu, cgroup, retire_lat.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cb6b34da4eef..3fe9b1c4caaf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -132,6 +132,7 @@ enum perf_output_field {
 	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
 	PERF_OUTPUT_CGROUP          = 1ULL << 39,
+	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
 };
 
 struct perf_script {
@@ -203,6 +204,7 @@ struct output_option {
 	{.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
 	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
 	{.str = "cgroup", .field = PERF_OUTPUT_CGROUP},
+	{.str = "retire_lat", .field = PERF_OUTPUT_RETIRE_LAT},
 };
 
 enum {
@@ -278,7 +280,7 @@ static struct {
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
 			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
 			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE |
-			      PERF_OUTPUT_INS_LAT,
+			      PERF_OUTPUT_INS_LAT | PERF_OUTPUT_RETIRE_LAT,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -551,6 +553,10 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 	}
 
+	if (PRINT_FIELD(RETIRE_LAT) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_RETIRE_LAT))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2187,6 +2193,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(INS_LAT))
 		fprintf(fp, "%16" PRIu16, sample->ins_lat);
 
+	if (PRINT_FIELD(RETIRE_LAT))
+		fprintf(fp, "%16" PRIu16, sample->retire_lat);
+
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
@@ -3876,7 +3885,7 @@ int cmd_script(int argc, const char **argv)
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
-		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup",
+		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.35.1

