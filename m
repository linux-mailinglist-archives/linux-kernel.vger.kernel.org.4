Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB97241C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbjFFMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbjFFMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:11:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B03910E0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:11:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568a8704f6dso89530197b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053472; x=1688645472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8coPEvUwDlKI+G80MftH9xxXZgTa0epa7omkndSMHA=;
        b=vWzHFe+f6b0SO9ZjCJqoUru52xdUuNnZIq6LnMnCtriPlDLRJZ18LiSlZY3NpYKKCf
         nMe/iV6ctP3Oz5SwfbarLiRIxyCChHxJbaf7V04aWyS1M/t6tk7jjopXLvNz/UIoBA5O
         CDebWGr2/1v3E1fW0PClyPNl068DVDA6EOjD4ZobvbmF2BTjWvCkGSao48mifbZOWmNb
         /QyrEUnZXV/JMNSnzX++RYhSbPNvVocemSoVMQNs4El0N9p5AXTml140OsqVQ7c5W4kG
         b1q7xBiEzKY39mS8kM2Bpbgxd/iihYyrRoZV2ieeGptRuyuSzNFCxplOVUU1visxhY6O
         kFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053472; x=1688645472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8coPEvUwDlKI+G80MftH9xxXZgTa0epa7omkndSMHA=;
        b=QOHVQnB8FCcO888UljWUwkjV6GHCDmC11YLLGXp2SPMpFjBdktErzJKGyZR5kDd5Gb
         KV54nGqXtd/PtOv7G1cLR386CsrJK+oa3nCuNGmq0eHXXWAMW12HmlMg02krtTVZSxEA
         sRk9CutDc7qjkJXyhgzlAZp8Or+vwJpgLj7DHQnAujD+HGbxmU7FG7x48GoOEiLWgmuB
         fMGEtYLAzwgxbtscbx/K2SREx1EaZhPhk9Vpztxd2aw6AU2y7cg+iyZERowZT56u/iXe
         VCwrx0HaJKc031JvtHB2qmeAAJnJgu5AuJjGp4MRZEY3J52ZteAkgvbSrGNusv++6MPx
         eqKw==
X-Gm-Message-State: AC+VfDz2lT7v07PHGE+ImxOqHj7se8kdNychY2SJNiRZL5QRfTFaroz1
        2wHgLgMQP4/JFhylY3z+4pWNV96KhvGS
X-Google-Smtp-Source: ACHHUZ4yVw8kxBQaZNeJJwBixm7xdLTIiPMzfDmRrqmi1UCOSbaEkRgUbl8QYue0ANyIEacYietJ03+RyloM
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a81:ad1c:0:b0:55d:6af3:1e2c with SMTP id
 l28-20020a81ad1c000000b0055d6af31e2cmr959734ywh.3.1686053472400; Tue, 06 Jun
 2023 05:11:12 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:52 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-17-mshavit@google.com>
Subject: [PATCH v2 16/18] iommu/arm-smmu-v3-sva: Attach S1_SHARED_CD domain
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

Prepare an smmu domain of type S1_SHARED_CD per smmu_mmu_notifier.
Attach that domain using the common arm_smmu_domain_set_dev_pasid
implementation when attaching an SVA domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 67 ++++++-------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e2a91f20f0906..9a2da579c3563 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -19,7 +19,7 @@ struct arm_smmu_mmu_notifier {
 	bool				cleared;
 	refcount_t			refs;
 	struct list_head		list;
-	struct arm_smmu_domain		*domain;
+	struct arm_smmu_domain		domain;
 };
 
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
@@ -198,7 +198,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 unsigned long start, unsigned long end)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_domain *smmu_domain = &smmu_mn->domain;
 	size_t size;
 
 	/*
@@ -217,7 +217,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_domain *smmu_domain = &smmu_mn->domain;
 	struct arm_smmu_master *master;
 	struct arm_smmu_attached_domain *attached_domain;
 	unsigned long flags;
@@ -233,15 +233,10 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * but disable translation.
 	 */
 	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
-	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
-			    domain_head) {
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains, domain_head) {
 		master = attached_domain->master;
-		/*
-		 * SVA domains piggyback on the attached_domain with SSID 0.
-		 */
-		if (attached_domain->ssid == 0)
-			arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg,
-						master, mm->pasid, &quiet_cd);
+		arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
+					attached_domain->ssid, &quiet_cd);
 	}
 	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
@@ -265,15 +260,13 @@ static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 
 /* Allocate or get existing MMU notifier for this {domain, mm} pair */
 static struct arm_smmu_mmu_notifier *
-arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
+arm_smmu_mmu_notifier_get(struct arm_smmu_device *smmu,
+			  struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
-	unsigned long flags;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
-	struct arm_smmu_master *master;
-	struct arm_smmu_attached_domain *attached_domain;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -294,7 +287,6 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
 	refcount_set(&smmu_mn->refs, 1);
 	smmu_mn->cd = cd;
-	smmu_mn->domain = smmu_domain;
 	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
 
 	ret = mmu_notifier_register(&smmu_mn->mn, mm);
@@ -302,24 +294,11 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		kfree(smmu_mn);
 		goto err_free_cd;
 	}
-
-	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
-	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
-			    domain_head) {
-		master = attached_domain->master;
-		ret = arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg,
-					      master, mm->pasid, cd);
-	}
-	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
-	if (ret)
-		goto err_put_notifier;
+	arm_smmu_init_shared_cd_domain(smmu, &smmu_mn->domain, cd);
 
 	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
 	return smmu_mn;
 
-err_put_notifier:
-	/* Frees smmu_mn */
-	mmu_notifier_put(&smmu_mn->mn);
 err_free_cd:
 	arm_smmu_free_shared_cd(cd);
 	return ERR_PTR(ret);
@@ -327,27 +306,15 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
 static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
-	unsigned long flags;
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
-	struct arm_smmu_attached_domain *attached_domain;
-	struct arm_smmu_master *master;
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_domain *smmu_domain = &smmu_mn->domain;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
 
-	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
-	list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
-			    domain_head) {
-		master = attached_domain->master;
-		arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
-					mm->pasid, NULL);
-	}
-	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
-
 	/*
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
@@ -369,17 +336,26 @@ static int __arm_smmu_sva_bind(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	int ret;
 
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
-	sva_domain->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain,
+	sva_domain->smmu_mn = arm_smmu_mmu_notifier_get(master->smmu,
+							smmu_domain,
 							mm);
 	if (IS_ERR(sva_domain->smmu_mn)) {
 		sva_domain->smmu_mn = NULL;
 		return PTR_ERR(sva_domain->smmu_mn);
 	}
+
 	master->nr_attached_sva_domains += 1;
+	smmu_domain = &sva_domain->smmu_mn->domain;
+	ret = arm_smmu_domain_set_dev_pasid(dev, master, smmu_domain, mm->pasid);
+	if (ret) {
+		arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
+		return ret;
+	}
 	return 0;
 }
 
@@ -544,8 +520,9 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
 	mutex_lock(&sva_lock);
-	master->nr_attached_sva_domains -= 1;
+	arm_smmu_domain_remove_dev_pasid(dev, &sva_domain->smmu_mn->domain, id);
 	arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
+	master->nr_attached_sva_domains -= 1;
 	mutex_unlock(&sva_lock);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

