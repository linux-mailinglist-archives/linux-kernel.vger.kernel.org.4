Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E0720C4C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjFBXVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBXVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:21:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD871B5;
        Fri,  2 Jun 2023 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685748103; x=1717284103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0QMr+LsyFpUa44hvu1HGLdLwcSLm0H5G8gRPGZoFgm4=;
  b=MQJKTk7CtywPFOIZPNfKCfEVOtDbYPilD/zMOHHfwBVPgqHv8L5x/x2f
   zddYqCsd55wDigjPGrdXBK54yZX+2oWWTydsmCH8B1VzFnylubbxStYuF
   nUuL93MtQt9+zjkINEwuJH8sk3PfsFzNbXvn9x7z0O8/jb1s0ZzYvKsWe
   5+5WVYawVwmZHhJnC0zpUxq0nVySNEr2fzFc1LA6HZaMDVl+ffwMRZ3yb
   WV+XhxW7lvng0UmNyEn39eIG2cqCs1Z3XO3KIQB+OgN3OYZiHSRlmHtt2
   Fdo3ePUNOW1/zcFWC21akTuqnrcd8xkjwQRMzUi8NScjzUmR/6ujNyYMC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442370907"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="442370907"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 16:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="882229221"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="882229221"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2023 16:21:42 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.214.169])
        by linux.intel.com (Postfix) with ESMTP id 9CB4A580ABF;
        Fri,  2 Jun 2023 16:21:42 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/intel/pmc: Add resume_fixup callback
Date:   Fri,  2 Jun 2023 16:21:41 -0700
Message-Id: <20230602232142.278155-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a resume_fixup callback to perform platform specific fixups during
resume from suspend.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 3 +++
 drivers/platform/x86/intel/pmc/core.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index da6e7206d38b..0fcd1cb7264b 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1229,6 +1229,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
 
+	if (pmcdev->resume_fixup)
+		pmcdev->resume_fixup();
+
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 9ca9b9746719..b58458d00bd3 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -327,6 +327,7 @@ struct pmc_reg_map {
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @lpm_req_regs:	List of substate requirements
  * @core_configure:	Function pointer to configure the platform
+ * @resume_fixup:	Function to perform fixups during resume
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -345,6 +346,7 @@ struct pmc_dev {
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	u32 *lpm_req_regs;
 	void (*core_configure)(struct pmc_dev *pmcdev);
+	void (*resume_fixup)(void);
 };
 
 extern const struct pmc_bit_map msr_map[];
-- 
2.34.1

