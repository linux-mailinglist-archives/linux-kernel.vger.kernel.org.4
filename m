Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE87241B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjFFMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbjFFMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:09:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CB10E5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:09:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a63so100114427b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053380; x=1688645380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRUuglN2mFNqzu8aGhjOdpRI6fbxHMR7AUFnYMKbqRg=;
        b=kFD8qk5nz8nEkhEGuavEr1Filv5HOrp6syWncQpUGLaJi3DYvQwXC5BFVUTs6ShZMw
         h2Y95axOqxnM9XTmFJ6HM/LFDny8rzY6qFSMC/+3xIlGp/7hPbzW7cKJtEwfD1qJdZ7/
         zyK5eZGzR/IklUms3hb6ynufw6ajbdu3QxaJ7Jfuq+CZShyStZGF4+K+2RlTw70PAT9j
         KenSIraTK1+dvYOx1AWhSiCb+EOCSpPRtSBeuDYUWj3jT31ikuHdVpsQd4VxIg0AQeVX
         Rc82mEmNmqsBHLrx5rXhOEoFNFvIeWbCvbY6ADIAislq33tv4hCanDFstI6fN4sCfrsT
         hQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053380; x=1688645380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRUuglN2mFNqzu8aGhjOdpRI6fbxHMR7AUFnYMKbqRg=;
        b=cPrn5wYv4P5hwyJFs5ExsLYtfysZ0xglkXgX10gWeHDY1/UTFDtPKNOWIzHML3NKrr
         RyJJJL0ji6Wh6MLS9A5vBLFPUSp6MOJSVh1rxpKcY7QsyRi93WCK/HwNVEzUZ/104gtX
         zeK9xzem3DQ2Upo66BBL+NrvaJXN8sliejjPPbZZkxF2ymKctuBNM+FAc9WRL75L2kmo
         Y8egpiPD48G4k98IrCgktE8FdYxTEY8nEMKTVxbDPQdtmj73AWi7d0ZBcoMsVGhxcG8X
         zqrrx01aqapqItNd4++D/0MXX50z8KIn5p9Ya4YtUyjpb01JnwpjHq2Zs/xCxwY9TOaK
         cqfQ==
X-Gm-Message-State: AC+VfDwURdB/sUl+mrLPxBzklGoYf5r+eBjmrClEHMnB1R0KTUHOh6Ql
        xDF4FYlWWC9I6zh0tWFUum+UwXDcTtfz
X-Google-Smtp-Source: ACHHUZ548G9N8HPAkr+f/occvz3qoizKM4Via0ZKMso3g/f4jIYftDXWFivpLcTLw0OV/yYIOtXOKOVjnR3G
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a81:a7c3:0:b0:568:ee83:d87d with SMTP id
 e186-20020a81a7c3000000b00568ee83d87dmr903702ywh.5.1686053380117; Tue, 06 Jun
 2023 05:09:40 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:39 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-4-mshavit@google.com>
Subject: [PATCH v2 03/18] iommu/arm-smmu-v3: Refactor write_strtab_ent
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
2.41.0.rc0.172.g3f132b7071-goog

