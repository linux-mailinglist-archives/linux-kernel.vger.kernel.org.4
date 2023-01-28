Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21E67FAB5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjA1UE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjA1UEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:04:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF12528F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936274; x=1706472274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/6p+lUBUIA2oZrnZvhOAPE95Uoj/IOijy7wsmhLAB0=;
  b=mMIAl8mV1zBemt5vIVf09U57oyCJx3GiUbiTcfMNy4Cz+cMTgAadrE7j
   JCtZIXBt2W6cV/XXs4Rtky6Q6XFrxgKffAgoUble/kmEU5j/DQEDfn4Am
   FHB6HgF3GP1FGN7GHKCnM93DRL9OPbWGMzwIOWXZOro9TKSqq1kTbJz2C
   wu+3zx85tmWvMqSlCPGV53qp/CwPspZQ/tqBo2emxJuuC+3qn/+1Edblt
   tEQrg8WBWmPRAaka0Vf0O40kazGC6unaofJVp9/dx5bTg6ve1sSVw/M/x
   Kst+q0OaL9Xkc6JJY3PUHTj419h3+IqVXPiMNWSr7L5VFlMwX8phZX0gk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022531"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022531"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038382"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038382"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:31 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 7/7] iommu/vt-d: Enable IOMMU perfmon support
Date:   Sat, 28 Jan 2023 12:04:28 -0800
Message-Id: <20230128200428.1459118-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230128200428.1459118-1-kan.liang@linux.intel.com>
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
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

Register and enable an IOMMU perfmon for each active IOMMU device.

The failure of IOMMU perfmon registration doesn't impact other
functionalities of an IOMMU device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 3 +++
 drivers/iommu/intel/iommu.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 43db6ebe8b57..6acfe879589c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1144,6 +1144,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		err = iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
 		if (err)
 			goto err_sysfs;
+
+		iommu_pmu_register(iommu);
 	}
 
 	drhd->iommu = iommu;
@@ -1166,6 +1168,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 static void free_iommu(struct intel_iommu *iommu)
 {
 	if (intel_iommu_enabled && !iommu->drhd->ignored) {
+		iommu_pmu_unregister(iommu);
 		iommu_device_unregister(&iommu->iommu);
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9221960e310..6a80d3848626 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -29,6 +29,7 @@
 #include "../iommu-sva.h"
 #include "pasid.h"
 #include "cap_audit.h"
+#include "perfmon.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -4013,6 +4014,8 @@ int __init intel_iommu_init(void)
 				       intel_iommu_groups,
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+
+		iommu_pmu_register(iommu);
 	}
 	up_read(&dmar_global_lock);
 
-- 
2.35.1

