Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55416E05C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDMEIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDMEHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:07:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFF6E94
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358828; x=1712894828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8EBKPy48sTV6ZkkN0Av9i1KZOvW3Gj5TdFWIOX431s=;
  b=La9rb1j1U9Fjk1IIa+s5RBcchJpsJN8unbEfurOLnEtKDu86pej4lxQH
   6rCUrj5MmcKP1QHrDH9/h5MtIuLjQyjXc4hRRl4/aHrqJv2FtX6NUxwgF
   IZjWTqZTEkFcoonXkLoOdUPzbH+X9Q+vC5/RAGeoOKlthTYc5gDcsOg5J
   K1q2LEOuzi0V17UZDoXc7pJzpA+5+zs4jjAD8caWYpd4Bf4bgLgXERewd
   0V05AcftmHS9xramBF92hTYJh2gUzV2STiZKf7SG06VZkUdwrMWZw1R/V
   cDPNxbJQRFp5f+CjXkiNxxXfnCysz5Gc6VFXEqerNGcZMjpZtyniAGfdM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786648"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786648"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361101"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361101"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:06 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Date:   Thu, 13 Apr 2023 12:06:42 +0800
Message-Id: <20230413040645.46157-15-baolu.lu@linux.intel.com>
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

