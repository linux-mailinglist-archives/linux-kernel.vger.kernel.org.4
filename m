Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FF67CFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjAZPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAZPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E66D516
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x10so2131736edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P78YOJNtNx1A2lMURy8WdPKbNTrzZSXLQJ7yOcKbEYY=;
        b=wq6GSpyeEMXTOBvJmDHBN5ji4ivXnfV6rihHo/Ne8y99h+jdCSSvCjP2ZeQ/W7x3lY
         UhHxv6S6ZKxZd8ZJ7O2rARZYrbut5lpyifR3+/AE1HH3Nmd7ZV1IfXoFEpNlmBmhaYQa
         pTf/SBVgjDTZ/zkzvheoLUoHrWZuIMQndXePLN6Pbc57n0FDAHR/UMhMkOgAVcxL3Uhp
         CoxBseBttdnGbudshUi7J1tEf2KttUVvNAKKUnHChSzYT0Z/NZJT+mAyMU8P1HicwXFB
         8ae8PVtNdXzrp1l2YwlRJ3NdQyktm5MAkHxP1yIrhWLh8/q1bf6XaXTmgBZCynaFuNME
         D8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P78YOJNtNx1A2lMURy8WdPKbNTrzZSXLQJ7yOcKbEYY=;
        b=Si7r6M9KEg5KOnd4T0Bw6h1AVurSPgdBdlb0+MTp2Woy4XU8JlUUvxDdo+vBuwsrU6
         xflXWSvIZ9zPJ6rqske6j2k5UyVe9Txztk9iVnbiV4vvBy0Tp26Sgip8a8TVdI98dqW9
         0VbSdWP5lp1Y3rIJmd3l0n7ltzmtyamjOuWePcwQLHbi8oHpmBtWmMjAe1CY4zfLZ0NR
         qy5FUWXo57bpbUgQbsNouf4OYCPRbFcAWUefXyKrC8C9fhhoF/122tqNzlhPkA02QqFE
         ffVM4UQLF1EQVLHQiwY4p7EESFN3zb4LBDk9Dd1Hs4VYtK+vDqu5RU7XnsyGKZITU9tc
         K9sw==
X-Gm-Message-State: AFqh2kpr1Ne+d0i2+vC4juKDEP3qPo1qzrMi6KgoXxpaLIlkvrEu7VmE
        0QStunWefXv8gJXW4rtTYRuwdw==
X-Google-Smtp-Source: AMrXdXtxeY99s2JoW44yFytv4ncyFOE4J6oC7Lu7h/IKDvpmk89qOGy0wDEMAYv+E7HHc7+NFrIgDg==
X-Received: by 2002:a05:6402:230c:b0:48d:91a9:2cd0 with SMTP id l12-20020a056402230c00b0048d91a92cd0mr32222832eda.29.1674746267542;
        Thu, 26 Jan 2023 07:17:47 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] drm/msm/a6xx: Fix some A619 tunables
Date:   Thu, 26 Jan 2023 16:16:13 +0100
Message-Id: <20230126151618.225127-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126151618.225127-1-konrad.dybcio@linaro.org>
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adreno 619 expects some tunables to be set differently. Make up for it.

Fixes: b7616b5c69e6 ("drm/msm/adreno: Add A619 support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7a480705f407..f34ab3f39f09 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1171,6 +1171,8 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
 	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
+	else if (adreno_is_a619(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00018000);
 	else if (adreno_is_a610(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
 	else
@@ -1188,7 +1190,9 @@ static int hw_init(struct msm_gpu *gpu)
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
2.39.1

