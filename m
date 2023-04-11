Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC36DD36A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjDKGu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjDKGuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:50:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A1C40C6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195803; x=1712731803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoxeI8nGmhipdmhbf/hPatJykHf7P/Wr8q6XOawTXGM=;
  b=CoH5ldwtPZlPsq7JtPndgdle83aQ/P1RObsbKMqcXrS4Yd5YdT8nZ816
   5o3YebNu/7KbDLlNydz3TFtGlRK3cEo+5ffopPBx9gjOfVfdWYJRXe0QA
   0OY3+5qotXpZgvPUNC7Bis2oeiVnGRUnlX4A0ERriBknminZQeGaSBG6o
   TFfA2+4Ij4sCjrNoUSznP6Fmr2jr9n+6LLnSrrb1SVM5yJMTFK7srP2T6
   7cFL+5MiqVZ1Srq5G2WEiNzZ+SPUQ8GUg3pp8FXyMQ4tg7dx7kYjLKR2h
   qWjkFS8v01V5IwYToQlAQDUlY6WI28t9RxAMJ3npaL8+G1m+B1pGP7pNX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028616"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256633"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256633"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:37 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
Date:   Tue, 11 Apr 2023 14:48:11 +0800
Message-Id: <20230411064815.31456-14-baolu.lu@linux.intel.com>
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

VT-d iotlb cache invalidation request with unexpected type is considered
as a bug to developers, which can be fixed. So, when such kind of issue
comes out, it needs to be reported through the kernel log, instead of
halting the system. Replacing BUG_ON with warning reporting.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-4-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c4847a5aaf52..dd61bb554aa7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1272,7 +1272,9 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
 			| DMA_CCMD_SID(source_id) | DMA_CCMD_FM(function_mask);
 		break;
 	default:
-		BUG();
+		pr_warn("%s: Unexpected context-cache invalidation type 0x%llx\n",
+			iommu->name, type);
+		return;
 	}
 	val |= DMA_CCMD_ICC;
 
@@ -1308,7 +1310,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 		val_iva = size_order | addr;
 		break;
 	default:
-		BUG();
+		pr_warn("%s: Unexpected iotlb invalidation type 0x%llx\n",
+			iommu->name, type);
+		return;
 	}
 	/* Note: set drain read/write */
 #if 0
@@ -1483,7 +1487,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain_id_iommu(domain, iommu);
 
-	BUG_ON(pages == 0);
+	if (WARN_ON(!pages))
+		return;
 
 	if (ih)
 		ih = 1 << 6;
-- 
2.34.1

