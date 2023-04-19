Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B46E7D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjDSOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjDSOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C755AC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r15so7684972wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915319; x=1684507319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcnExIV1IqNmb0Z5IkQ0hD4wokHSeyh+XnooedJBczc=;
        b=wE6YD9A+FYn6wOjrwQ7wUkuGlO2TbV0XvcQBxrLpJEpUiKGYmDeT5rHFG93t9xGEtt
         WMAkV9RYMgvKNyb+sTI41Qqn+DLI0EdI4gw5XvDCnIZDOLkrjbZHqUpXW+44UIJCmnDE
         obIYl+DE850tfLMmtqABwAXeCjE9Qao8gf7E+41hQmcR++4uXFlohv5Ci5SkPj/fFGZp
         b/HvhyPKYckHW77iqr8Yw1UJkh2IZpd5T76sRt8PoOKZhy9U+2v6RBc/1GKQiKeeVAwA
         9qXFk50pkvxMGI0+v5RbliE+giq7JkzqrbtCvXp1OC9ilK9R6CtGY27VkMvK4yfcKJ1S
         aTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915319; x=1684507319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcnExIV1IqNmb0Z5IkQ0hD4wokHSeyh+XnooedJBczc=;
        b=CDVbRnr4lr7iOaLgTpp/Q9PfpYm5TJETQVkZejDcfRPkV87p/1DgzF0VS7XxoCNSya
         fU6wTlCxkJ5HvvJyAtt56W/UZA0rivvSepsvzubrW9ZFxyoSj7loimI8Za5VjxRf96Xu
         Vc0qzPX9n9Y1uBOJa+9o+n0KTnbgU/OQkpBtWTYjWVw3GoDY/7hU9YZ8DBWo/zXWCpDi
         PJzML+FMiwuQaFFK8gIRzbvUa9yIR2FNMwEYpHJSaKLdbRGS9tM5kR2Ye12EAkA9/VrY
         NCa4jZ9wqRzIJ44RookumnoVPshMy5KhW3omPcGHVMDOaGgBx3azMKx2xHhUvOfJYazG
         ic7g==
X-Gm-Message-State: AAQBX9fPoU6IoWBQWljlvTAobc0I2ZS55gpb1odIF/i5mHSMqFzAsJ3S
        lOUVPtjvlxnOBvTo55yMWMhB
X-Google-Smtp-Source: AKy350Yii6qrh8MWxxQipuxjP1Qy+dnRkEO1AU19kqMcrB33h7+UVou4nFvyXNdYEA1cjvrLEjBTHg==
X-Received: by 2002:a05:600c:3793:b0:3f1:72e6:bf2 with SMTP id o19-20020a05600c379300b003f172e60bf2mr9084805wmr.19.1681915319472;
        Wed, 19 Apr 2023 07:41:59 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:41:59 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Wed, 19 Apr 2023 16:41:14 +0200
Subject: [PATCH 07/11] drm/msm/dpu: add sspp cursor blocks to msm8998 hw
 catalog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dpu-tweaks-v1-7-d1bac46db075@freebox.fr>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
In-Reply-To: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=ipqD9/zdMktG6jZ1bu4phPRN971JkBvc1JQ2BoirwDo=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2l9vG3IDNbhr+jhjy4oTIFGSW36RdaDadrV
 86j61QWHFOJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9pQAKCRBxA//ZuzQ0
 q8FhEACdwf8oEgYArrqf178JDo2Lso4yghQW7d+5aHzqw5icxRDKOQ+2nbEnyR6Y8hk2r0t+Y2F
 GhWBQpncaZL1tqDzAGnG2O8hxNG+J34LZlqaXdD51p+Ksmmd+Vyvji9TrYhsNdPLjRhLAjUV2gd
 NfHlUU06QerURwjrCJjiIVOlUzoUyWIMFQIakQtxpYB0LnBPS+WDASAYzT511FThnuf57ayLh9G
 Vs05zPmzHllDQ7TJpbF/UvoN/8yQh2k/1m+gs5EtDcia0HdcsZoZtLX9JtwA/Piw2hjOZ9eVDvA
 flcGI3183GRrfyeVKC+7AW9B8ttL6d7ou1c1wZPK4ZauMgvMUlW1PTRESP7UFLbPv0mWIIywgDu
 DwCd6WW+GsGUpOhCD3HGPRyIYjHTF53x2c6YQa09a/E/kW5CjpKaTjpNnENWTGEac2d0MoGJROT
 qOXZH75BWv2mNjQYAdoKNlt6vSlZy5+FKSZdfYrNKd5ZxS0rEnZLJCsjXAAJPGO+I/RhlpJ4X2o
 CK4ZEmPkOp2w8UKmBXGgo+/4UMQkQRfwYqfWvui3dVDFiobcS2PmTikKGXLz863AWN+bMNgRULl
 i1CsHl8O8INZjKgnDMQjKdAeWZcD8ihSTYqSxiaotCnkgUH5OLA9kHPD/pKRit4yWDNselmFtGk
 5n4VAVHk4hbV6Ww==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cursor sspp blocks can be used for cursor planes, enable them
