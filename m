Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9353D5BC2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiISGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiISGb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:31:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC9B17A94
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663569086; x=1695105086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NlLEGE69zbmyk7YL6ALP5s5qWGc0g73ZC68G4Db0N0=;
  b=UeJX6EWsF49NHJfl3ZgestQopl1DbYISln9id2lHC1zfmPcJcOqohanj
   1cZjh/wxJhWb4HXkK5FVFQnyp/2JE/x5X5Ba6IGS0zt8SO+WiSKxMP1Fv
   jEVEKVxCyTX9Pit88bZ4SGFvefqnKsM0/D61qsByxbKyVSkdu+XXUeX7B
   HLbV8AtnbmC7TZD0Oiuk4fiTwrxNUcC0H6JbNTfcPOicmFNVdjH8Kkfwu
   xqoWAwdDthOuyMVTFIu2OjyIeigdsKGTZGY6QmlBNtSrwJzLsAvx+mqxG
   MVbou7ItYtSyLy3S9dsWVbfTbqGyzgnExxMDzumdY/+4RUBco6Jv23O4e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="279699716"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279699716"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="680715168"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2022 23:31:24 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Avoid unnecessary global DMA cache invalidation
Date:   Mon, 19 Sep 2022 14:25:23 +0800
Message-Id: <20220919062523.3438951-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
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

Some VT-d hardware implementations invalidate all DMA remapping hardware
translation caches as part of SRTP flow. The VT-d spec adds a ESRTPS
(Enhanced Set Root Table Pointer Support, section 11.4.2 in VT-d spec)
capability bit to indicate this. With this bit set, software has no need
to issue the global invalidation request.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 1 +
 drivers/iommu/intel/iommu.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5407d82df4d1..251a609fdce3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -146,6 +146,7 @@
 /*
  * Decoding Capability Register
  */
+#define cap_esrtps(c)		(((c) >> 63) & 1)
 #define cap_esirtps(c)		(((c) >> 62) & 1)
 #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8e5d99197d39..c20f3e060bac 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1239,6 +1239,13 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 
+	/*
+	 * Hardware invalidates all DMA remapping hardware translation
+	 * caches as part of SRTP flow.
+	 */
+	if (cap_esrtps(iommu->cap))
+		return;
+
 	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 	if (sm_supported(iommu))
 		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
-- 
2.34.1

