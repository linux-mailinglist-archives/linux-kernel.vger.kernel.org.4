Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814955F6689
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiJFMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJFMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:47:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CC9A2AA9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a10so2146367ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KNYjRDFykFY6KGKtDFBELnGyRp5gYvZi8ob4FbY66+8=;
        b=NcKlQiQlMVmrVsmGogb8VBJatjXdqOBovxkSPalMkCIXlGO/FNgYF3GN4vuP+E5624
         5g76DtVH80D6rhQc1bMlQ3e4Jg+mMkpGKj1vraUjAMca+ri22UdWtwj6/Rsq2IfCQ7PK
         gXQt9fIWmcB3ugD4Oqz6Z311RfWHuImIQ5Fpa8Wq6WjHc5zialntBZaN5gCavtxz119T
         toLzQSx+lasrKGnXcExgfnsSv/s4jNKwzRCpN7+ycnvf5oU83xkwtED6LldGMZau0ec6
         NSYYpH1DraoLVIG/u6LdJS/dEAbOZ+5Y28oEiM3kyi+bXszTVq6+P503uICQn1jBFOyv
         1W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KNYjRDFykFY6KGKtDFBELnGyRp5gYvZi8ob4FbY66+8=;
        b=b9W/B/NU9EdNxxB3IT7svtsszxpivkXyDYAHJrNaOmp+TWhLHMJD/1w24e5nw9KeCP
         BSHTb4Z0xbJAFNpnj8nBsDv0+PL2fGR73A42wXmd95zG5diDkb1CiLqPgm/N1LNrM6Mv
         voRxW6OpT+9L55hy/+Q9h3FfmfISm/TZhuUsBe4hs1NYYfCJPheicORGifl0kWRgl8o8
         L2j0un1Sn2YealVUh/XhjkAercvvXtKQJ3dJKKptKGYAwjMzYVoOpVExLrJj6/6e3oXV
         pZ/7bHu444XjWeSR60DzZTaUC4lLG7kCfhGl9m7DIPMPV+pysI8jE3cVih80oGKa3fEY
         Tqmw==
X-Gm-Message-State: ACrzQf0didJnbistPTM9Y8+gIOqrznmeeWov2IBLW6o9v37tZOXd03Zt
        zikgDvrCNmPehngTwqBOMOFJ2A==
X-Google-Smtp-Source: AMsMyM5W/XjCgvQTXo3QeGSmnN+J2j+aV7DL2eW5K13L0Zlrzjy6Q6/USHiz0kB96+EifARuu2eqsw==
X-Received: by 2002:a2e:808a:0:b0:26d:cced:beb1 with SMTP id i10-20020a2e808a000000b0026dccedbeb1mr1786142ljg.299.1665060436719;
        Thu, 06 Oct 2022 05:47:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 13/34] dt-bindings: pinctrl: qcom,ipq6018: fix indentation in example
Date:   Thu,  6 Oct 2022 14:46:38 +0200
Message-Id: <20221006124659.217540-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index e02bc15e0ad5..bf84649593ef 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -120,21 +120,21 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@1000000 {
-              compatible = "qcom,ipq6018-pinctrl";
-              reg = <0x01000000 0x300000>;
-              interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-              interrupt-controller;
-              #interrupt-cells = <2>;
-              gpio-controller;
-              #gpio-cells = <2>;
-              gpio-ranges = <&tlmm 0 0 80>;
-
-              serial3-state {
-                      pins = "gpio44", "gpio45";
-                      function = "blsp2_uart";
-                      drive-strength = <8>;
-                      bias-pull-down;
-              };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq6018-pinctrl";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 80>;
+
+        serial3-state {
+            pins = "gpio44", "gpio45";
+            function = "blsp2_uart";
+            drive-strength = <8>;
+            bias-pull-down;
         };
+    };
-- 
2.34.1

