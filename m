Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D56BF76F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 03:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCRCtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 22:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRCtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:49:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278FC1BC6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 19:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679107779; x=1710643779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bor+dPTiKtTketea02WkL7osfgsHnY/28a55n4Zq0YM=;
  b=NKQDt9GlyWTZScJnFZp7A+T/YMurgSv4Q6jv5eY3qcvTJ3kyOWx0cZeV
   8Z3o+gNnMU6T2XlxLB7SHVW4ndM2fZMSLFAfDTnOtS2jb1ithS69vKJsD
   98SGEPWS6lWfwjc06ZYjpnIjBCyviZRF6E8JHO3u4VEJNnGl1OjXd8PWq
   LuwDPMAT1KxbZSl+/sWv1QZ7Wb/6unxgbllimp58m5FFSU9UymuTRiPK3
   eOeJyhyBllcubJm2+n3Y9l+oInGYJpXVF/pYVavgAj3ZOpp0a+Cj/Hog5
   hApVvCfhKdSxd1t3Pw8OFb8ulUD4G5tG2PkIAxxipklQIl5UC5l9M40xg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="340756734"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="340756734"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 19:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="673777714"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="673777714"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2023 19:49:36 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Allow zero SAGAW if second-stage not supported
Date:   Sat, 18 Mar 2023 10:48:24 +0800
Message-Id: <20230318024824.124542-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d spec states (section 11.4.2) that hardware implementations
reporting second-stage translation support (SSTS) field as Clear also
report the SAGAW field as 0. Reflect this in the sanity check of
alloc_iommu().

Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
Suggested-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 6acfe879589c..23828d189c2a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1071,7 +1071,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	}
 
 	err = -EINVAL;
-	if (cap_sagaw(iommu->cap) == 0) {
+	if (!cap_sagaw(iommu->cap) &&
+	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
 			iommu->name);
 		drhd->ignored = 1;
-- 
2.34.1

