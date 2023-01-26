Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9F67CFEA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAZPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjAZPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77379728F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y19so2160005edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ/SWB0Uw5t+tNKY8Z0cO7Uuu+g8h+UmzfpGrY5QuZM=;
        b=KMkAVEfAYo8ekcdVqIWy7mRDlsniGZcoWq7CCW0y3cjcDa5LkIva2KoCfYt5AAPGkM
         Y3bZMXEmMwO+i60h7guKeMHhawmlhddNYP4FwnuOlm9ahDthSCmceAwavIQhHJC3eDLn
         orRXDCZlG+0y5dZz7JMtgzCe7bE3+qBB0L+5PtUy0rDMgxZqnIPcZB8Kx6NMryAPeT4F
         Z0s8qLeMa1ji351+bJN9t+mNop/Z5kyiWlLbe+mF2KG0mtAvLsfWJWY1oGcX1kK1XouQ
         C5mN0wlszJ2vveKh1qnvyjW3IXSUYdtU2Xi++yjzsT7su8p6i/vD04S2uYkuZeNyIMa0
         2IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ/SWB0Uw5t+tNKY8Z0cO7Uuu+g8h+UmzfpGrY5QuZM=;
        b=g/uV2Er99B1wa3tl2veA8xwJIARur1JUE8EAepGT0FZZzNI9hhr+UT5nwcmMo73DzW
         nX4yXfoBFbB1pVg6Nd8b3mIb7dUJ7mPWLv20G4C0xZtJeueoMDgF/C+O3xAzOpLbosBR
         K2A8eKOxUOJs+8UUoVxkFlQ6xYGfl2xVmkNDChdzj6PxwZc1sz/BQUAlZGB0w7e6Qwv3
         D5Of5ncJLBOyAQlzzAmmGZBMdEuT74doOBuShYKO0xiuzF5eguUSoy9D5+keLwOqj2wR
         cTwamaVxNKD/oW/vWr5ZxCVtjqw2rsYMOgUr+HT1oys+/G6rRiTxJJtxeCEnZMGUCSvJ
         gL7g==
X-Gm-Message-State: AFqh2krYOo4+qCeyYxaHu6/L/ZSQedu6D6HdBvEN2k4XD9vhFkXZJHBs
        rJUQQdZDociQLeH/eNJIp1tjfg==
X-Google-Smtp-Source: AMrXdXv+v5eSwye6JxaP9a+PQmL9psoOKw/vH121uenJdn4msQrvOPlHrLsUEJxOPWWOMZE34AZ1JQ==
X-Received: by 2002:a05:6402:413:b0:498:b9ea:1894 with SMTP id q19-20020a056402041300b00498b9ea1894mr34147972edv.15.1674746263944;
        Thu, 26 Jan 2023 07:17:43 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:17:43 -0800 (PST)
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
        Ricardo Ribalda <ribalda@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Emma Anholt <emma@anholt.net>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] drm/msm/a6xx: Add A610 support
Date:   Thu, 26 Jan 2023 16:16:12 +0100
Message-Id: <20230126151618.225127-9-konrad.dybcio@linaro.org>
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

A610 is one of (if not the) lowest-tier SKUs in the A6XX family. It
features no GMU, as it's implemented solely on SoCs with SMD_RPM.
What's more interesting is that it does not feature a VDDGX line
either, being powered solely by VDDCX and has an unfortunate hardware
quirk that makes its reset line broken - after a couple of assert/
deassert cycles, it will hang for good and will not wake up again.

This GPU requires mesa changes for proper rendering, and lots of them
at that. The command streams are quite far away from any other A6XX
GPU and hence it needs special care. This patch was validated both
by running an (incomplete) downstream mesa with some hacks (frames
rendered correctly, though some instructions made the GPU hangcheck
which is expected - garbage in, garbage out) and by replaying RD
traces captured with the downstream KGSL driver - no crashes there,
ever.

Add support for this GPU on the kernel side, which comes down to
pretty simply adding A612 HWCG tables, altering a few values and
adding a special case for handling the reset line.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 95 ++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_device.c | 13 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  8 +-
 3 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 3c349e97b3a6..7a480705f407 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -254,6 +254,56 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	a6xx_flush(gpu, ring);
 }
 
+const struct adreno_reglist a612_hwcg[] = {
+	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
+	{REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000081},
+	{REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000f3cf},
+	{REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111},
+	{REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111},
+	{REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111},
+	{REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111},
+	{REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777},
+	{REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777},
+	{REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x77777777},
+	{REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00077777},
+	{REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01202222},
+	{REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220},
+	{REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040f00},
+	{REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x05522022},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555},
+	{REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011},
+	{REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044},
+	{REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222},
+	{REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222},
+	{REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x02222222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002},
+	{REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000},
+	{REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200},
+	{REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004},
+	{REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004},
+	{REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002},
+	{REG_A6XX_RBBM_ISDB_CNT, 0x00000182},
+	{REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000},
+	{REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
+	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
+	{},
+};
+
 /* For a615 family (a615, a616, a618 and a619) */
 const struct adreno_reglist a615_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_CNTL_SP0,  0x02222222},
