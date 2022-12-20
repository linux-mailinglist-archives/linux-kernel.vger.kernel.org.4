Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E033E652078
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiLTMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiLTMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E7B1C3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m19so8583181wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+Ok/Y8Pr2ds0xVbkzxTKyFSBfTt/36m9CaPlTa4hTI=;
        b=Ag1chGkW8b+L6VHPtMej8JYigTy4MJpq9bKbqyfbscX949mD/b1DQh1u7rZ0YUA72a
         DYpejL92sBjCMJ4cSf0UjL4aVuySRIE7A78VGq+pWP2agojIl7kKufLjRoEe7ADrrNc+
         T1os/kTg5MJ4cmk/LcNEpRDf1f5M+09GI/YP99Op/Ep+1gVRzAhHxVrsxRFWis9LqBFY
         r8s8yjwoDnBT4w7dLISdmxSAU0FOTCgzrYkA8JVa00QpiF2MCO8/uOIlLG6w57ePuDwi
         buHZhv2+Rm+Juu4VhZf8EH+Jq7ANjWC2WupAosZk1GaSFuqvb9CRG6qgU43bPygym6i4
         NO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+Ok/Y8Pr2ds0xVbkzxTKyFSBfTt/36m9CaPlTa4hTI=;
        b=0wuYpbqOUeT0UkqeH8Zjj8T15UTjtA0trpKii4MDa5P1YGLdGOndAGcKdPloOtfRAX
         vQqhotTP1NbHwNMlxNnM/eO2hQnQ7ZSoIKGuwHpYcEa7vz8gzzgs7UEW2U2G02Z4ftpe
         Svh8bG8ZlujlYKX8nyI/aVey2GG4gEUfOEC523m6S877PLVdMpbPsgIS8qZDaU1QZwvL
         l5dp6Mve5gfm7u/aLtgMi7GdNiAcIDhNIGgXFethcTyKPx9o8My/b0zV+CLohQA/TaKY
         h1z7aiOl1g1yQ24dniiN4Be0jhVpU7DX8Na03n0NBiVo1AJ56qkwFlxSzVKC39r2lirQ
         V6fA==
X-Gm-Message-State: ANoB5pmIx+CNledlOsJUYrcJuX5lDCoI2UhJTS21suheY2IdH2iHtBf/
        fjcxe9M2fDjcmLHGqtWqMvSEhQ==
X-Google-Smtp-Source: AA0mqf4PxgQM04G2ksh2FXeAbW88jOU2n+w0+LzI66CabwqjcV7HzBb9OwQuhQwrv1iFoIAvaAAg5Q==
X-Received: by 2002:a05:600c:42c2:b0:3d2:24d2:d02b with SMTP id j2-20020a05600c42c200b003d224d2d02bmr25615593wme.29.1671539799584;
        Tue, 20 Dec 2022 04:36:39 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:39 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 02/21] dt-bindings: msm: dsi-controller-main: Fix power-domain constraint
Date:   Tue, 20 Dec 2022 12:36:15 +0000
Message-Id: <20221220123634.382970-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
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

power-domain is required for the sc7180 dispcc GDSC but not every qcom SoC
has a similar dependency for example the apq8064.

Most Qcom SoC's using mdss-dsi-ctrl seem to have the ability to
power-collapse the MDP without collapsing DSI.

For example the qcom vendor kernel commit for apq8084, msm8226, msm8916,
msm8974.

https://review.carbonrom.org/plugins/gitiles/CarbonROM/android_kernel_oneplus_msm8994/+/7b5c011a770daa2811778937ed646237a28a8694

"ARM: dts: msm: add mdss gdsc supply to dsi controller device

 It is possible for the DSI controller to be active when MDP is
 power collapsed. DSI controller needs to have it's own vote for
 mdss gdsc to ensure that gdsc remains on in such cases."

This however doesn't appear to be the case for the apq8064 so we shouldn't
be marking power-domain as required in yaml checks.

Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 55bfe1101d6f4..8ba61fef576a5 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -137,7 +137,6 @@ required:
   - phys
   - assigned-clocks
   - assigned-clock-parents
-  - power-domains
   - ports
 
 additionalProperties: false
-- 
2.38.1

