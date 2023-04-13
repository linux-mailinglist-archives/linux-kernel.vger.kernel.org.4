Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518266E05C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDMEID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDMEHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:07:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38A7A85
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358827; x=1712894827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoxeI8nGmhipdmhbf/hPatJykHf7P/Wr8q6XOawTXGM=;
  b=CWmOo0NsEnSuGLhyIkmTHa10WBYbnrRHXhSWq2KrERFusSxZBowISQ8M
   88e3qYTRdJc+Juu33mkJSfhrS6RpGT2ABVUwr3nRkWokg9Yun7GtsP3Eg
   p+aNSpkBGCWpa34BHf9DcEbyMkxmIIp32neFKvZBOQ/nHztN+6QVtPx7R
   4aQuKgXCa1ZLyBGvIk+dLj6jsJvSdbgKp/7/7nhe0agv5lbiqH9zwm46Q
   UC7hFp467kegZJ93Urt56pI8QC5oqncTsqHYip/f2qR/ZSpoIZPW/EBl1
   z1M0ob72BdsIdRIB2f1Xl+DgzRYCZC3CsLc1q9AV9ijpn/En0QAeZp+NC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786640"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786640"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361089"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361089"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:05 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
Date:   Thu, 13 Apr 2023 12:06:41 +0800
Message-Id: <20230413040645.46157-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

