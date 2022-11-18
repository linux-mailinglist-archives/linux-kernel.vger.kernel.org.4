Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BAC62EEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiKRH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbiKRH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:56:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C18C093;
        Thu, 17 Nov 2022 23:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668758214; x=1700294214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8hF6YgXp4Ys4Ed5l5/rz2xoV2FruIaAMt4ntuoU4OIY=;
  b=MCowHOUHxmpfGqprQNMdLGdTS+fHAI+l0UPJjX5yhJUn+2FGLRv85Eqp
   LnN8D2QwaZJSXH6VzvJOf1xcr13WQk3pzNbFa41TYB9tlJGHyIaVG3Ohg
   7EBxVLZtpQELe6g7C1YJbHGZarmiZJmMJHDd42BsQ5D4wIeYkMuND5Jnp
   rpuAIIi+fW4/Owye00MKqBM+MXtj95UxF1KRJfP8VhFBpB2yAeJeamzD2
   fpcGdFCXnTAQDUW+RBspjhgxO3t4qKYzMQ75row4Gx2HDzTAslLLdeTtU
   mcMW0h407IZZmCugY2ALO+SfXL3mb0KWSGf9Lidzl893cBTe8gE7sX/HV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296444238"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="296444238"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634348296"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634348296"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 23:56:50 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 1/5] perf vendor events: Add the cpuid for Alderlake-N
Date:   Fri, 18 Nov 2022 15:56:58 +0800
Message-Id: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Alderlake-N only has E-core, it has been moved to non-hybrid code path on
the kernel side, add the cpuid for Alderlake-N separately. Both events for
Alderlake and Alderlake-N are based on JSON file v1.16.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5e609b876790..df47462a125f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BE|BF),v1.15,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.16,alderlake,core
+GenuineIntel-6-BE,v1.16,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
-- 
2.25.1

