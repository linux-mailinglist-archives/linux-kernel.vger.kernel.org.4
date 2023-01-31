Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D916825BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjAaHq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjAaHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:46:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DCB36442
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151172; x=1706687172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjBgirNm5pIeDvvzUxGA1RbTCC4lfrnHwE9vlSINv4g=;
  b=mKobrybW3LsJzzBtVBtKiPL5QYjspRhwIketdrOKGQ5HiV9SeDtOdoaw
   3z19EqagywN/bbSuQpknbROfRf7m8qG1/YOy6UEIoUMaJrcnE/fFz4/01
   xpdnBeA7YGSsGkAVOTGuFnqtL4EEqVvhQsMvdM1U8DwRThvkcm1o7Ifo7
   j4Wbm2vJ4x8FrN7F2ZbMeSniLLKBvXn/yxw/An/JJj/Qw3ubR6IeY6O51
   Q1f5h3ELcXN6Bs3hLgM3AqNW0tzy2QsLHNDQXV/yG0cAiYlz2cnHV8zrA
   t6JukmOWooL6sZpMZ/44Yj5z0mndhx1uMUxvQ9dYTKwEvNrHIOqau3r4+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736607"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775524"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775524"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:45:59 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kan.liang@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] iommu/vt-d: Set No Execute Enable bit in PASID table entry
Date:   Tue, 31 Jan 2023 15:37:33 +0800
Message-Id: <20230131073740.378984-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup No Execute Enable bit (Bit 133) of a scalable mode PASID entry.
This is to allow the use of XD bit of the first level page table.

Fixes: ddf09b6d43ec ("iommu/vt-d: Setup pasid entries for iova over first level")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20230126095438.354205-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/pasid.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fb3c7020028d..ec964ac7d797 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -364,6 +364,16 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
+/*
+ * Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
+ * entry. It is required when XD bit of the first level page table
+ * entry is about to be set.
+ */
+static inline void pasid_set_nxe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 5, 1 << 5);
+}
+
 /*
  * Setup the Page Snoop (PGSNP) field (Bit 88) of a scalable mode
  * PASID entry.
@@ -557,6 +567,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	pasid_set_nxe(pte);
 
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
-- 
2.34.1

