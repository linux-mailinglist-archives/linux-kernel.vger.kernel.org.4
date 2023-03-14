Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC76B993B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCNP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjCNP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:28:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E3D279BA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b10so16450414ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QBfkwBASk6EqehMpj5iBWVthwGOhEMOaMUH5eoHlaw=;
        b=UepBCxqmyQ8a7htSDlTFI0ShFtEB7diji/pbqGjwg56DIr/pGL1FMQG23Kn4gVFUIH
         NWU7NEQOg6QEPw+QBNKkfk0e3g7KdwuL54ChUUC95zetLCTFMuNkWeytTRsZmOoAlBPh
         6oKBWQ+Zrt2mvYnaj1zpDOe5mfV6hGiVgV8S4nFnuK92cLLCnctMeMoH5uimRkorSjJC
         hi7HBB16Btn0M0sTQJkP9rlv0qMBsA6gH2fdDc36OWvkMN9RwmYFYtyGhAjMCcaOXdv7
         Iu3w3ma+ue36QNvHTEAvVstExQCK4oYWWSW8+plHHOxbDvNQ+AjF0T3Vli78h9Ec6XHk
         l0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QBfkwBASk6EqehMpj5iBWVthwGOhEMOaMUH5eoHlaw=;
        b=YcthHZCWmY69JQr5ORb2YeWrXZ1x3IgqV2kSINH5DNdgUyGK9sXOr9evRbwr0blmj+
         ohrRz/CoRoHdlUuSt+aMLB843YwWF0Uq/CuJGQSCLIKlQG7gAOEfNMREt/xSDglL7CDU
         ykeaamMDYNOC0MRFYaEv+dLlJXTFEtSb1bl6wY/A8EAy08fPn7CTM6ubN38QrqyZ8lw8
         E9qq77XzqNja0MC61HyoyRXIu5FoMA1tIftv6oLTRCTMAYJVmSDDZUA2RRVvOcuSLrlU
         CsLbYsiSIhqu4w2kgsRd5c1zlHCBogYFP+tu0wjWyQmJiDLKsWut7M1wZ7Elyis5aOXU
         nB/A==
X-Gm-Message-State: AO0yUKX65fLN/74aEi5mu88Trku9JHMKETXwboF2D/R/o8DWnxPT7k8d
        Si/3Fo7Kq9RDecV0CZWM0zQFUg==
X-Google-Smtp-Source: AK7set9319x6pXFA2ZB5oQB5t6Vlb6uh1fRGtzfQAmcsGR0/P2fXfUFxvI6C2W5JvKGej6l20vdP9Q==
X-Received: by 2002:a2e:909a:0:b0:295:a829:1c57 with SMTP id l26-20020a2e909a000000b00295a8291c57mr12082944ljg.20.1678807731546;
        Tue, 14 Mar 2023 08:28:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 27-20020a2e165b000000b002986a977bf2sm491529ljw.90.2023.03.14.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:28:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 16:28:39 +0100
Subject: [PATCH v4 08/14] drm/msm/a6xx: Add support for A619_holi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v4-8-e987eb79d03f@linaro.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
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
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678807716; l=4940;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RIb1PwuaJxl26QOFy9hE9BbhqyB0PIh+V+WoOWu9KIo=;
 b=h7jUht1chOrWGuBBXbU8DzuW6yjeui4Q0sDTGbH6GAeYwsfIT23zHYJDwYLDz3LenakP9X/KTBJ5
 izASb5SjDlR6KxM03YuJv1h7kgCC7iusu/S20201Ob3fWj/jky89
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A619_holi is a GMU-less variant of the already-supported A619 GPU.
It's present on at least SM4350 (holi) and SM6375 (blair). No mesa
changes are required. Add the required kernel-side support for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 42 ++++++++++++++++++++++++++-------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 ++++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 70e9bd21ba3b..1c0e5e1df89c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -614,14 +614,16 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 		return;
 
 	/* Disable SP clock before programming HWCG registers */
-	if (!adreno_has_gmu_wrapper(adreno_gpu))
+	if (!adreno_has_gmu_wrapper(adreno_gpu) ||
+	     adreno_is_a619_holi(adreno_gpu))
 		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 1, 0);
 
 	for (i = 0; (reg = &adreno_gpu->info->hwcg[i], reg->offset); i++)
 		gpu_write(gpu, reg->offset, state ? reg->value : 0);
 
 	/* Enable SP clock */
