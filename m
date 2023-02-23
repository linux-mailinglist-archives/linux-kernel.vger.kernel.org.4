Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A059D6A06AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjBWKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjBWKwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745D5A3BB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:10 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i9so13106358lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RozdFg8UcjNGaMEUfY94uV2Q1ptXwQxOYUwNdKHWzQ=;
        b=GGxvm6blqyc89yQk58xauwymRokHUWjtnfkAy0M5C/kAVwDVTzl5V5K3cPOqw/6Wz2
         I+SFohN/OEwGh2D1YA9QotnOOOtXEozSgwQ5LYVWUzsf1+Ad3VGPeDwANoTmFyPhHz+L
         h1EFNvVz2N4El2qWdqCvQZ4Nx1n+SU+VA5embliA1uijST9wNBP992di58UohE6MNHH2
         hUPJKKiB+MaldLPl1+y9bvMNtzP0SfmJIyrULtEccFk0uapq+TSBo9VtVbCE0hsLro9Z
         6TJ2P83GdNGwPWEEBFqffGr2lN1qOMiyW8o46ZsEr+MdVSbwgIWoMW+sQ4exqOCKF9k0
         WmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RozdFg8UcjNGaMEUfY94uV2Q1ptXwQxOYUwNdKHWzQ=;
        b=p8cMOe0JZmpPg+/WrfjIDyTQ9C+ys+xg1PYUoTdfLHJLp6nyJlG8aIKZdWmzbH2y1p
         LeK5ufPrKWz9+5EXtT9GVuHodY0IEkCD+6Sdm5aZQ/NKNYnvHsIH0oNS85BRxsHAFQNG
         7IpqqXZsYdcdnGlOTkWtlkVj3Ya44vneIqCAwJACyKOxRAvh+OJgb/p1YjIB0ESfwS94
         AL75u+FiI1BR+f+rdq63UMGz5sgWYZZX2v2Z2qO9pKKjdagunZj0Gm9UvRGQX5XdBLKT
         anRMpT+FFEpv0gPnX3lLbRXZL8S/+GTyidzB12wttYp31marguL9m18V7/E8J0G03iOf
         9Btg==
X-Gm-Message-State: AO0yUKX02RSQJ5TCRdPWHFsF5fGbP60v6g4dQPcw+0xZeWGz0ZC8ucq8
        4+zFY7deslWZyidfRtngiLwumg==
X-Google-Smtp-Source: AK7set9jmvh+j4JyveYHT6/2X0EcNAwdK8aOAIJtzI8kddXy/qZK/hV40KXfjYqRZm5s7DJ2H2eGEA==
X-Received: by 2002:a05:6512:7b:b0:4dd:a053:3c0b with SMTP id i27-20020a056512007b00b004dda0533c0bmr992258lfo.42.1677149530231;
        Thu, 23 Feb 2023 02:52:10 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 11:52:01 +0100
Subject: [PATCH v3 5/7] drm/msm/a3xx: Implement .gpu_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v3-5-5f22163cd1df@linaro.org>
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
In-Reply-To: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=1452;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sAA92dCqoQlGesDQKUB68UAlcg2YIqQbh8UmjiEN524=;
 b=2jM+T/p9ilIYyJLFdFVnqDFZlEMAxUjw5IY/bXTDdO3ddLKvpMDcoDN5is+J8/ZT0+M8fbi/up0Z
 PVqxIs+gC4KVk5kRrpXOogK84F17HfLU9lulIvcI7CWczCEmjCw6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #ifc6410
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

