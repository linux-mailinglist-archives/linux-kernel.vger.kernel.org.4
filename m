Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC0737BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFUGoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjFUGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:43:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8DC19A5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5b8a9d82cso6185852276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329828; x=1689921828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3tJEpWHCJm3S04xQ0T/8NFLZuI/7sadQhRIHV1s9Zo=;
        b=tDLP783tJ0VQXKySnXfcycNFVcu1CwUxp8tUrTH0xu2NVvWELKSyiZsFc93tdsXdvB
         xETbRFAM6aKkKwECQOiXpyJILPwdCxEBih5pnCop8eUyqe0rhCwyzuViEs0sbi5rGrej
         9rL1XXQz69682N/N0/xt2Ohaot08bo5JQ9YQ/7IvhK9fLsoPnGVAokhZW6l/U5V/54UZ
         dA4BV3jTZuZEfgKZnQXiYtuBp4sLNnewc3vxY6RJ0YJwjoeeizsZilVlVAnwctKlJt3T
         u7RzkL909yZir1kXSjPGUWrgU6j5aLvYF7i8+sm5hJkwQTUqGkvq3HSxVSeKXV8QvaHd
         RFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329828; x=1689921828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3tJEpWHCJm3S04xQ0T/8NFLZuI/7sadQhRIHV1s9Zo=;
        b=AjRRRDy/PTTcGQ6aojT5C99P9fyW2hOdgWVwvXygeESeFjE6Kn5Wt7ehTUI9lga9D4
         WnUiTXBAX3no2PK2mGYxxM6CFqQyvTXhxJRxTLBV6su3dkdiPqBuNwD9koRbAoq/Cc+D
         bIoDdC+op7BeSyY25pCrG7rFXeaB/MGW3Gexl57M6TWsYpYDn8H1U/sTqK1PZmm+Ag3G
         udOo5Cm5nc1p6XZkl5Fk+XIRojCIeSj1NNo2b/ViPe8Lps17joDXQV78lGgbBC8839it
         dynA0bTVrNGkC1nJ2Q6BFnO85UZZod9JU9w+ikxs37RybAJlZIgSspqDl/mDEryUl537
         jPeQ==
X-Gm-Message-State: AC+VfDx3n+EBGWN13GZFMcD4TtInD8dOYx20A4UMg/imHbJPkQo4Pnx9
        /yAw6AK+YDkgwXYXg3r8UdX9jW8Wlv+8
X-Google-Smtp-Source: ACHHUZ7yq7ycY2qeb9AdhoMG/AMIx0w4M48vH2hQ0IrPDr4T8WnV7iAjLytDkfMdBW5HapJgIPYK6BBZnZgS
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:748e:0:b0:bac:fd63:b567 with SMTP id
 p136-20020a25748e000000b00bacfd63b567mr5997224ybc.4.1687329828409; Tue, 20
 Jun 2023 23:43:48 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:16 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-5-mshavit@google.com>
Subject: [PATCH v4 04/13] iommu/arm-smmu-v3: Refactor write_ctx_desc
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

Update arm_smmu_write_ctx_desc and downstream functions to be agnostic
of the CD table's ownership. Note that in practice, it will only be
called in cases where the table is owned by arm_smmu_master. Whether
arm_smmu_write_ctx_desc will trigger a sync is also made part of the
API.

Note that this change isn't a nop refactor since SVA will call
arm_smmu_write_ctx_desc in a loop for every master the domain is
attached to despite the fact that they all share the same CD table. Note
that the next commit ceases this sharing of the s1_cfg which makes that
loop necessary.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 36 ++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 80 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 +-
 3 files changed, 81 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 968559d625c40..48fa8eb271a45 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -45,10 +45,12 @@ static struct arm_smmu_ctx_desc *
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
@@ -80,7 +82,11 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(smmu, master->s1_cfg, master, 0, cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -211,6 +217,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	mutex_lock(&sva_lock);
 	if (smmu_mn->cleared) {
@@ -222,7 +230,12 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
+					mm->pasid, &quiet_cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
@@ -248,8 +261,10 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
+	unsigned long flags;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
+	struct arm_smmu_master *master;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -279,7 +294,12 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		ret = arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg,
+					      master, mm->pasid, cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 	if (ret)
 		goto err_put_notifier;
 
@@ -296,15 +316,23 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
 static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
+	unsigned long flags;
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
+	struct arm_smmu_master *master;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
+					mm->pasid, NULL);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d79c6ef5d6ed4..b6f7cf60f8f3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -965,14 +965,13 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
-static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
+/* master may be null */
+static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
 	size_t i;
-	unsigned long flags;
-	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
 		.cfgi	= {
@@ -981,16 +980,15 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 		},
 	};
 
