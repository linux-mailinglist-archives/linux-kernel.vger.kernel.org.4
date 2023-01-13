Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BA66A26A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAMS5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjAMS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:56:59 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26CDAE47
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:56:56 -0800 (PST)
Received: from lemmy.home.8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id D53222623DB;
        Fri, 13 Jan 2023 19:56:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1673636215;
        bh=wuU52J1QjtpdEUmFc+7pSu1gYylARkE55yw7iLw3DsY=;
        h=From:To:Cc:Subject:Date:From;
        b=lK1FO4mJJ2mc8eP36V6B/q7XdFfDSDnU6HLtFX13gnmZLVgNclV1QeINWmyHqq+FU
         alaEJe/36bKO/NXtEYBKPPpFbTB/3wnKupe6WPv5Odj7F3YhSN46DN0VV2Dm91VjK/
         7hmfSxAIjHmzHHO7nz3sc28HMBhRwmwZdIKt9AT0KRWGjQwsV+y6Mb4nYenuItmTWd
         Bkoa/MuuKL46tXsNR/cGGEEHttu9EmEQDo4ieEy9RstmcUc6oR8bYMrer9x0U6IrPt
         DHVcKClqmvxDQxfmRGihg1DcrZV95f6de9xtezgcPjJT8uRgejLp+2OI7jcCB+RK5J
         DJQ+UX3+3EE3g==
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Date:   Fri, 13 Jan 2023 19:56:40 +0100
Message-Id: <20230113185640.8050-1-joro@8bytes.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function is unused after commit 1b932ceddd19 ("iommu:
Remove detach_dev callbacks") and so compilation fails with

drivers/iommu/ipmmu-vmsa.c:305:13: error: ‘ipmmu_utlb_disable’ defined but not used [-Werror=unused-function]
  305 | static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
      |             ^~~~~~~~~~~~~~~~~~

Remove the function to fix the compile error.

Fixes: 1b932ceddd19 ("iommu: Remove detach_dev callbacks")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/ipmmu-vmsa.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 3112822ac7be..bdf1a4e5eae0 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -299,18 +299,6 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
 	mmu->utlb_ctx[utlb] = domain->context_id;
 }
 
-/*
- * Disable MMU translation for the microTLB.
- */
-static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
-			       unsigned int utlb)
-{
-	struct ipmmu_vmsa_device *mmu = domain->mmu;
-
-	ipmmu_imuctr_write(mmu, utlb, 0);
-	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
-}
-
 static void ipmmu_tlb_flush_all(void *cookie)
 {
 	struct ipmmu_vmsa_domain *domain = cookie;
-- 
2.39.0

