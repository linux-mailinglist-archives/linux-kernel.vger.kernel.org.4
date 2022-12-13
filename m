Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328B64AC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiLMAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiLMAYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:24:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50860F1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so2278942lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEIVdXDizl5GA8yUFDs8adYCHSjfLGoxScc9uTeNRRM=;
        b=OWqhQScustkMzjXFVt1cNe5DYkL14IYi+Rdz8Skrqo+RWKIyba1oepLqNaDTen2AQu
         cumnEwn/8PwtoHJFJrOUV+y5iRerymeZpB41CK5NsLALYjFRIrnIK3xjBfYvFq4FtPLv
         nR2+oV4oLbIySyy2BQh88feryeSpcMkQFXWRrJMGh23p+Vxp72TK1gHc1Xn1tSqw+WBZ
         NX2EhBKeq1NYa212WqZYh4nA+90M1oJXwSn6Wz4TVj3HKID+X/IvcbrXOuzaQIbkYrcs
         QbBF22P+qHGZISj+cg0cEu9C/iM0NJIQkUu0GuuRRcNff/u18zYZ8gy17M4ZYxZXpzoA
         xrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEIVdXDizl5GA8yUFDs8adYCHSjfLGoxScc9uTeNRRM=;
        b=FuJZM1dG39kJW/7uHtfWuYSEwCUWaQufPiV7nP9uAA4C50UknTFP7pMZnS393s+5nA
         kSbkuZmq4wF92A1piixQgXQf5m692J9gBjOe7NVsFBs8afps6vekKualJvAhZNYGZ8el
         Mymoitpcf/SeSR6+GLCCKnAga5EN4y13xEhRj9Bf988KwbYJb5uvmVkvq/fM8GjFA9YX
         bF81OHb9sMcCvX7Mndmr/0ihhZ7v+y2/HeQHNEjDw3prRAmTd2IWDZNVohsT01d5NaDP
         XL/fdFetWYNnWeZJlVMZWCHYIFzkz0Wkcel29FIDhxpbSbTPIS6IiSZj3f6TLOR98kCF
         kHdA==
X-Gm-Message-State: ANoB5plgEwnICubsuHLANi3aBCxSpFA49Gu6ccXfziPBTK9YhXCpu8lw
        JuWQGnQGhKNmjwtnEl056F7Y0w==
X-Google-Smtp-Source: AA0mqf5PxuEyT4388zQxFFOtql5DEIuyNV6rnOcvyNG+J41twRJyW7N0W6uU1rrt9dWlS69t0iQB/Q==
X-Received: by 2002:a05:6512:7b:b0:4a4:68b9:66f1 with SMTP id i27-20020a056512007b00b004a468b966f1mr3805731lfo.60.1670891075461;
        Mon, 12 Dec 2022 16:24:35 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24257000000b004978e51b691sm137352lfl.266.2022.12.12.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:24:35 -0800 (PST)
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
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drm/msm/a6xx: Add support for A650 speed binning
Date:   Tue, 13 Dec 2022 01:24:20 +0100
Message-Id: <20221213002423.259039-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213002423.259039-1-konrad.dybcio@linaro.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
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

Add support for matching QFPROM fuse values to get the correct speed bin
on A650 (SM8250) GPUs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 2c1630f0c04c..f139ec57c32d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1887,6 +1887,20 @@ static u32 a640_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
+static u32 a650_get_speed_bin(u32 fuse)
+{
+	if (fuse == 0)
+		return 0;
+	else if (fuse == 1)
+		return 1;
+	else if (fuse == 2)
+		return 2;
+	else if (fuse == 3)
+		return 3;
+
+	return UINT_MAX;
+}
+
 static u32 adreno_7c3_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -1915,6 +1929,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
 		val = a640_get_speed_bin(fuse);
 
+	if (adreno_cmp_rev(ADRENO_REV(6, 5, 0, ANY_ID), rev))
+		val = a650_get_speed_bin(fuse);
+
 	if (val == UINT_MAX) {
 		DRM_DEV_ERROR(dev,
 			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
-- 
2.39.0

