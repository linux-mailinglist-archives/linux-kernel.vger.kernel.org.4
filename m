Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF25E889D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiIXFpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiIXFo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:44:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B501F3BC79;
        Fri, 23 Sep 2022 22:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663998285; x=1695534285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aktu51+28FaoJRxOu94f10+s9e/A7ngnX7byejD6d3s=;
  b=RG9cFJmIH+/DoOYn3J7gULp7D3lf29qWNkJgxSm8Op91MCsxmwGEWgaP
   feSYJRDGJpWPPdqGyP8bM5g+U7FWJagvKt/5+d0Iqupq/nJZXBzW1welX
   kXwytf6+QBPSOfn+h4bHEiC0wG1KwHMi8i1HCwJ38hI9IontS/W7tmDz4
   PJUP4xVRR2bQ3QGjh202Md0YUjrHQ/JHNyxIuQY2wC9M7c4ycES61P0lK
   l/5eqqD/hN/6LPpe3n4vOZOUnlnRcTMSNfPKRhSwm95ictJWgQK3GMzG8
   zViBOIIHuzaGNSquQDxR1FoYQ9wYg3Y5v8FC3NmKNG5U5wZMvTJ0d4NL9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299470293"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="299470293"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 22:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="651207779"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 22:44:42 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, len.brown@intel.com
Cc:     mingo@redhat.com, linux-pm@vger.kernel.org, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Subject: [PATCH 3/3] tools/power turbostat: Use standard Energy Unit for SPR Dram RAPL domain
Date:   Sat, 24 Sep 2022 13:47:38 +0800
Message-Id: <20220924054738.12076-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220924054738.12076-1-rui.zhang@intel.com>
References: <20220924054738.12076-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Xeon servers used to use a fixed energy resolution (15.3uj) for
Dram RAPL domain. But on SPR, Dram RAPL domain follows the standard
energy resolution as described in MSR_RAPL_POWER_UNIT.

Remove the SPR rapl_dram_energy_units quirk.

Fixes: e7af1ed3fa47 ("tools/power turbostat: Support additional CPU model numbers")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 597cc2dbc456..e3e357df2a51 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4560,7 +4560,6 @@ static double rapl_dram_energy_units_probe(int model, double rapl_energy_units)
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
-- 
2.25.1

