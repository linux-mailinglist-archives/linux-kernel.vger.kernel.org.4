Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C697241B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjFFMJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjFFMJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:09:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB410C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:09:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso8021001276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053365; x=1688645365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ3cILiWBl6sHwkWb+xA2FBDWFhU70WEk+uPmzetVys=;
        b=waAz3jZdXTtDO8YssmYN5G/omZlhLk3AOZz+YlKxfJTmIQFgsouKNpICkvLnj5PC/H
         bZqWVLF3XcBri+fZh1WmYCnXCapku6Wrt/uBr9E/faVNwT/kYzGDxtQq94OVjLaHSWXT
         lXowvoVL5l6wuhwdpgDhR3x7IXZKL7LtKM68ekc5whSTKAPi9JRVV7858iLvKqE+rAgQ
         V2z91OUSOPBgHt4rZ0RPDqTgQR0hkZpkD9w6Hgeww7FbN7MUsMroas3NWhEUMDgh1Un4
         LEaUgWdNTiF8qSbnloEwbSGHXijMkKZgdWQFvALN51/9Hcu+UqMrEXjYbAHZLscdB6Ev
         xhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053365; x=1688645365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ3cILiWBl6sHwkWb+xA2FBDWFhU70WEk+uPmzetVys=;
        b=RZyjqMpxoNW0e88BYYtDx7pw4/bhg5h3nTtQmDNMLZi7sG/JutggQrdBc9x5Vyy9mg
         OFDMBFrxEpr2p2JLFZ5bkuc+l2TFuBFu6VtWH7vr/yGGqO7saMPHfhEWQyU3WSM9wa10
         pAEhqcXWHUOHQkPZFBnUoiJQ2nOhcV6OU6xKFEdh0mHR2bdV80ZqDDP2aw5kArggWgVB
         bBBdV00ViuGQfFiEE6m7hbcC5ZYspijLDMFe85CsAQtj4C88Q6c+UcOmPzPNIC8uzhXK
         75f+U4gROvT+uWS2IOdTqp4bxfvk3fZ8XzYbNpHUTCafnmGMuhMybsOqoJyFA2cFOZYx
         Uwfg==
X-Gm-Message-State: AC+VfDzWTYIBTRdifHD7PDvBrCV4nX+RKeBSxCnzs/2QfHNw0AhLDGhg
        Fur5cE3co6fcwqupGo3sKGzRZDJ754FI
X-Google-Smtp-Source: ACHHUZ5Ybk7tUiRypHKa3i9pd62JKC+ZZIVel3EJWkEbpOHcFdGs75+3Ha1gLuNWDNdErEjkenDKSQuQDFjq
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a25:e794:0:b0:ba8:4ff5:4671 with SMTP id
 e142-20020a25e794000000b00ba84ff54671mr1024741ybh.9.1686053365471; Tue, 06
 Jun 2023 05:09:25 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:37 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-2-mshavit@google.com>
Subject: [PATCH v2 01/18] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
From:   Michael Shavit <mshavit@google.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s1_cfg describes the CD table that is inserted into an SMMU's STEs. It's
weird for s1_cfg to also own ctx_desc which describes a CD that is
inserted into that table. It is more appropriate for arm_smmu_domain to
own ctx_desc.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 23 +++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 28 ++++++++++---------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947eb..968559d625c40 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -62,7 +62,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 		return cd;
 	}
 
-	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu_domain = container_of(cd, struct arm_smmu_domain, cd);
 	smmu = smmu_domain->smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fd83fb757227..beff04b897718 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1863,7 +1863,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -1946,7 +1946,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= smmu_domain->cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2077,7 +2077,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
-		arm_smmu_free_asid(&cfg->cd);
+		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2096,13 +2096,14 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
-	refcount_set(&cfg->cd.refs, 1);
+	refcount_set(&cd->refs, 1);
 
 	/* Prevent SVA from modifying the ASID until it is written to the CD */
 	mutex_lock(&arm_smmu_asid_lock);
-	ret = xa_alloc(&arm_smmu_asid_xa, &asid, &cfg->cd,
+	ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
 		goto out_unlock;
@@ -2115,23 +2116,23 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_free_asid;
 
-	cfg->cd.asid	= (u16)asid;
-	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
-	cfg->cd.tcr	= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
+	cd->asid	= (u16)asid;
+	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_TG0, tcr->tg) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, tcr->irgn) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, tcr->orgn) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_SH0, tcr->sh) |
 			  FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
-	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
+	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() before
 	 * the master has been added to the devices list for this domain.
 	 * This isn't an issue because the STE hasn't been installed yet.
 	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -2141,7 +2142,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
-	arm_smmu_free_asid(&cfg->cd);
+	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b574c58a34876..68d519f21dbd8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -593,7 +593,6 @@ struct arm_smmu_ctx_desc_cfg {
 
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
-	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
 };
@@ -707,25 +706,28 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct arm_smmu_device			*smmu;
+	struct mutex				init_mutex; /* Protects smmu pointer */
 
-	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
-	atomic_t			nr_ats_masters;
+	struct io_pgtable_ops			*pgtbl_ops;
+	bool					stall_enabled;
+	atomic_t				nr_ats_masters;
 
-	enum arm_smmu_domain_stage	stage;
+	enum arm_smmu_domain_stage		stage;
 	union {
-		struct arm_smmu_s1_cfg	s1_cfg;
-		struct arm_smmu_s2_cfg	s2_cfg;
+		struct {
+		struct arm_smmu_ctx_desc	cd;
+		struct arm_smmu_s1_cfg		s1_cfg;
+		};
+		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
-	struct iommu_domain		domain;
+	struct iommu_domain			domain;
 
-	struct list_head		devices;
-	spinlock_t			devices_lock;
+	struct list_head			devices;
+	spinlock_t				devices_lock;
 
-	struct list_head		mmu_notifiers;
+	struct list_head			mmu_notifiers;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-- 
2.41.0.rc0.172.g3f132b7071-goog

