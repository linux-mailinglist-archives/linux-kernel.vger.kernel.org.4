Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08475F68FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiJFOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiJFOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:07:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D46A7A8F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:06:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y5so2885687lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=38lnERZth6MHT7ySiPljzdn/2U0VV3LOVoj+ghi5KrM=;
        b=z1qOO9ZRWS7cinIkllvTt8oiqU5+038Epc0GPwZl+ww2F3TtCkHUV8wtS+/Wy1dd6b
         FsTQbJ2v5w7CRwH06BGS+kLesQFZqmonlAj9UCCIM2yqkFKO5i5UqAiIiC8x1xYxQ3J7
         QAhlHY4LmerDFvs8SI9x3+5TjyF8gtkfVAelflkM+zjueL9UXXRyEPWy6efw7ygkNW7a
         jNx7xmhDedZF0N26PSWkVVngGzbDfp0XOGEwXrA7GlpJI//06R7y6TZLTUEFDTIQcvIK
         wRh+fpof1HkIgBpC9Q2bCTZyLfCkpD8EGh2unvTs/XPWRFctp4uem4OcrkRmhMLkedgZ
         VEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=38lnERZth6MHT7ySiPljzdn/2U0VV3LOVoj+ghi5KrM=;
        b=a0plFw4hmxwfay0Vg/uLwu08tcZwTz8QiVkRwtsd2gIRSW4zyFFnW7KyGl0A3/ZD/8
         QMc7opxiU073Bh49W2iXwB0FBIgGBmwMSJlJGNtJBgufx7qjV4yuRms7AVoqmyQ6Wtsr
         ulNvaHG8FBdF95YzDA1KSB13UbDU7U1MF3FTtEMWz+uUvr8xBLf8ieggC3xcp4ColDpl
         N6OExgAN2LQyyFde313a/lHJ95z2z4R7NEP6ytivT9ZB/DmgNWrbkMXJ5Ygz7nJHsMSf
         3X2BP4s3ui5DzFkdmYRBm0YBIjxCaID5CPPpWWQBdRoj9nOMjTUZR4HZPgdrjU4dRGdl
         Lw1A==
X-Gm-Message-State: ACrzQf2aAUGkYJBlNh70hCHcvt4RYk+HGNl7PBSYr+RGlqCeKOoO/MWY
        Cv1VbGK4F1KSFWDC75161VWD1A==
X-Google-Smtp-Source: AMsMyM64C2KS39eDpb4Jp5OxfombHSDD2SrTa8+ccpSDpxUM7eaUiLgaQhkkfclPUQ3hDuSvXFMI0w==
X-Received: by 2002:a05:6512:10c2:b0:4a2:ed6:5020 with SMTP id k2-20020a05651210c200b004a20ed65020mr60981lfg.22.1665065218196;
        Thu, 06 Oct 2022 07:06:58 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:06:57 -0700 (PDT)
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
Subject: [PATCH 12/34] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common TLMM
Date:   Thu,  6 Oct 2022 16:06:15 +0200
Message-Id: <20221006140637.246665-13-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 8320e5ff17b9..4482625b6b1f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -53,6 +53,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -119,16 +120,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-6])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

