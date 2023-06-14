Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB03D7241BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjFFMKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbjFFMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:10:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0D1703
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:10:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so9694091276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053407; x=1688645407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xd2apE9I9Ql686K5E2cINv1GKkymHr8pAPZ24057YLo=;
        b=dUvBUGJ2uTFCpl8ZzYeV2M0aI5C148+z57kDrwYIZVrDrrDOTlwtK/k6da1JB47kly
         YHAETWdmnBmikZon7aFfK/ZKCgh4Enp6nkCmTtT5GvNqpLkDH2PgvgWfMhbmn6mgG7Kw
         An5suNQm3aoYqek50TCwOmQWe00ojcep/USlSNuwDmRCo9E8r0d6RG4bQu4fcFT6/OzN
         8RUmKOHjiuRYxpF1976rRclQJRTy6zUNQJjRUEDHb/5iXfGsp33uXLP9ViCApsZtuT26
         YCEq7EKWHDuJioM1w3nhhLDclVMfd+l5MQuVPq2qMPNzfworQYfG1hk0tMuJ40k2YsfJ
         NgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053407; x=1688645407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xd2apE9I9Ql686K5E2cINv1GKkymHr8pAPZ24057YLo=;
        b=g1sg38AMd5WXVhHkf/NG4D8iCOpQR4k+ds0nU0zpKc/VIFXh87e8igzoSJ9B6je1vN
         JkkfNxxKZ5vuGfW7QgJwlkTB3ZYFATNoP6cCzoJgFtMuW67a5hFlwERDqIFqAf1C96q4
         /6FFmsnxFYGzNG3zIsxhcm9PN/t60DVCjdah8ctXcay2PdjeBfTh7tZVqS+KcIT8udYB
         jSX+klS9Y/Hc8AE14s1NO9UntuCxy2fvYzVBFEuQJdYgjrlFP3H6edeB8C5Q4fW9PmyW
         iAMxFdGoUyes5U15qb4BUz7WwkfYPmrqqdDFDT/FugrEfA8eqjtUxb8knXtK625fTodV
         RkDw==
X-Gm-Message-State: AC+VfDzGiFe6X5PskwJpbdNobIIcALa6womVjIQInIZoOiatclYM42cN
        xKYNFmUS4rnf3UwyAOMD8YAvdMqJ0UXp
X-Google-Smtp-Source: ACHHUZ42r0IDYsLBXWt9XxFV7szayDqyBwH+j4RbI/1aUPDRFaWDF/S14ZoUu60ryXiFEZUoFZvsGSvsWE8Q
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:10c8:b0:ba8:797c:9bc7 with SMTP
 id w8-20020a05690210c800b00ba8797c9bc7mr1064923ybu.11.1686053407816; Tue, 06
 Jun 2023 05:10:07 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:43 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-8-mshavit@google.com>
Subject: [PATCH v2 07/18] iommu/arm-smmu-v3: Keep track of attached ssids
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

The arm-smmu-v3 driver keeps track of all masters that a domain is
attached to so that it can re-write their STEs when the domain's ASID is
upated by SVA. This tracking is also used to invalidate ATCs on all
masters that a domain is attached to.

This change introduces a new data structures to track all the CD entries
that a domain is attached to. This change is a pre-requisite to allow
domain attachment on non 0 SSIDs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
The arm_smmu_atc_inv_domain_ssid function is only temporarily introduced to make
these changes atomic, but is eventually removed in latter SVA refactoring
patches.

v1->v2: Fix arm_smmu_atc_inv_cmd_set_ssid and other cosmetic changes

---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 53 +++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 88 ++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++--
 3 files changed, 105 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 48fa8eb271a45..d07c08b53c5cf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -51,6 +51,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
 	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
 	if (!cd)
@@ -82,11 +83,14 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		arm_smmu_write_ctx_desc(smmu, master->s1_cfg, master, 0, cd);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
+			    domain_head) {
+		master = attached_domain->master;
+		arm_smmu_write_ctx_desc(smmu, master->s1_cfg, master,
+					attached_domain->ssid, cd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -210,7 +214,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -218,6 +222,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
 	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 	unsigned long flags;
 
 	mutex_lock(&sva_lock);
@@ -230,15 +235,21 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
-					mm->pasid, &quiet_cd);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
+			    domain_head) {
+		master = attached_domain->master;
+		/*
+		 * SVA domains piggyback on the attached_domain with SSID 0.
+		 */
+		if (attached_domain->ssid == 0)
+			arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg,
+						master, mm->pasid, &quiet_cd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -265,6 +276,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
 	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -294,12 +306,14 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
+			    domain_head) {
+		master = attached_domain->master;
 		ret = arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg,
 					      master, mm->pasid, cd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 	if (ret)
 		goto err_put_notifier;
 
@@ -319,6 +333,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	unsigned long flags;
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
+	struct arm_smmu_attached_domain *attached_domain;
 	struct arm_smmu_master *master;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
 
@@ -327,12 +342,14 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 	list_del(&smmu_mn->list);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
+			    domain_head) {
+		master = attached_domain->master;
 		arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
 					mm->pasid, NULL);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
