Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33047241C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbjFFMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbjFFMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:10:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D007E10C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:10:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a336caa0so97995387b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053430; x=1688645430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83dlZFDhtSz2rg2AR6ggZ2Mh/ASzqdpRvSd02rbzaCk=;
        b=IoFA55ulrjtnJDTW5pbuUTS9XeM0qmUYpaAJ3OnF3fjh404oOtNySp8WzgeTzaaiiO
         mVRlBZ2obwVwh4OUFmiQJt7UUnDxoDMkllhaIBQAmBhFfw48M+MKZQjL4e//71A1xQ+M
         ZQe0Lx0j/uNjanZ997DNS7XHK7FjkoWOzElSxea08x+rZug6VZyihB4gEnokoKygwiFy
         oohF6tU936F+ATOKuIyJj4FuSck9QyYVTKPs6mJWVCMGD4SJTG4PI7zHHboXxVFaZsG2
         nDS7Gx45dkGyCy6J2pqiwfXPIBXnbTfVR9nkfcP+mnZCb8QJyIFTWcKIELfCjtVWDZgK
         oB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053430; x=1688645430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83dlZFDhtSz2rg2AR6ggZ2Mh/ASzqdpRvSd02rbzaCk=;
        b=Ic9OWiyZlycETbO/O3xrXiErgSR6jf5HCBtoiKJb46n5VG58EDG88EnIpykPstMFV6
         6+eWb0JS7poGaV/fcBd7gz82dfeIf2BURJBXjb5ibvn8gp+llTyciAzZI7wT78kVV/TO
         lMlM5dtYBAsqfv+jJ2Pq4t8yn6lQErE0qresx12JSjSUYp+3QUuYO8wxaIMArNEwuo1t
         PjJywnebVsNaaRUnK7tHYlOrnmgYQ/3aV8kTpRSH3Bi6e6UQX2YTR+x5dfK/J9McwH1n
         9bq0djzs3CQH7yPjRrlgMsBU7dDLOxJ0vSTmcGTu4uoqR1EWm/SSHdlCVyICnJpXWc7A
         bjHA==
X-Gm-Message-State: AC+VfDxq28RCZ7rgEYXjtT/eYShbsu5G1gRlYgL+ces6bzdGF9k61zN2
        LYiqTbl4xD+8lXWP/1TeyBS5eVDNjWYJ
X-Google-Smtp-Source: ACHHUZ64pvQvCxVufeRzNt0VKrbwAwJNjh5MfrOYdfJtgOmahfaQ951Oi+PY3aJvHU4m52siOi/iL4Zbsjnl
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a81:b289:0:b0:562:837:122f with SMTP id
 q131-20020a81b289000000b005620837122fmr942001ywh.9.1686053430214; Tue, 06 Jun
 2023 05:10:30 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:46 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-11-mshavit@google.com>
Subject: [PATCH v2 10/18] iommu/arm-smmu-v3-sva: Remove bond refcount
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

The iommu-sva framework checks if a bond between a device and mm already
exists and handles refcounting at the iommu_domain level.
__arm_smmu_sva_bind is therefore only called once for a device/mm pair.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index d07c08b53c5cf..20301d0a2c0b0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -29,7 +29,6 @@ struct arm_smmu_bond {
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
-	refcount_t			refs;
 };
 
 #define sva_to_bond(handle) \
@@ -377,21 +376,12 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return ERR_PTR(-ENODEV);
 
-	/* If bind() was already called for this {dev, mm} pair, reuse it. */
-	list_for_each_entry(bond, &master->bonds, list) {
-		if (bond->mm == mm) {
-			refcount_inc(&bond->refs);
-			return &bond->sva;
-		}
-	}
-
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
 		return ERR_PTR(-ENOMEM);
 
 	bond->mm = mm;
 	bond->sva.dev = dev;
-	refcount_set(&bond->refs, 1);
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
@@ -570,7 +560,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+	if (!WARN_ON(!bond)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
 		kfree(bond);
-- 
2.41.0.rc0.172.g3f132b7071-goog

