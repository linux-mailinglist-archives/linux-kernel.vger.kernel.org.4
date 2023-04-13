Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636B26E05B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMEGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMEGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:06:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3A372BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358808; x=1712894808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rMHo8yYSBVXvdzGdpugvYObeZKKcdE/cMZKOA3T4vNU=;
  b=TiB2xdO/59MGPxxW+IIvYDZZAlJAgiE9qtG7sVXEwmpp5rQI73VnnwSC
   1t57xhgWAOs7cn5K7h0f7eIDazrS2XywubqG7b/U0Qf9SeP6HASTG7e3x
   ZtXcubuNXuXPCmWnu5ynFjXjtRLBSx+ECkkvNs89tBLgzp+7eDu30dlZp
   IyEEH3znnQykle675V1lBheMWYbb/ynt184M4UOWTJw7HGo6HQdqcgcf7
   opt/OoiU89vgY7rGlCGjkpr5ssEkpKnNi4J3+lrK4r4Apu5PSjRe/fDfv
   7MiHqDOCZGYlwqDJ3QGEruE5aZ4e784HC2bWtf+N/YkrJ3yfwN7CKWyAW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786512"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786512"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935360969"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935360969"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:45 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/17] iommu/vt-d: Allow SVA with device-specific IOPF
Date:   Thu, 13 Apr 2023 12:06:30 +0800
Message-Id: <20230413040645.46157-3-baolu.lu@linux.intel.com>
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

Currently enabling SVA requires IOPF support from the IOMMU and device
PCI PRI. However, some devices can handle IOPF by itself without ever
sending PCI page requests nor advertising PRI capability.

Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
driver (device-specific IOPF). As long as IOPF could be handled, SVA
should continue to work.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..caf664448ee9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4650,7 +4650,21 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
 		return -ENODEV;
 
-	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+	if (!info->pasid_enabled || !info->ats_enabled)
+		return -EINVAL;
+
+	/*
+	 * Devices having device-specific I/O fault handling should not
+	 * support PCI/PRI. The IOMMU side has no means to check the
+	 * capability of device-specific IOPF.  Therefore, IOMMU can only
+	 * default that if the device driver enables SVA on a non-PRI
+	 * device, it will handle IOPF in its own way.
+	 */
+	if (!info->pri_supported)
+		return 0;
+
+	/* Devices supporting PRI should have it enabled. */
+	if (!info->pri_enabled)
 		return -EINVAL;
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-- 
2.34.1

