Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801326A515A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjB1Cm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1CmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:42:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7028D3E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677552141; x=1709088141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A0CRrdLyu+AkROlOaV6sxjn4YAoa5LBpAtnl3pAoGX8=;
  b=T631mDimijDQTmeZ0aRqjVg6B2lLQWh99jZtCugdALht7WpMLRuZ+vwn
   g3ubAJV2Ys8ZztbzlU3m2Gf/OnEaKOvBA7apMQZYnZG7xOCc1o+6Wpotu
   F7M22bP2sC2SKZEYFO1Sx+w0a3alpLzO7T1HSQyQF4fCRLaB+xP2YOb+c
   aQ8oDylzQVKgq40wpxQ9Lias3ENGrhnqZrWJttcFgNIdYhIbwYa/VvKid
   2Y92YYzqFzjeaEuP2SvaTJgGc5Cog2mp93QGKhlg7AsqdqlvJLzAWnvJY
   QdOVCtdyz9msSTrrzpkruo5VOs6Hbrae0dmEpL1HsTH3s04byJFG9qHlh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322278097"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="322278097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 18:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="673963809"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="673963809"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2023 18:42:18 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete devices
Date:   Tue, 28 Feb 2023 10:33:41 +0800
Message-Id: <20230228023341.973671-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In normal processing of PCIe ATS requests, the IOMMU performs address
translation and returns the device a physical memory address which
will be stored in that device's IOTLB. The device may subsequently
issue Translated DMA request containing physical memory address. The
IOMMU only checks that the device was allowed to issue such requests
and does not attempt to validate the physical address.

The Intel IOMMU implementation only allows PCIe ATS on several SOC-
integrated devices which are opt-in’ed through the ACPI tables to
prevent any compromised device from accessing arbitrary physical
memory.

Add a kernel option intel_iommu=relax_ats to allow users to have an
opt-in to allow turning on ATS at as wish, especially for CSP-owned
vertical devices. In any case, risky devices are not allowed to use
ATS.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 drivers/iommu/intel/iommu.c                     | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..490fae585f73 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2075,6 +2075,12 @@
 			Note that using this option lowers the security
 			provided by tboot because it makes the system
 			vulnerable to DMA attacks.
+		relax_ats
+			By default, the Intel IOMMU implementation only allows
+			ATS to be enabled on certain devices. The platform
+			advertises its allowed devices in ACPI tables like SATC
+			and ATSR. With this option, this ATS requirement is
+			relaxed so that discrete PCI devices can also use ATS.
 
 	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
 			0	disables intel_idle and fall back on acpi_idle.
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..4f6c6d8716bd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -290,6 +290,7 @@ static int dmar_map_gfx = 1;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
 static int iommu_skip_te_disable;
+static int iommu_relaxed_ats;
 
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
@@ -349,6 +350,9 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			pr_info("Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
+		} else if (!strncmp(str, "relax_ats", 9)) {
+			pr_info("ATS reqirement is relaxed\n");
+			iommu_relaxed_ats = 1;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
@@ -3557,6 +3561,9 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 	struct dmar_atsr_unit *atsru;
 	struct dmar_satc_unit *satcu;
 
+	if (iommu_relaxed_ats && !dev->untrusted)
+		return 1;
+
 	dev = pci_physfn(dev);
 	satcu = dmar_find_matched_satc_unit(dev);
 	if (satcu)
-- 
2.34.1

