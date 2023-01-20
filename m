Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D261675B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:22:43 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDC6186
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:22:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z11so7607543ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTk/tR/tYl/KCS8N+SRDUWNSvwfDXiBMlwXtmH5gaEc=;
        b=YbR4ogtIlbSVc1u3jnY1YBF74m+ZBlifo5clT1CFPy1Tb3Z/Exs2k40fyU4F6Z0HzP
         Lp8Q/lndOGXNeXcIpktSqHhYb77BdaDyxMXXU5su6dqm9b2M/HHotEBAosBNIcrKRNzh
         Sc6caoppnZ9ReFwJkwlzmNjybToHDpI0mAdUnVtFEg4cH996zCCu9h1p2cIexmOGtRH8
         rAic1cOwKcldZRCLVbP4tn3DPzvu6nL0j46zEYtkK5LWgxRbX+xdSvq/XGEoQe9xgoOz
         glqS7yz/DPyZ5ijAP5GNsmDbhOqwPp7ITOIv0Kyi9n+7CM9vEtQAqyIoqFmGWb+UjZYc
         JA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTk/tR/tYl/KCS8N+SRDUWNSvwfDXiBMlwXtmH5gaEc=;
        b=usDAPcl27xA3IiwtbaR5IZaWjKZEsoVFSrdnDYMAcxURE3Lajna0YdGMFlXheJwoIr
         F4A27fDb7SWvlED98W9p83M0anaiS9LGc/JQolpAY+ZfqqzMTELTOVl4SHqfhsXjjf/Z
         cspJI+6kNVIVM5bgL618TNqZUmSgQWRVgK2/J8BFO1iOdwjfMmC6Vi9yCbGd9wObwG0y
         dTCqAhAQVzbe2pLxQ8KD2ceLrKyota2Z7nNawGLVleyPP9LnseLiKc1GyLV3sXB4uhIp
         LVoRapZrRItsJ5efiyhZZX4lbDMEDhMWVTodp2Kyb3fV1wG/zM/W17A6knIdq/hbR8e+
         t0rA==
X-Gm-Message-State: AFqh2kpLmRQ1lRZljMU1tsRcXDpAL6z7+7Oh9TAyhmWhSGOyH56yIy1C
        Po/u+zN7lzaoMKeJPasoR6L/xA==
X-Google-Smtp-Source: AMrXdXthABXCdiT9cLDMkuBkDpMVfezZjlIi4Sc+A7GxntmCeVxSoxYgIir09PgnJz6TiGQQWMCuEw==
X-Received: by 2002:aa7:ccd3:0:b0:49d:f44f:7ef1 with SMTP id y19-20020aa7ccd3000000b0049df44f7ef1mr17648565edt.14.1674235360898;
        Fri, 20 Jan 2023 09:22:40 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm18313857ejf.179.2023.01.20.09.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:22:40 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm/msm/a6xx: Add support for A640 speed binning
Date:   Fri, 20 Jan 2023 18:22:29 +0100
Message-Id: <20230120172233.1905761-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
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
on A640 (SM8150) GPUs.

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index aae60cbd9164..0ee8cb3e490c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1884,6 +1884,16 @@ static u32 a619_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
+static u32 a640_get_speed_bin(u32 fuse)
+{
+	if (fuse == 0)
+		return 0;
+	else if (fuse == 1)
+		return 1;
+
+	return UINT_MAX;
+}
+
 static u32 adreno_7c3_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -1909,6 +1919,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 	if (adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), rev))
 		val = adreno_7c3_get_speed_bin(fuse);
 
+	if (adreno_cmp_rev(ADRENO_REV(6, 4, 0, ANY_ID), rev))
+		val = a640_get_speed_bin(fuse);
+
 	if (val == UINT_MAX) {
 		DRM_DEV_ERROR(dev,
 			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
-- 
2.39.1

