Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C47601D14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiJQXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiJQXBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:01:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00828304C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:24 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f8so7675264qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8vCb8LN3NJCbZdNLXXOR3U/nzHlkTwjfzQuOgzIuCE=;
        b=eqmABeEYiUemSby2R6qnE5fERWUP4YF1f7MdYVrZARoiU/7kNF8PYsn4Y4cVqFNzY0
         kzLR0FWSwc2Id5aRNYu71OcPXdiajdilmmSvlTdgEKoUwTNv3wYazL8BO+fSPmaWEdKc
         stiAJKQ9Hm5rZG1saXmlGid2ojzlqsIOuxe2OiCLO94tV+Pm02rO9u7sGPM8Ec/DlO2j
         Z2cDx20W4FJouQdxm2BlHIrrAd4VMNhfEAf7qYLLQmIiSBERaqu6aYwNAaQnlFa3jM04
         hZ3A6mZmXUGluWR3adR4tzeO4gVvNobnR4wTpw7NUyqr/po45Nx+rsJUMNJau5Iz4WRF
         CoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8vCb8LN3NJCbZdNLXXOR3U/nzHlkTwjfzQuOgzIuCE=;
        b=hrn0W5ttalouTr0TghNW8Ns86AsfPtD3xmYprfsPGuEwDuyM/347mV+zy5TZxoS7v/
         NhgGF26waywLWqU5SXrH100qB9q0QD1EoTJLVKYDdBUPcR6oydP11ByYuhrH8FJYvs0U
         VkYZ2GQI6kfD1VcpCkv2ENpRWegD7x+jlNE3Bpf33MSDRdpYOtIKt+sXOdrWRB6ATRUX
         0v5QGHYnviuaXRgyXzeihywfwhvXfS5czMEK7CX3BON9IbIuJxgJqLzFZ1S5HUd8hRS7
         Qpn1CdW0g0lLT8Nk5zMUp//aL1B/b2Vf/q9Rk3sCZCK3+2DbyPXfgFretxGMAjyeEsyk
         32gQ==
X-Gm-Message-State: ACrzQf2oo3hwjP4lkPB01+Rc0XOdijpgb6rBbxKaihxtYx3IAMnnujLk
        rReKqiZQG+SwoOyt0S7O3jvzpA==
X-Google-Smtp-Source: AMsMyM7h7JIvamrz/REur83R/4ZvJ/ks913JvGAUkWvq8aIMPZxu839SoQbwpR01/b/WKjD1bZgZLQ==
X-Received: by 2002:a05:620a:2489:b0:6ee:6244:a225 with SMTP id i9-20020a05620a248900b006ee6244a225mr9474424qkn.112.1666047684192;
        Mon, 17 Oct 2022 16:01:24 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:01:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 25/33] dt-bindings: pinctrl: qcom,sm6375-tlmm: minor style cleanups
Date:   Mon, 17 Oct 2022 19:00:04 -0400
Message-Id: <20221017230012.47878-26-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 4482625b6b1f..d54ebb2bd5a8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SM6375 TLMM block
 maintainers:
   - Konrad Dybcio <konrad.dybcio@somainline.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer (TLMM) block found
-  in the SM6375 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM6375 SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -25,10 +24,10 @@ properties:
 
   interrupts: true
   interrupt-controller: true
-  '#interrupt-cells': true
+  "#interrupt-cells": true
   gpio-controller: true
   gpio-reserved-ranges: true
-  '#gpio-cells': true
+  "#gpio-cells": true
   gpio-ranges: true
   wakeup-parent: true
 
@@ -39,7 +38,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sm6375-tlmm-state"
       - patternProperties:
-- 
2.34.1

