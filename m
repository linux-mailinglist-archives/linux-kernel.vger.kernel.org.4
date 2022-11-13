Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3E626FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiKMNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiKMNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:40:23 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650CE090
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:40:22 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l6so8235692pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYxv6p0OLRmJkUIoXHmmBGT6rx0buZmGw9eP/QrShps=;
        b=Rj/iJfv0rIsMHplpy1NT9E5C+qNpv1eGioa3tlmokQmPmawH3NQbixi4zClFuG799m
         ABH7U671c2WbWgSazv3xIRQDn+vnVD7PwaywOVNLx0IiOEfR3eBYWDn9YQefSO3hUpoe
         uAXcUVoCjsc6TFITDVamWW/jsmuYTMMYAIlENTehZOZMYMUfXaDfyfFAl7QAMtR+Cz17
         v14VZORKrWWCoxpqAo7+ytUQHjHqBCX9YdGmE6ihvbrBGy57Z79pwawHo+jUa/TLMot6
         SFzO0s0E74e5HoBfIgfaTBpmuKIEIMs4prl5KimNZ3M+bjtWf16HPhFXsqrk082mRAFS
         gE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYxv6p0OLRmJkUIoXHmmBGT6rx0buZmGw9eP/QrShps=;
        b=J1PW08b5ive5LLprUw7LjH9PaHWICYlPvVl208T6Htyx4IIKS5RGz07zjchvwL0Ys+
         UdLwL505g/4aBa67Bttoz6bzIvD9R+3xrmZ8XP8Upl+QM/f8vCugfdblzKsuKbZVaDdT
         Rz0AKKmt/FzdAF1wEaYnxucbaCejPt7mVdS1FuRCXc9SqxFA402/td+HeINjKE9glLpx
         INXzTKvBJJwvaPO40PdGl1VsYlmsmGgk35FQz5SOJc/rJoY5HhjWj+Ykf1kol3XAgPcW
         RlNMD9hmoL2WqUTMKaL+tDpG35Ru8nxrfBiDbY1wVQWuIXsDTsuqQuQbN6jWCGzpC/JS
         vC1Q==
X-Gm-Message-State: ANoB5pnVTogcDRoqGsVOSD/i5qFnMR43F5YO0Xy5JCCY13R7pSo+ZqJ2
        YaBwGwvoc6+U17hzJHiHXQs=
X-Google-Smtp-Source: AA0mqf6S0VekRYqzT4gXdrYWjNR7ft9Yxhiv3X+xyTB4zAMvuqVM46n4qobIGziuZl2traSj0S/aqg==
X-Received: by 2002:a17:90a:f286:b0:20a:6106:a283 with SMTP id fs6-20020a17090af28600b0020a6106a283mr10119996pjb.107.1668346821873;
        Sun, 13 Nov 2022 05:40:21 -0800 (PST)
Received: from junjun.localdomain ([1.83.223.231])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902d58b00b001868d4600b8sm5204943plh.158.2022.11.13.05.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 05:40:21 -0800 (PST)
From:   Harry Song <jundongsong1@gmail.com>
To:     will@kernel.org
Cc:     robin.murphy@arm.com, joro@8bytes.org, jundongsong1@gmail.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Optimize checking for invalid values
Date:   Sun, 13 Nov 2022 21:38:55 +0800
Message-Id: <20221113133855.6219-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check of invalid value (iotlb_gather->pgsize = 0) from
arm_smmu_iotlb_sync() to __arm_smmu_tlb_inv_range() for iotlb sync
to make the code clearer.

Signed-off-by: Harry Song <jundongsong1@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d5df91c5..e51b9f506 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1873,7 +1873,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	size_t inv_range = granule;
 	struct arm_smmu_cmdq_batch cmds;
 
-	if (!size)
+	if (!size || !inv_range)
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -2507,9 +2507,6 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (!gather->pgsize)
-		return;
-
 	arm_smmu_tlb_inv_range_domain(gather->start,
 				      gather->end - gather->start + 1,
 				      gather->pgsize, true, smmu_domain);
-- 
2.25.1

