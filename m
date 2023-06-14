Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51BB730410
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbjFNPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbjFNPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:43:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B32114
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so16250487b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757423; x=1689349423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vic1ayWBGr79y9f6y1FKqdm9/OskuVUCQ3Tr10KopQ=;
        b=qhhtV69WKH2JluNtYemjQLj4d4hfClGTE//m6T+O7FE46Wo3W/vrmENSH/WtXfrT48
         8a5S07rhQ59AKc8+BgfzUy5Bj2swQlHUnRk3ucu69XFSSsZ+AomWUEn1sB396DApLgAe
         0adprdBEbSVUxQQfd4dT6RDzrQc6KTQN6bsgOYjw9CUc9dhFHYC2qWnzn+HRn1UPA9aH
         kjf90LWp0yxILw0IiPJOuiriOeSoOMmi9XkZKcrRXV97WwWsR1pNdEew2aR6B2qrQLUm
         3F+WX1+FcFiI+9BtyS27Rf8odZ0hD84gSWCl+MLkesx9GDJcjrjG+T0HGly7ZGRIuVWx
         6KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757423; x=1689349423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vic1ayWBGr79y9f6y1FKqdm9/OskuVUCQ3Tr10KopQ=;
        b=Z+rOKqD7Wb0uT8nqbz8I5s/iIaFrmZoHBeVPUfq/yLHKeTg1kgIhKYGuOR2Tuq+jTW
         d6RAWPamXGQsqESxDclPcMCACSF+rGaNqM2Wr6PbiG/BeWOZqm5oYiQnnxaY4X1vj1NY
         kWZ/o7SVaERvx66wS+cDe1XY0NlFMwxfZPW7EB4UXNooJG5BejlxDIkz+wI8aWJ8Bdv+
         44FhPxD4aYNxkRuDHQpGVdmKNx0VjpEF0sGAV8S6yKC7eqfWw8sDYbudD5/ggCoFLS6G
         j/gpEhpfZbiC3yU1i4FEe2s+w/IcMqIdDhx4s7Uba3fwkKQcTip3d68cPb/diQ+AXXHA
         UdIg==
X-Gm-Message-State: AC+VfDzqYICCok6JpU01W90FxcXwmnbRMT43O0QtUNQExFStX1i+UkvQ
        MQDzHNozZRe9ELpu2tIQ/H5nzlf9z8nt
X-Google-Smtp-Source: ACHHUZ7dqpkyX9QIV+ua1DgHJ+4Gpjcw5QzgmZIv8lQZIXKZNkPkBQS62jzmn2be9tvs4Kd2TECXDYFsL+z8
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a25:e6c4:0:b0:bc7:f6af:8cfe with SMTP id
 d187-20020a25e6c4000000b00bc7f6af8cfemr880044ybh.4.1686757422932; Wed, 14 Jun
 2023 08:43:42 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:41:54 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-3-mshavit@google.com>
Subject: [PATCH v3 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
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

Except for Nested domains, arm_smmu_master will own the STEs that are
inserted into the arm_smmu_device's STE table.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index beff04b897718..023769f5ca79a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1126,15 +1126,16 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_init_s1_cfg(struct arm_smmu_master *master,
+				struct arm_smmu_s1_cfg *cfg)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
 
+	cfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -1175,12 +1176,11 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cdcfg)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -2076,7 +2076,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
 		if (cfg->cdcfg.cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
+			arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2108,11 +2108,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cfg->s1cdmax = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_init_s1_cfg(master, cfg);
 	if (ret)
 		goto out_free_asid;
 
@@ -2140,7 +2138,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	return 0;
 
 out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
+	arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
 out_free_asid:
 	arm_smmu_free_asid(cd);
 out_unlock:
@@ -2704,6 +2702,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	ret = arm_smmu_init_s1_cfg(master, &master->owned_s1_cfg);
+	if (ret) {
+		arm_smmu_disable_pasid(master);
+		arm_smmu_remove_master(master);
+		goto err_free_master;
+	}
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -2719,6 +2724,7 @@ static void arm_smmu_release_device(struct device *dev)
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	arm_smmu_detach_dev(master);
+	arm_smmu_free_cd_tables(master->smmu, &master->owned_s1_cfg.cdcfg);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	kfree(master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 68d519f21dbd8..053cc14c23969 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -688,6 +688,7 @@ struct arm_smmu_master {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_s1_cfg		owned_s1_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
-- 
2.41.0.162.gfafddb0af9-goog

