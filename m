Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E766A06AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjBWKw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjBWKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E15A3AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s20so12983979lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c856FNZ6Lhd5u8jT462zPqnplUQDu/X42aKd4/VDH9g=;
        b=i+SHoYDu2CxmzFsvpNyj8FuuX25oBODVO7YQBk4ALkNydlbwUNuiWSn2f2CSEkMM20
         GYCDhYxFm4yDObXLeDN+CcKB9KjYhBpH+xjEp6XznKwW4U27HjLX/pBjjn1nzxBktyQi
         8IDlkKcRwCSXCCFY6KgyEdg/VjEiof8Z57j5fM4Lgpd64qOljDmAfxGWFGBJWnvEBOCd
         nHds+xKzZaZ+Mjcdiqq8R/4HwuI692uDlbrLrTvC8/XXusCjda9ZvNhgWFj/Di3PUJkX
         hSIQD1VQMQgsa8z8Gtwddtgfd3JGanEvWAzeqgdjycAY9zP7YFslnhCzjOZp6R22alQ9
         JCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c856FNZ6Lhd5u8jT462zPqnplUQDu/X42aKd4/VDH9g=;
        b=l3s/KAzRZstlndbBBDd/iwMBxkae/zpwQXTOEXr+Vc5iNF4jYI1Q+aZhkZIc6gB7lA
         hDPsWP7r03YD8dxsUoAxWpSrytZX1TdvLDbEreNo2vr/ETuz0XXY22aavDVZJ9Yrm02I
         kPuh7ydfy154PrvfwCXJrYeBT9oO2hQ+s/M/SF13DFzVNjAp5R/lE8NVDqMARzwfH8c2
         gCuow09ymEeDSqD+CvhHNU+s+7D+OA3b2wakL7h9u1pB4euygqtCl1TEANQKeccM89jx
         CZUUxMWCxm5rpehrP+1Zo5vt3p7sfseAMSqaSnZQJQkE82nfw691AWFniwDRooGGIp38
         6DQg==
X-Gm-Message-State: AO0yUKXV+gqFTLg/tRD557kBsuyyvD3BUyB2MTzdpomXExegPAYlp7ip
        V5dzdn8jgdS0F6PkTr+BzUuHSg==
X-Google-Smtp-Source: AK7set/sTdt05dvTUk/w0gYWf5Ab2lIvKNdwWjWwyCUK/HTWL/PBbhJP5beUWqFITY/p4Bsv6omTKQ==
X-Received: by 2002:ac2:43b4:0:b0:4d4:d7fb:d13 with SMTP id t20-20020ac243b4000000b004d4d7fb0d13mr3426578lfl.35.1677149528877;
        Thu, 23 Feb 2023 02:52:08 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:08 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 11:52:00 +0100
Subject: [PATCH v3 4/7] drm/msm/a2xx: Implement .gpu_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v3-4-5f22163cd1df@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=2182;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=M4GtniFH7Z74oP+C1wfVcdO+1YLmUE+S93nPkBb/ZUE=;
 b=A2D3TmwvTtxWv0uaGt4JkpWCn10VLe5vtr+8DwgiZJRVaOxktLKqoQFk0HZPITd+ExjXUz1QU95S
 18RI7cwQD1ckEytf8zZPcel2UNNBKTsg0CC4mdBmGnGNEy0o5Nak
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

Implement gpu_busy based on the downstream msm-3.4 code [1]. This
allows us to use devfreq on this old old old hardware!

[1] https://github.com/LineageOS/android_kernel_sony_apq8064/blob/lineage-16.0/drivers/gpu/msm/adreno_a2xx.c#L1975

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index c67089a7ebc1..104bdf28cdaf 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -481,6 +481,31 @@ a2xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
 	return aspace;
 }
 
+/* While the precise size of this field is unknown, it holds at least these three values.. */
+static u64 a2xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
+{
+	u64 busy_cycles;
+
+	/* Freeze the counter */
+	gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_FREEZE);
+
+	busy_cycles = gpu_read64(gpu, REG_A2XX_RBBM_PERFCOUNTER1_LO);
+
+	/* Reset the counter */
+	gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_RESET);
+
+	/* Re-enable the performance monitors */
+	gpu_rmw(gpu, REG_A2XX_RBBM_PM_OVERRIDE2,
+		A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE,
+		A2XX_RBBM_PM_OVERRIDE2_DEBUG_PERF_SCLK_PM_OVERRIDE);
+	gpu_write(gpu, REG_A2XX_RBBM_PERFCOUNTER1_SELECT, 1);
+	gpu_write(gpu, REG_A2XX_CP_PERFMON_CNTL, PERF_STATE_ENABLE);
+
+	*out_sample_rate = clk_get_rate(gpu->core_clk);
+
+	return busy_cycles;
+}
+
 static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
@@ -502,6 +527,7 @@ static const struct adreno_gpu_funcs funcs = {
 #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
 		.show = adreno_show,
 #endif
+		.gpu_busy = a2xx_gpu_busy,
 		.gpu_state_get = a2xx_gpu_state_get,
 		.gpu_state_put = adreno_gpu_state_put,
 		.create_address_space = a2xx_create_address_space,

-- 
2.39.2

