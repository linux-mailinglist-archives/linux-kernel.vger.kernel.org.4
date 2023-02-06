Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A315968C56B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjBFSIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBFSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:08:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918617CF6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:08:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g6so3229577wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HvOrHkIP8SbO+sqt+8GIffUexPmit/k/GSAi9C9ZLA=;
        b=ucFAJXzrJn53Zv+WFCeSBra+jaWVuMvLGrhQesAWslLqtngBNFeqOZ1sclvsw6z/Ql
         Oyn3wD+ev+7fbKgHDrwzRf41Gs+qdvGjUlXbGAvyIriSQ+6LA7FYYOxwmoHeuao9xQ0w
         No8YIRXi5ognFZ/fMQS1dcMRxUmFwI7Wlp6mPVhaPtlDhQSVeC0RPf618Q9ttflv5RAU
         8U0CftKGQrUQ0mqS99VTJFAgOfNCLBRjE7L8Tixn6zIdMeeVPb3KwaYxmiquslHTNQaK
         6I/2SmmJ76BBhJUofjYW4+gXoqBRLq0p0vtpqnD4abCqcy+Ew1zihoJ5FSuI9ubKsDJn
         xB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HvOrHkIP8SbO+sqt+8GIffUexPmit/k/GSAi9C9ZLA=;
        b=IMNwZc/g+ipB7kJej55i9Lz55zEuoCWgpLUHdkA9T3L/bpP0LRUUyjh7xat5XvkSvA
         zefbDtPbvkTqWMRZML/3Fppz3jSNuWMHgF5rMevp8eSfU+hu15NZM49LGgXvwN9F1Wss
         MJZpLKRPRaLtJwtiTmlr+ZR2bVUVfGDUcbAaqXG0Y4omHMJK+eYbqMLsw/ywXtrOlJJC
         wGv+jDTrk1x2PpxJTUcyqJ6VhX0r4QUp0UbHp/07rX38v92VX9Nd1m/hFiuz2MC22OAx
         c7cY+kplYXwTV34ADD0vbKr+yanoJcm3jY01DKkNd3GRqY6P2R0huJhTcmS47so0rFWu
         ZXnw==
X-Gm-Message-State: AO0yUKXyAn6WL3jws2lpjNPeZeESFtDkipJ1DlZOMCvyfSpxZQxjuufi
        qWLgQq0aNkhMNP1wxB2thLFbJA==
X-Google-Smtp-Source: AK7set/0BWk0xFD529JMx3PTnPQ1jw0SboYPgHS35Qq0UkDSwKopgOTCywFPtlZ6jfvnsqgedRLbNg==
X-Received: by 2002:adf:c60b:0:b0:2bd:c1de:a33f with SMTP id n11-20020adfc60b000000b002bdc1dea33fmr18720910wrg.19.1675706891758;
        Mon, 06 Feb 2023 10:08:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c3f1214e33sm365451wrw.100.2023.02.06.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:08:11 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH 3/3] ASoC: dt-bindings: qcom,wcd934x: Allow usage as IFD device
Date:   Mon,  6 Feb 2023 19:08:05 +0100
Message-Id: <20230206180805.6621-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
References: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
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

The WCD9340 audio codec appears on Slimbus twice: as IFD device without
properties and the actual audio-codec referencing the former via
wcd9340_ifd.  Allow in the binding both versions to fix several warnings
like:

  sdm850-samsung-w737.dtb: ifd@0,0: 'reset-gpios' is a required property
  sdm850-samsung-w737.dtb: ifd@0,0: 'slim-ifc-dev' is a required property
  sdm850-samsung-w737.dtb: ifd@0,0: 'interrupt-controller' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

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

