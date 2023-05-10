Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC16FE5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjEJUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjEJUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:52:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47AA93CF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:52:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7766d1f2so9330135276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751887; x=1686343887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crl7UEul6Dcfq8QDpXhaI9Eed6TzM1uxfD1qvdE3PPQ=;
        b=E34iKIHbcw2iwAefkui6Y8fb8t4HLsOQjNqt1book/JiKc5MTJgfjTRLyefr2cQ5Tl
         ttxCxp801cxl+gipPupYLagjsf9cbJi+iujzmWCnorMJI/TqEFnHwO9qxkgkGpt8hOqh
         /6N+osvQn3gDLvcqOrZhZCyASDH4oP30isSwbDcvXYFxg/tcc3S6sQmkMTLTm2nrl2pw
         gPXVwqKrkdzby3WLUXuFz7nJKDgVC29y7MqRLTuO0Zoy3QXctrcHxQOicB/jM3nGgix5
         pYOESBEWT/Isgxy0bnA5DVDmFRQCtPV301ZOAI+DwBAAqT6Kvrg2cgYImPalkXd+OqCj
         a+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751887; x=1686343887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Crl7UEul6Dcfq8QDpXhaI9Eed6TzM1uxfD1qvdE3PPQ=;
        b=JQ7SaBKdWyvHA95D5z4GjMiYkrVYlnejH0VsVKTBKIA689pcjEKbJSk1igFDr28RgP
         Urb9sp9Vp6tdYobsUjyxs89rWOPHCxsTbF4HBwsIDEQ3wryiiu9jlCTcOU0IjyQSPdvq
         A7SzMW2QnzifLqBszmh1M9qyleehFVvgONRxxVRTgI+KeNcdIAICbEAk82gcOgW9QHd0
         DGO9KKA4U/N/HB/aEioankWjlRcGC35z/RACztggJk9B5kAp81r6af2vLBoM/92rqqmB
         LWvomHxgjjiZM7Bf4daENcCPz+qrW8cTEzJcsbLoKep8vu8XwcfodMYmeIY5+/9l2QYp
         6WvQ==
X-Gm-Message-State: AC+VfDyuFceLPAbG2qHzWJx+TiIr8/VShjQFzluSuQgOuMLO+56c3jSj
        B1aiyNz6bXYvlX9j9uZRdayZNrS4u8eK
X-Google-Smtp-Source: ACHHUZ4n5rJoXtfVajxuWSLClEHWykNb92Fd743Dp9YuFoPRQCTDyrHk2ujH4WRb/j3lWIKrm3A+zT3yunih
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a25:328e:0:b0:ba0:f92f:84e7 with SMTP id
 y136-20020a25328e000000b00ba0f92f84e7mr11905705yby.7.1683751887458; Wed, 10
 May 2023 13:51:27 -0700 (PDT)
Date:   Thu, 11 May 2023 04:50:52 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-6-mshavit@google.com>
Subject: [PATCH v1 5/5] iommu/arm-smmu-v3: Implement set_dev_pasid
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 165 +++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 2 files changed, 147 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 81f49a86c1266..468a7a30ffe7b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2353,6 +2353,11 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
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
@@ -2396,6 +2401,33 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	arm_smmu_install_ste_for_dev(master);
 }
 
+/*
+ * Once attached for the first time, a domain can no longer be attached to any
+ * master with a distinct upstream SMMU.
+ */
+static int arm_smmu_prepare_domain_for_smmu(struct device *dev,
+					    struct arm_smmu_device *smmu,
+					    struct arm_smmu_domain *smmu_domain)
+{
+	int ret = 0;
+
+	mutex_lock(&smmu_domain->init_mutex);
+	if (!smmu_domain->smmu) {
+		smmu_domain->smmu = smmu;
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain);
+		if (ret) {
+			smmu_domain->smmu = NULL;
+			goto out_unlock;
+		}
+	} else if (smmu_domain->smmu != smmu) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+out_unlock:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2411,6 +2443,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	ret = arm_smmu_prepare_domain_for_smmu(dev, smmu, smmu_domain);
+	if (ret)
+		return ret;
+
 	/*
 	 * Checking that SVA is disabled ensures that this device isn't bound to
 	 * any mm, and can be safely detached from its old domain. Bonds cannot
@@ -2421,22 +2457,18 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EBUSY;
 	}
 
-	arm_smmu_detach_dev(master);
-
-	mutex_lock(&smmu_domain->init_mutex);
-
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
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
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() before
 	 * the master has been added to the devices list for this domain.
@@ -2446,7 +2478,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		master->has_stage1 = true;
 		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
 		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
 		master->s2_cfg = &smmu_domain->s2_cfg;
@@ -2473,11 +2505,74 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
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
+	ret = arm_smmu_prepare_domain_for_smmu(dev, smmu, smmu_domain);
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
+	if (!master->has_stage1 || master->s2_cfg)
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
+	 * race here regardless of whether we first the write the ctx_desc or
+	 * first insert into the domain's list. Grabbing the asic_lock prevents
+	 * SVA from changing the cd's ASID while the cd is being attached.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_write_ctx_desc(master, pasid, &smmu_domain->cd);
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
@@ -2723,6 +2818,15 @@ static void arm_smmu_release_device(struct device *dev)
 
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
 	arm_smmu_free_cd_tables(master);
 	arm_smmu_disable_pasid(master);
@@ -2858,12 +2962,34 @@ static int arm_smmu_def_domain_type(struct device *dev)
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
+	arm_smmu_write_ctx_desc(master, pasid, NULL);
+	master->nr_attached_pasid_domains -= 1;
+	mutex_unlock(&arm_smmu_asid_lock);
 }
 
 static struct iommu_ops arm_smmu_ops = {
@@ -2883,6 +3009,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev_pasid		= arm_smmu_set_dev_pasid,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 35700534a0b4a..9ef63ea381f4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -705,6 +705,7 @@ struct arm_smmu_master {
 	bool				iopf_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
+	unsigned int			nr_attached_pasid_domains;
 };
 
 /* SMMU private data for an IOMMU domain */
-- 
2.40.1.521.gf1e218fcd8-goog

