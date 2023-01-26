Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027A067CFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjAZPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAZPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:19:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CBB30B22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y19so2161022edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOXpo53+tk8MxMiyhFPMYbZRMhCDM1W9O7T9XaDKXE4=;
        b=sSfHyvUWR/wNGn0jDIL/ZvXJP4ucmis+dzeLTZZbj7iiGZuZ79AjayhkYXXfv9GQZ+
         EDCEaH/kMKgipyTy/CGQVglQxe1+eHwREx21ze+aftNP5Mvs7lgH1nOZZTq/1WMHqEQU
         zDEwA/3Gzl/NzWPE1Cx3jHoiM7N0uDw5VL0l/WXCKUu/T1mhFoD4ds8qh3N9NfEkJ8nu
         l8SS+NKJaKRW9Svv2hCASZuwGYwgPNITNG0C8D54c4+N13TENfKITy3YMG2FyGoNF4P8
         rOY0BbM4tvg+nrommvm+LSOe9sSwT8FHDkhzWXUAVfUSI73WGSW98Lp1tthojvy/g+Ax
         waaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOXpo53+tk8MxMiyhFPMYbZRMhCDM1W9O7T9XaDKXE4=;
        b=YH2eqigtLCYORTqZquFQR8sOoPHkcpQQZKC7xsJFljvv7OiIUpaQTofTIORT6rpq1S
         zob7ooztrbyXDhw8oCrhDd+MWWVjjiwzs/Bz7buVvEY0fP3Pm9+RcRVBj8Vrfb+EP2nM
         esAPcwK4XhYE7bX6Re30zI6y3aKFq+UGKjCM//UqjK+iIiz7xgpRXhsNYEWB0/QlX5xq
         mstyn25G29MlY5KNDxuUhAgPUxLN8I8Q72CUJjwYGuR2XBXcMaXWBhnAJtn3kH2E59/z
         g23WREuosXBUV6WafFpnFVTgQ+cNSQaRkZlMC3jnDCSTnsq6Du8hLtAPzE1cz6youEwW
         wgKQ==
X-Gm-Message-State: AFqh2kq83ev0HP0Its+YJWFCR8TBu0kSuzQMjg46ZIR22zdTQeX6MCAr
        UXZrYHTz2TJnen0JrUVOGhD7Kg==
X-Google-Smtp-Source: AMrXdXuMClMZi/t4VamP19GxKKUegQ+GpSDaywWACqZ+NfsLxUGI8QqRN6TuOzsGAhvHXCNwgQcadg==
X-Received: by 2002:a05:6402:4ce:b0:47f:bc9b:46ec with SMTP id n14-20020a05640204ce00b0047fbc9b46ecmr36583328edw.7.1674746284921;
        Thu, 26 Jan 2023 07:18:04 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:18:04 -0800 (PST)
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
Subject: [PATCH 14/14] drm/msm/a6xx: Add A610 speedbin support
Date:   Thu, 26 Jan 2023 16:16:18 +0100
Message-Id: <20230126151618.225127-15-konrad.dybcio@linaro.org>
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

A610 is implemented on at least three SoCs: SM6115 (bengal), SM6125
(trinket) and SM6225 (khaje). Trinket does not support speed binning
(only a single SKU exists) and we don't yet support khaje upstream.
Hence, add a fuse mapping table for bengal to allow for per-chip
frequency limiting.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 89990bec897f..214d81537431 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2079,6 +2079,30 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
+static u32 a610_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) three SoCs implementing A610: SM6125 (trinket),
+	 * SM6115 (bengal) and SM6225 (khaje). Trinket does not have speedbinning,
+	 * as only a single SKU exists and we don't support khaje upstream yet.
+	 * Hence, this matching table is only valid for bengal and can be easily
+	 * expanded if need be.
+	 */
+
+	if (fuse == 0)
+		return 0;
+	else if (fuse == 206)
+		return 1;
+	else if (fuse == 200)
+		return 2;
+	else if (fuse == 157)
+		return 3;
+	else if (fuse == 127)
+		return 4;
+
+	return UINT_MAX;
+}
+
 static u32 a618_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2175,6 +2199,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 {
 	u32 val = UINT_MAX;
 
+	if (adreno_cmp_rev(ADRENO_REV(6, 1, 0, ANY_ID), rev))
+		val = a610_get_speed_bin(fuse);
+
 	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
 		val = a618_get_speed_bin(fuse);
 
-- 
2.39.1

