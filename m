Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841B72F2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbjFNCtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbjFNCsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:48:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77D2128
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710902; x=1718246902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGWXKlFwoha8aQZA4PcpDVrWAANHfSgY3CsRnwLIe6c=;
  b=a0+U6IQ5EdhQP35L6gr0wvawf4BRZU/vGOm0zeTiZNIUK6WYApbJhCev
   R0FDHPlJZIn1jwBbx2UwPwpSmGV5IEP+szU/CotZ44VSW3mlq6NCVANOG
   PmQ+7q3SCTNCH7JK6/PsMTdqil1Bj4Y4ZIpKF4cJbLn6nPNdwTkWHnV3q
   5QnmQLGDHiSqB0TOzIvsbxSE8zuWNECeVu1hMsahLfBWCFCnQR3J1/5xd
   jbaZXLi0HOnC8KZ8JFl956SNaYA2Kt2pClFzxk6HNm69EnHkopv2dDJ42
   eStzxda+Xg2HUnB6Aft/s47DIe6OeQDrtoqWO1BCSgUGTa46FgmE8EydL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164469"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164469"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884219"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884219"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:20 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Yanfei Xu <yanfei.xu@intel.com>, Suhui <suhui@nfschina.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/vt-d: Remove commented-out code
Date:   Wed, 14 Jun 2023 10:47:05 +0800
Message-Id: <20230614024705.88878-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614024705.88878-1-baolu.lu@linux.intel.com>
References: <20230614024705.88878-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These lines of code were commented out when they were first added in commit
ba39592764ed ("Intel IOMMU: Intel IOMMU driver"). We do not want to restore
them because the VT-d spec has deprecated the read/write draining hit.

VT-d spec (section 11.4.2):
"
 Hardware implementation with Major Version 2 or higher (VER_REG), always
 performs required drain without software explicitly requesting a drain in
 IOTLB invalidation. This field is deprecated and hardware  will always
 report it as 1 to maintain backward compatibility with software.
"

Remove the code to make the code cleaner.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20230609060514.15154-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4c0b7424c45e..e5c111ff4dd9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1312,15 +1312,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 			iommu->name, type);
 		return;
 	}
-	/* Note: set drain read/write */
-#if 0
-	/*
-	 * This is probably to be super secure.. Looks like we can
-	 * ignore it without any impact.
-	 */
-	if (cap_read_drain(iommu->cap))
-		val |= DMA_TLB_READ_DRAIN;
-#endif
+
 	if (cap_write_drain(iommu->cap))
 		val |= DMA_TLB_WRITE_DRAIN;
 
-- 
2.34.1

