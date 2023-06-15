Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21473106F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbjFOHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbjFOHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:20:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D8270A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686813532; x=1718349532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tv0xInhDNZvIGN29/qg5JZUQvfOAzDkVJk+y8zR9+Z0=;
  b=ZjE8i8W5fRSYFplo7odk277vLPw/NRW+H+Cg0bltmmU6YvIoa+B2nV6z
   HodB+9+nZRCpCSFkwTo7SyybDL1vvpbxXeD7ZDSRw88S5vJPJPGP5luyN
   Rbp8jjA/5EjQPHW0vCxkPd7E7PruPItMMao9OitTst5rjrSYbkNDK/7yp
   Xu6MQaczsHrg8YmR9MTmffUKsgLsWb4v1imMtyt5+r+Bb2YmkTOucMtGs
   guDVeococ+8h7VMb2jNsN5NmJ+XYZfbHpO1HwWJItf5XlO0grmoPALOGq
   Wl1EeJGAL0LFlHim7BxDEtybz+Ml4zTIQ4VonP4x7Yf2DkX6S7QG3mdmY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339183070"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="339183070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 00:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="706544678"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="706544678"
Received: from tower.bj.intel.com ([10.238.157.62])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 00:18:49 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Date:   Thu, 15 Jun 2023 15:16:13 +0800
Message-Id: <20230615071613.690639-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even the PCI devices don't support pasid capability, PASID
table is mandatory for a PCI device in scalable mode. However
flushing cache of pasid directory table for these devices are
not taken after pasid table is allocated as the "size" of
table is zero. Fix to assign it with a page size.

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/pasid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..bde7df055865 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -115,7 +115,9 @@ int intel_pasid_alloc_table(struct device *dev)
 				  intel_pasid_max_id);
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
-	order = size ? get_order(size) : 0;
+	if (!size)
+		size = PAGE_SIZE;
+	order = get_order(size);
 	pages = alloc_pages_node(info->iommu->node,
 				 GFP_KERNEL | __GFP_ZERO, order);
 	if (!pages) {
-- 
2.34.1

