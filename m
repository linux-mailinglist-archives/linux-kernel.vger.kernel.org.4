Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911664293D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiLENVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiLENVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:21:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099D1C424
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670246495; x=1701782495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tvirCoktsOJCDgLp5DXt2SRw2Wm/ltzUXfTouRmkaSQ=;
  b=ildT5qOLNqHg8JiLzvQKlWMSeOy4AGtPGWoTFntjK5scufuvPD6pbU4R
   NVDZq3RT6xkwg+XMNlVAO/ys9oEJuo8m3XL2oAbG72yRG0heZUidkwwua
   yCQSkS9IC9Ql5e8bOXvPRIZG9axmOGiBMcG1DMgsmFnSVnhY5aZhzkOB8
   WPbHSNRIug6IIaJ4q4idsIRNFzwGxRd8aU05E9nfj8Siq/XcDTv+X787V
   W8Yn+PiKjsu/WGJWbuQ5l492uHHyMK3gPT0vElqfGAxrc3ju17Lz25NF9
   dfXpSdHm6YHcblpEdx3OJC8PZOgRjmeAhPh8tFY6J94bcn3jYbntXpQQg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="315046107"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="315046107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="676583250"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="676583250"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2022 05:21:33 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Fix buggy QAT device mask
Date:   Mon,  5 Dec 2022 21:14:12 +0800
Message-Id: <20221205131412.2003159-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205131412.2003159-1-baolu.lu@linux.intel.com>
References: <20221205131412.2003159-1-baolu.lu@linux.intel.com>
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

Impacted QAT device IDs that need extra dtlb flush quirk is ranging
from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
result should be 0x4940 instead of 0x494c to identify these devices.

Fixes: e65a6897be5e ("iommu/vt-d: Add a fix for devices need extra dtlb flush")
Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/r/20221203005610.2927487-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5287efe247b1..644ca49e8cf8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1402,7 +1402,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
  * check because it applies only to the built-in QAT devices and it doesn't
  * grant additional privileges.
  */
-#define BUGGY_QAT_DEVID_MASK 0x494c
+#define BUGGY_QAT_DEVID_MASK 0x4940
 static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 {
 	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
-- 
2.34.1

