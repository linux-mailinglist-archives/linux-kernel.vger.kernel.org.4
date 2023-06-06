Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A97241B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbjFFMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjFFMKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:10:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B410D0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:09:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b03057588cso55848405ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053394; x=1688645394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf1RkoS1TdpddcvtRBe1GBIueZ5xLUPAAm9eoAp49Lo=;
        b=TtzN+i4Nv9gGr4efu4ItozcQGiq9M+zfsaBG6ZPDEmf81aQoXMt7jAp6xIL5vWASUy
         3JdC1llGmcgJD2YE7TPR/xcb6ID6WzMEjTW4IHN5nSUGXpQVxCJg0LmIKvdtJIn1rMz8
         nNNY5NNwnoHArYIpzkOPscZ6R0OkHXOXMVxldeeYAaksx1lr3e53zrPlL256ai4CIH1f
         zGOuYxToD9xJMrDHMB1iLVaxVc5NERQPjpPr+2JH3aqH2MJQE97/yB9SZbpHuiJhE3a9
         QDSw6EFpOJ3nqmmYIKiSlidtEnlVEixjyTGMqYLMAZA9Rv7DXt+j6E8FhEmAHXV3WIXy
         ZIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053394; x=1688645394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf1RkoS1TdpddcvtRBe1GBIueZ5xLUPAAm9eoAp49Lo=;
        b=Zd5iD4410aa2uEZPLdEGaAAa+25HL1McUcWLO1iXKg8zUsDOKB+7IEv/5HEMZcE88c
         r8OcVxtFLctdohxNKAWLWAcwP+69JiRHZ2P01EBfpwkZKiSmLniVBI7xuYlf/mTUMNm7
         D/m6L7UeFG5A8jr1YVSzqlREG/E780ewaPHibffI0ERBQECocRXqHWdj8EIcrb6SoCD/
         ISrrwZbWekw3SQhNGsdIWZXboNut9sXB1thInNi8DS7JazPJPBKkbJQBVmb3DKuVJ01t
         KDG9YovSnNGAuuiAfHUbK7E6nGnQcTz3O2RDT/qPIc0u3G3fs3cZQg2Ehdp8k3sFwA/s
         AbAQ==
X-Gm-Message-State: AC+VfDxxNzPUSb8s2FzYBJ7efhw5LnCXubk/B+NUtO9RkHGCP3P62dmM
        9kD0rBqFbHgEf/gukLWEV7Op1Nk04CBj
X-Google-Smtp-Source: ACHHUZ4lwhgJHo/kAZj8thICGBCDPxKgi+/dMCNxEJPPDpLMYK30s7X7w7DyaKAUhvc7tyxV3avIIaVelmSw
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a17:903:32cf:b0:1b0:6a10:1ba1 with SMTP id
 i15-20020a17090332cf00b001b06a101ba1mr582137plr.13.1686053394148; Tue, 06 Jun
 2023 05:09:54 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:41 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-6-mshavit@google.com>
Subject: [PATCH v2 05/18] iommu/arm-smmu-v3: Use the master-owned s1_cfg
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

Insert CDs for STAGE_1 domains into a CD table owned by the
arm_smmu_master. Remove the CD table that was owned by arm_smmu_domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 ++++++---------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 2 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b6f7cf60f8f3d..08f440fe1da6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2065,12 +2065,8 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
-			arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2082,14 +2078,13 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2102,10 +2097,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = arm_smmu_init_s1_cfg(master, cfg);
-	if (ret)
-		goto out_free_asid;
-
 	cd->asid	= (u16)asid;
 	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
@@ -2117,19 +2108,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	ret = arm_smmu_write_ctx_desc(smmu, cfg,
-				      NULL /*Not attached to a master yet */,
-				      0, cd);
-	if (ret)
-		goto out_free_cd_tables;
-
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
-out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu, &cfg->cdcfg);
-out_free_asid:
-	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
@@ -2192,7 +2173,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		ias = min_t(unsigned long, ias, VA_BITS);
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
-		finalise_stage_fn = arm_smmu_domain_finalise_s1;
+		finalise_stage_fn = arm_smmu_domain_finalise_cd;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -2439,20 +2420,20 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	} else if (smmu_domain->smmu != smmu) {
 		ret = -EINVAL;
 		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
-		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->s1_cfg.stall_enabled !=
-			   master->stall_enabled) {
-		ret = -EINVAL;
-		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		master->s1_cfg = &smmu_domain->s1_cfg;
+		master->s1_cfg = &master->owned_s1_cfg;
+		ret = arm_smmu_write_ctx_desc(
+			smmu,
+			master->s1_cfg, NULL /*Not attached to a master yet */,
+			0, &smmu_domain->cd);
+		if (ret) {
+			master->s1_cfg = NULL;
+			master->domain = NULL;
+			goto out_unlock;
+		}
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
 		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
 		master->s2_cfg = &smmu_domain->s2_cfg;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 00a493442d6f9..dff0fa8345462 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -718,10 +718,7 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage		stage;
 	union {
-		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s1_cfg		s1_cfg;
-		};
 		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

