Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E474A87C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGGBfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGGBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:35:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61751BFC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693709; x=1720229709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfdYLppNc9eLDWu4uhQ6N/Y+k4M58Rts/UgDTo8w0sg=;
  b=nubovSnnAYjxeAk/5Effg9ptGHCTnHx0xH1eRB6LtoUUs0h6pLiSIq7+
   3ekT+u8MTk8pOhVdMIh4/zJrENAhX0ggFDS0N7Jz8kNNK79c1e6HuuvI5
   8BSpsaS6KP/gLRTsgKTtpX5oY6PjpAKKF3jxYJzBKquBiidCJ1wfxrDtf
   XxCV7d/N92YdMWIbVxDPj5rkW5oSFEGCL5ZcGZLBqyTPnyBec7SVq6fb6
   fKcOSq+lFjg0KxVvovXzqF4OB2PZT/itAU6comSL3uyGD/M3gtSLPr62b
   CaynUUMwvvUDynEa2iVxK3n8G0AGfNgDNwz7uzneHc7Hc0DD0SJ2tK+6n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832273"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791324"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791324"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:05 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 3/6] iommu: Introduce struct iommu_mm_data
Date:   Fri,  7 Jul 2023 09:34:38 +0800
Message-Id: <20230707013441.365583-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707013441.365583-1-tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sva domain 1:1 with mm pasid, mm needs to keep reference to the
sva domain as well as keeping the information of mm pasid. Introduce
struct iommu_mm_data to wrap the information up.

When a process is created, the mm pasid is initialized as IOMMU_PASID_
INVALID. The default_iommu_mms is introduced to initialize an mm pasid
with that default value.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu.c | 2 ++
 include/linux/iommu.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b4..35fa1c1b12826 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -83,6 +83,8 @@ static const char * const iommu_group_resv_type_string[] = {
 	[IOMMU_RESV_SW_MSI]			= "msi",
 };
 
+struct iommu_mm_data default_iommu_mm = { IOMMU_PASID_INVALID, NULL };
+
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
 #define IOMMU_CMD_LINE_STRICT		BIT(1)
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d39e647219eb8..20135912584ba 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,8 @@ struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
 
+extern struct iommu_mm_data default_iommu_mm;
+
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
 #define IOMMU_FAULT_WRITE	0x1
@@ -664,6 +666,11 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
+struct iommu_mm_data {
+	u32                     pasid;
+	struct iommu_domain     *sva_domain;
+};
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- 
2.34.1

