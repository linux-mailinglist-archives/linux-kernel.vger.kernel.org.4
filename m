Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43833730418
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbjFNPp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245105AbjFNPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:45:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B843296C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:44:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6662fcaac6dso859945b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757478; x=1689349478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zp8WWvGOizfWW9ZsurLF24HEAfBobFq4bOmSr8VWFOI=;
        b=P33CVxX4esw3dBSK5S17bbxhmwwXbDXFc5BNId/SskkIfaAcUMv/viU+8T/DGWsJKX
         W9bktuoWVfSWVcE8R8uDRfAvQ4J8cBGtPOqgyU2/iC9WsioU9cykfvXPVsg70c2BTtRO
         Gn53yG3SbQkxPaXuBcq5feCokxIsGkfeR1AnKvxlwKGyvIJf18/P/bs0RKpu0Zo9BCVG
         RFqiWZSuLLIGNb+GzEW5JjCnRYL4iGTuffbe32LPPmJP0d7z/jH5V0+foHmxOBBmhJ2e
         B2976zpIyp5dSuDIvhNrhiaSnDq4OVl9P5ifH6jbPCuE4HSZXUETXYqnZp7CStHkqLdk
         cEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757478; x=1689349478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp8WWvGOizfWW9ZsurLF24HEAfBobFq4bOmSr8VWFOI=;
        b=ewVySoioK0NDby4k6HRZCHJoXXwY2qZsYlPtygOMI+UEZ3XKjmwHwxwHDqP8ypL2s2
         K1iVf5fmkQx02nAGzlYmn9QiKnteJtxsNdBp32NS0asL1OTUjoh0980lKnip8mNhI7x0
         dd/YsfS6nHmB5oWq8yTJzKA+2tN8mA/2nADmlUGplbXgKJfIRfDPttUu8/DfoVW1ysn5
         vxjF5FtQ0O1J/JImpiQwPargC5YQPf4GAkdizwXHNGkCng8m2mDMy+TiEKZv+wAYXS1K
         xu6nhENKAgw2LqX07lJ6MuSj+nKr+tuRTQvhwUgDXOF3fbMdwSao670dGvDloTyBf97i
         7new==
X-Gm-Message-State: AC+VfDzEYM0WrU3H3ZEbImb2xF8HEae5Z5jTVCNlePYqPpZOm84ihLFe
        /8Xq2uXz5FhG8VF375l7pgtYtvaeEcjj
X-Google-Smtp-Source: ACHHUZ7oWcQmm2W8o0FHztY9pz4yhQmPGX8vnYdXZ3QyFdJYkZqNWjsWL87VFkksLupGG9fw4PhBms4uMnVQ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a05:6a00:1513:b0:64f:c0b1:6967 with SMTP
 id q19-20020a056a00151300b0064fc0b16967mr682372pfu.1.1686757478685; Wed, 14
 Jun 2023 08:44:38 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:42:01 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-10-mshavit@google.com>
Subject: [PATCH v3 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
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

This change enables the use of the iommu_attach_dev_pasid API for
UNMANAGED domains. The primary use-case is to allow in-kernel users of
the iommu API to manage domains with PASID. This change also allows for
future support of pasid in the DMA api.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Add missing atc invalidation when detaching with pasid
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 168 +++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 2 files changed, 149 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 176013bb974b8..a6fa56585c219 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2173,6 +2173,10 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+/*
+ * master may be null for domain types that are finalized before being attached
+ * to a master.
+ */
 static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 				    struct arm_smmu_master *master)
 {
@@ -2369,6 +2373,11 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	return 0;
 }
 
+static bool arm_smmu_master_has_pasid_domains(struct arm_smmu_master *master)
+{
+	return master->nr_attached_pasid_domains > 0;
+}
+
 static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 {
 	struct pci_dev *pdev;
@@ -2411,6 +2420,28 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	arm_smmu_install_ste_for_dev(master);
 }
 
+/*
+ * Once attached for the first time, a domain can no longer be attached to any
+ * master with a distinct upstream SMMU.
+ */
+static int arm_smmu_prepare_domain_for_smmu(struct arm_smmu_device *smmu,
+					    struct arm_smmu_domain *smmu_domain)
+{
+	int ret = 0;
+
+	mutex_lock(&smmu_domain->init_mutex);
+	if (!smmu_domain->smmu) {
+		smmu_domain->smmu = smmu;
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain, NULL);
+		if (ret)
+			smmu_domain->smmu = NULL;
+	} else if (smmu_domain->smmu != smmu) {
+		ret = -EINVAL;
+	}
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2426,6 +2457,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain);
+	if (ret)
+		return ret;
+
 	/*
 	 * Checking that SVA is disabled ensures that this device isn't bound to
 	 * any mm, and can be safely detached from its old domain. Bonds cannot
@@ -2436,22 +2471,18 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EBUSY;
 	}
 
-	arm_smmu_detach_dev(master);
-
-	mutex_lock(&smmu_domain->init_mutex);
-
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
-		if (ret) {
-			smmu_domain->smmu = NULL;
-			goto out_unlock;
-		}
-	} else if (smmu_domain->smmu != smmu) {
-		ret = -EINVAL;
-		goto out_unlock;
+	/*
+	 * Attaching a bypass or stage 2 domain would break any domains attached
+	 * with pasid. Attaching an S1 domain should be feasible but requires
+	 * more complicated logic to handle.
+	 */
+	if (arm_smmu_master_has_pasid_domains(master)) {
+		dev_err(dev, "cannot attach - domain attached with pasid\n");
+		return -EBUSY;
 	}
 
