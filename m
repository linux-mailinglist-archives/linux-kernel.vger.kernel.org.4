Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFD5E70DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiIWAs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiIWAsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:48:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A638115F65
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894091; x=1695430091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PnmH4tiC7HuVSl3cVloykZSS5RyOXcfcPLxPjpvq+kQ=;
  b=Xq4usZSTFJ/c2DTwnYJ6hEZ9F1YC81mrdNVvRT3FwIj8ziZPyiLOact7
   AmB65soRNFY3AOSfTxVsnPjQNbdqSy81Kkj8cVROeomfM5vSd1dxWSYtj
   g9iVIcHFB71bIvA8cc65z40BI/hp/DG0UWO636noCE6K9QVsP3hEudQDw
   enIqb3MxfbU5y+aRFFs0JbS3EHbX5K2JdTidoxG5QZDJniVovp9fm2mCh
   kj5UHWjnmAmX2/OaAxUiUXBuZb0gjuHaYGbxGyC8we6lqBPGj+1vCN/Gm
   T7Lne48JiRdW2mxKrSjOT5HB/5WgHXPWsgdomDOYwtEiexBpJnapNOpPo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278876"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650760001"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
Date:   Fri, 23 Sep 2022 08:42:05 +0800
Message-Id: <20220923004206.3630441-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
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

Some VT-d hardware implementations invalidate all interrupt remapping
hardware translation caches as part of SIRTP flow. The VT-d spec adds
a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
11.4.2 in VT-d spec) capability bit to indicate this.

The spec also states in 11.4.4 that hardware also performs global
invalidation on all interrupt remapping caches as part of Interrupt
Remapping Disable operation if ESIRTPS capability bit is set.

This checks the ESIRTPS capability bit and skip software global cache
invalidation if it's set.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220921065741.3572495-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h         | 1 +
 drivers/iommu/intel/irq_remapping.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 99cc75ecac63..bddf6c69587d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -146,6 +146,7 @@
 /*
  * Decoding Capability Register
  */
+#define cap_esirtps(c)		(((c) >> 62) & 1)
 #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
 #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 2e9683e970f8..5962bb5027d0 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -494,7 +494,8 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 	 * Global invalidation of interrupt entry cache to make sure the
 	 * hardware uses the new irq remapping table.
 	 */
-	qi_global_iec(iommu);
+	if (!cap_esirtps(iommu->cap))
+		qi_global_iec(iommu);
 }
 
 static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
@@ -680,7 +681,8 @@ static void iommu_disable_irq_remapping(struct intel_iommu *iommu)
 	 * global invalidation of interrupt entry cache before disabling
 	 * interrupt-remapping.
 	 */
-	qi_global_iec(iommu);
+	if (!cap_esirtps(iommu->cap))
+		qi_global_iec(iommu);
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
-- 
2.34.1

