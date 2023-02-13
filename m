Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93017695069
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBMTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBMTIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C813DE7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315290; x=1707851290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vCwYtZX3hPfCSqvh+1wJUJFKXzNXPAQY4vmXXsWFxE=;
  b=fA4BsrQsZKY3Fo5eKyqf1I5EgTKh84RKa8Hw7J4t2d/eko5Y5C0rQLm3
   8wMnbrTYdMclBXp65YZ6E6BYkdyt4MC7TF+eC6qyupiaSFj2edpc65kFu
   8xbDNg0pyEEl566abfdhZrdVXgKP2+EcOCtUW5qrne2Ep86R4ZMcn3Xb2
   M6E5nkpYzTkMqy/Dy8+OV5511AlA+QxUAaiGMRxMw8zbsyI10YKPiA4dI
   6e1j9wyZcg+Pz1Qb6c54rEF20OiiClDzMWJkxFBiVXH+THDF0hNugwQha
   37dZdtfqXqppDGU+lGb0a88ey75jUK/WUMOb1LhaGAon1QGym3ngT2EkX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108803"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901968"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901968"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:08:10 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 9/9] perf evsel: Enable post-processing monotonic raw conversion by default
Date:   Mon, 13 Feb 2023 11:07:54 -0800
Message-Id: <20230213190754.1836051-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213190754.1836051-1-kan.liang@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
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

The HW time is more accurate than the time recorded in the NMI handler.
Set the hw_time by default for the monotonic raw clock, and convert the
HW time to the monotonic raw clock in perf tool.

For the legacy kernel which doesn't support the attr, nothing is
changed. The monotonic raw clock is still from the time recorded in the
NMI handler.

Print the hw_time in perf_event_attr__fprintf

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c                   | 11 ++++++++++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5e27ac2b9f9b..d182c12fd291 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1349,6 +1349,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->use_clockid) {
 		attr->use_clockid = 1;
 		attr->clockid = opts->clockid;
+		if (opts->clockid == CLOCK_MONOTONIC_RAW)
+			attr->hw_time = 1;
 	}
 
 	if (evsel->precise_max)
@@ -1853,6 +1855,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.hw_time)
+		evsel->core.attr.hw_time = 0;
 	if (perf_missing_features.read_lost)
 		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
@@ -1906,7 +1910,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.read_lost &&
+	if (!perf_missing_features.hw_time &&
+	    evsel->core.attr.hw_time) {
+		perf_missing_features.hw_time = true;
+		pr_debug2("switching off hw_time support\n");
+		return true;
+	} else if (!perf_missing_features.read_lost &&
 	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
 		perf_missing_features.read_lost = true;
 		pr_debug2("switching off PERF_FORMAT_LOST support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d1ef67852bda..c1d6fd40ea39 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -189,6 +189,7 @@ struct perf_missing_features {
 	bool code_page_size;
 	bool weight_struct;
 	bool read_lost;
+	bool hw_time;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 7e5e7b30510d..7b3669430b87 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -154,6 +154,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
+	PRINT_ATTRf(hw_time, p_unsigned);
 
 	return ret;
 }
-- 
2.35.1

