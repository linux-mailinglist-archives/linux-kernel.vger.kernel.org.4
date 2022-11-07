Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1A62040F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiKGX5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKGX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:57:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F358226AF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:56:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j15so18514802wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgeozmPZqS6JXtBUtzz0XCzNbXeI8NLd/9teAZZ3ZoU=;
        b=Kr118oU3tWMRM9OSMDTcbOgWvtcP8ZX+qbTofQqOopNwYkeh3XrjPqa6V6VvNQvFvT
         buMppsTMAE9msYo92KDfPVh4w5Q5AkJkHxjoo21UDk4HoO7m0d+X3pqvW+c9s27zN6ji
         eAigHkl7x8GNbTxMKA3UOLEG7iPFPB5grRdVTKEncCeZQ4X7dPzTrZgrBEm0vuImwSdf
         GynTlyZRoiHPwRx0Z62w3A3uNl1VwtLVYX2fPCBpcT5fsD8hh1uopYrAGpCFro0X4IpW
         qvF8BiG7AS+gO99UC3oUTN0mzWxrLTASTXcJ5NIw9J/z7pW88w5/W7GxGgtLNFgJgOGz
         AwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgeozmPZqS6JXtBUtzz0XCzNbXeI8NLd/9teAZZ3ZoU=;
        b=Vn+T+7eBRIgxFL4tWb2BOj1rkFDyErQukKuctxOnnwJf1x3EKzB4LIiel+oc3VRhMO
         lDWZAzLLhRq1e65JxR1c2FBfmUs/3kYD1T+olZF6WzZVcfKZw+3jBbJ0sz1c/wkWleEl
         Fpc6Dk30VxuY0DgTkv799l8e7FxLeQZqsTFWQDzb1/GStmva0FDgycSBpQ0K8bN7QhWE
         BSqa5OJ37PmMCRiyhOUnw1fpAIc0dRpQpZpH1HWTwUxnCynUV5lwruS51s7tqik2O1Uu
         cVFjkJptw25AGnSRBbU9EqhxHCMzPXtc2cTjzKv82xeuomPV/Is1AEi/Ug5nSGOXfNtz
         A9jQ==
X-Gm-Message-State: ACrzQf0b7xZTGPUpkMCiC3EA9hDA4koFTsPxdlNXu5WwkKn4WGMaLpZN
        1n/3hGMIvVLOkFSImihckEA4tQ==
X-Google-Smtp-Source: AMsMyM6a2iAeeRzZq19eqEqkJIwF+xt4p4o6N4GE+PRqYk+U2IE/mi3aZrpaVlpQnpPKNsKNm05xHQ==
X-Received: by 2002:adf:e44f:0:b0:236:59a3:c5a8 with SMTP id t15-20020adfe44f000000b0023659a3c5a8mr34097585wrm.396.1667865417559;
        Mon, 07 Nov 2022 15:56:57 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm8386161wrf.76.2022.11.07.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:56:57 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/18] dt-bindings: msm: dsi-controller-main: Fix operating-points-v2 constraint
Date:   Mon,  7 Nov 2022 23:56:37 +0000
Message-Id: <20221107235654.1769462-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
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

The existing msm8916.dtsi does not depend on nor require operating points.

Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 7782bff89afc7..27ebfd5ffb22f 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -135,7 +135,6 @@ required:
   - assigned-clocks
   - assigned-clock-parents
   - power-domains
-  - operating-points-v2
   - ports
 
 additionalProperties: false
-- 
2.38.1

