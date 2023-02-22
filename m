Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC069FDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjBVVrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjBVVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:47:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF439CEE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:17 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so8608173lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4TOwLOMt599To1JExzRPWtUssAyU9NR4zE3oZiUZ+A=;
        b=vIL6E4WB430uGyuj0lUufFhuF3CQGdR7a0e2PL3GMslNGEyrtQDEjXZMeY3345jFvp
         HWO1elZEKOm+pdo7JkxplbSgn5GGT34/qsUrVg5t3ihU77eXSDx2zTE4mgNMLojm4Vhx
         MdFudMtuetf1KVuDIDp2jxF4OkeULi7JyBNPMTzKYXq5LG/SSSgT5fbUvFF05j26AqtB
         vyJ5II7jzDWQna98MFh0FBBYs5NK6pS0E66bRO+Rwax/We5NU19WGLzypCiJm5ckFhWj
         h5nAwqCUTPyF4bDoylbIKOJYICX2AvqMnOwvsjcFpGkZjXqjxcyQL1aUDCPiMnXWzTX7
         vQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4TOwLOMt599To1JExzRPWtUssAyU9NR4zE3oZiUZ+A=;
        b=iEkDF9y68iZp2uCjAVM/mO6Q9r6zjsNumkNAoOHaAKj9Hf/D6sd9ULOGEqHk5epm3O
         SYf0OAX7g3jomxfLB2hGYbzr/XkCluO42/bcZ8HwRK5M14PKjXiIEo1k8xl8N9vuoRIA
         794xZwUCRjrM9dB0SupwxnwCeyOQ3fDmj3XneVm5rHALeZroD4fmuWFGn5TquK0z2wVZ
         XPtyFeeAF+7VhnA554xBtf59TeOZYDBiBYTTaTk/RsDKA2VL1C36/HmJe/pRRfJRDhef
         SPCSZJ+vphL23fEJUPF8UbiCqKBzm7C97WEYkk6ibZvCR03LIaKUQ2PZW0WSIzd/EMvH
         Lp+Q==
X-Gm-Message-State: AO0yUKXjIbw1l8/JcVnzoS7jDbZ+EViw/R+9aUt7Vn/n4nnQBCwGYR2L
        i9JfJ/XsNXMjuRl5YeUfkLjZ4Q==
X-Google-Smtp-Source: AK7set+eW4mPqMzVEo+D/f0ChPtdJWyXdI0ZByYaPjTH4iVSby/zH5gzClBzhxeJzbHzlpRzj0AzIQ==
X-Received: by 2002:ac2:521b:0:b0:4da:8838:31d9 with SMTP id a27-20020ac2521b000000b004da883831d9mr2808196lfl.8.1677102436200;
        Wed, 22 Feb 2023 13:47:16 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id c23-20020ac244b7000000b004db5081e3f7sm505126lfm.46.2023.02.22.13.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:47:15 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 22 Feb 2023 22:47:12 +0100
Subject: [PATCH 3/5] drm/msm/a3xx: Implement .gpu_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230222-konrad-longbois-next-v1-3-01021425781b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677102430; l=1323;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=i47Ky4BsxixFNiVTtrlkGNfUWp9lquZtebebI9yr3wY=;
 b=v8h6Dm7DVQ7sOt5Zbr5iRrvE0ULoDp8T5pjmqb2KYeBnxk5vKNo9UlQ2/Sso9Qhla9hLMw4Up0kT
 4+nWOquwCwmoF65CjP0+7f/xpuDb4iBQzCNUnkIRlGCnRE4TyxfE
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

Add support for gpu_busy on a3xx, which is required for devfreq
support.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 948785ed07bb..c86b377f6f0d 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -477,6 +477,16 @@ static struct msm_gpu_state *a3xx_gpu_state_get(struct msm_gpu *gpu)
 	return state;
 }
 
+static u64 a3xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
+{
+	u64 busy_cycles;
+
+	busy_cycles = gpu_read64(gpu, REG_A3XX_RBBM_PERFCTR_RBBM_1_LO);
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
2.39.2

