Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AA728FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjFIGGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:06:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C613D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686290779; x=1717826779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCUTHnlZlVar+pAAYPKyf+GGBotLIiPQRNKzfWEppzc=;
  b=aeZ3SGhR3WpRihEYYh7FHsTfd7VxtMb7h8QeyiqicqgfuLGtasZqLtWG
   Ps00el0oOCzeydVUgO66+qDqJxVXyg2ZyIvqwjhPtti8DL1rID3D1tjLN
   xc3Uo1lcx8Z9fVMEVR2LJLQBpCyY/EoazH/2yPzW0RaIfM+Jcosms37cq
   jU7SG5C+robRrJLFHb4H1mYYXL1jvTao3fy1A5UA5YwTrhob+mE18+kTA
   51h43atIBB5/qUZdRXkg7sp6pF40Cm8LA3SBt1CEaawvAVi7KW1UJcimc
   8IxbM5Dl/CRn8QtZMC9A032osxq+SzkkINSt0cttEB7dnhc+H3PjOwK6W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360881589"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="360881589"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 23:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660652218"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660652218"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2023 23:06:17 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove commented-out code
Date:   Fri,  9 Jun 2023 14:05:14 +0800
Message-Id: <20230609060514.15154-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

These lines of code were commented out when they were first added in commit
ba39592764ed ("Intel IOMMU: Intel IOMMU driver"). We do not want to restore
them because the VT-d spec has deprecated the read/write draining hit.

VT-d spec (section 11.4.2):
"
 Hardware implementation with Major Version 2 or higher (VER_REG), always
 performs required drain without software explicitly requesting a drain in
 IOTLB invalidation. This field is deprecated and hardware  will always
 report it as 1 to maintain backward compatibility with software.
"

Remove the code to make the code cleaner.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4c0b7424c45e..e5c111ff4dd9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1312,15 +1312,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 			iommu->name, type);
 		return;
 	}
-	/* Note: set drain read/write */
-#if 0
-	/*
-	 * This is probably to be super secure.. Looks like we can
-	 * ignore it without any impact.
-	 */
-	if (cap_read_drain(iommu->cap))
-		val |= DMA_TLB_READ_DRAIN;
-#endif
+
 	if (cap_write_drain(iommu->cap))
 		val |= DMA_TLB_WRITE_DRAIN;
 
-- 
2.34.1

