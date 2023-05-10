Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C776FE5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjEJUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbjEJUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:52:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FC2691
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-52c219bf675so4144463a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751882; x=1686343882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ydbIuDbfoHmFVfOIEtd0qpW93a6R3EVtBtLPsHyXDc=;
        b=e4JtwHGiJHq7PmJTlD5WKq6S+5A77DPe5iCNOUZU56syCxRB7l63NwGg/OLGtwFgsQ
         Qe+cP/9GKpMkvMOZGwyN2gGyWlpjcUVr86r5vqBlxoCMoPGsbdrTxk0ta8EHe5GNvfm/
         IS/VuzvPd2qCMHdRQVR6/o1XRjslR4/Fkwi/yad75djwGWxySp6RJcIpxEMBs+C38Erj
         yYtgPUkLI3X+dLe5LYkq0uJlJmTtdtBoTj2X49Fyk7XEopSvSou6aP/QtG52tPJmlHMk
         hgQCARC94lLNFrqC+4GUoFkhyXIV/v6egX+ji/fUdxp9XdvOVjwvMD4HWE1D5Lc79YSO
         fapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751882; x=1686343882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ydbIuDbfoHmFVfOIEtd0qpW93a6R3EVtBtLPsHyXDc=;
        b=MMmds02keKbtZEZrgfqmxiYROnGmGIvKrLe/bmZXDTZ2VO8DfzEAiW1+67BygBLzVs
         pJtq4PA3Phx3ORnoBDH3kJsScT50wFlhYlTQH1CvwDdsNcegakRKJ27xca3ODGk+CGCf
         fMGziWue5tb51rtdzT9eiO/2xeXHpKDbGHZctb+kFVIGCUKv3WAu1cE2QVLc0M8v9Aq2
         Ds6s7NvCS+H2rF8lIJ6zSjzvkxeh0/TnAkHNYOsxME057+PFDxSBNHB7yVokMAaF2eiI
         hwrrPwwp4mPhrDNv6C5SYN8sy+T7cfRhafpVU6DfTbIWRocQsvOY1IUAnthSrBLaxF5b
         B6LA==
X-Gm-Message-State: AC+VfDwjZU9OVNBK6+H+Qj3NOietsg5gH2eh8PFJt6u8YV++0v3mzk/K
        Lz6GAXmfJ6K/9X188+nvL6F6HiW93C2o
X-Google-Smtp-Source: ACHHUZ4HRYFo0bOiYit1iSwb44uTaVEh4vg5c7cvnwD/wJk/qgd4VNNQyfgezrl2XUut9xvdytYOkOhY6bxY
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a63:80c8:0:b0:52c:bf5b:69ee with SMTP id
 j191-20020a6380c8000000b0052cbf5b69eemr4642357pgd.4.1683751882168; Wed, 10
 May 2023 13:51:22 -0700 (PDT)
Date:   Thu, 11 May 2023 04:50:51 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-5-mshavit@google.com>
Subject: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
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

The arm-smmu-v3 driver keeps track of all masters that a domain is
attached so that it can re-write their STEs when the domain's ASID is
upated by SVA. This tracking is also used to invalidate ATCs on all
masters that a domain is attached.

This change introduces a new data structures to track all the CD entries
that a domain is attached to. This change is a pre-requisite to allow
domain attachment on non 0 SSIDs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 31 ++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 90 ++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 17 ++--
 3 files changed, 89 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a721461b355c6..2eb066c0f3f99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -53,7 +53,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
-	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
 	if (!cd)
