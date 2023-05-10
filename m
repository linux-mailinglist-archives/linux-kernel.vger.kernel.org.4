Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E230D6FE5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbjEJUwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjEJUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:52:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BA6E87
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9dcfade347so14099852276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751865; x=1686343865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f05oUNHXSveqV1U+rh8Ih41HYQKZ7A3pZBc66Z2rnxc=;
        b=2LKwWhQdomE3dGvwT9OTXPmELcrXLWDV9UEd9UhdeIO1/5OG0hKScpfNWUQ8/CeIgz
         DISbEAg+eutvYWLtWR7jtbUS+JTOhPxz7ovrMXKkffZVQZxyP/tfWAP7Wni4GjMBSucG
         3KjS7yPmR+d4Vwja0z44raVRH9tIsGvMkYUEnkM2Bhuw1vJGKAVcMPYgSIJ4xJaD7/5r
         nZird9ArtHDDSN2l6f1ctcYYn6l3yEbpqmQ4cRB3EsV0xJiqlQYlF66P/mPMEeqpvImp
         kTmq5gMuvtKlkgeUfLBHfPDh+GDQxOpCMDjkGplFuz6ovkBUhvtveOubNUnRrkJlSNCi
         FN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751865; x=1686343865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f05oUNHXSveqV1U+rh8Ih41HYQKZ7A3pZBc66Z2rnxc=;
        b=cCsWYlAW6HpFH0K+wg0v5SwnVmWYz3Z6fnrtPZu0zgnK35v7ni9jKC18LogjNpQQOQ
         fT6I3Q6qNaW2bzH4qAPn0xvPu80L811Si+Gr/xj83XtpP6++Jgsj8bZ1/sC7m/ofxiRa
         zAcljFL5MLt2nQyx1Rf7FG+KSGFYsyvytdYz7dgQqmDeKGEoRIbDiFA59/ZpH9ep/rl3
         0iu5vVqQZUPzRulOr8RYjhZUtcXR+eIo9gg6yID6pfqYZpwFOdqNdS0fYvXth2upggOO
         vEzB1vqI0NrlOeYqeY/RNdyJ15ZIwZXQnbPEzvpA41wzBPx3fkgvjRDGcKReRzpyQcH2
         4uhA==
X-Gm-Message-State: AC+VfDyi4DWJ6Q2Wjwzytm1fWmFQz1xRcYe0GqVw7pX23J2Kf1IiOdC/
        +4WmfaTzsDRriRnJDG/QOPXybH7SO1rr
X-Google-Smtp-Source: ACHHUZ6VAQ7/rHe+ic4yyrEymMO0+t0Yr5vtpL02NRB+wBbQ3NSuKrQWLilbpu554hrpGh4rQEAb8g3MsH8g
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a25:9f02:0:b0:b8f:53e1:64b with SMTP id
 n2-20020a259f02000000b00b8f53e1064bmr8607903ybq.13.1683751865516; Wed, 10 May
 2023 13:51:05 -0700 (PDT)
Date:   Thu, 11 May 2023 04:50:48 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-2-mshavit@google.com>
Subject: [PATCH v1 1/5] iommu/arm-smmu-v3: Move cdtable to arm_smmu_master
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the arm-smmu-v3 driver, stage 1 domains represent the entire STE.
Iommu domains are conceptually closer to a single address space (with
some exceptions), which are better represented by a single
ContextDescriptor for stage 1 domains. With this change, the CD table is
now owned by the arm_smmu_master instead of the attached domain. Each
stage 1 domain now represents a single context.

