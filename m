Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCF705A82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEPWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjEPWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:20:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968859D2;
        Tue, 16 May 2023 15:20:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3fe67980so1982395ad.3;
        Tue, 16 May 2023 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684275645; x=1686867645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osWWYYQseCvJCBZt1Q3stKtUhhbUrnP9MQ0pNGBM3gY=;
        b=g/foAuQVywceUd2vkSxoKCros6/PiFyEdDf5xt0p72vPNe9I4bSzLoL/vquN64+kAD
         PIkh7655q/gv4B8jOrPmVQlN/bsS1vdzytkxuf48LAxUxusGEFxr+xwaYdlOxwY72/yU
         Szl7+Z0lsWtCdv9nKJsAYYHnM9MBsgspJF/D+8jB3XYolmMJScMNxoukf/IPm4rfIz/K
         guK7/lKMtpkPlutb6AkiP6MbGLEzrr4gPv1zLv0Nd3h6uk+q8kV2nKJ3BT0uz2IWaeds
         K24z8j6WONz7FwK7TnPP4CIWOUnaWp1+dNOjYb1VCYrdz6QFl7FFkq6ULV9TImhSprkV
         75xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275645; x=1686867645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osWWYYQseCvJCBZt1Q3stKtUhhbUrnP9MQ0pNGBM3gY=;
        b=Jc2ivd5bDxwpCKI5IQo2HMB/ANOK2PYMgQsoptJf9Pl84uNWQ/GmqF1XQNSp5DHGcZ
         ls+1ct1m1qXTfDAA275YhDxljwSKni1SpoIfEd1XemucxCN/S0hUZbiwOJ1kM0zS5jFW
         mBRHZvGFKbA1YtO2uzeOpWmOkD/FHIOUT4HuWRRvwCDwZQ3tAwgV8By27Lg04SbPgLvF
         RHBoyEB054VWD0vXYwjVtjgJpY8gvE+5XJ6FbYddmuBMxiBADkrELIUO/JX1c7KKMqgB
         3JUYjcMfjiQyWVerK2dFbA0v7SD3/ejJmomyCKbF04dVkSbDAdV7hYkqE7KBUI/jySGM
         VItw==
X-Gm-Message-State: AC+VfDzEjsLmCU+MtS8SKf5Av5cfus6+VlMwdeE3TaqdVYlepGg52U4i
        9t4TAJakf8+0KigqRMjBo0M=
X-Google-Smtp-Source: ACHHUZ56Oy1tbNsnATMkInzMat6wSqCNeaSNNYU8KTeCB983x8CWAKSUxkzxAs2XGLpr4nqa/v4LaA==
X-Received: by 2002:a17:902:d491:b0:1ad:faf7:5c93 with SMTP id c17-20020a170902d49100b001adfaf75c93mr13955599plg.5.1684275645520;
        Tue, 16 May 2023 15:20:45 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001ac741dfd29sm16001971plf.295.2023.05.16.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:20:45 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] drm/msm: Be more shouty if per-process pgtables aren't working
Date:   Tue, 16 May 2023 15:20:37 -0700
Message-Id: <20230516222039.907690-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516222039.907690-1-robdclark@gmail.com>
References: <20230516222039.907690-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Otherwise it is not always obvious if a dt or iommu change is causing us
to fall back to global pgtable.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 418e1e06cdde..9b19124c9bd0 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -227,21 +227,26 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(parent->dev);
 	struct msm_iommu *iommu = to_msm_iommu(parent);
 	struct msm_iommu_pagetable *pagetable;
 	const struct io_pgtable_cfg *ttbr1_cfg = NULL;
 	struct io_pgtable_cfg ttbr0_cfg;
 	int ret;
 
 	/* Get the pagetable configuration from the domain */
 	if (adreno_smmu->cookie)
 		ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
-	if (!ttbr1_cfg)
+
+	/*
+	 * If you hit this WARN_ONCE() you are probably missing an entry in
+	 * qcom_smmu_impl_of_match[] in arm-smmu-qcom.c
+	 */
+	if (WARN_ONCE(!ttbr1_cfg, "No per-process page tables"))
 		return ERR_PTR(-ENODEV);
 
 	pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
 	if (!pagetable)
 		return ERR_PTR(-ENOMEM);
 
 	msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
 		MSM_MMU_IOMMU_PAGETABLE);
 
 	/* Clone the TTBR1 cfg as starting point for TTBR0 cfg: */
-- 
2.40.1

