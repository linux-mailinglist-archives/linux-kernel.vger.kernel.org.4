Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452BE5EA93E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiIZOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiIZOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:54:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296692F6B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198497; x=1695734497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PnmH4tiC7HuVSl3cVloykZSS5RyOXcfcPLxPjpvq+kQ=;
  b=A3tOQeBjOeGLoiuSRLVMlamGyB4zdVsxuysajFepogFy3BugtclK6w2u
   6y8cy60V8iOOzdGMTnSIgYvAcymMw27ucQfp87W9X+IJyQAyETa+b4mhT
   uX1dZjbUEndiJcNWC0HynrlE3AysNMHsG7uxbC8tdh2RYEUw1+NGI2DL+
   q28wa5Kg2zjgIfICE/jhQVz+KQtAMwnlzTETe/ZOElWO73caKVaNRk1/5
   13HoQxPSt3Nj/SXCcgCZWzV124JDkvZ3QjUPDHejQ33b+rO0UmkOQK/1t
   w6W3tWcl3Z/IhmpZ9b/cfDQEgt+F8cNHdyFrzkvkLhUzFZvLm8qDJDkyV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280750312"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="280750312"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525678"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525678"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:36 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
Date:   Mon, 26 Sep 2022 21:15:28 +0800
Message-Id: <20220926131529.4045281-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
References: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

