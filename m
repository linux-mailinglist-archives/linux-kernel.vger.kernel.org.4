Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86F696B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjBNRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjBNRcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:32:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BB7222D7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cq19so15759490edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EA1b5UTex55XllBD6bRoH4DWPyBOS6Byl63HktcTps=;
        b=K6/tdJd6N0v3nJ8vDPKfNTISEMq95ZGjV9FRfudOu07WSeljh+UpcF1v2zh/0MCzL3
         8R0Ay0qWaJ2MBu3EHNgb57mkdTcgC/lHF6Xvnpx8xuxdlUSGsv5PYlVSzFBpblMb7A2B
         agJBMWrqquIOsf7Q63LXMJsQn+iwnPjkJztNMlCLQRASV1WJf+0vMkxonhYkhEYeR2K/
         wg9+P5/vTLAd4RpuQv0+4k0cv2V4ckLiaw1ARY37JE/q413qnyLZx2PC8wu/hcU7Zyof
         kVsbNkakV80AKKTn0il1RM9dYGhoIBhIEFoH75/d0YRfW3UuVVD/GlIA7T7FZ6LKwTa6
         q6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EA1b5UTex55XllBD6bRoH4DWPyBOS6Byl63HktcTps=;
        b=YL15kurEkMxmjL+yaJm5Dm/gav78j6LYriGqw3LuDGJIJvAV/ZCQ6Ps0ZdZPU38h68
         VLTzJIv0FVTjy737xIhNDhnVc1EuRLStNuvHbABJu3MtQtEDa4ahAfNMGvgvh5aOlHVO
         4FVc1JY8+Xt6QBkiilbq1cMLg3AyGdy0g7Nt0yQYpk1b92knEyS9/IH5xm+IY39XA8gg
         udRKnVjYtnbPr65bepb+ZPmWFd20McHPCGNdU5CI1t9UWzf4iiKPP7ykmDZW7YBaVcQa
         CU4pusqZyWsytheGT7UCJoa0fUrO0YoF15NzYjhWxoGZl3WgLJj+Yxm/INsVdCKUfxSn
         WdNg==
X-Gm-Message-State: AO0yUKU/pGKPzpJfxbE9OVNDJUSlVJt0ioPm6gBH9HfWdUyxvTMUOnip
        R9eDWjC7/Xguh0OsBGOIW80W3g==
X-Google-Smtp-Source: AK7set/sWMkw/dT7MHPH5kLLgzjXR6eUgX+yFgkXAcf78AHU0fCmCXGasaExRcaVeh2r93kf0lOWDg==
X-Received: by 2002:a50:a456:0:b0:4ac:cf29:1a6a with SMTP id v22-20020a50a456000000b004accf291a6amr3517283edb.20.1676395926186;
        Tue, 14 Feb 2023 09:32:06 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm8325787edf.24.2023.02.14.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:32:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
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
Subject: [PATCH v2 04/14] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt on hw init
Date:   Tue, 14 Feb 2023 18:31:35 +0100
Message-Id: <20230214173145.2482651-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
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

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0. For GMU-equipped GPUs this is
done in a6xx_bus_clear_pending_transactions(), but for the GMU-less
ones we have to do it *somewhere*. Unhalting both side by side sounds
like a good plan and it won't cause any issues if it's unnecessary.

Also, add a memory barrier to ensure it's gone through.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 72bf5c9f7ff1..75cf94b03c29 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1007,8 +1007,12 @@ static int hw_init(struct msm_gpu *gpu)
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
2.39.1

