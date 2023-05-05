Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6179E6F7D31
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjEEGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjEEGpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:45:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DB4C12;
        Thu,  4 May 2023 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683269130; x=1714805130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4KhTQWYJpyZeeVVAqWxzuhhuJ24zjCNfiqa/E3D5Nws=;
  b=FmJImMTKul5Ft39vikBGwCRKF5XwuGnvuTr6fVxbBMap0t5GFKbfmql/
   NanMN+JPDq8LWR43nVPH2nmAb5JB1qWyiXmRslKRRzKuDfEOOu59LdhJh
   cEUa7vWvyxb+PblKZd8D6eTVpoX19s9O9wvUffQjgU9dD8rhELVFVaXME
   0T9VRvvNADU7/qFr7DtwULU/DzZK4uL6Bh6GQ2he0BwSNhMjhOWdFCv+k
   yt+qDtonxy9o4xCFnnf7EHKnAnh3vPUyDwIJ2ZBKWUOwpErtiPrbKeY3w
   9kb/b76f1IT92ObYCUBg2Iy4BsSyPHPs2R2HoBmAxptRLRQz5SdFVWJRe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="333565129"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="333565129"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 23:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="943714373"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="943714373"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.212])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 23:45:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf parse-events: Do not break up AUX event group
Date:   Fri,  5 May 2023 09:44:52 +0300
Message-Id: <20230505064452.9660-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume AUX event group is correct and not do break it up.

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

Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 356c07f03be6..a34f61a5271d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -828,7 +828,11 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
 
 const char *evsel__group_pmu_name(const struct evsel *evsel)
 {
-	const struct evsel *leader;
+	const struct evsel *leader = evsel__leader(evsel);
+
+	/* Never break AUX event groups */
+	if (evsel__is_aux_event(leader))
+		return leader->pmu_name;
 
 	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
 	if (evsel->pmu_name)
@@ -837,15 +841,9 @@ const char *evsel__group_pmu_name(const struct evsel *evsel)
 	 * Software events may be in a group with other uncore PMU events. Use
 	 * the pmu_name of the group leader to avoid breaking the software event
 	 * out of the group.
-	 *
-	 * Aux event leaders, like intel_pt, expect a group with events from
-	 * other PMUs, so substitute the AUX event's PMU in this case.
 	 */
-	leader  = evsel__leader(evsel);
-	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
-	    leader->pmu_name) {
+	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && leader->pmu_name)
 		return leader->pmu_name;
-	}
 
 	return "cpu";
 }
-- 
2.34.1

