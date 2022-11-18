Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A936562F62C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiKRNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbiKRNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:32:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13C8CFF9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668778327; x=1700314327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3N4DyWbeBDCa+FLrMLNNfYvJtPvTOl1G3Lt5mdCGbBQ=;
  b=gCe18jaqWwql0p8WpRM3QzDU0/bSKkokqll5fynT+9kVtjYUvruO6q6n
   S+mNIjn4rIwDTMaWyweCyUImHEOZni5+1/3hg+S5jm0lTJO9Y1C745uLM
   DzHuppfBPMNnYs8lw7REOG4Va3qJio4ncAxEAsI1RBS9tn6pG6Kjjl5/Z
   HXEYKukP8Mr/XpwuBhzXrEj7rWpkRV8O2fCrEM/gnkNfxctfZbzgmCU4l
   gpazdAC24B9LWB2SwyYEvTUSfASxPdFdFh3Hrv00URlFDJxP2jjTJHKOb
   H8+EcGXTgLzv2CObXvPU6zBSPqcO3ZrYSvMiXHbRtpXPQ0DcVP2Nq24G/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314285085"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="314285085"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642511983"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642511983"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 05:32:04 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/7] iommu/vt-d: Some cleanups
Date:   Fri, 18 Nov 2022 21:24:44 +0800
Message-Id: <20221118132451.114406-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi,

This series includes some cleanups in the Intel IOMMU implementation
after the IOMMU core implemented the blocking domain. The cleanup work
is mainly in the attach_dev/device_probe/device_release paths.

Please help to review.

Best regards,
baolu

Change log:
v4:
 - Drop the change of "Fold dmar_remove_one_dev_info() into its caller"
   in order to avoid an inextricable ordering problem.

v3:
 - https://lore.kernel.org/linux-iommu/20221114014049.3959-1-baolu.lu@linux.intel.com/
 - Disable PCI capabilities (PASID/ATS/PRI) when there's no domain
   attached to the device.

v2:
 - https://lore.kernel.org/linux-iommu/20221108073408.1005721-1-baolu.lu@linux.intel.com/
 - Reorder the patches to make the device_block_translation() work with
   the existing path first.
 - Add a new patch to improve iommu_enable_pci_caps().

v1:
 - https://lore.kernel.org/linux-iommu/20221103055329.633052-1-baolu.lu@linux.intel.com/

Lu Baolu (7):
  iommu/vt-d: Allocate pasid table in device probe path
  iommu/vt-d: Add device_block_translation() helper
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Rename iommu_disable_dev_iotlb()
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 ++--
 drivers/iommu/intel/iommu.c | 169 ++++++++++++++++++------------------
 2 files changed, 90 insertions(+), 94 deletions(-)

-- 
2.34.1

