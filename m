Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383175BF6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIUHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIUHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:03:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482A7E805
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663743821; x=1695279821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VLf2RXUYKKOmZoPjWdX8Te/gPeu4nHe4ezJN9Uc4fRI=;
  b=hYtJqUFwwKQhfak4vbjjJQDSSvT+30352JAhL2df2JFiLp0yRU8K66Wd
   yen30cxXZSVBxEVGiroW5SykiYWKz9fMaeKO+uU1HMU4PjJQzTu9mtwNR
   u93HUEuMmhPKJQnJ8StqWLNiz2XAtjw6zYrg5F726hlh6kK54mk9ZHgIS
   Rto/M1l5QhKhOtbv6+agLsWZm5E8i2bCryUHvsEG/WGA6x/ivHTU8syBk
   KeeJyqr6Hf5WZzl7JL8iCjXLpN4p2RkQgv18rOqhKgATa9AVBff3tdoic
   JPn8wMTDerEvz0fIyd/2MfckGcmQ2zeeAeuOgPc8CU7PIDROgWSQ+m8El
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282967929"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="282967929"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 00:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="681648663"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2022 00:03:38 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
Date:   Wed, 21 Sep 2022 14:57:41 +0800
Message-Id: <20220921065741.3572495-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
---
 drivers/iommu/intel/iommu.h         | 1 +
 drivers/iommu/intel/irq_remapping.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

Change log:

v2:
 - Add ESIRTPS check in iommu_disable_irq_remapping() path as well.

v1: https://lore.kernel.org/r/20220919062523.3438951-2-baolu.lu@linux.intel.com

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

