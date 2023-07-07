Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE70974A87A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGGBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGBfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:35:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD061BDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688693701; x=1720229701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w9KMIa9FeqUiMJ7hHb6xqUyUsuqFNPtVvcMNCNqbITA=;
  b=YBp/TkGNbvvUfW95TUSywl1jB/MT3fSuzbYJjS6vjZ5iENKxmvDiYVMV
   AsffmE/WAjmoTTxYunt71QKnhOWY1aTvAZdaSSN6nYPlRJpR5DuKEr0He
   DqRAxu2MgkGFO0gTKxfltlVE2eZbKToIJNUs7mMy1LISQ/La9tvBSv2Hg
   KETUvya5BM9j1iFHugNv/PTFh4tHN2F2g6dbfXJvaMJ5K0zTLmWSNT1rS
   DURrZsmNA0lyLyrH61Ijcoo7RewjkZS1AGiY37O4htuLcT+zEQsGyXbVY
   U5jHES+Uo3Wwknnjpbmms5iaBltbJPBi5vrVKXRE8ew+6WR6/G5qx4qnN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429832245"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429832245"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893791292"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="893791292"
Received: from fengj-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.210.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:34:58 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 1/6] iommu: Add two pasid helper functions
Date:   Fri,  7 Jul 2023 09:34:36 +0800
Message-Id: <20230707013441.365583-2-tina.zhang@intel.com>
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

mm_get_pasid() is for getting mm pasid value and mm_set_pasid() is for
setting mm pasid value.

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 arch/x86/kernel/traps.c |  2 +-
 include/linux/iommu.h   | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff51..8587461c43664 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -678,7 +678,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8c9a7da10609..d39e647219eb8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1174,6 +1174,15 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return mm->pasid;
+}
+
+static inline void mm_set_pasid(struct mm_struct *mm, u32 pasid)
+{
+	mm->pasid = pasid;
+}
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1196,6 +1205,11 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
+static inline void mm_set_pasid(struct mm_struct *mm, u32 pasid) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
-- 
2.34.1

