Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425687241C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbjFFMLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbjFFMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:11:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CEA170C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:11:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso98279107b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053465; x=1688645465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjUOU0DPHGHGmTP8anm43RkbEqkADC+hmHbnOauQw70=;
        b=udNKb9hwr0Kk9+BMB5itHj3lPHTSQqr87Qcscot19+Y4rmBCzb19uWrHkx/Yg/muYr
         MGnuG3BikPGCJJpxU6JP94pix6vlJnCu6PPp2wr+vKwfs8xuLQYo48h5eTdLrLdFCsDq
         lDUqnvfRISjHbk7HBIJh4zxYeGfUKG+Uh6XEG8xJGMiCYyuh31GHhpeObSF6rfLCWKMQ
         hSF6T73IH9AXGpQgRV9XBJv7cE02pjOCpymzblrPCUrYRuRkPT2C8bQDiH+m09tXB/7G
         mK8/B294f8Jybhs9wu6cVKkJO0K5faZneZGSNqaCMhqKBxcMW5E+WPg+FsoEqeUXUccd
         OJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053465; x=1688645465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjUOU0DPHGHGmTP8anm43RkbEqkADC+hmHbnOauQw70=;
        b=Zj3T8O1LJImgiLeXhu7zAnJb1CLv9iaD1YYG1qnjeRndYAOVL9cPlDCKXW+A+lws1u
         kne35cxt7YVprujrXSaxyVNShKguEa7YnHXkxurWEHqmHWCu641wRp29ZWc5zIdUGjb5
         nyQ0bbQ0EjsXqd5pssT7O795Zm4dVFDtqQeP5vnjVo7KAIGYcmNBUHQqEkbt8iebFEKv
         +nAl9/xS7GiPJDb+7WQJmDVV3NqFMtfDvNQmQyofGzZhWndRqbXWI8/FZlVreWnSfgVF
         4JCsGtHNhixpIfx/yJXpxXy/6E4yPj6T7ZfAIAb7c59GBQe90no26XaBXYOlZGWut+fh
         m4Tg==
X-Gm-Message-State: AC+VfDyZf+OSLjfWcFkXdrVrKGPEivyRPKcKTrSft5meWg/B0zG7frU9
        gJYVsj+ny7rqpDtntSw/faXdmOGNPLEg
X-Google-Smtp-Source: ACHHUZ7AhoR4YEqAAGrC5wUivVYgQiraCSATW/GS+5HPDvrEOFS63RxN2Qa/uS1DsH75Bn8LomG8TlzYehmQ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a25:ac4e:0:b0:ba8:5bdf:2e84 with SMTP id
 r14-20020a25ac4e000000b00ba85bdf2e84mr953711ybd.10.1686053465052; Tue, 06 Jun
 2023 05:11:05 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:51 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-16-mshavit@google.com>
Subject: [PATCH v2 15/18] iommu/arm-smmu-v3: Allow more re-use for SVA
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

Now that arm-smmu-v3.c supports attaching domains with pasid, SVA can
also re-use much of the same logic. This change allows SVA to allocate
arm_smmu_domains with a shared CD and attach them using the arm-smmu-v3
set_dev_pasid implementation.

Because these domains aren't backed by an iommu_domain we must make sure
that an arm_smmu_domain's backing iommu_domain isn't accessed on
functions used by SVA. A good rule here would be to allow
domain_finalize to access it.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 63 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 11 ++++
 2 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 69b1d09fd0284..3c5ff4f58934a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1926,7 +1926,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
-		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+		tg = __ffs(smmu_domain->smmu->pgsize_bitmap);
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
@@ -2053,6 +2053,14 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static void arm_smmu_init_smmu_domain(struct arm_smmu_domain *smmu_domain)
+{
+	mutex_init(&smmu_domain->init_mutex);
+	INIT_LIST_HEAD(&smmu_domain->attached_domains);
+	spin_lock_init(&smmu_domain->attached_domains_lock);
+	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
+}
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -2075,14 +2083,22 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (!smmu_domain)
 		return NULL;
 
-	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->attached_domains);
-	spin_lock_init(&smmu_domain->attached_domains_lock);
-	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
-
+	arm_smmu_init_smmu_domain(smmu_domain);
 	return &smmu_domain->domain;
 }
 
+struct arm_smmu_domain *
+arm_smmu_init_shared_cd_domain(struct arm_smmu_device *smmu,
+			       struct arm_smmu_domain *smmu_domain,
+			       struct arm_smmu_ctx_desc *cd)
+{
+	arm_smmu_init_smmu_domain(smmu_domain);
+	smmu_domain->smmu = smmu;
+	smmu_domain->stage = ARM_SMMU_DOMAIN_S1_SHARED_CD;
+	smmu_domain->shared_cd = cd;
+	return smmu_domain;
+}
+
 static int arm_smmu_bitmap_alloc(unsigned long *map, int span)
 {
 	int idx, size = 1 << span;
@@ -2541,11 +2557,9 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 				  struct device *dev, ioasid_t pasid)
 {
 	int ret = 0;
-	unsigned long flags;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_attached_domain *attached_domain;
 	struct arm_smmu_master *master;
 
 	if (!fwspec)
@@ -2558,6 +2572,18 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
+	return arm_smmu_domain_set_dev_pasid(dev, master, smmu_domain, pasid);
+}
+
+int arm_smmu_domain_set_dev_pasid(struct device *dev,
+				  struct arm_smmu_master *master,
+				  struct arm_smmu_domain *smmu_domain,
+				  ioasid_t pasid)
+{
+	unsigned long flags;
+	struct arm_smmu_attached_domain *attached_domain;
+	int ret;
+
 	if (pasid == 0) {
 		dev_err(dev, "pasid 0 is reserved for the device's primary domain\n");
 		return -ENODEV;
@@ -2991,12 +3017,8 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	struct iommu_domain *domain;
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct arm_smmu_domain *smmu_domain;
-	struct arm_smmu_attached_domain *attached_domain;
-	unsigned long flags;
 
-	if (!master || pasid == 0)
+	if (pasid == 0)
 		return;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
@@ -3005,7 +3027,20 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	if (domain->type == IOMMU_DOMAIN_SVA)
 		return arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 
-	smmu_domain = to_smmu_domain(domain);
+	arm_smmu_domain_remove_dev_pasid(dev, to_smmu_domain(domain), pasid);
+}
+
+void arm_smmu_domain_remove_dev_pasid(struct device *dev,
+				      struct arm_smmu_domain *smmu_domain,
+				      ioasid_t pasid)
+{
+	struct arm_smmu_attached_domain *attached_domain;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	unsigned long flags;
+
+	if (!master)
+		return;
+
 	mutex_lock(&arm_smmu_asid_lock);
 	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
 	list_for_each_entry(attached_domain, &smmu_domain->attached_domains, domain_head) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4ac69427abf1c..2c33c0461036d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -761,6 +761,17 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
 				 unsigned long iova, size_t size);
+int arm_smmu_domain_set_dev_pasid(struct device *dev,
+				  struct arm_smmu_master *master,
+				  struct arm_smmu_domain *smmu_domain,
+				  ioasid_t pasid);
+void arm_smmu_domain_remove_dev_pasid(struct device *dev,
+				      struct arm_smmu_domain *smmu_domain,
+				      ioasid_t pasid);
+struct arm_smmu_domain *
+arm_smmu_init_shared_cd_domain(struct arm_smmu_device *smmu,
+			       struct arm_smmu_domain *smmu_domain,
+			       struct arm_smmu_ctx_desc *cd);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.41.0.rc0.172.g3f132b7071-goog

