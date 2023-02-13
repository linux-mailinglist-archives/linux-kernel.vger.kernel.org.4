Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4B694562
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjBMMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjBMMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:10:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A0C1A947
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lu11so31315531ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLkh67ooWyVObn1J2I1Qu7dXdNbX+Cd0UoL9axKT34o=;
        b=p8WGCP9v5yIWbqJlLQRmMt4chiH79pIdn/7AB+4u36M/TTmmzVK1ZVLXeajFDjlSHT
         cOO6it7vveZEhpkGjAAqnz+csbNPwy1aG25sAbzN4xBu1iIBCSLIb+fADM842f8D4gU1
         vQ4YjvIWiUj59NG7bCE+aUwx3nanN3FFInJXJjsDakUUBBnZAw+6/B6KYznfiPE7vDgR
         x/+Qq/jef9admT0KChEbH1aLvyLMslwfGF3JUJ/gV2UvFeChYwTlEswgOF0tTQtk4ig4
         SmoFfdXxu1QehBVPm4G9hbjnzNCyjRlo/EIr6YaxVp4mWcB6aW2elIkYazjylBN6HoKN
         8Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLkh67ooWyVObn1J2I1Qu7dXdNbX+Cd0UoL9axKT34o=;
        b=kv92onUwi0HIQYjMqfhGvo8ABB8x4XByVbpZb62qZyCrPs5L9O03ehClMAuciXjwvj
         I/EXkxZ1RpObszBQ0C9NDdhvvljCja02noigCirou+LLrqVavLGD/QrMHhWPSWRW3gMr
         p7t8u2dUxOLbxMpNwNYZ3x63kGIctUxXW0Lb8PdpHvPCjpTtGRWmR8gHXkcsA0BG1RJ6
         bIhBboTzKJsSCW6njNcPh5P+JDETy4rx/gtLtiOxAOHPWN8IgWpsdwmtiKRuBuZ++2fm
         VMRgbteF29FmjfpHWhdiaFLuc2aPIx8x0NMaWMTc45nLaPtdNiDCTgSboQ60PA/tmDio
         Oeow==
X-Gm-Message-State: AO0yUKXSHLzAHTHbToXw6k9zLgmdOuIWVMIvMgcwCYoTF3kX+ZLjkdis
        8RxUwWx4xIbVmQxmdn96VqVMAA==
X-Google-Smtp-Source: AK7set81z61FZiKoN0s7dy9ixfbbUA4wWNKA2rBI/8l8V7YwRzxhtMm5RnVtHF6TGfXBlSD4ZM0jEA==
X-Received: by 2002:a17:906:1908:b0:878:5f8e:26c0 with SMTP id a8-20020a170906190800b008785f8e26c0mr17900635eje.7.1676290217679;
        Mon, 13 Feb 2023 04:10:17 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id dt19-20020a170906b79300b0088ed7de4821sm6651586ejb.158.2023.02.13.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:10:17 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: display/msm: dsi-controller-main: Fix deprecated QCM2290 compatible
Date:   Mon, 13 Feb 2023 13:10:04 +0100
Message-Id: <20230213121012.1768296-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
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

The qcom, prefix was missed previously. Fix it.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e75a3efe4dac..2494817c1bd6 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -33,7 +33,7 @@ properties:
           - const: qcom,mdss-dsi-ctrl
       - items:
           - enum:
-              - dsi-ctrl-6g-qcm2290
+              - qcom,dsi-ctrl-6g-qcm2290
           - const: qcom,mdss-dsi-ctrl
         deprecated: true
 
-- 
2.39.1

