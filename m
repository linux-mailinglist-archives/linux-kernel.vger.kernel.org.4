Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3A5E70DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIWAsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiIWAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:48:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A31138D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894092; x=1695430092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjQtsc1TPF/QLcdDDuHGmW2FVH4+p2Iqv7hrj01LmOw=;
  b=Bws3TjGwfa0AOYkUaXsmgIGV8qAOAyF76mBJRjBqf/b6Q2/BwCpy86DH
   2EooNW8ToazqA686y0QsZvoU+f6gUPkh/K8OwEIiigI4rM5x31g4QSgGi
   tbrXqAYHZK8DwZCAdHSQsxspKhqgiW0YIziijkQXA7gqsc7byqMWv1JPc
   M6xAA4Ic3AshKhPuBd8jzmnhCdhWEvZomV9lIYFQJEq+F7H0t9751gaVs
   AUoGjeOVtwPMwnb0djCAFCSAJzx+WjLjDPqaEOaXBZDnKncuaimTLlMHI
   bRfvykpmtdxcM3U3psVyz4kohdknNnpED5ZSUh5NZIU//O0GRpKa8xQVc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278883"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650760011"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:10 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iommu/vt-d: Avoid unnecessary global DMA cache invalidation
Date:   Fri, 23 Sep 2022 08:42:06 +0800
Message-Id: <20220923004206.3630441-7-baolu.lu@linux.intel.com>
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

Some VT-d hardware implementations invalidate all DMA remapping hardware
translation caches as part of SRTP flow. The VT-d spec adds a ESRTPS
(Enhanced Set Root Table Pointer Support, section 11.4.2 in VT-d spec)
capability bit to indicate this. With this bit set, software has no need
to issue the global invalidation request.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220919062523.3438951-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 1 +
 drivers/iommu/intel/iommu.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index bddf6c69587d..92023dff9513 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -146,6 +146,7 @@
 /*
  * Decoding Capability Register
  */
+#define cap_esrtps(c)		(((c) >> 63) & 1)
 #define cap_esirtps(c)		(((c) >> 62) & 1)
 #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 81a449b5cb91..a8b36c3fddf1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1239,6 +1239,13 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 
+	/*
+	 * Hardware invalidates all DMA remapping hardware translation
+	 * caches as part of SRTP flow.
+	 */
+	if (cap_esrtps(iommu->cap))
+		return;
+
 	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 	if (sm_supported(iommu))
 		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
-- 
2.34.1

