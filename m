Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4F7419BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjF1Ugq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjF1Ufo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5922102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f122ff663eso84089e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687984540; x=1690576540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm3KamCt+ZMllCx3Nhj0qStzSxRN4w+L3iI1hHSLU/c=;
        b=ftSpIYYyblu+haUVVwWDEfGcDLb5SYqgaQGKOnzPeKrYITU3HSwm5GOmggs7cReLcA
         IxeW1jpzYxr7NWYhrIPKXP+dZoW3N8RrDLL3DJxwoz5Sb7puEr+Dv9GjdppS5VGFmC9K
         bozfItD5jP0zc14Dss8fvsuuO+qnVyQONzbVNG621/9VGSwQTKUVm0uX6af0TAaGt0IJ
         tzFt+hCDVxgW5WYJxLp8h5BzZmEbrO//Y/cHO61ETCe1Bf74Z0DIMESvcVfGuS2jlMHm
         U/hdJ4v2dgxF2X6lHiUaDuRGUeo6CqyL4CA5I+RGdASptFFa+A3bzxX71+7kUtyCNiDN
         Twcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984540; x=1690576540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm3KamCt+ZMllCx3Nhj0qStzSxRN4w+L3iI1hHSLU/c=;
        b=A4wvIoS6BPkZJQO65fB2BhJcxI4vrIeEvdMdIzXgyHxiuktUTFBX0Uyx87c14bT98b
         6Ytazr4xI/Y2tHgby4lcEvlr2fuv82gBhqlT2fjB0zoSJuhhdWt8G5vH3RliJxFyp+vg
         CPmBBHb06W5sSAhVqYg0xXr/wS+Q54bfAO7/+gp9cflKB0gICcqwYYC2qsUdVkv42ziK
         c+HF5tMbgSjRg0BEthqn2mvE5dpGGsD7XOpAVWvu9sf/L/n6oj4Va0eZWb4u9qxzsJDX
         ZprBgUjf4vxCvCpkh3+lzsxm8Gv5BQynTTpBb+QmZyqNg+sfQykn2R7kUWql0PHG6paZ
         qNyQ==
X-Gm-Message-State: AC+VfDw3Ib/344ZVGP8hV0DyYJkgrjzpIciX8MvMt1BlRKZmWvspZSFY
        zEu+D35PUjAxW8koQsNpR4sx2g==
X-Google-Smtp-Source: ACHHUZ7vpxQXc9n8p7qvzxt+uaCLzOIG2QonuAgMInXJPS2Ng61tTprQ2JDjqWIKLvSAtLr9Q6h+/A==
X-Received: by 2002:a05:6512:eaa:b0:4fb:7cea:882a with SMTP id bi42-20020a0565120eaa00b004fb7cea882amr6703712lfb.3.1687984540271;
        Wed, 28 Jun 2023 13:35:40 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512015900b004fb86c89fa1sm753363lfo.135.2023.06.28.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:35:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 22:35:10 +0200
Subject: [PATCH 10/14] drm/msm/a6xx: Mostly implement A7xx gpu_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v1-10-a7f4496e0c12@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687984524; l=6928;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JfANdNqbXqvpk3LICZmqHJzUXQO4R9kWuTFjDFe+5sk=;
 b=fOfjDxb/+o9s8svWZ6xC2Mw8u+laHAhP0rgjA/pC9EY4AwhIf+6xbdTSy3KjUgVmVF1f1Nmpw
 kmuRbpyngNvC9vMiaSWGG6yDisALj/VCZS7jJ/+t31zTwNMyckn+YMz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the necessary alternations to mostly support state dumping on
A7xx. Newer GPUs will probably require more changes here. Crashdumper
and debugbus remain untested.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 52 +++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 61 ++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 4e5d650578c6..18be2d3bde09 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -948,6 +948,18 @@ static u32 a6xx_get_cp_roq_size(struct msm_gpu *gpu)
 	return gpu_read(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2) >> 14;
 }
 
