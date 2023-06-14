Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F95730414
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbjFNPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbjFNPoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:44:19 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC2210B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:44:15 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-650cb5a6b0cso6469492b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757455; x=1689349455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=ZreyidDpJbP1PBXH0/670/kPY2SsUh00/efeS6mDpY0HajYSURNuwl2jgv15mHAY+8
         BQnjoS82KZhUCP+ZW8JKdnnpOoil/pxglVP0s2csLwMNXQxHU51EaIYCRwcdKqquCh0q
         3bWW4wrsmrxasyohwzBecrXf6yKsHWQhn0bySkpCPo4xUAgaHO41cs19iiK6VFDnmGcL
         1z3TlJElBou8TAuRPKhYnjDJwUUqq75L0bf3w6VNMdMUoFGls32SxQ9iHK9xTnV32fN7
         YIabDW9594lEZ4404D02Bxq7KeKnTkNz75qnKx2pKgIU+oWiPHE0kF1iXqTgciI2k5V0
         H35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757455; x=1689349455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=f0GOWWPGSroVzdT7/EUsbtR8+oIkP5RBmSJPylpmBk2adSgWEM34Dd2kutvk3AiuRA
         i7+cPUwScgVDGtadQHY+ZpqKwlS5oTah+W7zeD24/GIqT7NXYtjG/hkJAm8COC/+LG38
         1de1VyqzFaLYpO40ePEZtoTVSuIN8waSts4p9KWD9wJSe7b/9bIkkBuClE7KsKfLzfNG
         80+QnfVUWqlWZsmLFSFnykQN0aaOgId4B3f8+x8BcDesEPGWC8c+xAA9F2MVVDkvhgAF
         CCcC7DzCXQBLABF5fFp5Vimmmr0QayMIxC8p2jYrYblMsL2Ov5QI56VzUROfX06cdtVr
         GpPQ==
X-Gm-Message-State: AC+VfDzN8vto3tBMoeLgWFyVt7VLI7xMYEBhrVIJ5rfZHNdIFY7hA8Wj
        Fm9IYL6OAkASQ2ZVz0I8dJ67z8PsG/CV
X-Google-Smtp-Source: ACHHUZ5hvf161DqxDEUjciWGgh2uDlHkYPKEsVFxC66gt2tXnPwcs58oZC95f7+2kSAq6UzNy1BZjwtxJnV7
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a05:6a00:2e99:b0:654:424b:17d2 with SMTP
 id fd25-20020a056a002e9900b00654424b17d2mr664816pfb.2.1686757454862; Wed, 14
 Jun 2023 08:44:14 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:41:58 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-7-mshavit@google.com>
Subject: [PATCH v3 06/13] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
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
2.41.0.162.gfafddb0af9-goog

