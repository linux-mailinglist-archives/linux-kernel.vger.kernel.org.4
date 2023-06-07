Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F5727334
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjFGXja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjFGXjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:39:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255612115;
        Wed,  7 Jun 2023 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686181155; x=1717717155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+5v16ekd4mpMdaitluJiCwSxF+P8KWqlxIOWs7E2XU=;
  b=m5Ykuvsya0tthuO1WIvfngfTcovTsCH4E95bQ+OuiCKJc8gsq4h7sE4p
   MZi2BiekztJEgjwvm6uYJgxcz2QgurWmfjUnDiLwT/oI1QeFl5lU5j/6K
   QDawhNNlScIkYK7mVcaFQz5RhITcMMedxjtNuB8gNXruqQ+2cs0a4eI88
   K6I63YP9nbfWTjhIlNc+oY72c3eQr9sbTp+WDV9v0+l7HDexwSmvh16OM
   h4KBtbEalFV/EXStaIOxxwPWda6j6p1okvNiOVoUq2jUaa+6DwJ/WWqVJ
   eiXjmV1tvl+eVzrXUBKElMHMm7KLRfjd2awaYbcHsa4yvnL5uckS94WUn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="354631549"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="354631549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 16:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739461206"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="739461206"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2023 16:38:50 -0700
Received: from debox1-desk4.intel.com (unknown [10.251.3.221])
        by linux.intel.com (Postfix) with ESMTP id 605AF580D26;
        Wed,  7 Jun 2023 16:38:50 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     david.e.box@linux.intel.com, markgross@kernel.org,
        hdegoede@redhat.com, irenic.rajneesh@gmail.com,
        ilpo.jarvinen@linux.intel.com, xi.pardee@intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH V2 2/2] platform/x86/intel/pmc/mtl: Put devices in D3 during resume
Date:   Wed,  7 Jun 2023 16:38:49 -0700
Message-Id: <20230607233849.239047-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607233849.239047-1-david.e.box@linux.intel.com>
References: <20230607233849.239047-1-david.e.box@linux.intel.com>
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

An earlier commit placed some driverless devices in D3 during boot so that
they don't block package cstate entry on Meteor Lake. Also place these
devices in D3 after resume from suspend.

Fixes: 336ba968d3e3 ("platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - rename mtl_fixup to mtl_d3_fixup. Call it from new mtl_resume
     function, followed by the common resume. Suggested by Ilpo.

 drivers/platform/x86/intel/pmc/mtl.c | 29 ++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index e8cc156412ce..2b00ad9da621 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -68,16 +68,29 @@ static void mtl_set_device_d3(unsigned int device)
 	}
 }
 
-void mtl_core_init(struct pmc_dev *pmcdev)
+/*
+ * Set power state of select devices that do not have drivers to D3
+ * so that they do not block Package C entry.
+ */
+static void mtl_d3_fixup(void)
 {
-	pmcdev->map = &mtl_reg_map;
-	pmcdev->core_configure = mtl_core_configure;
-
-	/*
-	 * Set power state of select devices that do not have drivers to D3
-	 * so that they do not block Package C entry.
-	 */
 	mtl_set_device_d3(MTL_GNA_PCI_DEV);
 	mtl_set_device_d3(MTL_IPU_PCI_DEV);
 	mtl_set_device_d3(MTL_VPU_PCI_DEV);
 }
+
+static int mtl_resume(struct pmc_dev *pmcdev)
+{
+	mtl_d3_fixup();
+	return pmc_core_resume_common(pmcdev);
+}
+
+void mtl_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &mtl_reg_map;
+	pmcdev->core_configure = mtl_core_configure;
+
+	mtl_d3_fixup();
+
+	pmcdev->resume = mtl_resume;
+}
-- 
2.34.1