@@ -604,6 +654,8 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 
 	if (adreno_is_a630(adreno_gpu))
 		clock_cntl_on = 0x8aa8aa02;
+	else if (adreno_is_a610(adreno_gpu))
+		clock_cntl_on = 0xaaa8aa82;
 	else
 		clock_cntl_on = 0x8aa8aa82;
 
@@ -798,6 +850,11 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 min_acc_len = 0;
 	u32 ubwc_mode = 0;
 
+	if (adreno_is_a610(adreno_gpu)) {
+		min_acc_len = 1;
+		ubwc_mode = 1;
+	}
+
 	/* a618 is using the hw default values */
 	if (adreno_is_a618(adreno_gpu))
 		return;
@@ -1047,13 +1104,13 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_set_hwcg(gpu, true);
 
 	/* VBIF/GBIF start*/
-	if (adreno_is_a640_family(adreno_gpu) ||
+	if (adreno_is_a610(adreno_gpu) ||
+	    adreno_is_a640_family(adreno_gpu) ||
 	    adreno_is_a650_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
 	} else {
 		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
@@ -1084,18 +1141,26 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
 	gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
 
-	if (adreno_is_a640_family(adreno_gpu) ||
-	    adreno_is_a650_family(adreno_gpu))
+	if (adreno_is_a640_family(adreno_gpu) || adreno_is_a650_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
-	else
+		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
+	} else if (adreno_is_a610(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x00800060);
+		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x40201b16);
+	} else {
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
-	gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
+		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
+	}
 
 	if (adreno_is_a660_family(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_CP_LPAC_PROG_FIFO_SIZE, 0x00000020);
 
 	/* Setting the mem pool size */
-	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
+	if (adreno_is_a610(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 48);
+		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_DBG_ADDR, 47);
+	} else
+		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
 
 	/* Setting the primFifo thresholds default values,
 	 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
@@ -1106,6 +1171,8 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
 	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
+	else if (adreno_is_a610(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
 	else
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00180000);
 
@@ -1121,8 +1188,10 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_set_ubwc_config(gpu);
 
 	/* Enable fault detection */
-	gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL,
-		(1 << 30) | 0x1fffff);
+	if (adreno_is_a610(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
+	else
+		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);
 
 	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, 1);
 
@@ -1356,6 +1425,14 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	/* Software-reset the GPU */
 	if (adreno_has_gmu_wrapper(adreno_gpu)) {
+		/* 11nm chips (i.e. A610-hosting ones) have HW issues with the reset line */
+		if (!adreno_is_a610(adreno_gpu)) {
+			gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, 1);
+			gpu_read(gpu, REG_A6XX_RBBM_SW_RESET_CMD);
+			udelay(100);
+			gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, 0);
+		}
+
 		if (adreno_is_a619_holi(adreno_gpu)) {
 			gpu_write(gpu, 0x18, GPR0_GBIF_HALT_REQUEST);
 			spin_until((gpu_read(gpu, REG_A6XX_RBBM_VBIF_GX_RESET_STATUS) &
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 71faeb3fd466..e8449be606b1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -253,6 +253,19 @@ static const struct adreno_info gpulist[] = {
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.init = a5xx_gpu_init,
 		.zapfw = "a540_zap.mdt",
+	}, {
+		.rev = ADRENO_REV(6, 1, 0, ANY_ID),
+		.revn = 610,
+		.name = "A610",
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+		},
+		.gmem = (SZ_128K + SZ_4K),
+		.inactive_period = 500,
+		.quirks = ADRENO_QUIRK_GMU_WRAPPER,
+		.init = a6xx_gpu_init,
+		.zapfw = "a610_zap.mdt",
+		.hwcg = a612_hwcg,
 	}, {
 		.rev = ADRENO_REV(6, 1, 8, ANY_ID),
 		.revn = 618,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 16241368c2e4..2dd3dad3122b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -56,7 +56,8 @@ struct adreno_reglist {
 	u32 value;
 };
 
-extern const struct adreno_reglist a615_hwcg[], a630_hwcg[], a640_hwcg[], a650_hwcg[], a660_hwcg[];
+extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_hwcg[], a650_hwcg[];
+extern const struct adreno_reglist a660_hwcg[];
 
 struct adreno_info {
 	struct adreno_rev rev;
@@ -242,6 +243,11 @@ static inline int adreno_is_a540(struct adreno_gpu *gpu)
 	return gpu->revn == 540;
 }
 
+static inline int adreno_is_a610(struct adreno_gpu *gpu)
+{
+	return gpu->revn == 610;
+}
+
 static inline int adreno_is_a618(struct adreno_gpu *gpu)
 {
 	return gpu->revn == 618;
-- 
2.39.1

