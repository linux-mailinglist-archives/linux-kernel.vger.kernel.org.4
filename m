Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF869FDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjBVVr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjBVVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:47:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C646162
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:19 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f41so11853632lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBObAXrrIUPtcxXkSYb1/MPep4XlGTpRKBjzQvdnZZw=;
        b=DYSfqZcq1BWpH+P2IBd79HjNKdKOG3b8AjS3DIzytdnEhbqpWN/TgFGuXhJ9HI12Q3
         gSc2dvaycy+N3a8rxLUr/kQpz58VcT8cFeD/FRCfbo0gsX7gLrs/YBKoX8xQoP7Mlz4u
         37JNW1PJvoQ3RHem/XqNNt/Aty2SzoY5HsD9GY3oIXWgGIiJd6n+dRV+AmxOVsCWe7OX
         pwJAmELMnjZLaSsdC4s8lT98kyXkPA5J8S0erUdGXVJXyLVO25+VIaCEOOqg8cD5XuV0
         1In1RxBkjZi1Fx5cIh1DqgkQ4E0WF6yPIcFufuu3YgMeoAfB5j8nywnzViKwwkXISnlv
         BeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBObAXrrIUPtcxXkSYb1/MPep4XlGTpRKBjzQvdnZZw=;
        b=NC1kUy+liesrpCox/lsfOgycitt18RVRv7tbTZtkyVGRkyB/Zh60vi/6q4q+Qtlu5h
         Fl0GhO4BmKZ62etKKaa4dp/87fY+dm2iYWalSIKLB+53bB4WlDwd4wGx+CIrumajOHRQ
         LGYvamoPnNPzN3AaC/9vKnKyqd++XsCU1M9siMSLsfRowEQXOXxaFoPWrw8crBh6bP5c
         tt7AgwjkvAXfCzPSAgA67kRS5oIWasLwv3tGUArYF5kQ87Z3F6MiqXEiYp4iXFCLirZb
         x5VH3d7lxMMekE2FVwbaqlGnU2dZxN3XmPJ+3sYhlOsr8+M+PTs0PrDZEIfdZL6+KyAp
         IAXQ==
X-Gm-Message-State: AO0yUKUA4haKFysu/rH4tYH7NNXnKGOys8AF+QJ5KXxTKHMCqRIaMYIr
        pAwP5Soss6gVo6x57o/1sTat6A==
X-Google-Smtp-Source: AK7set8TVuK6O3j1A8cKQm/rm5TJ/U1qSbdnto6SXbID7beCkWyu0PMvaFkdf8HTx2O7tdm/3pc17A==
X-Received: by 2002:ac2:568d:0:b0:4db:1b30:e634 with SMTP id 13-20020ac2568d000000b004db1b30e634mr2851991lfr.65.1677102437491;
        Wed, 22 Feb 2023 13:47:17 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id c23-20020ac244b7000000b004db5081e3f7sm505126lfm.46.2023.02.22.13.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:47:17 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 22 Feb 2023 22:47:13 +0100
Subject: [PATCH 4/5] drm/msm/a4xx: Implement .gpu_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230222-konrad-longbois-next-v1-4-01021425781b@linaro.org>
References: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
In-Reply-To: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677102430; l=1318;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MauCU/9YqXIm/dt7dtytFcQBPIj8IAOvGMxFT4S8Dyc=;
 b=QP/b0QG4Xziuy8NNeXVPRPJH7YGpUoSLjur6u0R/Y4RiCLZ1iUjbF/PJzlgL6+eqAwD9/vnnCxZG
 rE5QRKXECnql9QRhMyM73Qpy3yERT9D7erzVd9cu5uOP/HjMtgUw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for gpu_busy on a4xx, which is required for devfreq
support.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 3e09d3a7a0ac..715436cb3996 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -611,6 +611,16 @@ static int a4xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
 	return 0;
 }
 
+static u64 a4xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
+{
+	u64 busy_cycles;
+
+	busy_cycles = gpu_read64(gpu, REG_A4XX_RBBM_PERFCTR_RBBM_1_LO);
+	*out_sample_rate = clk_get_rate(gpu->core_clk);
+
+	return busy_cycles;
+}
+
 static u32 a4xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	ring->memptrs->rptr = gpu_read(gpu, REG_A4XX_CP_RB_RPTR);
@@ -632,6 +642,7 @@ static const struct adreno_gpu_funcs funcs = {
 #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
 		.show = adreno_show,
 #endif
+		.gpu_busy = a4xx_gpu_busy,
 		.gpu_state_get = a4xx_gpu_state_get,
 		.gpu_state_put = adreno_gpu_state_put,
 		.create_address_space = adreno_create_address_space,

-- 
2.39.2

