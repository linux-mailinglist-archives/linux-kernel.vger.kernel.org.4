Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA32714AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjE2NxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjE2Nws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:52:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070311B
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so3744328e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368357; x=1687960357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEG7D8dDSqo05e8UhKgqNHGqbXe0pvKNUFpleUKYXVg=;
        b=VYVTUh8pzTNgV/eVoCNaftcZqjFTRyjiCwc+8UsNxROQQ1N6C6dvlrpJi4JIs0Edjj
         uletisN22xYlC87IH39xVDiD6XTEe9HptbcoAY1ViLOWEOBkHiq8D0A29yBQr3b6DLCF
         macvNl41DoWq0xDMKH11Imwo2RvVmJYoJ5dfluBXrXyfbknaS2vHDWxRwVzsQ3cVoTDE
         naYDncIxqPghGlwhp0Ah7CEE6nV1RAEWt8ET51Nk5ijHzw7NJgzjzbgA4/+hSxvppdff
         ephadTzUZd4p9lMm3lDEjhV1L9sP+84mLko0VcoEsbkxh8NWLT1cKND8E+wjv2dFRntP
         8wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368357; x=1687960357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEG7D8dDSqo05e8UhKgqNHGqbXe0pvKNUFpleUKYXVg=;
        b=TA02TLtbXHJbg7m9AjFrGQs3xGIvz6qxQQMhSJSPiwjarV0Gyufeqm8DQH4bQPAKKi
         Y5xJEQ0pGyHoVwG8T3vMius8y/EpJJ3OB53Zj22ejQmjAQwejw9FAKocuOvEVKcAOcBX
         7xHodlZNJyN8Me1HlMP5XO0RjZNGnUDYCsAlTD8BJ3TTe7q4YsPyVHZBmqFgbTigr2QY
         FpId1sD7irOq4hHMZXPbs6NJA6v66eXw77ez4dwtqG+a5b2HFypA685uEfm+iUuPd5VQ
         JjTXsd3r8sq5mlkEacyIFquU7U1IVPvSyyUOipfmYuSY9dmfkMk5sKdxcOiBMmySeyi8
         pyqg==
X-Gm-Message-State: AC+VfDx4q/CKW1o6w6nvuRksiv7RKNRKwt95gHymbVgEC/I6+V5RgMUj
        rNOWem0x9qLobEJ7xdxm4XouWw==
X-Google-Smtp-Source: ACHHUZ6BO3IMMdXQ4hOUI+q+RFhQoVSWjfWKHkdE8DmtBgfUjDjnwIVsdQTgMmVKONx6M/Q3ajt6eA==
X-Received: by 2002:ac2:4a84:0:b0:4f4:b05c:dbca with SMTP id l4-20020ac24a84000000b004f4b05cdbcamr3485700lfp.66.1685368356810;
        Mon, 29 May 2023 06:52:36 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25310000000b004f2532cfbc1sm4700lfh.81.2023.05.29.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:52:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 29 May 2023 15:52:27 +0200
Subject: [PATCH v8 08/18] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt
 on hw init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v8-8-69c68206609e@linaro.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685368343; l=1283;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JTiDWY7uw1D1PMKchNdprqbjJGR71Zsm7TruEBGJMeY=;
 b=xf73OwsERrXCMsq+Y+pf5PjUz5MTlKgqefICpZArCRq3AjzzRFz7lkqcF71SO/1SDRJfxrJKI
 cw21cRkAjsqALBfkZ1voAsLn2d2HMcmL6Z5gewnBdwHSDizkODWwhs+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0.

This is typically done automatically on successful GX collapse, but in
case that fails, we should take care of it.

Also, add a memory barrier to ensure it's gone through before jumping
to further initialization.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 083ccb5bcb4e..dfde5fb65eed 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1003,8 +1003,12 @@ static int hw_init(struct msm_gpu *gpu)
 	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
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
2.40.1

