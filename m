Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166836FCB74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEIQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEIQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:37:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB6422A;
        Tue,  9 May 2023 09:37:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so5721256a12.1;
        Tue, 09 May 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683650239; x=1686242239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osWWYYQseCvJCBZt1Q3stKtUhhbUrnP9MQ0pNGBM3gY=;
        b=mZZAJf8CDVLdRsIa/eB31WvC02gURKhS4JsgGIM1FMEfS0TPzOSNr2ofLgpB/7d36u
         t+huw2YXaVGECPsBBtfOGhjyjvU670c59fAbXlO8Yz+yLMEUksGNyv+BRDQD8VIZFfkh
         mghLEYlEXXdGTtZG9Ss2M4RDBoz3VsqKzX4/E8mXGpRx7MCzH6pSJS/kmC3o3x8ob2+r
         FaoysUGQAZtMPp33CmjiOwLcYoRVcG/j5VesdRfj9iwmMnTVtHtTdQnXLroAzQ5BYpuw
         Dk4me3Nis+OCHDDn/PHz6ClQak2AclwSy1vmc119W+tNEFEBpb/qq08kUvh8KKxLAnzZ
         bRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683650239; x=1686242239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osWWYYQseCvJCBZt1Q3stKtUhhbUrnP9MQ0pNGBM3gY=;
        b=eB2ORro4/JCJra4QED8eWUrG7UHPk3XlWwGiwuZFTaoP6Y3oT/WNroE3NHeCfTG8+D
         htWmWMijLHP88Gihpmj5QU2XbRiT0GHUbqlXvnxJ3pt/IkouLGnBquFUg6htDodNV8SZ
         5tcr6UgnMyQMfUvxytWzGrgXVPMUQXtazgAasFB8R1kEDS7nEJ96JJGrnLqcjMyVfSO3
         bvON6oVnu2DFgL4/NqcPMKtOG7FTJjPRKvkZNr4lmCdRYlXh5bcKaJMbyymmVVv+yrbZ
         obT8kiU7EaNpZtBIP03I5QvUVa/j3ouVRssHuNCIsB8K/LN9T4IVwWxFJjex2abWRn6T
         Pvig==
X-Gm-Message-State: AC+VfDzPjrcxWvdEmGLR3Ta514UmMRQ/rfYpZgCh7db1YtVRKVh4cbDh
        I+WwPwbT6/SRHjcL3NUTKQw=
X-Google-Smtp-Source: ACHHUZ5LYRtJdAdxjy+ccn4spz1/vSAxQC2cahvFcQb+ES2TNjUqZm2oJKcFVWN0/5kCALhertuX3Q==
X-Received: by 2002:a17:902:b110:b0:1aa:f6ed:973d with SMTP id q16-20020a170902b11000b001aaf6ed973dmr12646582plr.55.1683650239053;
        Tue, 09 May 2023 09:37:19 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001a217a7a11csm1812272pls.131.2023.05.09.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:37:18 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Be more shouty if per-process pgtables aren't working
Date:   Tue,  9 May 2023 09:37:11 -0700
Message-Id: <20230509163712.376117-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509163712.376117-1-robdclark@gmail.com>
References: <20230509163712.376117-1-robdclark@gmail.com>
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

