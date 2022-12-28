Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A026587C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiL1XGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiL1XGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:06:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E39B4A7;
        Wed, 28 Dec 2022 15:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672268780; x=1703804780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fSjIrcQRDvNG1vFngsj4HSl+5G2ZZUeVKEwFTd28l/k=;
  b=dJlagJZkeG7AWPEeESDcMuG0Wom2QDsUO0v9xSg12et5IQAfLuKdAbsX
   K00jd1/BGDx/A/trhxGrbOmm2sFrtOpNOkJ66jcC5u9FkT0t5nzQJwmJP
   s0CLYCHQ8z9kgBiZJiQOfQrHPK85ZEbz1rUEtXQrd+lU8wNGnCarQfVNe
   K0Fx4Q0DHDPSk1ve8K5rl1/pxPnvQ7MJlR/QwucmtCrdvtOMnMajQ6BIc
   BZgn7EMbe69cZ1jG9o5vsqy72/DZWscuAGSO3lTmLb66fXoWGd8k34okV
   qnLNd8UT0uvnbAtGuMKjpudK++mHUQUS/LENo3LqO5CmooXQVa3okHBbW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="322928064"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="322928064"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 15:06:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="760779484"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="760779484"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2022 15:06:02 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 60FDD580BF0;
        Wed, 28 Dec 2022 15:06:02 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v1] platform/x86: intel/pmc/core: Add Meteor Lake mobile support
Date:   Wed, 28 Dec 2022 15:05:53 -0800
Message-Id: <20221228230553.2497183-1-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.38.1
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

Add Meteor Lake mobile support to pmc core driver. Meteor Lake mobile
parts reuse all the Meteor Lake PCH IPs.

Cc: David E Box <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index f1d802f6ec3f..3a15d32d7644 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1029,6 +1029,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          mtl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
 	{}
 };
 

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.38.1

