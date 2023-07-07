Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147BE74A882
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGGBgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:36:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572B2115
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693779; x=1720229779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX3zfSSKDYdQMJ/lhBfeXvJtyWDmev5GpUgBT8vYQ+w=;
  b=Qwiy4Tm94fhp/tANMqil7VWuQSE71JB3YMFKorbV58HyopeSkjJ1KwnM
   4Bxc1XpsT+lZC5y2ghouq5oTJyjpVwtExXjnswhQNKpWcc+FEUluHF3ZW
   0BYZY/VTplsLvEJxilzQCjiDt22YHPDLZte6dHLZHvjfwi3XuFRVg4R8r
   TT3+yeQHPSLiJ62nP5CdVim5HCntWUdnZh5p4kdSCAzwzGdiH8aWMapne
   uvChwHtZI/gVaakXab7GIpR6PGNaWOFs2tyB/Q6lh9hIh2GkLxlOQGyPh
   I3IkDFpp3Woh3FA+Lm1Ln2452S8venTgLvoGDF1/ARI3UKylZ+yzI0jn2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832329"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832329"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791373"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791373"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:15 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 6/6] mm: Deprecate pasid field
Date:   Fri,  7 Jul 2023 09:34:41 +0800
Message-Id: <20230707013441.365583-7-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707013441.365583-1-tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 mm/init-mm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index c43b7d0347312..50824dd5a949a 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -43,7 +43,6 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 #ifdef CONFIG_IOMMU_SVA
-	.pasid		= IOMMU_PASID_INVALID,
 	.iommu_mm       = &default_iommu_mm,
 #endif
 	INIT_MM_CONTEXT(init_mm)
-- 
2.34.1

