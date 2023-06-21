Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAD737BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFUGpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFUGoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:44:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2481BF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc77a2d3841so5687269276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329844; x=1689921844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=1gaS0SkW/Sq1tXITKeGmUGTrKdPbcpqB9xL6/exaE20A1NUvR9wFlTNBFxrCnmmx1W
         noltPOrcY64SY3zBIRAqGGfbitthNieh+upEIdv0gNliNAenwXtXVAvyOqY984mtAd6s
         nZgSwJLTL85y1xBHpiEsiHarlo3Bmr5RbJEloL0e473xQwEsJxKBB34H4CbuybmXI0iF
         wQwBCGVX4lZWA1O+4ztFmOn8qil9C1LlaOpKaRxZ4fVPxqw4z+x6RhcaqWte8IpC0cAV
         lWLdyIWdY+62QfGdY9MFUSCJ+NVCLxGu5r6cyaSOI9Fao6Wur1O0Gop63zLuED1qwKea
         cevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329844; x=1689921844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKyYB6nGtYqnelo6XDlWvQzY0JjgxL/I8n3xKSQjyKM=;
        b=dkNSv1PxXteX/8YVt7fWsO3ybQLWTTr6TCdeYayxDpIjpPtlFa0HQikbpfy6Pccd21
         cCguyLkMmV6iLxp+DMTKVOnNZq83MX3kTCtGsexjH0ArnXIOOH+HnBDIV2kGPQdGqQxg
         CZW0xpAQncS4Dvdcu2q7ehbFTSCu5AIudDBQfp1L+tmH2iVIi/u7xVGz72nXFXy/D69n
         koz+4sSNIpBwWZafec5QOpJExSUXnNLyiUzo86xFIIfv6Tve9bCLQkIwJOAm/ZWkhO+j
         XjR4IB9oNYDjT93g3M3DENUCA5IPatpvfeCPTskulfQB0W1wVjxv7M9otKcLeGiBpcXu
         xS/A==
X-Gm-Message-State: AC+VfDwZoy8EgHgVh7KHKvPoBSmcs0dZEhlP7/bRBil7o5e8wCqsq4fh
        CbLdOjlTG9hN1TdU9rfRUMopVwsIYZWo
X-Google-Smtp-Source: ACHHUZ6RcCmWn2rv5cCpEtepK8VPy5yY5wftqIvcrh1WvBJEI4R+LQYSq6Xo61BWKeoCrTmvyiGy/yG28bPE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with SMTP
 id bt3-20020a056902136300b00bea918f2ef6mr1543181ybb.0.1687329844564; Tue, 20
 Jun 2023 23:44:04 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:18 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-7-mshavit@google.com>
Subject: [PATCH v4 06/13] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
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

