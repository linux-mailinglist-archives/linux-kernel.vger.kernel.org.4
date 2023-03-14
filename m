Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96846B9921
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCNP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjCNP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:28:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E33A614E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id g18so16449285ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=159lZK1VC8AnArbTbfywvfz47MuAlqr+e0q9A9rUbAY=;
        b=ybkS1ks85NwBg0oo4KVc4YOEPbJDHyxaTPYyY5Ix/0wWYBycqMFQxYFzrOVQ6wjypO
         fQmQycMbmWZvRFv7EduPzK10eesNeyMeiZJvpoHNqbbImGbWHlCu0F/fNvwSaVttOIlN
         JSbW0fOGV5ZttCFGvf6VYxPo8gUKcGGVxpMglgQDoUl30mV6R4KoNhgzpaQ2j9Glukbz
         RMENp5oNU5cfRTprvVqD6orxx+uicybh/W3zYauQtLBj6JZRMKQ45UVZCOvhq+SHvDd6
         lJWX0KvsUlPjFe6eyjd21Ka+W3Hcqs8eiTJMKR6z32H0p0/HpJqW2tyDrqH1IaokaCXz
         +56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=159lZK1VC8AnArbTbfywvfz47MuAlqr+e0q9A9rUbAY=;
        b=CeuBd5+9nv5ULJ+S9T2xQw3sM9sjsWjQD6HQWdSef1bXcFBzg4vwO+ND+fsLlzhVHi
         mRRjYMqJres6BxFNhfhhMMp6Eo4HooGV7ZvXEZIJ/A8w2iT6sqw50Z+FsRHvL+6VKr3+
         A4CEjy3HJOrB/OfWs9/MXrglVl0plbWxDnS/4fW8qRMAuv8/hRyJxr3j1fst4iz1wlo6
         sMVPgc3Up7wIk62tHZvLwojY3/r3FgzFyetxDO8ToqkLumv2xqkzarKHVWJJZVtSzfEz
         iGj3p66yYKe4fiB47uS0le4xpLpChBiQ3yS5KX2RTk17RJ+53dkqnt9LrxjS77YSffMS
         tjKw==
X-Gm-Message-State: AO0yUKXIYE/pOdO4khJJXIV6b+DBrY8o5JvAhYdHceeKgS4B+XmysvvH
        Hi8oMByFV+76aNsPspMFGbqlVQ==
X-Google-Smtp-Source: AK7set95lDIxfeW2sbimzmWl+O6poG1xg+59izmaVd4VGvYk/eNDDUxvFvJ4rN1VRn8SyfcPqBex6Q==
X-Received: by 2002:a05:651c:1059:b0:295:b96e:ca99 with SMTP id x25-20020a05651c105900b00295b96eca99mr14017598ljm.50.1678807728292;
        Tue, 14 Mar 2023 08:28:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 27-20020a2e165b000000b002986a977bf2sm491529ljw.90.2023.03.14.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:28:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 16:28:37 +0100
Subject: [PATCH v4 06/14] drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt
 on hw init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v4-6-e987eb79d03f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678807716; l=1251;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SQf5xqv6dgkFv8lqaRaSsqR3oatLGI4JEKv+JlvqW4k=;
 b=j0wqavMQyp9JVzEUb+dyZ3aehx3l+F1HEWpU/j8PV1u7+qyWbwNnPl8Ix1vohsIlZY8QP7XOf0G8
 gFxAnV4NCSDkUzx+xsz2mPlEqsuMhpdcxfpQLRfk7YgDSyVTBnNy
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

Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
need REG_A6XX_GBIF_HALT to be set to 0. For GMU-equipped GPUs this is
done in a6xx_bus_clear_pending_transactions(), but for the GMU-less
ones we have to do it *somewhere*. Unhalting both side by side sounds
like a good plan and it won't cause any issues if it's unnecessary.

Also, add a memory barrier to ensure it's gone through.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a90847a3379a..70e9bd21ba3b 100644
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
2.39.2

