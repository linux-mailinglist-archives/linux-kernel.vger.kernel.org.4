Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAA973041B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbjFNPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244874AbjFNPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:45:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879722116
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:45:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so981814276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757494; x=1689349494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=miKKuVOqy3O5VFZtsBJw0DWAr4nJ6ea8nlIylue8vHaIsdYyKs5VFM0KTJacu51Qzm
         +DH3Zl9jsvtSJPHee4tayDVENGPTKWf9gWXrcL4hC1Sc2GgiVQBtqQ7FnZG8+YwqkBPh
         yA8Et/DjbQCMxnJvenLQiNf7A7GFBipkyxcRcbX25mPlSQAORH+f6lepCF7STCNnbSjz
         QEVoAOVVQy/KvCuZreeHmBUtlj6a0/QT8lJ7Ls6W5a6m4+Xc6bUdeRYUvj91Jh2RQGIL
         1UcOZtIRMZQKKjjJou6pQavpNlTolKJ9ovsaIENZITg6nYLeQ/1+rErxMkqfwI2pqIqu
         2vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757494; x=1689349494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=X/baVtJN6J3qkZ1B9jJOzs1e1ngiG9GC2EfXoty22uR+3PABZQSsc1Dwi5sVXc75Pt
         ikonkDPI6mxQtOGviCxEnvcJRKfLhWIvob4v6LfiTOUNDvG2F9s3XHoqogEpsEdWwetU
         XtzQxBjxQAxRCHX5Yt2D8mCXzxYt14xbDe9TGStuXTVbfNHDNz3PASKWioWxwv0hWS99
         L1BH83dpjTBAg2BOaIV8XiE7v0JzQus0+gTIdF8TtLxkQde9zGf6peDxyIptBvTYic8a
         Nz4QKoV+DPrKc3TCYKIfDmCh5+aDVhfe5R4ftG4SmkR0FpD6PkUfImDVeIiBv/iWNdb7
         0VQw==
X-Gm-Message-State: AC+VfDzb3Zw0ECOcTiQsQfTTqhQOBI/P09JFfbN7tT2ZrMIPCBvzEATs
        jYVI8DuQTxMCgdYSrL3WdBjzj5d5fnJZ
X-Google-Smtp-Source: ACHHUZ78kKfpFZreseZ4ojfWuvi9sDnPV/0PlekSvb+T1K6vSEDreVSyrSqoVe2hWBnfSGsU5TgB/jwAdAGz
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a25:7356:0:b0:bc7:f6af:8cff with SMTP id
 o83-20020a257356000000b00bc7f6af8cffmr1176382ybc.2.1686757494488; Wed, 14 Jun
 2023 08:44:54 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:42:03 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-12-mshavit@google.com>
Subject: [PATCH v3 11/13] iommu/arm-smmu-v3-sva: Clean unused iommu_sva
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

