Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C4714B03
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjE2Nxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjE2Nw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:52:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35751B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so3533964e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368361; x=1687960361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbeDfglU9RuqTNjicprjwIl53dVBd5+75wJTdFjQtgw=;
        b=kTmeGuDwHU7ur/4sCsdXFYp5FoWicN2xTDVsoJWnudN7w6K3dZD4YeNnSBuqew7TON
         58SXqtcMN+NnCtucxZleD7d20JoqR8E1L0azxk1a5Pqk4OiRH9L2CQKMFv+NgW+J6+Mi
         Y4zK7R4L3i0rEm5jeG30d4F2LmsjpQDMpmSON/IedFUxBTHeCmmJt4JLzxIqvV2KjS3M
         Yyv5zTuXXSyFKfvhIBtwFD4W7RUVgCFm3XUmn2A1orAp1hjSiW/J9C4GrYVPjcZR9z5w
         zPkRRsLO7LI1ggBw0U82WHFL7qf3+CEp1fYNQdvBD5hPUJu2/pcaaAZwh+80oaSeOBpJ
         Qapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368361; x=1687960361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbeDfglU9RuqTNjicprjwIl53dVBd5+75wJTdFjQtgw=;
        b=MgYmgY/S3lWRhScUpP7FxtNqJcUmRVJsJVJyZnuv1suWK/xNW0EylJS0+4aQwcyjN3
         RDYFsUaVb7We+5jTq+0fyVJUSb9rGizkYnEvFr0SVvQReI+Q22FSEFggMdFsdM9+ptFv
         f3Jv4phiLAAj/E3V1OUwlKf489EjpZOtz2DZ8vW9Ps3DEVkz7QQRDxwiUhi5a5NbUOjy
         ww4q6jYbhJSTjq3t/Yla36zITB0OZmB7nWCqfysl2BIedgQ3yNyroV+cK9eq6S/oaex0
         pZDUXiD7YC/nXHhBhUtqWW5JFT5W2VSpjuB1cXrLDoAIRfxUvMhPzZpuN1O7W9GHiVNY
         SiAg==
X-Gm-Message-State: AC+VfDwLk/aQ3l/XFsb2AdT+ju4QlTfoGi8Ci1+zKxUfdIlzmMMF/yrb
        d14IRPg+OZQ9Ro/WyfnRjwcdBA==
X-Google-Smtp-Source: ACHHUZ6PQypAvlUh2hsqbkNhe5pjEaOiHixQ8ChfdSLjTypH8+v6gv71iop8fwxlVFtHecbwAVj8dw==
X-Received: by 2002:a19:f616:0:b0:4f2:5aae:937 with SMTP id x22-20020a19f616000000b004f25aae0937mr3856646lfe.64.1685368361510;
        Mon, 29 May 2023 06:52:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25310000000b004f2532cfbc1sm4700lfh.81.2023.05.29.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:52:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 29 May 2023 15:52:30 +0200
Subject: [PATCH v8 11/18] drm/msm/adreno: Disable has_cached_coherent in
 GMU wrapper configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v8-11-69c68206609e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685368343; l=1374;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Ocm0vLk+RPaXxNK50G6/CzW6Z0tf26goam4OhjTSWzI=;
 b=OqnZmmRzBagGO+AOTrI+XHelqF3EIrMG+V9wzMJiWxI2d7ec+LBLcEAQeWd3/PRVxqEVdvWEp
 mJS/OIqE32OBBWlH7Zwv4UhJkkd+aYRL2Vi2oGPZNQkASJogpaYiT/0
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

A610 and A619_holi don't support the feature. Disable it to make the GPU stop
crashing after almost each and every submission - the received data on
the GPU end was simply incomplete in garbled, resulting in almost nothing
being executed properly. Extend the disablement to adreno_has_gmu_wrapper,
as none of the GMU wrapper Adrenos that don't support yet seem to feature it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 8cff86e9d35c..b133755a56c4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -551,7 +551,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 		config.rev.minor, config.rev.patchid);
 
 	priv->is_a2xx = config.rev.core == 2;
-	priv->has_cached_coherent = config.rev.core >= 6;
 
 	gpu = info->init(drm);
 	if (IS_ERR(gpu)) {
@@ -563,6 +562,10 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	if (config.rev.core >= 6)
+		if (!adreno_has_gmu_wrapper(to_adreno_gpu(gpu)))
+			priv->has_cached_coherent = true;
+
 	return 0;
 }
 

-- 
2.40.1

