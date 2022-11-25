Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF96389F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKYMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKYMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:36:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D72CC86
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id x5so6584183wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cozmslkV1HJ5ORZW/fLPcfuOLJG0p6+yjVrLX810OU=;
        b=gSrbme5axxsrUfHnJ9DqOnGjycqxrvH4JWeFUpEagKcA9Y9wG8ZVhVWb+j5c6NH3yB
         2Lj+kWBs7GuExgaBQtEwSVOdKFnww8VbwbGUO9bhMpNGL/cGmdc/32NToDKa/ek5gAts
         6nzwlj6PJzXAg+tT0H0J48wy4OyWooMjq1TY85zJteBL2QjV76TYfN5qiBMZoauF+lJ0
         VwhojtM5eqNF6u8hcVeIkFHwaAyudnmRvq5rCj0MGN9iJ4PKgBW3TiamUH2Kywh5s315
         Vfcn+0ihaZS99RgPcahniK9lKLLV9UTUkNKfRCD49CMODa/aEPy8FTPUCvFBFw75o1/G
         uXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cozmslkV1HJ5ORZW/fLPcfuOLJG0p6+yjVrLX810OU=;
        b=BezOt2azcP8ntncKkM5YVkcCR37obtfBbjD66Cc6ZNuXocecj8M6Sc5D0vgWGmckiE
         C7N3eZ2NkjUtqWgwCBOLaBIrvgUNjlx4UJHBTOqFaeDU4ptAikv2cHaFhFMmmUGXk9/g
         vOMAHQ1KCPZC4U9bQQikrQ4IrjuK3PTDiwwklSddDuIZcsYWlEQ/XHYdVdoxXpBdPkGV
         7VXcEF595NPm1DOfviMWHriYgW9H0AtWvk+n6kirJJWuSdrnDqD7VNtf9/SPEhMLMZ8+
         OSZGocgTB1LNW4SBPPbvF/Z0LymsmyvUxO+F29QZO3cv+F2L3pxqDI+LIG2Yq+CmyhKp
         ogQw==
X-Gm-Message-State: ANoB5pkTqiYctRLe0QOP0L8fsZTKbvtitZ7ah5iE8mxfg9eV9MEJT1NL
        ForaDFOOfrpmy80W2Ud23Hz4NQ==
X-Google-Smtp-Source: AA0mqf6uPUyO7QCv468CYtFMBJdaaFEuo54w5kbk/FXdWI6X0qARaBXuLmS/8Kie9UtoOGkY8h36ug==
X-Received: by 2002:a5d:4b8c:0:b0:241:e1c6:7e0a with SMTP id b12-20020a5d4b8c000000b00241e1c67e0amr10626814wrt.463.1669379803818;
        Fri, 25 Nov 2022 04:36:43 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:43 -0800 (PST)
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
Subject: [PATCH v4 02/18] dt-bindings: msm: dsi-controller-main: Fix power-domain constraint
Date:   Fri, 25 Nov 2022 12:36:22 +0000
Message-Id: <20221125123638.823261-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

power-domain is required for the sc7180 dispcc GDSC but not every qcom SoC
has a similar dependency for example the aqp8064.

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
index 27ebfd5ffb22f..cf782c5f5bdb0 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -134,7 +134,6 @@ required:
   - phys
   - assigned-clocks
   - assigned-clock-parents
-  - power-domains
   - ports
 
 additionalProperties: false
-- 
2.38.1

