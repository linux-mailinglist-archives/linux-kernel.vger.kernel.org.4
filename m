Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EA5F6931
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiJFOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiJFOH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:07:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896AAE222
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m19so1511712lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qvhx7Yl1ZKU9mdZJ2zEHIWK6jJd4WPtCysK/pIgCqgc=;
        b=TUNPt45jDZ6GPoikBzW6gEDPfWCVSs4UcCWZuph97qZcTufZyNH1C6gI80x0I2/G/q
         BPykP5LJk/7NYKnHrks1yCx0EPI1zvYNU+a5Zk7W9ZfkVgGtUfL+PsZ0UbEOGQPIFkJY
         H9c6MxN6JjEMRkejfgTukOTIJYCZxQj16IPT667woL7rzs9Lcp+sxC3vBkTyP3diAP0h
         uAzI7krX+krBekPD9nPwJoFfWLHmGSYbAu+xVvek3TyZUU3cdYeDrsbj82aLx5NYPPjz
         XYTOba8qKMbsBPs72xUn+u90WWLt5roDunlMER749bTJ6Xvc1z0bkJZX7q3onUPqjRRR
         N7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qvhx7Yl1ZKU9mdZJ2zEHIWK6jJd4WPtCysK/pIgCqgc=;
        b=gQDVdsZUhGzjVxiJWdVidMs8r4bwrGkFcTDmwKom/ymTaQxPk2X9gcbxXTKyUaGp7p
         A7e3wdZ44bamOZqOzsAm/Ws6lJfTFx/TVKVWhKqrmN5ZBzQNXxAiChswgV4zqt3SiHSj
         5bjUqEL1juFBc+0i5x+Bg9TpfOmlfbBtiIwXX4MpeK67dWa7lGA+hhloY7L8FOzCiYny
         wWLxX+EwEx/TO/tQT6b4H9W08R55yXPRs7Cvt316vduNOVbhZlZB5OBJZoSyuBjJYlpR
         VvLmRnDWRX0G9xvoIevptJM5nHtQCdVLIgANqFh21/AkpVk7lNL61XbeoRPJGMbQ+ZOl
         USmA==
X-Gm-Message-State: ACrzQf3joPWDSPMGeigJXVNklPaKPRDgaZlQOu6VpzyvvX/9BYxKjd44
        AFlaozPz6wVtlkhD4tELyTz4KA==
X-Google-Smtp-Source: AMsMyM7SdI5cEn7r5VaRl6cfvR0imm14K3MgNw+BnRH44LmrTMS8q+8SB3A0xhaRMwGHO/Th3V+h1Q==
X-Received: by 2002:ac2:5108:0:b0:4a2:3d2f:7bb9 with SMTP id q8-20020ac25108000000b004a23d2f7bb9mr47097lfb.49.1665065239253;
        Thu, 06 Oct 2022 07:07:19 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:18 -0700 (PDT)
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
Subject: [PATCH 28/34] dt-bindings: pinctrl: qcom,sm8350: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:31 +0200
Message-Id: <20221006140637.246665-29-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml         | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
index cae726b5fc79..2a7be4522aea 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
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

