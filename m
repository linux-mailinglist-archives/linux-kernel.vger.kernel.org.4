Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC88699582
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjBPNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBPNQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:16:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A95354B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553406; x=1708089406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q4t6DQ3FZM/W5yMNCkd2+Emh3Kq12Ff5P8dXSp0yfmQ=;
  b=Uxt5voOevKGx+j1MWKBGB+Vzk76dMJK2ZC3cYiZhfuSGt9hxnHEGWs0h
   fdhd80CKsb8n/gsRqBg+S0agLCfELy5QETMKCh2woGMQbbBz+SIOe+kv3
   oNCBBIClo17qFSVmL43KlqZSK1vu9lluETe7GYGE0r51YSIq52oOSspCP
   YR1oOGeTWyOF6mZq/n+wRP6Gv/+rCNeaqNHZ1jaj5NR2kCkp4MkvyDRDT
   WlsJEHTvgdxNS1bwzcJi1DacIx0+yeZ/qHH2efBoL/84KftHFgycDV16U
   9Miaj6PefBNnyxL/BOBQqb2pUjfjWLVV07uzIyPfC+z1cbk4iQ9lY88Ps
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883307"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674936"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674936"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:44 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Avoid superfluous IOTLB tracking in lazy mode
Date:   Thu, 16 Feb 2023 21:08:14 +0800
Message-Id: <20230216130816.151824-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216130816.151824-1-baolu.lu@linux.intel.com>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Intel IOMMU driver implements IOTLB flush queue with domain selective
or PASID selective invalidations. In this case there's no need to track
IOVA page range and sync IOTLBs, which may cause significant performance
hit.

This patch adds a check to avoid IOVA gather page and IOTLB sync for
the lazy path.

The performance difference on Sapphire Rapids 100Gb NIC is improved by
the following (as measured by iperf send):

w/o this fix~48 Gbits/s. with this fix ~54 Gbits/s

Cc: <stable@vger.kernel.org>
Fixes: 2a2b8eaa5b25 ("iommu: Handle freelists when using deferred flushing in iommu drivers")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/r/20230209175330.1783556-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 994dffa1db57..ce36a16efc97 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4346,7 +4346,12 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
-	iommu_iotlb_gather_add_page(domain, gather, iova, size);
+	/*
+	 * We do not use page-selective IOTLB invalidation in flush queue,
+	 * so there is no need to track page and sync iotlb.
+	 */
+	if (!iommu_iotlb_gather_queued(gather))
+		iommu_iotlb_gather_add_page(domain, gather, iova, size);
 
 	return size;
 }
-- 
2.34.1

