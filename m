Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF72A6AFC4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCHB1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCHB12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:27:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB6AA705
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:27:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i28so19571848lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CdS5r2F5pTlugFcZt9Mh0mnJQG+hrKK2aIPit/aNCM=;
        b=sXMUCnkDvfCfMWWHhJKNhZ/0vjqdw1YO4+TyioCmKqFqr8znCBiLM1ldUGvwDqwGYX
         go5rCRfOodJUm9pD1pqrxB6t/TjI079Kh1VOohdcRWbT/G+bdZ8DikAYbk5RMBbNDWkP
         6Jkz5OkBYgGyT992PnrX7is7XgVjCUcZ3AADh/6gSm3BnS1+QFzJw97sv8OMFQE+o3hV
         gLfl+M3Gwc2HKBHuJifVrPsMh5/kDUGLXXfLGvMBaqeCS6JY0NF4Dh7lJZZ4v2BLJY1U
         UfvlgVh94+qRF/IcjjmHN2GH0L1CasjFEx1yMKjV5iG+3fmlLcg5Pzod+kLXVJqv1zbX
         xyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CdS5r2F5pTlugFcZt9Mh0mnJQG+hrKK2aIPit/aNCM=;
        b=MovF6Alnu4I988wYVCqJ9WRy3kUgOoEsQL0PM26ksGnZfyggCrZDO7pvdrfLKWb9p0
         2qJmcQkTvLfIX2TXNwxHAbaiX0W2yZosJJxLKwiBsZuEeh3uJRBzaghdo8Ycl0sQM2Gx
         HReF9WWmoHZPS9wIc2NidirvVZXxTQv70nXIJ9xEcqXvi+uYXFh53B4xPJ1dqJQDKWHq
         J+VroppoX+RhODAKgLGAC0ejlTj1t7Rt4R6FyuhIzPdpTtUdIl+ZEbKR0S1ROo6IVyZ4
         1YKTQzFHK4/VrRaxR6AwQ2rWSJu4ufnmIGeiaNY5C3Qm80YEdXC3nh+acmB6uLChbHvF
         snaw==
X-Gm-Message-State: AO0yUKVeQ1d/vhg1EYBNLbf+dLArFyyjwME9iQlnxEcv2NcG5oqzp3WV
        jQxl8eYQMKdFF3QIRT0183JTyQ==
X-Google-Smtp-Source: AK7set+Yy5tBuuoSoENYBjTcMKzaWJyxwiFD5wyKErIcPE6nHVzU8gGm9MdCAKN/K376CfbXuafvUg==
X-Received: by 2002:ac2:43da:0:b0:4cc:ff7c:4846 with SMTP id u26-20020ac243da000000b004ccff7c4846mr4848734lfl.0.1678238839527;
        Tue, 07 Mar 2023 17:27:19 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 02:26:59 +0100
Subject: [PATCH 2/8] dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data
 per compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-cpufreq_bindings-v1-2-3368473ec52d@linaro.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=3357;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fi5NAJ0nSvGXA5EZ9QEPjUBAW2wHsddKOdoQG8tRb7A=;
 b=ve7DuV6lXEtAmtEIBiET7qz47uKRYbTsE+dazaVhRquLl9J53wCa4LiPYOSsXIGbha4SM92D28r6
 AcCrpCTeDk/Wq0U4oDpaGrZ8eZg7ohRDnZkF9Zm4zaH8Wfs/45WN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce per-SoC compatibles for OSM targets (read: pre-sm8250) and
sanitize the number of interrupt{s,-names} and reg/-names per-compatible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 90 +++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index aebf2254e45a..6f97e2effaca 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -20,6 +20,12 @@ properties:
     oneOf:
       - description: v1 of CPUFREQ HW
         items:
+          - enum:
+              - qcom,sc7180-cpufreq-hw
+              - qcom,sdm845-cpufreq-hw
+              - qcom,sm6115-cpufreq-hw
+              - qcom,sm6350-cpufreq-hw
+              - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
       - description: v2 of CPUFREQ HW (EPSS)
@@ -85,6 +91,88 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qdu1000-cpufreq-epss
+              - qcom,sc7180-cpufreq-hw
+              - qcom,sc8280xp-cpufreq-epss
+              - qcom,sdm845-cpufreq-hw
+              - qcom,sm6115-cpufreq-hw
+              - qcom,sm6350-cpufreq-hw
+              - qcom,sm6375-cpufreq-epss
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        reg-names:
+          minItems: 2
+          maxItems: 2
+
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+        interrupt-names:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-cpufreq-epss
+              - qcom,sm8250-cpufreq-epss
+              - qcom,sm8350-cpufreq-epss
+              - qcom,sm8450-cpufreq-epss
+              - qcom,sm8550-cpufreq-epss
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+
+        reg-names:
+          minItems: 3
+          maxItems: 3
+
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
+        interrupt-names:
+          minItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8150-cpufreq-hw
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+
+        reg-names:
+          minItems: 3
+          maxItems: 3
+
+        # On some SoCs the Prime core shares the LMH irq with Big cores
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+        interrupt-names:
+          minItems: 2
+
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
@@ -235,7 +323,7 @@ examples:
       #size-cells = <1>;
 
       cpufreq@17d43000 {
-        compatible = "qcom,cpufreq-hw";
+        compatible = "qcom,sdm845-cpufreq-hw", "qcom,cpufreq-hw";
         reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
         reg-names = "freq-domain0", "freq-domain1";
 

-- 
2.39.2