+	arm_smmu_detach_dev(master);
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		master->s1_cfg = &master->owned_s1_cfg;
 		ret = arm_smmu_write_ctx_desc(
@@ -2460,8 +2491,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			0, &smmu_domain->cd);
 		if (ret) {
 			master->s1_cfg = NULL;
-			master->domain = NULL;
-			goto out_unlock;
+			return ret;
 		}
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
 		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
@@ -2490,11 +2520,75 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	arm_smmu_enable_ats(master, smmu_domain);
 
-out_unlock:
-	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
 }
 
+static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t pasid)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_attached_domain *attached_domain;
+	struct arm_smmu_master *master;
+
+	if (!fwspec)
+		return -ENOENT;
+
+	master = dev_iommu_priv_get(dev);
+	smmu = master->smmu;
+
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain);
+	if (ret)
+		return ret;
+
+	if (pasid == 0) {
+		dev_err(dev, "pasid 0 is reserved for the device's primary domain\n");
+		return -ENODEV;
+	}
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
+		dev_err(dev, "set_dev_pasid only supports stage 1 domains\n");
+		return -EINVAL;
+	}
+
+	if (!master->s1_cfg || master->s2_cfg)
+		return -EBUSY;
+
+	attached_domain = kzalloc(sizeof(*attached_domain), GFP_KERNEL);
+	if (!attached_domain)
+		return -ENOMEM;
+
+	attached_domain->master = master;
+	attached_domain->domain = smmu_domain;
+	attached_domain->ssid = pasid;
+
+	master->nr_attached_pasid_domains += 1;
+	/*
+	 * arm_smmu_share_asid may update the cd's asid value and write the
+	 * ctx_desc for every attached_domains in the list. There's a potential
+	 * race here regardless of whether we first write the ctx_desc or
+	 * first insert into the domain's list. Grabbing the asic_lock prevents
+	 * SVA from changing the cd's ASID while the cd is being attached.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
+				      pasid, &smmu_domain->cd);
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		kfree(attached_domain);
+	}
+
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_add(&attached_domain->domain_head, &smmu_domain->attached_domains);
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	return 0;
+}
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -2740,6 +2834,15 @@ static void arm_smmu_release_device(struct device *dev)
 
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+	if (WARN_ON(master->nr_attached_pasid_domains != 0)) {
+		/*
+		 * TODO: Do we need to handle this case?
+		 * This requires a mechanism to obtain all the pasid domains
+		 * that this master is attached to so that we can clean up the
+		 * domain's attached_domain list.
+		 */
+	}
+
 	arm_smmu_detach_dev(master);
 	arm_smmu_free_cd_tables(master->smmu, &master->owned_s1_cfg.cdcfg);
 	arm_smmu_disable_pasid(master);
@@ -2875,12 +2978,36 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	struct iommu_domain *domain;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_attached_domain *attached_domain;
+	unsigned long flags;
 
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (!master || pasid == 0)
+		return;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON(IS_ERR(domain)) || !domain)
 		return;
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		return arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 
-	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
+	smmu_domain = to_smmu_domain(domain);
+	mutex_lock(&arm_smmu_asid_lock);
+	spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_domains, domain_head) {
+		if (attached_domain->master != master ||
+		    attached_domain->ssid != pasid)
+			continue;
+		list_del(&attached_domain->domain_head);
+		break;
+	}
+	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
+	arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master, pasid,
+				NULL);
+	arm_smmu_atc_inv_master_ssid(master, pasid);
+	master->nr_attached_pasid_domains -= 1;
+	mutex_unlock(&arm_smmu_asid_lock);
 }
 
 static struct iommu_ops arm_smmu_ops = {
@@ -2900,6 +3027,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev_pasid		= arm_smmu_set_dev_pasid,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6929590530367..48795a7287b69 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -707,6 +707,7 @@ struct arm_smmu_master {
 	bool				iopf_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
+	unsigned int			nr_attached_pasid_domains;
 };
 
 /* SMMU private data for an IOMMU domain */
-- 
2.41.0.162.gfafddb0af9-goog

