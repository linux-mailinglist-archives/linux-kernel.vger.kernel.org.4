Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47996730419
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbjFNPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjFNPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:45:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE3F2101
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:45:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff81be091so12265027b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757486; x=1689349486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=vuL1XrQpU5Uq0e2ygjk0DfQm99VPq2z9YNT+avIv27XZ5urDEgwpmKbViVzjQ8Ors2
         T0rraZDZVM0ODSgkQTw6g6hdTWSyZHC/ZwHObRZETsh7v9KsqI7mfjRVjTddqwb75Yd6
         PkKi9NkGSgecoW5IThOwn0gGyOxQIy0qaPS8Ued69ldHUGXC3bEZuqzTL/jNRXCrcJi3
         uAxDiKxWDeKXd8Icj/EZsPQK5O6GRp7wJwAZct0hM+oyxo3a3VP2+SBs18GWULEH6AcA
         +Q3vGN3bOvN8pQVCjBFeK+N8axcpPszN+TMygeq+12fShtLMkNw5EOWGCZf8F5q4Py43
         k0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757486; x=1689349486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=M+v16h2MnOGFrv1NuWcGXbqky6y5WLQh7/ySc+7rWrjwXhosOJm1aYD3IK2Ne+LLw7
         Ed+hJBobZtBAOSwrb1T842IEgBRyLW72EBJqB9H7AmcZlB2ITS9tVthjCTuStP4tf15P
         DjjKZoBDtIvm1YYHBr9W7sXxdyqEDCvtj/iB10pUkrlGwivGV3aA5k5ReMvF6zT1J054
         ENW4n8ZcX6VFfOpFE2A8DYP2ysGL6OG77KUxxhzCVsXMtMUGzbjV2pHDEbmnFOAH3viW
         W7rHyJv21pX8s5GwIFlrYeETouzFe+N1aBXjT+bQgTwajPotvRx3X4nQUl6ZwKMOcHFG
         9Gkw==
X-Gm-Message-State: AC+VfDxYkZniZ3XdeSRnAKk+LKcD97h+Sh3fyOmxzbzjePSdyJv1LvzH
        vJHLD0NycZqjkEefuE/mp4rzMShVCbC5
X-Google-Smtp-Source: ACHHUZ6PWgAWHwE/x5mre24ZvBjK+WBUn1h6Ifenl3MHyaJYnWLa0SO3LQyqPPJbjhH7MP8WEYsBnUmWbutp
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a81:440c:0:b0:56d:791:d1a4 with SMTP id
 r12-20020a81440c000000b0056d0791d1a4mr1051771ywa.7.1686757486567; Wed, 14 Jun
 2023 08:44:46 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:42:02 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-11-mshavit@google.com>
Subject: [PATCH v3 10/13] iommu/arm-smmu-v3-sva: Remove bond refcount
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
2.41.0.162.gfafddb0af9-goog

