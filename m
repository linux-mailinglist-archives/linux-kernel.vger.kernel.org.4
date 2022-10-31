Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11CB612E77
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJaBGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:06:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7D9FDE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178363; x=1698714363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zwbxaON8XYHMDEYGmgYuDpqK1SsbsgRTeecwhgmM5zs=;
  b=e5HyvekrGdv+kgq/Yr9xZ009rsVwK2I8vQ0+3CAyDizI2pU+m5qTWVIp
   8gX4KTRJ8Ch4uHKgH4cm9Pw8hY8Z2qHBQqDzCQibn4ffqlMpgHAsj9NQm
   IGMoiIbxfyNt72qxefFyatbjn05up1XW723kacT1a9OXx5G+FG2QdwGz0
   szKZkzjXngrh1IKXh+XRhbCpTQ18y2hO954CkLHxlYYjj0FjWoqyN+gIA
   Gh4hbuTIU8PpfDvWuXotik3Q8M18z9zapdlIba8VHX+Z9EvJERdxVk8TK
   /fL/FOKgpHDml4UDgxKRuBMMhZ4IvvL+C15QVD5RioCGQBdEG9soCOQJF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373001657"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373001657"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496121"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496121"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:05:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 01/13] iommu: Add max_pasids field in struct iommu_device
Date:   Mon, 31 Oct 2022 08:59:05 +0800
Message-Id: <20221031005917.45690-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use this field to keep the number of supported PASIDs that an IOMMU
hardware is able to support. This is a generic attribute of an IOMMU
and lifting it into the per-IOMMU device structure makes it possible
to allocate a PASID for device without calls into the IOMMU drivers.
Any iommu driver that supports PASID related features should set this
field before enabling them on the devices.

In the Intel IOMMU driver, intel_iommu_sm is moved to CONFIG_INTEL_IOMMU
enclave so that the pasid_supported() helper could be used in dmar.c
without compilation errors.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h                       | 2 ++
 drivers/iommu/intel/iommu.h                 | 4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/dmar.c                  | 7 +++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3c9da1f8979e..e3af4f46e6e0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -322,12 +322,14 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	u32 max_pasids;
 };
 
 /**
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92023dff9513..cce0598f4109 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,8 +480,6 @@ enum {
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
-extern int intel_iommu_sm;
-
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
@@ -795,6 +793,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern const struct iommu_ops intel_iommu_ops;
 
 #ifdef CONFIG_INTEL_IOMMU
+extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
@@ -810,6 +809,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 }
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
+#define intel_iommu_sm (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d5df91c5c46..21cb13da122c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3543,6 +3543,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
 	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
 
 	/*
 	 * If the SMMU supports fewer bits than would fill a single L2 stream
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 5a8f780e7ffd..3528058d253e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1104,6 +1104,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 	raw_spin_lock_init(&iommu->register_lock);
 
+	/*
+	 * A value of N in PSS field of eCap register indicates hardware
+	 * supports PASID field of N+1 bits.
+	 */
+	if (pasid_supported(iommu))
+		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
+
 	/*
 	 * This is only for hotplug; at boot time intel_iommu_enabled won't
 	 * be set yet. When intel_iommu_init() runs, it registers the units
-- 
2.34.1

