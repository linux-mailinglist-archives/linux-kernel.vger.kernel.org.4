Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2389860373F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJSAvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJSAvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:51:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18944B1DE9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140681; x=1697676681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Al/7LZbe8QdirMOyPmBDmhB4puBPIgFgDynAt3svbtY=;
  b=bznA4vOECfcVEZotwI5Z4GfN6iYOubT6uCV4c+z6b6Ol6iRWXWqEbfK7
   kpetQ3yCjjMVtB8ENJds4iPtp9VMNP1sx1+aZ+E/e0os5i/tbJFdhyhUC
   /lm6EfUpeeTu507vUAyJstosiyJXCaNs1eUBXaC/lD6L3NzCBtpkaoGl9
   DpKiFFfulfPcStyM9tVTboEUmfgCV0O1cZ6uaH+v4BBLdKrt2ejNi6Xxk
   bOwjjh/yo3UCl4OJ1v7fVqSXAMCPz8K0396OEaa3rmb8DndT5UF69kS0g
   vKlV7nz3EbqACdKpiiTdU1FaW8GKszTrjcMeVZrAVvBvxqnn/A7t+cIUH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="289591520"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="289591520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606824817"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="606824817"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 17:51:19 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Charlotte Tan <charlotte@extrahop.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/vt-d: Allow NVS regions in arch_rmrr_sanity_check()
Date:   Wed, 19 Oct 2022 08:44:46 +0800
Message-Id: <20221019004447.4563-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019004447.4563-1-baolu.lu@linux.intel.com>
References: <20221019004447.4563-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charlotte Tan <charlotte@extrahop.com>

arch_rmrr_sanity_check() warns if the RMRR is not covered by an ACPI
Reserved region, but it seems like it should accept an NVS region as
well. The ACPI spec
https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html
uses similar wording for "Reserved" and "NVS" region types; for NVS
regions it says "This range of addresses is in use or reserved by the
system and must not be used by the operating system."

There is an old comment on this mailing list that also suggests NVS
regions should pass the arch_rmrr_sanity_check() test:

 The warnings come from arch_rmrr_sanity_check() since it checks whether
 the region is E820_TYPE_RESERVED. However, if the purpose of the check
 is to detect RMRR has regions that may be used by OS as free memory,
 isn't  E820_TYPE_NVS safe, too?

This patch overlaps with another proposed patch that would add the region
type to the log since sometimes the bug reporter sees this log on the
console but doesn't know to include the kernel log:

https://lore.kernel.org/lkml/20220611204859.234975-3-atomlin@redhat.com/

Here's an example of the "Firmware Bug" apparent false positive (wrapped
for line length):

 DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR
       [0x000000006f760000-0x000000006f762fff], contact BIOS vendor for
       fixes
 DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR
       [0x000000006f760000-0x000000006f762fff]

This is the snippet from the e820 table:

 BIOS-e820: [mem 0x0000000068bff000-0x000000006ebfefff] reserved
 BIOS-e820: [mem 0x000000006ebff000-0x000000006f9fefff] ACPI NVS
 BIOS-e820: [mem 0x000000006f9ff000-0x000000006fffefff] ACPI data

Fixes: f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved")
Cc: Will Mortensen <will@extrahop.com>
Link: https://lore.kernel.org/linux-iommu/64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216443
Signed-off-by: Charlotte Tan <charlotte@extrahop.com>
Reviewed-by: Aaron Tomlin <atomlin@redhat.com>
Link: https://lore.kernel.org/r/20220929044449.32515-1-charlotte@extrahop.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/iommu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 0bef44d30a27..2fd52b65deac 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	u64 start = rmrr->base_address;
 	u64 end = rmrr->end_address + 1;
+	int entry_type;
 
-	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
+	entry_type = e820__get_entry_type(start, end);
+	if (entry_type == E820_TYPE_RESERVED || entry_type == E820_TYPE_NVS)
 		return 0;
 
 	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
-- 
2.34.1

