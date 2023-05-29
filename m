Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B76714B10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjE2Nx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjE2NxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:53:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53EE4E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f505aace48so685048e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368366; x=1687960366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0LrHIoKMzpMSQj7S94ysxSa7kN4w0dJYmcCGd0sdww=;
        b=hnuJWAIwsEFc7/YYazlsDTw8xEguC4sKCwdzkX3AA99I6ocdoXqokdoYbP2tZzIgeT
         PBYv318NxcVlsIiRmoEKgenazmmLK0BayPCbuebaIs3VGp0bEd+NWLY4E3iHwJEQgb4B
         I9+1Z7cSowxPtha8RXsSDNyLdIVd3qmtcit4qqNKxpFwFt4D58ByfgbDdmjCYomzA9KJ
         FZZW2lh+1xA2V4ueX/WdDLig/rOKulre8i8lrl+IxGbJc47SKmkrcu9YIHPeFmmo25mf
         FR44e5Vc9L7KtZsKW1PvR7pMPMl5qwtfawnM9su8o7nK9KywQ5GlG7ytMSZYDo9Kmiiv
         wtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368366; x=1687960366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0LrHIoKMzpMSQj7S94ysxSa7kN4w0dJYmcCGd0sdww=;
        b=XoZo2YfcREUYhJLV8V9JQCpF9BR3MGFDCNq3dDEwKj5wSyvLN4R7dgvC0bZUcaj7D8
         XZxyDfYU18bN8c67NY3J3mSUO2q9jWLyN/iaXxo0ffw/ednRAPHE6djinRy3o0qFhi0s
         vlmUCxdZr/52DILISrIRY0P6egund8ChNUkqLOPsgB4jLI492Z7aV8yBKwgHog7K4dsY
         CMGAC4r7ApxgithZXqTRqloEJTpBxqFlZa+1XEYEMSqitdMhUIgtcDr3r578iMT5utlN
         VsfUGmsvCl2O3lJkEpgCxuV+QVWqViy65V9Seg+vgYAnUFRhjN6JADEqXBVizvx69ng8
         jpUA==
X-Gm-Message-State: AC+VfDw4JUXJMTf6daiuVl1SNpCh9XLUlN8d0udtQFkdYATfGM6DusKx
        EicclrSurealFKcpYJYbIHHlpA==
X-Google-Smtp-Source: ACHHUZ5exnJXX1LXjlZtk0l0vmA9ygM6CcJE4FFpnnIm1x+2dMBQtIhRP5pJHWpYe2wyW7MFSpGq4w==
X-Received: by 2002:a19:f719:0:b0:4ef:ec6a:198c with SMTP id z25-20020a19f719000000b004efec6a198cmr3110552lfe.26.1685368365835;
        Mon, 29 May 2023 06:52:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25310000000b004f2532cfbc1sm4700lfh.81.2023.05.29.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:52:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 29 May 2023 15:52:33 +0200
Subject: [PATCH v8 14/18] drm/msm/a6xx: Fix some A619 tunables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v8-14-69c68206609e@linaro.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685368343; l=1537;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y8lqQEXvfobjnxymY2ZJobXRHcQDq3saaResmTzrax8=;
 b=0l/msX5u1fAAB673veV9WhNa4MyJFgZY6bsag3fnS7Fm/CnUW1L2vIG2JTbgaW4yY9HZjwMuX
 nu7LjYRRRUqDMwPrsLqOl4IXGxUyjAD45jIblCiAtXZTdtePHkgY++d
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adreno 619 expects some tunables to be set differently. Make up for it.

Fixes: b7616b5c69e6 ("drm/msm/adreno: Add A619 support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c0d5973320d9..1a29e7dd9975 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1198,6 +1198,8 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
 	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
+	else if (adreno_is_a619(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00018000);
 	else if (adreno_is_a610(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
 	else
@@ -1215,7 +1217,9 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_set_ubwc_config(gpu);
 
 	/* Enable fault detection */
-	if (adreno_is_a610(adreno_gpu))
+	if (adreno_is_a619(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
+	else if (adreno_is_a610(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
 	else
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);

-- 
2.40.1

