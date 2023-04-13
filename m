Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0E6E05C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDMEH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDMEHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:07:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B476B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358826; x=1712894826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSH+9CuukwrVCuz9aJxEFN4y0MR5HKb9VSv4IIAZmfM=;
  b=GSaGvf0aeGnC3fnHwHemK6ADs/e/Mj/R7RidQMQsz3MnL2llM+3I5snI
   RnqxTSB3cZyE8NmH5HYI6kwYhp2OG7IyL7G8IzXNgbd5GRjgGt1rhalcw
   KCU+CPVqWi24qNZN2dkuZTY4llqOMbRxL0w7wLhhoxX+lloGksMddfS7d
   g/986Seg7NyOeKXVS6wJgjgWWhHSuo4iZ3d2J/2MUfzyrUAHldgPsAyky
   md5oSwjy04NYuP0JjcMZHTa7HueVgsEV+GDaCLhAfLJkiFRTCrAWJ5JAV
   9Jy/h3hrjg4x6WvYsxWrtHAn5gE1jNgYHy14FJd7QxQHbw+EaeQVGUEJK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786632"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786632"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361078"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361078"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:07:03 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/17] iommu/vt-d: Remove BUG_ON on checking valid pfn range
Date:   Thu, 13 Apr 2023 12:06:40 +0800
Message-Id: <20230413040645.46157-13-baolu.lu@linux.intel.com>
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

From: Tina Zhang <tina.zhang@intel.com>

When encountering an unexpected invalid pfn range, the kernel should
attempt recovery and proceed with execution. Therefore, using WARN_ON to
replace BUG_ON to avoid halting the machine.

Besides, one redundant checking is reduced.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406065944.2773296-3-tina.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acbf82fa90e7..c4847a5aaf52 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1005,9 +1005,9 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 	unsigned int large_page;
 	struct dma_pte *first_pte, *pte;
 
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
+	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
+	    WARN_ON(start_pfn > last_pfn))
+		return;
 
 	/* we don't need lock here; nobody else touches the iova range */
 	do {
@@ -1166,9 +1166,9 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 			 unsigned long last_pfn, struct list_head *freelist)
 {
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
+	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
+	    WARN_ON(start_pfn > last_pfn))
+		return;
 
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-- 
2.34.1

