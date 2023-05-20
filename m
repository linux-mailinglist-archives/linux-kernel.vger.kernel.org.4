Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CEC70A807
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjETMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjETMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:20:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711CCE6E
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:20:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3a166f8e9so2250929e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684585202; x=1687177202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xX5NNwgRWpbIyQzksfucv5stjdGXkcjknwzUIBRmfg=;
        b=uVELfZLJXKBUz880nMVVIVD/RdTGjdq7+wKB79u8V6aQ4fPp5OyE5gpA1wFc1Q8i/S
         gjzSCEtDJJmzIf2XDZKjK6OXdfDHFM5t4/tBw/5IpYkQkrzPsD4gCdGxJ4whdmOnsKZq
         33cZpu2MPOZSGHb8PpLPt/8xqPgEnJZijOZarE1+SZ51zC8CJE6EwYjbIj6GoH5hXht4
         IFuJR0mV9EdaZ4O4wOdwV+YqzZNpBV3NgmSewENipBifpocet5pU+NF29WHUlRk7b5mV
         RZ73X3Uw+rkvphMqKgv4rmYCEQSmenaDEh8pJj1TnTUfvfihqA2Fsf4bo+JrVRoYvneX
         eJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585202; x=1687177202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xX5NNwgRWpbIyQzksfucv5stjdGXkcjknwzUIBRmfg=;
        b=cpN9ymby/uLcz00eF0T92Ng2x0VJN87lIbVIHlUujHVWTkQ9No/9scWyPfW1sN9hZS
         US5ZbJ6criXtwB3smvc39OLeNkeKHjnZ3vg5sMmXeY/0lUpJw9mIu8qVVaXVQAKGVo5v
         YhI/1dz77MPf2/gtPwUd7dq5U/FIAAO3QXxnNDtoI2rl7N6Zc6iNG248f4YFxpsXyPEM
         Y2q4htX8+2hzd7dkAg6JGXg/NNoK/k/WUVaBTwcc6Iwj7nY7ai833by6hyi6GqBjhCcn
         t5+wwHwAzEGZhSbniTkDbeFDUaGw8u90EmVS2P/W3B9d3zm6BrshPyP558Q7hSSV1XHz
         K8Yw==
X-Gm-Message-State: AC+VfDztvtPsEKf+dU9TeLMzzSIWaoqvTtnAKjqeAW+8eVccbDvxguZu
        edMran0Sp2v4FHP+yps9M3tbpg==
X-Google-Smtp-Source: ACHHUZ4JncePd2ms0BiwKHDgbz8eNScrQIfaoUkZTLVZe9SaaJKX/QMFEl1kZMDlsB/+vzcoK8z71w==
X-Received: by 2002:ac2:5285:0:b0:4ac:b7bf:697a with SMTP id q5-20020ac25285000000b004acb7bf697amr2025347lfm.4.1684585201898;
        Sat, 20 May 2023 05:20:01 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y6-20020ac24466000000b004f37bd02a89sm244766lfl.287.2023.05.20.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:20:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 20 May 2023 14:19:49 +0200
Subject: [PATCH v7 09/18] drm/msm/a6xx: Extend and explain UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v7-9-ecc7aab83556@linaro.org>
References: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
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
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684585186; l=3025;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nJDRWtUki4jmsfB34feuvhwzM2ZS76IBIVVsPiHM+h4=;
 b=SnBS4X5cB+bIh7g9lIOPdHwSLdkv4Wq3ymO0C5zjVoU8+stgPjvUI755uLlqF4LVCd+U84D2Z
 QZgKS4cu4WVCCScSOMwwYLSXY1cwmEvjWY+8MNLu7kfaOLj0U5o+aNJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename lower_bit to hbb_lo and explain what it signifies.
Add explanations (wherever possible to other tunables).

Port setting min_access_length, ubwc_mode and hbb_hi from downstream.

Reviewed-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 39 +++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index dfde5fb65eed..58bf405b85d8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -786,10 +786,25 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	u32 lower_bit = 2;
-	u32 amsbc = 0;
+	/* Unknown, introduced with A650 family, related to UBWC mode/ver 4 */
 	u32 rgb565_predicator = 0;
+	/* Unknown, introduced with A650 family */
 	u32 uavflagprd_inv = 0;
+	/* Whether the minimum access length is 64 bits */
+	u32 min_acc_len = 0;
+	/* Entirely magic, per-GPU-gen value */
+	u32 ubwc_mode = 0;
+	/*
+	 * The Highest Bank Bit value represents the bit of the highest DDR bank.
+	 * We then subtract 13 from it (13 is the minimum value allowed by hw) and
+	 * write the lowest two bits of the remaining value as hbb_lo and the
+	 * one above it as hbb_hi to the hardware. This should ideally use DRAM
+	 * type detection.
+	 */
+	u32 hbb_hi = 0;
+	u32 hbb_lo = 2;
+	/* Unknown, introduced with A640/680 */
+	u32 amsbc = 0;
 
 	/* a618 is using the hw default values */
 	if (adreno_is_a618(adreno_gpu))
@@ -800,25 +815,31 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 
 	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
-		lower_bit = 3;
+		hbb_lo = 3;
 		amsbc = 1;
 		rgb565_predicator = 1;
 		uavflagprd_inv = 2;
 	}
 
 	if (adreno_is_7c3(adreno_gpu)) {
-		lower_bit = 1;
+		hbb_lo = 1;
 		amsbc = 1;
 		rgb565_predicator = 1;
 		uavflagprd_inv = 2;
 	}
 
 	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
-		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
-	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
-	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
-		uavflagprd_inv << 4 | lower_bit << 1);
-	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
+		  rgb565_predicator << 11 | hbb_hi << 10 | amsbc << 4 |
+		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
+
+	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, hbb_hi << 4 |
+		  min_acc_len << 3 | hbb_lo << 1 | ubwc_mode);
+
+	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, hbb_hi << 10 |
+		  uavflagprd_inv << 4 | min_acc_len << 3 |
+		  hbb_lo << 1 | ubwc_mode);
+
+	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, min_acc_len << 23 | hbb_lo << 21);
 }
 
 static int a6xx_cp_init(struct msm_gpu *gpu)

-- 
2.40.1

