Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA005F6952
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiJFOKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiJFOIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE40B0B23
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y5so2887750lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wsWSYIfqvuL5/p2Stk9kCmLLF/zpfCAEsYfD/6nr9/I=;
        b=G8ZuObOhaC2qYUDlzIF5mdrZxCNhxEY5WJKCZN2joHQ6LNrZo8N4/LXd6WUOfvCxbg
         zquY6YHIWr+9JMurOOzpFmHLcvVAtok6wRpljAaxWJzdnzrzlcWsmEC21sSP5DK5H2hx
         fpA/bCiauCbOSZuWyFFmm040/ysdssCo+OMoO0PtO9wq0cvy7JViHi0iwoFvl+Sp3f77
         kqUVY4FpnHlWQBGXy1p+oWIWzEdSHMagJfiQROKFwT3wVm8jLHP94cQjS7y+eRHLVphu
         Jo8GDfgdbDJT6ta0dJn6GCUzldwQncaJIsMXIvc3iG1aE2X67A8kgJhQ43TScDNSLFFc
         Duvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wsWSYIfqvuL5/p2Stk9kCmLLF/zpfCAEsYfD/6nr9/I=;
        b=Nv6dapOcv3PHJrwcEXR/+r7Gr9phHqC3Trghi+LDhahnT2z5FIdqSkvK8YFoT4BX9h
         k52WargtdmB27A+/REQoXfE5fL83JucLU05/Cxhk2Z1XPPGeLdf0IFggct0i7R4uWGeR
         Ziqn5AC8rcjG//IDTIvLJY5YorK20YUyfT52whnw1jTlc4vZJ9tLHB6ca1/0NoA/WahZ
         KXJSyeLsJxsckxkMv2/LbpvaDyUEIQF4mxQyPOzyLqeui8uEUSDPKoQnaMFfIrGyY6mW
         nQ7kmLjYS7Q3RD774gGkxgzX6ifGEeB4AadU/IVRF/BwNeerqj8qsuvzMIH/fvI6C1vx
         xj5g==
X-Gm-Message-State: ACrzQf1CNuaKPYqyH6HsET/ltZKv/v22ohLM3lylApcvYRvjWPvv4oZO
        cEmH3ZfkCa6UDl6uJHPgZ+jjGA==
X-Google-Smtp-Source: AMsMyM4DS7X6RRoO0AnTZ8mGIzPZpo///V4PkrqPcYHgY/5H5pCRiOojRxrbcEPyLgmNlHb59wP19A==
X-Received: by 2002:a19:5506:0:b0:4a2:405a:8f06 with SMTP id n6-20020a195506000000b004a2405a8f06mr38474lfe.503.1665065246029;
        Thu, 06 Oct 2022 07:07:26 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:25 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 33/34] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:36 +0200
Message-Id: <20221006140637.246665-34-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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
---
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml      | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
index c81fd74cde1a..01a0a4a40ba5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -4,15 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
-  Low Power Island (LPI) TLMM block
+title: Qualcomm SM8450 SoC LPASS LPI TLMM
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  LPASS LPI IP on most Qualcomm SoCs
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM8450 SoC.
 
 properties:
   compatible:
@@ -35,7 +34,7 @@ properties:
 
   gpio-controller: true
 
-  '#gpio-cells':
+  "#gpio-cells":
     description: Specifying the pin number and flags, as defined in
       include/dt-bindings/gpio/gpio.h
     const: 2
@@ -122,7 +121,7 @@ required:
   - clocks
   - clock-names
   - gpio-controller
-  - '#gpio-cells'
+  - "#gpio-cells"
   - gpio-ranges
 
 additionalProperties: false
-- 
2.34.1