+static u32 a7xx_get_cp_roq_size(struct msm_gpu *gpu)
+{
+	/*
+	 * The value at CP_ROQ_THRESHOLDS_2[20:31] is in 4dword units.
+	 * That register however is not directly accessible from APSS on A7xx.
+	 * Program the SQE_UCODE_DBG_ADDR with offset=0x70d3 and read the value.
+	 */
+	gpu_write(gpu, REG_A6XX_CP_SQE_UCODE_DBG_ADDR, 0x70d3);
+
+	return 4 * (gpu_read(gpu, REG_A6XX_CP_SQE_UCODE_DBG_DATA) >> 20);
+}
+
 /* Read a block of data from an indexed register pair */
 static void a6xx_get_indexed_regs(struct msm_gpu *gpu,
 		struct a6xx_gpu_state *a6xx_state,
@@ -1019,8 +1031,40 @@ static void a6xx_get_indexed_registers(struct msm_gpu *gpu,
 
 	/* Restore the size in the hardware */
 	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, mempool_size);
+}
+
+static void a7xx_get_indexed_registers(struct msm_gpu *gpu,
+		struct a6xx_gpu_state *a6xx_state)
+{
+	int i, indexed_count, mempool_count;
+
+	indexed_count = ARRAY_SIZE(a7xx_indexed_reglist);
+	mempool_count = ARRAY_SIZE(a7xx_cp_bv_mempool_indexed);
 
-	a6xx_state->nr_indexed_regs = count;
+	a6xx_state->indexed_regs = state_kcalloc(a6xx_state,
+					indexed_count + mempool_count,
+					sizeof(*a6xx_state->indexed_regs));
+	if (!a6xx_state->indexed_regs)
+		return;
+
+	a6xx_state->nr_indexed_regs = indexed_count + mempool_count;
+
+	/* First read the common regs */
+	for (i = 0; i < indexed_count; i++)
+		a6xx_get_indexed_regs(gpu, a6xx_state, &a7xx_indexed_reglist[i],
+			&a6xx_state->indexed_regs[i]);
+
+	gpu_rmw(gpu, REG_A6XX_CP_CHICKEN_DBG, 0, BIT(2));
+	gpu_rmw(gpu, REG_A7XX_CP_BV_CHICKEN_DBG, 0, BIT(2));
+
+	/* Get the contents of the CP_BV mempool */
+	for (i = 0; i < mempool_count; i++)
+		a6xx_get_indexed_regs(gpu, a6xx_state, a7xx_cp_bv_mempool_indexed,
+			&a6xx_state->indexed_regs[indexed_count - 1 + i]);
+
+	gpu_rmw(gpu, REG_A6XX_CP_CHICKEN_DBG, BIT(2), 0);
+	gpu_rmw(gpu, REG_A7XX_CP_BV_CHICKEN_DBG, BIT(2), 0);
+	return;
 }
 
 struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
@@ -1056,6 +1100,12 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 		return &a6xx_state->base;
 
 	/* Get the banks of indexed registers */
