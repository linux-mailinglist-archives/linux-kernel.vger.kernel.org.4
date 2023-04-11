Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF966DD36C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjDKGvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjDKGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:50:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43A40C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195807; x=1712731807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INsqM7kHCgplauDTVYgaDtYvmiBKWDtVPT9hnQCqHlE=;
  b=ZhKohr+JvuvXqI4h2urTfshrnA4wkEzkBZIPER09sseMaazD4y28Tin1
   +T4CucQYtXn1dMGvqqB0aKYvhxERtUNG08cpfbacqnw5CA+LauXS2Eb6D
   C/kN4mTufWrGIci7Mza1dasMlbG+0Rdzr/pCp8baE6zrTFESlGNdB9/4z
   honY5Bie/aR7eTDeC8xXQTAk6JTZJZ8qRO87PakJMXjzwSLpE4LBP75cV
   jEeiRa8MysKZvtLVomwvarChfGHfJH74TkVi+HBcU4UlBLWMMu3BzP3lQ
   yk4Gg4rVP7C8nVUj2/6Strhuzh3NfRZhIDM8Nzc7gS8fhfgtYeoJYAT+l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028628"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028628"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256651"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256651"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:42 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] iommu/vt-d: Remove BUG_ON in map/unmap()
Date:   Tue, 11 Apr 2023 14:48:13 +0800
Message-Id: <20230411064815.31456-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tina Zhang <tina.zhang@intel.com>

Domain map/unmap with invalid parameters shouldn't crash the kernel.
Therefore, using if() replaces the BUG_ON.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-6-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f11347a590d7..ab21ef1ddb3c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2159,7 +2159,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	phys_addr_t pteval;
 	u64 attr;
 
-	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
+	if (unlikely(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1)))
+		return -EINVAL;
 
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
@@ -4314,8 +4315,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
-	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
-			       GFP_ATOMIC));
+	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
+				     &level, GFP_ATOMIC)))
+		return 0;
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
-- 
2.34.1

