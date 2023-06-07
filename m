Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDC7265DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFGQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFGQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B331734;
        Wed,  7 Jun 2023 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155244; x=1717691244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jMWpaJgiMGTiy13U7uDkL/ns2NCxNprT8Kgl9zFnTro=;
  b=DYz1J53+AyHB9ApNeafDaaml8h3VLsF/TDsPE7vYMR+1ZYAtOE8rn23f
   L/di7RNRzHYgpVMq083rmi0WXzAYEC43LRpOANkzbhoKBE3GhwXobwgcO
   zpHi0+FNhcsi4rswYyL2vWWFYwV70Vh2TW2uukXHrx3KwSigd9jJg7ze0
   9+ulrwy6d5RVC6VyjcjPkk2G4mWUv/zfFJfMyzzIEcBqRm4u/X1lBtJXY
   2V4lbVt+J8u0dPgYTu03gQ6xadsYNwZFbYSDRIUSp9IYiiAlex8V0h95u
   xXF5qZ9ei5iSiXHMumOnGegUEJDUpVWrPiCbs1XCM6oNSUPoWdL3Nk9ur
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892642"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892642"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697668"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697668"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:21 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/8] perf vendor events arm64: Add default tags into topdown L1 metrics
Date:   Wed,  7 Jun 2023 09:26:56 -0700
Message-Id: <20230607162700.3234712-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230607162700.3234712-1-kan.liang@linux.intel.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add the default tags for ARM as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: John Garry <john.g.garry@oracle.com>
---
 tools/perf/pmu-events/arch/arm64/sbsa.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-events/arch/arm64/sbsa.json
index f678c37ea9c3..f90b338261ac 100644
--- a/tools/perf/pmu-events/arch/arm64/sbsa.json
+++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
@@ -2,28 +2,32 @@
     {
         "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
         "BriefDescription": "Frontend bound L1 topdown metric",
-        "MetricGroup": "TopdownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "frontend_bound",
         "ScaleUnit": "100%"
     },
     {
         "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
         "BriefDescription": "Bad speculation L1 topdown metric",
-        "MetricGroup": "TopdownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "bad_speculation",
         "ScaleUnit": "100%"
     },
     {
         "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
         "BriefDescription": "Retiring L1 topdown metric",
-        "MetricGroup": "TopdownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "retiring",
         "ScaleUnit": "100%"
     },
     {
         "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
         "BriefDescription": "Backend Bound L1 topdown metric",
-        "MetricGroup": "TopdownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "backend_bound",
         "ScaleUnit": "100%"
     }
-- 
2.35.1