+	if (adreno_is_a7xx(adreno_gpu)) {
+		a7xx_get_indexed_registers(gpu, a6xx_state);
+		/* Further codeflow is untested on A7xx. */
+		return &a6xx_state->base;
+	}
+
 	a6xx_get_indexed_registers(gpu, a6xx_state);
 
 	/*
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 790f55e24533..12c13226819a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -338,6 +338,28 @@ static const struct a6xx_registers a6xx_vbif_reglist =
 static const struct a6xx_registers a6xx_gbif_reglist =
 			REGS(a6xx_gbif_registers, 0, 0);
 
+static const u32 a7xx_ahb_registers[] = {
+	/* RBBM_STATUS */
+	0x210, 0x210,
+	/* RBBM_STATUS2-3 */
+	0x212, 0x213,
+};
+
+static const u32 a7xx_gbif_registers[] = {
+	0x3c00, 0x3c0b,
+	0x3c40, 0x3c42,
+	0x3c45, 0x3c47,
+	0x3c49, 0x3c4a,
+	0x3cc0, 0x3cd1,
+};
+
+static const struct a6xx_registers a7xx_ahb_reglist[] = {
+	REGS(a7xx_ahb_registers, 0, 0),
+};
+
+static const struct a6xx_registers a7xx_gbif_reglist =
+	REGS(a7xx_gbif_registers, 0, 0);
+
 static const u32 a6xx_gmu_gx_registers[] = {
 	/* GMU GX */
 	0x0000, 0x0000, 0x0010, 0x0013, 0x0016, 0x0016, 0x0018, 0x001b,
@@ -384,14 +406,17 @@ static const struct a6xx_registers a6xx_gmu_reglist[] = {
 };
 
 static u32 a6xx_get_cp_roq_size(struct msm_gpu *gpu);
+static u32 a7xx_get_cp_roq_size(struct msm_gpu *gpu);
 
-static struct a6xx_indexed_registers {
+struct a6xx_indexed_registers {
 	const char *name;
 	u32 addr;
 	u32 data;
 	u32 count;
 	u32 (*count_fn)(struct msm_gpu *gpu);
-} a6xx_indexed_reglist[] = {
+};
+
+static struct a6xx_indexed_registers a6xx_indexed_reglist[] = {
 	{ "CP_SQE_STAT", REG_A6XX_CP_SQE_STAT_ADDR,
 		REG_A6XX_CP_SQE_STAT_DATA, 0x33, NULL },
 	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
@@ -402,11 +427,43 @@ static struct a6xx_indexed_registers {
 		REG_A6XX_CP_ROQ_DBG_DATA, 0, a6xx_get_cp_roq_size},
 };
 
+static struct a6xx_indexed_registers a7xx_indexed_reglist[] = {
+	{ "CP_SQE_STAT", REG_A6XX_CP_SQE_STAT_ADDR,
+		REG_A6XX_CP_SQE_STAT_DATA, 0x33, NULL },
+	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
+		REG_A6XX_CP_DRAW_STATE_DATA, 0x100, NULL },
+	{ "CP_UCODE_DBG_DATA", REG_A6XX_CP_SQE_UCODE_DBG_ADDR,
+		REG_A6XX_CP_SQE_UCODE_DBG_DATA, 0x8000, NULL },
+	{ "CP_BV_SQE_STAT_ADDR", REG_A7XX_CP_BV_SQE_STAT_ADDR,
+		REG_A7XX_CP_BV_SQE_STAT_DATA, 0x33, NULL },
+	{ "CP_BV_DRAW_STATE_ADDR", REG_A7XX_CP_BV_DRAW_STATE_ADDR,
+		REG_A7XX_CP_BV_DRAW_STATE_DATA, 0x100, NULL },
+	{ "CP_BV_SQE_UCODE_DBG_ADDR", REG_A7XX_CP_BV_SQE_UCODE_DBG_ADDR,
+		REG_A7XX_CP_BV_SQE_UCODE_DBG_DATA, 0x8000, NULL },
+	{ "CP_SQE_AC_STAT_ADDR", REG_A7XX_CP_SQE_AC_STAT_ADDR,
+		REG_A7XX_CP_SQE_AC_STAT_DATA, 0x33, NULL },
+	{ "CP_LPAC_DRAW_STATE_ADDR", REG_A7XX_CP_LPAC_DRAW_STATE_ADDR,
+		REG_A7XX_CP_LPAC_DRAW_STATE_DATA, 0x100, NULL },
+	{ "CP_SQE_AC_UCODE_DBG_ADDR", REG_A7XX_CP_SQE_AC_UCODE_DBG_ADDR,
+		REG_A7XX_CP_SQE_AC_UCODE_DBG_DATA, 0x8000, NULL },
+	{ "CP_LPAC_FIFO_DBG_ADDR", REG_A7XX_CP_LPAC_FIFO_DBG_ADDR,
+		REG_A7XX_CP_LPAC_FIFO_DBG_DATA, 0x40, NULL },
+	{ "CP_ROQ", REG_A6XX_CP_ROQ_DBG_ADDR,
+		REG_A6XX_CP_ROQ_DBG_DATA, 0, a7xx_get_cp_roq_size },
+};
+
 static struct a6xx_indexed_registers a6xx_cp_mempool_indexed = {
 	"CP_MEMPOOL", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
 		REG_A6XX_CP_MEM_POOL_DBG_DATA, 0x2060, NULL,
 };
 
+static struct a6xx_indexed_registers a7xx_cp_bv_mempool_indexed[] = {
+	{ "CP_MEMPOOL", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
+		REG_A6XX_CP_MEM_POOL_DBG_DATA, 0x2100, NULL },
+	{ "CP_BV_MEMPOOL", REG_A7XX_CP_BV_MEM_POOL_DBG_ADDR,
+		REG_A7XX_CP_BV_MEM_POOL_DBG_DATA, 0x2100, NULL },
+};
+
 #define DEBUGBUS(_id, _count) { .id = _id, .name = #_id, .count = _count }
 
 static const struct a6xx_debugbus_block {

-- 
2.41.0

