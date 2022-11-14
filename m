Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEE762743B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiKNBru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiKNBrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:47:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C67DF7C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668390468; x=1699926468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mFSd21UgPyLtwwJWI/qh4eD+vxEwHbQ+QjhXTG1Phco=;
  b=nOvD+HXTAl7C3uIJ4kI0onc2ITPu5YN+sOGO7BZlOHmMnv59AiDrYila
   Q7q4CsGesQKiNiOkgY2W7oJ/7EFwKX7p86Ydco+OjW10JOw1FS1mFOvhz
   wcvn0XX14XGlFHl0Fltp+aFz5NabB4TD1Gvemm9p8beZo389AAlpwz+bn
   V3LX0xj/2N26waSjxTHzNg2C1tuqT2uLrR+dw88s4xvXgRrnrIOiuCCRi
   e/egbdyntRqTUevtzlX+ph/pDDUVZ4B3+BINwmhcTukUtVJmUftCcHRdM
   KTlqau1YD71djej5VLBg3V6JjCrzEDAQTLrd3ZrqIBC/aGmvW3r3YwV3N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313006682"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313006682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 17:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="707124188"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="707124188"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2022 17:47:45 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/7] iommu/vt-d: Some cleanups
Date:   Mon, 14 Nov 2022 09:40:42 +0800
Message-Id: <20221114014049.3959-1-baolu.lu@linux.intel.com>
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
v3:
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
  iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Rename domain_add_dev_info()
  iommu/vt-d: Remove unnecessary domain_context_mapped()
  iommu/vt-d: Use real field for indication of first level

 drivers/iommu/intel/iommu.h |  15 ++--
 drivers/iommu/intel/iommu.c | 172 ++++++++++++++++--------------------
 2 files changed, 81 insertions(+), 106 deletions(-)

-- 
2.34.1