For now, SVA still piggy-backs on the primary arm_smmu_domain for other
state management (such as the devices list).

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 185 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  29 +--
 3 files changed, 127 insertions(+), 122 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947eb..a721461b355c6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -35,6 +35,9 @@ struct arm_smmu_bond {
 #define sva_to_bond(handle) \
 	container_of(handle, struct arm_smmu_bond, sva)
 
+#define cd_to_domain(cd) \
+	container_of(cd, struct arm_smmu_domain, cd)
+
 static DEFINE_MUTEX(sva_lock);
 
 /*
@@ -45,10 +48,12 @@ static struct arm_smmu_ctx_desc *
 arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 {
 	int ret;
+	unsigned long flags;
 	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_master *master;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
 	if (!cd)
@@ -62,7 +67,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 		return cd;
 	}
 
-	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu_domain = cd_to_domain(cd);
 	smmu = smmu_domain->smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
@@ -80,7 +85,11 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master, 0, cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -211,6 +220,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	mutex_lock(&sva_lock);
 	if (smmu_mn->cleared) {
@@ -222,7 +233,11 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master, mm->pasid, &quiet_cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
@@ -244,7 +259,8 @@ static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 
 /* Allocate or get existing MMU notifier for this {domain, mm} pair */
 static struct arm_smmu_mmu_notifier *
-arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
+arm_smmu_mmu_notifier_get(struct arm_smmu_master *master,
+			  struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
@@ -279,7 +295,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
 	if (ret)
 		goto err_put_notifier;
 
@@ -294,7 +310,8 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 	return ERR_PTR(ret);
 }
 
-static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
+static void arm_smmu_mmu_notifier_put(struct arm_smmu_master *master,
+				      struct arm_smmu_mmu_notifier *smmu_mn)
 {
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
@@ -304,7 +321,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+	arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
@@ -348,7 +365,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	bond->sva.dev = dev;
 	refcount_set(&bond->refs, 1);
 
-	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
+	bond->smmu_mn = arm_smmu_mmu_notifier_get(master, smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
 		ret = PTR_ERR(bond->smmu_mn);
 		goto err_free_bond;
@@ -527,7 +544,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 
 	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		arm_smmu_mmu_notifier_put(master, bond->smmu_mn);
 		kfree(bond);
 	}
 	mutex_unlock(&sva_lock);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fd83fb757227..cee3efff3c9fa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -965,14 +965,12 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
-static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
+static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
 	size_t i;
-	unsigned long flags;
-	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
 		.cfgi	= {
@@ -981,16 +979,17 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 		},
 	};
 
-	cmds.num = 0;
+	/*
+	 * There's nothing to sync if the STE isn't valid yet.
+	 */
+	if (!master->domain)
+		return;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.cfgi.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
-		}
+	cmds.num = 0;
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.cfgi.sid = master->streams[i].id;
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
@@ -1020,16 +1019,16 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 				   u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->s1_cfg.cdcfg;
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (master->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
@@ -1041,13 +1040,13 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
 		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
-		arm_smmu_sync_cd(smmu_domain, ssid, false);
+		arm_smmu_sync_cd(master, ssid, false);
 	}
 	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
 	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
 	/*
@@ -1059,16 +1058,16 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 *     CD, then invalidate the old entry and mappings.
 	 * (4) Quiesce the context without clearing the valid bit. Disable
 	 *     translation, and ignore any translation fault.
-	 * (5) Remove a secondary CD.
+	 * (5) Remove a CD.
 	 */
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << master->s1_cfg.s1cdmax)))
 		return -E2BIG;
 
-	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	cdptr = arm_smmu_get_cd_ptr(master, ssid);
 	if (!cdptr)
 		return -ENOMEM;
 
@@ -1096,7 +1095,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-		arm_smmu_sync_cd(smmu_domain, ssid, true);
+		arm_smmu_sync_cd(master, ssid, true);
 
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
@@ -1108,7 +1107,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->stall_enabled)
+		if (master->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1122,19 +1121,20 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 *   without first making the structure invalid.
 	 */
 	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	arm_smmu_sync_cd(master, ssid, true);
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_s1_cfg *cfg = &master->s1_cfg;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
 
+	cfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -1175,12 +1175,12 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->s1_cfg.cdcfg;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1272,30 +1272,25 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_s1_cfg *s1_cfg = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
-	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
 			.sid	= sid,
 		},
 	};
