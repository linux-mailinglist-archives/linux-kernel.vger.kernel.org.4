Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACB6D133B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjC3X0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjC3XZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:25:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3FE12054
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j11so26631000lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680218732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBl7yKVCwhjc6yO5z/z3JPkwp8Wjhy3CVWsctbwDdiM=;
        b=J7ShoQYmlST31y9vYBnakfBjPumtRbVT2+SIx+XvGQGWIxuk7JkKCbQA7Xk5dA7I7L
         yZ7Re0fmWUaIlXxfUVhl61dmv4UTqVVwn0/71RSOC8CCQlcZIbtTiBESgNAnO/Puz2sn
         dt99mGqLsUiJ5OzFZ710eUgzsIVVs5WCwE8SA3uhPrfeqrHqJqq0xEXKqiG+coxQ1HXV
         jfYiChhzN3ApQ6Cb5Rpo99/IX34BPRwfuFJkXGHr8oG7RnlsFsj1eneyi6vhRqUerjDY
         gYuCVVRPlj97Y7Y0qgme6ECacS78PL8jQuPZJZ5mozwctG7FeA1QuVUwfFV7LGJpffaP
         0Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBl7yKVCwhjc6yO5z/z3JPkwp8Wjhy3CVWsctbwDdiM=;
        b=itqt4l6BkN4vPHGgGoJFBtHacjQBz1h0tpC6NVFxsZaEy5gU7pfA1AqW/S6AhIJNvi
         5k3WLR7AK16ZNZFBwP3Umd9D7h1Ta+xCiZHGnuo8Vn7kaZvRxlsW5XOd7stl59QZfWko
         SWqtF+l/EyOTjT5IcAkvfMVhGWsJdgMSDP72Qk/ugbr40KufmNDL3bM87wry785doJPN
         DhB2x3GSiGK5ECM6scL5tWYBi2DdXwclBvvEJPmAW/sUFhqfdbXNY3DA83+PGa5yIgP7
         +A7TtFnzE/F0OtconunaqPFD3/3/2sShbwdYUR8UKryee0WGP3m4fIU7n6c2tjnPnCNd
         v5Tg==
X-Gm-Message-State: AAQBX9cYop18O3VZh+hDVztRWkExn5N4AfihHBaanfIMlMjwNM8k2Ih9
        J/1fxA34K2NEMBRb66HNJEsBiA==
X-Google-Smtp-Source: AKy350YBpdsthEGRJfnncDpyCejjJFqgpBgwEfkchfFs55N+b/DdksqIwRWVvJPLXY6DeK1x4ozP7w==
X-Received: by 2002:a05:6512:503:b0:4dc:823c:8127 with SMTP id o3-20020a056512050300b004dc823c8127mr7083593lfb.57.1680218732024;
        Thu, 30 Mar 2023 16:25:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g26-20020ac2539a000000b004dda80cabf0sm127241lfh.172.2023.03.30.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:25:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 31 Mar 2023 01:25:21 +0200
Subject: [PATCH v5 07/15] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt
 on hw init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v5-7-bf774b9a902a@linaro.org>
References: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680218720; l=1312;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hzdufW67WGWbz2ZzqJov4K9OFxkr5eIp/rEY9Lr23FQ=;
 b=jUpAGWsk1sjcau7+3KKia8exWl7xlfLIwI0u4knrO022fI0vktcWsJ0R7MQyEWT0sZmd1gp+64Ru
 JkqYnxAhC9bGuEEKKOY17qjaRgmcj95XUwAmqk/IC5lmDqAdZZnn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0. For GMU-equipped GPUs this is
done in a6xx_bus_clear_pending_transactions(), but for the GMU-less
ones we have to do it *somewhere*. Unhalting both side by side sounds
like a good plan and it won't cause any issues if it's unnecessary.

Also, add a memory barrier to ensure it's gone through.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a7ecb0a87e98..30dae3ddc1c5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1015,8 +1015,12 @@ static int hw_init(struct msm_gpu *gpu)
 	}
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
-	if (a6xx_has_gbif(adreno_gpu))
+	if (a6xx_has_gbif(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
+		/* Let's make extra sure that the GPU can access the memory.. */
+		mb();
+	}
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 

-- 
2.40.0

