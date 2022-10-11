Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2375FB99A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJKRaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJKR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:28:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B66C74D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:13 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l19so9378050qvu.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiYopYJx4FFnWBL4nPbArasO7f6m/tH0C3clqIKSJU4=;
        b=z3qv1Cjyt2KYBSuTIO/bCAzHHl7mOkYJCGvR6WJfXLIoO0s84TRSrNO9xdbQCuPMcn
         B4Q8rli7aIcWaYIcSVoZjBFQknMFjDOib78gP+DGg+VPLySXhPXfr4oeJ++5mg4yq8eh
         N/r7ada6LKgjuQb6hWGOxd1IQ/nmkn59gG+xfudpQFWI+SoiK6fZGAmX63rB/yjbKYKv
         /isNS1s4A761cz07oeqzVmgg4lG9vkCDq2TNIgnXGqJ11J4eXPnYgUjhwMWKJWpiOtUF
         qyMbJBcpxBMMlqIv+rdnL6ZqRpF4nihdyuylncXueg69i2dn+8hzsO9S52h6zeVcr1FZ
         +BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiYopYJx4FFnWBL4nPbArasO7f6m/tH0C3clqIKSJU4=;
        b=H2AApklPJ/RJ0kD9zRTMObUYzo/D+oP5wa7w9gDdLIPQvuNFYfMZpaTpRHuxdKTZ55
         M41PtAtJPwOcNtfO0OVT7pIspvTZ90IjpW0XRYnJBQ5+4PK/umDmDJkISauzJQheVgQR
         MosTZihbL5IYyCfW8WsHnf8eqnPdBsjCld9etCb49Z6NLPkaemAeb0tSLe9oMLwm5AMH
         tjSomBq0d/qC2VPS0EOYFvp8w+ALco65FPL67xinM5VZDcZHl4N5iIiIwVWVrysqSyex
         jXjVVLvZktqCKc+0rHnfsgeCOY6N7KNzmoo490QdBbvw6wVPuvZpv3BMOd9+rR9uNN7u
         OkPQ==
X-Gm-Message-State: ACrzQf3VpXayHZhKBGHrXfEZfeb/s7fav2vZcUVCx11MMxhMLh0wmwSZ
        DPGCSoizyORmVmbAFOodXdxLRA==
X-Google-Smtp-Source: AMsMyM5ECs/f72pAmLkKlp5W6Akaa50cXyYFRjtxu4D0LYquw6ENMR59oI6wvHn0vKlH1Mlz9c6bwg==
X-Received: by 2002:a0c:8b0a:0:b0:4b1:9500:4703 with SMTP id q10-20020a0c8b0a000000b004b195004703mr19715290qva.124.1665509209527;
        Tue, 11 Oct 2022 10:26:49 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:49 -0700 (PDT)
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
Subject: [PATCH v2 28/34] dt-bindings: pinctrl: qcom,sm8350-tlmm: minor style cleanups
Date:   Tue, 11 Oct 2022 13:23:52 -0400
Message-Id: <20221011172358.69043-29-krzysztof.kozlowski@linaro.org>
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
pinctrl bindings), use double quotes consistently, drop redundant
quotes and rename file to match compatible (to match coding convention).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...om,sm8350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm8350-pinctrl.yaml => qcom,sm8350-tlmm.yaml} (94%)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
index cae726b5fc79..0b1e4aa5819e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/qcom,sm8350-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8350-tlmm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Technologies, Inc. SM8350 TLMM block
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SM8350 TLMM block
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer (TLMM) block found
-  in the SM8350 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM8350 SoC.
 
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
       - $ref: "#/$defs/qcom-sm8350-tlmm-state"
       - patternProperties:
-- 
2.34.1

