Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA934696BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjBNRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjBNRdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:33:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D5E2F7BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lf10so10057496ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7mTIcBAt9xKjMEqRxhkyslwv9ImP8F3/zPYA7ZjQgc=;
        b=Zz7CuboNHAWxl6q+hJmpjx8lB5Xi4d+tF70/vbE9hZpGX4KJoN6E5BaaBvsVppY8Pb
         hNt19jDlIb5ybaLwQbw+EF94Ui2RXSrCuifWL/raIV65/nFlfgMdo5Cgn03hTdj2eVGm
         vdIZEUjRbQMxzVTmE5dJmj3GDBysMaF3EaCu2jFRr8x25qYMIeEReBOW4N7HttWuABuu
         o55GXFTzD3TgHopbKSM2GYHhzxk5SeCQJNydS/hM+b/btdS/QqwjTUvT9jfN5fAutJM2
         RcwRBnn1ddYzEWZ7TXeBF+ccbCgkbpIT6qX/sOaqFy65akDck6mtTW/Yx8ZLj4enlPTw
         0CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7mTIcBAt9xKjMEqRxhkyslwv9ImP8F3/zPYA7ZjQgc=;
        b=EMMksInkosDnERZd62sCi2WgoUCTj9DaBl9eExV+njRgoYHK6OuVxwOEfMr5p79Inq
         HPcyuWGPdUgD+HDW3gV3z7Z3tXPKEzeuLUh4jVqnCCq2MhzYtF21h51UaMMc7bgaz+Lx
         +SPoI/cchOXgq1yNWUoqhwyX2Og3FoeN36/q6xoyFwYZvoct9AlkHw/SIHl+U4bO32Mj
         ealnvcMJzlxYeoUonNE1aubI4rv4asi1B+kLgu/vtP0/sUpwO+cjNcSTxr2WYc0rl2GH
         mME/BiukzPScLxNbkSizaz31la7F96OerLUuaRdtv154liHCgT5PMZoAf2jSiUvL5LYq
         wwdw==
X-Gm-Message-State: AO0yUKUiJl/Vfc7RU+BIlFk+nqX/Cm9UeyYfCUldBFA2FOW+qb90uCfA
        kAPIYfQLbN9yu3r+O3bDGO0Jng==
X-Google-Smtp-Source: AK7set/DxweF1llsDQScksIm/PFWy8dJZGhQvVBWx3ajlHfc3A6Nzdeu/HgS5D5G+hAQNBO/AZb1tg==
X-Received: by 2002:a17:906:3b87:b0:881:a3ec:2b43 with SMTP id u7-20020a1709063b8700b00881a3ec2b43mr3475091ejf.56.1676395953957;
        Tue, 14 Feb 2023 09:32:33 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm8325787edf.24.2023.02.14.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:32:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
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
Subject: [PATCH v2 14/14] drm/msm/a6xx: Add A610 speedbin support
Date:   Tue, 14 Feb 2023 18:31:45 +0100
Message-Id: <20230214173145.2482651-15-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
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
index 94b4d93619ed..f2679f9cc137 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2082,6 +2082,30 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
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
@@ -2178,6 +2202,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 {
 	u32 val = UINT_MAX;
 
+	if (adreno_cmp_rev(ADRENO_REV(6, 1, 0, ANY_ID), rev))
+		val = a610_get_speed_bin(fuse);
+
 	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
 		val = a618_get_speed_bin(fuse);
 
-- 
2.39.1

