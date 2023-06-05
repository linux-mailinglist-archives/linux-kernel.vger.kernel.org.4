Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C148722494
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjFEL37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjFEL3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:29:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C4F9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964588; x=1717500588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEJON0mdcarcf+gq8BZwb49Cru53/uhaflnw7S9fEAQ=;
  b=FXQnaWXrpKbXMlEDWrQ7hJWXjYZRv3n+bmwx1R4fIrPkZ7l3HUtq48ix
   QV3SokPOGPWYkUVGXF8kcp76HLzULeXX3j7eSVCnpaSs1BB8TdWeQBW+m
   7NzW9Mj9KZ20OvYTuVDpfYjdlU2UkjvM9EaMZMk4mAuJ84xOYxQDlueke
   6Oi7v9h1tStl4NGvpWZb5RrU2gMn/DmbeeUneErl6JoEOQNXeNSPFfFAE
   deYI/0mdziFRFkVMYoX4myYBKGibwP5vExzdUQk0OwiPKSu3O+iWK0syI
   Q6htNz4tL7wOQHsDwLt9oluUWi1FSANTcTjNspV6aenXWpoyExqkhhBnm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336699362"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336699362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="708626668"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708626668"
Received: from tower.bj.intel.com ([10.238.157.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:29:45 -0700
From:   Yanfei Xu <yanfei.xu@intel.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        yanfei.xu@intel.com
Subject: [PATCH v3 2/2] iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()
Date:   Mon,  5 Jun 2023 19:26:59 +0800
Message-Id: <20230605112659.308981-3-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605112659.308981-1-yanfei.xu@intel.com>
References: <20230605112659.308981-1-yanfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the WARN_ON(did == 0) as the domain id 0 is reserved and
set once the domain_ids is allocated. So iommu_init_domains will
never return 0.

Remvoe the WARN_ON(!table) as this pointer will be accessed in
the following code, if empty "table" really happens, the kernel
will report a NULL pointer reference warning at the first place.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c13c6475b626..cd9e01a0aa1d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1897,8 +1897,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int ret;
 
-	WARN_ON(did == 0);
-
 	if (hw_pass_through && domain_type_is_si(domain))
 		translation = CONTEXT_TT_PASS_THROUGH;
 
@@ -1944,8 +1942,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (sm_supported(iommu)) {
 		unsigned long pds;
 
-		WARN_ON(!table);
-
 		/* Setup the PASID DIR pointer: */
 		pds = context_get_sm_pds(table);
 		context->lo = (u64)virt_to_phys(table->table) |
-- 
2.34.1

