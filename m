Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83337419A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjF1Uf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF1Ufg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6671FF6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so80846e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687984533; x=1690576533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtpQvzp4RpyUG/PwqaST+5tYMMgpC5C6Y/5Ihh3AMLQ=;
        b=eRUCKRekrZjHJpsZkazD1CQsku0JiP3yeQQhB5BhMUaety7kgG4AFhrlgwRlP8ji1x
         XgQwJiAJXpDIkcYmuS+KUQSeskxt788EsBO1/wZY3cLqaGdcE9yS3s2Q4QWsQtbbOlkw
         rfZMnSrOe96vQqCsOmmsWuzaTAPQFWa2xCj6wSHhxjglkqhVEOpGAJzRh7+DL1imZvAN
         79/7I/UnYL9PytvoGdwQUjQB+wN7OwOWwahkR6SpKab4ldhjozV0n2NlDyz+zJwb9yB9
         BfjkhHZAISphtlDFA5MjK3kacWO2eq9TJUF3lQ2f/qlLxqjo5E/FX9I1mDM/xbYlh/n2
         o9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984533; x=1690576533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtpQvzp4RpyUG/PwqaST+5tYMMgpC5C6Y/5Ihh3AMLQ=;
        b=Lfsp++1qok79LNipshveTdkmDOid819Yf6R+AVnPKpAtTIMvQj0qg2oUMwC1ziwbtu
         LvVNH/8S9/XreDUSWPjMxwaLFwjDutQYQ39arjqLT3T6uuOkHux3OS2GLB54qbHhXD0E
         ThW7ERKPkIWFa6q710Vp0ZDEbPJMqKk38ymKhbaYX5SIXe6KhthBX7NtvlOEtXYEB/I+
         8EsyCzlvE/zao4Uy7BKWyVFcVOUJPitI1ganwynZ018NeSust65Ihy8ndEeTL9Zdl2AB
         9vsG54CNFv1YM1ElafknrnYKpRx8sRgFtdozEJiihYddbss/I9AotBJmdugrJrSD0p4g
         IkbA==
X-Gm-Message-State: AC+VfDxDIsCgIDfaC1tGEUUOdAHphoZcPkpEjuuhoKGsdNmuG6LogS73
        4RHBrlDOgCEto1Cwd17BrH6icw==
X-Google-Smtp-Source: ACHHUZ4uGYGv5RouOZ7IOh/HeB4Lh6M5iGT2Ode+APGSuhS8itbLrgq/rOdeNAb5HXfybgd6tpS7Bw==
X-Received: by 2002:a05:6512:3d8b:b0:4fa:5e76:7ad4 with SMTP id k11-20020a0565123d8b00b004fa5e767ad4mr9970258lfv.10.1687984532977;
        Wed, 28 Jun 2023 13:35:32 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512015900b004fb86c89fa1sm753363lfo.135.2023.06.28.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:35:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 22:35:05 +0200
Subject: [PATCH 05/14] drm/msm/a6xx: Introduce a6xx_llc_read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v1-5-a7f4496e0c12@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687984524; l=909;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+c+we8nCMly7yIkJ6dm5RdbFwSno59/Ex2lT1jIgyL0=;
 b=EXC4gaMs7g1fnr8cXfio+6LPLGT4COF/g31FpebXZDdZ8J1XKs2kcr74BVY+zK0BoOUiw9mvT
 P1Ilely/ODtBXuhV0Rf+KSVfXzQKUvdj0LNK/KbYosjeKMVEq2kYOHb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper that does exactly what it says on the can, it'll be
required for A7xx.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 488c69cf08d3..a70e36178058 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1740,6 +1740,11 @@ static void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
 	return msm_rmw(a6xx_gpu->llc_mmio + (reg << 2), mask, or);
 }
 
+static u32 a6xx_llc_read(struct a6xx_gpu *a6xx_gpu, u32 reg)
+{
+	return msm_readl(a6xx_gpu->llc_mmio + (reg << 2));
+}
+
 static void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
 {
 	msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));

-- 
2.41.0

