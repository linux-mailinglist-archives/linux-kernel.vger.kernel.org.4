Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC955BC2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiISGb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:31:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DF017A94
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663569084; x=1695105084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NjjJDzk3PCTN6zCJqZ/fLOxb+/E/7A+Bi6Uyy86kecA=;
  b=mX4onGwOrvxPg2JuXKpXGJz+uQ/TTOnSrHIIXQ0Ga+v1bR3MOWLgT2OV
   swH/4kTLJLixkZbDjl7VkVkPARsFazGrdC3ZT+nuAeKUgydexTel8Q4fO
   +9+fiAPfylJb3rEfKWm6g4ejPeHuNPfAxOfgOiQH8iwDPWgROVOfnKCoT
   nkBMu+9g2LD/KkLasBJEzU9Lfm+XjDsRDEVY4hEk74qh79E3lFij67v3m
   bFjGjcilVs296TQuNTO98J96SLZTvqq9HIoKkp2IU5g5tIFr821WF8Gpg
   ozKt5qucZS6olKgQrAN8lDaHv9EJUDy/7RydjycwbfsIb+Hcwk63l3IhC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="279699708"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279699708"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="680715161"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2022 23:31:22 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
Date:   Mon, 19 Sep 2022 14:25:22 +0800
Message-Id: <20220919062523.3438951-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
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
11.4.2 in VT-d spec) capability bit to indicate this. With this bit set,
software has no need to issue the global invalidation request.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h         | 1 +
 drivers/iommu/intel/irq_remapping.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index eef1a166b855..5407d82df4d1 100644
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
index 2e9683e970f8..b4a91fbd1c2f 100644
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
-- 
2.34.1

