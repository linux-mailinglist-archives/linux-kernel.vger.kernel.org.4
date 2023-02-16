Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D5699585
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjBPNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjBPNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:16:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA9552A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553410; x=1708089410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCCqLc87j+n2TX4S0I5r808qPN4XxFBlCpxujEbhTfo=;
  b=YulFT56SjFb5xcJNjrsTMZ61tm+hAGXJ9iPgi0ZhYio+YWJwEUbuuVGA
   9Uo+c907ZmoKXoyiPi5IVCEy/MSjZHcmgWLAHJJTmJtQsp8EK6q7MtUe2
   2Y2sm8fQ2H2k1Qb1M3x2ysEisQWaorJ1/yPLfmtoxg9HDb8BdhUg/S6Vd
   GLh6Y9hlIy2urMQgdF+gUtYT4feIurXh+SKQPxmPWp/uwaOjm+BsVozPP
   1LLKHOg5vQ3JdNfvKvw1uPo4OuOspiAjqwyN7d4zrvxwcl88ftTcsxu3W
   mAxVH1eHcGxjL734ennk1/9UIUwfGHfP/K7DW8+v8XZUSbBEIzb+0TgLI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883331"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674974"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674974"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:48 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu/vt-d: Allow to use flush-queue when first level is default
Date:   Thu, 16 Feb 2023 21:08:16 +0800
Message-Id: <20230216130816.151824-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216130816.151824-1-baolu.lu@linux.intel.com>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
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

From: Tina Zhang <tina.zhang@intel.com>

Commit 29b32839725f ("iommu/vt-d: Do not use flush-queue when caching-mode
is on") forced default domains to be strict mode as long as IOMMU
caching-mode is flagged. The reason for doing this is that when vIOMMU
uses VT-d caching mode to synchronize shadowing page tables, the strict
mode shows better performance.

However, this optimization is orthogonal to the first-level page table
because the Intel VT-d architecture does not define the caching mode of
the first-level page table. Refer to VT-d spec, section 6.1, "When the
CM field is reported as Set, any software updates to remapping
structures other than first-stage mapping (including updates to not-
present entries or present entries whose programming resulted in
translation faults) requires explicit invalidation of the caches."
Exclude the first-level page table from this optimization.

Generally using first-stage translation in vIOMMU implies nested
translation enabled in the physical IOMMU. In this case the first-stage
page table is wholly captured by the guest. The vIOMMU only needs to
transfer the cache invalidations on vIOMMU to the physical IOMMU.
Forcing the default domain to strict mode will cause more frequent
cache invalidations, resulting in performance degradation. In a real
performance benchmark test measured by iperf receive, the performance
result on Sapphire Rapids 100Gb NIC shows:
w/ this fix ~51 Gbits/s, w/o this fix ~39.3 Gbits/s.

Theoretically a first-stage IOMMU page table can still be shadowed
in absence of the caching mode, e.g. with host write-protecting guest
IOMMU page table to synchronize changed PTEs with the physical
IOMMU page table. In this case the shadowing overhead is decoupled
from emulating IOTLB invalidation then the overhead of the latter part
is solely decided by the frequency of IOTLB invalidations. Hence
allowing guest default dma domain to be lazy can also benefit the
overall performance by reducing the total VM-exit numbers.

Fixes: 29b32839725f ("iommu/vt-d: Do not use flush-queue when caching-mode is on")
Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20230214025618.2292889-1-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ce36a16efc97..52afcdaf7c7f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4005,7 +4005,8 @@ int __init intel_iommu_init(void)
 		 * is likely to be much lower than the overhead of synchronizing
 		 * the virtual and physical IOMMU page-tables.
 		 */
-		if (cap_caching_mode(iommu->cap)) {
+		if (cap_caching_mode(iommu->cap) &&
+		    !first_level_by_default(IOMMU_DOMAIN_DMA)) {
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
 			iommu_set_dma_strict();
 		}
-- 
2.34.1

