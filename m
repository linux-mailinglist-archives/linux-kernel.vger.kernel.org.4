Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C07241C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjFFMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjFFMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:11:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441941703
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:11:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2202e0108so7551099276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053458; x=1688645458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/IPHrVLjUq2s1o0Kk8jlOX8iem0l8MY258dkWJhSSA=;
        b=VZ4aVUegMrv+4Q6yvYwHunY/3cwuUlcr0h58VcDyy+whkFdBNoq1bmH2cIlw3NPTGf
         2xwwiPuSrWUGDBls3d7jNYpe94klnR35TS5OkpOjjZPOxAO8MIWR85bzh29QZGu9r6vq
         Uhrp4oqPT2o6ewJtPDlh64Ybaq2kCogm4tvMgZDNn5hii7e3Sp7nkxS2CPQ+QqPKUqO2
         jr7HF72nwtGIZwbU2rVIDb/0fXNIWezbdzedeFrmGi0/fABER6IwQMRfR22nwYnhBjrI
         RYCBaFffmg4sgiF4vWOkI7rmUWylAkhG7nKO4jBF3BV258AG4UrAU6eDZogjLom8Cb8J
         fe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053458; x=1688645458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/IPHrVLjUq2s1o0Kk8jlOX8iem0l8MY258dkWJhSSA=;
        b=CQtCnGzW/XmEn4N2MOYYsz+DsCXR++e5FzynOaNKRRqzm5rLTszRGqu8IgWTNCQU/E
         4ipoo4w0OOCaigjEV0pqFReHKhibN7fbAuon/u01Aj4XwxdGgH0PZHPAHPP66QIaOcfo
         JHtDyqZQj2u89wiSSBFNmAZL7V7W0M98/zo+8nIEVtjvphQ3VMq8NSsEg8icPz6V/cg9
         1fox2eZ65ca5T4IEN07AQJ7i9wfP7GbugBe3Fg/2WUUJV/LV0nKpO2DIprXe4JkkDdjh
         ALDfHStnFDiRow5/vYN/AoYluagKcjaIvS0Sq6EaI1ZGLPYEH9+nCyhrulGjDJyMueyS
         6isg==
X-Gm-Message-State: AC+VfDxakWzChd8CRhxv8Ovc6jxe9WWOj3Ye68yfFsGEUZxjZ64De3h4
        YYdZ3LcPZm40PLadqSu39UiPXaZiidwu
X-Google-Smtp-Source: ACHHUZ7wQ2cnghC4sSj2hPvQ7d1hwPGvVMm7khlu49LtLrhV/uxm381LyvtDF8uhJajK7hUiXOUQxpnGItxh
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1183:b0:ba7:7478:195f with SMTP
 id m3-20020a056902118300b00ba77478195fmr620081ybu.13.1686053458202; Tue, 06
 Jun 2023 05:10:58 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:50 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-15-mshavit@google.com>
Subject: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared CDs
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

SVA may attach a CD to masters that have different upstream SMMU
devices. The arm_smmu_domain structure can only be attached to a single
upstream SMMU device however. To work around this limitation, we propose
an ARM_SMMU_DOMAIN_S1_SHARED domain type for domains that attach a CD
shared across with arm_smmu_domains (each attached to a different
upstream SMMU device).

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b7f834dde85d1..69b1d09fd0284 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -965,6 +965,20 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
+static struct arm_smmu_ctx_desc *arm_smmu_get_cd(struct arm_smmu_domain *domain)
+{
+	if (domain->stage == ARM_SMMU_DOMAIN_S1_SHARED_CD)
+		return domain->shared_cd;
+	else
+		return &domain->cd;
+}
+
+static bool arm_smmu_is_s1_domain(struct arm_smmu_domain *domain)
+{
+	return domain->stage == ARM_SMMU_DOMAIN_S1_SHARED_CD ||
+	       domain->stage == ARM_SMMU_DOMAIN_S1;
+}
+
 /* master may be null */
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
@@ -1887,8 +1901,8 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
+	if (arm_smmu_is_s1_domain(smmu_domain)) {
+		arm_smmu_tlb_inv_asid(smmu, arm_smmu_get_cd(smmu_domain)->asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -1968,10 +1982,10 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		},
 	};
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (arm_smmu_is_s1_domain(smmu_domain)) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->cd.asid;
+		cmd.tlbi.asid	= arm_smmu_get_cd(smmu_domain)->asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2549,7 +2563,7 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 		return -ENODEV;
 	}
 
-	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
+	if (!arm_smmu_is_s1_domain(smmu_domain)) {
 		dev_err(dev, "set_dev_pasid only supports stage 1 domains\n");
 		return -EINVAL;
 	}
@@ -2575,7 +2589,7 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 	 */
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, master,
-				      pasid, &smmu_domain->cd);
+				      pasid, arm_smmu_get_cd(smmu_domain));
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
 		kfree(attached_domain);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3525d60668c23..4ac69427abf1c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -713,6 +713,7 @@ struct arm_smmu_master {
 /* SMMU private data for an IOMMU domain */
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
+	ARM_SMMU_DOMAIN_S1_SHARED_CD,
 	ARM_SMMU_DOMAIN_S2,
 	ARM_SMMU_DOMAIN_NESTED,
 	ARM_SMMU_DOMAIN_BYPASS,
@@ -728,6 +729,7 @@ struct arm_smmu_domain {
 	enum arm_smmu_domain_stage		stage;
 	union {
 		struct arm_smmu_ctx_desc	cd;
+		struct arm_smmu_ctx_desc	*shared_cd;
 		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

