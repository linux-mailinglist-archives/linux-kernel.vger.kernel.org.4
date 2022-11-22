Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648AB633168
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiKVAhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiKVAhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:37:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97FDC6972
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077420; x=1700613420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VZ2LtOW1xcwYPaSiUZLXM5yrsWzASb/u5zLe/eeYO0k=;
  b=lJS/QwKgDi/WvE+04MzQDmZ7HOhtorxAFqFgpaMVwIBKRemreMkU1fKO
   MTfb6sgrOm1U1kPH4iRZJOS6jNUZpPOt5ocloKDd3nwazfoJUiPt+YYG5
   dekIY0rcnl/hDJa0XVg1IRwyFBcxIgZgSmZXLRPZpkJoymnZllIuit3XR
   V44u3BNIufM8CcNQQbINbSK7QpxHCLFil32R7E4v7dEtAjSktXuxELJSw
   h9LEyO77myzJeViP6+1buVH/fxRoOLWFGDAF8QhOsTAaph+gCoZrhgIK+
   HxcaGMmc+53PiBAMmKD8Y9WRj2EE92q9+3fBMm5/eZGNdNcBCtrToBvrY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315516484"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315516484"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:37:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018429"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018429"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:36:59 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iommu/vt-d: Rename domain_add_dev_info()
Date:   Tue, 22 Nov 2022 08:29:47 +0800
Message-Id: <20221122002949.148140-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122002949.148140-1-baolu.lu@linux.intel.com>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
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

dmar_domain_attach_device() is more meaningful according to what this
helper does.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20221118132451.114406-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e814ddb84bbf..4484da88f917 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2453,7 +2453,8 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
+static int dmar_domain_attach_device(struct dmar_domain *domain,
+				     struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
@@ -4286,7 +4287,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return domain_add_dev_info(to_dmar_domain(domain), dev);
+	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
-- 
2.34.1

