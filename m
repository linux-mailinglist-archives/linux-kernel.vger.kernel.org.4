Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40A5F691C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiJFOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiJFOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:07:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9472AD989
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j4so2982044lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I81dKSI3MnL+i3Pego3sHpEAFKww1D9m1WRzWhyjyOs=;
        b=oAGvcUwuU3m0URIMxAv2mN8tP1D2pnzwdjM0a1/ffx6vHoWyYT8QqSNxJzZs9gXAn9
         0mA7DYmMzCLtI5/8Lq0gBvsp3k9jUyy1OElRe9J8nMT9SBOxbfRe57h/i+Ugcn+SCLrv
         ioadwjJaI0NpARzDF4xVs5hugplGezagSU34PNc7n0rckP1uB8oXoGR8ItN9OBbWyNwo
         /m8deoO/7XEGhwN1iA2uwOALD4uetbza4mVgs2BGtMIOaccDTsixWk64BRxxte0eNzNc
         +mvd4W3VNHLTf5XdmBzvhSs5FgI3ZFxOvtrSHO1a0tkAN1O9CPSZH4rBAy3eBrWVChqI
         5OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I81dKSI3MnL+i3Pego3sHpEAFKww1D9m1WRzWhyjyOs=;
        b=nZPivNkmWus2FcLE/vpYo24h2ZlG/+gHzPmqbOUlLaNjRLCJpqWyrmAWw+QwB98QNk
         zG1ypl7bvx2+bhWTnfUG3Pm0mSiVsP+N4dc07yl2PqU9P1Az2OeF9GwoMUymnBrrj3eS
         aE+hlPjHU8/sEqQ8uw7kPQcYrPn6Wnr679zi7DDF9BqWh3Oj2F6BpUH3QAGGegCLT0zE
         NDgO9vnmRquSZaOar5aaA5Gz5k6pwlSUuwKepoPbEi50fI9t4Tz0HqlRm4mdk15DdSur
         ZMe1pzWNqP34QVQ7BI6FWLX9uGyazswWmaF1ER35lzhw3R2RBrZrUFwe+VG8pb5PZQxf
         thFg==
X-Gm-Message-State: ACrzQf3Zxjt1QJZaHqZvPt/qexM5dHH5XmFJ6hmi3foYoWd4wzKeAyMq
        8holzspW2mzsHBjRvGcD+okKAw==
X-Google-Smtp-Source: AMsMyM48raNZbxeHVg8/kTzXjPIS1ejnsF5hmHitt4LMYaCgTCk3KNV7QBAV5c+eXjkJUJd9VxU6Hw==
X-Received: by 2002:a05:6512:5ce:b0:4a2:2993:8eea with SMTP id o14-20020a05651205ce00b004a229938eeamr53643lfo.388.1665065230507;
        Thu, 06 Oct 2022 07:07:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:10 -0700 (PDT)
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
Subject: [PATCH 21/34] dt-bindings: pinctrl: qcom,sc8180x: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:24 +0200
Message-Id: <20221006140637.246665-22-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml    | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
index 71ca4cfd567c..071f416f74b2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SC8180X TLMM block
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SC8180X platform.
+description:
+  Top Level Mode Multiplexer pin controller node in Qualcomm SC8180X SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -25,9 +24,9 @@ properties:
 
   reg-names:
     items:
-      - const: "west"
-      - const: "east"
-      - const: "south"
+      - const: west
+      - const: east
+      - const: south
 
   interrupts: true
   interrupt-controller: true
@@ -46,7 +45,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sc8180x-tlmm-state"
       - patternProperties:
@@ -54,7 +53,7 @@ patternProperties:
             $ref: "#/$defs/qcom-sc8180x-tlmm-state"
         additionalProperties: false
 
-'$defs':
+$defs:
   qcom-sc8180x-tlmm-state:
     type: object
     description:
-- 
2.34.1

