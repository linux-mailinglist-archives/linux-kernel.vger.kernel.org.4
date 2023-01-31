Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F576825C6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAaHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAaHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:46:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9B3347B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151176; x=1706687176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tIIPqWLDaXi88jATwWGBnjxjewiMTRegyRpE2yrmVj8=;
  b=goPRq4GvmKhle/uq6TIv1tHFD+NjLEn3++E1mehXVl4nbY2yMBg5vMEF
   Yk+VvISIYg8jW89gprvMYXKVF30xOxBv+6wTcM5ZG+Vq74HC8SGEPmT2m
   cdiHw2kzEvFcn0vpfqurkHak7WhJ4oPkQn31R6wfbZNrfWpSAF2Xrgj0u
   75sszs1riRKruyI8nUZNhr6EbyVHr2ns+5nvlGL5hlZQMo2jUQMZa2Uto
   Gosm2lz+/vVdyCPcerF8Hgzkn4FK/nulxuUbUcCpcKKTWJg1Ri1D48ifJ
   jPLCsbbp7I3YsK/ILdtX2l72JTQzR5Y6admiighgV+yE+En52kGC7GGJv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736651"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775587"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775587"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:46:10 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kan.liang@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] iommu/vt-d: Enable IOMMU perfmon support
Date:   Tue, 31 Jan 2023 15:37:40 +0800
Message-Id: <20230131073740.378984-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/r/20230128200428.1459118-8-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index e314c30d371a..691b306fada5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -29,6 +29,7 @@
 #include "../iommu-sva.h"
 #include "pasid.h"
 #include "cap_audit.h"
+#include "perfmon.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -4012,6 +4013,8 @@ int __init intel_iommu_init(void)
 				       intel_iommu_groups,
 				       "%s", iommu->name);
 		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+
+		iommu_pmu_register(iommu);
 	}
 	up_read(&dmar_global_lock);
 
-- 
2.34.1