-	if (!adreno_has_gmu_wrapper(adreno_gpu))
+	if (!adreno_has_gmu_wrapper(adreno_gpu) ||
+	     adreno_is_a619_holi(adreno_gpu))
 		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 0, 1);
 
 	gpu_write(gpu, REG_A6XX_RBBM_CLOCK_CNTL, state ? clock_cntl_on : 0);
@@ -814,6 +816,9 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	if (adreno_is_a618(adreno_gpu))
 		return;
 
+	if (adreno_is_a619_holi(gpu))
+		hbb_lo = 0;
+
 	if (adreno_is_a640_family(adreno_gpu))
 		amsbc = 1;
 
@@ -1015,7 +1020,12 @@ static int hw_init(struct msm_gpu *gpu)
 	}
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
-	if (a6xx_has_gbif(adreno_gpu)) {
+	if (adreno_is_a619_holi(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_write(gpu, 0x18, 0);
+		/* Let's make extra sure that the GPU can access the memory.. */
+		mb();
+	} else if (a6xx_has_gbif(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
 		/* Let's make extra sure that the GPU can access the memory.. */
@@ -1024,6 +1034,9 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		a6xx_sptprac_enable(gmu);
+
 	/*
 	 * Disable the trusted memory range - we don't actually supported secure
 	 * memory rendering at this point in time and we don't want to block off
@@ -1301,7 +1314,8 @@ static void a6xx_dump(struct msm_gpu *gpu)
 #define GBIF_CLIENT_HALT_MASK	BIT(0)
 #define GBIF_ARB_HALT_MASK	BIT(1)
 #define VBIF_RESET_ACK_TIMEOUT	100
-#define VBIF_RESET_ACK_MASK	0x00f0
+#define VBIF_RESET_ACK_MASK	0xF0
+#define GPR0_GBIF_HALT_REQUEST	0x1E0
 
 static void a6xx_recover(struct msm_gpu *gpu)
 {
@@ -1358,10 +1372,16 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	/* Software-reset the GPU */
 	if (adreno_has_gmu_wrapper(adreno_gpu)) {
-		/* Halt the GX side of GBIF */
-		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, GBIF_GX_HALT_MASK);
-		spin_until(gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT_ACK) &
-			   GBIF_GX_HALT_MASK);
+		if (adreno_is_a619_holi(adreno_gpu)) {
+			gpu_write(gpu, 0x18, GPR0_GBIF_HALT_REQUEST);
+			spin_until((gpu_read(gpu, REG_A6XX_RBBM_VBIF_GX_RESET_STATUS) &
+				   (VBIF_RESET_ACK_MASK)) == VBIF_RESET_ACK_MASK);
+		} else {
+			/* Halt the GX side of GBIF */
+			gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, GBIF_GX_HALT_MASK);
+			spin_until(gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT_ACK) &
+				   GBIF_GX_HALT_MASK);
+		}
 
 		/* Halt new client requests on GBIF */
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
@@ -1783,6 +1803,9 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		goto err;
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		a6xx_sptprac_enable(gmu);
+
 err:
 	mutex_unlock(&a6xx_gpu->gmu.lock);
 
@@ -1837,6 +1860,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 
 	mutex_lock(&a6xx_gpu->gmu.lock);
 
+	if (adreno_is_a619_holi(adreno_gpu))
+		a6xx_sptprac_disable(gmu);
+
 	clk_disable_unprepare(gpu->ebi1_clk);
 
 	clk_bulk_disable_unprepare(gpu->nr_clocks, gpu->grp_clks);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 2c0f0ef094cb..92ece15ec7d8 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -252,6 +252,11 @@ static inline int adreno_is_a619(struct adreno_gpu *gpu)
 	return gpu->revn == 619;
 }
 
+static inline int adreno_is_a619_holi(struct adreno_gpu *gpu)
+{
+	return adreno_is_a619(gpu) && adreno_has_gmu_wrapper(gpu);
+}
+
 static inline int adreno_is_a630(struct adreno_gpu *gpu)
 {
 	return gpu->revn == 630;

-- 
2.39.2

