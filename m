Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006EA696BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBNRc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjBNRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:32:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BF2DE69
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id n20so3507022edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA7zP8WNqSIxNsvlcXasT+8KqRpaNDNAbEWnbXxBDw4=;
        b=evazl+A+N6Cdli7S0ZAn3imoQpi0G22lPXh1deX/l0fnPhnI4kncAdAGEl7jDKvl2r
         3YjSE+aRiIUFu/gGXPD/5/wAbpePk1+589S2KH3qqU83uKbS5gYOEYFTneBs9tis5l4U
         SoCWUk8dzbHnMvzkkicBlNxJrnU8YeaOnJBdNLxNIXZ0JTkWIMXjgb/TjoA5SX8LVMwY
         joZGOhMOXlw89WdbCSgugeh85j/F6HZQrg7oe23v5WcQQ5ZV8Kh5BJs4vaTmLbt9M7Kj
         OP9yWPmjzLjasLku+ZLbqIkV9YruaOnQlGw0LO0cKWVsavO4UVDQQFl/vfuPNw+ll6rH
         fgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA7zP8WNqSIxNsvlcXasT+8KqRpaNDNAbEWnbXxBDw4=;
        b=xFc3GAlozW2mM2xZZaogI7yUclZmFrxBkcGqOwPjSH8lEfGKkH0KNhFMJnDOrHH3f0
         uTCVDOdUjgn5FRTgwl5cBz4QZcN6oaQVwrZM4c6+nHcxi+2xCzS+yxrYM+f1nwEHXwkz
         EbZAtPF7LN4DQ2aLz9oaaEg/hpX5reIsMkYJU5u98aT9nXTK9SNfjjg1wfFy9koNVYex
         hlBgx124Pg2P16xT6SqxKwgBwEsGr00uhK4k6A2zy+Y8Yl5yff3uqoPDfhZQfRRcxu/y
         DiVdN+ymc8Cc9b6evZMwCzp2MZbogcq0YCrzRW3+dVcPik6yGCYupXD3xiLDXM19L1pY
         /Bbg==
X-Gm-Message-State: AO0yUKVE/tukXK7SEJ6BdHLrn58ARqo2uiVs74B1kZ7A6hvai1U4hsOz
        axIF/Bk4vvdaLyl+Mo7xjWw7jw==
X-Google-Smtp-Source: AK7set+ctVCl1+WL01sBa8+tYLbtCUXlSqUfh34PPJGi3krIv2373I0oowT03Py5+hQ6lnZq5esA3Q==
X-Received: by 2002:a50:d0cd:0:b0:4ac:b600:180e with SMTP id g13-20020a50d0cd000000b004acb600180emr3271691edf.19.1676395941705;
        Tue, 14 Feb 2023 09:32:21 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm8325787edf.24.2023.02.14.09.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:32:21 -0800 (PST)
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
Subject: [PATCH v2 09/14] drm/msm/a6xx: Fix some A619 tunables
Date:   Tue, 14 Feb 2023 18:31:40 +0100
Message-Id: <20230214173145.2482651-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adreno 619 expects some tunables to be set differently. Make up for it.

Fixes: b7616b5c69e6 ("drm/msm/adreno: Add A619 support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1e259e9901ca..503c750216e6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1174,6 +1174,8 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
 	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
+	else if (adreno_is_a619(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00018000);
 	else if (adreno_is_a610(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
 	else
@@ -1191,7 +1193,9 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_set_ubwc_config(gpu);
 
 	/* Enable fault detection */
-	if (adreno_is_a610(adreno_gpu))
+	if (adreno_is_a619(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3fffff);
+	else if (adreno_is_a610(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
 	else
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);
-- 
2.39.1

