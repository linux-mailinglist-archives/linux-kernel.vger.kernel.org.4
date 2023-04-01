Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D436D3073
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDALzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDALzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:55:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD226253
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 04:55:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so32245543lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680350109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqvvserEEXfM7bfoSIgCSJ4UIeQQqPEniXobIbd6OmA=;
        b=MfjdIHHRqsbWEVlfHK0yGymcYsI7duJyM63jJzDNNQPTU0pcfN9iep6PvHm3ABq5dj
         F/dtRF4FNAA086+KXdcWwmyDia1xv8k+i+kr2LOmzkTMltgWxJJcUedkQApqV1qh27R7
         X2/8+VksnkZ2CuSP+WPcBRMwX0Wsh54fhS/j30VEZwJf2UQI6Z5HCi8JEHZ7NJ74s2VH
         w7m6t20chxaDnJhIptbRR8sc5YK9KdXqiZl0OsD+isjFwI5F7KuK1tXja3JPNPjbYEXS
         3aPLmix353GOLFIfD+oTKaZuiZTgZ75+9+XM1Qi8A2GWJBE6URjPzNLYfA/VTJl4/W6S
         MAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680350109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqvvserEEXfM7bfoSIgCSJ4UIeQQqPEniXobIbd6OmA=;
        b=JBvQNU6yXYfOzBM/Lez0way2hoQYbRoktIeLJwPHob0K8n2KFytw1AES1karRudEZE
         c1O/3el+tznyUGhaZn854f5SDF3bSacIGEOUHBKu04W+yEJ354tat4/MBP33Ei/YvSgT
         /TAQIJVqozzbmlOCUgw6aZYv1G82NB3xWGTO8zo7D8231lt5vaXUs9LQGiVg+1XszCB+
         0GpIN4v3wAJbVd3zWjlo6hh+XxulzCuHRqFR8oqihPbOhhHaAibySHHsd5InKSrsO9yF
         UUB1G4yDx33uIkt3/W9pByxTq9zxu7EiSgcMLxslRm8pPGDDSWsngDEdK0YULxtfBIGA
         gI/g==
X-Gm-Message-State: AAQBX9e57OmiiwpT1OoAD5LfJqhPRk80uRcbshc+u+gGbxSCLxYliXIZ
        9/z/B6k+wsqnKAVN5lmiYbT5uA==
X-Google-Smtp-Source: AKy350ZKsnq/mrUrLvubE5qPEGQ/Cxi2AShVFNWxCEZi7DwG0jehzrqC/mrcfTHsYp8T63gYlCU9lA==
X-Received: by 2002:a19:c51a:0:b0:4de:3c94:da15 with SMTP id w26-20020a19c51a000000b004de3c94da15mr9296547lfe.4.1680350108727;
        Sat, 01 Apr 2023 04:55:08 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w8-20020ac254a8000000b004e83f386878sm786737lfk.153.2023.04.01.04.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 04:55:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 01 Apr 2023 13:54:44 +0200
Subject: [PATCH v6 07/15] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt
 on hw init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v6-7-2034115bb60c@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680350084; l=1312;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LfJKI18ku3LCGvhXVjTfawfZ9xevg/d8d9jIr1dnQAM=;
 b=CV/tjUnURsDiZN4KzTdlbV/FyDcpzvhj9HHJ4JsESoZynabtlFtD5aJ2O1Zi5t0SpVVptHxNEgVF
 xPBV/dlRBEBxymgIl8ldYKixPvQxBkelTh8mkZowc9zhAnRmgELD
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

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0. For GMU-equipped GPUs this is
done in a6xx_bus_clear_pending_transactions(), but for the GMU-less
ones we have to do it *somewhere*. Unhalting both side by side sounds
like a good plan and it won't cause any issues if it's unnecessary.

Also, add a memory barrier to ensure it's gone through.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8e0345ffab81..17e314a745c3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1031,8 +1031,12 @@ static int hw_init(struct msm_gpu *gpu)
 	}
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
-	if (a6xx_has_gbif(adreno_gpu))
+	if (a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
+		/* Let's make extra sure that the GPU can access the memory.. */
+		mb();
+	}
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 

-- 
2.40.0

