Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA1737BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjFUGog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjFUGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:44:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370231BCF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bcef239a9fbso13159717276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329836; x=1689921836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vzESexuWCV4LLT4ZlWlOvb8u8164/HANB5QcSOGct0=;
        b=svmsiobx2Wo1tGVdmspzGY8XKIT2RMMfZsVIGP8+D0VskhD3W00QvnB74yg6w3Znfg
         FF0PHmvC5XVe190m9JDChplAtynZBkJ4zmC/GZXSj4PHFQu9Po+4/dccCy/wbGuWhmxh
         se005ZBXaisFJn7BGyDl48Svnfz+/u/MRUw7ZsoPofZBjic/m2iZTrsM/fqSlADWGFY/
         De6MKp6cEBEd3qxpL6wwFrJQp9hAuRrVmgyq3yIR5w/vn99QHwt8yL/0Jng0DUo0EAV9
         NZlsTatB05xTsImbbonTm96Wvoi3kQc1kObhyM6VDa93ATuNWP6gZ4K7nJlIb1va4fXm
         sPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329836; x=1689921836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vzESexuWCV4LLT4ZlWlOvb8u8164/HANB5QcSOGct0=;
        b=g8WEareeH0eyVpZANwkSYE5Xl8yxjHq6jXe0n0dny8ECzA0cJbuvxJZkqWZ4HAG6iz
         As4sF2PswoGzBvBazG2ao+qKT4RRp6KtKsr2SFGH6ksiC3zTJcwCCZGgqrs+0WNB87UP
         iqG6T3Lw/54wSkhLr6W6E8tJdaLycP0KqF+Gr5T9cLOs8YJh/xLPE5NFBCdcWlb2TnQ+
         j1SjfX3B0RkcWdM89JG6Hjzqd+im+iD8nwaJDPdK7aR1fIT84SQFg1yJVdFHxBB5EaHR
         gNgjMdNxFJH9/0K+HwaSkb5nAVRaqk1dkfOnaoNm6eDzWFpmMPnDMxtFlFHyJnLlTFHn
         YgLQ==
X-Gm-Message-State: AC+VfDyrOC9V3AQae0dMJLYuCh3QlMv4tFkEFdLIeHTSAX8axPcwOzTm
        A4BY24giDqzPY17OGm0PyDYf4aJs1Ugt
X-Google-Smtp-Source: ACHHUZ5OSHRehe3DXZzs9l8Ry/Fyn0ESmjipNH2+kktnVhz8AkYddX0OFhLKRoI4AmtAbrv6Hza5MotMUTju
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:abee:0:b0:ba8:4ff5:3214 with SMTP id
 v101-20020a25abee000000b00ba84ff53214mr3393703ybi.2.1687329836534; Tue, 20
 Jun 2023 23:43:56 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:17 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-6-mshavit@google.com>
Subject: [PATCH v4 05/13] iommu/arm-smmu-v3: Use the master-owned s1_cfg
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
2.41.0.162.gfafddb0af9-goog

