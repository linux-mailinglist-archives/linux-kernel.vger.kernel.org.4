Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5471D65DD79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjADUOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjADUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:14:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C8E3C38E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863254; x=1704399254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hjX6fvtkd6Ef+DO07MB9yPRMVzUF3uuDEe0GPO/Ialc=;
  b=QhG6wflr5md046YquT+6t7mED9NsoR9UhllIYUDUfNkyrwE/eKDvA0nz
   XTh33MVkMOcOVz0BWglDOU88HWMR3uTlcw+GeB7WzoaFFKAx09diY+M3U
   x5D7/l0/NFc4D4rlejBdqyxlqo+oN8MFz7XZ2gwgOQWu0lsKzgaXFegqF
   y2c8DbSl5htb08iHPdzr5DrD4y+xKmvedWasmwUpsix33xUzbl0f46Bkx
   J6kUb0/ZXejGEk3PB4Aqt+m4ppoaPoQQ6ZRbT9FRttJFWMZ9oTlDcbWzh
   VABh0XLpqxxqFdG4Kt7yMK8ldLeKzlBDDTeBqbRkomn6TxeNfKBoE5YLl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322105495"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322105495"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779324020"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="779324020"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 12:14:13 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 9/9] perf script: Support Retire Latency
Date:   Wed,  4 Jan 2023 12:13:49 -0800
Message-Id: <20230104201349.1451191-9-kan.liang@linux.intel.com>
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
PERF_SAMPLE_WEIGHT_STRUCT. The Retire Latency reports the number of
elapsed core clocks between the retirement of the instruction
indicated by the Instruction Pointer field of the PEBS record and the
retirement of the prior instruction. That's quite useful to display
the information with perf script.

Add a new field retire_lat for the Retire Latency information.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Change since V1
- Rebase on top of 6.2-rc1

 tools/perf/builtin-script.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..5a783d4ab55e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -130,6 +130,7 @@ enum perf_output_field {
 	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
 	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
+	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 39,
 };
 
 struct perf_script {
@@ -200,6 +201,7 @@ struct output_option {
 	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
 	{.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
 	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
+	{.str = "retire_lat", .field = PERF_OUTPUT_RETIRE_LAT},
 };
 
 enum {
@@ -275,7 +277,7 @@ static struct {
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
 			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
 			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE |
-			      PERF_OUTPUT_INS_LAT,
+			      PERF_OUTPUT_INS_LAT | PERF_OUTPUT_RETIRE_LAT,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -542,6 +544,10 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_INS_LAT))
 		return -EINVAL;
 
+	if (PRINT_FIELD(RETIRE_LAT) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_RETIRE_LAT))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2178,6 +2184,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(INS_LAT))
 		fprintf(fp, "%16" PRIu16, sample->ins_lat);
 
+	if (PRINT_FIELD(RETIRE_LAT))
+		fprintf(fp, "%16" PRIu16, sample->retire_lat);
+
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
@@ -3856,7 +3865,7 @@ int cmd_script(int argc, const char **argv)
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

