Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AA737BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjFUGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFUGqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:46:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728401992
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:45:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bce829aca1bso6009205276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329893; x=1689921893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iaiq8BTRsoloLG7rldnwk3G52sAWylq1kN+2LzQv5tM=;
        b=f2p4RRe6xTN7igEKKPHZGsDF92MIFONOcBrriUfaGfiU3ABD3qhOoJJOHan/Szh8sJ
         Kph4EWS3o0wtAioESPtVkWwEA9xFadSpa4206f5f3djBGbzfWOB1yGO3McRAFLPpCABM
         fvhSEzmduefkQzfFvvyoq4Ij4xlBU9yXRK8Lkbeizarjd2Ow4YKI2mXssopkMc4dGBkD
         uAd3/uApx4hTbP0KqhvPL1hTILkWXfRdIqXtfMtN7PIPEbOyvMIFFJeq1AN2pA1kVws8
         6R0dGFwCrLR2eZbdJbjNe6bcjYYwXVRTcsXyD48CL4OOgvxLnLwqOdLIqmLyHh29irfJ
         cesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329894; x=1689921894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iaiq8BTRsoloLG7rldnwk3G52sAWylq1kN+2LzQv5tM=;
        b=LjkyYlGoa17PLbGE6pIDhuH0GgDfJzIzBP/S25H6MG/AsPb7BvpWIAZ6TYAkZ2RejR
         ico26b8FfVIrhtnEpo3ckvlvyUtjLa7hhaFXsJoxDKO7v8TBq8iTR10ih5VeQCiJOXyz
         NdZFxO3jpwSMq1tNwWNJavmH5UGdYOyISCWcmRVcpGQ6T+kZNBjGzmw9nKhqEPPo6j1j
         JC7T3UCj8MFtG0J4XUQhi5Bz5Ci12zU2ntnJjLkF7xgYhiB4hjq2Fe6JD6IH5P1cYyE7
         j31nTvFZD7xoobdi2Uw9hNLIdGaBqiARAXU1+PyEb8SpUagNNk8yISHaQ8rTWMBT+ubw
         Ijzg==
X-Gm-Message-State: AC+VfDyMkCeqpcZ1eWNjfBJZ2t78tKAoPzbSszAH6wl18VOEc01lDDrD
        0ibfrkT7oybOLFmyWbzDwTj+ITLdJjhj
X-Google-Smtp-Source: ACHHUZ6DIszFBg7Jz5/qr1W0AVeQNCApk6Onqbv0M7i291vX3d/TmnbsUBoL2GYXPlET6GLZPqDom3YGK+aI
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:882:0:b0:bfe:ea69:91b4 with SMTP id
 124-20020a250882000000b00bfeea6991b4mr167148ybi.4.1687329893822; Tue, 20 Jun
 2023 23:44:53 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:24 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-13-mshavit@google.com>
Subject: [PATCH v4 12/13] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
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

There's a 1:1 relationship between arm_smmu_bond and the iommu_domain
used in set_dev_pasid/remove_dev_pasid. arm_smmu_bond has become an
unnecessary complication. It's more natural to store any needed
information at the iommu_domain container level.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 69 +++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 650c9c9ad52f1..b615a85e6a54e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
 
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
-struct arm_smmu_bond {
-	struct mm_struct		*mm;
+struct arm_smmu_sva_domain {
+	struct iommu_domain		iommu_domain;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
-	struct list_head		list;
 };
 
-#define sva_to_bond(handle) \
-	container_of(handle, struct arm_smmu_bond, sva)
+#define to_sva_domain(domain) \
+	container_of(domain, struct arm_smmu_sva_domain, iommu_domain)
 
 static DEFINE_MUTEX(sva_lock);
 
@@ -363,10 +362,10 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev,
+			       struct arm_smmu_sva_domain *sva_domain,
+			       struct mm_struct *mm)
 {
-	int ret;
-	struct arm_smmu_bond *bond;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -374,24 +373,14 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
-	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
-	if (!bond)
-		return -ENOMEM;
-
-	bond->mm = mm;
-
-	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
-	if (IS_ERR(bond->smmu_mn)) {
-		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_bond;
+	sva_domain->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain,
+							mm);
+	if (IS_ERR(sva_domain->smmu_mn)) {
+		sva_domain->smmu_mn = NULL;
+		return PTR_ERR(sva_domain->smmu_mn);
 	}
-
-	list_add(&bond->list, &master->bonds);
+	master->nr_attached_sva_domains += 1;
 	return 0;
-
-err_free_bond:
-	kfree(bond);
-	return ret;
 }
 
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
@@ -521,7 +510,7 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 {
 	mutex_lock(&sva_lock);
-	if (!list_empty(&master->bonds)) {
+	if (master->nr_attached_sva_domains != 0) {
 		dev_err(master->dev, "cannot disable SVA, device is bound\n");
 		mutex_unlock(&sva_lock);
 		return -EBUSY;
@@ -545,23 +534,12 @@ void arm_smmu_sva_notifier_synchronize(void)
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id)
 {
-	struct mm_struct *mm = domain->mm;
-	struct arm_smmu_bond *bond = NULL, *t;
+	struct arm_smmu_sva_domain *sva_domain = to_sva_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
 	mutex_lock(&sva_lock);
-	list_for_each_entry(t, &master->bonds, list) {
-		if (t->mm == mm) {
-			bond = t;
-			break;
-		}
-	}
-
-	if (!WARN_ON(!bond)) {
-		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		kfree(bond);
-	}
+	master->nr_attached_sva_domains -= 1;
+	arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
 	mutex_unlock(&sva_lock);
 }
 
@@ -572,7 +550,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	ret = __arm_smmu_sva_bind(dev, mm);
+	ret = __arm_smmu_sva_bind(dev, to_sva_domain(domain), mm);
 	mutex_unlock(&sva_lock);
 
 	return ret;
@@ -590,12 +568,11 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 
 struct iommu_domain *arm_smmu_sva_domain_alloc(void)
 {
-	struct iommu_domain *domain;
+	struct arm_smmu_sva_domain *sva_domain;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
+	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
+	if (!sva_domain)
 		return NULL;
-	domain->ops = &arm_smmu_sva_domain_ops;
-
-	return domain;
+	sva_domain->iommu_domain.ops = &arm_smmu_sva_domain_ops;
+	return &sva_domain->iommu_domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b928997d35ed3..2ed6c9e0df241 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2784,7 +2784,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 48795a7287b69..3525d60668c23 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -705,7 +705,7 @@ struct arm_smmu_master {
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
-	struct list_head		bonds;
+	unsigned int			nr_attached_sva_domains;
 	unsigned int			ssid_bits;
 	unsigned int			nr_attached_pasid_domains;
 };
-- 
2.41.0.162.gfafddb0af9-goog

