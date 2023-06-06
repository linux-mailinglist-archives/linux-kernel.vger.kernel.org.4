Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D047241C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjFFMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbjFFMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:11:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030510D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:10:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso8022769276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053437; x=1688645437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QGlHe+zKTAk3+6sKXLWwU9ZaaAOqSw/Vt2fUhgy2WA=;
        b=bS4nn54XlFs3QFnaLf26ObLJelQ97e9PnCVNdve77ggjCR3JfNlgF6+o8d1vUqjrUM
         wvbXSNOisrmhnBwK5+9Sazm5rU2Zgirf/L3AYbVVxxno+05JhYVLwDDz3CWGUB4CgacW
         7FI2dvkLiNurNExQW8FFZfErrWB4Og5cGkpTlMRWPQdtpgidl8RlYM87aELCqrHicqXT
         zpsqKEpKie2x+xoq6gnaxrUin3F+7UedVAY8bBpVCRRrbKzzvtt973F6bc+QBgFcfs/w
         A85oh7tf3LR1d+Jaic4iI6vwBIZt8daoHhctT54OQIG6Li3F73eKCdyQ6LRcKn5ogmAj
         Q1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053437; x=1688645437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QGlHe+zKTAk3+6sKXLWwU9ZaaAOqSw/Vt2fUhgy2WA=;
        b=MplL335TpQ0qF/qDC/l0N8slRnPEr0obs4N+1t90ZxyA9ZIU9E30t0DOahkPPCikJc
         /1zVX82QxtAElXXOoqZm+2vAuDMGCXGxxBRPfn68XIbCSl8BvPsrUqW11tcQ7zRnls/g
         16VALtjttr+kU1CfVUEpmWeU+MLHtwEn4o4FbbZGFuglRQIbAPDwr8LZNkD3u3RJwl+1
         N6ReDlJUNPrRV2QtjrjUy0P8JcpjlqOcWziPfFsDG/9mWyD9ON5ucOq4LVmBD7LV2H+e
         gg2OvO6/u7FZQ2RSKr+lJtTzNPf/87R0j92G/eGQazsNebNSNcGd7hCc8DEkufsmWoOy
         JrKQ==
X-Gm-Message-State: AC+VfDwCV2waSH1Xk8e4JunktFZvsMDYmND5if60Lg2dRjtJrxPcGkqa
        bMe8OV5BW/e6uhmCg120T24ycwDaaxNK
X-Google-Smtp-Source: ACHHUZ6jnEzs4FzKbc1eucPM21c1GLeALy+/7ZK+Ce8gDScxpZwrM/NUIO/Lv/HW4xE6mHRkm8wTRbjilPxN
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:703:b0:bac:f608:7113 with SMTP id
 k3-20020a056902070300b00bacf6087113mr1100722ybt.4.1686053437004; Tue, 06 Jun
 2023 05:10:37 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:47 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-12-mshavit@google.com>
Subject: [PATCH v2 11/18] iommu/arm-smmu-v3-sva: Clean unused iommu_sva
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
2.41.0.rc0.172.g3f132b7071-goog