@@ -340,7 +357,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dc7a59e87a2b4..70580ba7065dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1711,7 +1711,14 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 }
 
 static void
-arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+arm_smmu_atc_inv_cmd_set_ssid(int ssid, struct arm_smmu_cmdq_ent *cmd)
+{
+	cmd->substream_valid = !!ssid;
+	cmd->atc.ssid = ssid;
+}
+
+static void
+arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 			struct arm_smmu_cmdq_ent *cmd)
 {
 	size_t log2_span;
@@ -1736,8 +1743,8 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
-		.substream_valid	= !!ssid,
-		.atc.ssid		= ssid,
+		.substream_valid	= false,
+		.atc.ssid		= 0,
 	};
 
 	if (!size) {
@@ -1783,8 +1790,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
-
+	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1794,13 +1800,19 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size)
+/*
+ * If ssid is non-zero, issue atc invalidations with the given ssid instead of
+ * the one the domain is attached to. This is used by SVA since it's pasid
+ * attachments aren't recorded in smmu_domain yet.
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
@@ -1823,25 +1835,37 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+	arm_smmu_atc_inv_to_cmd(iova, size, &cmd);
 
 	cmds.num = 0;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
+			    domain_head) {
+		master = attached_domain->master;
 		if (!master->ats_enabled)
 			continue;
+		if (ssid != 0)
+			arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
+		else
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
@@ -1863,7 +1887,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
@@ -1951,7 +1975,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
+	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
 }
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
@@ -2031,8 +2055,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->attached_domains);
+	spin_lock_init(&smmu_domain->attached_domains_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
@@ -2270,12 +2294,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
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
@@ -2291,10 +2315,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
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
 
@@ -2358,18 +2381,17 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct arm_smmu_domain *smmu_domain = master->non_pasid_domain.domain;
 
 	if (!smmu_domain)
 		return;
 
-	arm_smmu_disable_ats(master);
+	arm_smmu_disable_ats(master, smmu_domain);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_del(&master->non_pasid_domain.domain_head);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
-	master->domain = NULL;
 	master->ats_enabled = false;
 	if (master->s1_cfg)
 		arm_smmu_write_ctx_desc(
@@ -2378,6 +2400,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 			0, NULL);
 	master->s1_cfg = NULL;
 	master->s2_cfg = NULL;
+	master->non_pasid_domain.domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
 }
 
@@ -2422,7 +2445,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
-	master->domain = smmu_domain;
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		master->s1_cfg = &master->owned_s1_cfg;
 		ret = arm_smmu_write_ctx_desc(
@@ -2449,13 +2471,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
+	master->non_pasid_domain.master = master;
+	master->non_pasid_domain.domain = smmu_domain;
+	master->non_pasid_domain.ssid = 0;
 	arm_smmu_install_ste_for_dev(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_add(&master->non_pasid_domain.domain_head,
+		 &smmu_domain->attached_domains);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
-	arm_smmu_enable_ats(master);
+	arm_smmu_enable_ats(master, smmu_domain);
 
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dff0fa8345462..6929590530367 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -682,11 +682,19 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+/* List of {masters, ssid} that a domain is attached to */
+struct arm_smmu_attached_domain {
+	struct list_head	domain_head;
+	struct arm_smmu_domain  *domain;
+	struct arm_smmu_master  *master;
+	int			ssid;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_domain		*domain;
+	struct arm_smmu_attached_domain	non_pasid_domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	struct arm_smmu_s1_cfg		owned_s1_cfg;
@@ -724,8 +732,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain			domain;
 
-	struct list_head			devices;
-	spinlock_t				devices_lock;
+	struct list_head			attached_domains;
+	spinlock_t				attached_domains_lock;
 
 	struct list_head			mmu_notifiers;
 };
@@ -748,8 +756,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
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
2.41.0.rc0.172.g3f132b7071-goog

