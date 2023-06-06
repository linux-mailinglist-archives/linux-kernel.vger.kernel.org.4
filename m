Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C887241CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbjFFMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbjFFMLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:11:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A04E7E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:11:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacd408046cso8996937276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053486; x=1688645486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=690IhMaVKQOheawjxO/ZDJYW5nna84UvkxSb29OMpJY=;
        b=eW2xKOUzDLrIwpVZxF6w1AffFH+eybFfzAor2EtdG3o/dhStpX5h+hko1PkiB6GL7y
         mmS6o7zPFxcUQRSRX5DG/d0PY60IviKLBvNBEtNsYPu/n5rjxNTwETco8yESLc1KVOOd
         wk+YW7cQw9e9JkvXKhVdJLpbLQn3z9yJ/KLwX3YpX8iS5O24ALewvrvR0jWyO9RzWlM8
         oBsNOOWQlcWJkiplzzMhLA+1nJr7ffwmXaxT30h7zIprl7PUkqEBHdk4bIQdyCKLuL2P
         Z/jOGUaNT82GRH9Ra+nCHqqwczwcKPcwLQGL1DiptDxhlo6Fn6zbRcEFclgC4GlKyr69
         EAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053486; x=1688645486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=690IhMaVKQOheawjxO/ZDJYW5nna84UvkxSb29OMpJY=;
        b=c38LxmX0rNOL/BHIerVNR4eiW0/pZYwKtQoMWXee+YMCc9CeyYb2CWcuPEvsNaBBzw
         Zg21+UhoidQ0C7hGipIosa6zC02xkyupNEmdhi/bGshbblmga3LhqIfBoG0uimKutMRx
         BCvjvexITCXLDdTvmrBGO/xXvMJdcqyJpp+gHKOobllOZP1MgWUhAKrZiHWevYK3uxwh
         AwMc4cThRTYDHDI6KwEsQmRGWypzu3tpI0W6Bbo1koYcKiD68BFWpEaygVzg2LXJR0Fu
         1nZfMt57zGH9x/07Zrw424TvlwHplZSJgLsxQ9cDJwZ7nEY0poNdbe4rptoDQI05kBeW
         CwHQ==
X-Gm-Message-State: AC+VfDxnnQ/3mLpPj7K8Xlb6XG+Ow1bK9xnvNsWs2Lmy0j0rciagbZmX
        tBGdnz9lmTvDGuyhaF61I3qpzBatirqE
X-Google-Smtp-Source: ACHHUZ4AJPXtcMUNlSjrot0SIGIe1VeYT3TxZRBKLGtRsB13dquq7jBw5UDlIYSeITtYdyny8gcWeIoq4RF3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:100b:b0:bad:600:1833 with SMTP id
 w11-20020a056902100b00b00bad06001833mr1035863ybt.0.1686053486705; Tue, 06 Jun
 2023 05:11:26 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:54 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-19-mshavit@google.com>
Subject: [PATCH v2 18/18] iommu/arm-smmu-v3-sva: Remove atc_inv_domain_ssid
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

arm_smmu_atc_inv_domain is sufficient in all cases now that
arm_smmu_domain always tracks all the master/ssids that it is attached
to. Also remove the last usage of mm->pasid in arm-smmu-v3-sva.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  9 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 +++----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++--
 3 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 3e49838e4f55c..5a124281bbef6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -211,7 +211,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
-	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -241,7 +241,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -304,7 +304,6 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_device *smmu,
 
 static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
-	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = &smmu_mn->domain;
 
@@ -318,7 +317,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 	}
 
 	/* Frees smmu_mn */
@@ -347,7 +346,7 @@ static int __arm_smmu_sva_bind(struct device *dev,
 
 	master->nr_attached_sva_domains += 1;
 	smmu_domain = &sva_domain->smmu_mn->domain;
-	ret = arm_smmu_domain_set_dev_pasid(dev, master, smmu_domain, mm->pasid);
+	ret = arm_smmu_domain_set_dev_pasid(dev, master, smmu_domain, id);
 	if (ret) {
 		arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e68c5264c6171..1e02e73e586f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1821,13 +1821,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_atc_inv_master_ssid(master, 0);
 }
 
-/*
- * If ssid is non-zero, issue atc invalidations with the given ssid instead of
- * the one the domain is attached to. This is used by SVA since it's pasid
- * attachments aren't recorded in smmu_domain yet.
- */
-int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
-				 unsigned long iova, size_t size)
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size)
 {
 	int i;
 	unsigned long flags;
@@ -1866,11 +1861,7 @@ int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
 		master = attached_domain->master;
 		if (!master->ats_enabled)
 			continue;
-		if (ssid != 0)
-			arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
-		else
-			arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
-
+		arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
@@ -1881,12 +1872,6 @@ int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-			    unsigned long iova, size_t size)
-{
-	return arm_smmu_atc_inv_domain_ssid(smmu_domain, 0, iova, size);
-}
-
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 041b0e532ac3d..9c382bc8c0549 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -759,8 +759,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
-int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
-				 unsigned long iova, size_t size);
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size);
 int arm_smmu_domain_set_dev_pasid(struct device *dev,
 				  struct arm_smmu_master *master,
 				  struct arm_smmu_domain *smmu_domain,
-- 
2.41.0.rc0.172.g3f132b7071-goog

