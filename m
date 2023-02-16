Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95DF699583
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjBPNQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBPNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:16:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65D54575
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553408; x=1708089408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjSVq1WVeCrfaYihL0lX05Q/SUamFWX/MkV36WR1wlU=;
  b=Fw9FVcslDK49cdJS1G4dKSpMVOIHYoYykDAYWWopuDvqQzXJsDlZFCxt
   aVKIgiy2lZDTp+/SWUxqorwj19B+h0EG9lxTwKKCshNXKN0aPuPNlrE18
   In+LmYLgb/OiaAOYWBHrgqXWz+IrjhIIqsXd6qtaSmwS+DZhPmjk+hMJ0
   6cWIbhikVsR3fmeZOV2KplH1gZHBHFqCIItpelMwzLhuRiMhW3ppkSjOk
   pt2OT6XmxDbG2vyL8qGb8vy7/djjy98Wi3Dlrs+O5kcSruE6MlIGPbm0N
   R7tbKeTNGyhi5R18NSYbB2CwdL7leKinvOiMN80bUKKlGVmEKxcvfD/2K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883313"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883313"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674949"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674949"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:46 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/vt-d: Fix PASID directory pointer coherency
Date:   Thu, 16 Feb 2023 21:08:15 +0800
Message-Id: <20230216130816.151824-4-baolu.lu@linux.intel.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

On platforms that do not support IOMMU Extended capability bit 0
Page-walk Coherency, CPU caches are not snooped when IOMMU is accessing
any translation structures. IOMMU access goes only directly to
memory. Intel IOMMU code was missing a flush for the PASID table
directory that resulted in the unrecoverable fault as shown below.

This patch adds clflush calls whenever allocating and updating
a PASID table directory to ensure cache coherency.

On the reverse direction, there's no need to clflush the PASID directory
pointer when we deactivate a context entry in that IOMMU hardware will
not see the old PASID directory pointer after we clear the context entry.
PASID directory entries are also never freed once allocated.

 DMAR: DRHD: handling fault status reg 3
 DMAR: [DMA Read NO_PASID] Request device [00:0d.2] fault addr 0x1026a4000
       [fault reason 0x51] SM: Present bit in Directory Entry is clear
 DMAR: Dump dmar1 table entries for IOVA 0x1026a4000
 DMAR: scalable mode root entry: hi 0x0000000102448001, low 0x0000000101b3e001
 DMAR: context entry: hi 0x0000000000000000, low 0x0000000101b4d401
 DMAR: pasid dir entry: 0x0000000101b4e001
 DMAR: pasid table entry[0]: 0x0000000000000109
 DMAR: pasid table entry[1]: 0x0000000000000001
 DMAR: pasid table entry[2]: 0x0000000000000000
 DMAR: pasid table entry[3]: 0x0000000000000000
 DMAR: pasid table entry[4]: 0x0000000000000000
 DMAR: pasid table entry[5]: 0x0000000000000000
 DMAR: pasid table entry[6]: 0x0000000000000000
 DMAR: pasid table entry[7]: 0x0000000000000000
 DMAR: PTE not present at level 4

Cc: <stable@vger.kernel.org>
Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reported-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/r/20230209212843.1788125-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fb3c7020028d..979f796175b1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -128,6 +128,9 @@ int intel_pasid_alloc_table(struct device *dev)
 	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
 	info->pasid_table = pasid_table;
 
+	if (!ecap_coherent(info->iommu->ecap))
+		clflush_cache_range(pasid_table->table, size);
+
 	return 0;
 }
 
@@ -215,6 +218,10 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 			free_pgtable_page(entries);
 			goto retry;
 		}
+		if (!ecap_coherent(info->iommu->ecap)) {
+			clflush_cache_range(entries, VTD_PAGE_SIZE);
+			clflush_cache_range(&dir[dir_index].val, sizeof(*dir));
+		}
 	}
 
 	return &entries[index];
-- 
2.34.1