on msm8998. The dma sspp blocks that were assigned to cursor planes can
now be used for overlay planes instead.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  8 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 34 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index b07e8a9941f79..7de393b0f91d7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -90,10 +90,14 @@ static const struct dpu_sspp_cfg msm8998_sspp[] = {
 		sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
 	SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1ac, DMA_MSM8998_MASK,
 		sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
-	SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1ac, DMA_CURSOR_MSM8998_MASK,
+	SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1ac, DMA_MSM8998_MASK,
 		sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA2),
-	SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x1ac, DMA_CURSOR_MSM8998_MASK,
+	SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x1ac, DMA_MSM8998_MASK,
 		sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA3),
+	SSPP_BLK("sspp_12", SSPP_CURSOR0, 0x34000, 0x1ac, DMA_CURSOR_MSM8998_MASK,
+		msm8998_cursor_sblk_0, 2, SSPP_TYPE_CURSOR, DPU_CLK_CTRL_CURSOR0),
+	SSPP_BLK("sspp_13", SSPP_CURSOR1, 0x36000, 0x1ac, DMA_CURSOR_MSM8998_MASK,
+		msm8998_cursor_sblk_1, 10, SSPP_TYPE_CURSOR, DPU_CLK_CTRL_CURSOR1),
 };
 
 static const struct dpu_lm_cfg msm8998_lm[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 8d5d782a43398..f34fa704936bc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -242,6 +242,22 @@ static const uint32_t wb2_formats[] = {
 	DRM_FORMAT_XBGR4444,
 };
 
+static const uint32_t cursor_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_BGRA4444,
+};
+
 /*************************************************************
  * SSPP sub blocks config
  *************************************************************/
@@ -300,6 +316,19 @@ static const uint32_t wb2_formats[] = {
 	.virt_num_formats = ARRAY_SIZE(plane_formats), \
 	}
 
+#define _CURSOR_SBLK(num) \
+	{ \
+	.maxdwnscale = SSPP_UNITY_SCALE, \
+	.maxupscale = SSPP_UNITY_SCALE, \
+	.smart_dma_priority = 0, \
+	.src_blk = {.name = STRCAT("sspp_src_", num), \
+		.id = DPU_SSPP_SRC, .base = 0x00, .len = 0x150,}, \
+	.format_list = cursor_formats, \
+	.num_formats = ARRAY_SIZE(cursor_formats), \
+	.virt_format_list = cursor_formats, \
+	.virt_num_formats = ARRAY_SIZE(cursor_formats), \
+	}
+
 static const struct dpu_sspp_sub_blks msm8998_vig_sblk_0 =
 				_VIG_SBLK("0", 0, DPU_SSPP_SCALER_QSEED3);
 static const struct dpu_sspp_sub_blks msm8998_vig_sblk_1 =
@@ -309,6 +338,11 @@ static const struct dpu_sspp_sub_blks msm8998_vig_sblk_2 =
 static const struct dpu_sspp_sub_blks msm8998_vig_sblk_3 =
 				_VIG_SBLK("3", 0, DPU_SSPP_SCALER_QSEED3);
 
+static const struct dpu_sspp_sub_blks msm8998_cursor_sblk_0 =
+				_CURSOR_SBLK("12");
+static const struct dpu_sspp_sub_blks msm8998_cursor_sblk_1 =
+				_CURSOR_SBLK("13");
+
 static const struct dpu_rotation_cfg dpu_rot_sc7280_cfg_v2 = {
 	.rot_maxheight = 1088,
 	.rot_num_formats = ARRAY_SIZE(rotation_v2_formats),

-- 
2.40.0

