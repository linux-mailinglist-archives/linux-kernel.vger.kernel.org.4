Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5736F480C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjEBQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjEBQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:10:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8ED421C;
        Tue,  2 May 2023 09:09:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso3057925b3a.0;
        Tue, 02 May 2023 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043797; x=1685635797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jhmn/igXsSQ1CgSsPa7t8gOoGNkMRgv5IZ8g6dlT48=;
        b=pJzuaACIWttjwELslkpHg1tCXmshS+yvKzlM2sclBeAZBqaktTCJdD8yhUTXg6i86o
         kkwivrOJHKBy0LnooQV+X+6wciXVy1C8bgD6obbCrIovO4o7JCJyWvxNBWuuNZQdyXMh
         ghBFTeWdu9LakvzS/7diA7EcEe5Y3IGFSGBdFG6gVFR36kYEii+W1Ln4aQrRVDL2vY6H
         ateJACxLjPKew3Jlx77UBG5H8o/1WKbDKyW1ehws+4PP0j+NpmwJuhW9aOMcN+rRUeYY
         RxY/MSmjaciiP9i16n2WmasfMoM65dS36Y6GCusdODbbUoFwHQFWd8EseLIOad7WuW8R
         O72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043797; x=1685635797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jhmn/igXsSQ1CgSsPa7t8gOoGNkMRgv5IZ8g6dlT48=;
        b=QU6aIU2TWtSH76cFaJyRA8oUIGrkY6naUYsF7fO7UOJdFNxR05q/tt5uOQWHM6WIon
         x+fPtHA30IMUe00GXwP5RjKzTde0Dr6t8+ciR2XjnxlU5vPQ//+GLqBUSz1F80sgGzio
         lzNfSBbHoR9FI3pyeEIbNtUUdBjM5LqJqx+G4PwaSX28Le/V1eTB6eWDUHN94R1kATTf
         iXYMlpHn1GrFV9ojqCppttX9Ftse01aP76ciDVmKbspgj3JNMYtjqMmNPhCy/uBg6iOf
         HjBfKkNzW+Z/XDurLqaxleA+7xSwLmgz6xyt1bxyTEDqn/Uca2WJhkPJS70DafXFih0l
         sthw==
X-Gm-Message-State: AC+VfDxF4QQAyK7u+5S/PVD1/fHbjW19i4nzqUs8Yyx1M2bJJLAoBpJF
        55b73BeSK8WsLQq02FNYGfFnfEYmWC4=
X-Google-Smtp-Source: ACHHUZ4S2jGKgufIL9tpXhjYzZqUINYF6azJ3+MOLssaF0FK1bp3oJJJR7P9lf0iUWJblNhY54sFLw==
X-Received: by 2002:a05:6a20:d69a:b0:ee:2bc1:6e01 with SMTP id it26-20020a056a20d69a00b000ee2bc16e01mr18312922pzb.24.1683043797412;
        Tue, 02 May 2023 09:09:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id u29-20020a056a00099d00b0063d2bb0d107sm22055505pfg.64.2023.05.02.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:09:57 -0700 (PDT)
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
Date:   Tue,  2 May 2023 09:09:48 -0700
Message-Id: <20230502160950.1758826-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230502160950.1758826-1-robdclark@gmail.com>
References: <20230502160950.1758826-1-robdclark@gmail.com>
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
 drivers/gpu/drm/msm/msm_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 418e1e06cdde..1b7792d35860 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -224,24 +224,25 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 
 struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 {
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(parent->dev);
 	struct msm_iommu *iommu = to_msm_iommu(parent);
 	struct msm_iommu_pagetable *pagetable;
 	const struct io_pgtable_cfg *ttbr1_cfg = NULL;
 	struct io_pgtable_cfg ttbr0_cfg;
 	int ret;
 
+
 	/* Get the pagetable configuration from the domain */
 	if (adreno_smmu->cookie)
 		ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
-	if (!ttbr1_cfg)
+	if (WARN_ON_ONCE(!ttbr1_cfg))
 		return ERR_PTR(-ENODEV);
 
 	pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
 	if (!pagetable)
 		return ERR_PTR(-ENOMEM);
 
 	msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
 		MSM_MMU_IOMMU_PAGETABLE);
 
 	/* Clone the TTBR1 cfg as starting point for TTBR0 cfg: */
-- 
2.39.2

