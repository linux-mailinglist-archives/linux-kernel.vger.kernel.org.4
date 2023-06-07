Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123777265DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjFGQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFGQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD419BC;
        Wed,  7 Jun 2023 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155240; x=1717691240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1t0YBmHwyxZmGA+01w7vD6GxXoMOf6lhCQFoyeHgFVQ=;
  b=ZuZFTBNUCd8gFy0XEHYnmviJS4to1O5I/zHuMC0LWuOYDgRJYYq+j1TI
   hjnxZZ57dWN4JN9B/wDk/U1Gn6IPKv+RFgtIkHEBsZ4gh+/wtWoSbRGUa
   g6uY0o90ntHdL8hdWeT99/7JYFXXqWz/GWZHpRQJFuqMNoXci+RH47HYY
   Fk74hojYm8dI3JiWCNSIcNDj0uSjaYjCP8RTMxMUyFPzmmTir0Pfv77cp
   lgIPXB2ZGfH7R+RR7K3+lYwnQFJTwv6ZQ6mGFcJHwSDZEhc6aG+BESguT
   V1MZW+PXtNRO3iHcJRumTyS8hY6r7P2Cu9PEj4TIBNhzB5X+5QtgaangV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892612"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892612"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697652"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697652"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:19 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/8] perf metric: Fix no group check
Date:   Wed,  7 Jun 2023 09:26:53 -0700
Message-Id: <20230607162700.3234712-2-kan.liang@linux.intel.com>
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

The no group check fails if there is more than one meticgroup in the
metricgroup_no_group.

The first parameter of the match_metric() should be the string, while
the substring should be the second parameter.

Fixes: ccc66c609280 ("perf metric: JSON flag to not group events if gathering a metric group")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 70ef2e23a710..74f2d8efc02d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1175,7 +1175,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 
 	if (pm->metric_expr && match_pm_metric(pm, data->pmu, data->metric_name)) {
 		bool metric_no_group = data->metric_no_group ||
-			match_metric(data->metric_name, pm->metricgroup_no_group);
+			match_metric(pm->metricgroup_no_group, data->metric_name);
 
 		data->has_match = true;
 		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
-- 
2.35.1

