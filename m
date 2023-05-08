Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB216FA382
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjEHJkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjEHJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:40:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E731709;
        Mon,  8 May 2023 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683538836; x=1715074836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRRzVfLR8FQOzqTHIuV3hywtd7FraWhxifJu1SEXR9Q=;
  b=jO//7Qyv70bBTcaS0XOvN8bffu3tVvAs90V4UOiwD3LdkNdHIL4Rn66r
   IguWLxGG7PuCVmuE/l/Ttc4sp44bWkIax/bZsheHfHPwF8THGvm762Pdl
   SRD8J91uzV4t6Kv4H91c0zaxeA3xAUSMhFrTlLN7Ken7rLOEB9lCZJjBK
   62G3oDf0KWwi2ZV55tl0q2l/9iaGpGVr0whi4AAcF2ZO93yhOf4oOaP3p
   d2+BMGvn9m9OigDeLpqDChKBGChn/UcHCVN3GktYULMJ5BHSqPtJ1muV0
   GOUefrfOPI6ukINP3TdLQiTFBmrYgfysqvR1C8zJyG/OwJ5HXlYNwpTde
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329223689"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329223689"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="1028354993"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="1028354993"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.218.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:40:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 2/2] perf parse-events: Do not break up AUX event group
Date:   Mon,  8 May 2023 12:39:52 +0300
Message-Id: <20230508093952.27482-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508093952.27482-1-adrian.hunter@intel.com>
References: <20230508093952.27482-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not assume which events may have a PMU name, allowing the logic to
keep an AUX event group together.

Example:

 Before:

    $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any/aux-sample-size=8192/pp}:u' -- sleep 0.1
    WARNING: events were regrouped to match PMUs
    Cannot add AUX area sampling to a group leader

 After:

    $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any/aux-sample-size=8192/pp}:u' -- sleep 0.1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.078 MB perf.data ]
    $ perf script -F-dso,+addr | grep -C5 tlb_flush.stlb_any | head -11
    sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc82a2 dl_main+0x9a2 => 7f5350cb38f0 _dl_add_to_namespace_list+0x0
    sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cb3908 _dl_add_to_namespace_list+0x18 => 7f5350cbb080 rtld_mutex_dummy+0x0
    sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc8350 dl_main+0xa50 => 0 [unknown]
    sleep 20444 [003]  7939.510244:  1  branches:uH:  7f5350cc83ca dl_main+0xaca => 7f5350caeb60 _dl_process_pt_gnu_property+0x0
    sleep 20444 [003]  7939.510245:  1  branches:uH:  7f5350caeb60 _dl_process_pt_gnu_property+0x0 => 0 [unknown]
    sleep 20444  7939.510245:       10 tlb_flush.stlb_any/aux-sample-size=8192/pp: 0 7f5350caeb60 _dl_process_pt_gnu_property+0x0
    sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc87fe dl_main+0xefe => 7f5350ccd240 strcmp+0x0
    sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc8862 dl_main+0xf62 => 0 [unknown]
    sleep 20444 [003]  7939.510255:  1  branches:uH:  7f5350cc9cdc dl_main+0x23dc => 0 [unknown]
    sleep 20444 [003]  7939.510257:  1  branches:uH:  7f5350cc89f6 dl_main+0x10f6 => 7f5350cb9530 _dl_setup_hash+0x0
    sleep 20444 [003]  7939.510257:  1  branches:uH:  7f5350cc8a2d dl_main+0x112d => 7f5350cb3990 _dl_new_object+0x0

Suggested-by: Ian Rogers <irogers@google.com>
Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e18752fd9245..9fdcde5471df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -828,11 +828,9 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
 
 const char *evsel__group_pmu_name(const struct evsel *evsel)
 {
-	struct evsel *leader, *pos;
+	struct evsel *leader = evsel__leader(evsel);
+	struct evsel *pos;
 
-	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
-	if (evsel->pmu_name)
-		return evsel->pmu_name;
 	/*
 	 * Software events may be in a group with other uncore PMU events. Use
 	 * the pmu_name of the first non-software event to avoid breaking the
@@ -841,7 +839,6 @@ const char *evsel__group_pmu_name(const struct evsel *evsel)
 	 * Aux event leaders, like intel_pt, expect a group with events from
 	 * other PMUs, so substitute the AUX event's PMU in this case.
 	 */
-	leader  = evsel__leader(evsel);
 	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
 		/* Starting with the leader, find the first event with a named PMU. */
 		for_each_group_evsel(pos, leader) {
@@ -850,7 +847,7 @@ const char *evsel__group_pmu_name(const struct evsel *evsel)
 		}
 	}
 
-	return "cpu";
+	return evsel->pmu_name ?: "cpu";
 }
 
 const char *evsel__metric_id(const struct evsel *evsel)
-- 
2.34.1

