Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210E7629807
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiKOMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiKOMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:03:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D5286DF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a29so24068350lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbaZwU77Z1ouLs3jgvngmnLtPy0YsEJlCLwAlXk9eGs=;
        b=QUhL0yGdrd3iB3ZcnCkgmArwlxWX3jxB+ogF+ySPNM30t+Ha+J2/kDkmZPQd3NbUrx
         GpwO6nNuqUtLMSMRU5o454qjK48oApnmyf6g4FehFFkD8jDp3FQFdbSFmvC0uh/c/gFs
         La8LSft5u7B1SDGy6EGkgxSkOyQ9THCNthTrWKve7XDdrNmw/kAEUMmaT4b/KgUi+EQf
         UmCRXvfLDPByytE+RoEyeKTLbMiAI6DzPUznO0W+V4SZJ3peP0bUcPNIVsE4XwdTVxE4
         pH+xl9zJFRjBpFWtiXujEfJ056dfD/2zdDpo7SVsaTPx5omi9Ra2nrS1sockA5mFZmYv
         4/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbaZwU77Z1ouLs3jgvngmnLtPy0YsEJlCLwAlXk9eGs=;
        b=mNBSBi619DQO/i0I3Vyrv1/RtdK5Pegue4dclQdZZgkmV+Ga0cyXZppFX+QbcySQ4v
         zlASttpzgsr1pu+kaeDG8JVLUxElDVB/h2M/EV1O4OCbk6XsBxZ0jd0glgld6mwKyuSb
         0Ilws1qqobbeWfwpuNs3zRrZ7xd7UlP0Xjtt2fd5H/SqHVVzB0iL8e8OXETngLrE8SrG
         7n+zButqUYB/TmeVr/bNDHlJFjHkXXKdHUwZ+lLLzUUhYQp07sDWaJ2WgT4/bVhzvE0A
         No+R6T8/w+vAxUn4wVQING5biuvb2TrtguZp9CcV1w2bIuAgtTP0HwSPUKeNhVzabbfo
         j2IA==
X-Gm-Message-State: ANoB5pmE9Z7k1pCBdV5QymHAgpCEXrvu800FK8UB6VYo9fc1dsoAyzOP
        On+MEqNhR01cZRPGT0+Uo6p45Q==
X-Google-Smtp-Source: AA0mqf7uYCrKdueUJqv0hPgUAc0aNVnzCOqAYP6HvvPf1xojk47c84bx1TNe+IkwF3HCvbMUByc5CA==
X-Received: by 2002:ac2:55a7:0:b0:4a2:5154:ead9 with SMTP id y7-20020ac255a7000000b004a25154ead9mr5737175lfg.32.1668513775386;
        Tue, 15 Nov 2022 04:02:55 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2176233lfb.121.2022.11.15.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:02:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        quic_srivasam@quicinc.com, quic_plai@quicinc.com
Subject: [PATCH v2 08/11] ASoC: dt-bindings: qcom,q6prm: Split to separate schema
Date:   Tue, 15 Nov 2022 13:02:32 +0100
Message-Id: <20221115120235.167812-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6PRM
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: quic_srivasam@quicinc.com
Cc: quic_plai@quicinc.com
---
 .../devicetree/bindings/sound/qcom,q6prm.yaml | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
new file mode 100644
index 000000000000..f6dbb1267bfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6prm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Proxy Resource Manager (Q6PRM)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+allOf:
+  - $ref: /schemas/soc/qcom/qcom,apr-services.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6prm
+
+  clock-controller:
+    $ref: /schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
+    unevaluatedProperties: false
+    description: Qualcomm DSP LPASS clock controller
+
+required:
+  - compatible
+  - clock-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@2 {
+            reg = <GPR_PRM_MODULE_IID>;
+            compatible = "qcom,q6prm";
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            clock-controller {
+                compatible = "qcom,q6prm-lpass-clocks";
+                #clock-cells = <2>;
+            };
+        };
+    };
-- 
2.34.1