+	struct iommu_domain *domain = NULL;
 
 	if (master) {
-		smmu_domain = master->domain;
 		smmu = master->smmu;
-	}
-
-	if (smmu_domain) {
-		switch (smmu_domain->stage) {
-		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
-			break;
-		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
-			s2_cfg = &smmu_domain->s2_cfg;
-			break;
-		default:
-			break;
+		if (master->domain)
+			domain = &master->domain->domain;
+	}
+	if (domain) {
+		if (domain->type != IOMMU_DOMAIN_IDENTITY) {
+			if (master->s2_cfg)
+				s2_cfg = master->s2_cfg;
+			else
+				s1_cfg = &master->s1_cfg;
 		}
 	}
 
@@ -1319,8 +1314,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
+	if (!(s1_cfg || s2_cfg)) {
+		if (disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -1863,7 +1858,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -1946,7 +1941,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= smmu_domain->cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2071,13 +2066,9 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
-		arm_smmu_free_asid(&cfg->cd);
+		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
@@ -2088,67 +2079,45 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
+static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
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
 
-	cfg->s1cdmax = master->ssid_bits;
-
-	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
-	if (ret)
-		goto out_free_asid;
-
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
-
-	/*
-	 * Note that this will end up calling arm_smmu_sync_cd() before
-	 * the master has been added to the devices list for this domain.
-	 * This isn't an issue because the STE hasn't been installed yet.
-	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
-	if (ret)
-		goto out_free_cd_tables;
+	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
-out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
-out_free_asid:
-	arm_smmu_free_asid(&cfg->cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
-				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -2173,8 +2142,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -2182,7 +2150,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
-				 struct arm_smmu_master *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -2204,7 +2171,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		ias = min_t(unsigned long, ias, VA_BITS);
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
-		finalise_stage_fn = arm_smmu_domain_finalise_s1;
+		finalise_stage_fn = arm_smmu_domain_finalise_cd;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -2234,7 +2201,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2402,6 +2369,13 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
+	master->s2_cfg = NULL;
+	/*
+	 * Note that this will end up calling arm_smmu_sync_cd() even though
+	 * we're about to destroy the entire STE anyways. This is ok because
+	 * arm_smmu_sync_cd will exit early now that we've set domain to NULL;
+	 */
+	arm_smmu_write_ctx_desc(master, 0, NULL);
 	arm_smmu_install_ste_for_dev(master);
 }
 
@@ -2436,7 +2410,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
+		ret = arm_smmu_domain_finalise(domain);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -2444,17 +2418,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	} else if (smmu_domain->smmu != smmu) {
 		ret = -EINVAL;
 		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
-		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->stall_enabled != master->stall_enabled) {
-		ret = -EINVAL;
-		goto out_unlock;
 	}
 
-	master->domain = smmu_domain;
+	/*
+	 * Note that this will end up calling arm_smmu_sync_cd() before
+	 * the master has been added to the devices list for this domain.
+	 * This isn't an issue because the STE hasn't been installed yet.
+	 */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
+		if (ret)
+			goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
+		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
+		master->s2_cfg = &smmu_domain->s2_cfg;
+	}
 
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
@@ -2466,6 +2444,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
+	master->domain = smmu_domain;
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -2703,6 +2682,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	ret = arm_smmu_alloc_cd_tables(master);
+	if (ret) {
+		arm_smmu_disable_pasid(master);
+		arm_smmu_remove_master(master);
+		goto err_free_master;
+	}
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -2718,6 +2704,7 @@ static void arm_smmu_release_device(struct device *dev)
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	arm_smmu_detach_dev(master);
+	arm_smmu_free_cd_tables(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	kfree(master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b574c58a34876..0b87c74bdf46e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -593,7 +593,6 @@ struct arm_smmu_ctx_desc_cfg {
 
 struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
-	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
 	u8				s1cdmax;
 };
@@ -689,6 +688,8 @@ struct arm_smmu_master {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_s1_cfg		s1_cfg;
+	struct arm_smmu_s2_cfg		*s2_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
@@ -707,25 +708,25 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct arm_smmu_device			*smmu;
+	 /* Protects smmu pointer */
+	struct mutex				init_mutex;
 
-	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
-	atomic_t			nr_ats_masters;
+	struct io_pgtable_ops			*pgtbl_ops;
+	atomic_t				nr_ats_masters;
 
-	enum arm_smmu_domain_stage	stage;
+	enum arm_smmu_domain_stage		stage;
 	union {
-		struct arm_smmu_s1_cfg	s1_cfg;
-		struct arm_smmu_s2_cfg	s2_cfg;
+		struct arm_smmu_ctx_desc	cd;
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
@@ -737,7 +738,7 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.40.1.521.gf1e218fcd8-goog