-	cmds.num = 0;
+	if (!master)
+		return;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.cfgi.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
-		}
+	smmu = master->smmu;
+	cmds.num = 0;
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.cfgi.sid = master->streams[i].id;
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
@@ -1020,16 +1018,18 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+/* master may be null */
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_device *smmu,
+				   struct arm_smmu_s1_cfg *s1_cfg,
+				   struct arm_smmu_master *master,
 				   u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &s1_cfg->cdcfg;
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (s1_cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
@@ -1041,13 +1041,21 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
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
+/*
+ * master must be provided if a CD sync is required but may be null otherwise
+ * (such as when the CD table isn't inserted into the STE yet, or is about to
+ * be detached.
+ */
+int arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
+			    struct arm_smmu_s1_cfg *s1_cfg,
+			    struct arm_smmu_master *master,
+			    int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
 	/*
@@ -1065,10 +1073,10 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	bool cd_live;
 	__le64 *cdptr;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << s1_cfg->s1cdmax)))
 		return -E2BIG;
 
-	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	cdptr = arm_smmu_get_cd_ptr(smmu, s1_cfg, master, ssid);
 	if (!cdptr)
 		return -ENOMEM;
 
@@ -1092,11 +1100,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
-		 * order. Ensure that it observes valid values before reading
-		 * V=1.
+		 * STE may be live, and the SMMU might read dwords of this CD
+		 * in any order. Ensure that it observes valid values before
+		 * reading V=1.
 		 */
-		arm_smmu_sync_cd(smmu_domain, ssid, true);
+		arm_smmu_sync_cd(master, ssid, true);
 
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
@@ -1108,7 +1116,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->stall_enabled)
+		if (s1_cfg->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1122,7 +1130,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 *   without first making the structure invalid.
 	 */
 	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	arm_smmu_sync_cd(master, ssid, true);
 	return 0;
 }
 
@@ -1136,6 +1144,7 @@ static int arm_smmu_init_s1_cfg(struct arm_smmu_master *master,
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
 
 	cfg->s1cdmax = master->ssid_bits;
+	cfg->stall_enabled = master->stall_enabled;
 	max_contexts = 1 << cfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2093,8 +2102,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_init_s1_cfg(master, cfg);
 	if (ret)
 		goto out_free_asid;
@@ -2110,12 +2117,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	/*
-	 * Note that this will end up calling arm_smmu_sync_cd() before
-	 * the master has been added to the devices list for this domain.
-	 * This isn't an issue because the STE hasn't been installed yet.
-	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	ret = arm_smmu_write_ctx_desc(smmu, cfg,
+				      NULL /*Not attached to a master yet */,
+				      0, cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -2386,6 +2390,11 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
+	if (master->s1_cfg)
+		arm_smmu_write_ctx_desc(
+			master->smmu, master->s1_cfg,
+			NULL /* Skip sync since we detach the CD table next*/,
+			0, NULL);
 	master->s1_cfg = NULL;
 	master->s2_cfg = NULL;
 	arm_smmu_install_ste_for_dev(master);
@@ -2435,7 +2444,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->stall_enabled != master->stall_enabled) {
+		   smmu_domain->s1_cfg.stall_enabled !=
+			   master->stall_enabled) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c614fbe2b8b9..00a493442d6f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -595,6 +595,7 @@ struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
 	u8				s1fmt;
 	u8				s1cdmax;
+	bool				stall_enabled;
 };
 
 struct arm_smmu_s2_cfg {
@@ -713,7 +714,6 @@ struct arm_smmu_domain {
 	struct mutex				init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops			*pgtbl_ops;
-	bool					stall_enabled;
 	atomic_t				nr_ats_masters;
 
 	enum arm_smmu_domain_stage		stage;
@@ -742,7 +742,9 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+int arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
+			    struct arm_smmu_s1_cfg *s1_cfg,
+			    struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.41.0.162.gfafddb0af9-goog

