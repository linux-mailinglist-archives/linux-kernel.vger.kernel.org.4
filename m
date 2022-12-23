Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74AE654ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLWCKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWCKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:10:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA0220DE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a17so3368699wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+Ok/Y8Pr2ds0xVbkzxTKyFSBfTt/36m9CaPlTa4hTI=;
        b=MrhN4Xb9RiUuzbzu5slyO/DpcQyG5glXnDF/6fqL9FJZMT/5dc2CHnWYXtss5wwPn2
         ckcR8BQ/3elmwT5pBC3a4mf3/Adv99wKrgjZ9dEPMbJoc8bVMj7leoXXLPTtaldcvV3Q
         07dMJ4wwtxmyipd+bHdalaiHQahJM+JPV/dAz7lMU1OQp3Ne9y5wfMMtjlps0w6YqIUj
         z3ZR8mJsgvYejDkdD7B0wNV7uYQbZ+4qHAqTRMWUWAadb8kdcTmrPVKr6Gyennx5r4VT
         cSZYiLEhwi3T2GlyUNEYuS/0vtyn/v19F0TB+RBqGQDyUikwtsQPDwEdzVY4RyFCOms2
         xUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+Ok/Y8Pr2ds0xVbkzxTKyFSBfTt/36m9CaPlTa4hTI=;
        b=17kS4XzBCTarJpV0z8HbB+ZFrO6f/+l8VXa6HCWEDr0S6tnpgsA528t8lriztnuexz
         pyEiUwgTrPAoPc87CLJJNj2i2Gt8VQAYyxUWscSzJ+zq4WAbXWl/AP9Ly3VYyIxjthRP
         fWjucRJiqiP464MJxzUrh9Su2enwR8vbcvEbG28jiDPwM/4NDSiq7Umvr4hJfDzsV/py
         C0mWjBLDIanyeAg9Oq1wG135BiOUbW2Z19ZSizpQXHILb/MNPCc8x5dbfd2kykQdd3sr
         KJ15F15b7wVVYiHsb+mAkHiSLqGTZPNEvAecCPU4tB3YZB4lfW+MLZMo5JGfDTJ6npbd
         CdLg==
X-Gm-Message-State: AFqh2kr9bjGbZ5zM+lVHYjt8lzt9IwjwRHO4EO9u4tKzzVR3eb5RR3bR
        f9odb/8A5cqv5Zuv1XU+YNFxTA==
X-Google-Smtp-Source: AMrXdXuu2FQx7IxvbWNkPzFPFbP1DApQ4G+dhRhfQmOT0QbUCc2Q1fzyKDnhG2hNUyqkCCJ6/z7dag==
X-Received: by 2002:a5d:4d8c:0:b0:241:fb7d:2f15 with SMTP id b12-20020a5d4d8c000000b00241fb7d2f15mr4047043wru.29.1671761430916;
        Thu, 22 Dec 2022 18:10:30 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:30 -0800 (PST)
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
Subject: [PATCH v6 02/18] dt-bindings: msm: dsi-controller-main: Fix power-domain constraint
Date:   Fri, 23 Dec 2022 02:10:09 +0000
Message-Id: <20221223021025.1646636-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
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

