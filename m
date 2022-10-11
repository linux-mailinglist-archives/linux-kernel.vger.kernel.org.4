Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5E5FB9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJKRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJKR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:29:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E0792E0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z30so8921736qkz.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hGWVea2Q1JaZ/Dedm9+8nbJvnK1pk/GRHSmb3bzcTM=;
        b=d/6Dw++TWoCfkEXcDLf4NN9pvhNxy3QrJtju6UEgotMx/R2t1/P4MD/X7jYXOoRMdM
         MrrAs4ig9fma8wecWQLyEKY9GTvQ9ssY+nlY+vRoQPdavJ7iCjauVbTvGqY95ax+Y9JP
         F4zdU/2ZK6xC+3AwyYZZ04iB/WAuWPe02hLGUOLPXF4C2oYDxsyNOmyfV6soxOta1E0i
         9Lkxz+8S/cKTQmdhQ6QSF/H1jIS68FibgjQUsgKh+fP+FTZsynkt9SsJ0sIYjW3JeI2o
         YzAsrXHkHulTau4bDxx0sjKkyYlcBjwLXs0Y1nACjvHyRD9f6EzymBvJR/VPuXwJOzIZ
         t13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hGWVea2Q1JaZ/Dedm9+8nbJvnK1pk/GRHSmb3bzcTM=;
        b=oG2dIMYK7ZV0JN8Dsyr53yHRB1TMlE8BT30nR/tjE/iPMM2P+z9kh2nNX+8/4qZlXa
         8Ry8jNSMMi6m7V/k3/i96Wa5xNPhc3QIZb3he0WxPhJMxOjvfXoabMXfdEyYOB01bVcN
         eWNJdvCMmulacMd+EFgZauZA/2dvu4kkAv/sVyNOUd1lHpfqER6j9nHygFyv5lQ4kx9G
         DbZdB7PuQAta1ApNS3BOvHuhvluNBF0bI3vPTfqETHfzAI6jbeNI2KFkbnDzADR+fqIS
         UzfK8vG25KM0fzBIYiZVquj6PfAdc9xVvlNq5aFpT6hAj2e0/GIu9513ygTUuJtJCAm5
         AVfw==
X-Gm-Message-State: ACrzQf2HBuQiOt4+A6/Evy8Zf+w6X7TovJmghxKXsydreIJB+09vtqqv
        LaR7dWIEZsnNevpJeWgDIBEiTg==
X-Google-Smtp-Source: AMsMyM7oHwbAdAliJB1+Ahghp4xegSiLBbrPQbRr8zG0DnrqpbdAZGtXCNlNw7DUAgmXtAoG7M2nsw==
X-Received: by 2002:a05:620a:2189:b0:6e9:856f:944a with SMTP id g9-20020a05620a218900b006e9856f944amr14314901qka.322.1665509217197;
        Tue, 11 Oct 2022 10:26:57 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:56 -0700 (PDT)
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
Subject: [PATCH v2 33/34] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
Date:   Tue, 11 Oct 2022 13:23:57 -0400
Message-Id: <20221011172358.69043-34-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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

