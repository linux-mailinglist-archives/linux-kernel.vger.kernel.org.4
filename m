Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20206DD360
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjDKGtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjDKGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:49:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DAE30DC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195726; x=1712731726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svE7EgjquyhwRZbom4QiBGJ7Mxb0NsfSfLHDW+HF/GA=;
  b=R7lUl7+hfgtUKRkPb+mVoNFLEYJz1jrvgduqPBljUQn8SOtFVfxVhZsO
   N1kIFY4vLMnh9EI+BeVP/rephmy6C6TLMgp+76Z4M8I0SR8c/sR2IkvU4
   boqLANh0m21Qynp/TcWbR4Proir9D/bM3TvENcq0vfB0w/SREGDwloHk6
   fMibS950OEKIGY9besAu7ybygXW+h0Z4L90Jv8qmHxAU+TY3nNY2HlWr0
   dKvMwfcNrEjRpYfiFSW4K37i+PLjf3zyJoQCCbMCSmKKMF73nkRCKxWmz
   Oa5mAIRgVcbwoH9UswUu/lWiylZlmWf9SJUaPKb/OEv9PnMPiXCKxIn16
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028522"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028522"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256558"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256558"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:18 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
Date:   Tue, 11 Apr 2023 14:48:02 +0800
Message-Id: <20230411064815.31456-5-baolu.lu@linux.intel.com>
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

They should be part of the per-device iommu private data initialization.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a6f07c74da2d..6d77b4072fdd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1406,20 +1406,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
-	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
-	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
-	 * reserved, which should be set to 0.
-	 */
-	if (!ecap_dit(info->iommu->ecap))
-		info->pfsid = 0;
-	else {
-		struct pci_dev *pf_pdev;
-
-		/* pdev will be returned if device is not a vf */
-		pf_pdev = pci_physfn(pdev);
-		info->pfsid = pci_dev_id(pf_pdev);
-	}
 
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
 	   the device if you enable PASID support after ATS support is
@@ -1438,7 +1424,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
-		info->ats_qdep = pci_ats_queue_depth(pdev);
 	}
 }
 
@@ -4521,6 +4506,17 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		    dmar_ats_supported(pdev, iommu)) {
 			info->ats_supported = 1;
 			info->dtlb_extra_inval = dev_needs_extra_dtlb_flush(pdev);
+
+			/*
+			 * For IOMMU that supports device IOTLB throttling
+			 * (DIT), we assign PFSID to the invalidation desc
+			 * of a VF such that IOMMU HW can gauge queue depth
+			 * at PF level. If DIT is not set, PFSID will be
+			 * treated as reserved, which should be set to 0.
+			 */
+			if (ecap_dit(iommu->ecap))
+				info->pfsid = pci_dev_id(pci_physfn(pdev));
+			info->ats_qdep = pci_ats_queue_depth(pdev);
 		}
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
-- 
2.34.1

