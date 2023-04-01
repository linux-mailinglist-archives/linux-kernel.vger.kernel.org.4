Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD36D3096
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDAL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDALzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:55:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F942659C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 04:55:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id br6so32194798lfb.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680350124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2TYwAn1Jyo9PBH+9U5+LtUDgGXL54gtjUvzWRdUK1Y=;
        b=MCDfAhrecL41SY1SS6uJ7vUnQxBWQ8vuGxBhgLKL9MOgthQlKYzvUk4YwBsCv5jJ2p
         GSJAMnbGJl+nQXlULJs1FSsSD74MryfUHLHiDNZRDBUHd7b58qX9d1s+KCKVmcvraKc0
         W533Hf9iG2IsGN7c1+DXlBFdGjAN9FQXLXxFkNafV/3JCOQxuN+0u2Qm7I+8VGbvgiff
         PB0Fb+PWONoH7YXQOWBKts8gCSqJIDbtTHRq4iXrZ4K3YFnaXEyCP6o9W9BWuvXoYevS
         Wj/JDr+sYgjWfagMoWqNFMgub18cjNITLh4rTI4gRpRIdi6L8enhVDzo3x2WQ+rxwlLy
         i4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680350124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2TYwAn1Jyo9PBH+9U5+LtUDgGXL54gtjUvzWRdUK1Y=;
        b=O3bw1oh8qgttJx3WCryX1Qk6yzOcNsxGEZiPLqRlyVrDxe/2OtR/NBHZFI5aAralIL
         VjJElF2iBWnlbhJGmKND5/1UHrd8HtSuOt5bZeip7RecBppuy0lFYchI2GaojcDYWmgN
         lxMfcOhaH5k2S2YjyKYxTzx/rM80oU6hz1qvKplMlBGhamf2Mr1FJP7iwgLneAbts5I3
         qmbws9RY9d/6JmIW9TYL6UOwOB7MEOEKBPUG5Ezf2TZskkq/N1R8o67lQwEStPXbaXKT
         ckNk6yiUd2vqiOEhP4I74runz+bvsF5ykMuajtMiAaGiKcSROIbEMuimS13cIAs2din8
         7k2g==
X-Gm-Message-State: AAQBX9eplfd2TtkiYQWWkRh8EfoVZ+m6jqVyQiz6UQxLLa777T7j8X9X
        CimUdBf6dGjdUjGe+gb8IwP64w==
X-Google-Smtp-Source: AKy350Y7b4+rJ7oIMIiEy7rKr+JmgGH1J0f8tpAFMqT1b/f/K/ZRJo33j0ZI8F4dEfux5Qrqr3cw1g==
X-Received: by 2002:a19:550b:0:b0:4e9:c627:195d with SMTP id n11-20020a19550b000000b004e9c627195dmr8145645lfe.57.1680350124471;
        Sat, 01 Apr 2023 04:55:24 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w8-20020ac254a8000000b004e83f386878sm786737lfk.153.2023.04.01.04.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 04:55:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 01 Apr 2023 13:54:49 +0200
Subject: [PATCH v6 12/15] drm/msm/a6xx: Use "else if" in GPU speedbin rev
 matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v6-12-2034115bb60c@linaro.org>
References: <20230223-topic-gmuwrapper-v6-0-2034115bb60c@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v6-0-2034115bb60c@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680350084; l=1434;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PUHRMhG2i7xarnxRfpZn2n4mbPzcd2Fd9BsLsPanfMM=;
 b=9m5H4CFtN6EC+FWJ//p7SwY92+XoqEoJDeGxyad+OdlVR2aSCDzbfBKcJ+7PZ/AAsHVPruU1PezJ
 w6wcitFEBKR7VUABWMNzhZ/JHGR8NcVQdKNySSAZiH+5yNl8KZbU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU can only be one at a time. Turn a series of ifs into if +
elseifs to save some CPU cycles.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 389a1f7251fe..a802a29f8173 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2171,16 +2171,16 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
 		val = a618_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
 		val = a619_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
 		val = adreno_7c3_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
 		val = a640_get_speed_bin(fuse);
 
-	if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
+	else if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
 		val = a650_get_speed_bin(fuse);
 
 	if (val == UINT_MAX) {

-- 
2.40.0

