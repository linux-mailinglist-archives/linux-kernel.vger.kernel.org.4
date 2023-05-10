Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF876FE5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjEJUwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjEJUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:52:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902CE7DAA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba6386e6f7aso2797910276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751870; x=1686343870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD2T39BHpHecI5MHeo7qoTsLquM2+wzDMKb634oTpbY=;
        b=rGEDpjfKVDSXnegP2Yoh1oS4RKGCm1S/1oh0YrY6TInsUUuT/TatwSrlR5ReWbSpVR
         3CEPJJWurPhFZiuXAtH3qfoSNnpYU5t7ee5qT488zgJ7RlD97QkBhrvYViqMbX+qpdw4
         bHWVtApzrNDQgPDj41iH5pfZsgCbPXXC/7XLzg+tUpY3lRKKv4NwXsRJGhBgg9bkNd6T
         dM7JDKt8kuPXk1NdgoJKuDBgvuKJFO7r2pfBj7HS+RnLwVuOiBsVt23rHj38lxD07exT
         Z1ASuFFRLZkAO7HaK6Taom7jnJaqOj5GAj9Pe7YYwcfnbrwtoaxSXgzy79zc/lPDAd0c
         ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751870; x=1686343870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD2T39BHpHecI5MHeo7qoTsLquM2+wzDMKb634oTpbY=;
        b=eUhmaEHPfh68+5gWmqAeN7prMXWwesKiVLY7vHtn+bNrd9TmKDtHVqj6rUi1dAikjE
         pPos5zKrsQkd1vizdFyd+2ehcFiNsrTfa/SXYk960CmGVKuxsPkydAFElACQTEpdd4Dn
         MdrkJZGcO0tCC+66/HHRQhWUUUP+XKGW4EbPyVR1HID3TlhnQy6LPz/fzgZBc1TNbYLk
         +19buO61TQMOwSQzDkFEfL/lV99xD8szNR68j2nH8fA3/FAJ/Gqg86wP7Nkesf/4RG7x
         Lyjq4gp1uSJY0ihu2ue2yNztxxhFTSRVAe8q4Yn1K1/s0DqOjTlRCQpcJmFlVlD6TgtO
         1Ryw==
X-Gm-Message-State: AC+VfDytE4vv1MK4LB1T19f7KcP25EmQqfpbK9qEDR348W0AllUIDoZB
        E1XIQzPUFyx4rlfTPcKgYyel4tDsApVG
X-Google-Smtp-Source: ACHHUZ73kuLRRbrNDuMDON5LT7h7WGSfJ99ThVHL6jicRwMCqCmXO9hfOilEc2kjetoWphmNCF9awexTlbaQ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a25:bbc9:0:b0:b95:518b:4921 with SMTP id
 c9-20020a25bbc9000000b00b95518b4921mr8254206ybk.12.1683751870775; Wed, 10 May
 2023 13:51:10 -0700 (PDT)
Date:   Thu, 11 May 2023 04:50:49 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-3-mshavit@google.com>
Subject: [PATCH v1 2/5] iommu/arm-smmu-v3: Add has_stage1 field
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

Inferring the state of the STE based on attached domains becomes tricker
when multiple domains can be attached to a master on different PASIDs.
The new field allows the smmu driver to directly query the state of the
STE (S1 present, S2 present, neither) instead of inferring it from the
attached domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++--------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cee3efff3c9fa..7b4399b5ba68b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -980,9 +980,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	};
 
 	/*
-	 * There's nothing to sync if the STE isn't valid yet.
+	 * There's nothing to sync if stage 1 hasn't been installed yet.
 	 */
-	if (!master->domain)
+	if (!master->has_stage1)
 		return;
 
 	cmds.num = 0;
@@ -1278,20 +1278,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			.sid	= sid,
 		},
 	};
-	struct iommu_domain *domain = NULL;
-
 	if (master) {
 		smmu = master->smmu;
-		if (master->domain)
-			domain = &master->domain->domain;
-	}
-	if (domain) {
-		if (domain->type != IOMMU_DOMAIN_IDENTITY) {
-			if (master->s2_cfg)
-				s2_cfg = master->s2_cfg;
-			else
-				s1_cfg = &master->s1_cfg;
-		}
+		if (master->has_stage1)
+			s1_cfg = &master->s1_cfg;
+		s2_cfg = master->s2_cfg;
 	}
 
 	if (val & STRTAB_STE_0_V) {
@@ -2367,9 +2358,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	master->domain = NULL;
 	master->ats_enabled = false;
 	master->s2_cfg = NULL;
+	master->has_stage1 = false;
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() even though
 	 * we're about to destroy the entire STE anyways. This is ok because
@@ -2426,6 +2417,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * This isn't an issue because the STE hasn't been installed yet.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		master->has_stage1 = true;
 		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
 		if (ret)
 			goto out_unlock;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0b87c74bdf46e..d715794572b13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -689,6 +689,7 @@ struct arm_smmu_master {
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	struct arm_smmu_s1_cfg		s1_cfg;
+	bool                            has_stage1;
 	struct arm_smmu_s2_cfg		*s2_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
-- 
2.40.1.521.gf1e218fcd8-goog

