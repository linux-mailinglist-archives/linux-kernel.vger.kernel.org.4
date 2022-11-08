Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB23620A83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiKHHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiKHHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543CC186EB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893274; x=1699429274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GHxYMywiMujCB0fUw9PW3w8rIrm70fPSsLe09FLp9ik=;
  b=BIcrlx8fzp4TyEaSc0QMTBA09snh/cTMhkE3YANHBnugAdiGunxPG66n
   KhEvuPO2pSEeHu0Z3a5guB4Rglmuh3ciA+kOPwxpt3NFV/+m/ff+iPjmp
   p6wkR79hE5f0cbVE2Ja5EXyVsuM8DhY0Ui3eR4t87sZiQKsBRainuatFI
   2TXbasAE1E2cKlGfF14bqw41yUIsCN2DgLMZ+BxQ6w7AuoFuLyFe+XUz+
   7mETf9yE0Ux5wy1oh0t3w1GusWcwlb2XjDQ8Mlsm+8nLbxCwyrv/lHTSd
   Su10A5aALscsECppevPwq1e1ErodAx2eN0QkgT0rQbt2IkcbdEwoMWru1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="309339867"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="309339867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821842"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821842"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:03 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
Date:   Tue,  8 Nov 2022 15:34:02 +0800
Message-Id: <20221108073408.1005721-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
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

The PCI subsystem triggers WARN() if a feature is repeatedly enabled.
This improves iommu_enable_pci_caps() to avoid unnecessary kernel
traces through checking and enabling. This also adds kernel messages
if any feature enabling results in failure. It is worth noting that
PRI depends on ATS. This adds a check as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 86 ++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bc42a2c84e2a..978cb7bba2e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1401,44 +1401,80 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 static void iommu_enable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
+	int ret;
 
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
-	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
-	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
-	 * reserved, which should be set to 0.
+	/*
+	 * The PCIe spec, in its wisdom, declares that the behaviour of
+	 * the device if you enable PASID support after ATS support is
+	 * undefined. So always enable PASID support on devices which
+	 * have it, even if we can't yet know if we're ever going to
+	 * use it.
 	 */
-	if (!ecap_dit(info->iommu->ecap))
-		info->pfsid = 0;
-	else {
-		struct pci_dev *pf_pdev;
-
-		/* pdev will be returned if device is not a vf */
-		pf_pdev = pci_physfn(pdev);
-		info->pfsid = pci_dev_id(pf_pdev);
+	if (info->pasid_supported && !info->pasid_enabled) {
+		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
+		if (ret)
+			pci_info(pdev, "Failed to enable PASID: %d\n", ret);
+		else
+			info->pasid_enabled = 1;
 	}
 
-	/* The PCIe spec, in its wisdom, declares that the behaviour of
-	   the device if you enable PASID support after ATS support is
-	   undefined. So always enable PASID support on devices which
-	   have it, even if we can't yet know if we're ever going to
-	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
-		info->pasid_enabled = 1;
+	if (info->ats_supported && !info->ats_enabled) {
+		if (!pci_ats_page_aligned(pdev)) {
+			pci_info(pdev, "Untranslated Addresses not aligned\n");
+			return;
+		}
 
-	if (info->pri_supported &&
-	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
-		info->pri_enabled = 1;
+		ret = pci_enable_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret) {
+			pci_info(pdev, "Failed to enable ATS: %d\n", ret);
+			return;
+		}
 
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
 		info->ats_qdep = pci_ats_queue_depth(pdev);
+
+		/*
+		 * For IOMMU that supports device IOTLB throttling (DIT),
+		 * we assign PFSID to the invalidation desc of a VF such
+		 * that IOMMU HW can gauge queue depth at PF level. If DIT
+		 * is not set, PFSID will be treated as reserved, which
+		 * should be set to 0.
+		 */
+		if (ecap_dit(info->iommu->ecap)) {
+			struct pci_dev *pf_pdev;
+
+			/* pdev will be returned if device is not a vf */
+			pf_pdev = pci_physfn(pdev);
+			info->pfsid = pci_dev_id(pf_pdev);
+		} else {
+			info->pfsid = 0;
+		}
+	}
+
+	if (info->pri_supported && !info->pri_enabled && info->ats_enabled) {
+		if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev)) {
+			pci_info(pdev, "PRG Response PASID Required\n");
+			return;
+		}
+
+		ret = pci_reset_pri(pdev);
+		if (ret) {
+			pci_info(pdev, "Failed to reset PRI: %d\n", ret);
+			return;
+		}
+
+		ret = pci_enable_pri(pdev, PRQ_DEPTH);
+		if (ret) {
+			pci_info(pdev, "Failed to enable PRI: %d\n", ret);
+			return;
+		}
+
+		info->pri_enabled = 1;
 	}
 }
 
-- 
2.34.1

