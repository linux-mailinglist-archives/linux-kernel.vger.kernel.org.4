Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB716DD368
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjDKGuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDKGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:50:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7E423F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195784; x=1712731784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHc/Dt3WZSFDnH//DR0PtW4o8sOEHZYZ41tbx+9UmIU=;
  b=dwVhYuC2L1KsP/sTK63g3tc+rivKc/wENqYW8HWayZq2XZqNBc1r0RFe
   TYmd8gUEfEB7fR3S3nBuCfXv4cbcDZDyAeHUQJjIpjzHMQBQW4mv5/B5v
   P8VlcFxG/ymsuzAT96l7eIEujR+56Vrkm2/a6rcyKdKUIfcGZ1zU/rbIt
   T3kzz1pHBTOf9TguFoozkGjqdeLiRrpIdDdFmucQd7TWUwQnsdU1X146J
   oCQI4RX/bMUPEs245jCbxTAmElITh2wL/L5e/lamg8leiLXJ/R0dwTYnT
   KGPhSZIRohnIJzaGrvU+hQ7TfH+GesVjYHivmpTYNeOZdyi2AaUpXolmG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028600"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028600"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256620"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256620"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:33 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Date:   Tue, 11 Apr 2023 14:48:09 +0800
Message-Id: <20230411064815.31456-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tina Zhang <tina.zhang@intel.com>

The patch fixes the klocwork issues that operands in a bitwise operation
have different size at line 1692 of dmar.c, line 1898 and line 1907 of
iommu.c.

Reported-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-2-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 2 +-
 drivers/iommu/intel/iommu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23828d189c2a..f0f51c957ccb 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1690,7 +1690,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	 * is present.
 	 */
 	if (ecap_smts(iommu->ecap))
-		val |= (1 << 11) | 1;
+		val |= BIT_ULL(11) | BIT_ULL(0);
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f4e536fd5a28..acbf82fa90e7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1870,7 +1870,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
  */
 static inline void context_set_sm_dte(struct context_entry *context)
 {
-	context->lo |= (1 << 2);
+	context->lo |= BIT_ULL(2);
 }
 
 /*
@@ -1879,7 +1879,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
  */
 static inline void context_set_sm_pre(struct context_entry *context)
 {
-	context->lo |= (1 << 4);
+	context->lo |= BIT_ULL(4);
 }
 
 /* Convert value to context PASID directory size field coding. */
-- 
2.34.1

