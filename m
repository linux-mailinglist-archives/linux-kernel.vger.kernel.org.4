Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1F5B9646
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiIOIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiIOIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:23:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F171998757
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663230184; x=1694766184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dbGDw/fR57kfC3zNVT516fZ+CC10yT0IHxbEPv0a3KE=;
  b=T189inbqMQ/qup3xRV/qFqy679kn/fTGzCfaxcx1/W/RWHewJdvAZh9k
   lwY1btCQufLB9xsk7R7Rx8lugiWoATG7saLzpmAh77lDgQr3HSAhGCfuk
   lEzIwZxZirIUp9NiJT0WVikelbp4ffEd4X+DSiYjdVwc02b8SkBJd0y5i
   JOMDtlR3r5qHohlVhUU8jjW/pSWCei2OFMlKw62AD+80Qf6whtbiw3tjb
   +jx1Oa9CfJ3zsl03w0Yjj3j05yXSAHRJnsuS/zSc3yMUa42/RCSw+sAvx
   QFBlM5krmgejsSnSbpDcJ19bSp9UCIcijyuHt+B2sDpv1sRKcwiDm3hI/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285691775"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="285691775"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 01:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="647737363"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2022 01:22:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove pasid_set_eafe()
Date:   Thu, 15 Sep 2022 16:16:45 +0800
Message-Id: <20220915081645.1834555-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used anywhere in the tree. Remove it to avoid dead code.
No functional change intended.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5e7e8b020a5..ccaf32949254 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -392,16 +392,6 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
-/*
- * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
- * of a scalable mode PASID entry.
- */
-static inline void
-pasid_set_eafe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
-}
-
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, u32 pasid)
-- 
2.34.1

