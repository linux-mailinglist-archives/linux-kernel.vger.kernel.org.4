Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D606809BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjA3Jiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjA3Jiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:38:52 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999C1027B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:38:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m2so29461467ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzQMMKcx09uqvwkgBAEJEp/XB8h4L/XPIaqj+sdWOGo=;
        b=aFnPqKDiZvokU1Ld9YVGuCQmLju46h8Ps4IdtGRs35c417o8G3yZFWbdUuURbsUUV6
         LPBbq1Zxb4S0wZJSHzgwzOtBcymhxWyplCdw+SFy5H087tb++iLOl7ekhob+0ljxV8My
         HDroHVCds5UyDOdGNNdpiQwFjkIPzQoBGbFdJgsCk1UlZIueccMNs94n19FwJsMY1MbS
         q/EtADGLM/NqgBOvx7qZThR6/g16OZJDzakdg50b9VNHm/ursOvTgY98Sblg2ipKtfJg
         p1GFcQOu71B7AnN9uSTt6pMyY1wjkCkFwoVE5TL9fR2/s3typ5Re1t8jqTGywYGlgY6a
         Rpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzQMMKcx09uqvwkgBAEJEp/XB8h4L/XPIaqj+sdWOGo=;
        b=dp3D2YNDkz1fyd97dMGDyPLouAcHdvXlYVsYl+Wqp8yIe1Bkf8zlsvvTTO3vlZU3t3
         +5Jxa4igtliLkLxF0glYA99RPZLDSN/OUFoftHx2X7MhgHQM7Tin2Yud+NjG6KfAgaPd
         /slE2ddmFV+zbvo31aUGFGHj1qxeaKa694BGwbq9A0W4GoQEz13B6Y38BZx6QCFZYnKr
         67YTwAbzm1egCS01CrQ4g3qtDmRe2mdh1Cp/3i/2UnNf5DySrmNKAyEsDsCv1qROhkgK
         EVv1gB//JcX1dsQLkuUSCkB8/iv+4FczwHohJ888PLvWXB+ez0lmBSuL4kF2S3fMcSjt
         X1zA==
X-Gm-Message-State: AO0yUKValCV2qsv9wZTzA23Bjb1Gzrp16ksLXF0nOsohobMOp3D6WWBP
        DyiPMte8kGxXFXizuSwDwp66SA==
X-Google-Smtp-Source: AK7set/Q8cFkx1KpIuuzDQfTJlgcFrvMRn26TPdEPM4KQ4E1HvWKmTFvnJdOiF00VXMaNhm6FU3idw==
X-Received: by 2002:a17:907:3ea1:b0:87b:1be:a8bf with SMTP id hs33-20020a1709073ea100b0087b01bea8bfmr15030746ejc.30.1675071493555;
        Mon, 30 Jan 2023 01:38:13 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906685a00b008878909859bsm1951398ejs.152.2023.01.30.01.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:38:13 -0800 (PST)
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
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/a3xx: Implement .gpu_busy
Date:   Mon, 30 Jan 2023 10:38:09 +0100
Message-Id: <20230130093809.2079314-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Add support for gpu_busy on a3xx, which is required for devfreq
support.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 948785ed07bb..1923388eacd8 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -477,6 +477,16 @@ static struct msm_gpu_state *a3xx_gpu_state_get(struct msm_gpu *gpu)
 	return state;
 }
 
+static u64 a3xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
+{
+	u64 busy_cycles;
+
+	busy_cycles = gpu_read64(gpu, REG_A3XX_RBBM_PERFCTR_RBBM_0_LO);
+	*out_sample_rate = clk_get_rate(gpu->core_clk);
+
+	return busy_cycles;
+}
+
 static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
@@ -498,6 +508,7 @@ static const struct adreno_gpu_funcs funcs = {
 #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
 		.show = adreno_show,
 #endif
+		.gpu_busy = a3xx_gpu_busy,
 		.gpu_state_get = a3xx_gpu_state_get,
 		.gpu_state_put = adreno_gpu_state_put,
 		.create_address_space = adreno_create_address_space,
-- 
2.39.1