@@ -85,11 +85,11 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		arm_smmu_write_ctx_desc(master, 0, cd);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains, domain_head) {
+		arm_smmu_write_ctx_desc(attached_domain->master, attached_domain->ssid, cd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -213,14 +213,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 	unsigned long flags;
 
 	mutex_lock(&sva_lock);
@@ -233,14 +233,19 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		arm_smmu_write_ctx_desc(master, mm->pasid, &quiet_cd);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains, domain_head) {
+		/*
+		 * SVA domains piggyback on the attached_domain with SSID 0.
+		 */
+		if (attached_domain->ssid == 0)
+			arm_smmu_write_ctx_desc(attached_domain->master,
+						mm->pasid, &quiet_cd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -329,7 +334,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_master *master,
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 47dda287a4736..81f49a86c1266 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1703,7 +1703,16 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 }
 
 static void
-arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+arm_smmu_atc_inv_cmd_set_ssid(int ssid, struct arm_smmu_cmdq_ent *cmd)
+{
+	*cmd = (struct arm_smmu_cmdq_ent) {
+		.substream_valid	= !!ssid,
+		.atc.ssid		= ssid,
+	};
+}
+
+static void
+arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 			struct arm_smmu_cmdq_ent *cmd)
 {
 	size_t log2_span;
@@ -1728,8 +1737,8 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
-		.substream_valid	= !!ssid,
-		.atc.ssid		= ssid,
+		.substream_valid	= false,
+		.atc.ssid		= 0,
 	};
 
 	if (!size) {
@@ -1775,8 +1784,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
-
+	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1786,13 +1794,21 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size)
+/*
+ * If ssid is 0, the domain is invalidated on all SSIDs that it is attached to.
+ * Otherwise, the domain is specifically invalidated on the provided SSID only.
+ * This second functionality is provided specifically for SVA which wants to
+ * invalidate domains on SSIDs that aren't recorded in the master's
+ * attached_domains list.
+ */
+int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
+				 unsigned long iova, size_t size)
 {
 	int i;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 	struct arm_smmu_cmdq_batch cmds;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
@@ -1815,25 +1831,35 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+	arm_smmu_atc_inv_to_cmd(iova, size, &cmd);
+	if (ssid != 0)
+		arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
 
 	cmds.num = 0;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains, domain_head) {
+		master = attached_domain->master;
 		if (!master->ats_enabled)
 			continue;
-
+		if (ssid == 0)
+			arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
 		}
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size)
+{
+	return arm_smmu_atc_inv_domain_ssid(smmu_domain, 0, iova, size);
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
@@ -1855,7 +1881,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
@@ -1943,7 +1969,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
+	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
 }
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
@@ -2023,8 +2049,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->attached_domains);
+	spin_lock_init(&smmu_domain->attached_domains_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
@@ -2259,12 +2285,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
-static void arm_smmu_enable_ats(struct arm_smmu_master *master)
+static void arm_smmu_enable_ats(struct arm_smmu_master *master,
+				struct arm_smmu_domain *smmu_domain)
 {
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
 	if (!master->ats_enabled)
@@ -2280,10 +2306,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-static void arm_smmu_disable_ats(struct arm_smmu_master *master)
+static void arm_smmu_disable_ats(struct arm_smmu_master *master,
+				 struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = master->domain;
-
 	if (!master->ats_enabled)
 		return;
 
@@ -2347,20 +2372,21 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct arm_smmu_domain *smmu_domain = master->attached_domain.domain;
 
 	if (!smmu_domain)
 		return;
 
-	arm_smmu_disable_ats(master);
+	arm_smmu_disable_ats(master, smmu_domain);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_del(&master->attached_domain.domain_head);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	master->ats_enabled = false;
 	master->s2_cfg = NULL;
 	master->has_stage1 = false;
+	master->attached_domain.domain = NULL;
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() even though
 	 * we're about to destroy the entire STE anyways. This is ok because
@@ -2436,14 +2462,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	master->domain = smmu_domain;
+	master->attached_domain.master = master;
+	master->attached_domain.domain = smmu_domain;
+	master->attached_domain.ssid = 0;
 	arm_smmu_install_ste_for_dev(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_add(&master->attached_domain.domain_head, &smmu_domain->attached_domains);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
-	arm_smmu_enable_ats(master);
+	arm_smmu_enable_ats(master, smmu_domain);
 
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d715794572b13..35700534a0b4a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -681,11 +681,18 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_attached_domain {
+	struct list_head domain_head;
+	struct arm_smmu_master *master;
+	int ssid;
+	struct arm_smmu_domain *domain;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_domain		*domain;
+	struct arm_smmu_attached_domain	attached_domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	struct arm_smmu_s1_cfg		s1_cfg;
@@ -724,8 +731,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain			domain;
 
-	struct list_head			devices;
-	spinlock_t				devices_lock;
+	struct list_head			attached_domains;
+	spinlock_t				attached_domains_lock;
 
 	struct list_head			mmu_notifiers;
 };
@@ -746,8 +753,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size);
+int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
+				 unsigned long iova, size_t size);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.40.1.521.gf1e218fcd8-goog

