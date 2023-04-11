Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7964F6DD36B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjDKGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDKGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:50:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0340FB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195806; x=1712731806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8EBKPy48sTV6ZkkN0Av9i1KZOvW3Gj5TdFWIOX431s=;
  b=NJ7+aF/Ko46KeXHGCNniHLhGa0y4cNbYp3EM0cM60iB9owfAecD65g1h
   c++gpGjNZjN//F222LPSwh/p5WqEyNK/AXyrJ6UMq1SWDEM+y0WyrXz2H
   awRmcav2I0cFu/GVSIk5/w8YsAekenKruCJigr5BQjS9dCAlvkF0bi4Cc
   XAXeLMmTSzlF7tyMs74HzV/JtEPFQzUxnkYC06D8Da/105hc3fzKVAWWC
   5ygkjal+j08JysmoLo4nPpbIwajuLjZm7orDm8mciEDg3Ck0Q3w3aSCce
   mPK0GmjYoOtj23aFp+FaDy3PRIDQuLdF9LzrWxGwk5XGCv0iZRP1bgwg3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028622"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028622"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256637"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256637"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:40 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Date:   Tue, 11 Apr 2023 14:48:12 +0800
Message-Id: <20230411064815.31456-15-baolu.lu@linux.intel.com>
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

When performing domain_context_mapping or getting dma_pte of a pfn, the
availability of the domain page table directory is ensured. Therefore,
the domain->pgd checkings are unnecessary.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-5-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd61bb554aa7..f11347a590d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -915,8 +915,6 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 	int level = agaw_to_level(domain->agaw);
 	int offset;
 
-	BUG_ON(!domain->pgd);
-
 	if (!domain_pfn_supported(domain, pfn))
 		/* Address beyond IOMMU's addressing capabilities. */
 		return NULL;
@@ -1910,8 +1908,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
-	BUG_ON(!domain->pgd);
-
 	spin_lock(&iommu->lock);
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
-- 
2.34.1

