Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0B730411
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjFNPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbjFNPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:43:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC771FFF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561ceb5b584so12002457b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757431; x=1689349431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzXQy+3gWCRrOq/bPJGSod35GlRHXYXuXCqPkpYte2c=;
        b=JXTplwSsE5VOimvzwSxoOBAXrvM0DkSnTFs5atKOgzNUFE/C6yugZQCGi8Ug+Q8za4
         5m/tPpgqerRmaFNQv3MeyUdn3zLMeQPVwdgidcdiQSni224I4J4BLjawCnAL5dEuCm4B
         GttF1B/Zse1OdabCBCXmYiTJKA+xHsGxGmBk9ODJn0kHpM9qNz7aVzxYApxkUb654QRM
         ZbG1mWIJsW+aW9HEn9KYHX9jCB1Y3C20S8I1DWRQBR0nMQHa2kwM/UwkgmmL2shc3mGR
         6bxqrYSA4iicQ8gtGX2d5ts0FDp2lDELfAQh+Q2Venkpo5DaS6bweeY9O1W8mf1klzN7
         iDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757431; x=1689349431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzXQy+3gWCRrOq/bPJGSod35GlRHXYXuXCqPkpYte2c=;
        b=aPIuehZzn5S/ltQgvBuA1pDwHz1MvAEzPP7mW1hETqoB3Z/qlJcyi+gPJRDECnwtq3
         aDmjB0xZ4j4fGRMREVKLVL+1XRVlHUNgOkos+wFlH8QTCVqTr4UPsfmGyBEM5Cx9SXoD
         PczwLLrO4ZRc+Oi6S5FxFdbh/F7lTAwKS7F0aRDJa6EPZa9KJyN584017PJB9kZe9zsj
         viJRmnqZlBjH+fiahiUeFCCt3Lv8k/ZTz07BxqZaSCWUmWvFuuRCMh7mISSl2ACl4j05
         Dju6oWxtKq1iTn0QPxMycTsFMJeq+qARF/ikpqJyFMUk0uNhZf8fPVHrSU/lzaeqLnHv
         pHiQ==
X-Gm-Message-State: AC+VfDxwsbXQyBcdxMwnwc+x2qua7PhcZs/Lp7VkMmY7J2zqZQVJnNNM
        4kEF9KcwaHhi7ud2wpveowvjGnWuFmrq
X-Google-Smtp-Source: ACHHUZ4sh+CBjo+i26d91zindBZbilBHxQfue0Y4MR1TnNvJRRBgFBF/DXyPE1IT5owTTggbKbSZ6ISdN3jZ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a25:abeb:0:b0:bc8:c749:eede with SMTP id
 v98-20020a25abeb000000b00bc8c749eedemr1129224ybi.7.1686757431181; Wed, 14 Jun
 2023 08:43:51 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:41:55 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-4-mshavit@google.com>
Subject: [PATCH v3 03/13] iommu/arm-smmu-v3: Refactor write_strtab_ent
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

Explicity keep track of the s1_cfg and s2_cfg that are attached to a
master in arm_smmu_master, regardless of whether they are owned by
arm_smmu_master, arm_smmu_domain or userspace.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 023769f5ca79a..d79c6ef5d6ed4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1269,10 +1269,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 */
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
-	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_s1_cfg *s1_cfg = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
-	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1280,24 +1279,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		},
 	};
 
-	if (master) {
-		smmu_domain = master->domain;
-		smmu = master->smmu;
-	}
-
-	if (smmu_domain) {
-		switch (smmu_domain->stage) {
-		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
-			break;
-		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
-			s2_cfg = &smmu_domain->s2_cfg;
-			break;
-		default:
-			break;
-		}
-	}
+	if (master->s1_cfg)
+		s1_cfg = master->s1_cfg;
+	else if (master->s2_cfg)
+		s2_cfg = master->s2_cfg;
 
 	if (val & STRTAB_STE_0_V) {
 		switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
@@ -1319,8 +1304,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
+	if (!(s1_cfg || s2_cfg)) {
+		if (disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -2401,6 +2386,8 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
+	master->s1_cfg = NULL;
+	master->s2_cfg = NULL;
 	arm_smmu_install_ste_for_dev(master);
 }
 
@@ -2454,6 +2441,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	master->domain = smmu_domain;
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		master->s1_cfg = &smmu_domain->s1_cfg;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
+		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
+		master->s2_cfg = &smmu_domain->s2_cfg;
+	}
 
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 053cc14c23969..3c614fbe2b8b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -689,6 +689,8 @@ struct arm_smmu_master {
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	struct arm_smmu_s1_cfg		owned_s1_cfg;
+	struct arm_smmu_s1_cfg		*s1_cfg;
+	struct arm_smmu_s2_cfg		*s2_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
-- 
2.41.0.162.gfafddb0af9-goog

