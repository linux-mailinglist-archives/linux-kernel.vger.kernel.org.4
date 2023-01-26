Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D667CFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjAZPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjAZPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9D52068E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x10so2132032edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CddRwSzocQvRockEdA4yvKkrPdK0c3Dd42RlRLUcF2Y=;
        b=GXmG/u1h816X05sgf8P1FECsAAVuqm7W8uZuzMlJ3yYinH721+FYFN9aDfAmNDTt1p
         X9WWXSUesFBuZNbZ5sXvXaQLbK7szTktWxlPz8/sR7fOQ6jSW/EE1ZexvSS6g58+CAEd
         CaOmskiFbo7tqyydjQV7uLLRxEo/8jf8AsSF+y0cW7iHOMUC9LVv9YTjn2VjVCHDC1uC
         Wn48JLQeSpERIKxWCkbVTLUQ5rD1nve44WQniwh5GbVBrVkkjPvHkoUcyVav3Adia2j1
         IgxcaUYHYDIYJINQsTEg9zm/4L6Gg1nOz4Bzk7kqur55bEQpPoeZhDBmxAhgIXwobgYg
         M6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CddRwSzocQvRockEdA4yvKkrPdK0c3Dd42RlRLUcF2Y=;
        b=3oX3rdzf4HuoDyQcPODzXbNRHR6lZCUcfqncdQ6EnjaRvJ7HoiJRvdwplCiM8RK/ZV
         02hRCua6bQ+qP4vkr1e1a82VZ6f3MDeomKRfWoPY3w9zigCyFWe8Eg+KQA1fdm3FcY0b
         bABzFlhmsfRVCUMNQf0o7moTUUt1sdNAf7TqQweMKQ0xXexw7oFCnmiC27oIR1m+nGOh
         09ls3ziUnF4BmJ8OkADt2m2sQsUrmGLcfF9R2/MM5g/MjlhJFgYxqiQDpoIQWOOF/Vr+
         /kdATda++/IrbHCbUrt2btejticV8WjeFSbk5ilsTSTVFH7dNCwp40xRiUeOTxQs15v/
         ABgg==
X-Gm-Message-State: AO0yUKUgwKgbbS2KlJRBx7abUv6HxIHhMXBeqbG1KmTWCen5iXLkV6YI
        Jd/WIz6tNH0r2Sq8JufoEaMapw==
X-Google-Smtp-Source: AK7set/ykZUSLMStAUNJlo7q5VvG2BHWVGFSh8/CbaVeBRoljyctPOuurEQckisZ2pmnXW2EGweKww==
X-Received: by 2002:a05:6402:430b:b0:4a0:afd5:df81 with SMTP id m11-20020a056402430b00b004a0afd5df81mr7170467edc.35.1674746274366;
        Thu, 26 Jan 2023 07:17:54 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:54 -0800 (PST)
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
Subject: [PATCH 11/14] drm/msm/a6xx: Enable optional icc voting from OPP tables
Date:   Thu, 26 Jan 2023 16:16:15 +0100
Message-Id: <20230126151618.225127-12-konrad.dybcio@linaro.org>
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

On GMU-equipped GPUs, the GMU requests appropriate bandwidth votes
for us. This is however not the case for the other GPUs. Add the
dev_pm_opp_of_find_icc_paths() call to let the OPP framework handle
bus voting as part of power level setting.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 62f504ed7ef5..6d6b71306ee5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2335,5 +2335,9 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		msm_mmu_set_fault_handler(gpu->aspace->mmu, gpu,
 				a6xx_fault_handler);
 
+	ret = dev_pm_opp_of_find_icc_paths(&pdev->dev, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return gpu;
 }
-- 
2.39.1

