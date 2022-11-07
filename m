Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE37620425
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiKGX5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiKGX5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:57:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B127B05
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:57:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso10655086wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/l0ZArM5aYLACoVmmcFP9wBttR3aaNtl9/MPOMSmmw=;
        b=Xe2BXEA8czrlM0BrgYSbdDgxtV/SeozvhiiL/+B3EhdSDp+vlE/fsBjKAgyWxcGAvj
         +o68P+10dkRhRQkepfpRIgGSUadpp4mj/mYrc6GKO5LVfQ/O3Atin5cu//D6POLSlZ9P
         +UXKxXZ83k41SO3o8mbdRW8K36fcE1monc8f4gDh6ajwVdM48/GjcygT8zgwZOzAhJ48
         LpvmGdyvY/9ydFj3Efce0NQx0xMnEefEcsa6xmSSUti55h64SoGPqEYT4yw4mDAjfDid
         vu8jaygzOS2uiHyJ+I5s4P2b9hOboupXMtLktDvpjJrbDNs/tPzVr7VREM5ySgBMwzKv
         mdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/l0ZArM5aYLACoVmmcFP9wBttR3aaNtl9/MPOMSmmw=;
        b=iWib0qKN9sLtSYBjdE34DNpjiKKxw9A8zF4GAJEQ2hxC/nLXY2i03oFV3EPQUaLDiy
         /7v4rsrzvsZCfhl+kelWU0vwT4FEOX+JHzNlnmr6FhjNM7BVvttU5iDZI/GOfsckycJI
         bOuqZYyKBjLUsYhzSKTDrJe2H07fHUVqjI26ku3oTOYpSlxJqeA7mQXD2fH2bQAV8v9n
         vt9vm9IssSPINhfe6pyng1pfeYe9FSTpye5mI0IwgZh/jZOlum60ozaAyberU93xwEtm
         VDyF9VK9LykrlMny7QB/HM/cE4b6soSc4H29D4jKYElh1T156oDzt4kDSEg5iebZFB0K
         0LZw==
X-Gm-Message-State: ACrzQf3isCpoyXvkD0tCv+QiILSQYVgiPqrdr6DFewh/FZM94G0mik4O
        VkNc+H30EMP9cmRa5CPGjgJLlg==
X-Google-Smtp-Source: AMsMyM4RsIxnEQQgvUP/I7yIWjJa3J7nqUYK5Wno5u2oQWHF/Fo/KzsU5pisEHMnS9Z91zGF3qYjwg==
X-Received: by 2002:a05:600c:6885:b0:3c4:de24:638 with SMTP id fn5-20020a05600c688500b003c4de240638mr45123390wmb.183.1667865421987;
        Mon, 07 Nov 2022 15:57:01 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm8386161wrf.76.2022.11.07.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:57:01 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/18] dt-bindings: msm: dsi-controller-main: Fix description of core clock
Date:   Mon,  7 Nov 2022 23:56:41 +0000
Message-Id: <20221107235654.1769462-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
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

There's a typo in describing the core clock as an 'escape' clock. The
accurate description is 'core'.

Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
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
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index cab38a20a54b0..a607ccd4a905a 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -32,7 +32,7 @@ properties:
       - description: Display byte clock
       - description: Display byte interface clock
       - description: Display pixel clock
-      - description: Display escape clock
+      - description: Display core clock
       - description: Display AHB clock
       - description: Display AXI clock
       - description: Core MultiMedia SubSystem clock
-- 
2.38.1

