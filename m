Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8D6A9015
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 05:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCCEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCCEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 23:14:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FEA12BE6;
        Thu,  2 Mar 2023 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677816857; x=1709352857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vF/1poQJ5i2/fALYadh5wXENB15OfhGT7T0JvZIYi0I=;
  b=Bl0Lg5MRLFrwskFU/gAuNLdwv4PpTyiVrjfu3N5Zdxid4A2tB92dYd29
   RYXmVbhLiibvpaMQ8ha33UxEliZlZge5KZJS1W8cR0n4DsuUOpuZhEaMG
   3y4hMbWU2nC0xjisZdfqlK74peb/RVI7xKAQlDFrzCdAcdppr7G9cP9GZ
   DLpsIoNwFkTCeoe29VOWAIvf9Lv6nm/W6KYSvdNSImFLAj69VzRAkYfJy
   5Kk73rkEoXJkShsKGkBWDxJsKIhD+XCTi7XgDMkX+FX9lVP0rRiVurabW
   D9MjJp3QJfPDwzwz159d6KSDp0C0kP/bRPhyBD7vNZSM//LkOzorTMNgT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333671402"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="333671402"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 20:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="744119122"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="744119122"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2023 20:14:16 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Enable HWP IO boost for all servers
Date:   Thu,  2 Mar 2023 20:14:11 -0800
Message-Id: <20230303041411.3161780-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

The HWP IO boost results in slight improvements for IO performance on
both Ice Lake and Sapphire Rapid servers.

Currently there is a CPU model check for Skylake desktop and server along
with the ACPI PM profile for performance and enterprise servers to enable
IO boost.

Remove the CPU model check, so that all current server models enable HWP
IO boost by default.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cb4beec27555..8edbc0856892 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2384,12 +2384,6 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 	{}
 };
 
-static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
-	X86_MATCH(SKYLAKE_X,		core_funcs),
-	X86_MATCH(SKYLAKE,		core_funcs),
-	{}
-};
-
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
@@ -2408,12 +2402,9 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		cpu->epp_default = -EINVAL;
 
 		if (hwp_active) {
-			const struct x86_cpu_id *id;
-
 			intel_pstate_hwp_enable(cpu);
 
-			id = x86_match_cpu(intel_pstate_hwp_boost_ids);
-			if (id && intel_pstate_acpi_pm_profile_server())
+			if (intel_pstate_acpi_pm_profile_server())
 				hwp_boost = true;
 		}
 	} else if (hwp_active) {
-- 
2.34.1

