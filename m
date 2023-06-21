Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1595A737BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFUGqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFUGpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:45:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1681BD0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfec07e5eb0so736401276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329877; x=1689921877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=bFIfZORz4qlyvHdesSBGaoACwrXyukUmDFr+sNMMwiGcbhJJOqX5vCINTCGVK/kqb1
         M2pwDMPHBCg5EsNV8co3V/w8l6vhX4vTin9L9Y5GtkOrDe1gld2dyDd8Gs1HqLfNwdN1
         G1FtBdPsy2NHnG2IC3hIdVsnPTWng2eGQ+qtojfzCdm1ORIt9R40o+eakI5Ec4ojnwqT
         F2VattLO/4nUSbZD2O/jFgdRuiN0pvkwRjTfp2vimZsBjB7peBN0fhLflu4T05WVZiO1
         hJkx9W1oX0Pcb7kL4Ccd0fi2GEjiJaL7AxA3aaF5kFJsUz+3Ce+yO5GZBwoTHZZ/M+Ot
         GroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329877; x=1689921877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=fwba4Jk3WNHBFx8nCdnOkJ1roBJuHKqxT/UBVVwH7ANOVfaAiPImnTVorp/4rNN+Cy
         u3wMvNWOp9qJoCMTLZ8mfAh/xwLHLhbDeNZ4Tdx4RvwvWTvrDW8qyXLqw6tNnCTTVkD9
         yY0CsB6BngJbfsYTGlGW8VQBcbdbVnEAFZL/73cM+4CK4Gz598gO0rupEp3cIPNjv1JJ
         89jE8sBrljRUIcnpfk2ceab4E/elJiDTiWmef89JBhY8yVt8yGOLeYYGExxSqTY1m+9q
         Gb2wXcmfl9H+t02fexZtEdr5fCHbE6HnpMyCs6B8OIA1DIcHX2LZYLu3o7XwkSvH46PK
         q/Yw==
X-Gm-Message-State: AC+VfDzLV7Sx2H3enPRzQISEDtf0OJVO/RagjNrp7X3mRccC6MIRW2lt
        a1rulwyBFRqO6NReiDsFy0nlrRwAFePA
X-Google-Smtp-Source: ACHHUZ4Hv0OtvqUjdHD4vH+y719Y6q1CiVIktPp2laFj3DNmpEvjIkRNUnFgjTd048rLwQnXunTIxIImH8Cz
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr5885974ybg.11.1687329877614; Tue, 20
 Jun 2023 23:44:37 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:22 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-11-mshavit@google.com>
Subject: [PATCH v4 10/13] iommu/arm-smmu-v3-sva: Remove bond refcount
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

