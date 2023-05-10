Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA16FE5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjEJUxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjEJUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:52:27 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E81707
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24dfc3c668dso4118420a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751876; x=1686343876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMTIUjk5Ind647HSgdl65AQXCGi9ZS5fYo432OHDtSQ=;
        b=KPCdBXKKrCR73vDaoJkOuz1eCOKkI8LYLClUu3ZrD6Rg2/zc1ZSSm1qiKat0BbRArq
         FzmRUM7rp0v+9GCIQNvhfqNy6gVsr5Z+UcEeGdXWHGtGkuO8UqQD+KxCtxreNbiahZ4y
         WRs9ZnTK8MAfnni7I6rJo6ZgF2pU32hZo8ijPo0ne33mYgduNBv5MO3HGN+bs9Od89QK
         i2LHTDL9KXS/yzLi1erv9ZaYyyIhnsYBtHV6e5vK7hSE63IfP6ma2qN7HjsasosoGTdT
         Q5gvPvvoQSCTowCCHHUlbYR2j7v0iItW60tukvbIeG92nL1GMCHNrDjF6xU3rK/ctXeO
         aY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751876; x=1686343876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMTIUjk5Ind647HSgdl65AQXCGi9ZS5fYo432OHDtSQ=;
        b=ZvSCU5qI+yoyK/GGjt0bQLbXs5pjTLm3pj5B0fijCHBydOUraDiS9qdmHczfv7cjIA
         meHHZXcjkrSaqA9Q28fqV7u7+TAy+4f6vWlcdV+yptT21S1WVeWazgET7EYJQ2lWMMkS
         xc/k7frV5rX0h0njZOwpBBjdxJMgd44V9wP/NAhe0WbkluzeKFZBkOAd/IB3hdPWSImG
         9BBBP3byIaaR8gb5A0j5kqjTSjU7D9y40oqaT01NDhtiFtkbdYYg3Rt4B4eeQHfDte1q
         9ViWJgPF2be0v1KdIXQVSGsfhALlurIxNZWpLLIIfAOXKOFN5W25GRSXj4By+V5YjMxp
         EAMg==
X-Gm-Message-State: AC+VfDwcgUMOZmDG9J37kmLMebALa/5Z1RpS8GTN5cNhstQGZlt2aepr
        H4mdYEl6tK+jUlnwVl3XOyUVS1I/4s+U
X-Google-Smtp-Source: ACHHUZ47UrMzz7gfleKmwaFULxZzolcnVNmCc5mUtValZYiJTjKDcV7CB0gT7x4GUYJvV4hW6CYE2C8IA55d
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a17:90a:db0f:b0:24d:f863:458c with SMTP id
 g15-20020a17090adb0f00b0024df863458cmr5910104pjv.1.1683751876335; Wed, 10 May
 2023 13:51:16 -0700 (PDT)
Date:   Thu, 11 May 2023 04:50:50 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-4-mshavit@google.com>
Subject: [PATCH v1 3/5] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
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
necessary, and it's easier to reason about arm_smmu_enable_ats if it only
issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7b4399b5ba68b..47dda287a4736 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2275,7 +2275,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.40.1.521.gf1e218fcd8-goog

