Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00E05F68D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiJFOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJFOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:06:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51733A7AB3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:06:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p5so2332090ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dpVa1Bd2BX15p5an5Hiu/Ih46PauKXzJMUjfTxIgEw8=;
        b=qaXDbRxgcRv2x+tHLjQG4oYUHBKrYEuGCNAwMaDltQXmGJsbaKSvuhPP+NC9KMiwK6
         Dv/BSg0RxH4Yw4WYZDPyYE/uRlkVVomoeo5nO1UO5P/sNqBUI27ZFPQ3xApQn0AfdTlc
         ah5HWSOE6cyGZz0qBOGiG6QKTYt5T7gUwYTOxh1qNTSR1MLEnbwjKwFm1vKsQ8rvsJHU
         sgxiNkv8wbgSbUp0uv3ARk/adK2uYuwOAwrCIAnRsXSZeCF25a+qdacQhGCB/pYaDNwF
         bm96xTvsYV1dV49cXxLeUaSzCRXgMmJeBUe6lwrNBHQ4q4cRlPUvi+ri4E+dx5vF9Zch
         cxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dpVa1Bd2BX15p5an5Hiu/Ih46PauKXzJMUjfTxIgEw8=;
        b=tKdhPX6dpnvlDqSN4rVAHHsFdGwdoKpiQKxo4R5IyTkdwgVknWneNIeZEm0555T2R0
         3PYbYKGpGJWIw+QY370MmyxoSAXHypwGuyGaf6ZTDhCnqDLNzyzPfZpAa+/Pd6eDWn4K
         dKU0MW9JgMswPAVgM1wSpdWH+5wURdDLY3o6n/wA9HWUmwB3KaIVuO7pKZphziOke20q
         NPRZSnIhxgd2twmZYobJ8u3hNzA3cgeHjGGsaIMI7N+YNF+M3ESAiM5nsLRKEZAMKZ61
         sC+n12DQQfRoc73HxhnDFZJH7bq1xrFeVbGA/vFp3R3zAzjrwSGWTMJIEHtl2LxFk9QE
         TAWg==
X-Gm-Message-State: ACrzQf1vOAVPXC1csKMHvlTsSeT941tS4tVoQm272aMniPbjcJ/5YQL4
        ydp/ppFAbhuSsocqrYB9brFjDA==
X-Google-Smtp-Source: AMsMyM42M5CyNOIlsRnnNx6kT7a/CyNKGt/woh5MHZbZE/OPfotuMpu4EzWGDhL12bRjHysGvJ1ong==
X-Received: by 2002:a05:651c:1508:b0:26c:622e:abe1 with SMTP id e8-20020a05651c150800b0026c622eabe1mr1802870ljf.228.1665065205356;
        Thu, 06 Oct 2022 07:06:45 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:06:44 -0700 (PDT)
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
Subject: [PATCH 02/34] dt-bindings: pinctrl: qcom,sc7280: drop checks used in common TLMM
Date:   Thu,  6 Oct 2022 16:06:05 +0200
Message-Id: <20221006140637.246665-3-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 2a6b5a719d18..bdb896e5682f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -62,6 +62,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -127,16 +128,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: /schemas/pinctrl/pincfg-node.yaml
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-4])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 allOf:
-- 
2.34.1

