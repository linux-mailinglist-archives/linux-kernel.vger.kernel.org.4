Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31F7241BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjFFMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbjFFMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:10:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC610DE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:10:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so9693846276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053400; x=1688645400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3oiLY+ykJwBM19GqpOciDwpUp4BC6bUpIyUkrOw/lU=;
        b=3hPQpvgL+wDxU0OjZQfIfZ4PvVC+sRTH9qlAAPJqZw1xiM2Q3iNaeKDiXdelb0sVio
         D6xhz8ENSzVt3nnIIlVKdYJfctHXIAa0AVbONky2oo5QejO9Xh6VEvVppH5VVD/R0DTg
         Rz+4hNgCNRDD7UxQBbLKaWHBeXwxqhF9abdIbDSldq7wOSbdk8rtegg1ed7wG1S+DX4F
         9gDbr52SBPiRvOlnYTCDE5jSJQThXBeNqvfSEcx2+4zLLOYwZ5zlaQVcRWkWS8JjZRaJ
         XFM2GVTbPxXllz89+WNgxWz51t+GrQPq+ZkabafS5wNcTuWm2e98+FU9XPrgilTH4onp
         qvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053400; x=1688645400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3oiLY+ykJwBM19GqpOciDwpUp4BC6bUpIyUkrOw/lU=;
        b=cPbsJNERGABPpdd+o4HcVPl6bjF5MUhtEj0PGjRKA7TUMDDptgW29F/g4tUzH7pMmu
         6KRRH5q0oXVsN/adPkfUbChTH7av5zwX79cvEjfXMEZ3pmfLm1lDgn4Brr+naa3BnGjh
         WrAI6tn7OIZE0LNR/naPAWpGQu3vGdhYYGVyW9SEoWNoOL+7o0NLgNgFkpKWBSmixhxA
         jPI6dxcVJf9+HyUaW/HQURTqayShaCM2d7X3vUImAHwzx3+SlSkU7XtD6l9xmbiZ4uEs
         ZWoZ60RXo5Qpl9yedTM8+xGviDkik0G1iogKPEB1pkEDwYFv+V8utSwPdY0rI3TEHqqh
         m1QA==
X-Gm-Message-State: AC+VfDyTH3vZd3qHGsniocOi32K+emVa18NHI41IX0POYOD74D+z0W+Q
        2Qcw77HgjMVZhaxOPtNg8WjDfoDFw6yt
X-Google-Smtp-Source: ACHHUZ4SbzdX0vrWGGzX8FEpBXrbLqYVs8p8cs/JwhdTrNJ2i2fH3FCcYmqUDP7FZD+MtLPKPWmNhTPp6j14
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:10c8:b0:ba8:797c:9bc7 with SMTP
 id w8-20020a05690210c800b00ba8797c9bc7mr1064725ybu.11.1686053400830; Tue, 06
 Jun 2023 05:10:00 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:42 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-7-mshavit@google.com>
Subject: [PATCH v2 06/18] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
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

arm_smmu_enable_ats's call to inv_domain would trigger an invalidation
for all masters that a domain is attached to everytime it's attached to
another ATS-enabled master. It doesn't seem like those invalidations are
necessary, and it's easier to reason about arm_smmu_enable_ats if it
only issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Fix commit message wrapping
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 08f440fe1da6d..dc7a59e87a2b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2286,7 +2286,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

