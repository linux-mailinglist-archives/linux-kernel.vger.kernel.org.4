Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA9669E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAMQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAMQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C977EA52
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id cf18so47103972ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bexLBDu2Jcqr900kwtHlEd3vc21Me48gshjDc+jPY5U=;
        b=iGbfa1kPYcyjjbwACbG3VaTIbW+t0C83bDns2PeqtRAE3fKZyPa/WEmxMc79C7n+k0
         LSn7GtKnoYNf36+3K5afjV9HtWsYGjR6SztHSRfDbdDn8o7Jtsm88jzTkgzpLLt/mibF
         XlwJuLig4EvjXMVD6NKEn0QZv/t3QADwTFWKXR5D+iaP5uuiZooEJDe/8aSmLbQQdbg/
         tvs9JayG5UkN4ibEtzCdON79+XZZJFzTAWvYpJkrx95wlIipqCFl2etYsvPfiOZ5WO/I
         ZyMfPDeN4OS5JYIyM4BO7L8zP8T6WGZZWy0WiWHLPvKxkkyvycgHI+qvxOHZ/z9EvWH5
         GIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bexLBDu2Jcqr900kwtHlEd3vc21Me48gshjDc+jPY5U=;
        b=nec5Aw+JuGk78IE1DE78gsSIVBuv19ICLo2NyzNWbLlvVanM0ZZSPa0kW7F+2MlLyN
         v+zzjtyt/yhG4Jcjzca2dWc+OrflyMmjSrB765hfOm+qGemh4cESxRLVLc3gktTjN7TY
         yPp3i5gqud7rCq8MWcilOyzVrpqEr8SuttMGFXEJ/dE7dkXoMa+03aMdm9yd3R9RGkAh
         +oYuhHiLSUnc23v9BZs9OBw7BQD62lU1iV6bAM5RQnoija7subjUTfx9V/LpLnHOCXDA
         uZeXRDqcB+DOUw9FvuRz0dhHDsv2ltZ9w2nxRkxSsKPq7fVMg81uo/DVKZBnRTVs08DS
         pM8Q==
X-Gm-Message-State: AFqh2kr9zfUuttavO/k0KTE2m06fDtWgmX7FESzNOMHN3BPf43OOCed3
        SgYoliJRKRFpWlD5AeOwwJqLfA==
X-Google-Smtp-Source: AMrXdXteXj2KfLx4/wMmN2219OBKDVEo2r86wx6/WgM1C2Dv8h723tnkzSLIYUoGCqzY6op/E1Rujg==
X-Received: by 2002:a17:907:a609:b0:7c1:22a6:818f with SMTP id vt9-20020a170907a60900b007c122a6818fmr4233958ejc.25.1673626942675;
        Fri, 13 Jan 2023 08:22:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0084d242d07ffsm8376737ejm.8.2023.01.13.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:22:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: dt-bindings: qcom,wcd934x: Allow usage as IFD device
Date:   Fri, 13 Jan 2023 17:22:14 +0100
Message-Id: <20230113162214.117261-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
References: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
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

The WCD9340 audio codec appears on Slimbus twice: as IFD device without
properties and the actual audio-codec referencing the former via
wcd9340_ifd.  Allow in the binding both versions to fix several warnings
like:

  sdm850-samsung-w737.dtb: ifd@0,0: 'reset-gpios' is a required property
  sdm850-samsung-w737.dtb: ifd@0,0: 'slim-ifc-dev' is a required property
  sdm850-samsung-w737.dtb: ifd@0,0: 'interrupt-controller' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

oneOf: interrupts-extended|interrupts is needed to avoid dtschema
limitation.
---
 .../bindings/sound/qcom,wcd934x.yaml          | 58 ++++++++++++++-----
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index 39b27126cfc1..ea09590bfa30 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -149,21 +149,49 @@ patternProperties:
 required:
   - compatible
   - reg
-  - reset-gpios
-  - slim-ifc-dev
-  - interrupts
-  - interrupt-controller
-  - clock-frequency
-  - clock-output-names
-  - qcom,micbias1-microvolt
-  - qcom,micbias2-microvolt
-  - qcom,micbias3-microvolt
-  - qcom,micbias4-microvolt
-  - "#interrupt-cells"
-  - "#clock-cells"
-  - "#sound-dai-cells"
-  - "#address-cells"
-  - "#size-cells"
+
+allOf:
+  - if:
+      required:
+        - slim-ifc-dev
+    then:
+      required:
+        - reset-gpios
+        - slim-ifc-dev
+        - interrupt-controller
+        - clock-frequency
+        - clock-output-names
+        - qcom,micbias1-microvolt
+        - qcom,micbias2-microvolt
+        - qcom,micbias3-microvolt
+        - qcom,micbias4-microvolt
+        - "#interrupt-cells"
+        - "#clock-cells"
+        - "#sound-dai-cells"
+        - "#address-cells"
+        - "#size-cells"
+      oneOf:
+        - required:
+            - interrupts-extended
+        - required:
+            - interrupts
+    else:
+      properties:
+        reset-gpios: false
+        slim-ifc-dev: false
+        interrupts: false
+        interrupt-controller: false
+        clock-frequency: false
+        clock-output-names: false
+        qcom,micbias1-microvolt: false
+        qcom,micbias2-microvolt: false
+        qcom,micbias3-microvolt: false
+        qcom,micbias4-microvolt: false
+        "#interrupt-cells": false
+        "#clock-cells": false
+        "#sound-dai-cells": false
+        "#address-cells": false
+        "#size-cells": false
 
 additionalProperties: false
 
-- 
2.34.1

