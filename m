Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F616E05C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDMEHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjDMEHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:07:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D436A4D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358822; x=1712894822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QWKb5WYVBBtztVXr3PHvMcXCQDDphOV1gmNATePnwEA=;
  b=FIaLT/9DNmz1UT6YxYaeQ6IlOONLMCdsPrXXY+s5k/+fOXOhuBxVqcCq
   3FMrlpvKjNWUK+2KR5jCGsruFygztt6Y/x5yRq77HHJbXE2PGJdFaC7ob
   Szb5dnqGlzYOAUWvHmsMzwM5U4Mqy3up5qBU3f1SLOOuDbZJS6WKVuTeJ
   yX8O2BXrVBeNeR6ykcwYtTdxVE3GDwwuZTbIzauaDW0GQwahBhfAI4sxt
   9SHsEDE+tDq/I0Gq0cN5JCyZcdrmXCegI8Gv8Wxp3/NNzj0+NpFL+/ie1
   nTah+Isnri+5p+1b+eTOEse4oAxuBPwDfYWF+CYJJEpCa3M5chtML8hyk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786610"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786610"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361058"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361058"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:59 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] iommu/vt-d: Remove PASID supervisor request support
Date:   Thu, 13 Apr 2023 12:06:38 +0800
Message-Id: <20230413040645.46157-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

There's no more usage, remove PASID supervisor support.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/r/20230331231137.1947675-3-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  7 ------
 drivers/iommu/intel/pasid.c | 43 -------------------------------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 20c54e50f533..d6b7d21244b1 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -41,13 +41,6 @@
 #define FLPT_DEFAULT_DID		1
 #define NUM_RESERVED_DID		2
 
-/*
- * The SUPERVISOR_MODE flag indicates a first level translation which
- * can be used for access to kernel addresses. It is valid only for
- * access to the kernel's static 1:1 mapping of physical memory — not
- * to vmalloc or even module mappings.
- */
-#define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
 #define PASID_FLAG_NESTED		BIT(1)
 #define PASID_FLAG_PAGE_SNOOP		BIT(2)
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 633e0a4a01e7..c5d479770e12 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,15 +335,6 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
-/*
- * Setup the SRE(Supervisor Request Enable) field (Bit 128) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_sre(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 0, 1);
-}
-
 /*
  * Setup the WPE(Write Protect Enable) field (Bit 132) of a
  * scalable mode PASID entry.
@@ -521,23 +512,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
-#ifdef CONFIG_X86
-		unsigned long cr0 = read_cr0();
-
-		/* CR0.WP is normally set but just to be sure */
-		if (unlikely(!(cr0 & X86_CR0_WP))) {
-			pr_err("No CPU write protect!\n");
-			return -EINVAL;
-		}
-#endif
-		if (!ecap_srs(iommu->ecap)) {
-			pr_err("No supervisor request support on %s\n",
-			       iommu->name);
-			return -EINVAL;
-		}
-	}
-
 	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
 		pr_err("No 5-level paging support for first-level on %s\n",
 		       iommu->name);
@@ -560,10 +534,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 
 	/* Setup the first level page table pointer: */
 	pasid_set_flptr(pte, (u64)__pa(pgd));
-	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
-		pasid_set_sre(pte);
-		pasid_set_wpe(pte);
-	}
 
 	if (flags & PASID_FLAG_FL5LP)
 		pasid_set_flpm(pte, 1);
@@ -658,12 +628,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	/*
-	 * Since it is a second level only translation setup, we should
-	 * set SRE bit as well (addresses are expected to be GPAs).
-	 */
-	if (pasid != PASID_RID2PASID && ecap_srs(iommu->ecap))
-		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
@@ -700,13 +664,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
-
-	/*
-	 * We should set SRE bit as well since the addresses are expected
-	 * to be GPAs.
-	 */
-	if (ecap_srs(iommu->ecap))
-		pasid_set_sre(pte);
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
-- 
2.34.1

