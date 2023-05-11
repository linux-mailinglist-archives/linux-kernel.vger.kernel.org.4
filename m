Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602646FF55A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjEKO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbjEKO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:59:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00910CF;
        Thu, 11 May 2023 07:59:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2502346bea0so5394135a91.2;
        Thu, 11 May 2023 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817155; x=1686409155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osWWYYQseCvJCBZt1Q3stKtUhhbUrnP9MQ0pNGBM3gY=;
        b=XAwtDDfL4AebuXak7bNPPI87nvTlXoYVEeNLYlT0BUwe4sk+v7jj2fSMAaMAVEkLac
         ASTV+Qd+a+iHRSsrr45q79TD3dqZjxXhxlxvWMDbkTRuogCV00CMQWXjxNJczItOgTLg
         yIXphxYtHPyqzJRpdLXhyd5kbt7fPsdqfPUEjC07crjg5JAzPfBYhLSaXouULyYUbUSb
         yAMWFEkA+uKWjPKiyonpbvNWr5WZeGFVeMqxrMvKzKfS2KZtz78sVhZ1nO2EDLxnlvnb
         5K6F6qy+H8TL5DZ0JLMmh9pfcfZ/e0whO3kjLiwSmpyWIyju/Pm3UibZf+n+1Ksn+Lci
         AmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817155; x=1686409155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osWWYYQseCvJCBZt1Q3stKtUhhbUrnP9MQ0pNGBM3gY=;
        b=b13Swe2+lBx0tLXU5CnGigiyLvGp6FJBjwdnXvtYL/PTHyFAG48gPMPKbNCwunuSPb
         cH+axUDsm6QtUyfgEC+nCYW8WtljXh7x2Xocp6+1fMt4sThqO69Ru2HO0VCNBErgyJos
         y1qOCQa52JoxGWJ1i8OsOl1aCKr1UzRwXdAJwfBAulyURXjKUh4GXK/OUQAAJP/GMN7X
         L2aRAcobcozJ/G4Uci/UsQlLF6D60Rd7staJbI4BvYcDXxIbx0BOn3hjcK1KT6ACi9hh
         bWt6NWFibZuH24FTaysVz6as4+10u5XtF3uCz3saNOgxVf1CuJ54rIyVxCDzCC9B0HeO
         /jxQ==
X-Gm-Message-State: AC+VfDwW8ENFPi3f+enblDT26D+Q4gq7lZoJ12ehOwCVQ8qML5RtysQu
        H6Cd/cHVxskWdouaOa6rsRo=
X-Google-Smtp-Source: ACHHUZ5R5SEh6hgEPBhrxyDoUJPaDfMiz4Rtx25aiaUxPLerkMMf/9r2TREIx7jtkfBBQqUHdw7JYQ==
X-Received: by 2002:a17:90b:1992:b0:24e:55c3:89af with SMTP id mv18-20020a17090b199200b0024e55c389afmr21638386pjb.18.1683817154440;
        Thu, 11 May 2023 07:59:14 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090acb8100b0024e2980574asm15558660pju.4.2023.05.11.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:59:14 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/msm: Be more shouty if per-process pgtables aren't working
Date:   Thu, 11 May 2023 07:59:06 -0700
Message-Id: <20230511145908.597683-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511145908.597683-1-robdclark@gmail.com>
References: <20230511145908.597683-1-robdclark@gmail.com>
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

