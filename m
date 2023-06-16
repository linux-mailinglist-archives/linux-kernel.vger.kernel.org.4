Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A052473299A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244920AbjFPIN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbjFPIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:13:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCD22962
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686903206; x=1718439206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ItNP+JKSJICj4eyo+r6suaHTPScQyJ1JFtXO/FOP/0=;
  b=Q9fhaTqgipqVwUG3xsWDKuT9eKdmAR2EyYTO5s0opmgC/gFnkrIhzQax
   s045mqUZtE1eEuYB2PDywTsRFVgNRUd3pPC4p+0W7ygcRzAX/AdBbzDOV
   KF9ofTRhcBRk7OIhluzYaDa8VSc1DrjxpVc99nnK/A1Clct0aiA/gTurE
   f3mq58Knrafs2jz4ZOQZLYAx0PVjZB+oRSdPodow+awEnJCJHYJl0fWR7
   DkEgln4UqH1+cI+I+8Jys1ckaKYlztguZmI2J+OwW+VgN9PPtlkg6Khw8
   BnCOj+4ZDTTV40ovy6vFb3krSmBWpgd5p/N+ka7X8tm+ceglcQlNlLJp3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343898449"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="343898449"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 01:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959538546"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="959538546"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 01:13:21 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, tina.zhang@intel.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH v2] iommu/vt-d: Fix to flush cache of PASID directory table
Date:   Fri, 16 Jun 2023 16:10:45 +0800
Message-Id: <20230616081045.721873-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even the PCI devices don't support pasid capability, PASID
table is mandatory for a PCI device in scalable mode. However
flushing cache of pasid directory table for these devices are
not taken after pasid table is allocated as the "size" of
table is zero. Fix it by calculating the size by page order.

Found this when reading the code, no actual problem encountered
for now

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
v1->v2:
  use variable "order" to calculate the table size (Suggested by baolu)

 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..49fc5a038a14 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -129,7 +129,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	info->pasid_table = pasid_table;
 
 	if (!ecap_coherent(info->iommu->ecap))
-		clflush_cache_range(pasid_table->table, size);
+		clflush_cache_range(pasid_table->table, (1 << order) * PAGE_SIZE);
 
 	return 0;
 }
-- 
2.34.1

