Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56872F2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbjFNCtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbjFNCsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:48:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D01FFB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710899; x=1718246899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Kwv1UQHKRHrV8kbWrew4OGtdP1EEr6az2+Laq0Cs7w=;
  b=gGdyfAl9EuQOf2ibGWoHN2TA8KPQH1DBeu5qIRxTjFy5jxayKerF90qU
   7c11gD3BoMx+5koNzfVLqBnWv37eeFoIge4rhjNOqAOM8QqGL4KuuxQLf
   rjpGmBvweF2faVr9WMMCfLRLL65ouna/S50+88kUrNnTFCGxQJkMVR9hg
   Di5QXpdfpQOh5G63GHy48R0otLtZMnaIzUt09yZ4FB0KrCi5F9V5Oap8j
   zPvzN51XGkMrqtrZDfIzh0rToKOZ3wK6xkZ8dgXoEuuylB6M0lOWSCGgr
   BEyIoiFrFqfEGWcAb6jMR6E5I0zVFmDsP0MntIQvOkB2tu1OVhVYbjJKi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164455"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164455"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884198"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884198"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:16 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Yanfei Xu <yanfei.xu@intel.com>, Suhui <suhui@nfschina.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Handle the failure case of dmar_reenable_qi()
Date:   Wed, 14 Jun 2023 10:47:03 +0800
Message-Id: <20230614024705.88878-3-baolu.lu@linux.intel.com>
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

From: Yanfei Xu <yanfei.xu@intel.com>

dmar_reenable_qi() may not succeed. Check and return when it fails.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
Link: https://lore.kernel.org/r/20230605112659.308981-2-yanfei.xu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 323fa1a93765..e83fe243680b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2967,10 +2967,15 @@ static int init_iommu_hw(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
+	int ret;
 
-	for_each_active_iommu(iommu, drhd)
-		if (iommu->qi)
-			dmar_reenable_qi(iommu);
+	for_each_active_iommu(iommu, drhd) {
+		if (iommu->qi) {
+			ret = dmar_reenable_qi(iommu);
+			if (ret)
+				return ret;
+		}
+	}
 
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
-- 
2.34.1

