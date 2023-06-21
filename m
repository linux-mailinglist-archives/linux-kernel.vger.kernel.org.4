Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A68C737BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFUGqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFUGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:45:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11821BEF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57000a7480bso77142067b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329886; x=1689921886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=NwyrXz6ubgbYeu5se4OnmTGRl/ECZnN/7JXUGfb3yfJHIleuEhl/vBOWZdfzMER6Gx
         BiPVvWA9Zp+4QaWrnn9OAzgPxD8EtCxqeits8Wu66pkUEHOGaiwDQhRW/J+yNdDMsAlF
         y8tREQZuazgzoLW1lJOdMAgC3jROf3yU6f6/ooGUM/ed0cdMK69TTIuHL8pi8+hdgxg4
         sMmuWLwUHHqnGxYMofKOeij/4hhaVO7yrHVtyCzzPIP3fz7HtdUP47sUq7HkSrrLt0u4
         AKIy0MweTpJJB47zOUsszP8BDsLy6b518MCCeqGT4lRkc+iJWu0D/oSX+S9wtNgHByFL
         IhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329886; x=1689921886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=SKzXZyh35Cr1YMOXR+EXdWO+xgDMmPS4D+8LsxokkAy6uZucnRKFvds54lw/JQJO6U
         ojMWq/I3jaBbY+VjcboINOYJIHGyGXr9tJ46fPamF7MB30q2MjM0PmSG8ooBkVUI3ZQM
         YmWIsU20MqR13EUuszf8hj2aPxaqwl3pq5JNcezMuYfxRzrmDmicTx2WVOf0+CsbfDdj
         iBLlT26z0ChNQuTOoCZr/VaKzkMhQb5OT0KtmhIHXAAK9hMG2q8LFIgmRXsGWWpVJJLO
         T5O0kc4XzdY3oYKVnaJHDEnREI5tcusSIvwWfJQgN/dwJfTVJZFngMEDM4qT13zPgn0u
         iwBg==
X-Gm-Message-State: AC+VfDwsf8GxCU26TY7vyDuOscecljKee145KOosNz4qjy8AdZKYRfun
        eYNJdxHh51kY9GyiNpaVBh9E4/e5ZnL/
X-Google-Smtp-Source: ACHHUZ7QGJG0D7z7/43AEtJ6RwcS6kiSb09I0mWwsorRzmgb/ZEaTmvkUNbdIb93dJYPVoc71NOppCwfYFjW
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a81:bc4d:0:b0:56f:2841:aa24 with SMTP id
 b13-20020a81bc4d000000b0056f2841aa24mr6215155ywl.10.1687329885894; Tue, 20
 Jun 2023 23:44:45 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:23 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-12-mshavit@google.com>
Subject: [PATCH v4 11/13] iommu/arm-smmu-v3-sva: Clean unused iommu_sva
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __arm_smmu_sva_bind function returned an unused iommu_sva handle
that can be removed.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 20301d0a2c0b0..650c9c9ad52f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -25,7 +25,6 @@ struct arm_smmu_mmu_notifier {
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
 struct arm_smmu_bond {
-	struct iommu_sva		sva;
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
@@ -364,8 +363,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -374,14 +372,13 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	if (!master || !master->sva_enabled)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	bond->mm = mm;
-	bond->sva.dev = dev;
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
@@ -390,11 +387,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	}
 
 	list_add(&bond->list, &master->bonds);
-	return &bond->sva;
+	return 0;
 
 err_free_bond:
 	kfree(bond);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
@@ -572,13 +569,10 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t id)
 {
 	int ret = 0;
-	struct iommu_sva *handle;
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
-	if (IS_ERR(handle))
-		ret = PTR_ERR(handle);
+	ret = __arm_smmu_sva_bind(dev, mm);
 	mutex_unlock(&sva_lock);
 
 	return ret;
-- 
2.41.0.162.gfafddb0af9-goog

