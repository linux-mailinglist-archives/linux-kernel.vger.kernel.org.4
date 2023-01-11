Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF76664CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjAKUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjAKUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:25:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA713DE7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673468731; x=1705004731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oYG9pyvEnoir5ijKaJji/tARGhQScPMXvWnM9ZJ6oYU=;
  b=Qk2dd4KxtLtwVIFKgYpogQB+2uUy7qff8qkZw5oFSlWNQjLPkoWxuCID
   KWTb4AdDQvszT12qC7vwuOljHWoTngvc5ux7bktqfUTSdLJlyLb7YSjhJ
   xoV7Ad+7ijC5MsJTTBTJuaKcDej2XLeGEC8tmD+9ZRzw7V4DB7P/Kvt7C
   SLJwM6lMW1P11kW7YyAjNAxFfZG3jCTA4Kv6feAcR1iMBH/a8j4QFBdlG
   5yBgcG5fWtfP4SLyyjGeva4l9B3s7cV2eItt5rcQ6Iu1doNclaHgeoZ8d
   pB0SDzjmmvOayMC1tvd1PeI+a6H+JRXFF52Z0a6EK3aCSQETPdn9fgOVg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350754990"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="350754990"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 12:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781518068"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="781518068"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 12:25:28 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/7] iommu/vt-d: Support Enhanced Command Interface
Date:   Wed, 11 Jan 2023 12:25:00 -0800
Message-Id: <20230111202504.378258-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111202504.378258-1-kan.liang@linux.intel.com>
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

The Enhanced Command Register is to submit command and operand of
enhanced commands to DMA Remapping hardware. It can supports upto 256
enhanced commands.

There is a HW register to indicate the availability of all 256 enhanced
commands. Each bit stands for each command. But there isn't an existing
interface to read/write all 256 bits. Introduce the u64 ecmdcap[4] to
store the existence of each enhanced command. Read 4 times to get
all of them in map_iommu().

Add a helper to facilitate an enhanced command launch. Make sure hardware
complete the command.

Add a helper to facilitate the check of PMU essentials.

The helpers will be used later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 63 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h | 46 +++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 91bb48267df2..dcafa32875c1 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1025,6 +1025,16 @@ static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 			goto release;
 		}
 	}
+
+	if (cap_ecmds(iommu->cap)) {
+		int i;
+
+		for (i = 0; i < DMA_MAX_NUM_ECMDCAP; i++) {
+			iommu->ecmdcap[i] = dmar_readq(iommu->reg + DMAR_ECCAP_REG +
+						       i * DMA_ECMD_REG_STEP);
+		}
+	}
+
 	err = 0;
 	goto out;
 
@@ -2434,3 +2444,56 @@ bool dmar_platform_optin(void)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dmar_platform_optin);
+
+#ifdef CONFIG_INTEL_IOMMU
+#define ecmd_get_status_code(res)	((res & 0xff) >> 1)
+
+/*
+ * Function to submit a command to the enhanced command interface. The
+ * valid enhanced command descriptions are defined in Table 47 of the
+ * VT-d spec. The VT-d hardware implementation may support some but not
+ * all commands, which can be determined by checking the Enhanced
+ * Command Capability Register.
+ *
+ * Return values:
+ *  - 0: Command successful without any error;
+ *  - Negative: software error value;
+ *  - Nonzero positive: failure status code defined in Table 48.
+ */
+int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
+		     u64 oa, bool has_ob, u64 ob)
+{
+	unsigned long flags;
+	u64 res;
+	int ret;
+
+	if (!cap_ecmds(iommu->cap))
+		return -ENODEV;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+
+	res = dmar_readq(iommu->reg + DMAR_ECRSP_REG);
+	if (res & DMA_ECMD_ECRSP_IP) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	if (has_ob)
+		dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
+	dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA_SHIFT));
+
+	IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
+		      !(res & DMA_ECMD_ECRSP_IP), res);
+
+	if (res & DMA_ECMD_ECRSP_IP) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	ret = ecmd_get_status_code(res);
+err:
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	return ret;
+}
+#endif /* CONFIG_INTEL_IOMMU */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5bcefbea55c9..f227107434ac 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -130,6 +130,10 @@
 #define DMAR_PERFOVFOFF_REG	0x318
 #define DMAR_PERFCNTROFF_REG	0x31c
 #define DMAR_PERFEVNTCAP_REG	0x380
+#define DMAR_ECMD_REG		0x400
+#define DMAR_ECEO_REG		0x408
+#define DMAR_ECRSP_REG		0x410
+#define DMAR_ECCAP_REG		0x430
 #define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
 #define DMAR_VCMD_REG		0xe00 /* Virtual command register */
 #define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
@@ -304,6 +308,26 @@
 #define DMA_CCMD_SID(s) (((u64)((s) & 0xffff)) << 16)
 #define DMA_CCMD_DID(d) ((u64)((d) & 0xffff))
 
+/* ECMD_REG */
+#define DMA_MAX_NUM_ECMD		256
+#define DMA_MAX_NUM_ECMDCAP		(DMA_MAX_NUM_ECMD / 64)
+#define DMA_ECMD_REG_STEP		8
+#define DMA_ECMD_ENABLE			0xf0
+#define DMA_ECMD_DISABLE		0xf1
+#define DMA_ECMD_FREEZE			0xf4
+#define DMA_ECMD_UNFREEZE		0xf5
+#define DMA_ECMD_OA_SHIFT		16
+#define DMA_ECMD_ECRSP_IP		0x1
+#define DMA_ECMD_ECCAP3			3
+#define DMA_ECMD_ECCAP3_ECNTS		(1ULL << 48)
+#define DMA_ECMD_ECCAP3_DCNTS		(1ULL << 49)
+#define DMA_ECMD_ECCAP3_FCNTS		(1ULL << 52)
+#define DMA_ECMD_ECCAP3_UFCNTS		(1ULL << 53)
+#define DMA_ECMD_ECCAP3_ESSENTIAL	(DMA_ECMD_ECCAP3_ECNTS |	\
+					 DMA_ECMD_ECCAP3_DCNTS |	\
+					 DMA_ECMD_ECCAP3_FCNTS |	\
+					 DMA_ECMD_ECCAP3_UFCNTS)
+
 /* FECTL_REG */
 #define DMA_FECTL_IM (((u32)1) << 31)
 
@@ -600,6 +624,7 @@ struct intel_iommu {
 	u64		cap;
 	u64		ecap;
 	u64		vccap;
+	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
@@ -841,6 +866,15 @@ extern const struct iommu_ops intel_iommu_ops;
 extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
+extern int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
+			    u64 oa, bool has_ob, u64 ob);
+
+static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
+{
+	return (iommu->ecmdcap[DMA_ECMD_ECCAP3] & DMA_ECMD_ECCAP3_ESSENTIAL) ==
+		DMA_ECMD_ECCAP3_ESSENTIAL;
+}
+
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
 #else
@@ -852,6 +886,18 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 {
 	return 0;
 }
+
+static inline int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd,
+				   u64 oa, bool has_ob, u64 ob)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
+{
+	return false;
+}
+
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
-- 
2.35.1

